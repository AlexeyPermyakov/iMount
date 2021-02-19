#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Фильтр = Неопределено;
	Если Параметры.Свойство("Фильтр", Фильтр) Тогда
		Если ТипЗнч(Фильтр) = Тип("Структура") Тогда
			ЗаполнитьЗначенияСвойств(ЭтотОбъект, Фильтр);
		КонецЕсли;
	КонецЕсли;
	
	СправочникОУЗаполнитьСписокВыбораНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ГеоОбъектВидСравненияПриИзменении(Элементы.ГеоОбъектВидСравнения);
	ОбъектУчетаВидСравненияПриИзменении(Элементы.ОбъектУчетаВидСравнения);
КонецПроцедуры

&НаСервере
Процедура ПриСохраненииДанныхВНастройкахНаСервере(Настройки)
	Настройки.Вставить("ТипГеометрии", ТипГеометрии);
	Настройки.Вставить("Слой", Слой);
	Настройки.Вставить("ГеоОбъектВидСравнения", ГеоОбъектВидСравнения);
	Настройки.Вставить("ГеоОбъектРавно", ГеоОбъектРавно);
	Настройки.Вставить("ГеоОбъектВСписке", ГеоОбъектВСписке);
	Настройки.Вставить("ГеоОбъектНаименование", ГеоОбъектНаименование);
	Настройки.Вставить("ГеоОбъект", ГеоОбъект);
	Настройки.Вставить("СправочникОУ", СправочникОУ);
	Настройки.Вставить("ОбъектУчетаВидСравнения", ОбъектУчетаВидСравнения);
	Настройки.Вставить("ОбъектУчетаРавно", ОбъектУчетаРавно);
	Настройки.Вставить("ОбъектУчетаВСписке", ОбъектУчетаВСписке);
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	ТипГеометрии = Настройки.Получить("ТипГеометрии");
	Слой = Настройки.Получить("Слой");
	ГеоОбъектВидСравнения = Настройки.Получить("ГеоОбъектВидСравнения");
	ГеоОбъектРавно = Настройки.Получить("ГеоОбъектРавно");
	ГеоОбъектВСписке = Настройки.Получить("ГеоОбъектВСписке");
	ГеоОбъектНаименование = Настройки.Получить("ГеоОбъектНаименование");
	ГеоОбъект = Настройки.Получить("ГеоОбъект");
	СправочникОУ = Настройки.Получить("СправочникОУ");
	ОбъектУчетаВидСравнения = Настройки.Получить("ОбъектУчетаВидСравнения");
	ОбъектУчетаРавно = Настройки.Получить("ОбъектУчетаРавно");
	ОбъектУчетаВСписке = Настройки.Получить("ОбъектУчетаВСписке");
	
	ОбъектУчетаРавноПривестиНаСервере();
	ОбъектУчетаВСпискеПривестиНаСервере();
	
	ГеоОбъектВидСравненияПриИзмененииНаСервере();
	ОбъектУчетаВидСравненияПриИзмененииНаСервере();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура СлойНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(ТипГеометрии) Тогда
		СтандартнаяОбработка = Ложь;
		ОткрытьФорму("Справочник.гисСлоиКарты.ФормаВыбора", Новый Структура("ТекущаяСтрока,Отбор", Слой, Новый Структура("ТипГеометрии", ТипГеометрии)), , , , , 
			Новый ОписаниеОповещения("СлойНачалоВыбораЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СлойНачалоВыбораЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено Тогда
		Слой = ВыбранноеЗначение;
		СлойПриИзменении(Элементы.Слой);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура СлойПриИзменении(Элемент)
	Если ЗначениеЗаполнено(Слой) Тогда
		СправочникОУЗаполнитьСписокВыбораНаСервере();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ГеоОбъектВидСравненияПриИзменении(Элемент)
	Если Не ЗначениеЗаполнено(ГеоОбъектВидСравнения) Тогда
		ГеоОбъектВидСравнения = Элементы.ГеоОбъектВидСравнения.СписокВыбора[0].Значение;
	КонецЕсли;
	
	ГеоОбъектВидСравненияПриИзмененииНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура СправочникОУНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СправочникОУЗаполнитьСписокВыбораНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура СправочникОУПриИзменении(Элемент)
	ОбъектУчетаРавноПривестиНаСервере();
	ОбъектУчетаВСпискеПривестиНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ОбъектУчетаВидСравненияПриИзменении(Элемент)
	Если Не ЗначениеЗаполнено(ОбъектУчетаВидСравнения) Тогда
		ОбъектУчетаВидСравнения = Элементы.ОбъектУчетаВидСравнения.СписокВыбора[0].Значение;
	КонецЕсли;
	
	ОбъектУчетаВидСравненияПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОбъектУчетаРавноНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(СправочникОУ) Тогда
		ОбъектУчетаРавноНачалоВыбораОткрытиеФормы(СправочникОУ);
	Иначе
		Если Элементы.СправочникОУ.СписокВыбора.Количество() = 1 Тогда
			ОбъектУчетаРавноНачалоВыбораОткрытиеФормы(Элементы.СправочникОУ.СписокВыбора[0].Значение);
		ИначеЕсли Элементы.СправочникОУ.СписокВыбора.Количество() > 1 Тогда
			НачальноеЗначение = Неопределено;
			Если ЗначениеЗаполнено(ОбъектУчетаРавно) Тогда
				Для Каждого ЭлементСписка Из Элементы.СправочникОУ.СписокВыбора Цикл
					Если ТипЗнч(ОбъектУчетаРавно) = Тип("СправочникСсылка." + ЭлементСписка.Значение) Тогда
						НачальноеЗначение = ЭлементСписка;
						Прервать;
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
			ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ОбъектУчетаРавноНачалоВыбораВыборСправочника", ЭтотОбъект), Элементы.СправочникОУ.СписокВыбора, , НачальноеЗначение);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбъектУчетаРавноНачалоВыбораВыборСправочника(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено Тогда
		ОбъектУчетаРавноНачалоВыбораОткрытиеФормы(ВыбранноеЗначение.Значение);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОбъектУчетаРавноНачалоВыбораОткрытиеФормы(ИмяСправочника)
	ОткрытьФорму("Справочник." + ИмяСправочника + ".ФормаВыбора", Новый Структура("ТекущаяСтрока,ВыборГруппИЭлементов", ОбъектУчетаРавно, ИспользованиеГруппИЭлементов.ГруппыИЭлементы), , , , , 
		Новый ОписаниеОповещения("ОбъектУчетаРавноНачалоВыбораЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ОбъектУчетаРавноНачалоВыбораЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено Тогда
		ОбъектУчетаРавно = ВыбранноеЗначение;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ОбъектУчетаВСпискеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(СправочникОУ) Тогда
		ОбъектУчетаВСпискеПривестиНаСервере();
	Иначе
		Если Элементы.СправочникОУ.СписокВыбора.Количество() > 0 Тогда
			ОбъектУчетаВСпискеПривестиНаСервере();
		Иначе
			СтандартнаяОбработка = Ложь;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	ВозвращаемоеЗначение = Новый Структура;
	
	ВозвращаемоеЗначение.Вставить("ТипГеометрии", ТипГеометрии);
	ВозвращаемоеЗначение.Вставить("Слой", Слой);
	ВозвращаемоеЗначение.Вставить("ГеоОбъектВидСравнения", ГеоОбъектВидСравнения);
	ВозвращаемоеЗначение.Вставить("ГеоОбъектРавно", ГеоОбъектРавно);
	ВозвращаемоеЗначение.Вставить("ГеоОбъектВСписке", ГеоОбъектВСписке);
	ВозвращаемоеЗначение.Вставить("ГеоОбъектНаименование", ГеоОбъектНаименование);
	ВозвращаемоеЗначение.Вставить("ГеоОбъект", ГеоОбъект);
	ВозвращаемоеЗначение.Вставить("СправочникОУ", СправочникОУ);
	ВозвращаемоеЗначение.Вставить("ОбъектУчетаВидСравнения", ОбъектУчетаВидСравнения);
	ВозвращаемоеЗначение.Вставить("ОбъектУчетаРавно", ОбъектУчетаРавно);
	ВозвращаемоеЗначение.Вставить("ОбъектУчетаВСписке", ОбъектУчетаВСписке);
	
	ЭтотОбъект.Закрыть(ВозвращаемоеЗначение);
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьФильтр(Команда)
	ТипГеометрии = Неопределено;
	Слой = Неопределено;
	ГеоОбъектВидСравнения = Неопределено;
	ГеоОбъектРавно = Неопределено;
	ГеоОбъектВСписке = Неопределено;
	ГеоОбъектНаименование = Неопределено;
	ГеоОбъект = Неопределено;
	СправочникОУ = Неопределено;
	ОбъектУчетаВидСравнения = Неопределено;
	ОбъектУчетаРавно = Неопределено;
	ОбъектУчетаВСписке = Неопределено;
	
	ГеоОбъектВидСравненияПриИзменении(Элементы.ГеоОбъектВидСравнения);
	ОбъектУчетаВидСравненияПриИзменении(Элементы.ОбъектУчетаВидСравнения);
	
	ОбъектУчетаРавноПривестиНаСервере();
	ОбъектУчетаВСпискеПривестиНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СправочникОУЗаполнитьСписокВыбораНаСервере()
	Если ЗначениеЗаполнено(Слой) Тогда
		МассивСправочников = Новый Массив;
		Если ЗначениеЗаполнено(Слой.СправочникОбъектовУчета) Тогда
			МассивСправочников.Добавить(Слой.СправочникОбъектовУчета);
		КонецЕсли;
	Иначе
		Запрос = Новый Запрос;
		Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ 
		|	СправочникОбъектовУчета 
		|ИЗ Справочник.гисСлоиКарты 
		|ГДЕ 
		|	НЕ ПометкаУдаления 
		|	И НЕ СправочникОбъектовУчета ЕСТЬ NULL 
		|	И СправочникОбъектовУчета <> """" 
		|УПОРЯДОЧИТЬ ПО 
		|	СправочникОбъектовУчета";
		МассивСправочников = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("СправочникОбъектовУчета");
	КонецЕсли;
	
	Элементы.СправочникОУ.СписокВыбора.Очистить();
	Для Каждого Справочник Из МассивСправочников Цикл
		Представление = Метаданные.Справочники[Справочник].Синоним;
		Если Не ЗначениеЗаполнено(Представление) Тогда
			Представление = Неопределено;
		КонецЕсли;
		Элементы.СправочникОУ.СписокВыбора.Добавить(Справочник, Представление);
	КонецЦикла;
	Элементы.СправочникОУ.СписокВыбора.СортироватьПоПредставлению();
	
	Если ЗначениеЗаполнено(СправочникОУ) Тогда
		Если Элементы.СправочникОУ.СписокВыбора.НайтиПоЗначению(СправочникОУ) = Неопределено Тогда
			СправочникОУ = Неопределено;
		КонецЕсли;
	КонецЕсли;
	
	ОбъектУчетаРавноПривестиНаСервере();
	ОбъектУчетаВСпискеПривестиНаСервере();
КонецПроцедуры

&НаСервере
Процедура ОбъектУчетаРавноПривестиНаСервере()
	Если ЗначениеЗаполнено(СправочникОУ) И ЗначениеЗаполнено(ОбъектУчетаРавно) Тогда
		Если ТипЗнч(ОбъектУчетаРавно) <> Тип("СправочникСсылка." + СправочникОУ) Тогда
			ОбъектУчетаРавно = Неопределено;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбъектУчетаВСпискеПривестиНаСервере()
	МассивТипов = Новый Массив;
	Если ЗначениеЗаполнено(СправочникОУ) Тогда
		МассивТипов.Добавить(Тип("СправочникСсылка." + СправочникОУ));
	Иначе
		Для Каждого ЭлементСписка Из Элементы.СправочникОУ.СписокВыбора Цикл
			МассивТипов.Добавить(Тип("СправочникСсылка." + ЭлементСписка.Значение));
		КонецЦикла;
	КонецЕсли;
	
	ОбъектУчетаВСписке.ТипЗначения = Новый ОписаниеТипов(МассивТипов);
КонецПроцедуры

&НаСервере
Процедура ГеоОбъектВидСравненияПриИзмененииНаСервере()
	Если ГеоОбъектВидСравнения = Элементы.ГеоОбъектВидСравнения.СписокВыбора[0].Значение Или
		ГеоОбъектВидСравнения = Элементы.ГеоОбъектВидСравнения.СписокВыбора[1].Значение Или
		ГеоОбъектВидСравнения = Элементы.ГеоОбъектВидСравнения.СписокВыбора[4].Значение Или
		ГеоОбъектВидСравнения = Элементы.ГеоОбъектВидСравнения.СписокВыбора[5].Значение Тогда
		
		Элементы.ГеоОбъектРавно.Видимость = Истина;
		Элементы.ГеоОбъектВСписке.Видимость = Ложь;
	Иначе
		Элементы.ГеоОбъектРавно.Видимость = Ложь;
		Элементы.ГеоОбъектВСписке.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ОбъектУчетаВидСравненияПриИзмененииНаСервере()
	Если ОбъектУчетаВидСравнения = Элементы.ОбъектУчетаВидСравнения.СписокВыбора[0].Значение Или
		ОбъектУчетаВидСравнения = Элементы.ОбъектУчетаВидСравнения.СписокВыбора[1].Значение Или
		ОбъектУчетаВидСравнения = Элементы.ОбъектУчетаВидСравнения.СписокВыбора[4].Значение Или
		ОбъектУчетаВидСравнения = Элементы.ОбъектУчетаВидСравнения.СписокВыбора[5].Значение Тогда
		
		Элементы.ОбъектУчетаРавно.Видимость = Истина;
		Элементы.ОбъектУчетаВСписке.Видимость = Ложь;
	Иначе
		Элементы.ОбъектУчетаРавно.Видимость = Ложь;
		Элементы.ОбъектУчетаВСписке.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
