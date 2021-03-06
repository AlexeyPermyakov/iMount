
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Первоначальное заполнение справочника из макета.
//
Процедура ПервоначальноеЗаполнениеСправочника() Экспорт
	Макет = ПолучитьМакет("КлассификаторРазрешенногоИспользования");
	ЗаполнениеОкончено = Ложь;
	НомерСтроки = 3; 
	
	Пока Не ЗаполнениеОкончено Цикл
		Строка = "R" + Формат(НомерСтроки, "ЧДЦ=0; ЧГ=0"); 
		
		Код = Макет.Область(Строка + "C2").Текст; 
		Наименование = Макет.Область(Строка + "C3").Текст; 
		Если ЗначениеЗаполнено(Код) И ЗначениеЗаполнено(Наименование) Тогда
			НовыйЭлемент = Справочники.гисВидыРазрешенногоИспользования.СоздатьЭлемент();
			НовыйЭлемент.Код = Код;
			НовыйЭлемент.Наименование = Наименование;
			Попытка
				НовыйЭлемент.Записать();
			Исключение
			КонецПопытки;
			НомерСтроки = НомерСтроки + 1;
		Иначе
			ЗаполнениеОкончено = Истина;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#КонецЕсли
