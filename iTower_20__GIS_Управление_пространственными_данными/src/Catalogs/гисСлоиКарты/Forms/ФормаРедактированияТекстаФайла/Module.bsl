#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ТекстФайла = Параметры.ТекстФайла;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	ЭтотОбъект.Закрыть(ТекстФайла);
КонецПроцедуры

#КонецОбласти
