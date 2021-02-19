#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Установка отборов.
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияАМС, "АМС", Объект.Ссылка);
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияАМС, "ГруппаРазмещения", Перечисления.УБХГруппыРазмещения.АМС);
	
	ГруппыКонтЗУ = Новый СписокЗначений;
	ГруппыКонтЗУ.Добавить(Перечисления.УБХГруппыРазмещения.ПлощадкаЗУ);
	ГруппыКонтЗУ.Добавить(Перечисления.УБХГруппыРазмещения.Контейнер);
	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияКонтЗУ, "АМС", Объект.Ссылка);	
	ОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(СписокОборудованияКонтЗУ, "ГруппаРазмещения", ГруппыКонтЗУ);
		
	Элементы.Характеристики.Заголовок = "Характеристики: " + "Высота "+ Объект.Высота + " м, тип " + """" + Объект.ТипКонструкции + """" + ", Тип установки опоры " + """" + Объект.ТипУстановкиОпоры + """" + ", материал " + """" + Объект.Материал + """";  
	
КонецПроцедуры

#КонецОбласти
