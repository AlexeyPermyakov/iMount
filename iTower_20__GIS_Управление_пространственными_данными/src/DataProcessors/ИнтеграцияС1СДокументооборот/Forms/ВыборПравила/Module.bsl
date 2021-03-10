#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	ИнтеграцияС1СДокументооборотПереопределяемый.ПриСозданииНаСервереФормыВыбораПравила(ЭтотОбъект);
	
	ЕстьКомментарии = Ложь;
	Для Каждого Правило Из Параметры.Правила Цикл
		СтрокаПравила = Правила.Добавить();
		ЗаполнитьЗначенияСвойств(СтрокаПравила, Правило);
		ИнтеграцияС1СДокументооборотПереопределяемый.ПриОпределенииПредставленияВидаОбъектаПотребителя(
			СтрокаПравила.Ссылка,
			СтрокаПравила.ПредставлениеОбъектаИС);
		СтрокаПравила.Комментарий = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(
			СтрокаПравила.Ссылка,
			"Комментарий");
		ЕстьКомментарии = ЕстьКомментарии Или ЗначениеЗаполнено(СтрокаПравила.Комментарий);
	КонецЦикла;
	
	Если Параметры.Свойство("СозданиеОбъектаИС") Тогда
		Элементы.ПравилаПредставлениеОбъектаДО.Видимость = Ложь;
		Элементы.ПравилаПредставлениеОбъектаИС.Видимость = Истина;
	КонецЕсли;
	
	Элементы.ПравилаКомментарий.Видимость = ЕстьКомментарии;
	Элементы.Правила.Шапка = ЕстьКомментарии;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Готово(Команда)
	
	ВыбратьИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ПравилаВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ВыбратьИЗакрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ВыбратьИЗакрыть()
	
	ТекущиеДанные = Элементы.Правила.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("Ссылка", ТекущиеДанные.Ссылка);
	Результат.Вставить("ТипОбъектаДО", ТекущиеДанные.ТипОбъектаДО);
	Результат.Вставить("ТипОбъектаИС", ТекущиеДанные.ТипОбъектаИС);
	Результат.Вставить("ПредставлениеОбъектаДО", ТекущиеДанные.ПредставлениеОбъектаДО);
	Результат.Вставить("ПредставлениеОбъектаИС", ТекущиеДанные.ПредставлениеОбъектаИС);
	
	Закрыть(Результат);
	
КонецПроцедуры

#КонецОбласти