
#Область ПрограммныйИнтерфейс

Процедура ЗаполнитьРасширенныеНастройки(РасширенныеНастройки) Экспорт
	
// Подсистема MDMЯдро
	РаботаСБизнесПроцессамиКлиентСервер.ПриЗаполненииРасширенныхНастроек(РасширенныеНастройки)
// Конец Подсистема MDMЯдро

КонецПроцедуры

Функция ИмяТаблицыДанных() Экспорт
	
	Возврат "лм_СоставДанных";
	
КонецФункции

Функция ИмяТаблицыПодпроцессов() Экспорт
	
	Возврат "лм_ЗапущенныеПодпроцессы";
	
КонецФункции

Функция ИмяРеквизитаВариантСортировкиАтрибутовСправочникаНСИ() Экспорт
	
	Возврат "лм_ВариантСортировкиАтрибутовСправочникаНСИ";
		
КонецФункции

Функция ОбработчикиПолейТаблиц() Экспорт
	
	Результат = Новый Массив;
	
	// ТочкаПереопределения			
	Возврат Результат;
	
КонецФункции

Процедура УстановитьОтображениеСоставаДанных(СоставДанных, ТаблицаНастроекОтображения) Экспорт
	
	СоответствиеНастроек = Новый Соответствие;
	
	Для Каждого Стр Из ТаблицаНастроекОтображения Цикл
		СоответствиеНастроек.Вставить(Стр.ИмяРеквизита, Стр);
	КонецЦикла;
	
	Для Каждого СтрТЗ Из СоставДанных Цикл
		Стр = СоответствиеНастроек[СтрТЗ.ИмяРеквизита];
		Если Стр <> Неопределено Тогда
			Если Стр.Видимость <> 2 Тогда
				СтрТЗ.Видимость = Стр.Видимость;
			КонецЕсли;
			Если Стр.Доступность <> 2 Тогда
				СтрТЗ.Доступность = Стр.Доступность;
			КонецЕсли;
			Если Стр.Обязательность <> 2 Тогда
				СтрТЗ.АвтоОтметкаНезаполненного = Стр.Обязательность;
			КонецЕсли;
			СтрТЗ.ТолькоПросмотр = Стр.ТолькоПросмотр;			
		КонецЕсли;
	КонецЦикла;
		
КонецПроцедуры

Функция ДобавитьСтрокуСоставаДанных(Форма, СоставДанных, Реквизит, МассивДоступныхТиповДляПодпроцессов, ТаблицаПодпроцессов, стрДанныеПредмета, ДополнительныеПараметры = Неопределено) Экспорт

	ИмяРеквизитаФормы          = "лм_" + Реквизит.ИмяПоля;
	СтрокаСостава              = СоставДанных.Добавить();
	СтрокаСостава.ИмяРеквизита = ИмяРеквизитаФормы;
	СтрокаСостава.Наименование = Реквизит.Синоним;
	
	Если СтрНачинаетсяС(ИмяРеквизитаФормы, "лм_" + УправлениеНСИКлиентСервер.ВидДанныхДополнительноеСвойство()) Тогда
		СтрокаСостава.ТипЗначения = Новый ОписаниеТипов(Реквизит.ТипЗначения,, "СправочникСсылка.ИдентификаторыОбъектовМетаданных")
	Иначе
		СтрокаСостава.ТипЗначения = Реквизит.ТипЗначения;
	КонецЕсли;
	
	СтрокаСостава.ТекущееЗначение           = ?(стрДанныеПредмета.Свойство(ИмяРеквизитаФормы), стрДанныеПредмета[ИмяРеквизитаФормы], Неопределено);
	СтрокаСостава.НовоеЗначение             = Форма[ИмяРеквизитаФормы];
	СтрокаСостава.Видимость                 = ?(ДополнительныеПараметры <> Неопределено И ДополнительныеПараметры.Свойство("Видимость"), ДополнительныеПараметры.Видимость, Истина);
	СтрокаСостава.Доступность               = Истина;
	СтрокаСостава.АвтоОтметкаНезаполненного = Ложь;
	
	ОписаниеПоля        = Реквизит.Метка;
	СтрокаСостава.Метка = ОписаниеПоля;
	ПозицияРазделителя  = СтрНайти(ОписаниеПоля, "_");
	ВидДанных           = Неопределено;
	Поле                = Неопределено;
	Если ПозицияРазделителя > 0 Тогда
		ВидДанных = Лев(ОписаниеПоля, ПозицияРазделителя - 1);
		КодПоля   = Сред(ОписаниеПоля, ПозицияРазделителя + 1);
		
		Если ВидДанных = УправлениеНСИКлиентСервер.ВидДанныхКлассификатор() Тогда
			Поле                                       = лм_БизнесПроцессыВызовСервераПереопределяемый.ПолучитьСсылкуПоКоду("Справочники.Классификаторы", КодПоля);
		ИначеЕсли ВидДанных = УправлениеНСИКлиентСервер.ВидДанныхДополнительноеСвойство() Тогда
			РеквизитыАтрибута                          = лм_БизнесПроцессыВызовСервераПереопределяемый.ПолучитьРеквизитыПоКоду("ПланыВидовХарактеристик.Атрибуты", КодПоля, "Ссылка,ОбработчикЗаполненияЗначения");
			Поле                                       = РеквизитыАтрибута.Ссылка; 
			СтрокаСостава.ИспользоватьОбработчикВыбора = ЗначениеЗаполнено(РеквизитыАтрибута.ОбработчикЗаполненияЗначения);
		КонецЕсли;
	ИначеЕсли ОписаниеПоля = УправлениеНСИКлиентСервер.ВидДанныхРеквизит() Тогда
		ВидДанных = ОписаниеПоля;
		Поле      = Реквизит.ИмяПоля; // префикс "лм_"
	КонецЕсли;
	
	СтрокаСостава.ВидДанных = ВидДанных;
	СтрокаСостава.Поле      = Поле;
	
	ЕстьШаблон = Ложь;
	Для Каждого ТипПредмета Из МассивДоступныхТиповДляПодпроцессов Цикл
		Если СтрокаСостава.ТипЗначения.СодержитТип(ТипПредмета) Тогда
			ЕстьШаблон = Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	СтрокаСостава.СтатусБПИндексКартинки = ?(ЕстьШаблон, 1, 2);
	
	Для Каждого Стр Из ТаблицаПодпроцессов Цикл
		Если СтрокаСостава.Поле = Стр.ИмяПоля Тогда
			СтрокаСостава.СтатусБПИндексКартинки = 0;
			Прервать;
		КонецЕсли;
	КонецЦикла;
		
	Возврат СтрокаСостава;
	
КонецФункции

Процедура ДополнитьСоставДанныхПоНастройкамОтображения(Форма, СоответствиеСтрокТаблицыДанных, СоставДанных, СоответствиеРеквизитов, МассивДоступныхТиповДляПодпроцессов, ТаблицаПодпроцессов, стрДанныеПредмета) Экспорт

	ТаблицаНастроекОтображения = Форма[лм_БизнесПроцессыКлиентСервер.ИмяТаблицыНастроекОтображения()];
	
	Для Каждого НастройкаОтображения Из ТаблицаНастроекОтображения Цикл
		Если НастройкаОтображения.Видимость = 0 Тогда
			Продолжить;
		КонецЕсли;
		Если СоответствиеСтрокТаблицыДанных[НастройкаОтображения.ИмяРеквизита] = Неопределено Тогда
			ИмяРеквизита = Сред(НастройкаОтображения.ИмяРеквизита, 4);
			Реквизит     = СоответствиеРеквизитов[ИмяРеквизита];
			Если Реквизит <> Неопределено И Не ЗначениеЗаполнено(Реквизит.ОсновнойИдентификатор) И Не Реквизит.ТипЗначения = Тип("Структура") Тогда
				лм_БизнесПроцессыКлиентСерверПереопределяемый.ДобавитьСтрокуСоставаДанных(Форма, СоставДанных, СоответствиеРеквизитов[ИмяРеквизита], МассивДоступныхТиповДляПодпроцессов, ТаблицаПодпроцессов, стрДанныеПредмета);
			КонецЕсли;
		КонецЕсли;		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

#КонецОбласти