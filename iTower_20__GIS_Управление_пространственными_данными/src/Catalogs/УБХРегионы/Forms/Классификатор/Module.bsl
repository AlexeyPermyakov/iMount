#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Служебные реквизиты
	ПоляКлассификатора = "Код, Наименование";
	
	Параметры.Свойство("РежимВыбора", РежимВыбора);
	ЗакрыватьПриВыборе = РежимВыбора;
	
	МакетРегионы = Справочники.Регионы.ПолучитьМакет("Регионы");
	
	Для Индекс = 1 По МакетРегионы.ВысотаТаблицы Цикл
		ТекущийКодРегиона = СокрЛП(МакетРегионы.Область(Индекс, 2, Индекс, 2).Текст);
		Название = СокрЛП(МакетРегионы.Область(Индекс, 1, Индекс, 1).Текст);
		
		НоваяСтрока = Классификатор.Добавить();
		НоваяСтрока.Код = ТекущийКодРегиона;
		НоваяСТрока.Наименование = Название; 
			
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыКлассификатор

&НаКлиенте
Процедура КлассификаторВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Если ВыбраннаяСтрока = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(ВыбраннаяСтрока) = Тип("Массив") Тогда
		ИдентификаторСтрокиВыбора = ВыбраннаяСтрока[0];
	Иначе
		ИдентификаторСтрокиВыбора = ВыбраннаяСтрока;
	КонецЕсли;
	
	ОповеститьОВыбореЭлементаКлассификатора(ИдентификаторСтрокиВыбора);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОповеститьОВыбореЭлементаКлассификатора(ИдентификаторСтрокиВыбора)
	ВсеДанныеСтроки = Классификатор.НайтиПоИдентификатору(ИдентификаторСтрокиВыбора);
	Если ВсеДанныеСтроки <> Неопределено Тогда
		ДанныеСтроки = Новый Структура(ПоляКлассификатора);
		ЗаполнитьЗначенияСвойств(ДанныеСтроки, ВсеДанныеСтроки);
		
		ДанныеВыбора = ДанныеВыбораЭлементаКлассификатора(ДанныеСтроки);
		Если ДанныеВыбора.ЭтоНовый Тогда
			ОповеститьОСозданииЭлементов(ДанныеВыбора.Ссылка);
		КонецЕсли;
		
		ОповеститьОВыборе(ДанныеВыбора.Ссылка);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОповеститьОСозданииЭлементов(Ссылка)
	ОповеститьОЗаписиНового(Ссылка);
	Оповестить("Справочник.УБХРегионы.Изменение", Ссылка, ЭтотОбъект);
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДанныеВыбораЭлементаКлассификатора(Знач ДанныеСтраны)
	// Ищем только по коду, так как в классификаторе все коды заданы.
	Ссылка = Справочники.УБХРегионы.НайтиПоКоду(ДанныеСтраны.Код);
	ЭтоНовый = Не ЗначениеЗаполнено(Ссылка);
	Если ЭтоНовый Тогда
		Регион = Справочники.УБХРегионы.СоздатьЭлемент();
		ЗаполнитьЗначенияСвойств(Регион, ДанныеСтраны);
		Регион.Записать();
		Ссылка = Регион.Ссылка;
	КонецЕсли;
	
	Возврат Новый Структура("Ссылка, ЭтоНовый, Код", Ссылка, ЭтоНовый, ДанныеСтраны.Код);
КонецФункции

#КонецОбласти