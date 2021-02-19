#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	// Заполнение констант
	гисИмяСтиляКонфигурации				= Константы.гисИмяСтиляКонфигурации.Получить();
	гисКлючДляБазовыхСлоевКосмоснимки	= Константы.гисКлючДляБазовыхСлоевКосмоснимки.Получить();
	гисКлючДляБазовыхСлоевЯндекс		= Константы.гисКлючДляБазовыхСлоевЯндекс.Получить();
	гисКлючДляБазовыхСлоевArcgis		= Константы.гисКлючДляБазовыхСлоевArcgis.Получить();
	
	// Проверка основного стиля конфигурации
	Если Метаданные.ОсновнойСтиль = Неопределено Тогда
		ЗаполнитьСписокВыбораИмяСтиляКонфигурации();
	Иначе
		Элементы.ГруппаВнешнийВидСтильКонфигурацииОтключено.Видимость = Истина;
		Элементы.ГруппаВнешнийВидСтильКонфигурации.Доступность = Ложь;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзмененияИЗакрыть(Команда)
	Если СохранитьНаСервере() Тогда
		Закрыть();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	СохранитьНаСервере();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьСписокВыбораИмяСтиляКонфигурации()
	Элементы.гисИмяСтиляКонфигурации.РежимВыбораИзСписка = Истина;
	Элементы.гисИмяСтиляКонфигурации.СписокВыбора.Очистить();
	Для каждого ОбъектСтиль Из Метаданные.Стили Цикл
		Элементы.гисИмяСтиляКонфигурации.СписокВыбора.Добавить(ОбъектСтиль.Имя, ОбъектСтиль.Синоним);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция СохранитьНаСервере()
	Попытка
		// Запись констант
		Константы.гисИмяСтиляКонфигурации.Установить(гисИмяСтиляКонфигурации);
		Константы.гисКлючДляБазовыхСлоевКосмоснимки.Установить(гисКлючДляБазовыхСлоевКосмоснимки);
		Константы.гисКлючДляБазовыхСлоевЯндекс.Установить(гисКлючДляБазовыхСлоевЯндекс);
		Константы.гисКлючДляБазовыхСлоевArcgis.Установить(гисКлючДляБазовыхСлоевArcgis);
		
		Модифицированность = Ложь;
		Возврат Истина;
	Исключение
		ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());
		Возврат Ложь;
	КонецПопытки;
КонецФункции

#КонецОбласти
