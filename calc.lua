local first = tostring(arg[1])
local operation = tostring(arg[2])
local second = tostring(arg[3])
local result=""
local rest = ""


function padString(str,len)
    local obj = str
    for i=1,len-#str do
        obj = "0"..obj
    end
    return obj
end

function reverseStr(str)
    local obj = ""
    for i=1,#str do
        obj=obj..string.sub(str,#str-i+1,#str-i+1)
    end
    return obj
end

function addThem(fi,se)
    local f = reverseStr(fi)
    local s = reverseStr(se)
    local carry = false
    local obj=""
    for i=1,#f do
        local d = tonumber(string.sub(f,i,i))
        local ds = tonumber(string.sub(s,i,i))
        local r = d+ds
        if carry then r=r+1; carry=false end
        if r>=10 then carry=true; r=r-10 end
        obj=obj..tostring(r)
    end
    if carry then obj=obj.."1" end
    return reverseStr(obj)
end

function subtractThem(fi,se)
    local f = reverseStr(fi)
    local s = reverseStr(se)
    local carry = false
    local obj=""
    for i=1,#f do
        local d = tonumber(string.sub(f,i,i))
        local ds = tonumber(string.sub(s,i,i))
        local r = d-ds
        if carry then r=r-1; carry=false end
        if r<0 then carry=true; r=r+10 end
        obj=obj..tostring(r)
    end    
    return reverseStr(obj)
end

function isLarger(fi,se)
    for i=1,#fi do
        local d = tonumber(string.sub(fi,i,i))
        local ds = tonumber(string.sub(se,i,i))
        if d>ds then return true elseif ds>d then break end
    end
    return false
end

function isEqual(fi,se)
    for i=1,#fi do
        local d = tonumber(string.sub(fi,i,i))
        local ds = tonumber(string.sub(se,i,i))
        if d~=ds then return false end
    end
    return true
end

function divideThem(fi,se)
    local count = "0"
    local rest = fi
    while true do
        if isLarger(rest,se) or isEqual(rest,se) then
            rest = subtractThem(rest,se)
        else
            break
        end
        count = addThem(count,padString("1",#count))
    end
    return count, rest
end

function multiplyThem(fi,se)
    local obj = fi
    for i=1,tonumber(se)-1 do
        obj = addThem(obj,padString(fi,#obj))
    end
    return obj
end

function factorThem(fi)
    local where = fi
    local obj = fi
    while isEqual(where,padString("0",#where))==false do
        where = subtractThem(where,padString("1",#where))
        obj = multiplyThem(obj,padString(where,#obj))
    end
    return obj
end

function powerThem(fi,se)
    local where = se
    local obj = padString("1",#fi)
    while isEqual(where,padString("0",#where))==false do
        where = subtractThem(where,padString("1",#where))
        obj = multiplyThem(obj,padString(fi,#obj))
    end
    return obj
end

--local pi = divideThem("22","07")

if #first>#second then
    second=padString(second,#first)
elseif #second>#first then
    first=padString(first,#second)
end

if operation=="+" then
    result = addThem(first,second)
elseif operation=="-" then
    result = subtractThem(first,second)
elseif operation=="x" then
    result = multiplyThem(first,second)
elseif operation=="/" then
    result, rest = divideThem(first,second)
elseif operation=="!" then
    result = factorThem(first)
elseif operation=="^" then
    result = powerThem(first,second)
end

print(result, rest)