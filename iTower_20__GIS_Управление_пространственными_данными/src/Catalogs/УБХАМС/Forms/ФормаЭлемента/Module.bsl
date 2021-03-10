#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// ИнтеграцияС1СДокументооборотом	
	ИнтеграцияС1СДокументооборот.ПриСозданииНаСервере(ЭтаФорма);	
	// Конец ИнтеграцияС1Сдокументооборотом

	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияАМС, "АМС", Объект.Ссылка);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияАМС, "ГруппаРазмещения", Перечисления.УБХГруппыРазмещения.АМС);
	
	ГруппыКонтЗУ = Новый СписокЗначений;
	ГруппыКонтЗУ.Добавить(Перечисления.УБХГруппыРазмещения.ПлощадкаЗУ);
	ГруппыКонтЗУ.Добавить(Перечисления.УБХГруппыРазмещения.Контейнер);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияКонтЗУ, "АМС", Объект.Ссылка);	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияКонтЗУ, "ГруппаРазмещения", ГруппыКонтЗУ);
		
	Элементы.Характеристики.Заголовок = "Характеристики: " + "Высота "+ Объект.Высота + " м, тип " + """" + Объект.ТипКонструкции + """" + ", Тип установки опоры " + """" + Объект.ТипУстановкиОпоры + """" + ", материал " + """" + Объект.Материал + """";  
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	// ИнтеграцияС1СДокументооборотом	
	ИнтеграцияС1СДокументооборот.ПередЗаписьюНаСервере(ЭтаФорма, ТекущийОбъект, ПараметрыЗаписи);	
	// Конец ИнтеграцияС1Сдокументооборотом
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// ИнтеграцияС1СДокументооборотом
&НаКлиенте

Процедура Подключаемый_ВыполнитьКомандуИнтеграции(Команда)
	
	ИнтеграцияС1СДокументооборотКлиент.ВыполнитьПодключаемуюКомандуИнтеграции(Команда, ЭтаФорма, Объект);
	
КонецПроцедуры
// Конец ИнтеграцияС1Сдокументооборотом

#КонецОбласти
