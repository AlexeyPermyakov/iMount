#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	// Значения реквизитов формы
	СоставНабораКонстантФормы = СоставНабораКонстант(НаборКонстант);
	ВнешниеРодительскиеКонстанты = РодительскиеКонстанты(СоставНабораКонстантФормы);
	
	РежимРаботы  = Новый Структура;
	РежимРаботы.Вставить("СоставНабораКонстантФормы",    Новый ФиксированнаяСтруктура(СоставНабораКонстантФормы));
	РежимРаботы.Вставить("ВнешниеРодительскиеКонстанты", Новый ФиксированнаяСтруктура(ВнешниеРодительскиеКонстанты));
	
	РежимРаботы = Новый ФиксированнаяСтруктура(РежимРаботы);
	
	ПолучитьМаксимальныйРазмерПередаваемогоФайла();
	
	Если НаборКонстант.ИспользоватьПрисоединенныеФайлы1СДокументооборота Тогда
		СпособХраненияПрисоединенныхФайлов = 1;
	ИначеЕсли НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота Тогда
		СпособХраненияПрисоединенныхФайлов = 2;
	Иначе
		СпособХраненияПрисоединенныхФайлов = 0;
	КонецЕсли;
	
	ОбновитьНастройкиОбновленияСвязанныхРеквизитов();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// Обновление состояния элементов
	УстановитьДоступность();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии()
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

&НаКлиенте
// Обработчик оповещения формы.
//
// Параметры:
//   ИмяСобытия - Строка - обрабатывается только событие Запись_НаборКонстант, генерируемое панелями администрирования.
//   Параметр   - Структура - содержит имена констант, подчиненных измененной константе, "вызвавшей" оповещение.
//   Источник   - Строка - имя измененной константы, "вызвавшей" оповещение.
//
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия <> "Запись_НаборКонстант" Тогда
		Возврат; // такие событие не обрабатываются
	КонецЕсли;
	
	// Если это изменена константа, расположенная в другой форме и влияющая на значения констант этой формы,
	// то прочитаем значения констант и обновим элементы этой формы.
	Если РежимРаботы.ВнешниеРодительскиеКонстанты.Свойство(Источник)
			Или (ТипЗнч(Параметр) = Тип("Структура")
			И ПолучитьОбщиеКлючиСтруктур(Параметр, РежимРаботы.ВнешниеРодительскиеКонстанты).Количество() > 0) Тогда
		
		Прочитать();
		УстановитьДоступность();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ДекорацияНастройкиАвторизацииНажатие(Элемент)
	
	ИмяФормыПараметров = "Обработка.ИнтеграцияС1СДокументооборот.Форма.АвторизацияВ1СДокументооборот";
	
	ОткрытьФорму(ИмяФормыПараметров,,ЭтотОбъект,,,,,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьИнтеграциюС1СДокументооборотПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура АдресВебСервиса1СДокументооборотПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьСвязанныеДокументы1СДокументооборотаПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПроцессыИЗадачи1СДокументооборотаПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьЕжедневныеОтчеты1СДокументооборотаПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьЭлектроннуюПочту1СДокументооборотаПриИзменении(Элемент)
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура СпособХраненияПрисоединенныхФайловПриИзменении(Элемент)
	
	Если СпособХраненияПрисоединенныхФайлов = 0 Тогда // не использовать ДО
		НаборКонстант.ИспользоватьПрисоединенныеФайлы1СДокументооборота = Ложь;
		НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота = Ложь;
		
	ИначеЕсли  СпособХраненияПрисоединенныхФайлов = 1 Тогда // файлы связанных объектов
		НаборКонстант.ИспользоватьПрисоединенныеФайлы1СДокументооборота = Истина;
		НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота = Ложь;
		
	Иначе // 2, файлы в папках
		НаборКонстант.ИспользоватьПрисоединенныеФайлы1СДокументооборота = Ложь;
		НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота = Истина;
		
	КонецЕсли;
	
	Подключаемый_ПриИзмененииРеквизита(Элемент);
		
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеКорневойПапкиФайлов1СДокументооборотНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПроверкаПодключенияЗавершение", ЭтотОбъект, Элемент);
	ИнтеграцияС1СДокументооборотКлиент.ПроверитьПодключение(
		ОписаниеОповещения,,, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаПодключенияЗавершение(Результат, ЭлементФормы) Экспорт
	
	Если Результат = Истина Тогда
		УстановитьКорневуюПапкуФайловДокументооборота(ЭлементФормы);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКорневуюПапкуФайловДокументооборота(Элемент)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ТипОбъектаВыбора", "DMFileFolder");
	ПараметрыФормы.Вставить("Отбор", 			Неопределено);
	ПараметрыФормы.Вставить("ВыбранныйЭлемент", НаборКонстант.ИдентификаторКорневойПапкиФайлов1СДокументооборот);
	ПараметрыФормы.Вставить("Заголовок", 		НСтр("ru = 'Выбор папки файлов'"));
	
	Оповещение = Новый ОписаниеОповещения("УстановитьКорневуюПапкуФайловДокументооборотаЗавершение", ЭтотОбъект, Элемент);
	
	ОткрытьФорму("Обработка.ИнтеграцияС1СДокументооборот.Форма.ВыборИзСписка", 
		ПараметрыФормы, ЭтотОбъект,,,, Оповещение, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеКорневойПапкиФайлов1СДокументооборотОчистка(Элемент, СтандартнаяОбработка)
	НаборКонстант.ИдентификаторКорневойПапкиФайлов1СДокументооборот = "";
	
	Подключаемый_ПриИзмененииРеквизита(Элемент, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборотПриИзменении(Элемент)
	Подключаемый_ПриИзмененииРеквизита(Элемент, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаНавигационнойСсылки(НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ИзменитьРасписание" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ДиалогНастройкиРасписанияЗавершение", ЭтотОбъект);
		
		ДиалогНастройкиРасписания = Новый ДиалогРасписанияРегламентногоЗадания(РасписаниеРегламентногоЗадания);
		ДиалогНастройкиРасписания.Показать(ОписаниеОповещения);
		
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "ВвестиИмяПользователяИПароль" Тогда
		
		СтандартнаяОбработка = Ложь;
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("ВызовДляПользователяЗаданияОбмена", Истина);
		
		ОткрытьФорму("Обработка.ИнтеграцияС1СДокументооборот.Форма.АвторизацияВ1СДокументооборот",
			ПараметрыФормы,
			ЭтотОбъект,,,,,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновлятьСвязанныеОбъектыАвтоматическиПриИзменении(Элемент)
	
	ОбновитьИспользованиеРегламентногоЗадания(ОбновлятьСвязанныеОбъектыАвтоматически);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ИнтегрируемыеОбъекты(Команда)
	
	ОткрытьФорму("Справочник.ПравилаИнтеграцииС1СДокументооборотом.Форма.ИнтегрируемыеОбъекты",, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПравилаИнтеграции(Команда)
	
	ОткрытьФорму("Справочник.ПравилаИнтеграцииС1СДокументооборотом.Форма.ФормаСписка",, ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Клиент

&НаКлиенте
Процедура ДиалогНастройкиРасписанияЗавершение(Результат, Параметры) Экспорт
	
	Если Результат <> Неопределено Тогда
		ОбновитьНастройкиОбновленияСвязанныхРеквизитов(Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступность(РеквизитПутьКДанным = "")
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьИнтеграциюС1СДокументооборот"
			Или РеквизитПутьКДанным = "" Тогда
		
		ЗначениеКонстанты = НаборКонстант.ИспользоватьИнтеграциюС1СДокументооборот;
		УстановитьДоступностьИспользованияИнтеграции(ЗначениеКонстанты);
		
		ЗначениеКонстанты = НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота;
		Элементы.НаименованиеКорневойПапкиФайлов1СДокументооборот.Доступность = ЗначениеКонстанты;
		
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота"
			Или РеквизитПутьКДанным = "СпособХраненияПрисоединенныхФайлов"
			Или РеквизитПутьКДанным = "" Тогда
		
		ЗначениеКонстанты = НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота;
		Элементы.НаименованиеКорневойПапкиФайлов1СДокументооборот.Доступность = ЗначениеКонстанты;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьИспользованияИнтеграции(Значение)
	
	Элементы.ГруппаПодключение.Доступность = Значение;
	Элементы.ИспользоватьПроцессыИЗадачи1СДокументооборота.Доступность = Значение;
	Элементы.ИспользоватьСвязанныеДокументы1СДокументооборота.Доступность = Значение;
	Элементы.ИспользоватьЕжедневныеОтчеты1СДокументооборота.Доступность = Значение;
	Элементы.ИспользоватьЭлектроннуюПочту1СДокументооборота.Доступность = Значение;
	Элементы.СпособХраненияПрисоединенныхФайлов.Доступность = Значение;
	Элементы.МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот.Доступность = Значение;
	Элементы.ИнтегрируемыеОбъекты.Доступность = Значение;
	Элементы.ПравилаИнтеграции.Доступность = Значение;
	Элементы.ОбновлятьСвязанныеОбъектыАвтоматически.Доступность = Значение;
	Элементы.ОписаниеНастройкиОбновления.Доступность = Значение;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьКорневуюПапкуФайловДокументооборотаЗавершение(Результат, Элемент) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда 
		НаборКонстант.НаименованиеКорневойПапкиФайлов1СДокументооборот  = Результат.РеквизитПредставление;
		НаборКонстант.ИдентификаторКорневойПапкиФайлов1СДокументооборот = Результат.РеквизитID;
	КонецЕсли;
	
	Подключаемый_ПриИзмененииРеквизита(Элемент, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	КонстантаИмя = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	Если КонстантаИмя = "ИспользоватьИнтеграциюС1СДокументооборот"
			Или КонстантаИмя = "АдресВебСервиса1СДокументооборот" Тогда
		Если Не НаборКонстант.ИспользоватьИнтеграциюС1СДокументооборот Тогда
			УстановитьДоступностьИспользованияИнтеграции(Ложь);
		Иначе
			Элементы.ГруппаПодключение.Доступность = Ложь;
		КонецЕсли;
	КонецЕсли;
	
	Если ОбновлятьИнтерфейс Тогда
		#Если Не ВебКлиент Тогда
			ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 1, Истина);
			ОбновитьИнтерфейс = Истина;
		#Иначе
			УстановитьДоступность();
		#КонецЕсли
	Иначе
		УстановитьДоступность();
	КонецЕсли;
	
	Если КонстантаИмя <> "" Тогда
		Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбновитьИнтерфейс();
	КонецЕсли;
	
	УстановитьДоступность();
	
КонецПроцедуры

#КонецОбласти

#Область ВызовСервера

&НаСервере
Процедура ОбновитьНастройкиОбновленияСвязанныхРеквизитов(Расписание = Неопределено)
	
	Если Не ПравоДоступа("Администрирование", Метаданные) Тогда
		Элементы.ГруппаАвтообновление.Доступность = Ложь;
		Возврат;
	КонецЕсли;
	
	Задание = РегламентныеЗаданияСервер.Задание(
		Метаданные.РегламентныеЗадания.ИнтеграцияС1СДокументооборотВыполнитьОбменДанными);
	
	Если Расписание <> Неопределено Тогда
		Задание.Расписание = Расписание;
		Задание.Записать();
	КонецЕсли;
	
	ОбновлятьСвязанныеОбъектыАвтоматически = Задание.Использование;
	РасписаниеРегламентногоЗадания = Задание.Расписание;
	
	МассивСтрок = Новый Массив;
	
	РасписаниеСтрокой = Строка(Задание.Расписание);
	Если Не СтрЗаканчиваетсяНа(РасписаниеСтрокой, ".") Тогда
		РасписаниеСтрокой = РасписаниеСтрокой + ".  ";
	Иначе
		РасписаниеСтрокой = РасписаниеСтрокой + "  ";
	КонецЕсли;
	МассивСтрок.Добавить(РасписаниеСтрокой);
	
	СтрокаСсылки = Новый ФорматированнаяСтрока(НСтр("ru = 'Изменить расписание'"),,,, "ИзменитьРасписание");
	МассивСтрок.Добавить(СтрокаСсылки);
	
	МассивСтрок.Добавить("  ");
	
	СтрокаСсылки = Новый ФорматированнаяСтрока(НСтр("ru = 'Задать служебного пользователя для обмена'"),,,, "ВвестиИмяПользователяИПароль");
	МассивСтрок.Добавить(СтрокаСсылки);
	
	ОписаниеНастройкиОбновления = Новый ФорматированнаяСтрока(МассивСтрок);
	
КонецПроцедуры

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
	
	Если КонстантаИмя = "ИспользоватьИнтеграциюС1СДокументооборот" Тогда
		ОбновитьНастройкиОбновленияСвязанныхРеквизитов();
	КонецЕсли;
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат КонстантаИмя;
	
КонецФункции

#КонецОбласти

#Область Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным, ПеречитыватьФорму = Истина)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат "";
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
		Если РеквизитПутьКДанным = "МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот" Тогда
			НаборКонстант.МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот =
				МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот * (1024*1024);
			КонстантаИмя = "МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот";
		КонецЕсли;
	КонецЕсли;
	
	// Сохранение значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		
		Если КонстантаМенеджер.Получить() <> КонстантаЗначение Тогда
			КонстантаМенеджер.Установить(КонстантаЗначение);
		КонецЕсли;
		
		Если ЕстьПодчиненныеКонстанты(КонстантаИмя, КонстантаЗначение) И ПеречитыватьФорму Тогда
			Прочитать();
		КонецЕсли;
		
	КонецЕсли;
	
	Если КонстантаИмя = "НаименованиеКорневойПапкиФайлов1СДокументооборот" Тогда
		КонстантаИмя = СохранитьЗначениеРеквизита("НаборКонстант.ИдентификаторКорневойПапкиФайлов1СДокументооборот");
	КонецЕсли;
	
	Если РеквизитПутьКДанным = "СпособХраненияПрисоединенныхФайлов" Тогда
		КонстантаИмя = СохранитьЗначениеРеквизита("НаборКонстант.ИспользоватьФайловоеХранилище1СДокументооборота", Ложь);
		КонстантаИмя = СохранитьЗначениеРеквизита("НаборКонстант.ИспользоватьПрисоединенныеФайлы1СДокументооборота");
	КонецЕсли;
	
	Возврат КонстантаИмя;
	
КонецФункции

&НаСервереБезКонтекста
Процедура ОбновитьИспользованиеРегламентногоЗадания(Использование)
	
	Задание = РегламентныеЗаданияСервер.Задание(
		Метаданные.РегламентныеЗадания.ИнтеграцияС1СДокументооборотВыполнитьОбменДанными);
	Задание.Использование = Использование;
	Задание.Записать();
	
КонецПроцедуры

#КонецОбласти

#Область Прочие

&НаСервере
Процедура ПолучитьМаксимальныйРазмерПередаваемогоФайла()
	
	МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот =
		НаборКонстант.МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот / (1024*1024);
	
	Если МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот = 0 Тогда
		МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот = 10; // мб
		СохранитьЗначениеРеквизита("МаксимальныйРазмерФайлаДляПередачиВ1СДокументооборот");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция СоставНабораКонстант(Набор)
	
	Результат = Новый Структура;
		
	Для Каждого МетаКонстанта Из Метаданные.Константы Цикл
		Если ЕстьРеквизитОбъекта(Набор, МетаКонстанта.Имя) Тогда
			Результат.Вставить(МетаКонстанта.Имя);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ЕстьРеквизитОбъекта(Объект, ИмяРеквизита)
	
	КлючУникальностиОбъекта = Новый УникальныйИдентификатор;
	СтруктураРеквизита = Новый Структура(ИмяРеквизита, КлючУникальностиОбъекта);
	
	ЗаполнитьЗначенияСвойств(СтруктураРеквизита, Объект);
	
	Возврат СтруктураРеквизита[ИмяРеквизита] <> КлючУникальностиОбъекта;
	
КонецФункции

&НаСервере
Функция ЕстьПодчиненныеКонстанты(ИмяРодительскойКонстанты, ЗначениеРодительскойКонстанты)
	
	ТаблицаКонстант = ИнтеграцияС1СДокументооборот.ЗависимостиКонстант();
	
	ПодчиненныеКонстанты = ТаблицаКонстант.НайтиСтроки(
		Новый Структура(
			"ИмяРодительскойКонстанты, ЗначениеРодительскойКонстанты",
			ИмяРодительскойКонстанты, ЗначениеРодительскойКонстанты));
	
	Возврат ПодчиненныеКонстанты.Количество() > 0;
	
КонецФункции

&НаСервере
Функция РодительскиеКонстанты(СтруктураПодчиненныхКонстант)
	
	Результат = Новый Структура;
	ТаблицаКонстант = ИнтеграцияС1СДокументооборот.ЗависимостиКонстант();
	
	Для Каждого ИскомаяКонстанта Из СтруктураПодчиненныхКонстант Цикл
		
		РодительскиеКонстанты = ТаблицаКонстант.НайтиСтроки(
			Новый Структура("ИмяПодчиненнойКонстанты", ИскомаяКонстанта.Ключ));
		
		Для Каждого СтрокаРодителя Из РодительскиеКонстанты Цикл
			
			Если Результат.Свойство(СтрокаРодителя.ИмяРодительскойКонстанты)
					Или СтруктураПодчиненныхКонстант.Свойство(СтрокаРодителя.ИмяРодительскойКонстанты) Тогда
				Продолжить;
			КонецЕсли;
			
			Результат.Вставить(СтрокаРодителя.ИмяРодительскойКонстанты);
			
			РодителиРодителя = РодительскиеКонстанты(Новый Структура(СтрокаРодителя.ИмяРодительскойКонстанты));
			
			Для Каждого РодительРодителя Из РодителиРодителя Цикл
				Результат.Вставить(РодительРодителя.Ключ);
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПолучитьОбщиеКлючиСтруктур(Структура1, Структура2)
	
	Результат = Новый Структура;
	
	Для Каждого КлючИЗначение Из Структура1 Цикл
		Если Структура2.Свойство(КлючИЗначение.Ключ) Тогда
			Результат.Вставить(КлючИЗначение.Ключ);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецОбласти
