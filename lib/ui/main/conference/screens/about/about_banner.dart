import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uhk_events/common/colors.dart';
import 'package:uhk_events/common/constants.dart';

class BannerWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String date;
  final String url;

  const BannerWidget(
      {@required this.title,
      @required this.url,
      @required this.color,
      this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ConferenceBackButton(fillColor: color),
        _BannerSkeleton(
          url: url,
          date: date,
          title: title,
        )
      ],
    );
  }
}

class _ConferenceBackButton extends StatelessWidget {
  final Color fillColor;

  const _ConferenceBackButton({@required this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: backButtonSize,
          height: backButtonSize,
          decoration: BoxDecoration(color: fillColor, shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerSkeleton extends StatelessWidget {
  final String title;
  final String date;
  final String url;

  const _BannerSkeleton(
      {@required this.title, @required this.url, @required this.date});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.transparent, disableBarItemColor],
            ).createShader(
              Rect.fromLTRB(0, 80, 0, 400),
            );
          },
          blendMode: BlendMode.darken,
          child: Image.network(
            url,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes
                      : null,
                ),
              );
            },
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(
                  date,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30),
              ),
              Padding(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.display1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
