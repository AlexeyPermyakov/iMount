
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Объект.Ссылка.Пустая() И Не ЗначениеЗаполнено(Объект.ТипЗначения) Тогда
		Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Число;
	КонецЕсли;
	ОбновитьВидимость();
	СправочникИмяЗаполнитьСписокВыбора();
	
	ЗагрузитьЦвета(Параметры.ЗначениеКопирования);
	
	Если ЗначениеЗаполнено(Параметры.СлойКарты) Тогда
		Элементы.СлоиКарты.Видимость = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ЗначениеЗаполнено(Параметры.СлойКарты) Тогда
		СлоиКартыПриАктивизацииСтроки(Элементы.СлоиКарты);
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	Если Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Справочник Тогда
		Если Не ЗначениеЗаполнено(Объект.СправочникИмя) Тогда
			ОбщегоНазначения.СообщитьПользователю("Не выбран справочник!", , "Объект.СправочникИмя", , Отказ);
		ИначеЕсли Элементы.СправочникВладелецЗначений.Видимость И Не ЗначениеЗаполнено(Объект.СправочникВладелецЗначений) Тогда
			ОбщегоНазначения.СообщитьПользователю("не выбран владелец значений!", , "Объект.СправочникВладелецЗначений", , Отказ);
		КонецЕсли;
	Иначе
		ТекущийОбъект.СправочникИмя = "";
		ТекущийОбъект.СправочникВладелецЗначений = Неопределено;
	КонецЕсли;
	СохранитьЦвета(ТекущийОбъект);
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	ЗагрузитьЦвета();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТекущееВсплывающееСообщениеЗаполненоНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(ТекущийСлойКарты) Тогда
		ОткрытьФорму("Справочник.гисПоказатели.Форма.РедакторВсплывающегоСообщения", Новый Структура("Подпись,СлойКарты,Тематика", ТекущееВсплывающееСообщение, ТекущийСлойКарты, Истина), , , , , 
			Новый ОписаниеОповещения("ТекущееВсплывающееСообщениеЗаполненоНажатиеЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не выбран слой!'"), , "Объект.СлоиКарты");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТекущееВсплывающееСообщениеЗаполненоНажатиеЗавершение(ВозвращенноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВозвращенноеЗначение <> Неопределено И ВозвращенноеЗначение <> КодВозвратаДиалога.Отмена Тогда
		Строки = Объект.СлоиКарты.НайтиСтроки(Новый Структура("КлючСтроки", ТекущийКлючСтроки));
		Если Строки.Количество() > 0 Тогда
			ТекущееВсплывающееСообщение = ВозвращенноеЗначение;
			Строки[0].ВсплывающееСообщение = ТекущееВсплывающееСообщение;
			ВсплывающееСообщениеЗаполненоУстановитьТекст();
			
			Модифицированность = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ТекущийШаблонРасчетаЗаполненНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(ТекущийСлойКарты) Тогда
		ОткрытьФорму("Справочник.гисПоказатели.Форма.ШаблонРасчета", Новый Структура("ШаблонРасчета", ТекущийШаблонРасчета), , , , , 
			Новый ОписаниеОповещения("ТекущийШаблонРасчетаЗаполненНажатиеЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не выбран слой!'"), , "Объект.СлоиКарты");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТекущийШаблонРасчетаЗаполненНажатиеЗавершение(ВозвращенноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВозвращенноеЗначение <> Неопределено И ВозвращенноеЗначение <> КодВозвратаДиалога.Отмена Тогда
		Строки = Объект.СлоиКарты.НайтиСтроки(Новый Структура("КлючСтроки", ТекущийКлючСтроки));
		Если Строки.Количество() > 0 Тогда
			ТекущийШаблонРасчета = ВозвращенноеЗначение;
			Строки[0].ШаблонРасчета = ТекущийШаблонРасчета;
			ШаблонРасчетаЗаполненУстановитьТекст();
			
			Модифицированность = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ТекущаяДетализацияЗаполненаНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	Если ЗначениеЗаполнено(ТекущийСлойКарты) Тогда
		ОткрытьФорму("Справочник.гисПоказатели.Форма.ШаблонРасчета", Новый Структура("ШаблонРасчета,Детализация", ТекущаяДетализация, Истина), , , , , 
			Новый ОписаниеОповещения("ТекущаяДетализацияЗаполненаНажатиеЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	Иначе
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Не выбран слой!'"), , "Объект.СлоиКарты");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТекущаяДетализацияЗаполненаНажатиеЗавершение(ВозвращенноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВозвращенноеЗначение <> Неопределено И ВозвращенноеЗначение <> КодВозвратаДиалога.Отмена Тогда
		Строки = Объект.СлоиКарты.НайтиСтроки(Новый Структура("КлючСтроки", ТекущийКлючСтроки));
		Если Строки.Количество() > 0 Тогда
			ТекущаяДетализация = ВозвращенноеЗначение;
			Строки[0].Детализация = ТекущаяДетализация;
			ДетализацияЗаполненаУстановитьТекст();
			
			Модифицированность = Истина;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура ТипЗначенияПриИзменении(Элемент)
	Если Не ЗначениеЗаполнено(Объект.ТипЗначения) Тогда
		Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.гисПоказателиТипы.Число");
		Возврат;
	КонецЕсли;
	ОбновитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура СправочникИмяНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СправочникИмяЗаполнитьСписокВыбора();
КонецПроцедуры

&НаКлиенте
Процедура СправочникИмяПриИзменении(Элемент)
	ОбновитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура СправочникВладелецЗначенийНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	
	СписокТипов = СправочникВладелецЗначенийПолучитьСписокТипов();
	
	Тип = Неопределено;
	Если СписокТипов.Количество() > 1 Тогда
		ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ЗавершениеВыбораТипаИзСписка", ЭтотОбъект), СписокТипов);
		Возврат;
	ИначеЕсли СписокТипов.Количество() = 1 Тогда
		Тип = СписокТипов[0].Значение;
	КонецЕсли;
	
	ОткрытиеФормыВыбораТипа(Тип);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеВыбораТипаИзСписка(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Тип = Неопределено;
	Если ВыбранноеЗначение <> Неопределено Тогда
		Тип = ВыбранноеЗначение.Значение;
	КонецЕсли;
	
	ОткрытиеФормыВыбораТипа(Тип);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытиеФормыВыбораТипа(Тип)
	Если Тип = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФорму("Справочник." + Тип + ".ФормаВыбора", Новый Структура("ТекущаяСтрока,РежимВыбора", Объект.СправочникВладелецЗначений, Истина), , , , , 
		Новый ОписаниеОповещения("ЗавершениеВыбораВладельца", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ЗавершениеВыбораВладельца(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	Если ВыбранноеЗначение <> Неопределено Тогда 
		Объект.СправочникВладелецЗначений = ВыбранноеЗначение;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСлоиКарты

&НаКлиенте
Процедура СлоиКартыПриАктивизацииСтроки(Элемент)
	Если Не Элементы.СлоиКарты.Видимость Тогда
		Строки = Объект.СлоиКарты.НайтиСтроки(Новый Структура("СлойКарты", Параметры.СлойКарты));
		Если Строки.Количество() = 0 Тогда
			НоваяСтрока = Объект.СлоиКарты.Добавить();
			НоваяСтрока.СлойКарты = Параметры.СлойКарты;
			НоваяСтрока.КлючСтроки = ПолучитьНовыйКлючСтроки("СлоиКарты");
			ТекущаяСтрока = НоваяСтрока;
		Иначе
			ТекущаяСтрока = Строки[0];
		КонецЕсли;
		
		Элементы.ЦветаПоказателей.ОтборСтрок = Новый ФиксированнаяСтруктура("КлючСтрокиСлоиКарты", ТекущаяСтрока.КлючСтроки);
		ТекущийСлойКарты			= Параметры.СлойКарты;
		ТекущийКлючСтроки			= ТекущаяСтрока.КлючСтроки;
		ТекущееВсплывающееСообщение = ТекущаяСтрока.ВсплывающееСообщение;
		ТекущийШаблонРасчета		= ТекущаяСтрока.ШаблонРасчета;
		ТекущаяДетализация			= ТекущаяСтрока.Детализация;
	ИначеЕсли Элементы.СлоиКарты.ТекущиеДанные <> Неопределено Тогда
		ТекущаяСтрока				= Элементы.СлоиКарты.ТекущиеДанные;
		
		Элементы.ЦветаПоказателей.ОтборСтрок = Новый ФиксированнаяСтруктура("КлючСтрокиСлоиКарты", ТекущаяСтрока.КлючСтроки);
		ТекущийСлойКарты			= ТекущаяСтрока.СлойКарты;
		ТекущийКлючСтроки			= ТекущаяСтрока.КлючСтроки;
		ТекущееВсплывающееСообщение = ТекущаяСтрока.ВсплывающееСообщение;
		ТекущийШаблонРасчета		= ТекущаяСтрока.ШаблонРасчета;
		ТекущаяДетализация			= ТекущаяСтрока.Детализация;
	Иначе
		Элементы.ЦветаПоказателей.ОтборСтрок = Новый ФиксированнаяСтруктура("КлючСтрокиСлоиКарты", Неопределено);
		ТекущийСлойКарты			= Неопределено;
		ТекущийКлючСтроки			= 0;
		ТекущееВсплывающееСообщение = "";
		ТекущийШаблонРасчета		= "";
		ТекущаяДетализация			= "";
	КонецЕсли;
	ВсплывающееСообщениеЗаполненоУстановитьТекст();
	ШаблонРасчетаЗаполненУстановитьТекст();
	ДетализацияЗаполненаУстановитьТекст();
	
	УстановитьУсловноеОформление();
КонецПроцедуры


&НаКлиенте
Процедура СлоиКартыПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Отказ = Истина;
	
	ТипыГеометрии = Новый СписокЗначений;
	ТипыГеометрии.Добавить(ПредопределенноеЗначение("Перечисление.гисТипыГеометрии.Точка"));
	ТипыГеометрии.Добавить(ПредопределенноеЗначение("Перечисление.гисТипыГеометрии.Линия"));
	ТипыГеометрии.Добавить(ПредопределенноеЗначение("Перечисление.гисТипыГеометрии.Полигон"));
	
	Отбор = Новый Структура("ТипСлоя,ТипГеометрии", ПредопределенноеЗначение("Перечисление.гисТипыСлоев.ПоСправочникуОбъектыКарты"), ТипыГеометрии);
	ПараметрыФормы = Новый Структура("Отбор", Отбор);
	Обработчик = Новый ОписаниеОповещения("СлоиКартыПередНачаломДобавленияЗавершение", ЭтотОбъект, Новый Структура("Копирование", Копирование));
	ОткрытьФорму("Справочник.гисСлоиКарты.ФормаВыбора", ПараметрыФормы, , , , , Обработчик, РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура СлоиКартыПередНачаломДобавленияЗавершение(ВыбранныйСлойКарты, ДополнительныеПараметры) Экспорт
	Если ВыбранныйСлойКарты = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если УжеЕстьСлой(ВыбранныйСлойКарты) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю("Выбранный слой карты уже есть в таблице!");
	Иначе
		НоваяСтрока = Объект.СлоиКарты.Добавить();
		НоваяСтрока.СлойКарты = ВыбранныйСлойКарты;
		НоваяСтрока.КлючСтроки = ПолучитьНовыйКлючСтроки("СлоиКарты");
		
		Если ДополнительныеПараметры.Копирование Тогда
			СтрокиРаскраски = Объект.ЦветаПоказателей.НайтиСтроки(Новый Структура("КлючСтрокиСлоиКарты", Элементы.СлоиКарты.ТекущиеДанные.КлючСтроки));
			Для Каждого СтрокаРаскраски Из СтрокиРаскраски Цикл
				НоваяСтрокаРаскраска = Объект.ЦветаПоказателей.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрокаРаскраска, СтрокаРаскраски);
				НоваяСтрокаРаскраска.КлючСтрокиСлоиКарты = НоваяСтрока.КлючСтроки;
			КонецЦикла;
			
			Если Найти(Элементы.СлоиКарты.ТекущиеДанные.ВсплывающееСообщение, "[Объект.ОбъектУчета.") > 0 Тогда
				Если РазныеСправочникиОбъектовУчета(Элементы.СлоиКарты.ТекущиеДанные.СлойКарты, ВыбранныйСлойКарты) Тогда
					ПоказатьПредупреждение(, "У выбранного слоя карты другой справочник объектов учета! Проверьте всплывающее сообщение!");
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Элементы.СлоиКарты.ТекущаяСтрока = НоваяСтрока.ПолучитьИдентификатор();
		СлоиКартыПриАктивизацииСтроки(Элементы.СлоиКарты);
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры


&НаКлиенте
Процедура СлоиКартыПередУдалением(Элемент, Отказ)
	Отказ = Истина;
	Строки = Объект.ЦветаПоказателей.НайтиСтроки(Новый Структура("КлючСтрокиСлоиКарты", Элементы.СлоиКарты.ТекущиеДанные.КлючСтроки));
	Если Строки.Количество() > 0 Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("СлоиКартыПередУдалениемВопрос", ЭтотОбъект), 
			"Раскраска будет удалена! Продолжить?", РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет);
	Иначе
		СлоиКартыПередУдалениемЗавершение();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СлоиКартыПередУдалениемВопрос(Ответ, ДополнительныеПараметры) Экспорт
	Если Ответ = КодВозвратаДиалога.Да Тогда
		СлоиКартыПередУдалениемЗавершение();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СлоиКартыПередУдалениемЗавершение()
	Раскраска = Объект.ЦветаПоказателей.НайтиСтроки(Новый Структура("КлючСтрокиСлоиКарты", Элементы.СлоиКарты.ТекущиеДанные.КлючСтроки));
	Для Каждого Строка Из Раскраска Цикл
		Объект.ЦветаПоказателей.Удалить(Строка);
	КонецЦикла;
	
	Объект.СлоиКарты.Удалить(Элементы.СлоиКарты.ТекущиеДанные);
	Модифицированность = Истина;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыЦветаПоказателей

&НаКлиенте
Процедура ЦветаПоказателейПриИзменении(Элемент)
	УстановитьУсловноеОформление();
КонецПроцедуры

&НаКлиенте
Процедура ЦветаПоказателейПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
	Если Элементы.СлоиКарты.ТекущиеДанные = Неопределено И Элементы.СлоиКарты.Видимость Тогда
		Отказ = Истина;
		ОбщегоНазначенияКлиент.СообщитьПользователю("Не выбран слой!", , "Объект.СлоиКарты");
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЦветаПоказателейПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	Если НоваяСтрока Тогда
		ТипЗначения = ПолучитьТипЗначения(Объект.ТипЗначения, Объект.СправочникИмя);
		Элементы.ЦветаПоказателей.ТекущиеДанные.ЗначениеОт = ТипЗначения.ПривестиЗначение(Элементы.ЦветаПоказателей.ТекущиеДанные.ЗначениеОт);
		Элементы.ЦветаПоказателей.ТекущиеДанные.ЗначениеДо = ТипЗначения.ПривестиЗначение(Элементы.ЦветаПоказателей.ТекущиеДанные.ЗначениеДо);
		Элементы.ЦветаПоказателей.ТекущиеДанные.КлючСтрокиСлоиКарты = ТекущийКлючСтроки;
		ЦветаПоказателейПриИзменении(Элемент);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЦветаПоказателейЦветНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОткрытьФорму("ОбщаяФорма.гисФормаВыбораЦветаRGB", Новый Структура("Цвет", Элементы.ЦветаПоказателей.ТекущиеДанные.ЦветФона), Элемент, , , , 
		Новый ОписаниеОповещения("ЦветаПоказателейЦветНачалоВыбораЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура ЦветаПоказателейЦветНачалоВыбораЗавершение(ВыбранныеЦвет, ДополнительныеПараметры) Экспорт
	Если ТипЗнч(ВыбранныеЦвет) = Тип("Цвет") Тогда
		Элементы.ЦветаПоказателей.ТекущиеДанные.ЦветФона = ВыбранныеЦвет;
		УстановитьУсловноеОформление();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЦветаПоказателейЗначениеОтНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Если Объект.ТипЗначения = "Справочник" Тогда
		Если ЗначениеЗаполнено(Объект.СправочникВладелецЗначений) Тогда
			НовыйПараметр = Новый ПараметрВыбора("Отбор.Владелец", Объект.СправочникВладелецЗначений);
			НовыйМассив = Новый Массив();
			НовыйМассив.Добавить(НовыйПараметр);
			НовыеПараметры = Новый ФиксированныйМассив(НовыйМассив);
			Элемент.ПараметрыВыбора = НовыеПараметры;
		Иначе
			НовыйМассив = Новый Массив();
			НовыеПараметры = Новый ФиксированныйМассив(НовыйМассив);
			Элемент.ПараметрыВыбора = НовыеПараметры;
		КонецЕсли;
		
		Если Не ЗначениеЗаполнено(Объект.СправочникИмя) Тогда
			СтандартнаяОбработка = Ложь;
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Автозаполнение(Команда)
	Если Элементы.СлоиКарты.ТекущиеДанные = Неопределено И Элементы.СлоиКарты.Видимость Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыФормы = Новый Структура("СлойКарты,Показатель", ТекущийСлойКарты, Объект.Ссылка);
	ОткрытьФорму("Справочник.гисПоказатели.Форма.ФормаАвтозаполнениеНастройки", ПараметрыФормы, , , , , 
		Новый ОписаниеОповещения("АвтозаполнениеЗавершение", ЭтотОбъект), РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
КонецПроцедуры

&НаКлиенте
Процедура АвтозаполнениеЗавершение(Настройки, ДополнительныеПараметры) Экспорт
	Если Настройки <> Неопределено И Настройки <> КодВозвратаДиалога.Отмена Тогда
		АвтозаполнениеНаСервере(Настройки, ТекущийКлючСтроки);
		ЗаполнитьПодписи(Команды.ЗаполнитьПодписи);
		
		УстановитьУсловноеОформление();
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПодписи(Команда)
	Если Элементы.СлоиКарты.ТекущиеДанные = Неопределено И Элементы.СлоиКарты.Видимость Тогда
		Возврат;
	КонецЕсли;
	
	ЭтоЧисло = Объект.ТипЗначения = ПредопределенноеЗначение("Перечисление.гисПоказателиТипы.Число");
	
	Строки = Объект.ЦветаПоказателей.НайтиСтроки(Новый Структура("КлючСтрокиСлоиКарты", ТекущийКлючСтроки));
	Для Каждого Строка Из Строки Цикл
		Если ЭтоЧисло Тогда
			Строка.Подпись = "от " + Строка.ЗначениеОт + " до " + Строка.ЗначениеДо;
		Иначе
			Строка.Подпись = Строка(Строка.ЗначениеОт);
		КонецЕсли;
	КонецЦикла;
	
	Модифицированность = Истина;
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура ПересчетДляЧисел(Таблица, КоличествоГрадаций, ЗначениеМин, ЗначениеМакс, ЦветНачала, ЦветКонца)
	Если КоличествоГрадаций < 1 Тогда
		Возврат;
	ИначеЕсли  КоличествоГрадаций = 1 Тогда
		НоваяГрадация = Таблица.Добавить();
		НоваяГрадация.ЦветФона = ЦветНачала;
		НоваяГрадация.ЗначениеОт = ЗначениеМин;
		НоваяГрадация.ЗначениеДо = ЗначениеМакс;
		Возврат;
	КонецЕсли;	
	
	ТекущееЗначение = ЗначениеМин;
	Шаг = (ЗначениеМакс - ТекущееЗначение) / КоличествоГрадаций;
	
	ТекущийКрасный	= ЦветНачала.Красный;
	ТекущийЗеленый	= ЦветНачала.Зеленый;
	ТекущийСиний	= ЦветНачала.Синий;
	КонечныйКрасный = ЦветКонца.Красный;
	КонечныйЗеленый = ЦветКонца.Зеленый;
	КонечныйСиний	= ЦветКонца.Синий;
	ШагКрасный = (ТекущийКрасный - КонечныйКрасный) / (КоличествоГрадаций - 1);
	ШагЗеленый = (ТекущийЗеленый - КонечныйЗеленый) / (КоличествоГрадаций - 1);
	ШагСиний = (ТекущийСиний - КонечныйСиний) / (КоличествоГрадаций - 1);
	
	Номер = 1;
	Пока Номер <= КоличествоГрадаций Цикл
		НоваяГрадация = Таблица.Добавить();
		НоваяГрадация.ЦветФона = Новый Цвет(Окр(ТекущийКрасный), Окр(ТекущийЗеленый), Окр(ТекущийСиний));
		НоваяГрадация.ЗначениеОт = ТекущееЗначение;
		
		ТекущееЗначение = ТекущееЗначение + Шаг;
		НоваяГрадация.ЗначениеДо = ТекущееЗначение;
		
		ТекущийКрасный = ТекущийКрасный - ШагКрасный;
		ТекущийЗеленый = ТекущийЗеленый - ШагЗеленый;
		ТекущийСиний = ТекущийСиний - ШагСиний;
		Номер = Номер + 1;
	КонецЦикла;	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПересчетДляЭлементовСправочника(Таблица, ЦветНачала, ЦветКонца, Показатель, ВыборИзСправочника, ВладелецЗначений)
	Если Не ЗначениеЗаполнено(ВыборИзСправочника) Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Таблица.Ссылка
	|ИЗ
	|	Справочник." + ВыборИзСправочника + " КАК Таблица
	|ГДЕ
	|	НЕ ПометкаУдаления
	|
	|УПОРЯДОЧИТЬ ПО
	|	Таблица.Код";
	Если ЗначениеЗаполнено(ВладелецЗначений) Тогда
		Запрос.Текст = СтрЗаменить(Запрос.Текст, "ГДЕ", "ГДЕ Таблица.Владелец = &Владелец И");
		Запрос.УстановитьПараметр("Владелец", ВладелецЗначений);
	КонецЕсли;
	МассивЗначений = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Ссылка");
	
	КоличествоГрадаций = МассивЗначений.Количество();
	
	ТекущийКрасный	= ЦветНачала.Красный;
	ТекущийЗеленый	= ЦветНачала.Зеленый;
	ТекущийСиний	= ЦветНачала.Синий;
	КонечныйКрасный = ЦветКонца.Красный;
	КонечныйЗеленый = ЦветКонца.Зеленый;
	КонечныйСиний	= ЦветКонца.Синий;
	ШагКрасный	= (ТекущийКрасный - КонечныйКрасный) / (КоличествоГрадаций - 1);
	ШагЗеленый	= (ТекущийЗеленый - КонечныйЗеленый) / (КоличествоГрадаций - 1);
	ШагСиний	= (ТекущийСиний - КонечныйСиний) / (КоличествоГрадаций - 1);
	
	Индекс = 0;
	Пока Индекс < КоличествоГрадаций Цикл
		НоваяГрадация = Таблица.Добавить();
		НоваяГрадация.ЦветФона = Новый Цвет(Окр(ТекущийКрасный), Окр(ТекущийЗеленый), Окр(ТекущийСиний));
		НоваяГрадация.ЗначениеОт = МассивЗначений[Индекс];
		
		Индекс = Индекс + 1;
		
		ТекущийКрасный = ТекущийКрасный - ШагКрасный;
		ТекущийЗеленый = ТекущийЗеленый - ШагЗеленый;
		ТекущийСиний = ТекущийСиний - ШагСиний;
	КонецЦикла;	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПересчетДляБулево(Таблица, ЦветНачала, ЦветКонца)
	НоваяГрадация = Таблица.Добавить();
	НоваяГрадация.ЦветФона = ЦветНачала;
	НоваяГрадация.ЗначениеОт = Ложь;
	
	НоваяГрадация = Таблица.Добавить();
	НоваяГрадация.ЦветФона = ЦветКонца;
	НоваяГрадация.ЗначениеОт = Истина;
КонецПроцедуры


&НаСервереБезКонтекста
Функция РазныеСправочникиОбъектовУчета(Слой1, Слой2)
	Возврат Слой1.СправочникОбъектовУчета <> Слой2.СправочникОбъектовУчета;
КонецФункции


&НаСервереБезКонтекста
Функция ПолучитьТипЗначения(ТипЗначения, СправочникИмя)
	Возврат Справочники.гисПоказатели.ПолучитьТипЗначения(ТипЗначения, СправочникИмя);
КонецФункции

&НаСервере
Процедура ОбновитьВидимость()
	Если Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Число Тогда
		Элементы.КоличествоЗнаков.Видимость = Истина;
	Иначе
		Элементы.КоличествоЗнаков.Видимость = Ложь;
	КонецЕсли;
	
	Если Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Справочник Тогда
		Элементы.ГруппаСправочник.Видимость = Истина;
		Если ЗначениеЗаполнено(Объект.СправочникИмя) И Метаданные.Справочники[Объект.СправочникИмя].Владельцы.Количество() > 0 Тогда
			ЕстьСправочники = Ложь;
			Для Каждого Владелец Из Метаданные.Справочники[Объект.СправочникИмя].Владельцы Цикл
				Если Метаданные.Справочники.Содержит(Владелец) Тогда
					ЕстьСправочники = Истина;
				КонецЕсли;
			КонецЦикла;
			Элементы.СправочникВладелецЗначений.Видимость = ЕстьСправочники;
			
			Если ЗначениеЗаполнено(Объект.СправочникВладелецЗначений) Тогда
				Нашли = Ложь;
				Для Каждого Владелец Из Метаданные.Справочники[Объект.СправочникИмя].Владельцы Цикл
					Попытка
						Если Тип("СправочникСсылка." + Владелец.Имя) = ТипЗнч(Объект.СправочникВладелецЗначений) Тогда
							Нашли = Истина;
						КонецЕсли;
					Исключение
					КонецПопытки;
				КонецЦикла;
				Если Не Нашли Тогда
					Объект.СправочникВладелецЗначений = Неопределено;
				КонецЕсли;
			КонецЕсли;
		Иначе
			Элементы.СправочникВладелецЗначений.Видимость = Ложь;
			Если ЗначениеЗаполнено(Объект.СправочникВладелецЗначений) Тогда
				Объект.СправочникВладелецЗначений = Неопределено;
			КонецЕсли;
		КонецЕсли;
	Иначе
		Элементы.ГруппаСправочник.Видимость = Ложь;
		Если ЗначениеЗаполнено(Объект.СправочникВладелецЗначений) Тогда
			Объект.СправочникВладелецЗначений = Неопределено;
		КонецЕсли;
	КонецЕсли;
	
	
	Если Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Число Тогда
		Элементы.ЦветаПоказателейЗначениеДо.Видимость = Истина;
		Элементы.ЦветаПоказателейЗначениеОт.Заголовок = "Значение от";
	ИначеЕсли Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Булево Или Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Справочник Тогда
		Элементы.ЦветаПоказателейЗначениеДо.Видимость = Ложь;
		Элементы.ЦветаПоказателейЗначениеОт.Заголовок = "Значение";
	КонецЕсли;
	
	ТипЗначения = ПолучитьТипЗначения(Объект.ТипЗначения, Объект.СправочникИмя);
	Для Каждого Строка Из Объект.ЦветаПоказателей Цикл
		Строка.ЗначениеОт = ТипЗначения.ПривестиЗначение(Строка.ЗначениеОт);
		Строка.ЗначениеДо = ТипЗначения.ПривестиЗначение(Строка.ЗначениеДо);
		Если ТипЗначения = Новый ОписаниеТипов("Неопределено") Тогда
			Строка.ЗначениеОт = Неопределено;
			Строка.ЗначениеДо = Неопределено;
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура УстановитьУсловноеОформление()
	УсловноеОформление.Элементы.Очистить();
	
	Для Каждого Градация Из Объект.ЦветаПоказателей Цикл
		гисОбщегоНазначенияКлиентСервер.ДобавитьЭлементУсловногоОформления(ЭтотОбъект,
			"Объект.ЦветаПоказателей.НомерСтроки", Градация.НомерСтроки, "ЦветаПоказателейЦветФона", Градация.ЦветФона);
	КонецЦикла;
КонецПроцедуры


&НаСервере
Процедура СправочникИмяЗаполнитьСписокВыбора()
	Элементы.СправочникИмя.СписокВыбора.Очистить();
	Для каждого Справочник из Метаданные.Справочники Цикл
		Элементы.СправочникИмя.СписокВыбора.Добавить(Справочник.Имя, Справочник.Синоним);
	КонецЦикла;
	Элементы.СправочникИмя.СписокВыбора.СортироватьПоПредставлению();
КонецПроцедуры

&НаСервере
Функция СправочникВладелецЗначенийПолучитьСписокТипов()
	СписокТипов = Новый СписокЗначений;
	
	Для Каждого Владелец Из Метаданные.Справочники[Объект.СправочникИмя].Владельцы Цикл
		Если Метаданные.Справочники.Содержит(Владелец) Тогда
			СписокТипов.Добавить(Владелец.Имя, ?(ЗначениеЗаполнено(Владелец.Синоним), Владелец.Синоним, Владелец.Имя));
		конецЕсли;
	КонецЦикла;
	
	Возврат СписокТипов;
КонецФункции


&НаСервере
Функция ПолучитьНовыйКлючСтроки(НазваниеТаблицы)
	Если Объект[НазваниеТаблицы].Количество() = 0 Тогда
		Ключ = 1;
	Иначе
		// Если в табл. части уже присутствуют строки, то новое «свободное» значение ключа
		// рассчитывается от максимального существующего значения.
		СписокКлючей = Новый СписокЗначений;
		СписокКлючей.ЗагрузитьЗначения(Объект[НазваниеТаблицы].Выгрузить().ВыгрузитьКолонку("КлючСтроки"));
		СписокКлючей.СортироватьПоЗначению(НаправлениеСортировки.Убыв);
		Ключ = СписокКлючей[0].Значение + 1;
	КонецЕсли;

	Возврат Ключ;
КонецФункции

&НаКлиенте
Функция УжеЕстьСлой(СлойКарты)
	Строки = Объект.СлоиКарты.НайтиСтроки(Новый Структура("СлойКарты", СлойКарты));
	Возврат Строки.Количество() > 0;
КонецФункции


&НаСервере
Процедура ЗагрузитьЦвета(ОткудаПолучатьЦвета = Неопределено)
	Если ЗначениеЗаполнено(ОткудаПолучатьЦвета) Тогда
		ТекущийОбъект = ОткудаПолучатьЦвета.ПолучитьОбъект();
	Иначе
		ТекущийОбъект = РеквизитФормыВЗначение("Объект");
	КонецЕсли;
	
	Для НомерСтроки = 0 По ТекущийОбъект.ЦветаПоказателей.Количество() - 1 Цикл
		Объект.ЦветаПоказателей[НомерСтроки].ЦветФона = ТекущийОбъект.ЦветаПоказателей[НомерСтроки].Цвет.Получить();
	КонецЦикла;
	
	УстановитьУсловноеОформление();
КонецПроцедуры

&НаСервере
Процедура СохранитьЦвета(ТекущийОбъект)
	Для НомерСтроки = 0 По Объект.ЦветаПоказателей.Количество() - 1 Цикл
		ТекущийОбъект.ЦветаПоказателей[НомерСтроки].Цвет = Новый ХранилищеЗначения(Объект.ЦветаПоказателей[НомерСтроки].ЦветФона);
	КонецЦикла;
КонецПроцедуры


&НаСервере
Процедура АвтозаполнениеНаСервере(Настройки, КлючСтроки)
	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("ЦветФона");
	Таблица.Колонки.Добавить("ЗначениеОт");
	Таблица.Колонки.Добавить("ЗначениеДо");
	
	Если Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Число Тогда
		ПересчетДляЧисел(Таблица, Настройки.КоличествоГрадаций, Настройки.ЗначениеМин, Настройки.ЗначениеМакс, Настройки.ЦветНачала, Настройки.ЦветКонца);
	ИначеЕсли Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Справочник Тогда
		ПересчетДляЭлементовСправочника(Таблица, Настройки.ЦветНачала, Настройки.ЦветКонца, Объект.Ссылка, Объект.СправочникИмя, Объект.СправочникВладелецЗначений);
	ИначеЕсли Объект.ТипЗначения = Перечисления.гисПоказателиТипы.Булево Тогда
		ПересчетДляБулево(Таблица, Настройки.ЦветНачала, Настройки.ЦветКонца);
	КонецЕсли;
	
	РаскраскаПоСлою = Объект.ЦветаПоказателей.НайтиСтроки(Новый Структура("КлючСтрокиСлоиКарты", КлючСтроки));
	Для Каждого Строка Из РаскраскаПоСлою Цикл
		Объект.ЦветаПоказателей.Удалить(Строка);
	КонецЦикла;
	
	Для Каждого Строка Из Таблица Цикл
		НоваяСтрока = Объект.ЦветаПоказателей.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
		НоваяСтрока.КлючСтрокиСлоиКарты = КлючСтроки;
	КонецЦикла;
КонецПроцедуры


&НаКлиенте
Процедура ВсплывающееСообщениеЗаполненоУстановитьТекст()
	ТекущееВсплывающееСообщениеЗаполнено = ?(ЗначениеЗаполнено(ТекущееВсплывающееСообщение), НСтр("ru = 'Заполнено'"), НСтр("ru = 'Не заполнено'"));
КонецПроцедуры

&НаКлиенте
Процедура ШаблонРасчетаЗаполненУстановитьТекст()
	ТекущийШаблонРасчетаЗаполнен = ?(ЗначениеЗаполнено(ТекущийШаблонРасчета), НСтр("ru = 'Заполнен'"), НСтр("ru = 'Не заполнен'"));
КонецПроцедуры

&НаКлиенте
Процедура ДетализацияЗаполненаУстановитьТекст()
	ТекущаяДетализацияЗаполнена = ?(ЗначениеЗаполнено(ТекущаяДетализация), НСтр("ru = 'Заполнена'"), НСтр("ru = 'Не заполнена'"));
КонецПроцедуры

#КонецОбласти
