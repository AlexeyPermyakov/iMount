
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(Параметры.Подпись) Тогда
		УстановитьОперандыПоТексту(Параметры.Подпись);
	КонецЕсли;
	
	Если Не Пользователи.ЭтоПолноправныйПользователь(Пользователи.ТекущийПользователь()) Тогда
		Если ЗначениеЗаполнено(Параметры.ТипСлояКарты) Тогда
			// форма вызвана из справочника слоев
			Этотобъект.ТолькоПросмотр = Не ПравоДоступа("Изменение", Метаданные.Справочники.гисСлоиКарты);
		Иначе // все остальные случаи
			Этотобъект.ТолькоПросмотр = Не ПравоДоступа("Изменение", Метаданные.Справочники.гисПоказатели);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОперандТекстПриИзменении(Элемент)
	Элементы.ТаблицаОперандов.ТекущиеДанные.Текст = ОперандТекст;
	УстановитьТекст();
КонецПроцедуры

&НаКлиенте
Процедура ОперандЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОткрытьФорму("Справочник.гисПоказатели.Форма.ВыборЗначения", Новый Структура("СлойКарты,ТипСлояКарты,Тематика,Значение", Параметры.СлойКарты, Параметры.ТипСлояКарты, Параметры.Тематика, ОперандЗначение), , , , , 
		Новый ОписаниеОповещения("ОперандЗначениеНачалоВыбораЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца)
КонецПроцедуры

&НаКлиенте
Процедура ОперандЗначениеНачалоВыбораЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено И ВыбранноеЗначение <> КодВозвратаДиалога.Отмена Тогда
		ОперандЗначение = ВыбранноеЗначение;
		ОперандЗначениеПриИзменении(Элементы.ОперандЗначение);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОперандЗначениеПриИзменении(Элемент)
	Элементы.ТаблицаОперандов.ТекущиеДанные.Значение = ОперандЗначение;
	УстановитьТекст();
КонецПроцедуры

&НаКлиенте
Процедура ОперандЦветНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	ОткрытьФорму("ОбщаяФорма.гисФормаВыбораЦветаRGB", Новый Структура("Цвет", ОперандЦвет), Элемент, , , , 
		Новый ОписаниеОповещения("ОперандЦветНачалоВыбораЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ОперандЦветНачалоВыбораЗавершение(ВыбранныеЦвет, ДополнительныеПараметры) Экспорт
	Если ТипЗнч(ВыбранныеЦвет) = Тип("Цвет") Тогда
		ОперандЦвет = ВыбранныеЦвет;
		Элементы.ТаблицаОперандов.ТекущиеДанные.Цвет = ОперандЦвет;
		УстановитьТекст();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОперандРазмерПриИзменении(Элемент)
	Элементы.ТаблицаОперандов.ТекущиеДанные.Размер = ОперандРазмер;
	УстановитьТекст();
КонецПроцедуры

&НаКлиенте
Процедура ОперандКурсивПриИзменении(Элемент)
	Элементы.ТаблицаОперандов.ТекущиеДанные.Курсив = ОперандКурсив;
	УстановитьТекст();
КонецПроцедуры

&НаКлиенте
Процедура ОперандЖирныйПриИзменении(Элемент)
	Элементы.ТаблицаОперандов.ТекущиеДанные.Жирный = ОперандЖирный;
	УстановитьТекст();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаОперандов

&НаКлиенте
Процедура ТаблицаОперандовПриИзменении(Элемент)
	УстановитьТекст();
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОперандовПриАктивизацииСтроки(Элемент)
	УстановитьТекст();
	Если Элементы.ТаблицаОперандов.ТекущиеДанные = Неопределено Или Элементы.ТаблицаОперандов.ТекущиеДанные.Операнд = "Перенос строки" Тогда
		Элементы.ГруппаЗначенияОперанда.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Элементы.ГруппаЗначенияОперанда.Видимость = Истина;
	ОперандТекст = Элементы.ТаблицаОперандов.ТекущиеДанные.Текст;
	ОперандЗначение = Элементы.ТаблицаОперандов.ТекущиеДанные.Значение;
	ОперандЦвет = Элементы.ТаблицаОперандов.ТекущиеДанные.Цвет;
	ОперандРазмер = Элементы.ТаблицаОперандов.ТекущиеДанные.Размер;
	ОперандЖирный = Элементы.ТаблицаОперандов.ТекущиеДанные.Жирный;
	ОперандКурсив = Элементы.ТаблицаОперандов.ТекущиеДанные.Курсив;
	
	Если Элементы.ТаблицаОперандов.ТекущиеДанные.Операнд = "Текст" Тогда
		Элементы.ОперандТекст.Видимость = Истина;
		Элементы.ОперандЗначение.Видимость = Ложь;
	Иначе
		Элементы.ОперандТекст.Видимость = Ложь;
		Элементы.ОперандЗначение.Видимость = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОперандовПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Если Копирование Тогда
		Отказ = Истина;
		НоваяСтрока = ТаблицаОперандов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Элементы.ТаблицаОперандов.ТекущиеДанные);
		Элементы.ТаблицаОперандов.ТекущаяСтрока = НоваяСтрока.ПолучитьИдентификатор();
		ТаблицаОперандовПриАктивизацииСтроки(Элементы.ТаблицаОперандов);
		Возврат;
	КонецЕсли;
	
	Отказ = Истина;
	
	СписокВыбора = Новый СписокЗначений;
	СписокВыбора.Добавить("Текст");
	СписокВыбора.Добавить("Значение");
	СписокВыбора.Добавить("Перенос строки");
	
	ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ТаблицаОперандовПередНачаломДобавленияЗавершение", ЭтотОбъект), СписокВыбора, Элементы.ТаблицаОперандов);
КонецПроцедуры

&НаКлиенте
Процедура ТаблицаОперандовПередНачаломДобавленияЗавершение(ВыбранноеЗначение, ДополнительныеПараметры) ЭКспорт
	Если ВыбранноеЗначение <> Неопределено Тогда
		НоваяСтрока = ТаблицаОперандов.Добавить();
		НоваяСтрока.Операнд = ВыбранноеЗначение.Значение;
		НоваяСтрока.Цвет = Новый Цвет(255, 255, 255);
		Элементы.ТаблицаОперандов.ТекущаяСтрока = НоваяСтрока.ПолучитьИдентификатор();
		ТаблицаОперандовПриАктивизацииСтроки(Элементы.ТаблицаОперандов);
		УстановитьТекст();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПрименитьИзменения(Команда)
	Отказ = Ложь;
	Для Номер = 0 По ТаблицаОперандов.Количество() - 1 Цикл
		Если ТаблицаОперандов[Номер].Операнд = "Значение" И ТаблицаОперандов[Номер].Значение = "" Тогда
			ОбщегоНазначенияКлиент.СообщитьПользователю("В строке " + Строка(Номер + 1) + " не выбрано значение операнда!", , "ТаблицаОперандов[" + Номер + "].Операнд", , Отказ);
		КонецЕсли;
	КонецЦикла;
	
	Если Не Отказ Тогда
		ПодписьПоказателя = СтрЗаменить(ПодписьПоказателя, ПолучитьФонДляТекущегоОперанда(), "");
		ПодписьПоказателя = СтрЗаменить(ПодписьПоказателя, "style=''", "");
		ЭтотОбъект.Закрыть(ПодписьПоказателя);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Функция ПолучитьФонДляТекущегоОперанда()
	Возврат "background-color:rgb(77, 116, 164);";
КонецФункции

&НаСервере
Процедура УстановитьТекстHtml()
	ТекстHtml = "<!DOCTYPE html><html><body style='background-color:rgb(127, 157, 195);color:white;'><div>" + ПодписьПоказателя + "</div></body></html>";
КонецПроцедуры

&НаСервере
Процедура УстановитьТекстНаСервере(ИдентификаторСтроки)
	Текст = "";
	Для Каждого СтрокаОперандов Из ТаблицаОперандов Цикл
		Если СтрокаОперандов.Операнд = "Перенос строки" Тогда
			Строка = "<br>";
		Иначе
			Если СтрокаОперандов.Операнд = "Текст" Тогда
				Строка = СтрокаОперандов.Текст;
			Иначе
				Строка = "[" + СтрокаОперандов.Значение + "]";
			КонецЕсли;
			
			СтрокаАтрибутов = "color='" + гисОбщегоНазначенияКлиентСервер.ПеревестиЦветВHEX(СтрокаОперандов.Цвет) + "'";
			
			Стиль = "";
			
			Если СтрокаОперандов.Жирный Тогда
				Стиль = "font-weight:bold;";
			КонецЕсли;
			Если СтрокаОперандов.Курсив Тогда
				Стиль = Стиль + "font-style:italic;";
			КонецЕсли;
			Если ЗначениеЗаполнено(СтрокаОперандов.Размер) Тогда
				Стиль = Стиль + "font-size:" + СтрокаОперандов.Размер + "px;";
			КонецЕсли;
			Если СтрокаОперандов.ПолучитьИдентификатор() = ИдентификаторСтроки Тогда
				Стиль = Стиль + ПолучитьФонДляТекущегоОперанда();
			КонецЕсли;
			
			Если ЗначениеЗаполнено(Стиль) Тогда
				СтрокаАтрибутов = СтрокаАтрибутов + ?(СтрокаАтрибутов = "", "", " ") + "style='" + Стиль + "'";
			КонецЕсли;
			
			Если ЗначениеЗаполнено(СтрокаАтрибутов) Тогда
				Строка = "<font " + СтрокаАтрибутов + ">" + Строка + "</font>";
			КонецЕсли;
		КонецЕсли;
		Текст = Текст + Строка;
	КонецЦикла;
	ПодписьПоказателя = Текст;
	УстановитьТекстHtml();
КонецПроцедуры

&НаКлиенте
Процедура УстановитьТекст()
	ИдентификаторСтроки = 0;
	Если Элементы.ТаблицаОперандов.ТекущиеДанные <> Неопределено Тогда
		ИдентификаторСтроки = Элементы.ТаблицаОперандов.ТекущиеДанные.ПолучитьИдентификатор();
	КонецЕсли;
	УстановитьТекстНаСервере(ИдентификаторСтроки);
КонецПроцедуры

&НаСервере
Процедура УстановитьОперандыПоТекстуРазобратьFont(СтрокаFont)
	СтрокаОперанда = Сред(СтрокаFont, Найти(СтрокаFont, ">") + 1, Найти(СтрокаFont, "</font>") - Найти(СтрокаFont, ">") - 1);
	СтрокаАтрибутов = Сред(СтрокаFont, 6, Найти(СтрокаFont, ">") - 6);
	
	НоваяСтрока = ТаблицаОперандов.Добавить();
	НоваяСтрока.Операнд = ?(Лев(СтрокаОперанда, 1) = "[", "Значение", "Текст");
	Если НоваяСтрока.Операнд = "Текст" Тогда
		НоваяСтрока.Текст = СтрокаОперанда;
	Иначе
		НоваяСтрока.Значение = Сред(СтрокаОперанда, 2, СтрДлина(СтрокаОперанда) - 2);
	КонецЕсли;
	
	Если Найти(СтрокаАтрибутов, "color='") > 0 Тогда
		СтрокаЦвет = Сред(СтрокаАтрибутов, Найти(СтрокаАтрибутов, "color='") + 7, 7);
		НоваяСтрока.Цвет = гисОбщегоНазначенияКлиентСервер.ПеревестиHEXВЦвет(СтрокаЦвет);
	Иначе
		НоваяСтрока.Цвет = Новый Цвет(255, 255, 255);
	КонецЕсли;
	
	ПозицияСтиля = Найти(СтрокаАтрибутов, "style='");
	Если ПозицияСтиля > 0 Тогда
		Стиль = Сред(СтрокаАтрибутов, ПозицияСтиля + 7);
		Стиль = Лев(Стиль, Найти(Стиль, "'") - 1);
		
		Если Найти(Стиль, "font-weight:bold;") > 0 Тогда
			НоваяСтрока.Жирный = Истина;
		КонецЕсли;
		Если Найти(Стиль, "font-style:italic;") > 0 Тогда
			НоваяСтрока.Курсив = Истина;
		КонецЕсли;
		Если Найти(Стиль, "font-size:") > 0 Тогда
			Размер = Сред(Стиль, Найти(Стиль, "font-size:") + 10);
			Размер = Лев(Размер, Найти(Размер, ";") - 3);
			НоваяСтрока.Размер = Размер;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура УстановитьОперандыПоТексту(Знач Подпись)
	ПодписьПоказателя = Подпись;
	УстановитьТекстHtml();
	Пока СтрДлина(Подпись) > 0 Цикл
		Если Лев(Подпись, 4) = "<br>" Тогда
			Подпись = Сред(Подпись, 5);
			
			НоваяСтрока = ТаблицаОперандов.Добавить();
			НоваяСтрока.Операнд = "Перенос строки";
		ИначеЕсли Лев(Подпись, 5) = "<font" Тогда
			СтрокаFont = Сред(Подпись, 0, Найти(Подпись, "</font>") + 6);
			Подпись = Сред(Подпись, Найти(Подпись, "</font>") + 7);
			
			УстановитьОперандыПоТекстуРазобратьFont(СтрокаFont);
		ИначеЕсли Лев(Подпись, 1) = "[" Тогда
			Строка = Сред(Подпись, 1, Найти(Подпись, "]"));
			Подпись = Сред(Подпись, Найти(Подпись, "]") + 1);
			
			НоваяСтрока = ТаблицаОперандов.Добавить();
			НоваяСтрока.Операнд = "Значение";
			НоваяСтрока.Значение = Сред(Строка, 2, СтрДлина(Строка) - 2);
		Иначе
			НомерСтроки1 = Найти(Подпись, "<");
			НомерСтроки2 = Найти(Подпись, "[");
			
			Если НомерСтроки1 = 0 И НомерСтроки2 > 0 Тогда
				НомерСтроки = НомерСтроки2;
			ИначеЕсли НомерСтроки2 = 0 И НомерСтроки1 > 0 Тогда
				НомерСтроки = НомерСтроки1;
			ИначеЕсли НомерСтроки1 > 0 И НомерСтроки2 > 0 Тогда
				НомерСтроки = ?(НомерСтроки1 < НомерСтроки2, НомерСтроки1, НомерСтроки2);
			Иначе
				НомерСтроки = 0;
			КонецЕсли;
			
			Если НомерСтроки = 0 Тогда
				Подпись = "";
				
				НоваяСтрока = ТаблицаОперандов.Добавить();
				НоваяСтрока.Операнд = "Текст";
				НоваяСтрока.Текст = Подпись;
			Иначе
				Строка = Лев(Подпись, НомерСтроки - 1);
				Подпись = Сред(Подпись, НомерСтроки);
				
				НоваяСтрока = ТаблицаОперандов.Добавить();
				НоваяСтрока.Операнд = "Текст";
				НоваяСтрока.Текст = Строка;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

#КонецОбласти
