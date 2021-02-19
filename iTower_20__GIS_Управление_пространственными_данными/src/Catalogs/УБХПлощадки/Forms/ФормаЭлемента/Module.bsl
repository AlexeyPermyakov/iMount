#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)	
	ОбновитьТипыОбъектов();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура ОбъектыПлощадкиОбъектПлощадкиПриИзменении(Элемент)
	
	ТекущиеДанные = Элемент.Родитель.ТекущиеДанные;
	ТекущиеДанные.ТипОбъекта = ПолучитьЗначениеТипаОбъекта(ТипЗнч(ТекущиеДанные.ОбъектПлощадки));

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьТипыОбъектов();
	
	Для Каждого СТрокаТЧ Из Объект.ОбъектыПлощадки Цикл
		СТрокаТЧ.ТипОбъекта = ПолучитьЗначениеТипаОбъекта(ТипЗнч(СТрокаТЧ.ОбъектПлощадки));
	КонецЦикла;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьЗначениеТипаОбъекта(ТипЗначенияОбъекта)
	Возврат УБХОбщегоНазначенияКлиентСервер.ТипОбъектаПоТипуЗначения(ТипЗначенияОбъекта);
КонецФункции

#КонецОбласти
