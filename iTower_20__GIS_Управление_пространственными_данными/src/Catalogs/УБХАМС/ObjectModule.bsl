#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	Если ЗначениеЗаполнено(Площадка) Тогда
		Регион = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Площадка, "Регион");
	КонецЕсли;

КонецПроцедуры

#КонецЕсли
