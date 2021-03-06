
#Область ПрограммныйИнтерфейс

// Функция - Шаблон бизнес процесса по коду
//
// Параметры:
//  ШаблонБПКод	 - Строка - код шаблона бизнес процесса
// 
// Возвращаемое значение:
//  СправочникСсылка.лм_ШаблоныБизнесПроцессов, СправочникСсылка.ШаблоныБизнесПроцессов, Неопределено - Неопределено, если шаблон не найден
//
Функция ШаблонБизнесПроцессаПоКоду(ШаблонБПКод) Экспорт
	
	текШаблонБП = Неопределено;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("лм_УправлениеБизнесПроцессами") Тогда
		текЗапрос = Новый Запрос;
		текЗапрос.Текст =
		"ВЫБРАТЬ
		|	спрШаблоныБП.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.лм_ШаблоныБизнесПроцессов КАК спрШаблоныБП
		|ГДЕ
		|	спрШаблоныБП.Код = &Код";
		текЗапрос.УстановитьПараметр("Код",		ШаблонБПКод);
		
		текВыборка = текЗапрос.Выполнить().Выбрать();
		Если текВыборка.Следующий() Тогда
			текШаблонБП	= текВыборка.Ссылка;
		КонецЕсли;
	ИначеЕсли ОбщегоНазначения.ПодсистемаСуществует("БизнесПроцессы") Тогда
		текЗапрос = Новый Запрос;
		текЗапрос.Текст =
		"ВЫБРАТЬ
		|	спрШаблоныБП.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ШаблоныБизнесПроцессов КАК спрШаблоныБП
		|ГДЕ
		|	спрШаблоныБП.Код = &Код";
		текЗапрос.УстановитьПараметр("Код",		ШаблонБПКод);
		
		текВыборка = текЗапрос.Выполнить().Выбрать();
		Если текВыборка.Следующий() Тогда
			текШаблонБП	= текВыборка.Ссылка;
		КонецЕсли;
	КонецЕсли;
	
	Возврат текШаблонБП;
	
КонецФункции

#КонецОбласти

#Область ОбработчикиСобытийОбъекта

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

