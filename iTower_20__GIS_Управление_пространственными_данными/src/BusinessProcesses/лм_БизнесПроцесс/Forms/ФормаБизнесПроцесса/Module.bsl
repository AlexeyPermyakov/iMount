
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
			
	Элементы.ГруппаРодитель.Видимость = ЗначениеЗаполнено(Объект.Родитель);
	Элементы.НадписьРодительОжидаетЗавершения.Видимость = Объект.РодительОжидаетЗавершения И НЕ Объект.Завершен;
		
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// НачалоЗамераПроизводительности
НачалоЗамера = ОценкаПроизводительности.НачатьЗамерВремени();
// Конец НачалоЗамераПроизводительности
	
	ОбновитьКартуМаршрута();
	
	// ЗавершениеЗамераПроизводительности
ОценкаПроизводительности.ЗакончитьЗамерВремени("Бизнес-процесс.ОткрытиеФормыПроцесса", НачалоЗамера);
// Конец ЗавершениеЗамераПроизводительности	
		
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьКартуМаршрута()
	
	ЗаписьКарты = РегистрыСведений.лм_ВерсииКартыМаршрута.СоздатьМенеджерЗаписи();
	ЗаписьКарты.Шаблон = Объект.Шаблон;
	ЗаписьКарты.НомерВерсии = Объект.НомерВерсии;
	ЗаписьКарты.Прочитать();
	КартаМаршрута = ЗаписьКарты.КартаМаршрута.Получить();
	ЭлементыКарты = КартаМаршрута.ЭлементыГрафическойСхемы;
	
	ЦветФона = Новый Цвет(255, 255, 255);
	ЦветЛинии = Новый Цвет(0, 0, 0);
	Линия = Новый Линия(ТипСоединительнойЛинии.Сплошная, 2);
	ЛинияАктивной = Новый Линия(ТипСоединительнойЛинии.Пунктир, 2);
		
	Запрос = Новый Запрос();
	Запрос.Текст = "ВЫБРАТЬ
	               |	лм_ВыполнениеБизнесПроцессов.ИдентификаторТочки КАК ИдентификаторТочки,
	               |	лм_ТочкиБизнесПроцессов.ИмяТочки КАК ИмяТочки,
	               |	лм_СценарииБизнесПроцессов.НаименованиеВыхода КАК НаименованиеВыхода,
	               |	лм_СценарииБизнесПроцессов.НаименованиеВарианта КАК НаименованиеВарианта,
	               |	лм_СценарииБизнесПроцессов.УсловиеВыполнено КАК УсловиеВыполнено,
	               |	лм_ВыполнениеБизнесПроцессов.ИдентификаторТочкиВхода КАК ИдентификаторТочкиВхода,
	               |	лм_ТочкиВхода.ИмяТочки КАК ИмяТочкиВхода,
	               |	лм_ВыполнениеБизнесПроцессов.Активная КАК Активная,
	               |	лм_ВыполнениеБизнесПроцессов.Итерация КАК Итерация
	               |ИЗ
	               |	РегистрСведений.лм_ВыполнениеБизнесПроцессов КАК лм_ВыполнениеБизнесПроцессов
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.лм_ТочкиБизнесПроцессов КАК лм_ТочкиБизнесПроцессов
	               |		ПО лм_ВыполнениеБизнесПроцессов.ИдентификаторТочки = лм_ТочкиБизнесПроцессов.ИдентификаторТочки
	               |			И (лм_ТочкиБизнесПроцессов.НомерВерсии = &НомерВерсии)
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.лм_ТочкиБизнесПроцессов КАК лм_ТочкиВхода
	               |		ПО лм_ВыполнениеБизнесПроцессов.ИдентификаторТочкиВхода = лм_ТочкиВхода.ИдентификаторТочки
	               |			И (лм_ТочкиВхода.НомерВерсии = &НомерВерсии)
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.лм_СценарииБизнесПроцессов КАК лм_СценарииБизнесПроцессов
	               |		ПО лм_ВыполнениеБизнесПроцессов.ИдентификаторТочки = лм_СценарииБизнесПроцессов.КонечнаяТочка
	               |			И лм_ВыполнениеБизнесПроцессов.ИдентификаторТочкиВхода = лм_СценарииБизнесПроцессов.ИсходнаяТочка
	               |			И (лм_СценарииБизнесПроцессов.НомерВерсии = &НомерВерсии)
	               |ГДЕ
	               |	лм_ВыполнениеБизнесПроцессов.БизнесПроцесс = &БизнесПроцесс
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Активная";
	Запрос.УстановитьПараметр("БизнесПроцесс", Объект.Ссылка);
	Запрос.УстановитьПараметр("НомерВерсии", Объект.НомерВерсии);
	РезультатЗапроса = Запрос.Выполнить();
	Выборка = РезультатЗапроса.Выбрать();
	ВыполненныеПереходы = Новый ТаблицаЗначений();
	ВыполненныеПереходы.Колонки.Добавить("ИмяТочки", Новый ОписаниеТипов("Строка"));
	ВыполненныеПереходы.Колонки.Добавить("ИмяТочкиВхода", Новый ОписаниеТипов("Строка"));
	ВыполненныеПереходы.Колонки.Добавить("НаименованиеВыхода", Новый ОписаниеТипов("Строка"));
	ВыполненныеПереходы.Колонки.Добавить("НаименованиеВарианта", Новый ОписаниеТипов("Строка"));
	
	Пока Выборка.Следующий() Цикл
		ИмяТочки = Выборка.ИмяТочки;
		СтрокаПерехода = ВыполненныеПереходы.Добавить();
		СтрокаПерехода.ИмяТочки = ИмяТочки;
		СтрокаПерехода.ИмяТочкиВхода = Выборка.ИмяТочкиВхода;
		СтрокаПерехода.НаименованиеВыхода = Выборка.НаименованиеВыхода;
		СтрокаПерехода.НаименованиеВарианта = Выборка.НаименованиеВарианта;
		
		Если НЕ ПустаяСтрока(ИмяТочки) Тогда			
			ЭлементТочки = ЭлементыКарты.Найти(ИмяТочки);
			Если ЭлементТочки <> Неопределено Тогда
				ЭлементТочки.ЦветФона = ЦветФона; 
				ЭлементТочки.ЦветРамки = ЦветЛинии;
				Если Выборка.Активная Тогда
					ЭлементТочки.Рамка = ЛинияАктивной;
				Иначе
					ЭлементТочки.Рамка = Линия;
					Если ТипЗнч(ЭлементТочки) = Тип("ЭлементГрафическойСхемыДействие") Тогда
						ЭлементТочки.Картинка = БиблиотекаКартинок.Успешно;
					ИначеЕсли ТипЗнч(ЭлементТочки) = Тип("ЭлементГрафическойСхемыВыборВарианта") Тогда
						Для Каждого ЭлементВарианта Из ЭлементТочки.Элементы Цикл
							ЭлементВарианта.ЦветФона = ЦветФона;
						КонецЦикла;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого ЭлементСвязи Из ЭлементыКарты Цикл
		Если (ТипЗнч(ЭлементСвязи) = Тип("ЭлементГрафическойСхемыСоединительнаяЛиния")
				ИЛИ ТипЗнч(ЭлементСвязи) = Тип("ЭлементГрафическойСхемыДекоративнаяЛиния")) Тогда				
			ДанныеПерехода = Новый Структура();
			ДанныеПерехода.Вставить("ИмяТочки", ЭлементСвязи.КонецЭлемент.Имя);
			ДанныеПерехода.Вставить("ИмяТочкиВхода", ЭлементСвязи.НачалоЭлемент.Имя);
			Если ТипЗнч(ЭлементСвязи.НачалоЭлемент) = Тип("ЭлементГрафическойСхемыВыборВарианта") Тогда			
				ДанныеПерехода.Вставить("НаименованиеВарианта", ЭлементСвязи.НачалоВариант.Наименование);
			ИначеЕсли ТипЗнч(ЭлементСвязи.НачалоЭлемент) = Тип("ЭлементГрафическойСхемыДействие") Тогда
				ДанныеПерехода.Вставить("НаименованиеВыхода", ЭлементСвязи.Наименование);
			КонецЕсли;
			НайденныеСтроки = ВыполненныеПереходы.НайтиСтроки(ДанныеПерехода);
			Если НайденныеСтроки.Количество() > 0 Тогда 
				ЭлементСвязи.Линия = Линия;
				ЭлементСвязи.ЦветЛинии = ЦветЛинии;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти