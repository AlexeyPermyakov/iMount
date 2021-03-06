#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Если Параметры.Детализация Тогда
		Заголовок = "Детализация";
		АвтоЗаголовок = Ложь;
	КонецЕсли;
	
	ШаблонРасчета = Параметры.ШаблонРасчета;
	ЗаполнитьТекстПодсказки();
	
	Если Не Пользователи.ЭтоПолноправныйПользователь(Пользователи.ТекущийПользователь()) Тогда
		Этотобъект.ТолькоПросмотр = Не ПравоДоступа("Изменение", Метаданные.Справочники.гисПоказатели);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПринятьИзменения(Команда)
	Закрыть(ШаблонРасчета);
КонецПроцедуры

&НаКлиенте
Процедура КонструкторЗапроса(Команда)
	Конструктор = Новый КонструкторЗапроса;
	Конструктор.Текст = ШаблонРасчета;
	Конструктор.Показать(Новый ОписаниеОповещения("КонструкторЗапросаЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура КонструкторЗапросаЗавершение(Текст, дополнительныеПараметры) Экспорт
	Если Текст <> Неопределено Тогда
		ШаблонРасчета = Текст;
		Модифицированность = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура Подсказка(Команда)
	Элементы.Подсказка.Пометка = Не Элементы.Подсказка.Пометка;
	Элементы.ГруппаПодсказка.Видимость = Элементы.Подсказка.Пометка;
КонецПроцедуры

&НаКлиенте
Процедура ПодсказкаОбновить(Команда)
	ЗаполнитьТекстПодсказки();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ЗаполнитьТекстПодсказки()
	Если Параметры.Детализация Тогда
		ПодсказкаТекст = "Запрос для задания детализации объекта по показателю.
		|
		|Можно использовать параметры (они будут подставлены программно):
		|	Объект - гео-объект, по которому строится тематика;
		|	Дата - дата, на которую строится тематика;
		|	ДатаНачала - дата начала периода для построения тематики;
		|	Показатель - показатель, по которому строится тематика;
		|	Значение - значение объекта по показателю.
		|
		|Все выбранные поля в запросе попадут в отчет.
		|
		|
		|
		|Пример:
		|
		|
		|ВЫБРАТЬ
		|	Родитель, Долгота, Широта
		|ИЗ
		|	Справочник.гисОбъектыКарты
		|ГДЕ
		|	Ссылка = &Объект
		|
		|";
	Иначе
		ПодсказкаТекст = "Запрос для задания значения показателя для объекта.
		|
		|Можно использовать параметры (они будут подставлены программно):
		|	Объект - гео-объект, по которому строится тематика;
		|	Дата - дата, на которую строится тематика;
		|	ДатаНачала - дата начала периода для построения тематики;
		|	Показатель - показатель, по которому строится тематика.
		|
		|Значение показателя должно в запросе иметь синоним ""Значение"".
		|
		|
		|
		|Пример:
		|
		|
		|ВЫБРАТЬ
		|	СУММА(ЗначенияПоказателей.ЗначениеЧисло) КАК Значение
		|ИЗ
		|	РегистрСведений.гисЗначенияПоказателейОбъектов.СрезПоследних(&Дата, Период >= &ДатаНачала И Показатель = &Показатель) КАК ЗначенияПоказателей
		|ГДЕ
		|	ЗначенияПоказателей.Объект.Родитель = &Объект
		|
		|СГРУППИРОВАТЬ ПО
		|	ЗначенияПоказателей.Объект.Родитель
		|";
	КонецЕсли;
КонецПроцедуры

#КонецОбласти
