
// Процедура переподчинения и реструктуризации периодов.
//
Процедура РеструктурироватьПериоды(Родитель=Неопределено) Экспорт
	
	Запрос=Новый Запрос;
	Запрос.Текст=
	"ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.День) КАК Период,
	|	1 КАК Ранг
	|ПОМЕСТИТЬ РангиПериодов
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.Неделя),
	|	7
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.Декада),
	|	10
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.Месяц),
	|	30
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.Квартал),
	|	90
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.Полугодие),
	|	180
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.ДевятьМесяцев),
	|	270
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ЗНАЧЕНИЕ(Перечисление.Периодичность.Год),
	|	360
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Периоды.Ссылка КАК Ссылка,
	|	Периоды.ДатаНачала КАК ДатаНачала,
	|	Периоды.ДатаОкончания КАК ДатаОкончания,
	|	Периоды.Периодичность КАК Периодичность,
	|	РангиПериодов.Ранг КАК Ранг,
	|	РангиРодителей.Ранг КАК РангРодителя
	|ПОМЕСТИТЬ ОтобранныеПериоды
	|ИЗ
	|	Справочник.Периоды КАК Периоды
	|		ЛЕВОЕ СОЕДИНЕНИЕ РангиПериодов КАК РангиПериодов
	|		ПО (РангиПериодов.Период = Периоды.Периодичность)
	|		ЛЕВОЕ СОЕДИНЕНИЕ РангиПериодов КАК РангиРодителей
	|		ПО (РангиРодителей.Период = Периоды.Родитель.Периодичность)
	|"+?(НЕ Родитель=Неопределено,"	И Периоды.Родитель В ИЕРАРХИИ(&Родитель)","")+"
	|ГДЕ
	|	НЕ Периоды.Произвольный
	|	И НЕ Периоды.ПометкаУдаления
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ОтобранныеПериоды.Ссылка КАК Период,
	|	ОтобранныеПериоды.Ссылка.Родитель КАК ТекущийРодитель,
	|	ПериодыВладельцы.Ссылка КАК ВозможныйРодитель,
	|	ПериодыВладельцы.Ранг КАК Ранг
	|ИЗ
	|	ОтобранныеПериоды КАК ОтобранныеПериоды
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ОтобранныеПериоды КАК ПериодыВладельцы
	|		ПО (НЕ ПериодыВладельцы.Периодичность = ЗНАЧЕНИЕ(Перечисление.Периодичность.ДевятьМесяцев))
	|			И ОтобранныеПериоды.ДатаОкончания <= ПериодыВладельцы.ДатаОкончания
	|			И ОтобранныеПериоды.Периодичность <> ПериодыВладельцы.Периодичность
	|			И ОтобранныеПериоды.ДатаНачала >= ПериодыВладельцы.ДатаНачала
	|			И ОтобранныеПериоды.ДатаОкончания <= ПериодыВладельцы.ДатаОкончания
	|			И ОтобранныеПериоды.Ранг < ПериодыВладельцы.Ранг
	|
	|УПОРЯДОЧИТЬ ПО
	|	Период,
	|	Ранг
	|ИТОГИ ПО
	|	Период";	
	Запрос.УстановитьПараметр("Родитель",Родитель);
	
	Результат = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	
	Пока Результат.Следующий() Цикл
		
		ВозможныеРодителиПериода = Результат.Выбрать(ОбходРезультатаЗапроса.Прямой);
		Если ВозможныеРодителиПериода.Следующий() Тогда
			
			ПериодОбъект = ВозможныеРодителиПериода.Период.ПолучитьОбъект();
			ПериодОбъект.Родитель = ВозможныеРодителиПериода.ВозможныйРодитель;
			ПериодОбъект.ОбменДанными.Загрузка = Истина;
			ПериодОбъект.Записать();
				
		КонецЕсли;
		
	КонецЦикла;	
	
КонецПроцедуры

// Функция выполняет создание дочерних периодов по родителю
// 
Функция СоздатьПериоды(Родитель, ЗаполняемыеПериоды,МассивПодчиненныхПериодов = Неопределено) Экспорт
	
	Если ЗаполняемыеПериоды.Количество() = 0 Тогда
		Возврат Истина;
	КонецЕсли;
	
	Запрос=Новый Запрос;
	Запрос.Текст="ВЫБРАТЬ
	             |	Периоды.Ссылка,
	             |	Периоды.ДатаНачала,
	             |	Периоды.Периодичность
	             |ИЗ
	             |	Справочник.Периоды КАК Периоды
	             |ГДЕ
	             |	Периоды.Родитель В ИЕРАРХИИ(&Родитель)
	             |	И Периоды.Периодичность В(&Периодичность)";
				 
	Запрос.УстановитьПараметр("Родитель",Родитель);
	Запрос.УстановитьПараметр("Периодичность",ЗаполняемыеПериоды);
	
	Результат=Запрос.Выполнить().Выгрузить();
	
	Для Каждого Периодичность ИЗ ЗаполняемыеПериоды Цикл
		
		ДатаНачала = Родитель.ДатаНачала;
		
		Пока ДатаНачала <= Родитель.ДатаОкончания Цикл
			
			СтруктураПоиска=Новый Структура;
			СтруктураПоиска.Вставить("ДатаНачала",ДатаНачала);
			СтруктураПоиска.Вставить("Периодичность",Периодичность);
			
			МассивСуществующих=Результат.НайтиСтроки(СтруктураПоиска);
			
			Если МассивСуществующих.Количество()=0 Тогда
				
				Объект = Справочники.Периоды.СоздатьЭлемент();
				Объект.Родитель   = Родитель;
				Объект.ДатаНачала = ДатаНачала;
				Объект.Периодичность = Периодичность;
				Объект.Заполнить(Неопределено);
				
				Попытка
					Объект.Записать();
				Исключение
					ОбщегоНазначенияСлужебныйКлиентСервер.СообщитьПользователю(ОписаниеОшибки());
					Возврат Ложь;
				КонецПопытки;
				
				Ссылка = Объект.Ссылка;
				
			Иначе
				
				Ссылка=МассивСуществующих[0].Ссылка;
				
			КонецЕсли; 
			
			Если НЕ МассивПодчиненныхПериодов = Неопределено Тогда
				 МассивПодчиненныхПериодов.Добавить(Ссылка);
			КонецЕсли;	
			
			
			Если Периодичность=Перечисления.Периодичность.ДевятьМесяцев Тогда
				Прервать;
			Иначе
				ДатаНачала = НачалоДня(УБХОбщегоНазначения.ДобавитьДень(Ссылка.ДатаОкончания, 1));
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЦикла;
	
	РеструктурироватьПериоды(Родитель);
	
	Возврат Истина;
	
КонецФункции

Функция ОпределитьДатуОкончания(ДатаНачала, ДатаОкончания, Периодичность, УстановитьДату = Истина) Экспорт
	
	Если Периодичность = Перечисления.Периодичность.Год Тогда
		ДатаКонцаПериода = НачалоДня(ДобавитьМесяц(ДатаНачала, 12) - 1);
	ИначеЕсли Периодичность =Перечисления.Периодичность.ДевятьМесяцев Тогда
		ДатаКонцаПериода = НачалоДня(ДобавитьМесяц(ДатаНачала, 9) - 1);
	ИначеЕсли Периодичность = Перечисления.Периодичность.Полугодие Тогда
		ДатаКонцаПериода = НачалоДня(ДобавитьМесяц(ДатаНачала, 6) - 1);
	ИначеЕсли Периодичность = Перечисления.Периодичность.Квартал Тогда
		ДатаКонцаПериода = НачалоДня(ДобавитьМесяц(ДатаНачала, 3) - 1);
	ИначеЕсли Периодичность = Перечисления.Периодичность.Месяц Тогда
		ДатаКонцаПериода = НачалоДня(ДобавитьМесяц(ДатаНачала, 1) - 1);
	ИначеЕсли Периодичность = Перечисления.Периодичность.Декада Тогда
		
		Если День(ДатаНачала) < 10 Тогда
			ДатаКонцаПериода = УБХОбщегоНазначения.ДобавитьДень(ДатаНачала, 10) - 1;
		ИначеЕсли День(ДатаНачала) < 20 Тогда
			ДатаКонцаПериода = УБХОбщегоНазначения.ДобавитьДень(ДатаНачала, 10) - 1;
		Иначе 
			ДатаКонцаПериода = КонецМесяца(ДатаНачала);
		КонецЕсли;
	ИначеЕсли Периодичность = Перечисления.Периодичность.Неделя Тогда
		
		Если День(ДатаНачала)<=День(КонецНедели(ДатаНачала)) Тогда
			ДатаКонцаПериода = КонецНедели(ДатаНачала);
		Иначе
			ДатаКонцаПериода = КонецМесяца(ДатаНачала);
		КонецЕсли;
		
	Иначе	
		ДатаКонцаПериода = ДатаНачала;
	КонецЕсли;
    
    Если УстановитьДату Тогда
 		УБХОбщегоНазначения.УстановитьНовоеЗначение(ДатаОкончания, ДатаКонцаПериода);
    КонецЕсли; 
    
    Возврат ДатаКонцаПериода;
    
КонецФункции

Функция ПолучитьПроизвольныйПериод(ДатаНачала, ДатаОкончания, ТихийРежим = Ложь) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ ПЕРВЫЕ 1
	|	Периоды.Ссылка
	|ИЗ
	|	Справочник.Периоды КАК Периоды
	|ГДЕ
	|	Периоды.ДатаНачала = &ДатаНачала
	|	И Периоды.ДатаОкончания = &ДатаОкончания";
	
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	
	РезультатЗапроса = Запрос.Выполнить();
	Если РезультатЗапроса.Пустой() Тогда
		
		Если Не ТихийРежим Тогда
			
			ШаблонОшибки = "Невозможно определить период (с <%1> по <%2>): не существует искомый период в справочнике ""Периоды""! ";
			ТекстОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонОшибки, ДатаНачала, ДатаОкончания);
			ОбщегоНазначенияСлужебныйКлиентСервер.СообщитьПользователю(ТекстОшибки);	
			
		КонецЕсли;
		
		Возврат Неопределено; 
	Иначе	
		Возврат РезультатЗапроса.Выгрузить()[0].Ссылка;
	КонецЕсли;	

КонецФункции
