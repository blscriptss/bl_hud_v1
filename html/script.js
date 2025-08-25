
function updateCircle(type, value) {
    const hud = document.getElementById('hud');
    if (!hud) return;

    const circles = hud.querySelectorAll('.circle');
    circles.forEach(container => {
        const icon = container.querySelector('.icon-img');
        if (icon && icon.src.includes(`${type}.svg`)) {
            const fg = container.querySelector('.fg');
            if (fg) {
                fg.setAttribute('stroke-dasharray', `${value}, 100`);
            }
        }
    });
}

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.type === "forceUpdate") {
        location.reload();
    }

    if (data.action === 'setCash') {
        document.getElementById('cash').innerText = '$' + data.value;
    }

    if (data.action === 'setBank') {
        document.getElementById('bank').innerText = '$' + data.value;
    }

    if (data.action === 'setHunger') {
        updateCircle('hunger', data.value);
    }

    if (data.action === 'setThirst') {
        updateCircle('thirst', data.value);
    }

    if (data.action === 'setHealth') {
        updateCircle('health', data.value);
    }

    if (data.action === 'setArmor') {
        updateCircle('armor', data.value);
    }

    if (data.type === "updateHUD") {
        const hud = document.getElementById('hud');
        if (!hud) return;

        const colors = {
            health: '#e74c3c',
            armor: '#2980b9',
            hunger: '#f39c12',
            thirst: '#1abc9c'
        };

        const order = ['health', 'armor', 'hunger', 'thirst'];

        order.forEach((key) => {
            const val = data.data[key];
            if (val !== undefined) {
                let icon = hud.querySelector(`.circle .icon-img[src="icons/${key}.svg"]`);
                let container = icon ? icon.closest('.circle') : null;

                if (!container) {
                    container = document.createElement('div');
                    container.className = 'circle';

                    const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                    svg.setAttribute("viewBox", "0 0 36 36");

                    const bg = document.createElementNS("http://www.w3.org/2000/svg", "circle");
                    bg.classList.add("bg");
                    bg.setAttribute("cx", "18");
                    bg.setAttribute("cy", "18");
                    bg.setAttribute("r", "15.9155");

                    const fg = document.createElementNS("http://www.w3.org/2000/svg", "circle");
                    fg.classList.add("fg");
                    fg.setAttribute("cx", "18");
                    fg.setAttribute("cy", "18");
                    fg.setAttribute("r", "15.9155");
                    fg.setAttribute("stroke", colors[key] || '#2ecc71');

                    const iconImg = document.createElement("img");
                    iconImg.src = `icons/${key}.svg`;
                    iconImg.className = "icon-img";

                    svg.appendChild(bg);
                    svg.appendChild(fg);
                    container.appendChild(svg);
                    container.appendChild(iconImg);
                    hud.appendChild(container);
                }

                const fg = container.querySelector('.fg');
                if (fg) {
                    fg.setAttribute('stroke-dasharray', `${val}, 100`);
                }
            }
        });
    }
});
