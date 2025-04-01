Return-Path: <linux-acpi+bounces-12582-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A3EA77718
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F4D1886830
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 09:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8741BBBFD;
	Tue,  1 Apr 2025 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="ZyemjEUs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0F2E3398
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498091; cv=none; b=OpzT7isRNbLggoYi00HZE9HpEXVba+lz80lMJuHA7YTg28XhUoAuujS7Fp6cXiaQaS1oBUA86e5kI7jiUOvToRFOtpvDtZf6AJOIEOyppJvua+ADSQ424Zv1DAS2EEYufg9awLRi520M7lUx90HwxIlj6TgRiDb8wXQqK+bNN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498091; c=relaxed/simple;
	bh=N3ElgbiDnvb7GdfFMoLSzmundiB4BzhzWkvDbWPscUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHDqfo0Sp9LB3TmB9qQ/OEpLjFSJqLf7D5zdthuRaM9XUuL1S3dzE4mcA1o8V2G/k0MlrLPfZXy0+sCxrTrdG0k9tJefcEI6a80MwNeC8HfE2CTkD5UQbcOlugFGo7ekIBR5rmr5DLR2cqqyfdQFS2OUo6FBdsq1h1sntZ2SvAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=ZyemjEUs; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id C4FDE2E03400
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 12:01:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743498082;
	bh=KOA+JFhQfuTndbxIAfzLYBZtbFSXG1GCW6ZDTptVtyQ=;
	h=Received:From:Subject:To;
	b=ZyemjEUsDIIcBdm7XCEs/XN4l4GmAoscG7s/TioZksx4UxdZTBkcvlw/GIkqXN2nR
	 eyvFeU+/mpLBcmQ0Sk4ZGfivgQnNtaPpIJqaZrIR0rbhuaAsHATzENNm9f6NyMtzQP
	 aKmUJYRraxudZXeSbsEYOElZils5qUCkqZVJV0RI=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.181) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f181.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-30bf8632052so46525511fa.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 02:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW0bRHtRgfIEsaPoPTalzSi4K9EE/mbtj9d5lxS94VQpqhdYzbGxekLyaYr86hfGE07m74aToA1wSV9@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+xDVc0vtb/YIjZZLQhdwPXZNGnMnb3metmJ0t7G2hkar8EVc
	AOr4AY5DjjsM7htzbvze3fUNYvpOlSwY6v2ySWW+ThRTBVJXLpzvGRWFJVIOwgNYyD4paLOm+7Y
	2d2z1reEi8i1izT/Nee5SV3CSAIs=
X-Google-Smtp-Source: 
 AGHT+IE8fncfzTW93YEyNKtZcfGZy0juTDKppiugl9+HWMcG9rUItJIMinFj5cR5MaEaX+vM8icy5dqaPp6R76vXZYQ=
X-Received: by 2002:a2e:bd03:0:b0:302:48fd:6922 with SMTP id
 38308e7fff4ca-30de02f8562mr41010261fa.37.1743498079851; Tue, 01 Apr 2025
 02:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
In-Reply-To: <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 11:01:08 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
X-Gm-Features: AQ5f1JrI2CWOug-xvvgIUfOusyAiA8Wac7hHGkQ65mSB1s_S8bpopsgnKqHTTkc
Message-ID: 
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174349808156.20047.366346506954148941@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 04:40, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 3/31/2025 4:16 PM, Antheas Kapenekakis wrote:
> > On Mon, 31 Mar 2025 at 22:55, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >> On 3/31/2025 3:53 PM, Antheas Kapenekakis wrote:
> >>> On Mon, 31 Mar 2025 at 22:51, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >>>>
> >>>> On Mon, 31 Mar 2025 at 22:44, Mario Limonciello <superm1@kernel.org> wrote:
> >>>>>
> >>>>> From: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>
> >>>>> When AC adapter is unplugged or plugged in EC wakes from
> >>>>> HW sleep but APU doesn't enter back into HW sleep.
> >>>>>
> >>>>> The reason this hapens is that when APU exits HW sleep the power
> >>>>> rails the EC controls will power up the TCON.  The TCON has a
> >>>>> GPIO that will be toggled during this time.  The GPIO is not marked
> >>>>> as a wakeup source however GPIO controller still has an unserviced
> >>>>> interrupt and it will block entering HW sleep again. Clearing the
> >>>>> GPIO doesn't help, the TCON raises it again until it's been initialized
> >>>>> by i2c-hid.
> >>>>>
> >>>>> Fixing this would require TCON F/W changes and it's already broken
> >>>>> in the wild on production hardware.
> >>>>>
> >>>>> To avoid triggering this issue add a quirk to avoid letting EC wake
> >>>>> up system at all.  The power button still works properly on this system.
> >>>>
> >>>> Hi Mario,
> >>>> I reported this issue to you early in January, did all the debugging
> >>>> for it, found the cause, made this patch, tested it, and finally
> >>>> deployed it as well. Then sent it to Xino.
> >>>>
> >>>> Then you pushed back for perfectly valid reasons, and we had a
> >>>> multi-week long back and forth trying to find the proper cause for
> >>>> this.
> >>>>
> >>>> So from my side I do not get why I am just a reported-by here. This is
> >>>> my patch. We also had a discussion about this out of band.
> >>>>
> >>>> Antheas
> >>>
> >>> It is interesting you ended up finding the cause. Which makes
> >>> attributing this a bit murkier.
> >>>
> >>> Antheas
> >>
> >> Hi Antheas,
> >>
> >> FWIW - you and I separately created very similar patches.
> >
> > There is only one way to write a no_ec_wakeup patch after I reported
> > to you that it fixes it, here [1] mine is the same, even the DMI order
> > is the same.
>
> You mean the same order as my patch for GoS that applied to acp-6x?
>
> commit b9a8ea185f3f8 ("ASoC: acp: Support microphone from Lenovo Go S")

Yes, which was submitted, accepted, and prior work at the time, so you
do not get to be credited for it as part of this patch as well.

> >
> >> There has been more debugging that is not public (as you can see from
> >> the content of this commit message).
> >>
> >> What tag would you like in this case?
> >
> > I think co-developed-by since you also worked very hard on fixing
> > this. I do not know if b4 picks up co-developed tags.
> >
>
> Here are tags for linking to your patch development to be picked up.
>
> Link:
> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Anyways, you got what my problem here was. You nacked and bikeshed
this patch for 2 months, and that was after I did all the background
research, testing and deployed it [1], so you could find the real
cause, which I let you do as a _professional courtesy_. Then, out of a
sudden you are the primary author on a patch I authored and you nacked
and started testing after it was done [2].

I guess a nicer way of saying this is that you make it hard to
collaborate on kernel development. When I bring up issues to you, do
the background research, bisect, and general grunt work for them, you
do a minor cleanup which is easy for you as a kernel developer, then
strip the credit for them and I have to hunt you down to get some of
it back. This is not a productive environment, I cannot work like
this.

I think this is the 6th or 8th time this happened but this time it is
particularly egregious, because you had me spend 20 hours debugging
offshoots after my patch was already done in random directions trying
to find a real cause, only to see me get dropped to a normal reported
by, and that is after I told you off very harshly because of [2].
Otherwise the reported-by might have been missing too.

In any case, there is no point in rehashing this over and over.
Authorship in this series is mostly fine now, so it can go through.

And to avoid having this conversation again, there is another Legion
Go S [3] patch you nacked and froze the testing for, so you could go
on the manhunt for the real cause of this one. But it will probably be
needed and you will find that as you get TDP controls going. So if you
want me to prepare that in a timely manner, because that one actually
needs rewriting to be posted, now is the time to say so.

Antheas

[1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
[2] https://gitlab.com/evlaV/linux-integration/-/commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
[3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760

> > Not that I am content with it, which you might have noticed with my
> > absence in the amd/drm issue tracker.
> >
> > So, was it the touchscreen after all? Did you verify this by tweaking
> > its firmware?
>
> Yes it's the touchscreen causing this issue.  It was confirmed by a
> hardware rework.
>
> >
> > Antheas
> >
> > [1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> >
> >
> >> Thanks,
> >>
> >>>>
> >>>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> >>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>> ---
> >>>>>    drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
> >>>>>    1 file changed, 28 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >>>>> index 8db09d81918fb..3c5f34892734e 100644
> >>>>> --- a/drivers/acpi/ec.c
> >>>>> +++ b/drivers/acpi/ec.c
> >>>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
> >>>>>                           DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
> >>>>>                   },
> >>>>>           },
> >>>>> +       /*
> >>>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
> >>>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>>>> +        */
> >>>>> +       {
> >>>>> +               .matches = {
> >>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> >>>>> +               }
> >>>>> +       },
> >>>>> +       {
> >>>>> +               .matches = {
> >>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> >>>>> +               }
> >>>>> +       },
> >>>>> +       {
> >>>>> +               .matches = {
> >>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> >>>>> +               }
> >>>>> +       },
> >>>>> +       {
> >>>>> +               .matches = {
> >>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> >>>>> +               }
> >>>>> +       },
> >>>>>           { },
> >>>>>    };
> >>>>>
> >>>>> --
> >>>>> 2.43.0
> >>>>>
> >>
>

