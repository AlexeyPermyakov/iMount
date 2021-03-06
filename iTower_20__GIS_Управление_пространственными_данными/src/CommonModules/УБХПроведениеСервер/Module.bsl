
#Область ПрограммныйИнтерфейс

#Область ПодготовкаИЗаписьДвиженийДокумента

// Процедура инициализирует общие структуры, используемые при проведении документов.
//  Вызывается из модуля документов при проведении.
//
// Параметры:
//  ДокументСсылка			 - ДокументСсылка - ссылка на документ
//  ДополнительныеСвойства	 - Структура - дополнительные свойства документа-объекта
//  РежимПроведения			 - РежимПроведенияДокумента - режим проведения.
//
Процедура ИнициализироватьДополнительныеСвойстваДляПроведения(ДокументСсылка, ДополнительныеСвойства, РежимПроведения = Неопределено) Экспорт

	// В структуре "ДополнительныеСвойства" создаются свойства с ключами "ТаблицыДляДвижений", "ДляПроведения".

	// "ТаблицыДляДвижений" - структура, которая будет содержать таблицы значений с данными для выполнения движений.
	ДополнительныеСвойства.Вставить("ТаблицыДляДвижений", Новый Структура);

	// "ДляПроведения" - структура, содержащая свойства и реквизиты документа, необходимые для проведения.
	ДополнительныеСвойства.Вставить("ДляПроведения", Новый Структура);
	
	// Структура, содержащая ключ с именем "МенеджерВременныхТаблиц", в значении которого хранится менеджер временных таблиц.
	// Содержит для каждой временной таблицы ключ (имя временной таблицы) и значение (признак наличия записей во временной таблице).
	ДополнительныеСвойства.ДляПроведения.Вставить("СтруктураВременныеТаблицы", Новый Структура("МенеджерВременныхТаблиц", Новый МенеджерВременныхТаблиц));
	ДополнительныеСвойства.ДляПроведения.Вставить("РежимПроведения",           РежимПроведения);
	ДополнительныеСвойства.ДляПроведения.Вставить("МетаданныеДокумента",       ДокументСсылка.Метаданные());
	ДополнительныеСвойства.ДляПроведения.Вставить("Ссылка",                    ДокументСсылка);
	
КонецПроцедуры

// Выполняет закрытие менеджера временных таблиц в структуре дополнительных свойств документа, используемых 
// при проведении.
//
// Параметры:
//	ДополнительныеСвойства - Структура - структура с дополнительными свойствами документа, используемыми
//		при проведении.
//
Процедура ОчиститьДополнительныеСвойстваДляПроведения(ДополнительныеСвойства) Экспорт
	
	ДополнительныеСвойства.ДляПроведения.СтруктураВременныеТаблицы.МенеджерВременныхТаблиц.Закрыть();
	
КонецПроцедуры

// Формирует массив имен регистров, по которым документ имеет движения.
//  Вызывается при подготовке записей к регистрации движений.
//
// Параметры:
//  Регистратор					 - ДокументСсылка	 - ссылка на документ, для которого формируется список регистров
//  Движения					 - КоллекцияДвижений - движения документа
//  МассивИсключаемыхРегистров	 - Массив			 - исключаемые регистры.
// 
// Возвращаемое значение:
//  Массив - массив имен регистров, по которым документ имеет движения.
//
Функция ПолучитьИспользуемыеРегистры(Регистратор, Движения, МассивИсключаемыхРегистров = Неопределено) Экспорт

	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Регистратор", Регистратор);

	Результат = Новый Массив;
	МаксимумТаблицВЗапросе = 256;

	СчетчикТаблиц   = 0;
	СчетчикДвижений = 0;

	ВсегоДвижений = Движения.Количество();
	ТекстЗапроса  = "";
	Для Каждого Движение Из Движения Цикл

		СчетчикДвижений = СчетчикДвижений + 1;

		ПропуститьРегистр = МассивИсключаемыхРегистров <> Неопределено
							И МассивИсключаемыхРегистров.Найти(Движение.Имя) <> Неопределено;

		Если Не ПропуститьРегистр Тогда

			Если СчетчикТаблиц > 0 Тогда

				ТекстЗапроса = ТекстЗапроса + "
				|ОБЪЕДИНИТЬ ВСЕ
				|";

			КонецЕсли;

			СчетчикТаблиц = СчетчикТаблиц + 1;

			ТекстЗапроса = ТекстЗапроса + 
			"
			|ВЫБРАТЬ ПЕРВЫЕ 1
			|""" + Движение.Имя + """ КАК ИмяРегистра
			|
			|ИЗ " + Движение.ПолноеИмя() + "
			|
			|ГДЕ Регистратор = &Регистратор
			|";

		КонецЕсли;

		Если СчетчикТаблиц = МаксимумТаблицВЗапросе Или СчетчикДвижений = ВсегоДвижений Тогда

			Запрос.Текст  = ТекстЗапроса;
			ТекстЗапроса  = "";
			СчетчикТаблиц = 0;

			Если Результат.Количество() = 0 Тогда

				Результат = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ИмяРегистра");

			Иначе

				Выборка = Запрос.Выполнить().Выбрать();
				Пока Выборка.Следующий() Цикл
					Результат.Добавить(Выборка.ИмяРегистра);
				КонецЦикла;

			КонецЕсли;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;

КонецФункции

// Процедура компонует текст запроса, выполняет запрос и выгружает результаты запроса в таблицы.
//
// Параметры:
//  Запрос					 - Запрос	 - запрос, параметры которого предварительно установлены.
//  ТекстыЗапроса			 - СписокЗначений	 - в списке перечислены тексты запросов и их имена.
//  Таблицы					 - Структура		 - структура в которую будут помещены полученные таблицы для движений.
//  ДобавитьРазделитель		 - Булево			 - Истина, если нужно добавить разделитель ";" между запросами.
//  ДобавлятьСловоТаблица	 - Булево			 - Истина, если к имени таблицы движений нужно в начало добавить слово "Таблица".
//  ТолькоОтмеченные		 - Булево			 - признак пропуска инициализации таблицы движения.
//
Процедура ИнициализироватьТаблицыДляДвижений(Запрос, ТекстыЗапроса, Таблицы, ДобавитьРазделитель = Ложь, ДобавлятьСловоТаблица = Истина, ТолькоОтмеченные = Ложь) Экспорт
	
	ТаблицыЗапроса = УБХОбщегоНазначения.ВыгрузитьРезультатыЗапроса(Запрос, ТекстыЗапроса,, ДобавитьРазделитель);
	
	// Помещение результатов запроса в таблицы
	Для Каждого ТекстЗапроса Из ТекстыЗапроса Цикл

		ИмяТаблицы = ТекстЗапроса.Представление;

		Если Не ПустаяСтрока(ИмяТаблицы) И (Не ТолькоОтмеченные Или ТекстЗапроса.Пометка) Тогда
		
			Если ДобавлятьСловоТаблица Тогда
				// Таблицы для проведения должны начинаться с "Таблица"
				Если НЕ СтрНачинаетсяС(ИмяТаблицы, "Таблица") Тогда
					ИмяТаблицы = "Таблица" + ИмяТаблицы;
				КонецЕсли;
			КонецЕсли;
			
			Таблицы.Вставить(ИмяТаблицы, ТаблицыЗапроса[ТекстЗапроса.Представление]);
			
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ПроцедурыВыдачиСообщенийОбОшибкахПроведения

#КонецОбласти

#КонецОбласти
