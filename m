Return-Path: <linux-acpi+bounces-12596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653B3A77E76
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 17:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2013C7A4747
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E1320550E;
	Tue,  1 Apr 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HHd3VnwO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19249204F6C
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519824; cv=none; b=LpRXJjCaj4kQBYScnhvxOfhioej6XVdQYvLjFlLlf7ElTaulCIImFmw8EeAe2cRBA3aB9O2UrO9EVlcZV9F+PWBQqtvV2QaYeHhMg6RS2TFFnqE73mXHbLpX4DxeWjtb2QdXcVE1lMZziDPdWta9CwSSiIIxOelyZB5cXR7HmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519824; c=relaxed/simple;
	bh=EKSxIUkrDjqKZMQqE74LbP72tPlcKY7ZVvhYXISQkVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR92gJcFF5FZiIVZaYdmmE5gBGwherehp6DZDsPAc+J2oz65yfvGsqEL9U4feUHhaJ+RSFDg8RrBTH9Vf0q9rNyHS9Ewg1ON8HAUQYa5MSG3TVHljrVh1kLwOC/WXdirZa7hAQm1A+GpWcv0Y1tB8pQcDz6SmE6LZKPQqkECJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HHd3VnwO; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 80DCE2E09135
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:03:33 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743519817;
	bh=VCqZDu0GRyXyWyeGbjuJHet7MQ8A+p8hHf7YIPpXe1g=;
	h=Received:From:Subject:To;
	b=HHd3VnwOBmwkzTpqDGxCERuRKP06mTTvcLBUeyfuQmqwmeng2ARayE6T4y0c6UT1k
	 wgFQ4dL1LuXXxxC4VXER17Syg7n0V57OgkxgWSybJ340u/TrRGelD+iWrZdPl41lST
	 7QiCLu0HioOXRScpcIw4FhIxhktcge14yy+ArhHA=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.53) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f53.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5498d2a8b89so6659661e87.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 08:03:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCX0YQhuuEbmSuW/qSowNz1IY6oPNxnbc/nEquRtefbrqEJ3YujAPJiZzWMch6jNM1FzUmb5WEjBdFB0@vger.kernel.org
X-Gm-Message-State: AOJu0YynJB9NflKO7H024wB+RzsM5o5kfn0Rid1SZ3GfWMWsj2UC1HsG
	VYBgld1+uBQfMxVnVo4LrsKpp6OqdoSWXIBz3ZkTxvlV8ngVzqYiItTtAMzNip95Q1Kvt68FrhR
	woedD4Z6BQ61XRVPJHquZMB2IRa8=
X-Google-Smtp-Source: 
 AGHT+IHbgEgHokinKrcnIa5wb3eXmd5xchTDJ0+YhVV+zAcOOvtWc/7jNdEVdieIRFLJ4/NGFzyAoZ2x1iNx4Lg0Kyg=
X-Received: by 2002:a2e:bc01:0:b0:30c:3099:13db with SMTP id
 38308e7fff4ca-30de024b23dmr35574801fa.14.1743519812587; Tue, 01 Apr 2025
 08:03:32 -0700 (PDT)
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
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
 <1eb121e5-c0d3-49a8-9579-6ea5543ad4f9@kernel.org>
 <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
 <6a9268de-4072-4ef2-9f33-95cc783a8595@kernel.org>
In-Reply-To: <6a9268de-4072-4ef2-9f33-95cc783a8595@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 17:03:20 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF6iFkgvS54KYGMg554S9DTD83rq2ctH=UtFO-b8c1H1Q@mail.gmail.com>
X-Gm-Features: AQ5f1JrvCCV7ckif7SGq6-0DVd2-eQaMmu2Xl992K0sXmz3bbhfOhbIcZ978erQ
Message-ID: 
 <CAGwozwF6iFkgvS54KYGMg554S9DTD83rq2ctH=UtFO-b8c1H1Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
	"derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174351981505.18520.3814431800576989596@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 16:09, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 4/1/2025 7:45 AM, Antheas Kapenekakis wrote:
> > On Tue, 1 Apr 2025 at 14:30, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >>>> Here are tags for linking to your patch development to be picked up.
> >>>>
> >>>> Link:
> >>>> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> >>>> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>
> >>
> >> I don't believe that b4 will pick these up, so I will send out a v2 with
> >> them and mark this patch as superceded in patchwork so that Rafael
> >> doesn't have to pull everything out of this thread manually.
>
> FTR I don't have permission on patchwork for linux-acpi.
>
> I sent out v2 though.
>
> >>
> >>>
> >>> And to avoid having this conversation again, there is another Legion
> >>> Go S [3] patch you nacked and froze the testing for, so you could go
> >>> on the manhunt for the real cause of this one. But it will probably be
> >>> needed and you will find that as you get TDP controls going. So if you
> >>> want me to prepare that in a timely manner, because that one actually
> >>> needs rewriting to be posted, now is the time to say so.
> >>
> >> Can you please propose what you have in mind on the mailing lists to
> >> discuss?  It's relatively expensive (in the unit of tech debt) to add
> >> quirk infrastructure and so we need to make sure it is the right solution.
> >>
> >> Derek is working on CPU coefficient tuning in a completely separate
> >> driver.  If there are issues with that, I would generally prefer the
> >> fixes to be in that driver.
> >
> > CPU coefficient tuning? If you mean the lenovo-wmi-driver, yes I will
> > try to make sure the quirk can be potentially added there, or in any
> > driver*.
>
> Yes things like fPPT, sPPT, STAPM, STT limits.
>
> >
> > The idea is to rewrite the patch series to just add a simple delay
> > field on the s2idle quirk struct. Then the biggest delay wins and gets
> > placed in ->begin. We have been using that series for ~6 months now,
> > and it turns out that having a delay system for every call is quite
> > pointless. But there are also situations where you might have a device
> > such as the Z13 Folio which looks like a USB device but listens to
> > s2idle notifications through ACPI, so the hid subsystem might need to
> > be able to inject a small delay there.
>
> So the "general" problem with injecting delays is they are typically not
> scalable as they're usually empirically measured and there is no
> handshake with the firmware.
>
> Say for example the EC has some hardcoded value of 200ms to wait for
> something.  IIRC the Linux timer infrastructure can be off by ~13%.  So
> if you put 175ms it might work sometimes.  You get some reports of this,
> so you extend it to 200ms.  Great it works 100% of the time because the
> old hardcoded value in the EC was 200ms.
>
> Now say a new EC firmware comes out that for $REASONS changes it to
> 250ms.  Your old empirically measured value stops working, spend a bunch
> of cycles debugging it, measure the new one.  You change it to 250ms,
> but people with the old one have a problem now because the timing changed.
>
> So now you have to add infrastructure to say what version of the
> firmware gets what delay.
>
> Then you find out there is another SKU of that model which needs a
> different delay, so your complexity has ballooned.
>
> What if all these "delays" were FW timeouts from failing to service an
> interrupt?  Or what if they were a flow problem like the device expected
> you to issue a STOP command before a RESET command?
>
> So we need to be /incredibly careful/ with delays and 100% they are the
> right answer to a problem.

I do get your points. In this case though we sideskirt through a lot
of the points because of where the delay is placed.

If the instrumentation is in-place, this delay happens before sleep
after the screen of the device has turned off (due to early DPMS), the
keyboard backlight has turned off (DIsplay off call), and the suspend
light pulses (Sleep Entry). So it does not affect device behavior and
you can be quite liberal. The user has left the device alone.

If the device needs e.g., 250ms you will not put 250ms, you will put
500ms. Still unsure, you bump it to 750ms. Also, even if the
manufacturer comes up with a new firmware that fixes this issue, you
can keep the delay for the life of the product, because keeping it
does not affect device behavior, and writing kernel patches takes time.

This is how I think about it, at least. A universal delay might be
needed eventually. But for now, limiting the scope to some devices and
seeing how that goes should be enough.

Antheas


Antheas

> >
> > But rewriting the series will take 1-2 weeks, so I need a heads up now
> > if you need it for the Go S launch.
> >
> > Specifically for the Z13 folio, since I brought that up, it seems like
> > all Aura devices including the Ally need a 300ms delay to fade their
> > backlights after sleep entry but before D3, but my testing has been
> > mixed here because KDE plays with the backlight while i test the
> > hid-asus series.
> >
> > *for general device stability such as in the Go S, I'd have a slight
> > preference for a non-platform quirk though.
> >
> > Antheas
> >
> >>>
> >>> Antheas
> >>>
> >>> [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
> >>> [2] https://gitlab.com/evlaV/linux-integration/-/commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
> >>> [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
> >>>
> >>>>> Not that I am content with it, which you might have noticed with my
> >>>>> absence in the amd/drm issue tracker.
> >>>>>
> >>>>> So, was it the touchscreen after all? Did you verify this by tweaking
> >>>>> its firmware?
> >>>>
> >>>> Yes it's the touchscreen causing this issue.  It was confirmed by a
> >>>> hardware rework.
> >>>>
> >>>>>
> >>>>> Antheas
> >>>>>
> >>>>> [1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> >>>>>
> >>>>>
> >>>>>> Thanks,
> >>>>>>
> >>>>>>>>
> >>>>>>>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> >>>>>>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>>>> ---
> >>>>>>>>>      drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
> >>>>>>>>>      1 file changed, 28 insertions(+)
> >>>>>>>>>
> >>>>>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >>>>>>>>> index 8db09d81918fb..3c5f34892734e 100644
> >>>>>>>>> --- a/drivers/acpi/ec.c
> >>>>>>>>> +++ b/drivers/acpi/ec.c
> >>>>>>>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
> >>>>>>>>>                             DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
> >>>>>>>>>                     },
> >>>>>>>>>             },
> >>>>>>>>> +       /*
> >>>>>>>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
> >>>>>>>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>>>>>>>> +        */
> >>>>>>>>> +       {
> >>>>>>>>> +               .matches = {
> >>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> >>>>>>>>> +               }
> >>>>>>>>> +       },
> >>>>>>>>> +       {
> >>>>>>>>> +               .matches = {
> >>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> >>>>>>>>> +               }
> >>>>>>>>> +       },
> >>>>>>>>> +       {
> >>>>>>>>> +               .matches = {
> >>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> >>>>>>>>> +               }
> >>>>>>>>> +       },
> >>>>>>>>> +       {
> >>>>>>>>> +               .matches = {
> >>>>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> >>>>>>>>> +               }
> >>>>>>>>> +       },
> >>>>>>>>>             { },
> >>>>>>>>>      };
> >>>>>>>>>
> >>>>>>>>> --
> >>>>>>>>> 2.43.0
> >>>>>>>>>
> >>>>>>
> >>>>
> >>
>

