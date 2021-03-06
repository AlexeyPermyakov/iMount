#Область ОбработчикиСобытийЭлементовТаблицыФормыПоискПоАдресуРезультаты

&НаКлиенте
Процедура ПоискПоАдресуРезультатыПриАктивизацииСтроки(Элемент)
	ТекущаяСтрока = Элементы.ПоискПоАдресуРезультаты.ТекущиеДанные;
	Если ТекущаяСтрока <> Неопределено Тогда
		гисРаботаСКартойКлиент.ТочечныеОбъектыСпозиционироваться(ВладелецФормы, ТекущаяСтрока.Широта, ТекущаяСтрока.Долгота);
		гисРаботаСКартойКлиент.ТочечныеОбъектыАнимацияВТочке(ВладелецФормы, ТекущаяСтрока.Широта, ТекущаяСтрока.Долгота);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПоискПоАдресу(Команда)  
	ПоискПоАдресуРезультаты.Очистить();
	НайденныеОбъекты = ПоискПоАдресуНаСервере(ПоискПоАдресуСтрокаПоиска);

	Если НайденныеОбъекты <> Неопределено Тогда
		Если НайденныеОбъекты.Количество() = 0 Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю("Ничего не найдено.");
		Иначе
			Для НомерСтроки = 0 По НайденныеОбъекты.Количество() - 1 Цикл
				СтрокаРезультата = ПоискПоАдресуРезультаты.Добавить();
				СтрокаРезультата.Долгота = НайденныеОбъекты[НомерСтроки].lon;
				СтрокаРезультата.Широта = НайденныеОбъекты[НомерСтроки].lat;
				СтрокаРезультата.Описание = НайденныеОбъекты[НомерСтроки].display_name;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПоискПоАдресуОчистить(Команда)
	ПоискПоАдресуРезультаты.Очистить();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПоискПоАдресуНаСервере(СтрокаПоиска)
	ПараметрыHttpGetЗапрос = "search?q=""" + СтрокаПоиска + """&format=json";

	Попытка
		ssl = Новый ЗащищенноеСоединениеOpenSSL();
		HttpСоединение = Новый HTTPСоединение("nominatim.openstreetmap.org",,,,,, ssl);
		ЗапросКСерверу = Новый HTTPЗапрос(ПараметрыHttpGetЗапрос);
		ОтветСервера = HttpСоединение.Получить(ЗапросКСерверу);
		Если ОтветСервера.КодСостояния <> 200 Тогда
			ОбщегоНазначения.СообщитьПользователю("Не удалось выполнить запрос геолокации! Сервер вернул HTTP код " + ОтветСервера.КодСостояния);
			Возврат Неопределено;
		КонецЕсли;
		ГеокодСтрока = ОтветСервера.ПолучитьТелоКакСтроку();
		Возврат гисРаботаСJSON.ПрочитатьНативно(ГеокодСтрока);
	Исключение
		ОбщегоНазначения.СообщитьПользователю("Не удалось выполнить запрос геолокации! Возможные причины: 
		| - нет доступа к интернет;
		| - сервер не отчечает;
		| - ответ некорректный." + Символы.ПС + Символы.ПС + ОписаниеОшибки());
		Возврат Неопределено;
	КонецПопытки;
КонецФункции

#КонецОбласти
