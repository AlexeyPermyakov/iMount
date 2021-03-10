#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("Заголовок") Тогда
		Заголовок = Параметры.Заголовок;
	КонецЕсли;
	Если Параметры.Свойство("ЗаголовокКоманды") Тогда
		Элементы.Готово.Заголовок = Параметры.ЗаголовокКоманды;
	КонецЕсли;
	Если Параметры.Свойство("ОбъектИС") Тогда
		ТипОбъектаИС = Параметры.ОбъектИС.Метаданные().ПолноеИмя();
	КонецЕсли;
	Элементы.ГруппаНастроитьПравило.Видимость = 
		ПравоДоступа("Добавление", Метаданные.Справочники.ПравилаИнтеграцииС1СДокументооборотом);
	
	НоваяСтрока = ТипыОбъектов.Добавить();
	НоваяСтрока.Тип = "DMInternalDocument";
	НоваяСтрока.Представление = НСтр("ru = 'Внутренний документ'");
	
	НоваяСтрока = ТипыОбъектов.Добавить();
	НоваяСтрока.Тип = "DMIncomingDocument";
	НоваяСтрока.Представление = НСтр("ru = 'Входящий документ'");
	
	НоваяСтрока = ТипыОбъектов.Добавить();
	НоваяСтрока.Тип = "DMOutgoingDocument";
	НоваяСтрока.Представление = НСтр("ru = 'Исходящий документ'");
	
	НоваяСтрока = ТипыОбъектов.Добавить();
	НоваяСтрока.Тип = "DMCorrespondent";
	Если ИнтеграцияС1СДокументооборотПовтИсп.ИспользоватьТерминКорреспонденты() Тогда
		НоваяСтрока.Представление = НСтр("ru = 'Корреспондента'");
	Иначе
		НоваяСтрока.Представление = НСтр("ru = 'Контрагента'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ДекорацияНастроитьПравилоНажатие(Элемент)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТипОбъектаИС", ТипОбъектаИС);
	
	ОткрытьФорму("Справочник.ПравилаИнтеграцииС1СДокументооборотом.Форма.ФормаЭлемента",
		ПараметрыФормы,
		ЭтотОбъект);
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Готово(Команда)
	
	ВыбратьИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ТипыОбъектовВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВыбратьИЗакрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыбратьИЗакрыть()
	
	ТекущиеДанные = Элементы.ТипыОбъектов.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Закрыть(ТекущиеДанные.Тип);
	
КонецПроцедуры

#КонецОбласти