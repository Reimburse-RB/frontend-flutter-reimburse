function formatDateTime(dateString, showTime = false) {
    const date = new Date(dateString);

    const optionsDate = { year: "numeric", month: "long", day: "numeric" };
    const formattedDate = new Intl.DateTimeFormat("id-ID", optionsDate).format(date);

    if (showTime) {
        const optionsTime = { hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: false };
        const formattedTime = new Intl.DateTimeFormat("id-ID", optionsTime).format(date);
        console.log(`formattedDate ${formattedDate} ${formattedTime} hohoho`);
        return `${formattedDate} ${formattedTime}`;
    }

    console.log(`formattedDate ${formattedDate} hohoho`);

    return formattedDate;
}

module.exports = { formatDateTime };

