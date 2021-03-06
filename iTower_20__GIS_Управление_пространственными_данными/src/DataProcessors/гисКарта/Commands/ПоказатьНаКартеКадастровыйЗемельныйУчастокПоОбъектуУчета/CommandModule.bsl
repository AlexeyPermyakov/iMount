#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	СписокУчастков = ПолучитьСписокУчастков(ПараметрКоманды);
	Если СписокУчастков.Количество() = 0 Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ВопросОткрытьКартуЗавершение", ЭтотОбъект, Новый Структура("ПараметрыВыполненияКоманды", ПараметрыВыполненияКоманды)), 
			"Участок не привязан к объекту на карте! Открыть карту?", РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет);
	ИначеЕсли СписокУчастков.Количество() > 1 Тогда
		ФормаВыбора = ПолучитьФорму("Справочник.гисКадастровыеЗемельныеУчастки.ФормаВыбора", Новый Структура("Отбор", Новый Структура("Ссылка", СписокУчастков)));
		ФормаВыбора.Элементы.Список.Отображение = ОтображениеТаблицы.Список;
		
		ФормаВыбора.ОписаниеОповещенияОЗакрытии = Новый ОписаниеОповещения("ВыборОбъектаЗавершение", ЭтотОбъект, Новый Структура("ПараметрыВыполненияКоманды", ПараметрыВыполненияКоманды));
		ФормаВыбора.РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
		ФормаВыбора.Открыть();
	Иначе
		ПоказатьУчасток(СписокУчастков[0].Значение, ПараметрыВыполненияКоманды);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВопросОткрытьКартуЗавершение(Ответ, ДополнительныеПараметры) Экспорт
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ПоказатьУчасток(Неопределено, ДополнительныеПараметры.ПараметрыВыполненияКоманды);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ВыборОбъектаЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено Тогда
		ПоказатьУчасток(ВыбранноеЗначение, ДополнительныеПараметры.ПараметрыВыполненияКоманды);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция ПолучитьСписокУчастков(ОбъектУчета)
	Запрос = Новый Запрос();
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Участки.Ссылка
	|ИЗ
	|	Справочник.гисКадастровыеЗемельныеУчастки КАК Участки
	|ГДЕ
	|	Участки.ОбъектУчета = &ОбъектУчета";
	Запрос.УстановитьПараметр("ОбъектУчета", ОбъектУчета);
	МассивОбъектовКарты = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	СписокУчастков = Новый СписокЗначений;
	СписокУчастков.ЗагрузитьЗначения(МассивОбъектовКарты);
	Возврат СписокУчастков;
КонецФункции

&НаКлиенте
Процедура ПоказатьУчасток(Участок, ПараметрыВыполненияКоманды)
	НашлиКарту = Ложь;
	
	Окна = ПолучитьОкна();
	Для Каждого Окно Из Окна Цикл
		Для Каждого Содержимое Из Окно.Содержимое Цикл
			Если ТипЗнч(Содержимое) = Тип("УправляемаяФорма") И Содержимое.ИмяФормы = "Обработка.гисКарта.Форма.Форма" Тогда
				НашлиКарту = Истина;
				Оповестить("КартаПоказатьУчасток", Участок);
				Содержимое.Активизировать();
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Если Не НашлиКарту Тогда 
		ПараметрыФормы = Новый Структура("Участок", Участок);
		ОткрытьФорму("Обработка.гисКарта.Форма", ПараметрыФормы, ПараметрыВыполненияКоманды.Источник, ПараметрыВыполненияКоманды.Уникальность, ПараметрыВыполненияКоманды.Окно, ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
