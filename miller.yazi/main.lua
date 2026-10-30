--- @since 26.9.1
-- miller.yazi: CSV and TSV preview as an aligned table, rendered by Miller (https://github.com/johnkerl/miller).

local M = {}

-- Miller input flag by file extension; anything else is read as CSV.
local INPUT = { csv = "--icsv", tsv = "--itsv", tab = "--itsv" }

local function message(job, text)
	ya.preview_widget(job, ui.Text(text):area(job.area):wrap(ui.Wrap.YES))
end

-- Reads the command's output and shows the lines that fit the preview pane,
-- starting at job.skip. Long lines wrap the same way Yazi wraps code.
local function show(job, child, program)
	local opt = { ansi = true, tab_size = rt.preview.tab_size, wrap = rt.preview.wrap, width = job.area.w }
	local first, last = job.skip + 1, job.skip + job.area.h
	local seen, shown, errors = 0, {}, {}

	while seen < last do
		local line, event = child:read_line()
		if event == 1 then
			errors[#errors + 1] = line
		elseif event ~= 0 then
			break
		else
			local wrapped = ui.lines(line, opt)
			for k = 1, #wrapped do
				seen = seen + 1
				if seen >= first and seen <= last then
					shown[#shown + 1] = wrapped[k]
				end
			end
		end
	end
	child:start_kill()

	if seen == 0 and #errors > 0 then
		local text = table.concat(errors, "")
		if text:sub(1, #program + 1) ~= program .. ":" then
			text = program .. ": " .. text
		end
		return message(job, text)
	end
	if job.skip > 0 and seen < last then
		-- Scrolled past the end: step back to the last full page.
		return ya.emit("peek", { math.max(0, seen - job.area.h), only_if = job.file.url, upper_bound = true })
	end
	ya.preview_widget(job, ui.Text(shown):area(job.area))
end

function M:peek(job)
	local path = tostring(job.file.path)
	local ext = (path:match("%.([^./]+)$") or ""):lower()

	local child, err = Command("mlr")
		:arg({ INPUT[ext] or "--icsv", "--opprint", "-C", "cat", path })
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:spawn()

	if not child then
		return message(job, "mlr: failed to start (" .. tostring(err) .. "). Is Miller installed and in PATH?")
	end
	show(job, child, "mlr")
end

function M:seek(job) require("code"):seek(job) end

return M
