
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(Параметры.Геометрия) Тогда
		ЗагрузитьГеометрию(Параметры.Геометрия);
	КонецЕсли;
	
	ЕстьДырки = НомераДырок.Количество() > 0;
	ОтображатьДырки = ЕстьДырки;
	Элементы.ДыркиГруппа.Видимость = ЕстьДырки;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтображатьДыркиПриИзменении(Элемент)
	Элементы.ДыркиГруппа.Видимость = ОтображатьДырки;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыНомераДырок

&НаКлиенте
Процедура НомераДырокПриАктивизацииСтроки(Элемент)
	Если Элементы.НомераДырок.ТекущиеДанные = Неопределено Тогда
		Элементы.Дырки.ОтборСтрок = Неопределено;
	Иначе
		Если Не ЗначениеЗаполнено(Элементы.НомераДырок.ТекущиеДанные.КлючСтроки) Тогда
			Элементы.НомераДырок.ТекущиеДанные.КлючСтроки = ПолучитьСледующийКлючДырок();
			Элементы.НомераДырок.ТекущиеДанные.НомерСтроки = НомераДырок.Количество();
		КонецЕсли;
		
		Элементы.Дырки.ОтборСтрок = Новый ФиксированнаяСтруктура("НомерДырки", Элементы.НомераДырок.ТекущиеДанные.КлючСтроки);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура НомераДырокПередУдалением(Элемент, Отказ)
	Если Элементы.НомераДырок.ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Строки = Дырки.НайтиСтроки(Новый Структура("НомерДырки", Элементы.НомераДырок.ТекущиеДанные.КлючСтроки));
	Для Каждого Строка Из Строки Цикл
		Дырки.Удалить(Строка);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура НомераДырокПослеУдаления(Элемент)
	ОбновитьНомераДырок();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыДырки

&НаКлиенте
Процедура ДыркиПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	Если НомераДырок.Количество() = 0 Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ДыркиПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда
		Элементы.Дырки.ТекущиеДанные.НомерДырки = Элементы.НомераДырок.ТекущиеДанные.КлючСтроки;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	ЭтотОбъект.Закрыть(ГеометрияВJson());
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает геометрию, введенную на форме, в формате GeoJson.
// Геометрия будет типа Polygon.
// 
// Возвращаемое значение:
//   - Строка - геометрия в формате GeoJson.
//
&НаСервере
Функция ГеометрияВJson()
	Если ОсновнойКонтур.Количество() = 0 Тогда
		Возврат "";
	КонецЕсли;
	
	МассивПолигонов = Новый Массив;
	
	Полигон = Новый Массив;
	Для Каждого Строка Из ОсновнойКонтур Цикл
		Координаты = Новый Массив;
		Координаты.Добавить(Строка.Долгота);
		Координаты.Добавить(Строка.Широта);
		Полигон.Добавить(Координаты);
	КонецЦикла;
	
	МассивПолигонов.Добавить(Полигон);
	
	Для Каждого НомерДырки Из НомераДырок Цикл
		Полигон = Новый Массив;
		
		СтрокиДырки = Дырки.НайтиСтроки(Новый Структура("НомерДырки", НомерДырки.КлючСтроки));
		
		Для Каждого Строка Из СтрокиДырки Цикл
			Координаты = Новый Массив;
			Координаты.Добавить(Строка.Долгота);
			Координаты.Добавить(Строка.Широта);
			Полигон.Добавить(Координаты);
		КонецЦикла;
		
		МассивПолигонов.Добавить(Полигон);
	КонецЦикла;
	
	Возврат гисГисСервер.ПолучитьGeoJson(МассивПолигонов, "Polygon");
КонецФункции

// Загружает на форму геометрию типа Polygon сохраненную в формате GeoJson.
// Если тип другой - выдает сообщение об ошибке.
//
// Параметры:
//  ГеометрияСтрока	 - Строка - геометрия в формате GeoJson.
//
&НаСервере
Процедура ЗагрузитьГеометрию(ГеометрияСтрока)
	Геометрия = гисРаботаСJson.ПрочитатьНативно(ГеометрияСтрока);
	
	geometry = Геометрия.geometry;
	Если geometry.type <> "Polygon" Тогда
		ОбщегоНазначения.СообщитьПользователю("Ошибка при загрузке геометрии!");
		Возврат;
	КонецЕсли;
	
	МассивПолигонов = geometry.coordinates;
	
	Если МассивПолигонов.Количество() > 0 Тогда
		// основной полигон
		Для Каждого Координаты Из МассивПолигонов[0] Цикл
			НоваяСтрока = ОсновнойКонтур.Добавить();
			НоваяСтрока.Долгота = Координаты[0];
			НоваяСтрока.Широта = Координаты[1];
		КонецЦикла;
	КонецЕсли;
	
	Для НомерДырки = 1 По МассивПолигонов.Количество() - 1 Цикл
		НоваяСтрока = НомераДырок.Добавить();
		НоваяСтрока.НомерСтроки = НомерДырки;
		НоваяСтрока.КлючСтроки = НомерДырки;
		
		Для Каждого Координаты Из МассивПолигонов[НомерДырки] Цикл
			НоваяСтрока = Дырки.Добавить();
			НоваяСтрока.НомерДырки = НомерДырки;
			НоваяСтрока.Долгота = Координаты[0];
			НоваяСтрока.Широта = Координаты[1];
		КонецЦикла;
	КонецЦикла;
КонецПроцедуры


// В таблице НомераДырок проставляем заново номера контуров.
//
&НаКлиенте
Процедура ОбновитьНомераДырок()
	НомерСтроки = 1;
	Для каждого Строка Из НомераДырок Цикл
		Строка.НомерСтроки = НомерСтроки;
		НомерСтроки = НомерСтроки + 1;
	КонецЦикла;
КонецПроцедуры

// Возвращает следующий ключ строки для табличной части НомераДырок.
// 
// Возвращаемое значение:
//   - Число - Ключ строки для следующей дырки.
//
&НаКлиенте
Функция ПолучитьСледующийКлючДырок()
	МаксимальныйКлюч = 0;
	Для каждого Строка Из НомераДырок Цикл
		Если Строка.КлючСтроки > МаксимальныйКлюч Тогда
			МаксимальныйКлюч = Строка.КлючСтроки;
		КонецЕсли; 
	КонецЦикла;
	Возврат МаксимальныйКлюч + 1;
КонецФункции

#КонецОбласти
