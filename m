Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCAB2DD3B1
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 16:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgLQPDf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 10:03:35 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:10777 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLQPDf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Dec 2020 10:03:35 -0500
Date:   Thu, 17 Dec 2020 15:02:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1608217373;
        bh=Ct//XJf8TFRzjf0mnFYEZLHhfdn3kQLr6stdCSpQBCE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Snu0vh8Hsj2tgD2V88UeYtUfY9+ji+LHInlvk+bAirxDnpJ9vfBqfBEaGd2VVZmgE
         w5VmsItgRx2hsnc9fYoyEpMxW282uLipR0VH9XbJVzT8IMzFbB2P/e/jr0bbSk6s4t
         YjWOsnbhPSCrnn4gxVcKHHI8txZ7wmmEJxhCT058=
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
Subject: Re: [External] Re: [PATCH v6 2/3] ACPI: platform-profile: Add platform profile support
Message-ID: <lz2i0N6rCGcqra4IF0bl9Q0ke6btCg4-uW4fwI4PCnjsfLvhF2hm3SgqjCtUBybLzZTKDMmleu123UylZDfAjZ_jsayppN-X0PnSaaNwK6c=@protonmail.com>
In-Reply-To: <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com> <20201211020630.305905-2-markpearson@lenovo.com> <CAJZ5v0hMnRizowg-FeS0ON9eJOD7ootqdTVyCPFRr6VCz7aS5g@mail.gmail.com> <l-Nzteqdz9SbINiwW0w4kFnKwknGoh5DH7VXqvkb23SZPwhvNyna0FRV9z2IZ18T0S9-a4n3LGBR1pMZYKX4FcxNTOma7vIuya66CY_Mkpc=@protonmail.com> <CAJZ5v0hHoScy18FE_Aj+zoWpr-vUhGq-vO+8AjO7RxmOvZBYMA@mail.gmail.com> <00993237-eb24-6038-3a85-bb76f96f679d@lenovo.com> <CAJZ5v0ji_+BbCrJo=3TB1Cytb8eV-tGE_m6R35UYfwmpUs6MAg@mail.gmail.com> <e682cdbd-41fe-065e-5912-d0fb94879dc9@lenovo.com> <CAJZ5v0gMo_22OJvjrufJy6uQsMjh+AT_mYQyFD-LpNzAwhkimA@mail.gmail.com>
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

2020. december 17., cs=C3=BCt=C3=B6rt=C3=B6k 14:36 keltez=C3=A9ssel, Rafael=
 J. Wysocki <rafael@kernel.org> =C3=ADrta:

> [...]
> > >> My thinking here that I shouldn't make assumptions for future platfo=
rm
> > >> implementations - there may be valid cases in the future where being
> > >> able to return an error condition if there was an error would be use=
ful.
> > >>
> > >> Just trying to keep this somewhat future proof. Returning an error
> > >> condition seemed a useful thing to have available.
> > >
> > > You can still return an error while returning a platform_profile_opti=
on value.
> > >
> > > Just add a special value representing an error to that set.
> > >
> > I'd like to understand what is better about that approach than having a=
n
> > error and a returnable parameter?
> >
> > I'm probably missing something obvious but if I add an extra
> > platform_profile option (e.g PLATFORM_PROFILE_ERROR) to be used in an
> > error case (and return just an enum platform_profile_option) it seems I
> > lose the granularity of being able to return a specific error condition=
.
> > It doesn't feel like an improvement.
>
> And what's the user expected to do about the different error codes
> that can be returned?

Even assuming the users of the API cannot or will not handle different erro=
rs
differently, who would benefit from getting rid of this information which m=
ay be
an aid in debugging for those who know what they're looking at?

And if a new enum value is introduced to signal an error condition, how is =
that
going to be communicated to the users? A magic string like "error" or "-1"?
Or under a single errno like -EIO? Personally, I believe neither of these t=
wo
solutions are better than returning the actual errno which is deemed most
appropriate by the platform profile handler. Or am I missing a third way?


Regards,
Barnab=C3=A1s P=C5=91cze
