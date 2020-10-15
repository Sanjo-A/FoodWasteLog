import 'package:test/test.dart';
import 'package:wasteagram/models/waste.dart';
void main(){
  test('General test(1) of creating new waste post', ()
  {
    final date = DateTime.parse('2020-08-01').toIso8601String();
    const imageUrl = "sakldjlkdaf";
    const wasteCount = 100;
    const longitude = 1.0;
    const latitude = 2.0;
    final foodWastePost = Waste(
        imageUrl: imageUrl,
        longitude: longitude,
        latitude: latitude,
        wasteCount: wasteCount,
        date: date);
    expect(foodWastePost.date, date);
    expect(foodWastePost.longitude, longitude);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.wasteCount, wasteCount);
    expect(foodWastePost.imageUrl, imageUrl);
  });
  test('General test(2) of creating new waste post', ()
  {
    const imageUrl = "sakldjlkdaf";
    const wasteCount = 100;
    const longitude = 1.0;
    const latitude = 2.0;
    final foodWastePost = Waste(
        imageUrl: imageUrl,
        longitude: longitude,
        latitude: latitude,
        wasteCount: wasteCount);
    expect(foodWastePost.date, null);
  });
  
  test('General test(3) of creating new waste post', ()
  {
    final date = DateTime.parse('2020-08-01').toIso8601String();
    const imageUrl = "fdasdsafxcbvbvxcv";
    const wasteCount = 9;
    const longitude = 10.0;
    const latitude = 22.0;
    final foodWastePost = Waste(
        imageUrl: imageUrl,
        longitude: longitude,
        latitude: latitude,
        wasteCount: wasteCount,
        date: date);
  const expectedSharedLocation = "Meet me at ($longitude $latitude) !";
  expect(foodWastePost.shareLocation(), expectedSharedLocation);
  });
}