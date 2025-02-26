math.randomseed(os.time())

shapes = {}
elapsed = 0

function init()
    for i = 0,100,1
    do
        shapes[i] = randObject()
    end
end

function update(timeDelta)
    elapsed = elapsed + timeDelta
    for _, entity in ipairs(shapes) do
        updatePosition(entity:id())
        updateRotation(entity:id())
        --updateOrigin(entity:id())
    end
end

function updatePosition(eid)
    trs, found = components.transform.get(eid)
    if not found then
        return
    end

    tx, ty, tz = trs.translation()
    tx, ty, tz = tx + 1, ty + 1, tz

    if tx > 1124 then
        tx = -150
    end

    if ty > 868 then
        ty = -150
    end

    trs.translation(tx, ty, tz)
end

function updateRotation(eid)
    trs, found = components.transform.get(eid)
    if not found then
        return
    end


    rx, ry, rz = trs.rotation()
    ry = ry + 1

    trs.rotation(rx, ry, rz)
end

function updateOrigin(eid)
    origin, found = components.origin.get(eid)
    if not found then
        return
    end

    n = elapsed / 1000000000

    ox, oy, oz = origin.xyz()
    ox = math.cos(n)
    oy = math.sin(n)

    origin.xyz(ox, oy, oz)
end

function coinFlip()
    v = math.random() * 2
    return v > 1
end

function randColorComponent()
    v = math.random()
    return string.format("%02x", v * 255)
end

function randColor()
    r, g, b = randColorComponent(), randColorComponent(), randColorComponent()
    return "#" .. r .. g .. b
end

function randObject()
    x = math.random(0, 1024)
    y = math.random(0, 768)
    w = math.random(0, 150/2) * 2
    h = math.random(0, 150/2) * 2

    fill = randColor()
    stroke = randColor()

    randNumber = math.random() * 3

    if randNumber > 2 then
        e = rectangle.new(x, y, w, h, fill, stroke)
    elseif randNumber > 1 then
        e = circle.new(x, y, w/2, fill, stroke)
    else
        KEKW = "https://cdn.betterttv.net/emote/5e9c6c187e090362f8b0b9e8/3x"
        e = image.new(KEKW, x, y)
    end

    return e
end