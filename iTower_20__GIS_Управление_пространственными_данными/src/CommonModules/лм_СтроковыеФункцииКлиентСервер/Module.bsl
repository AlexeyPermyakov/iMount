
#Область ПрограммныйИнтерфейс

// Определяет, является ли строка валидным идентификатором,
//	т.е. содержит только буквы, цифры и символ подчеркивания, и не начинается с цифры
//
// Параметры:
//  Строка	 - строка	 - проверяемая строка
// 
// Возвращаемое значение:
//  Булево
//
Функция ЭтоВалидныйИдентификатор(Знач Строка) Экспорт
	
	Результат = Истина;
	
	Для Индекс = 1 По СтрДлина(Строка) Цикл
		Символ = Сред(Строка, Индекс, 1);
		Если Индекс = 1 Тогда
			Результат = Результат И (ЭтоБуква(Символ) ИЛИ СтрСравнить(Символ, "_") = 0);
		Иначе
			Результат = Результат И (ЭтоБуква(Символ) ИЛИ СтрСравнить(Символ, "_") = 0 ИЛИ ЭтоЦифра(Символ));
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Определяет, является ли символ цифрой
//
// Параметры:
//  Символ	 - строка	 - проверяемый символ
// 
// Возвращаемое значение:
//  Булево
//
Функция ЭтоЦифра(Символ) Экспорт
	
	КодСимвола = КодСимвола(Символ);
	Результат = (КодСимвола <= 57 И КодСимвола >= 48);
	
	Возврат Результат;
	
КонецФункции

// Определяет, является ли символ буквой
//
// Параметры:
//  Символ	 - строка	 - проверяемый символ
// 
// Возвращаемое значение:
//  Булево
//
Функция ЭтоБуква(Символ) Экспорт
	
	КодСимвола = КодСимвола(Символ);
	
	Результат = (КодСимвола <= 1103 И КодСимвола >= 1040)
				ИЛИ (КодСимвола <= 122 И КодСимвола >= 97)
				ИЛИ (КодСимвола <= 90 И КодСимвола >= 65);
	 
	Возврат Результат;
	
КонецФункции

// Формирует строку, являющуюся валидным идентификатором  
//	(т.е. содержащую только буквы, цифры и символ подчеркивания, и не начинающуюся с цифры)
//  на основании переданной на вход функции строки
//
// Параметры:
//  Строка - исходная строка
//  МассивСуществующих - необязательный параметр, содержит массив существующих идентификаторов,
//  в случае, если формируемый идентификатор сопадает с одним из существующих к нему будет добавляться
//  символ "_", до тех пор, пока он не станет уникальным
//
// Возвращаемое значение:
//  Строка - строка, являющаяся валидным идентификатором
//
Функция ПолучитьВалидныйИдентификатор(Знач Строка, МассивСуществующих = Неопределено) Экспорт
	
	Результат = "";
	Для Индекс = 1 По СтрДлина(Строка) Цикл
		Символ = Сред(Строка, Индекс, 1);
		Если Индекс = 1 Тогда
			Результат = ?(ЭтоЦифра(Символ) ИЛИ НЕ ЭтоБуква(Символ), "_", Символ);
		Иначе
			Результат = Результат + ?(ЭтоБуква(Символ) ИЛИ ЭтоЦифра(Символ), Символ, "_");
		КонецЕсли;
	КонецЦикла;
	
	Если МассивСуществующих = Неопределено Тогда	
		Возврат Результат;
	КонецЕсли;
	
	ЕстьДубли = Истина;
	
	Пока ЕстьДубли Цикл
		Если МассивСуществующих.Найти(Результат) <> Неопределено Тогда
			Результат = Результат + "_";
		Иначе
			ЕстьДубли = Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти