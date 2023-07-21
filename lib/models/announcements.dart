class Announcements {
  String? id;
  String? title;
  String? content;
  var date;
  Announcements({
     this.title,
      this.content,
      this.date,
      this.id,
    });
}

List publicAnnouncements = [
  Announcements(title: 'P title 1', content: 'content', date: 'date'),
  Announcements(title: 'P title 2', content: 'content', date: 'date'),
  Announcements(title: 'P title 3', content: 'content', date: 'date'),
  Announcements(title: 'P title 4', content: 'content', date: 'date'),
  Announcements(title: 'P title 5', content: 'content', date: 'date')
];
List studentsAnnouncements = [
  Announcements(title: 'S title 1', content: 'content', date: 'date'),
  Announcements(title: 'S title 2', content: 'content', date: 'date'),
  Announcements(title: 'S title 3', content: 'content', date: 'date'),
  Announcements(title: 'S title 4', content: 'content', date: 'date'),
  Announcements(title: 'S title 5', content: 'content', date: 'date')
];
List teachersAnnouncements = [
  // Announcements(title: 'T title 1', content: 'content', date: 'date'),
  // Announcements(title: 'T title 2', content: 'content', date: 'date'),
  // Announcements(title: 'T title 3', content: 'content', date: 'date'),
  // Announcements(title: 'T title 4', content: 'content', date: 'date'),
  // Announcements(title: 'T title 5', content: 'content', date: 'date')
];

