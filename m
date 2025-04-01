Return-Path: <linux-acpi+bounces-12586-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2AA77B2C
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9D887A3461
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65741E47A9;
	Tue,  1 Apr 2025 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="HM9Mywrh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136E26AF3
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511525; cv=none; b=Hqv2zqglOJ431RP1t9zNoyEcWsW8VuLtur/F7zcyJldrnk+vZP9I9RX+iK/jygWJWZEiiCR96lNyDSfBI/foKzIYiU3mCv1eJ1mcctbSN5btJKid7Ni3xhk4Qb4Imn1E/0PfVx/ArwupzygUoiX0IfRvAfiFCpGnzqGHSg8VyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511525; c=relaxed/simple;
	bh=Bnkpfk13hQ2UAdcyKehtumR99r1s5JrvC++CH5Yuzxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mok64+gdhKVPQsP1uTiis/JCjT6I6n+dsBwCg/zWg4+WxaoofPdbvk57iUQy09e4aVU91aeaNsBqo/g0yZ6zn3Mjm3ZB3GhX9dNuAo7f66KwiIyguE3VRwXTfxc6wRgyMZhAcnFv/uMbEKW8MfLtFQDA1gz9CrgzYi3h2Ua1VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=HM9Mywrh; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2F49E2E08E29
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 15:45:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743511518;
	bh=uuUZMBbCxRDnQgkwGgrU08wyhofsWdmaCw/Qy8KLj6E=;
	h=Received:From:Subject:To;
	b=HM9MywrhwBfG+Jyp1Oc8O+7K2AhnQa34voPuHlmpCT0jgEVSmBNjwDjAE84FJoyrZ
	 Vl0UN/2kfvo+D8+DnvJXJxAnU+5InDNyjeJ4bsvA+p3lmgboz0SINyMYRxLAVys/dk
	 y5U8q0rA+JG07+oiSnJGtfZxPNuWqaF2TYSOY9Qs=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-30db3f3c907so52144971fa.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 05:45:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXlaPSX+CmPXBfxUB/XAKwSUcQn8JCHQP+dSoATJUa42j5gBstSMLI+R8OniVBd30gR5q8XfXHNJ/F+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6MYz0DMPvYBl176jVKNXp+ySLhd7IRkLIdXf/PQWl+bmVymKP
	JfnSo3Z5nrFeci8PC3UI0SHwFz8NdtPaIP9mWJubLgABZ9v5e7p2ZwV0ANYz0e0z6SdP4+vJpcF
	OLqjuSb+S9iVAQP8X0fZ3BX3yIq0=
X-Google-Smtp-Source: 
 AGHT+IGSt7TNHebD50mLK1N9E4lKh2YGITZfLBnW2oCuwlmLCZsYQcRt+vfQPhZUPua7LLo982JuPbsySX5nd+yEhKY=
X-Received: by 2002:a05:651c:1142:b0:308:e8d3:7578 with SMTP id
 38308e7fff4ca-30de0303e30mr40483081fa.35.1743511517442; Tue, 01 Apr 2025
 05:45:17 -0700 (PDT)
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
In-Reply-To: <1eb121e5-c0d3-49a8-9579-6ea5543ad4f9@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 14:45:05 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
X-Gm-Features: AQ5f1Jr3TKkgQQgkM2lDNeINGn6BHIA0VlOXVp_xB3_6PQEHe3WdWWnMEj55aXg
Message-ID: 
 <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
	"derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174351151869.9687.3057516376173108309@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 14:30, Mario Limonciello <superm1@kernel.org> wrote:
>
> >> Here are tags for linking to your patch development to be picked up.
> >>
> >> Link:
> >> https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> >> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> >> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> >
>
> I don't believe that b4 will pick these up, so I will send out a v2 with
> them and mark this patch as superceded in patchwork so that Rafael
> doesn't have to pull everything out of this thread manually.
>
> >
> > And to avoid having this conversation again, there is another Legion
> > Go S [3] patch you nacked and froze the testing for, so you could go
> > on the manhunt for the real cause of this one. But it will probably be
> > needed and you will find that as you get TDP controls going. So if you
> > want me to prepare that in a timely manner, because that one actually
> > needs rewriting to be posted, now is the time to say so.
>
> Can you please propose what you have in mind on the mailing lists to
> discuss?  It's relatively expensive (in the unit of tech debt) to add
> quirk infrastructure and so we need to make sure it is the right solution.
>
> Derek is working on CPU coefficient tuning in a completely separate
> driver.  If there are issues with that, I would generally prefer the
> fixes to be in that driver.

CPU coefficient tuning? If you mean the lenovo-wmi-driver, yes I will
try to make sure the quirk can be potentially added there, or in any
driver*.

The idea is to rewrite the patch series to just add a simple delay
field on the s2idle quirk struct. Then the biggest delay wins and gets
placed in ->begin. We have been using that series for ~6 months now,
and it turns out that having a delay system for every call is quite
pointless. But there are also situations where you might have a device
such as the Z13 Folio which looks like a USB device but listens to
s2idle notifications through ACPI, so the hid subsystem might need to
be able to inject a small delay there.

But rewriting the series will take 1-2 weeks, so I need a heads up now
if you need it for the Go S launch.

Specifically for the Z13 folio, since I brought that up, it seems like
all Aura devices including the Ally need a 300ms delay to fade their
backlights after sleep entry but before D3, but my testing has been
mixed here because KDE plays with the backlight while i test the
hid-asus series.

*for general device stability such as in the Go S, I'd have a slight
preference for a non-platform quirk though.

Antheas

> >
> > Antheas
> >
> > [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
> > [2] https://gitlab.com/evlaV/linux-integration/-/commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
> > [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
> >
> >>> Not that I am content with it, which you might have noticed with my
> >>> absence in the amd/drm issue tracker.
> >>>
> >>> So, was it the touchscreen after all? Did you verify this by tweaking
> >>> its firmware?
> >>
> >> Yes it's the touchscreen causing this issue.  It was confirmed by a
> >> hardware rework.
> >>
> >>>
> >>> Antheas
> >>>
> >>> [1] https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e808c72e6b1836da4a95fc63
> >>>
> >>>
> >>>> Thanks,
> >>>>
> >>>>>>
> >>>>>>> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> >>>>>>> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> >>>>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>>>>> ---
> >>>>>>>     drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
> >>>>>>>     1 file changed, 28 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> >>>>>>> index 8db09d81918fb..3c5f34892734e 100644
> >>>>>>> --- a/drivers/acpi/ec.c
> >>>>>>> +++ b/drivers/acpi/ec.c
> >>>>>>> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
> >>>>>>>                            DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
> >>>>>>>                    },
> >>>>>>>            },
> >>>>>>> +       /*
> >>>>>>> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up from EC
> >>>>>>> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> >>>>>>> +        */
> >>>>>>> +       {
> >>>>>>> +               .matches = {
> >>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> >>>>>>> +               }
> >>>>>>> +       },
> >>>>>>> +       {
> >>>>>>> +               .matches = {
> >>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> >>>>>>> +               }
> >>>>>>> +       },
> >>>>>>> +       {
> >>>>>>> +               .matches = {
> >>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> >>>>>>> +               }
> >>>>>>> +       },
> >>>>>>> +       {
> >>>>>>> +               .matches = {
> >>>>>>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >>>>>>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> >>>>>>> +               }
> >>>>>>> +       },
> >>>>>>>            { },
> >>>>>>>     };
> >>>>>>>
> >>>>>>> --
> >>>>>>> 2.43.0
> >>>>>>>
> >>>>
> >>
>

