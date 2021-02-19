
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	Если Не ЭтоГруппа Тогда
		Если ТипЗначения = Перечисления.гисПоказателиТипы.Справочник Тогда
			ПроверяемыеРеквизиты.Добавить("СправочникИмя");
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	ЭтоЧисло = ТипЗначения = Перечисления.гисПоказателиТипы.Число;
	
	Для Каждого Строка Из ЦветаПоказателей Цикл
		Если ЗначениеЗаполнено(Строка.Подпись) Тогда
			Продолжить;
		КонецЕсли;
			
		Если ЭтоЧисло Тогда
			Строка.Подпись = "от " + Строка.ЗначениеОт + " до " + Строка.ЗначениеДо;
		Иначе
			Строка.Подпись = Строка(Строка.ЗначениеОт);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли