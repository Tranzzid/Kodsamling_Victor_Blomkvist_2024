function memberThumbnail(member) {
  const thumbnail = `
  <li class="thumbnail">
      <div class="thumbnail__image-container">
        <img
          class="thumbnail__image"
          src="./img/members/0/${member.id}.jpg"
          width="512"
          height="512"
          alt="Image of ${member.first_name} ${member.last_name}"
          srcset="
            ./img/members/${member.id}/${member.id}_256.webp 256w,
            ./img/members/${member.id}/${member.id}_512.webp 512w,
            ./img/members/${member.id}/${member.id}_1024.webp 1024w,
            ./img/members/${member.id}/${member.id}_2048.webp 2048w"
          sizes="
            (min-width: 1600px) calc((100vw - 26.6vw) / 6),
            (min-width: 1200px) calc((100vw - 20vw) / 4),
            (min-width: 992px) calc((100vw - 14vw) / 3),
            (min-width: 768px) calc((100vw - 10vw) / 2), 
            (min-width: 480px) calc((100vw - 30px) / 2), 
            calc((100vw - 30px)"/>
        <a class="thumbnail__link" href="#" title="Link to ${member.first_name} ${member.last_name}">Go to profile</a>
      </div>
    <div class="thumbnail__header">
      <h4 class="thumbnail__title thumbnail__title--tertiary">${member.first_name} ${member.last_name}</h4>
      <p class="thumbnail__text thumbnail__text--right"><a href="#" title="Mail ${member.first_name} ${member.last_name}">${member.mail}@du.se</a></p>
    </div>
  </li>
  `;
  return thumbnail;
}

function addMemberThumbnails(members) {
  let output = "";
  members.forEach(function (member) {
    output += memberThumbnail(member);
  });
  return output;
}

const gallery = document.querySelector(".gallery");

members = [
  {
    id: "1",
    first_name: "Robin",
    last_name: "Vredeskog",
    mail: "a2z",
  },
  {
    id: "2",
    first_name: "Jane",
    last_name: "Sarani",
    mail: "a2z",
  },
  {
    id: "3",
    first_name: "Nynaeve",
    last_name: "Al'Meara",
    mail: "a2z",
  },
  {
    id: "4",
    first_name: "Ida",
    last_name: "Olsen",
    mail: "a2z",
  },
  {
    id: "5",
    first_name: "Jonathan",
    last_name: "Eriksson",
    mail: "a2z",
  },
  {
    id: "6",
    first_name: "Isak",
    last_name: "Rapp",
    mail: "a2z",
  },
  {
    id: "7",
    first_name: "Min",
    last_name: "Farshaw",
    mail: "a2z",
  },
  {
    id: "8",
    first_name: "Filippa",
    last_name: "Masonei",
    mail: "a2z",
  },
  {
    id: "9",
    first_name: "Elayne",
    last_name: "Trakand",
    mail: "a2z",
  },
  {
    id: "10",
    first_name: "Perrin",
    last_name: "Aybara",
    mail: "a2z",
  },
  {
    id: "11",
    first_name: "Tuon",
    last_name: "Athaem",
    mail: "a2z",
  },
  {
    id: "12",
    first_name: "Kamarile",
    last_name: "Maradim",
    mail: "a2z",
  },
  {
    id: "13",
    first_name: "Fail",
    last_name: "Bashere",
    mail: "a2z",
  },
  {
    id: "14",
    first_name: "Tom",
    last_name: "Bombadill",
    mail: "a2z",
  },
  {
    id: "15",
    first_name: "Elan",
    last_name: "Morin Tedronai",
    mail: "a2z",
  },
  {
    id: "16",
    first_name: "Mierin",
    last_name: "Eronaile",
    mail: "a2z",
  },
  {
    id: "17",
    first_name: "Barid Bel",
    last_name: "Medar",
    mail: "a2z",
  },
];

gallery.insertAdjacentHTML("beforeend", addMemberThumbnails(members));
