

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область ПрограммныйИнтерфейсОбработчикиСобытийФорм

Процедура ПередНачаломИзменения(Элемент, Отказ, Форма) Экспорт
	
	Если Элемент.Имя = лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыРеквизитов() Тогда
		ПередНачаломИзмененияСоставаСтруктуры(Элемент, Отказ, Форма);	
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередНачаломДобавления(Элемент, Отказ, Копирование, Форма) Экспорт
	
	Отказ = Истина;
	
	Если Элемент.Имя = лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыРеквизитов() Тогда
		ОткрытьФорму("ОбщаяФорма.лм_КарточкаРеквизита", СформироватьСтруктуруНовогоРеквизита(Форма),,Истина);
	КонецЕсли;	
	
КонецПроцедуры

Процедура НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма) Экспорт
	
	лм_УниверсальныеСтруктурыДанныхКлиентПереопределяемый.НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка, Форма);
	
КонецПроцедуры

Процедура ДобавитьИзменитьДанныеРеквизитаУниверсальнойСтруктуры(ИмяСобытия, Параметры, Форма) Экспорт
		
	Если ИмяСобытия = "лм_УниверсальныеСтруктурыДанных_ЗаписьРеквизита"
		И Параметры.ИдентификаторФормыВладельца = Форма.УникальныйИдентификатор Тогда
		
		Форма.Модифицированность = Истина;
		Отбор = Новый Структура("Идентификатор", Параметры.Идентификатор);
		СтрокиОтбора = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыРеквизитов()].НайтиСтроки(Отбор);
		
		Если СтрокиОтбора.Количество() = 0 Тогда
			СтрокаРеквизита = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыРеквизитов()].Добавить();
		Иначе
			СтрокаРеквизита = СтрокиОтбора[0];
		КонецЕсли;
		
		Если Параметры.Свойство("Нередактируемый") И НЕ Параметры.Нередактируемый Тогда
			ЗаполнитьЗначенияСвойств(СтрокаРеквизита, Параметры);
			СтрокаРеквизита.ПредставлениеТипаЗначения = лм_УниверсальныеСтруктурыДанныхКлиентСервер.ПолучитьПредставлениеТипаЗначения(Параметры.ТипЗначения, Параметры.ВидСправочника);
			
			ПерезаполнитьЗависимостиРеквизита(Параметры, Форма);
			ПерезаполнитьСвойстваРеквизитовСтруктуры(Параметры, Форма);
			ПерезаполнитьЗависимостиСвойствРеквизитовСтруктуры(Параметры, Форма);
		КонецЕсли;
		
		Если Параметры.Свойство("ЗаполнитьПоДаннымПредмета")
			И ТипЗнч(Форма.Объект.Ссылка) = Тип("СправочникСсылка.лм_ШаблоныБизнесПроцессов") Тогда
			
			// Очистим.
			НайденныеСтроки = Форма.РеквизитыЗаполняемыеИзПредмета.НайтиСтроки(Новый Структура("ИмяПоля, Идентификатор", СтрокаРеквизита.ИмяПоля, СтрокаРеквизита.Идентификатор));
			Для Каждого НайденнаяСтрока из НайденныеСтроки Цикл
				Форма.РеквизитыЗаполняемыеИзПредмета.Удалить(НайденнаяСтрока);
			КонецЦикла; 
			
			// Добавим.
			Для Каждого ЭлементСписка из Параметры.ЗаполнитьПоДаннымПредмета Цикл
				НоваяСтрока = Форма.РеквизитыЗаполняемыеИзПредмета.Добавить();
				НоваяСтрока.ИдентификаторТочки 	= ЭлементСписка.Значение;
				НоваяСтрока.ИмяПоля 			= СтрокаРеквизита.ИмяПоля;
				НоваяСтрока.Идентификатор 		= СтрокаРеквизита.Идентификатор;
				НоваяСтрока.НаименованиеТочки 	= ЭлементСписка.Представление;
			КонецЦикла;
			
			СтрокаРеквизита.ЗаполнитьПоДаннымПредмета = Параметры.ЗаполнитьПоДаннымПредмета;
		КонецЕсли;
		
		//Если Форма.лмЭтоОсновнаяСтруктура Тогда
			//ДанныеСтруктуры = СформироватьДанныеУниверсальнойСтруктуры(Форма);
			//лм_УниверсальныеСтруктурыДанныхВызовСервера.ЗаписатьУниверсальнуюСтруктуру(ДанныеСтруктуры);
			//ЗаписатьДанныеСтруктуры(Форма);
			
		//КонецЕсли;
	КонецЕсли;	
	
КонецПроцедуры	

Процедура ПриАктивизацииСтрокиСпискаСтруктур(Элемент, Форма) Экспорт
	
	ИдентификаторСтруктуры = Элемент.ТекущиеДанные.Идентификатор;
	
	Если ИдентификаторСтруктуры <> Неопределено Тогда
		лм_УниверсальныеСтруктурыДанныхКлиентСервер.ВывестиДанныеСтруктуры(ИдентификаторСтруктуры, Форма);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередНачаломДобавленияСтрокиСпискаСтруктур(Элемент, Отказ, Копирование, Форма) Экспорт
	
	Отказ             = Истина;
	ДанныеСтруктуры   = лм_УниверсальныеСтруктурыДанныхКлиентСервер.ПодготовитьДанныеСтруктуры();
	лм_УниверсальныеСтруктурыДанныхВызовСервера.ЗаписатьУниверсальнуюСтруктуру(ДанныеСтруктуры);	
	Стр               = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяСпискаСтруктур()].Добавить();
	Стр.Идентификатор = ДанныеСтруктуры.ИдентификаторСтруктуры;
	
КонецПроцедуры

Процедура ПриИзмененииСтрокиСпискаСтруктур(Элемент, ЭтаФорма) Экспорт
	
	Идентификатор = Элемент.ТекущиеДанные.Идентификатор;
	
	Если Идентификатор <> Неопределено Тогда
		УниверсальнаяСтруктура = лм_УниверсальныеСтруктурыДанныхВызовСервера.ПолучитьДанныеУниверсальнойСтруктуры(Идентификатор);	
		УниверсальнаяСтруктура.Наименование = Элемент.ТекущиеДанные.Наименование;
		лм_УниверсальныеСтруктурыДанныхВызовСервера.ЗаписатьУниверсальнуюСтруктуру(УниверсальнаяСтруктура);
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбновитьЗависимостиРеквизитовУниверсальнойСтруктуры(Форма, СоответствиеЗависимых) Экспорт
	
	ДанныеЗависимостей = лм_УниверсальныеСтруктурыДанныхКлиентСервер.ПолучитьДанныеЗависимостей(Форма, СоответствиеЗависимых);
	
	СоответствиеДобавляемых = Новый Соответствие;
	Для Каждого ДанныеЗависимости Из ДанныеЗависимостей Цикл
		Если ДанныеЗависимости.Значение.Видимость = Истина И Форма.Элементы.Найти(ДанныеЗависимости.Ключ) = Неопределено Тогда
			СоответствиеДобавляемых.Вставить(Сред(ДанныеЗависимости.Ключ, 4), Истина);
		КонецЕсли;
	КонецЦикла;
	
	Если СоответствиеДобавляемых.Количество() <> 0 Тогда
		Оповестить("СозданиеЭлементов", СоответствиеДобавляемых);		
	КонецЕсли;
	
	Для Каждого ДанныеЗависимости Из ДанныеЗависимостей Цикл
		Если Форма.Элементы.Найти(ДанныеЗависимости.Ключ) = Неопределено Тогда
			Продолжить;	
		КонецЕсли;
		Элемент = Форма.Элементы[ДанныеЗависимости.Ключ];
		Элемент.ОтметкаНезаполненного = ДанныеЗависимости.Значение.АвтоОтметкаНезаполненного;
		ЗаполнитьЗначенияСвойств(Элемент, ДанныеЗависимости.Значение);
	КонецЦикла;
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("лм_УправлениеБизнесПроцессами") И Форма.ИмяФормы = "БизнесПроцесс.лм_БизнесПроцесс.Форма.ДействиеВыполнить" Тогда
		МодульБизнесПроцессыКлиентСервер = ОбщегоНазначенияКлиент.ОбщийМодуль("лм_БизнесПроцессыКлиентСервер");
		МодульБизнесПроцессыКлиентСервер.НастроитьОтображениеЭлементовФормыЗадачи(Форма);
	КонецЕсли;
	
	лм_УниверсальныеСтруктурыДанныхКлиентПереопределяемый.ПриОбновленииЗависимостейРеквизитовУниверсальнойСтруктуры(Форма);
		
КонецПроцедуры

Процедура ЗаписатьДанныеСтруктуры(Форма) Экспорт
	
	ДанныеСтруктурыИнициализированы = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяРеквизитаДанныеСтруктурыИнициализированы()];
	
	ЭтоНоваяСтруктура = лм_УниверсальныеСтруктурыДанныхВызовСервера.ПроверитьСуществованиеУниверсальнойСтруктуры(Форма.лмИдентификаторСтруктуры);
	
	Если ДанныеСтруктурыИнициализированы ИЛИ ЭтоНоваяСтруктура Тогда
		ДанныеСтруктуры = СформироватьДанныеУниверсальнойСтруктуры(Форма);
		лм_УниверсальныеСтруктурыДанныхВызовСервера.ЗаписатьУниверсальнуюСтруктуру(ДанныеСтруктуры);
		Форма.лмИдентификаторСтруктуры = ДанныеСтруктуры.ИдентификаторСтруктуры;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПередНачаломИзмененияСоставаСтруктуры(Элемент, Отказ, Форма)
	
	Отказ = Истина;
	ТекущиеДанные = Элемент.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
			
		// Открытие формы свойства.
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Идентификатор",               ТекущиеДанные.Идентификатор);
		ПараметрыФормы.Вставить("ИмяПоля",                     ТекущиеДанные.ИмяПоля);
		ПараметрыФормы.Вставить("Синоним",            	       ТекущиеДанные.Синоним);
		ПараметрыФормы.Вставить("ТипЗначения",            	   ТекущиеДанные.ТипЗначения);
		ПараметрыФормы.Вставить("МногострочноеПолеВвода",      ТекущиеДанные.МногострочноеПолеВвода);
		ПараметрыФормы.Вставить("ВыводитьВВидеГиперссылки",    ТекущиеДанные.ВыводитьВВидеГиперссылки);
		ПараметрыФормы.Вставить("Подсказка",    			   ТекущиеДанные.Подсказка);				
		ПараметрыФормы.Вставить("Комментарий",    			   ТекущиеДанные.Комментарий);				
		ПараметрыФормы.Вставить("ФорматСвойства",    		   ТекущиеДанные.ФорматСвойства);				
		ПараметрыФормы.Вставить("ЗаполнятьОбязательно",    	   ТекущиеДанные.ЗаполнятьОбязательно);
		ПараметрыФормы.Вставить("Нередактируемый",             ТекущиеДанные.Нередактируемый);	
		ПараметрыФормы.Вставить("Метка",                       ТекущиеДанные.Метка);		
		ПараметрыФормы.Вставить("ВидСправочника",              ТекущиеДанные.ВидСправочника);
		ПараметрыФормы.Вставить("РеквизитыСтруктуры",          СформироватьМассивРеквизитовСтруктуры(Форма));
		ПараметрыФормы.Вставить("ИдентификаторФормыВладельца", Форма.УникальныйИдентификатор);
		ПараметрыФормы.Вставить("ЗависимостиРеквизитов",       ПолучитьМассивЗависимостейРеквизита(ТекущиеДанные.Идентификатор, Форма));		
		ПараметрыФормы.Вставить("СвойстваРеквизитов",          ПолучитьМассивСвойствРеквизита(ТекущиеДанные.Идентификатор, Форма));		
		ПараметрыФормы.Вставить("ЗависимостиСвойств",          ПолучитьМассивЗависимостейСвойствРеквизита(ТекущиеДанные.Идентификатор, Форма));				
		ПараметрыФормы.Вставить("ЭтоОсновнаяСтруктура",        Форма.лмЭтоОсновнаяСтруктура);		
		
		Если ТипЗнч(Форма.Объект.Ссылка) = Тип("СправочникСсылка.лм_ШаблоныБизнесПроцессов") Тогда
			НайденныеСтроки = Форма.РеквизитыЗаполняемыеИзПредмета.НайтиСтроки(Новый Структура("ИмяПоля, Идентификатор", ТекущиеДанные.ИмяПоля, ТекущиеДанные.Идентификатор));
			
			ЗаполнитьПоДаннымПредмета = Новый СписокЗначений;
			Для Каждого НайденнаяСтрока из НайденныеСтроки Цикл
				ЗаполнитьПоДаннымПредмета.Добавить(НайденнаяСтрока.ИдентификаторТочки, НайденнаяСтрока.НаименованиеТочки);
			КонецЦикла;
			
			ПараметрыФормы.Вставить("ЗаполнитьПоДаннымПредмета",   ЗаполнитьПоДаннымПредмета);
			
			СписокТочекДействия = Новый СписокЗначений;
			Для Каждого ТочкаБП Из Форма.ТочкиМаршрута Цикл
				Если ТочкаБП.ТипТочки = ПредопределенноеЗначение("Перечисление.лм_ТипыТочекБизнесПроцессов.ТочкаДействия") Тогда				
					СписокТочекДействия.Добавить(ТочкаБП.ИдентификаторТочки, ТочкаБП.НаименованиеТочки);
				КонецЕсли;
			КонецЦикла;
			ПараметрыФормы.Вставить("СписокТочекДействия", СписокТочекДействия);
		КонецЕсли;
		
		ОткрытьФорму("ОбщаяФорма.лм_КарточкаРеквизита", ПараметрыФормы,,Истина);			
	КонецЕсли;
	
КонецПроцедуры

Функция СформироватьСтруктуруНовогоРеквизита(Форма)
	
	СтруктураРеквизита = Новый Структура;
	
	СтруктураРеквизита.Вставить("Идентификатор",               Новый УникальныйИдентификатор);
	СтруктураРеквизита.Вставить("ИмяПоля",                     "");
	СтруктураРеквизита.Вставить("Синоним",                     "");
	СтруктураРеквизита.Вставить("ТипЗначения",                 Новый ОписаниеТипов("Строка"));
	СтруктураРеквизита.Вставить("МногострочноеПолеВвода",      0);
	СтруктураРеквизита.Вставить("РеквизитыСтруктуры",          СформироватьМассивРеквизитовСтруктуры(Форма));
	СтруктураРеквизита.Вставить("ИдентификаторФормыВладельца", Форма.УникальныйИдентификатор);	
	СтруктураРеквизита.Вставить("ВыводитьВВидеГиперссылки",    Ложь);
	СтруктураРеквизита.Вставить("ЗаполнятьОбязательно",        Ложь);
	СтруктураРеквизита.Вставить("Подсказка",                   "");
	СтруктураРеквизита.Вставить("Комментарий",                 "");
	СтруктураРеквизита.Вставить("ФорматСвойства",              "");
	СтруктураРеквизита.Вставить("ЭтоОсновнаяСтруктура",        Форма.лмЭтоОсновнаяСтруктура);		
	СтруктураРеквизита.Вставить("Нередактируемый",             Ложь);		
	СтруктураРеквизита.Вставить("Динамический",                Ложь);		
	СтруктураРеквизита.Вставить("Метка",                       "");		
	СтруктураРеквизита.Вставить("ВидСправочника",              Неопределено);		
	
	Возврат СтруктураРеквизита;
	
КонецФункции

Функция СформироватьМассивРеквизитовСтруктуры(Форма)
	
	МассивРеквизитов = Новый Массив;
	
	Для Каждого Стр Из Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыРеквизитов()] Цикл
		стрТаблица = Новый Структура("Идентификатор,Реквизит,Представление,ТипЗначения,НомерКартинки,РежимВыбора", Стр.Идентификатор, Стр.ИмяПоля, Стр.Синоним, Стр.ТипЗначения, 1, "Элементы");
		МассивРеквизитов.Добавить(стрТаблица);
	КонецЦикла;
	
	Возврат МассивРеквизитов;
	
КонецФункции

Процедура ПерезаполнитьЗависимостиРеквизита(Параметры, Форма)
	
	ЗависимостиРеквизитов  = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыЗависимостей()];
	
	Отбор        = Новый Структура("Идентификатор", Параметры.Идентификатор);
	СтрокиОтбора = ЗависимостиРеквизитов.НайтиСтроки(Отбор);
	
	Для Каждого Стр Из СтрокиОтбора Цикл
		ЗависимостиРеквизитов.Удалить(Стр);
	КонецЦикла;
	
	Для Каждого Стр Из Параметры.ЗависимостиРеквизитов Цикл
		НоваяСтрока = ЗависимостиРеквизитов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Стр);
		НоваяСтрока.Идентификатор = Параметры.Идентификатор;
	КонецЦикла;
		
КонецПроцедуры

Процедура ПерезаполнитьСвойстваРеквизитовСтруктуры(Параметры, Форма)
	
	Если Не Форма.лмЭтоОсновнаяСтруктура Тогда
		Возврат;	
	КонецЕсли;
	
	СвойстваРеквизитов = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыСвойствРеквизитов()];
	
	Отбор        = Новый Структура("ОсновнойИдентификатор", Параметры.Идентификатор);
	СтрокиОтбора = СвойстваРеквизитов.НайтиСтроки(Отбор);
	
	Для Каждого Стр Из СтрокиОтбора Цикл
		СвойстваРеквизитов.Удалить(Стр);	
	КонецЦикла;
	
	Для Каждого Стр Из Параметры.СвойстваРеквизитов Цикл
		НоваяСтрока = СвойстваРеквизитов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Стр);
		НоваяСтрока.ОсновнойИдентификатор = Параметры.Идентификатор;
	КонецЦикла;	
	
КонецПроцедуры

Процедура ПерезаполнитьЗависимостиСвойствРеквизитовСтруктуры(Параметры, Форма)
	
	Если Не Форма.лмЭтоОсновнаяСтруктура Тогда
		Возврат;	
	КонецЕсли;
	
	ЗависимостиСвойств = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыЗависимостейСвойствРеквизитов()];
		
	Отбор        = Новый Структура("ОсновнойИдентификатор", Параметры.Идентификатор);
	СтрокиОтбора = ЗависимостиСвойств.НайтиСтроки(Отбор);
	
	Для Каждого Стр Из СтрокиОтбора Цикл
		ЗависимостиСвойств.Удалить(Стр);	
	КонецЦикла;
	
	Для Каждого Стр Из Параметры.ЗависимостиСвойств Цикл
		НоваяСтрока = ЗависимостиСвойств.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Стр);
		НоваяСтрока.ОсновнойИдентификатор = Параметры.Идентификатор;
	КонецЦикла;	
		
КонецПроцедуры

Функция ПолучитьМассивЗависимостейРеквизита(Идентификатор, Форма)
	
	Отбор        = Новый Структура("Идентификатор", Идентификатор);
	СтрокиОтбора = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыЗависимостей()].НайтиСтроки(Отбор);
	
	МассивЗависимостей = Новый Массив;
	
	Для Каждого Стр Из СтрокиОтбора  Цикл
		стрЗависимость = лм_УниверсальныеСтруктурыДанныхКлиентСервер.СформироватьСтруктуруЗависимостиРеквизита();
		ЗаполнитьЗначенияСвойств(стрЗависимость, Стр);
		МассивЗависимостей.Добавить(стрЗависимость);
	КонецЦикла;
	
	Возврат МассивЗависимостей;
	
КонецФункции

Функция ПолучитьМассивСвойствРеквизита(Идентификатор, Форма)
	
	МассивСвойств = Новый Массив;
	
	Если Не Форма.лмЭтоОсновнаяСтруктура Тогда
		Возврат МассивСвойств;	
	КонецЕсли;
	
	Отбор        = Новый Структура("ОсновнойИдентификатор", Идентификатор);
	СтрокиОтбора = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыСвойствРеквизитов()].НайтиСтроки(Отбор);
		
	Для Каждого Стр Из СтрокиОтбора  Цикл
		стрСвойствоРеквизита = лм_УниверсальныеСтруктурыДанныхКлиентСервер.СформироватьСтруктуруСвойстваРеквизита();
		ЗаполнитьЗначенияСвойств(стрСвойствоРеквизита, Стр);
		МассивСвойств.Добавить(стрСвойствоРеквизита);
	КонецЦикла;
	
	Возврат МассивСвойств;
		
КонецФункции

Функция ПолучитьМассивЗависимостейСвойствРеквизита(Идентификатор, Форма)
	
	МассивЗависимостей = Новый Массив;
	
	Если Не Форма.лмЭтоОсновнаяСтруктура Тогда
		Возврат МассивЗависимостей;	
	КонецЕсли;
	
	Отбор        = Новый Структура("ОсновнойИдентификатор", Идентификатор);
	СтрокиОтбора = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыЗависимостейСвойствРеквизитов()].НайтиСтроки(Отбор);
		
	Для Каждого Стр Из СтрокиОтбора  Цикл
		стрЗависимостьСвойства = Новый Структура("Представление,Условие,Значение,Реквизит,ТипЗначения,ЗависимоеСвойство,РежимВыбора,Идентификатор");
		ЗаполнитьЗначенияСвойств(стрЗависимостьСвойства, Стр);
		МассивЗависимостей.Добавить(стрЗависимостьСвойства);
	КонецЦикла;
	
	Возврат МассивЗависимостей;
			
КонецФункции

Функция СформироватьДанныеУниверсальнойСтруктуры(Форма) Экспорт
	
	ДанныеСтруктуры    = Новый Структура;		
	МассивРеквизитов   = Новый Массив;
	МассивЗависимостей = Новый Массив;
	
	ТаблицаРеквизитов = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыРеквизитов()];	
	ЗаполнитьМассивПоТаблице(МассивРеквизитов, ТаблицаРеквизитов, "Реквизит");
	ТаблицаРеквизитов = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыСвойствРеквизитов()];	
	ЗаполнитьМассивПоТаблице(МассивРеквизитов, ТаблицаРеквизитов, "Реквизит");
	ДанныеСтруктуры.Вставить("Реквизиты", МассивРеквизитов);
	
	ТаблицаЗависимостей = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыЗависимостей()];
	ЗаполнитьМассивПоТаблице(МассивЗависимостей, ТаблицаЗависимостей, "Зависимость");
	ТаблицаЗависимостей = Форма[лм_УниверсальныеСтруктурыДанныхКлиентСервер.ИмяТаблицыЗависимостейСвойствРеквизитов()];
	ЗаполнитьМассивПоТаблице(МассивЗависимостей, ТаблицаЗависимостей, "Зависимость");
	ДанныеСтруктуры.Вставить("ЗависимостиРеквизитов", МассивЗависимостей);
		
	ДанныеСтруктуры.Вставить("ИдентификаторСтруктуры", Форма.лмИдентификаторСтруктуры);
	ДанныеСтруктуры.Вставить("ВладелецСтруктуры",      Форма.лмВладелецСтруктуры);
	ДанныеСтруктуры.Вставить("Имя",           		   Форма.лмИмяСтруктуры);
		
	Возврат ДанныеСтруктуры;
	
КонецФункции

Процедура ЗаполнитьМассивПоТаблице(ЗаполняемыйМассив, Таблица, ТипСтруктуры)
	
	Для Каждого Стр Из Таблица Цикл
		Если ТипСтруктуры = "Реквизит" Тогда
			Стк = лм_УниверсальныеСтруктурыДанныхКлиентСервер.СформироватьСтруктуруСвойстваРеквизита();
		ИначеЕсли ТипСтруктуры = "Зависимость" Тогда
			Стк = лм_УниверсальныеСтруктурыДанныхКлиентСервер.СформироватьСтруктуруЗависимостиРеквизита();
		КонецЕсли;
			
		Стк.Вставить("ОсновнойИдентификатор", "");
		ЗаполнитьЗначенияСвойств(Стк, Стр);
		ЗаполняемыйМассив.Добавить(Стк);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
