Theme(
data: Theme.of(context).copyWith(
scrollbarTheme: ScrollbarThemeData(
thumbColor:
MaterialStateProperty.all(renkler.sariRenk),
)),
child: Stack(
children: [
Padding(
padding: const EdgeInsets.only(left: 1.75),
child: SizedBox(
width: 4,
height: size.height / 3.04,
child: const DecoratedBox(
decoration: BoxDecoration(
borderRadius: BorderRadius.all(Radius.circular(30)),
color: Color(0xff0D1C26)),
),
),
),
Scrollbar(
controller: Scrollbarcontroller2,
thumbVisibility: true,
scrollbarOrientation:
ScrollbarOrientation.left,
interactive: true,
thickness: 7,
radius: const Radius.circular(15.0),
child: ListView.builder(
controller: Scrollbarcontroller2,
itemCount: snapshot.data!.length,
itemBuilder:
(BuildContext context, index) {
spendinfo item =
snapshot.data![index];
return Column(
children: [
Padding(
padding: const EdgeInsets.only(
left: 15, right: 10),
child: ClipRRect(
//Borderradius vermek için kullanıyoruz
borderRadius:
BorderRadius.circular(
10.0),
child: Container(
height: 26,
color: renkler.ArkaRenk,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
mainAxisSize: MainAxisSize.max,
children: [
SizedBox(
width: 100,
child: Text(
'${item.category}',textAlign: TextAlign.center),
),
SizedBox(
width: 50,
child: Text(
'${item.operationTool}',textAlign: TextAlign.center),
),
SizedBox(
width: 100,
child: gelirGiderInfo(item),
),
SizedBox(
width: 60,
child: Padding(
padding: const EdgeInsets.only(right: 10),
child: Text(item
    .operationTime
    .toString(),textAlign: TextAlign.center),
),
),
],
),
),
),
),
const SizedBox(height: 5), // elemanlar arasına bşluk bırakmak için kulllandım.
],
);
}),
)
],
),
),