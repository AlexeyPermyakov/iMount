////////////////////////////////////////////////////////////////////////////////
// Менеджер защиты: Система лицензирования отраслевых и специализированных решений. 
// Поддержка программного интерфейса СЛК
// Область выполнения: Сервер (вызов сервера)
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Проверяет лицензию для текущего сеанса ИБ, в случае успеха возвращает Истина,
// в случае ошибки - Ложь. Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
//  КомандаМенеджераЗащиты  - Строка - Команда, выполняемая менеджером защиты
//							Поддерживаемые команды:
//							 - ПодключитьЕслиНеЗапущен
//							 - Отключить
//
// Возвращаемое значение:
//   Булево   - в случае успеха возвращает Истина, в случае ошибки - Ложь
//
Функция ПроверитьЛицензиюСеанса(Знач Серия, ОписаниеОшибки = "", Знач КомандаМенеджераЗащиты = "ПодключитьЕслиНеЗапущен")	Экспорт

	Попытка
		
		ТолькоНаличиеКлюча = Ложь;			
		СерияЗащитыИнициализирована = слкМенеджерЗащитыСервер.СерияЗащитыИнициализирована(Серия, ТолькоНаличиеКлюча);
		
		Если СерияЗащитыИнициализирована Тогда
			
			Если КомандаМенеджераЗащиты = "Отключить" Тогда
				слкМенеджерЗащитыСервер.УдалитьМенеджерСерииЗащиты(Серия, ОписаниеОшибки);
				Возврат Ложь;
			Иначе
				МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);				
				Возврат МенеджерОбъектов.ПопыткаПроверитьЛицензиюСеанса(ТолькоНаличиеКлюча);
			КонецЕсли;
			
		Иначе
			
			Если КомандаМенеджераЗащиты = "ПодключитьЕслиНеЗапущен" Тогда
				МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);				
				Если слкМенеджерЗащитыСервер.СерияЗащитыИнициализирована(Серия, ТолькоНаличиеКлюча) Тогда
					Возврат МенеджерОбъектов.ПопыткаПроверитьЛицензиюСеанса(ТолькоНаличиеКлюча);
				Иначе
					Возврат Ложь;
				КонецЕсли;
			Иначе
				Возврат Ложь;				
			КонецЕсли;
		
		КонецЕсли;
		
	Исключение
		
		ОписаниеОшибки = ОписаниеОшибки();
		Возврат Ложь;
		
	КонецПопытки;

КонецФункции // ПроверитьЛицензиюСеанса()

// Возвращает защищенный объект по его имени в файле данных, в случае ошибки – Неопределено. 
// Информация об ошибке возвращается в ОписаниеОшибки
// Для создания объектов, находящихся в дополнительных файлах данных, 
// необходимо указать псевдоним нужного файла, например:
//	// объект из основного файла XXXX.datafile
//	Объект = МенеджерОбъектов.СоздатьОбъект("ЗащищеннаяОбработка"); 
//	// объект в файле XXXX.Extension.datafile
//	Объект = МенеджерОбъектов.СоздатьОбъект("Extension.ЗащищеннаяОбработка"); 
// Для создания объекта из файла данных, загруженного из макета в конфигурации, 
// в качестве псевдонима указывается имя макета, например:
//	// объект в файле из макета "ДанныеСЛК"
//	Объект = МенеджерОбъектов.СоздатьОбъект("ДанныеСЛК.ЗащищеннаяОбработка");
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//	Имя - Строка - Имя объекта в файле данных
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Объект, Неопределено   - защищенный объект по его имени в файле данных, 
//                            в случае ошибки – Неопределено 
//
Функция СоздатьОбъект(Знач Серия, Знач Имя, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ЗащищенныйОбъект = МенеджерОбъектов.ПопыткаСоздатьОбъект(Имя);     
		Если ЗащищенныйОбъект = Неопределено Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ЗащищенныйОбъект;

КонецФункции // СоздатьОбъект()

// Возвращает серийный номер ключа, лицензию которого занимает текущий сеанс, 
// в случае ошибки – Неопределено. Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Строка, Неопределено   - серийный номер ключа, лицензию которого занимает 
//                            текущий сеанс, в случае ошибки – Неопределено
//
Функция ПолучитьНомерКлюча(Знач Серия, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		НомерКлюча = МенеджерОбъектов.ПопыткаПолучитьНомерКлюча();     
		Если НомерКлюча = Неопределено Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат НомерКлюча;

КонецФункции // ПолучитьНомерКлюча()

// Возвращает в виде строки список установленных на сервере СЛК ключей используемой серии.
// Строка имеет следующий формат:
// 	СН1,Тип1,Лицензии1,ТипУстройства1,РегНомер1;СН2,Тип2,Лицензии2,ТипУстройства1,РегНомер1;…
//	Где:
// 		СН – серийный номер ключа
//		Тип – тип ключа (3 – основной, 4 – дополнительный)
//		Лицензии – количество лицензий
//		ТипУстройства – 0 – аппаратный, 1 – программный
//		РегНомер – регистрационный номер, связанный с С/Н (0, если не связан)
// Информация об ошибке возвращается в ОписаниеОшибки.
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Строка	- список установленных на сервере СЛК ключей используемой серии 
//
Функция ПолучитьСписокКлючей(Знач Серия, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		СписокКлючей = МенеджерОбъектов.ПопыткаПолучитьСписокКлючей();     
		Если СписокКлючей = Неопределено Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат СписокКлючей;

КонецФункции // ПолучитьСписокКлючей()

// Возвращает значение указанного параметра для текущего ключа защиты, с которым работает система, 
// в случае ошибки – пустая строка. Информация об ошибке возвращается в ОписаниеОшибки
//
// Если для текущего ключа значение не определено и параметр ИспользоватьОсновнойКлюч равен Ложь, 
// то будет возвращено значение параметра по умолчанию.
// Если для текущего ключа значение не определено и параметр ИспользоватьОсновнойКлюч равен Истина, 
// то будет возвращено значение для основного ключа. Если же значение для основного ключа не определено, 
// то будет возвращено значение параметра по умолчанию.
// В качестве основного ключа будет выступать ключ, указанный в файле параметров как главный 
// основной ключ или первый подключенный к компьютеру основной.
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//	Имя - Строка - Имя параметра в файле параметров
//	ИспользоватьОсновнойКлюч - Булево - Признак использования основного ключа.
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Строка   - значение указанного параметра для текущего ключа защиты
//
Функция ПолучитьЗначениеПараметра(Знач Серия, Знач Имя, Знач ИспользоватьОсновнойКлюч = Истина, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ЗначениеПараметра = МенеджерОбъектов.ПопыткаПолучитьЗначениеПараметра(Имя, ИспользоватьОсновнойКлюч);     
		Если ЗначениеПараметра = Неопределено Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ЗначениеПараметра;

КонецФункции // ПолучитьЗначениеПараметра()

// Возвращает значение пользовательской памяти для текущего ключа защиты, с 
// которым работает система, в случае ошибки вызывается исключение. По умолчанию пароль
// на чтение равен пустой строке. Изменить пароли можно при помощи редактора файлов данных
// и функций УстановитьПаролиНаПамятьКлюча и ПопыткаУстановитьПаролиНаПамятьКлюча.
// Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Строка   - значение пользовательской памяти для текущего ключа защиты 
//				(максимум 8 символов)
//
Функция ПрочитатьПамятьКлюча(Знач Серия, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ПамятьКлюча = МенеджерОбъектов.ПопыткаПрочитатьПамятьКлюча();     
		Если ПамятьКлюча = Неопределено Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ПамятьКлюча;

КонецФункции // ПрочитатьПамятьКлюча()

// Записывает значение в пользовательскую память текущего ключа защиты, с которым 
// работает система. По умолчанию пароль на запись равен пустой строке. Изменить 
// пароли можно при помощи редактора файлов данных и функций УстановитьПаролиНаПамятьКлюча 
// и ПопыткаУстановитьПаролиНаПамятьКлюча.
// Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//	Пароль - Строка - Пароль на запись (максимум 8 символов)
//	Значение - Строка - Данные для записи в память ключа (максимум 400 символов)
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Булево   - успешность записи памяти
//
Функция ЗаписатьПамятьКлюча(Знач Серия, Знач Пароль, Знач Значение, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ПамятьЗаписана = МенеджерОбъектов.ПопыткаЗаписатьПамятьКлюча(Пароль, Значение);     
		Если НЕ ПамятьЗаписана Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ПамятьЗаписана;

КонецФункции // ЗаписатьПамятьКлюча()

// Обнуляет пользовательскую память текущего ключа защиты, с которым работает система. 
// Пароли на чтение и запись устанавливаются равными пустой строке.
// Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Булево   - успешность обнуления памяти ключа
//
Функция ОбнулитьПамятьКлюча(Знач Серия, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ПамятьОбнулена = МенеджерОбъектов.ПопыткаОбнулитьПамятьКлюча();     
		Если НЕ ПамятьОбнулена Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ПамятьОбнулена;

КонецФункции // ОбнулитьПамятьКлюча()

// Устанавливает пароли на доступ к пользовательской памяти текущего ключа защиты, 
// с которым работает система.
// Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//	НаЧтениеСтарый - Строка - Текущий пароль на чтение (максимум 8 символов)
//	НаЗаписьСтарый - Строка - Текущий пароль на запись (максимум 8 символов)
//	НаЧтениеНовый - Строка - Новый пароль на чтение (максимум 8 символов)
//	НаЗаписьНовый - Строка - Новый пароль на запись (максимум 8 символов)
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Булево   - успешность установки пароля
//
Функция УстановитьПаролиНаПамятьКлюча(Знач Серия, Знач НаЧтениеСтарый, Знач НаЗаписьСтарый, Знач НаЧтениеНовый, Знач НаЗаписьНовый, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ПаролиУстановлены = МенеджерОбъектов.УстановитьПаролиНаПамятьКлюча(НаЧтениеСтарый, НаЗаписьСтарый, НаЧтениеНовый, НаЗаписьНовый);     
		Если НЕ ПаролиУстановлены Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
	КонецПопытки;
	
	Возврат ПаролиУстановлены;

КонецФункции // УстановитьПаролиНаПамятьКлюча()

// В зависимости от параметра Тип возвращает следующие значения:
//	0 - Общее количество установленных лицензий
//	1 - Общее количество использованных лицензий
//	2 - Общее количество свободных лицензий
// Информация об ошибке возвращается в ОписаниеОшибки
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//	Тип - Число - Тип возвращаемого количества лицензий
//					0 - Общее количество установленных лицензий
//					1 - Общее количество использованных лицензий
//					2 - Общее количество свободных лицензий
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Число   - количество лицензий
//
Функция ПолучитьОбщееКоличествоЛицензий(Знач Серия, Тип = 0, ОписаниеОшибки = "")	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		ОбщееКоличествоЛицензий = МенеджерОбъектов.ПопыткаПолучитьОбщееКоличествоЛицензий(Тип);     
		Если ОбщееКоличествоЛицензий = Неопределено Тогда
			ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Возврат 0;
	КонецПопытки;
	
	Возврат ОбщееКоличествоЛицензий;

КонецФункции // ПолучитьОбщееКоличествоЛицензий()

// Освобождает лицензию сеанса в клиент-серверном варианте работы
// В клиент-серверном варианте работы при завершении работы конфигурации 
// компонента остается загруженной в процессе сервера 1С и, если ей не указать, 
// продолжает занимать лицензии сеансов
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК. Если не указана
//					 освобождаются все занятые лицензии СЛК.
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Булево   - результат удаления менеджера серии защиты
//
Функция ОсвободитьЛицензиюСеанса(Знач Серия = Неопределено, ОписаниеОшибки = "")	Экспорт
	
	Возврат слкМенеджерЗащитыСервер.УдалитьМенеджерСерииЗащиты(Серия, ОписаниеОшибки);

КонецФункции // ОсвободитьЛицензиюСеанса()

// Возвращает в виде строки список регистрационных номеров ключей используемой серии 
// установленных на сервере СЛК. Информация об ошибке возвращается в ОписаниеОшибки.
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//                 
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//                 
//	ОтборПоТипуКлюча - Число,Неопределено - Регистрационные номера с учетом отбора 
//						по типу ключей:
//						3 – основной, 4 – дополнительный, неопределено - без отбора
//
// Возвращаемое значение:
//   Строка	- список регистрационных номеров ключей  используемой серии 
//				установленных на сервере СЛК. Строка имеет следующий формат:
//				РегНомер1;РегНомер2;…
//				Где: РегНомер – регистрационный номер, связанный с С/Н 
//								(пустая строка, если не связан)
//
Функция ПолучитьРегНомераКлючей(Знач Серия, ОписаниеОшибки = "", Знач ОтборПоТипуКлюча = Неопределено)	Экспорт
	
	Попытка
		МенеджерОбъектов = ПолучитьМенеджерОбъектовСерииЗащиты(Серия);
		
		// Информация о ключах защиты
		СписокКлючей = МенеджерОбъектов.ПопыткаПолучитьСписокКлючей();     
		Если СписокКлючей = Неопределено Тогда
			слкМенеджерЗащиты.ВызватьИсключениеСЛК(МенеджерОбъектов.ПолучитьОписаниеОшибки(), Серия);
		КонецЕсли;
		
		Если ОтборПоТипуКлюча = Неопределено Тогда
			КлючиЗащиты = слкМенеджерЗащитыПовтИсп.ТаблицаИзСпискаКлючейЗащиты(СписокКлючей);
		Иначе
			КлючиЗащиты = слкМенеджерЗащитыПовтИсп.ТаблицаИзСпискаКлючейЗащиты(СписокКлючей).Скопировать(Новый Структура("Тип", ОтборПоТипуКлюча));
		КонецЕсли;
		
		Если КлючиЗащиты = Неопределено Тогда
			Возврат "";
		Иначе
			Возврат СтрСоединить(КлючиЗащиты.ВыгрузитьКолонку("РегНомер"), ";");
		КонецЕсли;
		
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		Возврат "";
	КонецПопытки;

КонецФункции // ПолучитьРегНомераКлючей()

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает актуальность версии компоненты СЛК 
//
// Параметры:
//	Версия - Строка - минимальное значение версии
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Булево   - Верия компоненты СЛК актуальна
//
Функция ПроверитьВерсиюКомпонентыСЛК(Знач Версия, ОписаниеОшибки = "") Экспорт
	
	Если слкМенеджерЗащитыСервер.ПодключитьКомпонентуСЛК( ,ОписаниеОшибки) Тогда
		МенеджерЛицензий = Новый("AddIn.Licence.LicenceExtension20");
		Возврат МенеджерЛицензий.ПроверитьВерсию(Версия);
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

// Регламентная процедура проверки лицензий сеанса. Актуально для нескольких 
// баз размещенных на одном сервере приложений при клиент-серверном взаимодействии
//
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Булево   - в случае успеха возвращает Истина, в случае ошибки - Ложь
// 
Функция ПроверитьЛицензииСеанса(ОписаниеОшибки = "")	Экспорт
	
	Результат = Истина;
	
	МенеджерЗащиты = слкМенеджерЗащитыСервер.ПолучитьМенеджерЗащиты(Ложь);
	Для каждого СерияКлючейЗащиты Из МенеджерЗащиты Цикл
		Если НЕ ПроверитьЛицензиюСеанса(СерияКлючейЗащиты.Ключ, ОписаниеОшибки) Тогда
			Результат = Ложь;
		КонецЕсли;
	КонецЦикла;

	Возврат Результат;
	
КонецФункции


// Версия используемого модуля компоненты СЛК
//
// Параметры:
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//
// Возвращаемое значение:
//   Строка   - Верия компоненты СЛК
//
Функция ВерсияКомпонентыСЛК(ОписаниеОшибки = "") Экспорт
	
	Если слкМенеджерЗащитыСервер.ПодключитьКомпонентуСЛК( ,ОписаниеОшибки) Тогда
		МенеджерЛицензий = Новый("AddIn.Licence.LicenceExtension20");
		Возврат МенеджерЛицензий.Версия;
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

// Сообщение об ошибке СЛК с возможностью указания серии защиты
// При выполнении очищает параметр Описание ошибки
//
// Параметры:
//  ОписаниеОшибки  - Строка - Информация об ошибке 
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//						(может не указываться)
//
Процедура СообщитьОбОшибкеСЛК(Знач ОписаниеОшибки, Серия = "")	Экспорт

	Если ЗначениеЗаполнено(ОписаниеОшибки) Тогда
					
		ИмяСобытия = НСтр("ru = 'Ошибка лицензирования '");

		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = ИмяСобытия + ?(ЗначениеЗаполнено(Серия), "(" + Серия + ")", "")
		 + ": " + ОписаниеОшибки;
		 
		 Сообщение.Сообщить();

		Если Метаданные.ОбщиеМодули.Найти("ЖурналРегистрацииВызовСервера") <> Неопределено Тогда
			
			СтруктураСообщения = Новый Структура;
			СтруктураСообщения.Вставить("ИмяСобытия", ИмяСобытия);
			СтруктураСообщения.Вставить("ПредставлениеУровня", "Ошибка");
			СтруктураСообщения.Вставить("Комментарий", ОписаниеОшибки);
			
			СообщенияДляЖурналаРегистрации = Новый СписокЗначений;
			СообщенияДляЖурналаРегистрации.Добавить(СтруктураСообщения);
			
			Выполнить("ЖурналРегистрацииВызовСервера.ЗаписатьСобытияВЖурналРегистрации(СообщенияДляЖурналаРегистрации)");
			
		КонецЕсли;
		
	КонецЕсли;
	
	ОписаниеОшибки = "";
		
КонецПроцедуры

// Вызов исключения ошибки СЛК с возможностью указания серии защиты
// При выполнении очищает параметр Описание ошибки
//
// Параметры:
//  ОписаниеОшибки  - Строка - Информация об ошибке 
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//						(может не указываться)
//
Процедура ВызватьИсключениеСЛК(Знач ОписаниеОшибки, Серия = "")	Экспорт

	Если ЗначениеЗаполнено(ОписаниеОшибки) Тогда
					
		ИмяСобытия = НСтр("ru = 'Ошибка лицензирования '");

		ТекстИсключения = ИмяСобытия + ?(ЗначениеЗаполнено(Серия), "(" + Серия + ")", "")
		 + ": " + ОписаниеОшибки;
		 
		 ВызватьИсключение ТекстИсключения;
		
	КонецЕсли;
	
	ОписаниеОшибки = "";
		
КонецПроцедуры

#Если Сервер Тогда

// Возвращает менеджер серии защиты. Структура, содержащая МенеджерОбъектов СЛК и 
// описывающая  параметры подключения серии защиты.
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//  КомандаМенеджераЗащиты  - Строка - Команда, выполняемая менеджером защиты
//							Поддерживаемые команды:
//							 - ПодключитьЕслиНеЗапущен
//							 - Отключить
//                 
// Возвращаемое значение:
//   Структурв   - Менеджер серии защиты
//
Функция ПолучитьМенеджерСерииЗащиты(Знач Серия, ОписаниеОшибки = "")	Экспорт
	
	Возврат слкМенеджерЗащитыПовтИсп.ПолучитьМенеджерСерииЗащиты(Серия);

КонецФункции // ПолучитьМенеджерСерииЗащиты()

// Возвращает менеджер объектов серии защиты.
//
// Параметры:
//	Серия - Строка - Уникальная серия ключей защиты СЛК
//  ОписаниеОшибки  - Строка - Информация об ошибке полученная вызовом функции 
//						СЛК ПолучитьОписаниеОшибки (описание последней ошибки)
//  КомандаМенеджераЗащиты  - Строка - Команда, выполняемая менеджером защиты
//							Поддерживаемые команды:
//							 - ПодключитьЕслиНеЗапущен
//							 - Отключить
//                 
// Возвращаемое значение:
//   Структурв   - Менеджер серии защиты
//
Функция ПолучитьМенеджерОбъектовСерииЗащиты(Знач Серия, ОписаниеОшибки = "")	Экспорт
	
	Возврат слкМенеджерЗащитыПовтИсп.МенеджерОбъектовСерииЗащиты(Серия);

КонецФункции // ПолучитьМенеджерСерииЗащиты()

#КонецЕсли

#КонецОбласти
