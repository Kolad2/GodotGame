extends Object
class_name Set

var array = []
var dict = {}

# Удаление элемента
func remove(item: Variant):
	if not dict.has(item):  # Проверяем, существует ли элемент
		return

	var index = dict[item]  # Получаем индекс элемента
	var last_item = array.pop_back()  # Удаляем последний элемент массива

	if index < array.size():  # Если удаленный элемент не был последним
		array[index] = last_item  # Заменяем удаленный элемент последним
		dict[last_item] = index  # Обновляем индекс последнего элемента в словаре

	dict.erase(item)  # Удаляем элемент из словаря

# Добавление элемента
func add(item: Variant):
	if dict.has(item):  # Проверяем, существует ли элемент
		return

	array.append(item)  # Добавляем элемент в массив
	dict[item] = array.size() - 1  # Сохраняем индекс элемента в словаре
	
