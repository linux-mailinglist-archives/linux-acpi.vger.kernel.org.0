Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006412DC6B1
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 19:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgLPSmy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 13:42:54 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:14904 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgLPSmx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2020 13:42:53 -0500
Date:   Wed, 16 Dec 2020 18:42:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608144131;
        bh=bjEMbxsRKDZFGIURv7LQRdyvGAt7PpANZNbe0eQmDQA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=t1E0yFZwA9d9oDFfC0hI9qvG3M/uXHyJNHOg/WFu3mhpjyjpDayxW3bvQOQWTY2jm
         uGdGggeLDjfI0kXAGV9X2V/RaXS8kMv5/HW/92WReM4Y1jtHayx2W2puxU8DGf89Yg
         hH8vuyXo57HCyWDa0Da83eiDEhL7SxY0j5jOznEs=
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        "njosh1@lenovo.com" <njosh1@lenovo.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v6 2/3] ACPI: platform-profile: Add platform profile support
Message-ID: <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com>
In-Reply-To: <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com> <20201211020630.305905-2-markpearson@lenovo.com> <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com>
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

2020. december 16., szerda 19:13 keltez=C3=A9ssel, Rafael J. Wysocki =C3=
=ADrta:

> On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wro=
te:
> >
> > This is the initial implementation of the platform-profile feature.
> > It provides the details discussed and outlined in the
> > sysfs-platform_profile document.
> >
> > Many modern systems have the ability to modify the operating profile to
> > control aspects like fan speed, temperature and power levels. This
> > module provides a common sysfs interface that platform modules can regi=
ster
> > against to control their individual profile options.
> >
> > Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> [...]
> > +enum platform_profile_option {
> > +       PLATFORM_PROFILE_LOW,
> > +       PLATFORM_PROFILE_COOL,
> > +       PLATFORM_PROFILE_QUIET,
> > +       PLATFORM_PROFILE_BALANCED,
> > +       PLATFORM_PROFILE_PERFORM,
> > +       PLATFORM_PROFILE_LAST, /*must always be last */
> > +};
> > +
> > +struct platform_profile_handler {
> > +       unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
> > +       int (*profile_get)(enum platform_profile_option *profile);
>
> I'm not sure why this callback is necessary and, provided that there
> is a good enough reason, why it cannot return an enum
> platform_profile_option value.
>
> In principle, if ->profile_set() returns 0, the requested profile can
> be saved in a static var and then returned by subsequent "read"
> operations.
>

It is possible that the platform profile can be changed with (e.g.) a dedic=
ated
button (commonly found on laptops), in which case there needs to be a mecha=
nism
to retrieve the new profile, which would not be possible without introducin=
g
something else in place of that getter - unless I'm missing something obvio=
us.


Regards,
Barnab=C3=A1s P=C5=91cze
