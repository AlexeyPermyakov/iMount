
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// лм_УниверсальныеСтруктурыДанных
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		СсылкаНового = Справочники.лм_ВидыУниверсальныхСправочников.ПолучитьСсылку(Новый УникальныйИдентификатор());
	КонецЕсли;
	лм_УниверсальныеСтруктурыДанных.ФормаНастроекПриСозданииНаСервере(ЭтаФорма, СформироватьПараметрыФормыНастроек());
// Конец лм_УниверсальныеСтруктурыДанных	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	// лм_УниверсальныеСтруктурыДанных
	лм_УниверсальныеСтруктурыДанныхКлиент.ЗаписатьДанныеСтруктуры(ЭтаФорма);
// Конец лм_УниверсальныеСтруктурыДанных
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	// лм_УниверсальныеСтруктурыДанных
	лм_УниверсальныеСтруктурыДанныхКлиент.ДобавитьИзменитьДанныеРеквизитаУниверсальнойСтруктуры(ИмяСобытия, Параметр, ЭтаФорма);
// Конец лм_УниверсальныеСтруктурыДанных
	
КонецПроцедуры


&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)	
	
// лм_УниверсальныеСтруктурыДанных
	Если ТекущийОбъект.ЭтоНовый() Тогда
		ТекущийОбъект.УстановитьСсылкуНового(СсылкаНового);
	КонецЕсли;
// Конец лм_УниверсальныеСтруктурыДанных

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

// лм_УниверсальныеСтруктурыДанных

&НаКлиенте
Процедура лм_УниверсальныеСтруктурыДанных_ПередНачаломИзменения(Элемент, Отказ)
	
	лм_УниверсальныеСтруктурыДанныхКлиент.ПередНачаломИзменения(Элемент, Отказ, ЭтаФорма); 
		
КонецПроцедуры

&НаКлиенте
Процедура лм_УниверсальныеСтруктурыДанных_ПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа)
	
	лм_УниверсальныеСтруктурыДанныхКлиент.ПередНачаломДобавления(Элемент, Отказ, Копирование, ЭтаФорма); 
		
КонецПроцедуры

// Конец лм_УниверсальныеСтруктурыДанных

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// лм_УниверсальныеСтруктурыДанных
&НаСервере
Функция СформироватьПараметрыФормыНастроек()
	
	ПараметрыФормы = Новый Структура;
	
	ПараметрыФормы.Вставить("ВыводитьСписокСтруктур", Ложь);
	ПараметрыФормы.Вставить("ИмяГруппы",              "ГруппаУниверсальнаяСтруктура");
	ПараметрыФормы.Вставить("ИдентификаторСтруктуры", ПолучитьИдентификаторСтруктуры());
	ПараметрыФормы.Вставить("ВладелецСтруктуры",	  ?(ЗначениеЗаполнено(Объект.Ссылка), Объект.Ссылка, СсылкаНового));
	
	Возврат ПараметрыФормы;
	
КонецФункции

&НаСервере
Функция ПолучитьИдентификаторСтруктуры()
	
	Если Объект.Ссылка.Пустая() Тогда
		ИдентификаторСтруктуры = СсылкаНового.УникальныйИдентификатор();
	Иначе
		ИдентификаторСтруктуры = Объект.Ссылка.УникальныйИдентификатор();
	КонецЕсли;	
	
	Возврат ИдентификаторСтруктуры;
	
КонецФункции
// Конец лм_УниверсальныеСтруктурыДанных

#КонецОбласти

