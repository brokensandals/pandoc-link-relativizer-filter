local doc_url = nil
local doc_base_url = nil
local doc_path = nil
local doc_path_parts = nil

function split_url(url)
  local base_url, path, remainder = string.match(url, "^(https?://[^/]+)/?([^?#]*)(.*)$")
  return base_url, path, remainder
end

function split_path(path)
  if path == nil then
    return {}
  end
  local parts = {}
  for part in string.gmatch(path, "([^/]+)") do
    table.insert(parts, part)
  end
  return parts
end

function read_meta(meta)
  doc_url = pandoc.utils.stringify(meta.url)
  doc_base_url, doc_path = split_url(doc_url)
  doc_path_parts = split_path(doc_path)
end

-- GitHub Copilot wrote most of this function :)
function relativize(url)
  local base_url, path, rest = split_url(url)
  if not (base_url == doc_base_url) then
    return url
  end
  local path_parts = split_path(path)
  local last_common_part_index = 0
  for i, part in ipairs(path_parts) do
    if i > #doc_path_parts then
      break
    end
    if part == doc_path_parts[i] then
      last_common_part_index = i
    else
      break
    end
  end
  local relative_path_parts = {}
  for i = last_common_part_index + 1, #doc_path_parts do
    table.insert(relative_path_parts, "..")
  end
  for i = last_common_part_index + 1, #path_parts do
    table.insert(relative_path_parts, path_parts[i])
  end
  if string.match(path, "/$") then
    table.insert(relative_path_parts, "")
  end
  return table.concat(relative_path_parts, "/") .. rest
end

function update_link(link)
  link.target = relativize(link.target)
  return link
end

return {{Meta = read_meta}, {Link = update_link}}
