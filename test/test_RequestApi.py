from core.api.request_api.RequestApi import RequestApi


def test_verify_value_sendingValidRow_keyRow_valueAndDictionary_return1231231312aa2212133():
    row_key = "boardObject"
    row_value = "(boardObject.id)"
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    request_api = RequestApi()
    expected = request_api.verify_value(row_key, row_value, id_dictionary)
    actual = "1231231312aa2212133"
    assert expected == actual


def test_verify_value_sendingInvalidRow_keyAndValidRow_valueDictionary_returnNone():
    row_key = "boardObject"
    row_value = "(NoneBoardObject.id)"
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    request_api = RequestApi()
    expected = request_api.verify_value(row_key, row_value, id_dictionary)
    actual = None
    assert expected == actual


def test_generate_data():
    """
    To do
    """
