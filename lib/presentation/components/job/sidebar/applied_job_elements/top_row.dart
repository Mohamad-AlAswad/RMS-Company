import 'package:flutter/material.dart';

import '../../../../../domain/usecases/job/applied/rate_application.dart';
import 'applied_job-elements.dart';

class TopRow extends StatefulWidget {
  const TopRow({
    Key? key,
    this.iconOnPress,
    required this.aJob,
    this.refresh,
  }) : super(key: key);
  final Function()? iconOnPress;
  final AppliedJob aJob;
  final Function()? refresh;

  @override
  State<TopRow> createState() => _TopRowState();
}

class _TopRowState extends State<TopRow> {
  List<OneStar>? stars;
  late int rate;
  late int newRate;

  List<OneStar> getStars() {
    if (stars != null) {
      return stars!;
    }
    stars = [];
    for (int i = 0; i < 5; i++) {
      stars!.add(
        OneStar(
          flag: rate > i,
          onPress: () {
            newRate = i + 1;
            for (int j = 0; j < 5; j++) {
              stars![j].starState.changeFlag(j <= i);
            }
          },
        ),
      );
    }
    return stars!;
  }

  checkForSave() {
    print(rate);
    print(newRate);
    print('--------');
    if (newRate != rate) {
      RateApplication()(appliedJob: widget.aJob, rating: newRate).then(
        (value) {
          if (widget.refresh != null) {
            widget.refresh!();
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    rate = widget.aJob.rating as int;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CloseRating(
          onPress: () {
            if (widget.iconOnPress != null) {
              widget.iconOnPress!();
            }
            checkForSave();
          },
        ),
        OneStar(
          iconData: Icons.clear_all,
          onPress: () {
            for (var element in getStars()) {
              element.starState.changeFlag(false);
            }
            newRate = 0;
          },
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.06,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: getStars(),
          ),
        ),
      ],
    );
  }
}
