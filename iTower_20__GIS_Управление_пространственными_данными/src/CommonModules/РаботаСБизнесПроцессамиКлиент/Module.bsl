
#Область ПрограммныйИнтерфейс

Процедура СкопироватьЗаявку(Форма) Экспорт
	
	//мсвИнтерактивныеОбработки = Новый Массив;
	//
	//// 1. Проверить, записана ли заявка
	//сткДопПараметры = Новый Структура("Форма",	Форма);
	//сткОписаниеОбработки	= лм_ИнтерактивныеОбработкиКлиент.Описание("СохранитьЗаявку", "ПроверитьМодифицированностьЗаявки", ЭтотОбъект, сткДопПараметры);
	//мсвИнтерактивныеОбработки.Добавить(сткОписаниеОбработки);
	//
	//// 2. Задать вопрос о копировании файлов
	//сткДопПараметры = Новый Структура("Форма",	Форма);
	//сткОписаниеОбработки	= лм_ИнтерактивныеОбработкиКлиент.Описание("ВопросСкопироватьФайлы", "ЗадатьВопросОКопированииФайлов", ЭтотОбъект, сткДопПараметры);
	//мсвИнтерактивныеОбработки.Добавить(сткОписаниеОбработки);
	//
	//// 3. Начать копирование заявки
	//сткДопПараметры = Новый Структура("Форма",	Форма);
	//сткОписаниеОбработки	= лм_ИнтерактивныеОбработкиКлиент.Описание("НачатьКопированиеЗаявки", "НачатьКопированиеЗаявки", ЭтотОбъект, сткДопПараметры);
	//мсвИнтерактивныеОбработки.Добавить(сткОписаниеОбработки);
	//
	//лм_ИнтерактивныеОбработкиКлиент.Старт(мсвИнтерактивныеОбработки);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиОповещений

Процедура ПроверитьМодифицированностьЗаявки(Результат, ДополнительныеПараметры) Экспорт
	
	// **********
	// * @ToDo: Проверку и вопрос пользователю
	// **********
	//ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Заявка сохранена'"));
	//сткРезультаты = Новый Структура;
	//сткРезультаты.Вставить("ЗаявкаСохранена",	Истина);
	//
	//лм_ИнтерактивныеОбработкиКлиент.ВыполнитьСледующую(сткРезультаты, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура ЗадатьВопросОКопированииФайлов(Результат, ДополнительныеПараметры) Экспорт
	
	//Если ОбщегоНазначенияMDMВызовСервера.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСФайлами") Тогда
	//	текОповещение	= Новый ОписаниеОповещения("ПослеВопросаОКопированииФайлов", ЭтотОбъект, ДополнительныеПараметры);
	//	текстВопроса	= НСтр("ru = 'Копировать прикрепленные файлы?'");
	//	ПоказатьВопрос(текОповещение, текстВопроса, РежимДиалогаВопрос.ДаНетОтмена, , КодВозвратаДиалога.Да);
	//Иначе
	//	сткРезультаты = Новый Структура;
	//	сткРезультаты.Вставить("КопироватьФайлы",	Ложь);
	//	
	//	лм_ИнтерактивныеОбработкиКлиент.ВыполнитьСледующую(сткРезультаты, ДополнительныеПараметры);
	//КонецЕсли;
	
КонецПроцедуры

Процедура ПослеВопросаОКопированииФайлов(Результат,  ДополнительныеПараметры) Экспорт
	
	//Если Не (    Результат = КодВозвратаДиалога.Да
	//		 Или Результат = КодВозвратаДиалога.Нет) Тогда
	//	// Прерываем обработку
	//	Возврат;
	//КонецЕсли;
	//
	//сткРезультаты = Новый Структура;
	//сткРезультаты.Вставить("КопироватьФайлы",	Результат = КодВозвратаДиалога.Да);
	//
	//лм_ИнтерактивныеОбработкиКлиент.ВыполнитьСледующую(сткРезультаты, ДополнительныеПараметры);
	
КонецПроцедуры

Процедура НачатьКопированиеЗаявки(Результат, ДополнительныеПараметры) Экспорт
	
	//текЗаявка = ДополнительныеПараметры.Форма.Объект.Ссылка;
	//
	//сткДопПараметры = Новый Структура;
	//Если ДополнительныеПараметры.Свойство("Результаты") И ТипЗнч(ДополнительныеПараметры.Результаты) = Тип("Структура") Тогда
	//	Для Каждого кзРезультат Из ДополнительныеПараметры.Результаты Цикл
	//		сткДопПараметры.Вставить(кзРезультат.Ключ, кзРезультат.Значение);
	//	КонецЦикла;
	//КонецЕсли;
	//
	//текНовыйБП = РаботаСБизнесПроцессамиВызовСервера.СкопироватьБизнесПроцессПоЗаявке(текЗаявка, сткДопПараметры);
	//
	//сткРезультаты = Новый Структура;
	//сткРезультаты.Вставить("ЗаявкаСкопирована",	ЗначениеЗаполнено(текНовыйБП));
	//сткРезультаты.Вставить("Заявка",			текНовыйБП);
	//
	//лм_ИнтерактивныеОбработкиКлиент.ВыполнитьСледующую(сткРезультаты, ДополнительныеПараметры);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти

