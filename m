Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B267568F03
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Jul 2022 18:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGFQYU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Jul 2022 12:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiGFQYT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Jul 2022 12:24:19 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715421246
        for <linux-acpi@vger.kernel.org>; Wed,  6 Jul 2022 09:24:18 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a11so19099374ljb.5
        for <linux-acpi@vger.kernel.org>; Wed, 06 Jul 2022 09:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=c1GCV8kAZ4Y3DJ11NGRKgxzgFkMnbEBSTsu/N9uaH5s=;
        b=SJ0IpihBZx8bszOA95kroK40bmMwZ7u65b5D9qd1Gf+ptvJfFeBKMJcqlIjlcVRnak
         6NIW9GRUYuEMF9ZPqzCnRetnXObKF5JNdlk+cxg7xCjcVBjLkG5hwY+hzKqCUHl66Hyp
         C/S6+x/UEmSnEKi/95jjuhabBY8T+cwvmmjdMYOIDyRXI1EBdRZABWqWk9GV5P44nY2t
         Bfu6zmjtoOPRTgDqIBLJVkuoqbEpn7+eammZNoceN4DUrVcw6m4rzMTzNeiMAbBPuhb0
         p4FM3U9kpX9vYFu5vyD/hG/RrdOMgN73sGsJgTH+ejynupqR2noMIhG4SPZrVXAayHqb
         aO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=c1GCV8kAZ4Y3DJ11NGRKgxzgFkMnbEBSTsu/N9uaH5s=;
        b=Y/4Pxdn15G7LdJE6uUG5tfZe5j3RYoe7EaowkQDkvVYOXrKKhAGT47kWHPngj2qQsC
         jO/1+x5uuDd2durHzuZF/oZvE3YGkBDvOOV2++jY4NnFcCpFQDZg5xG3/dKjgysSPV/g
         eeGWHqKkP42m+Tb8skC0UQwfQhtS7DK5pyryHZXtLCRff3Hky8TjJ0fjz8bcx6n9KOxh
         CN8w9m+yrijyDMdGrnWlkQW3+9Hky4Hcy3duckXdLx5euxOHVSC7yi13Jh+398Zv7W0k
         1ja84JWC4kj4lEZmWqjDyjBLl+lD1DjAu/aT4+K4NJLnI5yKp9Jy2/zNGr3fKbwVwaTi
         QjZQ==
X-Gm-Message-State: AJIora9efeB9VRwM7y2eTAZQ+z2h/cuZ34gnCoS1X6GF9ZhchSrChojh
        dZdUhKmkPHZXTMO40SCh1S24Bn3mKoJqqW2IrBo=
X-Google-Smtp-Source: AGRyM1vCkZA1fNaOH71rqznfCvHSvkl8DQEm5wrRSfstO8nH4g2X6eDCoSwzBL0b0iyahOpuxmJ7ssv9gs+U3crEDJk=
X-Received: by 2002:a05:651c:544:b0:25d:3150:d9ea with SMTP id
 q4-20020a05651c054400b0025d3150d9eamr5681908ljp.129.1657124654864; Wed, 06
 Jul 2022 09:24:14 -0700 (PDT)
MIME-Version: 1.0
Sender: michaelwood0331@gmail.com
Received: by 2002:a05:6512:6c5:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:24:14
 -0700 (PDT)
From:   MRS HANNAH VANDRAD <h.vandrad@gmail.com>
Date:   Wed, 6 Jul 2022 09:24:14 -0700
X-Google-Sender-Auth: Kyb-yvtmGaTJbouGf4HeSeq3_gQ
Message-ID: <CACaNVU=GLngipHHgMeg+zOAxCpM6A-sKA-+o_-9bKmHuKU2pKw@mail.gmail.com>
Subject: Greetings dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michaelwood0331[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michaelwood0331[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Greetings dear



   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Hannah
Vandrad, a widow suffering from a long time illness. I have some funds
I inherited from my late husband, the sum of ($11,000,000.00,)
 my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest and God fearing person who can claim this
money and use it for Charity works, for orphanages and gives justice
and help to the poor, needy and widows says The Lord." Jeremiah
22:15-16.=E2=80=9C and also build schools for less privilege that will be
named after my late husband if possible and to promote the word of god
and the effort that the house of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

I am waiting for your reply.

May God Bless you,


 Mrs. Hannah Vandrad.
