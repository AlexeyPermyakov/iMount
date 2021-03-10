////////////////////////////////////////////////////////////////////////////////
// Обновление информационной базы Библиотеки интеграции с 1С:Документооборотом
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

////////////////////////////////////////////////////////////////////////////////
// Сведения о библиотеке (или конфигурации).

// Заполняет основные сведения о библиотеке или основной конфигурации.
// Библиотека, имя которой имя совпадает с именем конфигурации в метаданных, определяется как основная конфигурация.
// 
// Параметры:
//  Описание - Структура - сведения о библиотеке:
//
//   * Имя                 - Строка - имя библиотеки, например, "СтандартныеПодсистемы".
//   * Версия              - Строка - версия в формате из 4-х цифр, например, "2.1.3.1".
//
//   * ТребуемыеПодсистемы - Массив - имена других библиотек (Строка), от которых зависит данная библиотека.
//                                    Обработчики обновления таких библиотек должны быть вызваны ранее
//                                    обработчиков обновления данной библиотеки.
//                                    При циклических зависимостях или, напротив, отсутствии каких-либо зависимостей,
//                                    порядок вызова обработчиков обновления определяется порядком добавления модулей
//                                    в процедуре ПриДобавленииПодсистем общего модуля
//                                    ПодсистемыКонфигурацииПереопределяемый.
//
Процедура ПриДобавленииПодсистемы(Описание) Экспорт
	
	Описание.Имя    = "БиблиотекаИнтеграцииС1СДокументооборотом";
	Описание.Версия = "1.1.17.2";
	Описание.ИдентификаторИнтернетПоддержки = "DMIL";
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Обработчики обновления информационной базы.

// Добавляет в список процедуры-обработчики обновления данных ИБ
// для всех поддерживаемых версий библиотеки или конфигурации.
// Вызывается перед началом обновления данных ИБ для построения плана обновления.
//
// Параметры:
//   Обработчики - ТаблицаЗначений - описание полей, см. в процедуре.
//                 ОбновлениеИнформационнойБазы.НоваяТаблицаОбработчиковОбновления.
//
// Пример:
//	Обработчик = Обработчики.Добавить();
//	Обработчик.Версия              = "1.1.0.0";
//	Обработчик.Процедура           = "ОбновлениеИБ.ПерейтиНаВерсию_1_1_0_0";
//	Обработчик.РежимВыполнения     = "Монопольно";
//
Процедура ПриДобавленииОбработчиковОбновления(Обработчики) Экспорт
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "*";
	Обработчик.МонопольныйРежим = Ложь;
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыБИД.ПроверитьСоответствиеПравилИнтеграцииМетаданным";
	Обработчик.Идентификатор = Новый УникальныйИдентификатор("757a17b9-2e40-40ed-b109-0f30f7a0de5b");
	Обработчик.Комментарий = НСтр("ru = 'Проверка правил интеграции с 1С:Документооборотом'");
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "*";
	Обработчик.МонопольныйРежим = Ложь;
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыБИД.ПриОбновленииИнформационнойБазы";
	Обработчик.Комментарий = НСтр("ru = 'Проверка соответствия определяемых типов и плана обмена'");
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "1.1.6.1";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыБИД.ПерейтиНаВерсию_1_1_6_1";
	Обработчик.Комментарий = НСтр("ru = 'Обновление правил интеграции с 1С:Документооборотом'");
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "1.1.8.4";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыБИД.ПерейтиНаВерсию_1_1_8_4";
	Обработчик.Комментарий = НСтр("ru = 'Обновление правил интеграции с 1С:Документооборотом'");
	
	Обработчик = Обработчики.Добавить();
	Обработчик.Версия = "1.1.12.2";
	Обработчик.Процедура = "ОбновлениеИнформационнойБазыБИД.ПерейтиНаВерсию_1_1_12_2";
	Обработчик.Комментарий = НСтр("ru = 'Обновление правил интеграции с 1С:Документооборотом'");

КонецПроцедуры

// Вызывается перед процедурами-обработчиками обновления данных ИБ.
//
Процедура ПередОбновлениемИнформационнойБазы() Экспорт
	
	
	
КонецПроцедуры

// Вызывается после завершения обновления данных ИБ.
//
// Параметры:
//   ПредыдущаяВерсия       - Строка - версия до обновления. "0.0.0.0" для "пустой" ИБ.
//   ТекущаяВерсия          - Строка - версия после обновления.
//   ВыполненныеОбработчики - ДеревоЗначений - список выполненных процедур-обработчиков обновления,
//                                             сгруппированных по номеру версии.
//   ВыводитьОписаниеОбновлений - Булево - если установить Истина, то будет выведена форма
//                                с описанием обновлений. По умолчанию, Истина.
//                                Возвращаемое значение.
//   МонопольныйРежим           - Булево - Истина, если обновление выполнялось в монопольном режиме.
//
// Пример:
//	Для Каждого Версия Из ВыполненныеОбработчики.Строки Цикл
//		
//		Если Версия.Версия = "*" Тогда
//			// Обработчик, который может выполнятся при каждой смене версии.
//		Иначе
//			// Обработчик, который выполняется для определенной версии.
//		КонецЕсли;
//		
//		Для Каждого Обработчик Из Версия.Строки Цикл
//			...
//		КонецЦикла;
//		
//	КонецЦикла;
//
Процедура ПослеОбновленияИнформационнойБазы(Знач ПредыдущаяВерсия, Знач ТекущаяВерсия,
		Знач ВыполненныеОбработчики, ВыводитьОписаниеОбновлений, МонопольныйРежим) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при подготовке табличного документа с описанием изменений в программе.
//
// Параметры:
//   Макет - ТабличныйДокумент - описание обновления всех библиотек и конфигурации.
//           Макет можно дополнить или заменить.
//           См. также общий макет ОписаниеИзмененийСистемы.
//
Процедура ПриПодготовкеМакетаОписанияОбновлений(Знач Макет) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при определении режима обновления данных.
//
// Параметры:
//   РежимОбновленияДанных - Строка - режим обновления.
//   СтандартнаяОбработка - Булево - Ложь, если нужно изменить режим по умолчанию.
//
Процедура ПриОпределенииРежимаОбновленияДанных(РежимОбновленияДанных, СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Обработчик, проверяющий соответствие правил интеграции метаданным конфигурации.
//
Процедура ПроверитьСоответствиеПравилИнтеграцииМетаданным() Экспорт
	
	Если Не ПолучитьФункциональнуюОпцию("ИспользоватьИнтеграциюС1СДокументооборот") Тогда
		Возврат;
	КонецЕсли;
	
	ЗапросПравила = Новый Запрос(
		"ВЫБРАТЬ
		|	Правила.Ссылка
		|ИЗ
		|	Справочник.ПравилаИнтеграцииС1СДокументооборотом КАК Правила
		|ГДЕ
		|	НЕ ПометкаУдаления
		|	И ТипОбъектаИС <> """"");
		
	ВыборкаПравила = ЗапросПравила.Выполнить().Выбрать();
	Пока ВыборкаПравила.Следующий() Цикл
		
		ПравилоОбъект = ВыборкаПравила.Ссылка.ПолучитьОбъект();
		НужнаЗапись = Ложь;
		
		ОбъектМетаданных = Метаданные.НайтиПоПолномуИмени(ПравилоОбъект.ТипОбъектаИС);
		
		Если ОбъектМетаданных = Неопределено Тогда
			
			ТекстСообщения = СтрШаблон(
				НСтр("ru = 'Помечено на удаление правило для несуществующего объекта %1'",
					ОбщегоНазначения.КодОсновногоЯзыка()),
				ПравилоОбъект.ТипОбъектаИС);
			ЗаписьЖурналаРегистрации(
				ИнтеграцияС1СДокументооборот.ИмяСобытияЖурналаРегистрации(),
				УровеньЖурналаРегистрации.Ошибка,,,
				ТекстСообщения);
				
			ПравилоОбъект.ПометкаУдаления = Истина;
			НужнаЗапись = Истина;
			
		Иначе
		
			Для Каждого Правило Из ПравилоОбъект.ПравилаЗаполненияРеквизитовДО Цикл
				
				Если Правило.Вариант
						<> Перечисления.ВариантыПравилЗаполненияРеквизитов.РеквизитОбъекта
					Или Правило.ЭтоДополнительныйРеквизитИС
					Или Правило.ЭтоТаблица
					Или ЗначениеЗаполнено(Правило.Таблица) Тогда
					Продолжить;
				КонецЕсли;
				
				ПозицияТочки = СтрНайти(Правило.ИмяРеквизитаОбъектаИС, ".");
				Если ПозицияТочки = 0 Тогда
					ИмяРеквизитаОбъектаИС = Правило.ИмяРеквизитаОбъектаИС;
				Иначе
					ИмяРеквизитаОбъектаИС = Лев(Правило.ИмяРеквизитаОбъектаИС, ПозицияТочки - 1);
				КонецЕсли;
				
				Если ОбъектМетаданных.Реквизиты.Найти(ИмяРеквизитаОбъектаИС) = Неопределено
					И ИмяРеквизитаОбъектаИС <> "Представление" Тогда
					
					Найден = Ложь;
					Для Каждого СтандартныйРеквизит Из ОбъектМетаданных.СтандартныеРеквизиты Цикл
						Если СтандартныйРеквизит.Имя = ИмяРеквизитаОбъектаИС Тогда
							Найден = Истина;
							Прервать;
						КонецЕсли;
					КонецЦикла;
					
					Если Не Найден Тогда
						
						ТекстСообщения = СтрШаблон(НСтр("ru = 'Очищено правило выгрузки для несуществующего реквизита %1'"),
							Правило.ИмяРеквизитаОбъектаИС);
						ЗаписьЖурналаРегистрации(
							ИнтеграцияС1СДокументооборот.ИмяСобытияЖурналаРегистрации(),
							УровеньЖурналаРегистрации.Ошибка,,
							ВыборкаПравила.Ссылка,
							ТекстСообщения);
						НужнаЗапись = Истина;
						
						Правило.Вариант = Неопределено; 
						Правило.ИмяРеквизитаОбъектаИС = Неопределено;
						Правило.ЗначениеРеквизитаДО = ТекстСообщения;
						
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЦикла;
		
			Для Каждого Правило Из ПравилоОбъект.ПравилаЗаполненияРеквизитовИС Цикл
				
				Если Правило.Вариант
						<> Перечисления.ВариантыПравилЗаполненияРеквизитов.РеквизитОбъекта
					Или Правило.ЭтоДополнительныйРеквизитИС
					Или Правило.ЭтоТаблица
					Или ЗначениеЗаполнено(Правило.Таблица) Тогда
					Продолжить;
				КонецЕсли;
				
				Если ОбъектМетаданных.Реквизиты.Найти(Правило.ИмяРеквизитаОбъектаИС) = Неопределено
					И Правило.ИмяРеквизитаОбъектаИС <> "Представление" Тогда
					
					Найден = Ложь;
					Для Каждого СтандартныйРеквизит Из ОбъектМетаданных.СтандартныеРеквизиты Цикл
						Если СтандартныйРеквизит.Имя = Правило.ИмяРеквизитаОбъектаИС Тогда
							Найден = Истина;
							Прервать;
						КонецЕсли;
					КонецЦикла;
					
					Если Не Найден Тогда
						
						ТекстСообщения = СтрШаблон(НСтр("ru = 'Очищено правило загрузки для несуществующего реквизита %1'"),
							Правило.ИмяРеквизитаОбъектаИС);
						ЗаписьЖурналаРегистрации(
							ИнтеграцияС1СДокументооборот.ИмяСобытияЖурналаРегистрации(),
							УровеньЖурналаРегистрации.Ошибка,,
							ВыборкаПравила.Ссылка,
							ТекстСообщения);
						НужнаЗапись = Истина;
						
						Правило.Вариант = Неопределено; 
						Правило.ИмяРеквизитаОбъектаИС = Неопределено;
						Правило.ЗначениеРеквизитаИС = ТекстСообщения;
						Правило.Обновлять = Ложь;
						
					КонецЕсли;
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
		Если НужнаЗапись Тогда
			ОбновлениеИнформационнойБазы.ЗаписатьДанные(ПравилоОбъект);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Вызывается при обновлении ИБ.
//
Процедура ПриОбновленииИнформационнойБазы() Экспорт
	
	Ошибки = Новый Массив;
	
	ПроверитьСоответствиеОпределяемыхТиповМеждуСобой(Ошибки);
	ПроверитьСоответствиеОпределяемыхТиповИПланаОбмена(Ошибки);
	
	Если Ошибки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТекстОшибок = СтрСоединить(Ошибки, Символы.ПС);
	ВызватьИсключение ТекстОшибок;
	
КонецПроцедуры

// Сверяет состав определяемых типов между собой, вызывая исключения.
//
Процедура ПроверитьСоответствиеОпределяемыхТиповМеждуСобой(Ошибки) Экспорт
	
	СтандартнаяОбработка = Истина;
	ИнтеграцияС1СДокументооборотПереопределяемый.ПроверитьСоответствиеОпределяемыхТиповМеждуСобой(
		Ошибки,
		СтандартнаяОбработка);
	
	Если Не СтандартнаяОбработка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ТипЗначения Из Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.Тип.Типы() Цикл
		
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗначения);
		
		Если ОбъектМетаданных = Неопределено
			Или (Не ОбщегоНазначения.ЭтоСправочник(ОбъектМетаданных)
				И Не ОбщегоНазначения.ЭтоДокумент(ОбъектМетаданных)
				И Не ОбщегоНазначения.ЭтоПланВидовХарактеристик(ОбъектМетаданных)
				И Не ОбщегоНазначения.ЭтоБизнесПроцесс(ОбъектМетаданных)
				И Не ОбщегоНазначения.ЭтоЗадача(ОбъектМетаданных)) Тогда
			
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый, но интеграция данного объекта с ДО не поддерживается.'"),
					ТипЗначения));
			Продолжить;
		КонецЕсли;
		
		Если Не ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый, но в него должны быть включены только ссылочные типы.'"),
					ТипЗначения));
			Продолжить;
		КонецЕсли;
		
		ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		Если ОбщегоНазначения.ЭтоСправочник(ОбъектМетаданных) Тогда
			Тип = Тип(СтрЗаменить(ПолноеИмя, ".", "Объект."));
			Если Не Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотСправочникиОбъектыПереопределяемый.Тип.СодержитТип(Тип) Тогда
				Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Справочник ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый, но отсутствует в типе ИнтеграцияС1СДокументооборотСправочникиОбъектыПереопределяемый.'"),
					ОбъектМетаданных.Имя));
			КонецЕсли;
		ИначеЕсли ОбщегоНазначения.ЭтоДокумент(ОбъектМетаданных) Тогда
			Тип = Тип(СтрЗаменить(ПолноеИмя, ".", "Объект."));
			Если Не Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотДокументыОбъектыПереопределяемый.Тип.СодержитТип(Тип) Тогда
				Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Документ ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый, но отсутствует в типе ИнтеграцияС1СДокументооборотДокументыОбъектыПереопределяемый.'"),
					ОбъектМетаданных.Имя));
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ТипЗначения Из Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотДокументыОбъектыПереопределяемый.Тип.Типы() Цикл
		
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗначения);
		
		Если ОбъектМетаданных = Неопределено Или Не ОбщегоНазначения.ЭтоДокумент(ОбъектМетаданных) Тогда
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотДокументыОбъектыПереопределяемый, но в него должны быть включены только документы.'"),
					ТипЗначения));
			Продолжить;
		КонецЕсли;
		
		Если ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотДокументыОбъектыПереопределяемый, но в него должны быть включены только типы ДокументОбъект.'"),
					ТипЗначения));
			Продолжить;
		КонецЕсли;
		
		ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		Тип = Тип(СтрЗаменить(ПолноеИмя, ".", "Ссылка."));
		Если Не Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.Тип.СодержитТип(Тип) Тогда
			Ошибки.Добавить(СтрШаблон(
				НСтр("ru = 'Документ ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотДокументыОбъектыПереопределяемый, но отсутствует в типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.'"),
				ОбъектМетаданных.Имя));
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ТипЗначения Из Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотСправочникиОбъектыПереопределяемый.Тип.Типы() Цикл
		
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗначения);
		
		Если ОбъектМетаданных = Неопределено Или Не ОбщегоНазначения.ЭтоСправочник(ОбъектМетаданных) Тогда
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотСправочникиОбъектыПереопределяемый, но в него должны быть включены только справочники.'"),
					ТипЗначения));
			Продолжить;
		КонецЕсли;
		
		Если ОбщегоНазначения.ЭтоСсылка(ТипЗначения) Тогда
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотСправочникиОбъектыПереопределяемый, но в него должны быть включены только типы СправочникОбъект.'"),
					ТипЗначения));
			Продолжить;
		КонецЕсли;
		
		ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		Тип = Тип(СтрЗаменить(ПолноеИмя, ".", "Ссылка."));
		Если Не Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.Тип.СодержитТип(Тип) Тогда
			Ошибки.Добавить(СтрШаблон(
				НСтр("ru = 'Справочник ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотСправочникиОбъектыПереопределяемый, но отсутствует в типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.'"),
				ОбъектМетаданных.Имя));
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Сверяет определяемые типы с планом обмена, вызывая исключения.
//
Процедура ПроверитьСоответствиеОпределяемыхТиповИПланаОбмена(Ошибки) Экспорт
	
	СтандартнаяОбработка = Истина;
	ИнтеграцияС1СДокументооборотПереопределяемый.ПроверитьСоответствиеОпределяемыхТиповИПланаОбмена(
		Ошибки,
		СтандартнаяОбработка);
	
	Если Не СтандартнаяОбработка Тогда
		Возврат;
	КонецЕсли;
	
	Для Каждого ЭлементСостава Из Метаданные.ПланыОбмена.ИнтеграцияС1СДокументооборотомПереопределяемый.Состав Цикл
		
		ОбъектМетаданных = ЭлементСостава.Метаданные;
		ПолноеИмя = ОбъектМетаданных.ПолноеИмя();
		
		Если Не ОбщегоНазначения.ЭтоСправочник(ОбъектМетаданных)
			И Не ОбщегоНазначения.ЭтоДокумент(ОбъектМетаданных)
			И Не ОбщегоНазначения.ЭтоПланВидовХарактеристик(ОбъектМетаданных)
			И Не ОбщегоНазначения.ЭтоБизнесПроцесс(ОбъектМетаданных)
			И Не ОбщегоНазначения.ЭтоЗадача(ОбъектМетаданных) Тогда
			
			Ошибки.Добавить(СтрШаблон(
					НСтр("ru = 'Объект ""%1"" есть в плане обмена ИнтеграцияС1СДокументооборотомПереопределяемый, но интеграция данного объекта с ДО не поддерживается.'"),
					ПолноеИмя));
			Продолжить;
		КонецЕсли;
		
		Тип = Тип(СтрЗаменить(ПолноеИмя, ".", "Ссылка."));
		Если Не Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.Тип.СодержитТип(Тип) Тогда
			Ошибки.Добавить(СтрШаблон(
				НСтр("ru = 'Объект ""%1"" есть в плане обмена ИнтеграцияС1СДокументооборотомПереопределяемый, но отсутствует в типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.'"),
				ПолноеИмя));
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого ТипЗначения Из Метаданные.ОпределяемыеТипы.ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый.Тип.Типы() Цикл
		
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗначения);
		
		Если ОбъектМетаданных = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		Если Не Метаданные.ПланыОбмена.ИнтеграцияС1СДокументооборотомПереопределяемый.Состав.Содержит(ОбъектМетаданных) Тогда
			Ошибки.Добавить(СтрШаблон(
				НСтр("ru = 'Тип ""%1"" выбран в определяемом типе ИнтеграцияС1СДокументооборотВсеСсылкиПереопределяемый, но отсутствует в составе плана обмена ИнтеграцияС1СДокументооборотомПереопределяемый.'"),
				ТипЗначения));
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// Обработчик обновления БИД на версию 1.1.6.1. Обновление наименований правил интеграции
// и установка реквизита Ключевой у видов документов ДО.
//
Процедура ПерейтиНаВерсию_1_1_6_1() Экспорт
	
	ЗапросПравила = Новый Запрос(
		"ВЫБРАТЬ
		|	Правила.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ПравилаИнтеграцииС1СДокументооборотом КАК Правила
		|ГДЕ
		|	(Правила.ТипОбъектаИС <> """"
		|				И (ВЫРАЗИТЬ(Правила.ПредставлениеОбъектаИС КАК СТРОКА(1))) = """"
		|			ИЛИ Правила.ТипОбъектаДО <> """"
		|				И (ВЫРАЗИТЬ(Правила.ПредставлениеОбъектаДО КАК СТРОКА(1))) = """")");
	
	ВыборкаПравила = ЗапросПравила.Выполнить().Выбрать();
	Пока ВыборкаПравила.Следующий() Цикл
		
		ПравилоОбъект = ВыборкаПравила.Ссылка.ПолучитьОбъект();
		
		Для Каждого ПравилоВыгрузки Из ПравилоОбъект.ПравилаЗаполненияРеквизитовДО Цикл
			Если ПравилоВыгрузки.ИмяРеквизитаОбъектаДО = "documentType" Тогда
				ПравилоВыгрузки.Ключевой = Истина;
			КонецЕсли;
		КонецЦикла;
		
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(ПравилоОбъект);
		
	КонецЦикла;
	
КонецПроцедуры

// Обработчик обновления БИД на версию 1.1.8.4. Установка флага "Не создавать связи по ссылкам".
//
Процедура ПерейтиНаВерсию_1_1_8_4() Экспорт
	
	ЗапросПравила = Новый Запрос(
		"ВЫБРАТЬ
		|	Правила.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.ПравилаИнтеграцииС1СДокументооборотом КАК Правила
		|ГДЕ
		|	НЕ Правила.НеСоздаватьСвязиПоСсылкам");
	
	ВыборкаПравила = ЗапросПравила.Выполнить().Выбрать();
	Пока ВыборкаПравила.Следующий() Цикл
		
		ПравилоОбъект = ВыборкаПравила.Ссылка.ПолучитьОбъект();
		ПравилоОбъект.НеСоздаватьСвязиПоСсылкам = Истина;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(ПравилоОбъект);
		
	КонецЦикла;
	
КонецПроцедуры

// Обработчик обновления БИД на версию 1.1.12.2. Установка флага "Не создавать связи по ссылкам".
//
Процедура ПерейтиНаВерсию_1_1_12_2() Экспорт
	
	ПустойРежим = Перечисления.РежимИзмененияПроведенногоДокументаДанными1СДокументооборота.ПустаяСсылка();
	ЗапросПравила = Новый Запрос(
		"ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	ПравилаЗагрузки.Ссылка
		|ИЗ
		|	Справочник.ПравилаИнтеграцииС1СДокументооборотом.ПравилаЗаполненияРеквизитовИС КАК ПравилаЗагрузки
		|ГДЕ
		|	ПравилаЗагрузки.РежимИзмененияДанныхПроведенногоДокумента = &ПустойРежим
		|	И ПравилаЗагрузки.Ссылка.ТипОбъектаИС ПОДОБНО ""Документ.%""
		|");
	ЗапросПравила.УстановитьПараметр("ПустойРежим", ПустойРежим);
		
	ВыборкаПравила = ЗапросПравила.Выполнить().Выбрать();
	Пока ВыборкаПравила.Следующий() Цикл
		
		ПравилоОбъект = ВыборкаПравила.Ссылка.ПолучитьОбъект();
		Для Каждого ПравилоЗагрузки Из ПравилоОбъект.ПравилаЗаполненияРеквизитовИС Цикл
			Если ПравилоЗагрузки.РежимИзмененияДанныхПроведенногоДокумента = ПустойРежим Тогда 
				ПравилоЗагрузки.РежимИзмененияДанныхПроведенногоДокумента =
					Перечисления.РежимИзмененияПроведенногоДокументаДанными1СДокументооборота.Запрещено;
			КонецЕсли;
		КонецЦикла;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(ПравилоОбъект);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти