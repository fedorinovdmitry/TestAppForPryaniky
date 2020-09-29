# TestAppForPryaniky

Задание:
В качестве тестового задания предлагается использования принципы MVP сделать небольшое приложение, позволяющее:
-получать с сервера JSON файл со списком данных для отображения на странице нескольких 
типов (Ex: картинка, Текст, селектор одного варианта из N), а также массивом со списком, какие блоки надо отобразить.
Ex: https://pryaniky.com/static/json/sample.json (data - данные, view: массив с последовательностью отображения)
-Отображать список этих элементов и при клике на них или выборе одного из вариантов ответа выводить информацию,
что за объект инициировал событие (id, имя, например)

Что реализовано:
-сетевой сервис URLSession 
-парсинг Json через Codable с использованием nestedUnkeyedContainer для массива с разной data
-основной список выводится через таблицу, таблица поддерживает вывод n кол-во объектов
-для каждого типа data, реализован свой тип ячейки
-размеры ячеек в таблицы динамические и поддерживают отображение текста разных размеров
-добавлен функционал вывода списка вариантов из селектора и возможность выбора по клику на кнопку в ячейке селектора
-при клике на объект выскакивает алерт с данными об объекте, который инициорвал событие

приложение поддерживает iphone и ipad в портретном режиме