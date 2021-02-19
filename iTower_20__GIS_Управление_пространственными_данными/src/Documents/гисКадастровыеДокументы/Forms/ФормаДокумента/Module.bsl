
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если ЗагруженФайл Тогда
		ПараметрыФайла = Новый Структура("Автор,ВладелецФайлов,ИмяБезРасширения,РасширениеБезТочки,ВремяИзмененияУниверсальное",
			Пользователи.ТекущийПользователь(), ТекущийОбъект.Ссылка, ИмяФайла, РасширениеФайла);
		Попытка
			РаботаСФайлами.ДобавитьФайл(ПараметрыФайла, АдресСохраненногоФайла);
			ЗагруженФайл = Ложь;
		Исключение
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область ОбработчикиКомандФормыПодменюЗагрузкаИзXml

&НаКлиенте
Процедура ЗагрузитьИзКадастровойВыписки6(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", ПредопределенноеЗначение("Перечисление.гисТипыКадастровыхДокументов.КадастроваяВыписка6"));
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайла", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзКадастровойВыписки7(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", ПредопределенноеЗначение("Перечисление.гисТипыКадастровыхДокументов.КадастроваяВыписка7"));
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайла", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры


&НаКлиенте
Процедура ЗагрузитьИзКадастровогоПаспорта5(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", ПредопределенноеЗначение("Перечисление.гисТипыКадастровыхДокументов.КадастровыйПаспорт5"));
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайла", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзКадастровогоПаспорта6(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", ПредопределенноеЗначение("Перечисление.гисТипыКадастровыхДокументов.КадастровыйПаспорт6"));
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайла", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзКадастровогоПлана9(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", ПредопределенноеЗначение("Перечисление.гисТипыКадастровыхДокументов.КадастровыйПлан9"));
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайла", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьИзКадастровогоПлана10(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", ПредопределенноеЗначение("Перечисление.гисТипыКадастровыхДокументов.КадастровыйПлан10"));
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайла", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеВыбораФайла(Результат, АдресФайла, ИмяВыбранногоФайла, ДополнительныеПараметры) Экспорт
	Если Не Результат Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Загрузка из файла отменена!");
		Возврат;
	КонецЕсли;
	
	Объект.ТипДокумента = ДополнительныеПараметры.ТипДокумента;
	Объект.Комментарий = ИмяВыбранногоФайла;
	ФайлЗагружен = ЗагрузитьИзXmlНаСервере(АдресФайла);
	Если ФайлЗагружен Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ЗавершениеВопросаСохраненияФайла", ЭтотОбъект, Новый Структура("ИмяФайла,АдресФайла", ИмяВыбранногоФайла, АдресФайла)),
			"Сохранить загруженный файл?", РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ЗагрузитьИзФайлаАвто(Команда)
	ИмяФайла = "";
	АдресФайла = Неопределено;
	ДополнительныеПараметры = Новый Структура("ТипДокумента", Неопределено);
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗавершениеВыбораФайлаАвто", ЭтотОбъект, ДополнительныеПараметры), АдресФайла, ИмяФайла, , УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеВыбораФайлаАвто(Результат, АдресФайла, ИмяВыбранногоФайла, ДополнительныеПараметры) Экспорт
	Если Не Результат Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Загрузка из файла отменена!");
		Возврат;
	КонецЕсли;
	
	Объект.Комментарий = ИмяВыбранногоФайла;
	ФайлЗагружен = ЗагрузитьИзXmlНаСервере(АдресФайла, Истина);
	Если ФайлЗагружен Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ЗавершениеВопросаСохраненияФайла", ЭтотОбъект, Новый Структура("ИмяФайла,АдресФайла", ИмяВыбранногоФайла, АдресФайла)),
			"Сохранить загруженный файл?", РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Да);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеВопросаСохраненияФайла(Ответ, ДополнительныеПараметры) Экспорт
	Если Ответ = КодВозвратаДиалога.Да Тогда
		ЗагруженФайл = Истина;
		
		АдресСохраненногоФайла = ДополнительныеПараметры.АдресФайла;
		
		РасширениеФайла = ПолучитьРасширениеФайла(ДополнительныеПараметры.ИмяФайла);
		ИмяФайла = СтрЗаменить(ДополнительныеПараметры.ИмяФайла, "." + РасширениеФайла, "");
		
		Пока Найти(ИмяФайла, "\") > 0 Цикл
			ИмяФайла = Сред(ИмяФайла, Найти(ИмяФайла, "\") + 1);
		КонецЦикла;
	Иначе
		ЗагруженФайл = Ложь;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("МассивСистемКоординат", гисРаботаСJson.ПрочитатьНативно(Объект.СистемыКоординатФайла));
	ОткрытьФорму("Документ.гисКадастровыеДокументы.Форма.ФормаСоответствияСистемКоординат", ПараметрыФормы, , , , , 
		Новый ОписаниеОповещения("ЗавершениеВводаНастроек", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры


&НаКлиенте
Процедура ЗавершениеВводаНастроек(ВозвращаемоеЗначение, ДополнительныеПараметры) Экспорт
	Если ВозвращаемоеЗначение <> Неопределено И ВозвращаемоеЗначение <> КодВозвратаДиалога.Отмена Тогда
		ОбновлятьОбъекты = ТипЗнч(ДополнительныеПараметры) = Тип("Структура") И ДополнительныеПараметры.Свойство("ОбновлятьОбъекты") И ДополнительныеПараметры.ОбновлятьОбъекты;
		
		ЗемельныеУчасткиУстановитьСистемыКоординатНаСервере(ВозвращаемоеЗначение.СистемыКоординат);
		Если ОбновлятьОбъекты Тогда
			ЗемельныеУчасткиОбновитьНаСервере();
		КонецЕсли;
	КонецЕсли;
	
	Если ДополнительныеПараметры = Неопределено Тогда
		ПоказатьПредупреждение(, "Загрузка завершена!");
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормыПодменюЗагруженнаяXml

&НаКлиенте
Процедура ФайлОбновить(Команда)
	Если Объект.Ссылка.Пустая() Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Документ не записан!");
		Возврат;
	КонецЕсли;
	
	МассивФайлов = ПолучитьПрисоединенныеФайлы(Объект.Ссылка);
	Если МассивФайлов.Количество() = 1 Тогда
		ФайлОбновитьНаКлиенте(МассивФайлов[0]);
	ИначеЕсли МассивФайлов.Количество() > 1 Тогда
		СписокФайлов = Новый СписокЗначений;
		СписокФайлов.ЗагрузитьЗначения(МассивФайлов);
		ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ФайлОбновитьЗавершениеВыбораИзСписка", ЭтотОбъект), СписокФайлов, Элементы.Комментарий);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ФайлОбновитьЗавершениеВыбораИзСписка(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено Тогда
		ФайлОбновитьНаКлиенте(ВыбранноеЗначение.Значение);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ФайлОбновитьНаКлиенте(Файл)
	Если Объект.КадастровыеЗемельныеУчастки.Количество() = 0 Тогда
		ФайлОбновитьНаСервере(Файл);
	Иначе
		ПоказатьВопрос(Новый ОписаниеОповещения("ФайлОбновитьЗавершение", ЭтотОбъект, Новый Структура("Файл", Файл)), "Обновлять заполненные строки?", РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ФайлОбновитьЗавершение(Ответ, ДополнительныеПараметры) Экспорт
	ФайлОбновитьНаСервере(ДополнительныеПараметры.Файл, Ответ = КодВозвратаДиалога.Да);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормыЗакладкаЗемельныеУчастки

#Область ОбработчикиКомандФормыЗакладкаЗемельныеУчасткиПодменюУчасток

&НаКлиенте
Процедура ЗемельныеУчасткиУчастокСоздать(Команда)
	Если Объект.Ссылка.Пустая() Тогда
		ПоказатьПредупреждение(, "Сначала нужно записать документ!");
		Возврат;
	КонецЕсли;
	
	Если Элементы.КадастровыеЗемельныеУчастки.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока = Элементы.КадастровыеЗемельныеУчастки.ТекущиеДанные;
	
	ПараметрыФормы = Новый Структура("ДанныеXml, Документ, ПараметрыПереводаВWgs84, Слой", 
		ТекущаяСтрока.ДанныеXml, Объект.Ссылка, ТекущаяСтрока.ПараметрыПереводаВWgs84, Объект.Слой);
	Форма = ПолучитьФорму("Справочник.гисКадастровыеЗемельныеУчастки.ФормаОбъекта", ПараметрыФормы);
	
	Форма.РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
	Форма.ОписаниеОповещенияОЗакрытии = Новый ОписаниеОповещения("ЗавершениеЗемельныеУчасткиУчастокСоздать", ЭтотОбъект, Новый Структура("Форма", Форма));
	Форма.Открыть();
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеЗемельныеУчасткиУчастокСоздать(Результат, ДополнительныеПараметры) Экспорт
	КУ = ДополнительныеПараметры.Форма.Объект.Ссылка;
	Если Не КУ.Пустая() Тогда
		Элементы.КадастровыеЗемельныеУчастки.ТекущиеДанные.ЗемельныйУчасток = КУ;
		ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗемельныеУчасткиУчастокОбновить(Команда)
	Если Объект.Ссылка.Пустая() Тогда
		ПоказатьПредупреждение(, "Сначала нужно записать документ!");
		Возврат;
	КонецЕсли;
	
	Если Элементы.КадастровыеЗемельныеУчастки.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТекущаяСтрока = Элементы.КадастровыеЗемельныеУчастки.ТекущиеДанные;
	
	Если Не ЗначениеЗаполнено(ТекущаяСтрока.ЗемельныйУчасток) Тогда
		ПоказатьПредупреждение(, "Не выбран земельный участок!");
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ТекущаяСтрока.ДокументУчастка) И Объект.Ссылка <> ТекущаяСтрока.ДокументУчастка И Объект.Дата < ТекущаяСтрока.ДатаДокументаУчастка Тогда
		ПоказатьПредупреждение(, "Имеются более актуальные данные!");
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("Ключ, ДанныеXml, Документ, ПараметрыПереводаВWgs84", 
		ТекущаяСтрока.ЗемельныйУчасток, ТекущаяСтрока.ДанныеXml, Объект.Ссылка, ТекущаяСтрока.ПараметрыПереводаВWgs84);
	ОткрытьФорму("Справочник.гисКадастровыеЗемельныеУчастки.ФормаОбъекта", ПараметрыФормы, , , , , 
		Новый ОписаниеОповещения("ЗавершениеЗемельныеУчасткиУчастокОбновить", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеЗемельныеУчасткиУчастокОбновить(Результат, ДополнительныеПараметры) Экспорт
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормыЗакладкаЗемельныеУчасткиПодменюГрупповыеДействия

&НаКлиенте
Процедура ЗемельныеУчасткиЗаполнитьПараметрыПереводаВWgs84(Команда)
	Если Не ЗначениеЗаполнено(Объект.СистемыКоординатФайла) Тогда
		ПоказатьПредупреждение(, "Не загружена xml!");
	ИначеЕсли ЗначениеЗаполнено(Объект.СистемыКоординатФайла) Тогда
		ЗемельныеУчасткиУстановитьСистемыКоординат();
	Иначе
		ПараметрыПеревода = ПредопределенноеЗначение("Справочник.гисПараметрыПереводаВWgs84.ПустаяСсылка");
		ПоказатьВводЗначения(Новый ОписаниеОповещения("ЗавершениеВводаПараметровПереводаЗемельныеУчастки", ЭтотОбъект), ПараметрыПеревода, "Выберите параметры перевода из кадастровой проекции:");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеВводаПараметровПереводаЗемельныеУчастки(ПараметрыПеревода, ДополнительныеПараметры) Экспорт
	Если ПараметрыПеревода <> Неопределено Тогда
		Для Каждого Строка Из Объект.КадастровыеЗемельныеУчастки Цикл
			Строка.ПараметрыПереводаВWgs84 = ПараметрыПеревода;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ЗемельныеУчасткиОчиститьПустыеСтроки(Команда)
	ЗемельныеУчасткиОчиститьПустыеСтрокиНаСервере();
КонецПроцедуры


&НаКлиенте
Процедура ЗемельныеУчасткиПодобрать(Команда)
	ЗемельныеУчасткиПодобратьНаСервере();
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры

&НаКлиенте
Процедура ЗемельныеУчасткиОбновить(Команда)
	Если Объект.Ссылка.Пустая() Тогда
		ПоказатьПредупреждение(, "Сначала нужно записать документ!");
		Возврат;
	КонецЕсли;
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ЗемельныеУчасткиОбновитьНаСервере();
	Состояние("ЗУ: обновление завершено!");
КонецПроцедуры

&НаКлиенте
Процедура ЗемельныеУчасткиСоздать(Команда)
	Если Объект.Ссылка.Пустая() Тогда
		ПоказатьПредупреждение(, "Сначала нужно записать документ!");
		Возврат;
	КонецЕсли;
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ЗемельныеУчасткиСоздатьНаСервере();
	Состояние("ЗУ: создание завершено!");
КонецПроцедуры


&НаКлиенте
Процедура ЗемельныеУчасткиСоздатьОбновить(Команда)
	Если Объект.Ссылка.Пустая() Тогда
		ПоказатьПредупреждение(, "Сначала нужно записать документ!");
		Возврат;
	КонецЕсли;
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ЗемельныеУчасткиСоздатьОбновитьНаСервере();
	Состояние("ЗУ: создание / обновление завершено!");
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ЗемельныеУчасткиРосреестр(Команда)
	ОткрытьФорму("Документ.гисКадастровыеДокументы.Форма.ФормаПараметровДляЗапросаИзРосреестра", , , , , , 
		Новый ОписаниеОповещения("ЗавершениеЗемельныеУчасткиРосреестр", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеЗемельныеУчасткиРосреестр(ВозвращенноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВозвращенноеЗначение <> Неопределено И ВозвращенноеЗначение <> КодВозвратаДиалога.Отмена Тогда
		ЗемельныеУчасткиРосреестрНаСервере(ВозвращенноеЗначение.МассивДанныхXml);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ПолучитьРасширениеФайла(Знач ИмяФайла)
	РасширениеФайла = "";
	МассивСтрок = СтрРазделить(ИмяФайла, ".", Ложь);
	Если МассивСтрок.Количество() > 1 Тогда
		РасширениеФайла = МассивСтрок[МассивСтрок.Количество() - 1];
	КонецЕсли;
	
	Возврат РасширениеФайла;
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьПрисоединенныеФайлы(Документ)
	МассивФайлов = Новый Массив;
	РаботаСФайлами.ЗаполнитьПрисоединенныеФайлыКОбъекту(Документ, МассивФайлов);
	Возврат МассивФайлов;
КонецФункции

&НаСервере
Функция ЗагрузитьИзXmlНаСервере(Адрес, Авто = Ложь)
	ИмяФайлаНаСервере = КаталогВременныхФайлов() + "xml " + Формат(ТекущаяДата(), "ДФ=""гггг.ММ.дд ЧЧ-мм-сс""") + ".xml";
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяФайлаНаСервере);
	
	Если Не гисРаботаСКадастром.ПроверитьXmlНаКорректность(ИмяФайлаНаСервере) Тогда
		ОбщегоНазначения.СообщитьПользователю("Некорректная xml!" + Символы.ПС + "Ошибка разбора xml!");
		Возврат Ложь;
	КонецЕсли;
	
	Если Авто Тогда
		ТипДокумента = гисРаботаСКадастром.ПолучитьТипДокумента(ИмяФайлаНаСервере);
		Если Не ЗначениеЗаполнено(ТипДокумента) Тогда
			ОбщегоНазначения.СообщитьПользователю("Тип xml не определен! Загрузка отменена!");
			Возврат Ложь;
		КонецЕсли;
		Объект.ТипДокумента = ТипДокумента;
	КонецЕсли;
	
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	Результат = ДокументОбъект.ЗаполнитьТабличныеЧасти(ИмяФайлаНаСервере);
	ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
	
	Если Результат Тогда
		Модифицированность = Истина;
		
		ЗемельныеУчасткиПодобратьНаСервере();
		ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	КонецЕсли;
	
	Попытка
		УдалитьФайлы(ИмяФайлаНаСервере);
	Исключение
	КонецПопытки;
	
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ФайлОбновитьНаСервере(Файл, ИзменятьЗаполненные = Ложь)
	ИмяФайлаНаСервере = КаталогВременныхФайлов() + "xml " + Формат(ТекущаяДата(), "ДФ=""гггг.ММ.дд ЧЧ-мм-сс""") + ".xml";
	
	ДвоичныеДанные = РаботаСФайлами.ДвоичныеДанныеФайла(Файл);
	ДвоичныеДанные.Записать(ИмяФайлаНаСервере);

	Если Не гисРаботаСКадастром.ПроверитьXmlНаКорректность(ИмяФайлаНаСервере) Тогда
		ОбщегоНазначения.СообщитьПользователю("Некорректная xml!" + Символы.ПС + "Ошибка разбора xml!");
		Возврат;
	КонецЕсли;
	
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	Результат = ДокументОбъект.ЗаполнитьТабличныеЧасти(ИмяФайлаНаСервере, Ложь, ИзменятьЗаполненные);
	ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
	
	Если Результат Тогда
		Модифицированность = Истина;
		
		ЗемельныеУчасткиПодобратьНаСервере();
		ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	КонецЕсли;
	
	Попытка
		УдалитьФайлы(ИмяФайлаНаСервере);
	Исключение
	КонецПопытки;
КонецПроцедуры

#Область СлужебныеПроцедурыИФункцииЗемельныеУчастки

&НаСервере
Процедура ЗемельныеУчасткиЗаполнитьВременныеРеквизиты()
	Для Каждого Строка Из Объект.КадастровыеЗемельныеУчастки Цикл
		Строка.ДокументУчастка = Строка.ЗемельныйУчасток.КадастровыйДокумент;
		Строка.ДатаДокументаУчастка = Строка.ЗемельныйУчасток.КадастровыйДокумент.Дата;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ЗемельныеУчасткиОчиститьПустыеСтрокиНаСервере()
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	ДокументОбъект.ЗемельныеУчасткиОчиститьПустыеСтроки();
	ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
	
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры


&НаСервере
Процедура ЗемельныеУчасткиУстановитьСистемыКоординатНаСервере(МассивСистемКоординат)
	Объект.СистемыКоординатФайла = гисРаботаСJson.ЗаписатьНативно(МассивСистемКоординат);
	
	Для Каждого Строка Из Объект.КадастровыеЗемельныеУчастки Цикл
		Если МассивСистемКоординат.Количество() = 1 Тогда
			Строка.ПараметрыПереводаВWgs84 = ЗначениеИзСтрокиВнутр(МассивСистемКоординат[0].Ссылка);
		Иначе
			Если ЗначениеЗаполнено(Строка.СистемаКоординат) Тогда
				Для Каждого СтрокаСПараметрами Из МассивСистемКоординат Цикл
					Если СтрокаСПараметрами.Ид = Строка.СистемаКоординат Тогда
						Строка.ПараметрыПереводаВWgs84 = ЗначениеИзСтрокиВнутр(СтрокаСПараметрами.Ссылка);
						Прервать;
					КонецЕсли;
				КонецЦикла;
			Иначе
				Строка.ПараметрыПереводаВWgs84 = Неопределено;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ЗемельныеУчасткиУстановитьСистемыКоординат()
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("МассивСистемКоординат", гисРаботаСJson.ПрочитатьНативно(Объект.СистемыКоординатФайла));
	ОткрытьФорму("Документ.гисКадастровыеДокументы.Форма.ФормаСоответствияСистемКоординат", ПараметрыФормы, ЭтотОбъект, , , , 
		Новый ОписаниеОповещения("ЗавершениеЗемельныеУчасткиУстановитьСистемыКоординат", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеЗемельныеУчасткиУстановитьСистемыКоординат(ВозвращаемоеЗначение, ДополнительныеПараметры) Экспорт
	Если ВозвращаемоеЗначение = Неопределено Или ВозвращаемоеЗначение = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	Если ВозвращаемоеЗначение.ДляВсехЗакладок Тогда
		ЗавершениеВводаНастроек(ВозвращаемоеЗначение, ВозвращаемоеЗначение);
	Иначе
		ЗемельныеУчасткиУстановитьСистемыКоординатНаСервере(ВозвращаемоеЗначение.СистемыКоординат);
		Если ВозвращаемоеЗначение.ОбновлятьОбъекты Тогда
			ЗемельныеУчасткиОбновитьНаСервере();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры


&НаСервере
Процедура ЗемельныеУчасткиПодобратьНаСервере()
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	ДокументОбъект.ЗемельныеУчасткиПодобрать();
	ЗначениеВРеквизитФормы(ДокументОбъект, "Объект");
	
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	Модифицированность = Истина;
КонецПроцедуры

// создание / обновление ЗУ

&НаСервере
Процедура ЗемельныеУчасткиСоздатьОбновитьСтрокуНаСервере(Строка)
	ДокументОбъект = РеквизитФормыВЗначение("Объект");
	Попытка
		ДокументОбъект.ЗемельныеУчасткиСоздатьОбновитьСтроку(Строка);
	Исключение
		ОбщегоНазначения.СообщитьПользователю(ОписаниеОшибки());
	КонецПопытки;
КонецПроцедуры

&НаСервере
Процедура ЗемельныеУчасткиОбновитьНаСервере()
	Для Каждого Строка Из Объект.КадастровыеЗемельныеУчастки Цикл
		Если Не ЗначениеЗаполнено(Строка.ЗемельныйУчасток) Тогда
			Продолжить;
		КонецЕсли;
		
		ЗемельныеУчасткиСоздатьОбновитьСтрокуНаСервере(Строка);
	КонецЦикла;
	
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	Модифицированность = Истина;
КонецПроцедуры

&НаСервере
Процедура ЗемельныеУчасткиСоздатьНаСервере()
	Для Каждого Строка Из Объект.КадастровыеЗемельныеУчастки Цикл
		Если ЗначениеЗаполнено(Строка.ЗемельныйУчасток) Тогда
			Продолжить;
		КонецЕсли;
		
		ЗемельныеУчасткиСоздатьОбновитьСтрокуНаСервере(Строка);
	КонецЦикла;
	
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	Модифицированность = Истина;
КонецПроцедуры

&НаСервере
Процедура ЗемельныеУчасткиСоздатьОбновитьНаСервере()
	Для Каждого Строка Из Объект.КадастровыеЗемельныеУчастки Цикл
		ЗемельныеУчасткиСоздатьОбновитьСтрокуНаСервере(Строка);
	КонецЦикла;
	
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
	Модифицированность = Истина;
КонецПроцедуры

// Росреестр

&НаСервере
Процедура ЗемельныеУчасткиРосреестрНаСервере(МассивДанныхXml)
	Массив = гисРаботаСКадастром.ЗемельныеУчасткиПолучитьМассивСвойствДата();
	
	Для Каждого ДанныеXml Из МассивДанныхXml Цикл
		НоваяСтрока = Объект.КадастровыеЗемельныеУчастки.Добавить();
		НоваяСтрока.ДанныеXml = ДанныеXml;
		СтруктураДанныхXml = гисРаботаСJson.ПрочитатьНативно(ДанныеXml, Массив);
		НоваяСтрока.КадастровыйНомер = СтруктураДанныхXml.КадастровыйНомер;
		НоваяСтрока.КатегорияЗемель = Справочники.гисКатегорииЗемель.НайтиПоКоду(СтруктураДанныхXml.КатегорияЗемельКод);
		НоваяСтрока.ВидИспользования = Справочники.гисВидыРазрешенногоИспользования.НайтиПоКоду(СтруктураДанныхXml.ВидИспользованияКод);
	КонецЦикла;
	
	ЗемельныеУчасткиПодобратьНаСервере();
	ЗемельныеУчасткиЗаполнитьВременныеРеквизиты();
КонецПроцедуры

#КонецОбласти

#КонецОбласти
