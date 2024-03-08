import 'package:cinemax/constants/color_constants.dart';
import 'package:cinemax/widgets/back_label.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const BackLabel(),
                  ),
                  const Text(
                    "Notification",
                    style: TextStyle(
                      fontFamily: "SBM",
                      fontSize: 16,
                      color: TextColors.whiteText,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Privacy Policy",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 14,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              privacyPolicy(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Links to Other Websites",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 14,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              securityofYourdata(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Links to Other Websites",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 14,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              childrenPrivacy(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Links to Other Websites",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 14,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              linksTowebsites(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Changes to this Privacy Policy",
                style: TextStyle(
                  fontFamily: "MSB",
                  fontSize: 14,
                  color: TextColors.whiteText,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              changesToPrivacyPolicy(),
            ],
          ),
        ),
      ),
    );
  }

  Widget privacyPolicy() {
    return const Text(
      """
This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.

We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Free Privacy Policy Generator.""",
      style: TextStyle(
        fontFamily: "MM",
        fontSize: 14,
        color: TextColors.greyText,
      ),
    );
  }

  Widget changesToPrivacyPolicy() {
    return const Text(
      """
We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.

We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.

You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.""",
      style: TextStyle(
        fontFamily: "MM",
        fontSize: 14,
        color: TextColors.greyText,
      ),
    );
  }

  Widget linksTowebsites() {
    return const Text(
      """
Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party's site. We strongly advise You to review the Privacy Policy of every site You visit.

We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.""",
      style: TextStyle(
        fontFamily: "MM",
        fontSize: 14,
        color: TextColors.greyText,
      ),
    );
  }

  Widget childrenPrivacy() {
    return const Text(
      """
Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.

If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent's consent before We collect and use that information.""",
      style: TextStyle(
        fontFamily: "MM",
        fontSize: 14,
        color: TextColors.greyText,
      ),
    );
  }

  Widget securityofYourdata() {
    return const Text(
      """
The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.""",
      style: TextStyle(
        fontFamily: "MM",
        fontSize: 14,
        color: TextColors.greyText,
      ),
    );
  }
}
