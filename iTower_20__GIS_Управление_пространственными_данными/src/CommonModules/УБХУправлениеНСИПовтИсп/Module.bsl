#Область СлужебныеПроцедурыИФункции

// Функция возвращает типы для по которым есть реквизит Площадка.
// 
// Возвращаемое значение:
//  Массив типов.
//
Функция ПолучитьТипыОбъектовПлощадки() Экспорт
	
	ТипыОбъектовПлощадки = Новый Массив;
	
	Для Каждого Тип Из Метаданные.ОпределяемыеТипы.УБХОбъектыПлощадки.Тип.Типы() Цикл
		Если Тип = Тип("СправочникСсылка.УБХОсновныеСредства") Тогда
			Продолжить;
		КонецЕсли;
		
		ТипыОбъектовПлощадки.Добавить(Тип);
		
	КонецЦикла;
	
	Возврат ТипыОбъектовПлощадки;
	
КонецФункции

#КонецОбласти