from unittest.mock import patch

from visitor_couter import handler


def test_increase_visit_count_adds_one():
    current = 41
    stub_response = {"Attributes": {"id": handler.COUNTER_ID, "value": current + 1}}

    with patch.object(handler.table, "update_item", return_value=stub_response) as mock_update:
        new_value = handler.increase_visit_count()

    assert new_value == current + 1
    mock_update.assert_called_once()
    kwargs = mock_update.call_args.kwargs
    assert kwargs["Key"] == {"id": handler.COUNTER_ID}
    assert kwargs["ExpressionAttributeValues"] == {":increment": 1}
