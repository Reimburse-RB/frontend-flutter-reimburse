function formatDateTime(dateInput, showTime = false, timeZoneOffsetActive = false) {
    let date = new Date(dateInput);

    if (timeZoneOffsetActive) {
        const tzoffset = 7 * 60 * 60000; // +7 WIB
        date = new Date(date.getTime() + tzoffset);
        console.log(`timezone offset ${tzoffset}`);
    } else {
        date = new Date(date);
    }
    // const tzoffset = date.getTimezoneOffset() * 60000; // offset dalam milidetik
    // const tzoffsetDateInput = date.getTimezoneOffset() * 60000; // offset dalam milidetik
    // console.log(`timezone offset dateinput${tzoffsetDateInput}`);
    // console.log(`timezone offset date${tzoffset}`);

    const optionsDate = { year: "numeric", month: "long", day: "numeric" };
    const formattedDate = new Intl.DateTimeFormat("id-ID", optionsDate).format(date);

    if (showTime) {
        const optionsTime = { hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: false };
        const formattedTime = new Intl.DateTimeFormat("id-ID", optionsTime).format(date);
        console.log(`formattedDate ${formattedDate} ${formattedTime}`);
        return `${formattedDate} ${formattedTime}`;
    }

    console.log(`formattedDate ${formattedDate}`);
    return formattedDate;
}

function formatCurrency(number) {
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR'
    }).format(number);
}

module.exports = { formatDateTime, formatCurrency };

