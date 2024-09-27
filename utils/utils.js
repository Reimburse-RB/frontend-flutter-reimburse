function formatDateTime(dateInput, showTime = false, timeZoneOffsetActive = false) {
    let date;

    if (timeZoneOffsetActive) {
        const tzoffset = dateInput.getTimezoneOffset() * 60000; // offset dalam milidetik
        date = new Date(dateInput.getTime() + tzoffset);
    } else {
        date = new Date(dateInput);
    }

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

module.exports = { formatDateTime };

