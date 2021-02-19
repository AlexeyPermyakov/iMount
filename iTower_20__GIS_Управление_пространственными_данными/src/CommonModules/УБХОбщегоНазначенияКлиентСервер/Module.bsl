#Область ПрограммныйИнтерфейс

// Функция возвращает аббревиатуру для типа значения объекта Площадки.
//
// Параметры:
//  ТипЗначенияОбъекта  - Тип.
//
Функция ТипОбъектаПоТипуЗначения(ТипЗначенияОбъекта) Экспорт
	
	Если ТипЗначенияОбъекта = Тип("СправочникСсылка.УБХАМС") Тогда
		ВОзврат "АМС";
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникСсылка.УБХВЛЭС") Тогда
		ВОзврат "ВЛЭС";
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникСсылка.УБХЗемельныеУчастки") Тогда
		ВОзврат "Зем. участок";
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникСсылка.УБХКТП") Тогда
		ВОзврат "КТП";
	ИначеЕсли ТипЗначенияОбъекта = Тип("СправочникСсылка.УБХОсновныеСредства") Тогда
		ВОзврат "Основное средство";
	Иначе
		ВОзврат "";
	КонецЕсли;
	
КонецФункции

// Функция возвращает процент ставки НДС.
//
// Параметры:
//  СтавкаНДС - ПеречислениеСсылка.СтавкиНДС - Ставка НДС.
//
// Возвращаемое значение:
//	Число - Процент ставки НДС.
//
Функция ПолучитьСтавкуНДС(СтавкаНДС) Экспорт
	
	Если СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС10")
		Или СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС10_110") Тогда
		Возврат 10;
	ИначеЕсли СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС18")
		Или СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС18_118") Тогда
		Возврат 18;
	ИначеЕсли СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС20")
		Или СтавкаНДС = ПредопределенноеЗначение("Перечисление.СтавкиНДС.НДС20_120") Тогда
		Возврат 20;
	Иначе
		Возврат 0;
	КонецЕсли;
	
КонецФункции

// Рассчитывает сумму НДС исходя из суммы и флагов налогообложения.
//
// Параметры:
//  Сумма            - Число - сумма от которой надо рассчитывать налоги;
//  СтавкаНДС        - Число - процентная ставка НДС.
//  СуммаВключаетНДС - Булево - признак включения НДС в сумму ("внутри" или "сверху");
//  НалогообложениеНДС - ПеречислениеСсылка.ТипыНалогообложенияНДС - налогообложение документа
//
// Возвращаемое значение:
//  Число - полученная сумма НДС.
//
Функция РассчитатьСуммуНДС(Сумма, СтавкаНДС, СуммаВключаетНДС = Истина, НалогообложениеНДС = Неопределено) Экспорт

	//Если НалогообложениеНДС = ПредопределенноеЗначение("Перечисление.ТипыНалогообложенияНДС.ОблагаетсяНДСУПокупателя") Тогда
	//	Возврат 0;
	//КонецЕсли;

	Если СуммаВключаетНДС Тогда
		СуммаНДС = Окр(Сумма - 100 * Сумма / (100 + СтавкаНДС), 2, РежимОкругления.Окр15как20);
	Иначе
		СуммаНДС = Окр(Сумма * СтавкаНДС / 100, 2, РежимОкругления.Окр15как20);
	КонецЕсли;
	
	Возврат СуммаНДС;

КонецФункции

#КонецОбласти
