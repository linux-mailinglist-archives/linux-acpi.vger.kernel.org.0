Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56242B414B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 11:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgKPKmC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 05:42:02 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:49662 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKPKmC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Nov 2020 05:42:02 -0500
Date:   Mon, 16 Nov 2020 10:41:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605523318;
        bh=/WV2tykl7QFI5295MXa4aW9hJf5TbvqqlS+GpFktc8Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=yGm+dERn62Ckc987BKG0rfjnxVm0wcqQjKCzSVd2xjMfAF9WJVN6IzHEpcpKjkNqc
         Dz59k1zrXQNttoKzP79N9k4ApOP5h77nD75ExhTePmp41sRWXhASUS2dBsu1rCFhSX
         IfNnI3j1QKZTcIFLGPlD9hMOX6gfgpUQP5HvPuJI=
To:     Mark Pearson <markpearson@lenovo.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "mario.limonciello@dell.com" <mario.limonciello@dell.com>,
        "eliadevito@gmail.com" <eliadevito@gmail.com>,
        "hadess@hadess.net" <hadess@hadess.net>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "dvhart@infradead.org" <dvhart@infradead.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [External] Re: [PATCH v2 3/3] platform/x86: thinkpad_acpi: Add platform profile support
Message-ID: <XA28kK3tz3phNUgFlhcMj2C2Wo_wKSktok4MytsBKMU-eTtG3mcmXyBT28Hni9FWHIIcUnzQTTVOzLhp6nQ2eEHv43dLtecJKE6xanuvWng=@protonmail.com>
In-Reply-To: <746e3f26-bca4-9659-abf2-98d81aa84f63@lenovo.com>
References: <markpearson@lenovo.com> <20201114150102.340618-1-markpearson@lenovo.com> <20201114150102.340618-3-markpearson@lenovo.com> <bC_Z4v6vrGG27schT2V4eci6RtrHSQrt1okyeocu4rdL0tka_bmMM43h9pphEknHKMPs5dbnXG-Kzs2SwSuwTO4dOkIeIVHUgYZ5EvNrkm0=@protonmail.com> <746e3f26-bca4-9659-abf2-98d81aa84f63@lenovo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi


2020. november 16., h=C3=A9tf=C5=91 0:22 keltez=C3=A9ssel, Mark Pearson =
=C3=ADrta:

> [...]
> >> +static int convert_profile_to_dytc(enum platform_profile_option profi=
le, int *perfmode)
> >> +{
> >> +=09switch (profile) {
> >> +=09case profile_low:
> >> +=09=09*perfmode =3D DYTC_MODE_QUIET;
> >> +=09=09break;
> >> +=09case profile_balance:
> >> +=09=09*perfmode =3D DYTC_MODE_BALANCE;
> >> +=09=09break;
> >> +=09case profile_perform:
> >> +=09=09*perfmode =3D DYTC_MODE_PERFORM;
> >> +=09=09break;
> >> +=09default: /* Unknown profile */
> >> +=09=09return -EOPNOTSUPP;
> >
> > I personally think EINVAL would be better here,
> > just like in `convert_dytc_to_profile()`.
> I liked how this worked when testing.
> If you put in an invalid profile name then platform_profile returned
> EINVAL but if you got this far you'd provided a valid profile setting
> that this driver doesn't support and the not supported message seemed
> clearer. As an example 'cool' is used on HP platforms but not Lenovo.
> I'd like to leave this one as it is please.
> >

I have just realized that the platform profile module does not check if
the profile the user wants to set is supported by the handler. As I've
mentioned in my other email, I think that should be checked. You could retu=
rn
EOPNOTSUPP there (in the platform profile module). After reading the explan=
ation
why you want to use EOPNOTSUPP, I believe it makes sense and it's fine.


> >
> >> +=09}
> >> +=09return 0;
> >> +}
> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
