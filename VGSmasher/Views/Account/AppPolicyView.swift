//
//  AppPolicyView.swift
//  VGSmasher
//
//  Created by Pablo Figueroa Martínez on 9/6/21.
//

import SwiftUI

struct AppPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group{
                    Text("Last updated 09/06/2021")
                    Text("Thank you for choosing to be part of our community at VGSmasher. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about this privacy notice, or our practices with regards to your personal information, please contact us at pablo.figueroa@alumnos.upm.es").padding(.top)
                    Text("When you use our mobile application, as the case may be VGSmasher and more generally, use any of our services, we appreciate that you are trusting us with your personal information. We take your privacy very seriously. In this privacy notice, we seek to explain to you in the clearest way possible what information we collect, how we use it and what rights you have relation to it. We hope you take some time to read through it carefully, as it important. If there are any terms in this privacy notice that you do not agree please discontinue use of our Services immediately.").padding(.top)
                    Text("This privacy notice applies to all information collected through our Services (as described above, includes our App), as well as, any related services, marketing or events.").padding(.top)
                    Text("Please read this privacy notice carefully as it will help you understand what do with the information that we collect.").bold().padding(.top)
                }
                
                Group {
                    Text("Table of contents").font(.title).bold().padding(.top)
                    Text("1. WHAT INFORMATION DO WE COLLECT?").fontWeight(.medium).foregroundColor(.blue).padding(.top)
                    Text("2. HOW DO WE USE YOUR INFORMATION?").fontWeight(.medium).foregroundColor(.blue)
                    Text("3. WILL YOUR INFORMATION BE SHARED WITH ANYONE?").fontWeight(.medium).foregroundColor(.blue)
                    Text("4. IS YOUR INFORMATION TRANSFERRED INTERNATIONALLY?").fontWeight(.medium).foregroundColor(.blue)
                    Text("5. HOW LONG DO WE KEEP YOUR INFORMATION?").fontWeight(.medium).foregroundColor(.blue)
                    Text("6. HOW DO WE KEEP YOUR INFORMATION SAFE?").fontWeight(.medium).foregroundColor(.blue)
                }
                Group {
                    Text("7. WHAT ARE YOUR PRIVACY RIGHTS?").fontWeight(.medium).foregroundColor(.blue)
                    Text("8. CONTROLS FOR DO-NOT-TRACK FEATURES").fontWeight(.medium).foregroundColor(.blue)
                    Text("9. DO CALIFORNIA RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?").fontWeight(.medium).foregroundColor(.blue)
                    Text("10. DO WE MAKE UPDATES TO THIS NOTICE?").fontWeight(.medium).foregroundColor(.blue)
                    Text("11. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?").fontWeight(.medium).foregroundColor(.blue)
                    
                    Text("What information do we collect?").font(.title).fontWeight(.bold).padding(.top)
                    Text("We do not collect information from user other than its email, username and password when registering to the app.").padding(.top)
                }

                Group {
                    Text("How do we use your information?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("We process your information for purposes based on legitimate interests, the fulfillment of our contract with you, compliance with our obligations, and/or your consent.")).padding(.top)
                    Text("We use personal information collected via our App for a variety of purposes described below. We process your personal information for purposes in reliance on our legitimate business interests, in order to enter into perform a contract with you, with your consent, and/or for compliance with our obligations. We indicate the specific processing grounds we rely on next to purpose listed below.").padding(.top)
                    Text("We use the information we collect or receive:").padding(.top)
                    Text("  - To facilitate account creation and logon process.").padding(.top)
                    Text("  - Request feedback. We may use your information to request feedback and contact you about your use of our App.").padding(.top)
                    Text("  - To manage user accounts. We may use your information for the purposes managing our account and keeping it in working order.").padding(.top)
                    Text("  - To enforce our terms, conditions and policies for business purposes, comply with legal and regulatory requirements or in connection with contract.").padding(.top)
                    Text("  - To respond to legal requests and prevent harm. If we receive a or other legal request, we may need to inspect the data we hold to how to respond.").padding(.top)
                    Text("  - For other business purposes. We may use your information for business purposes, such as data analysis, identifying usage determining the effectiveness of our promotional campaigns and to and improve our App, products, marketing and your experience.").padding(.top)
                }
                
                Group {
                    Text("Will your information be shared with anyone?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("We only share information with your consent, to comply with laws, provide you with services, to protect your rights, or to fulfill business obligations.")).padding(.top)
                    Text("We may process or share your data that we hold based on the following legal basis:").padding(.top)
                    Text("  - Consent: We may process your data if you have given us specific consent use your personal information for a specific purpose.").padding(.top)
                    Text("  - Legitimate Interests: We may process your data when it is necessary to achieve our legitimate business interests.").padding(.top)
                    Text("  - Performance of a Contract: Where we have entered into a contract with we may process your personal information to fulfill the terms of our contract.").padding(.top)
                    Text("  - Legal Obligations: We may disclose your information where we are required to do so in order to comply with applicable law, requests, a judicial proceeding, court order, or legal process, such as response to a court order or a subpoena (including in response to authorities to meet national security or law enforcement requirements).").padding(.top)
                    Text("  - Vital Interests: We may disclose your information where we believe it necessary to investigate, prevent, or take action regarding potential of our policies, suspected fraud, situations involving potential threats to safety of any person and illegal activities, or as evidence in litigation in we are involved.").padding(.top)
                    Text("More specifically, we may need to process your data or share your information in the following situations:").padding(.top)
                    Text("  - Business Transfers. We may share or transfer your information connection with, or during negotiations of, any merger, sale of assets, financing, or acquisition of all or a portion of our business to company.").padding(.top)
                }
                
                Group {
                    Text("Is your information transferred internationaly?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("We may transfer, store, and process your information in countries than your own.")).padding(.top)
                    Text("Our servers are located in Europe. If you are accessing our App from outside, please aware that your information may be transferred to, stored, and processed by us our facilities and by those third parties with whom we may share your information (see 'WILL YOUR INFORMATION BE SHARED WITH ANYONE?' above), in and other countries.").padding(.top)
                    Text("If you are a resident in the European Economic Area (EEA) or United Kingdom (then these countries may not necessarily have data protection laws or other laws as comprehensive as those in your country. We will however take all measures to protect your personal information in accordance with this privacy and applicable law.").padding(.top)
                    
                    Text("How long do we keep your information?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("We keep your information for as long as necessary to fulfill the outlined in this privacy notice unless otherwise required by law.")).padding(.top)
                    Text("We will only keep your personal information for as long as it is necessary for purposes set out in this privacy notice, unless a longer retention period is required permitted by law (such as tax, accounting or other legal requirements). No in this notice will require us keeping your personal information for longer than period of time in which users have an account with us.").padding(.top)
                    Text("When we have no ongoing legitimate business need to process your information, we will either delete or anonymize such information, or, if this is possible (for example, because your personal information has been stored in archives), then we will securely store your personal information and isolate it any further processing until deletion is possible.").padding(.top)
                }
                
                Group {
                    Text("How do we keep your information safe?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("We aim to protect your personal information through a system organizational and technical security measures.")).padding(.top)
                    Text("We have implemented appropriate technical and organizational security designed to protect the security of any personal information we process. despite our safeguards and efforts to secure your information, no transmission over the Internet or information storage technology can be to be 100% secure, so we cannot promise or guarantee that cybercriminals, or other unauthorized third parties will not be able to defeat security, and improperly collect, access, steal, or modify your information. we will do our best to protect your personal information, transmission of information to and from our App is at your own risk. You should only access the within a secure environment.").padding(.top)
                    
                    Text("What are your privacy rights?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("You may review, change, or terminate your account at any time.")).padding(.top)
                    Text("If you would at any time like to review or change the information in your account terminate your account, you can contact us using the contact information provided.").padding(.top)
                    Text("Upon your request to terminate your account, we will deactivate or delete account and information from our active databases. However, we may retain information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our Terms of Use and/or comply with applicable requirements.").padding(.top)
                }
                
                Group {
                    Text("Controls for do-not-track features").font(.title).fontWeight(.bold).padding(.top)
                    Text("Most web browsers and some mobile operating systems and mobile include a Do-Not-Track ('DNT') feature or setting you can activate to signal privacy preference not to have data about your online browsing activities and collected. At this stage no uniform technology standard for recognizing implementing DNT signals has been finalized. As such, we do not currently to DNT browser signals or any other mechanism that automatically your choice not to be tracked online. If a standard for online tracking is adopted we must follow in the future, we will inform you about that practice in a version of this privacy notice.").padding(.top)
                    
                    Text("Do California residents have specific privacy rights?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("Yes, if you are a resident of California, you are granted specific regarding access to your personal information.")).padding(.top)
                    Text("California Civil Code Section 1798.83, also known as the 'Shine The Light' permits our users who are California residents to request and obtain from us, once year and free of charge, information about categories of personal information (if we disclosed to third parties for direct marketing purposes and the names addresses of all third parties with which we shared personal information in immediately preceding calendar year. If you are a California resident and would to make such a request, please submit your request in writing to us using contact information provided below.").padding(.top)
                    Text("If you are under 18 years of age, reside in California, and have a registered with the App, you have the right to request removal of unwanted data that publicly post on the App. To request removal of such data, please contact us the contact information provided below, and include the email address with your account and a statement that you reside in California. We will make the data is not publicly displayed on the App, but please be aware that the data not be completely or comprehensively removed from all our systems (e.g. etc.).").padding(.top)
                    
                    Text("Do we make updates to this notice?").font(.title).fontWeight(.bold).padding(.top)
                    (Text("In short: ").bold() + Text("Yes, we will update this notice as necessary to stay compliant relevant laws.")).padding(.top)
                    Text("We may update this privacy notice from time to time. The updated version will indicated by an updated 'Revised' date and the updated version will be effective soon as it is accessible. If we make material changes to this privacy notice, we notify you either by prominently posting a notice of such changes or by sending you a notification. We encourage you to review this privacy notice to be informed of how we are protecting your information.").padding(.top)
                }
                
                Group {
                    Text("How can you contact us about this notice?").font(.title).fontWeight(.bold).padding(.top)
                    Text("If you have questions or comments about this notice, you may email us pablo.figueroa@alumnos.upm.es.").padding(.top)
                }
                
            }.padding([.horizontal, .top])
        }.navigationBarTitle(Text("PRIVACY NOTICE"))
    }
}

struct AppPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        AppPolicyView()
    }
}
