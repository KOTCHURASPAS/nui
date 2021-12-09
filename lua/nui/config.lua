--[[ ------ Scoreboard ------ ]]
NUI.Scoreboard.groups = {
    ['superadmin'] = {
        name = 'Команда проекта',
        color = Color(255, 0, 0, 255),
        icon = 'icon16/tux.png'
    },
    ['user'] = {
        name = 'Игрок',
        color = Color(255, 255, 255),
        icon = 'icon16/user.png'
    },
    ['admin'] = {
        name = 'Администратор',
        color = Color(53, 50, 255),
        icon = 'icon16/user.png'
    },
}
--[[ ---------- F4 ---------- ]]
-- Добавление ссылок в F4
NUI.F4.Links = {
    {
        link = 'https://darkhub.ru/',
        name = 'Сайт',
        icon = Material('nui/internet.png', 'noclamp 1')
    },
    {
        link = 'https://darkhub.ru/forum/',
        name = 'Форум',
        icon = Material('nui/vote.png', 'noclamp 1')
    },
    {
        link = 'https://darkhub.ru/l/1/',
        name = 'Контент',
        icon = Material('nui/bring.png', 'noclamp 1')
    },
    {
        link = 'https://darkhub.ru/l/vk/',
        name = 'Группа ВК',
        icon = Material('nui/vk.png', 'noclamp 1')
    },
    {
        link = 'https://darkhub.ru/l/ds/',
        name = 'Дискорд',
        icon = Material('nui/discord.png', 'noclamp 1')
    }
}

-- Отключение отображения оружий в меню выбранной профессии в блоке 'Оружия:'
NUI.F4.DisabledWeapons = {
    ['arrest_stick'] = true,
}

-- Основные кнопки F4
NUI.F4.Pages = {
    ['food'] = {
        name = 'Еда',
        icon = Material('nui/food.png', 'noclamp 1')
    },
    ['shipments'] = {
        name = 'Коробки',
        icon = Material('nui/cube.png', 'noclamp 1')
    },
    ['entities'] = {
        name = 'Вещи',
        icon = Material('nui/bulb.png', 'noclamp 1')
    },
    ['jobs'] = {
        name = 'Профессии',
        icon = Material('nui/build.png', 'noclamp 1')
    },
}