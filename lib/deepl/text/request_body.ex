defmodule Deepl.Text.RequestBody do
  @moduledoc false
  @moduledoc since: "0.1.0"

  defstruct source_lang: nil,
            context: nil,
            show_billed_characters: nil,
            split_sentences: nil,
            preserve_formatting: nil,
            formality: nil,
            model_type: nil,
            glossary_id: nil,
            tag_handling: nil,
            outline_detection: nil,
            non_splitting_tags: [],
            splitting_tags: [],
            ignore_tags: []

  @doc """
  Converts the struct to a keyword list for use in API requests.
  """
  @spec to_keyword(struct()) :: Keyword.t()
  def to_keyword(%__MODULE__{} = struct) do
    struct
    |> Map.from_struct()
    |> Enum.reject(fn {_key, value} -> is_nil(value) or value == [] end)
    |> Enum.map(fn {key, value} -> {key, value} end)
  end
end
