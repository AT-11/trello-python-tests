from core.utils.RequestApiUtils import RequestApiUtils
from typing import Final

ENDPOINT: Final = "/boards/boardObject.id/labels"

def test_get_id_value_sending_valid_row_key_row_value_and_dictionary_return1231231312aa2212133():
    row_value = "(boardObject.id)"
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    actual = RequestApiUtils.get_id_value(row_value, id_dictionary)
    expected = "1231231312aa2212133"
    assert expected == actual


def test_get_id_value_sending_valid_row_value_dictionary_return_none():
    row_value = "(NoneBoardObject.id)"
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    actual = RequestApiUtils.get_id_value(row_value, id_dictionary)
    expected = None
    assert expected == actual


def test_generate_data_sends_empty_data_table_return_key_and_token_as_data_dictionary():
    data_table = None
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    actual = RequestApiUtils.generate_data(data_table, id_dictionary)
    expected = 0
    assert expected == len(actual)


def test_replace_variable_sends_valid_dictionary_and_input_endpoint_return_url_concatenated_with_id():
    id_dictionary = {"boardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    endpoint = ENDPOINT
    expected = "/boards/1231231312aa2212133/labels"
    actual = RequestApiUtils.replace_variables(endpoint, id_dictionary)
    assert expected == actual


def test_replace_variable_sends_invalid_dictionary_and_input_endpoint_return_url_without_changes():
    id_dictionary = {"invalidBoardObject": "1231231312aa2212133", "listObject": "456464565jjj45645646"}
    endpoint = ENDPOINT
    expected = ENDPOINT
    actual = RequestApiUtils.replace_variables(endpoint, id_dictionary)
    assert expected == actual
