///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область СлужебныйПрограммныйИнтерфейс

// Процедура обновляет кэш-реквизиты регистра по результату изменения состава
// типов значений и групп значений доступа.
//
Процедура ОбновитьВспомогательныеДанныеРегистраПоИзменениямКонфигурации() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	ПоследниеИзменения = СтандартныеПодсистемыСервер.ИзмененияПараметраРаботыПрограммы(
		"СтандартныеПодсистемы.УправлениеДоступом.ТипыГруппИЗначенийДоступа");
	
	Если (ПоследниеИзменения = Неопределено
	      ИЛИ ПоследниеИзменения.Количество() > 0)
	   И Константы.ОграничиватьДоступНаУровнеЗаписей.Получить() Тогда
		
		УправлениеДоступомСлужебный.УстановитьЗаполнениеДанныхДляОграниченияДоступа(Истина);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Процедура обновляет данные регистра при полном обновлении вспомогательных данных.
//
// Параметры:
//  ЕстьИзменения - Булево - (возвращаемое значение) - если производилась запись,
//                  устанавливается Истина, иначе не изменяется.
//
Процедура ОбновитьДанныеРегистра(ЕстьИзменения = Неопределено) Экспорт
	
	СтандартныеПодсистемыСервер.ПроверитьДинамическоеОбновлениеВерсииПрограммы();
	
	КоличествоДанных = 0;
	Пока КоличествоДанных > 0 Цикл
		КоличествоДанных = 0;
		УправлениеДоступомСлужебный.ЗаполнениеДанныхДляОграниченияДоступа(КоличествоДанных, Истина, ЕстьИзменения);
	КонецЦикла;
	
	ТипыОбъектов = УправлениеДоступомСлужебныйПовтИсп.ТипыОбъектовВПодпискахНаСобытия(
		"ЗаписатьНаборыЗначенийДоступа");
	
	Для каждого ОписаниеТипа Из ТипыОбъектов Цикл
		Тип = ОписаниеТипа.Ключ;
		
		Если Тип = Тип("Строка") Тогда
			Продолжить;
		КонецЕсли;
		
		Выборка = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(Метаданные.НайтиПоТипу(Тип).ПолноеИмя()).Выбрать();
		
		Пока Выборка.Следующий() Цикл
			УправлениеДоступомСлужебный.ОбновитьНаборыЗначенийДоступа(Выборка.Ссылка, ЕстьИзменения);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
