ngx.header.content_type = 'application/json'

local functions = require('short/functions')
local cjson = require('cjson')
ngx.req.read_body()
-- POst 支持
ngx.req.read_body() -- 解析 body 参数之前一定要先读取 body
local args_post = cjson.decode(ngx.req.get_body_data())
local args_get = ngx.req.get_uri_args()
--  for k,v in pairs(arg) do
--      ngx.log(ngx.ERR, "[POST] key:", k, " v:", v)
--  end
--
--  for k,v in pairs(args) do
--      ngx.say("[GET] key:", k, " v:", v)
--  end

local long_url = args_post['url']
local short_string = args_get['short']
local short_url, err = functions.url_create(long_url)
if err then
	functions.show_error(err)
end
ngx.say('{"status":1,"shorturl":"'..short_url..'"}')
