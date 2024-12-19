Return-Path: <linux-acpi+bounces-10203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B719F86C0
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 22:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0699C7A41EF
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462981BEF71;
	Thu, 19 Dec 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="iN1RjOIS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC951A2632;
	Thu, 19 Dec 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642652; cv=none; b=CxkujelgyWZmk9DGkzf7vC8LQC/st6V+E1hKbx+LxhmfL/3SUV/pkacUcZSDl2RmkkrO6B6D+KklZwVUpM3puKUWcgH0t/muqqUcQ4JKr2im9sObg/gF3oc0jUaaHFSs88ZyOzM5Xh71UkIKMkt4GA5ayM7WLdtb6WFQPiroTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642652; c=relaxed/simple;
	bh=AKExuUvpLLQKfzCS8enCnzdakzkCRASdovRFSJnq0U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mj9bkpuzr+khoyM2IQUctshvBgEcfvk1CQHubYRbsJDAQ3xMFnBbgSiPpafo1TTVOXrSuuX5vEMogJ20lOQfu2/lzsJJePwr2sQ2eFP4OhA2o/8GiyABOCrZCTqOPPGK3BHJxVZz7OWf71Zf/0CvtqeBNp8puXtDgqYO1980sjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=iN1RjOIS; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id A16A52E08B08;
	Thu, 19 Dec 2024 23:10:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1734642644;
	bh=4jPy3BBoxsKzbTEekHUiNUI/YjVghkL/lOcdr3wpEzA=;
	h=Received:From:Subject:To;
	b=iN1RjOIS2BnrdK2l4E5KV/RmaJSMNLSlkgzRty38HMCYi04pkwT7KTyvY6vhZDJrh
	 1F96Lgd3MYQClc94E14rZOPkqfecgsLNka/oHcXpH1fx07tVcCmSm0zD9lqFzRwm71
	 ouXZFHcaOu7vQn+AJdTngRJ96mxAONkQE3HruUQk=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-30219437e63so23904161fa.1;
        Thu, 19 Dec 2024 13:10:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUG8iMU1yzoxVskWuWLo/Dkj0RdKZHS15srAKRBDoJFDG/wAn06RyCaiVBb29jI3OgClrJJ0P+y5TIQ/AXh@vger.kernel.org,
 AJvYcCW+zpTdwDMBVeWZkFsayB0bzWHz57G8roiEbvasNtKfLCgp9vX58m08Fo0RxuL+Yb5H2sxQxgZJVcqz@vger.kernel.org,
 AJvYcCXuvOZnkSOR+w8TnC2Uiz3Zl/wLYyjmJJOfWfXWeQhuZt5n8oqltKoRu8F2XWPmItPj7VBTiV1oE54klxcj7Zi86caC+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGtiVeNCh5Ezsu70I3UmVyrxxfC1xsdsHoxuOvL6ym4jaFuuGO
	ZMs3OjbBtmqIMKbryU3n4HuqOhUZMQXD6aIFDbTh+FO0tC+4dji9AbdhkMS66irDL+lRDcZzRe/
	dWDyRFT4F+/jLjsebnxPcKm+wph4=
X-Google-Smtp-Source: 
 AGHT+IHBdSxHPKfrD/oiOvqXkSPBe6NzV75e6KGwr0Kpy2xQySoYhaT95rP8/f2EyNoTVGOJ6ipgE3O0ZYlLonlOuWg=
X-Received: by 2002:a2e:bc1b:0:b0:302:215f:94ee with SMTP id
 38308e7fff4ca-30458337550mr18500031fa.4.1734642641772; Thu, 19 Dec 2024
 13:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <CAGwozwFjo4uSFpCAXRKivK+VoeYz-Qftmw+iLtOrVnyhn3xpfA@mail.gmail.com>
 <ba5a7961-de65-41a1-a556-338ed1b06faa@kernel.org>
 <CAGwozwEAuGOKTsPvko4Ncg9nhkXiinb0B8-kXBaQ6dxyLocD5w@mail.gmail.com>
 <deda5a04-ba48-43c0-83c9-2f0afcaefb18@kernel.org>
In-Reply-To: <deda5a04-ba48-43c0-83c9-2f0afcaefb18@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Dec 2024 22:10:30 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG3WCOa6s0_73-e1-iQOwMy413tBqj8WXk=J5FPkq3+QA@mail.gmail.com>
Message-ID: 
 <CAGwozwG3WCOa6s0_73-e1-iQOwMy413tBqj8WXk=J5FPkq3+QA@mail.gmail.com>
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Mario Limonciello <superm1@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <173464264300.20179.5722608661961526331@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 19 Dec 2024 at 17:14, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 12/19/2024 09:24, Antheas Kapenekakis wrote:
> > On Thu, 19 Dec 2024 at 15:50, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >> On 12/19/2024 07:12, Antheas Kapenekakis wrote:
> >>> Hi Mario,
> >>> given that there is a Legion Go driver in the works, and Asus already
> >>> has a driver, the only thing that would be left for locking down ACPI
> >>> access is manufacturers w/o vendor APIs.
> >>>
> >>> So, can we restart the conversation about this driver? It would be
> >>> nice to get to a place where we can lock down /dev/mem and ACPI by
> >>> spring.
> >>
> >> As Shyam mentioned we don't have control for limits by the PMF driver
> >> for this on PMF v2 (Strix) or later platforms.
> >>
> >> So if we were to revive this custom discussion it would only be for
> >> Phoenix and Hawk Point platforms.
> >
> > That's unfortunate.
> >
> >>>
> >>> Moreover, since the other two proposed drivers use the
> >>> firmware_attributes API, should this be used here as well?
> >>
> >> I do feel that if we revive this conversation specifically for Phoenix
> >> and Hawk Point platforms yes we should use the same API to expose it to
> >> userspace as those other two drivers do.
> >>
> >> I'd like Shyam's temperature on this idea though before anyone spends
> >> time on it.  If he's amenable would you want to work on it?
> >
> > We currently expect the 2025 lineup to include a lot of Strix Point
> > handhelds, so I'd like a solution that works with that. OneXPlayer
> > released a model already, and GPD is getting ready to ship as well.
> >
> > Yeah, I could throw some hours to it after I go through some overdue stuff.
> >
> >>>
> >>> By the way, you were right about needing a taint for this. Strix Point
> >>> fails to enter a lower power state during sleep if you set it to lower
> >>> than 10W. This is not ideal, as hawk point could go down to 5 while
> >>> still showing a power difference, but I am unsure where this bug
> >>> should be reported. This is both through ryzenadj/ALIB
> >>
> >> Who is to say this is a bug?  Abusing a debugging interface with a
> >> reverse engineered tool means you might be able to configure a platform
> >> out of specifications.
> >
> > The spec being 10+W would be very undesirable for handhelds with Strix
> > Point, so I'd hope somebody looks into it, esp. if it can be fixed
> > with a BIOS fw update before more handhelds come out. I can raise the
> > minimum TDP to 10W, with some user complaints.
> >
> > Asus and Lenovo use the same mailbox so they'd share the issue too.
> >
> > FYI for a typical handheld with e.g., a 60Wh battery, a 10W envelope
> > results in around 20-22W total consumption which is around 2.5 hours.
> > Hawk Point can be TDP limited down to 16W total consumption (TDP ~7W)
> > and can go down to 8W with frame limiting etc. I do not have numbers
> > for Strix Point yet, but to match Hawk Point it has to allow TDP to go
> > down to 7W. I think for 2025, customer expectation will be 6-8 hours+
> > at low wattages.
> >
>
> I've got a fundamental question - why the fixation on PPT?
>
> This just sets "limits" for the package.  In Windows it's probably the
> best knob to tune to adjust performance in an effort to extend battery
> life, but in Linux we have a lot of other knobs:
>
> * the ability to tune EPP (energy_performance_preference)
> * set min and max CPU frequencies (scaling_min_freq, scaling_max_freq)

We use both of these.

> * offline cores at will

if a core is parked and you try to write into its sysfs entrypoints,
we found that this might cause a userspace program to hang
indefinitely. Since a lot of settings are per core that's problematic
and since it does not help much most TDP programs dont offer it
anymore.

> * change DPM setting in the GPU driver (power_dpm_force_performance_level)

I think we played with this mostly to try to get lower than 800mhz.
However, going lower than 800mhz in these APUs causes issues.

> All the core related knobs can be changed on a per-core basis.  So for
> example even on a non-heterogeneous design you could potentially make it
> perform "like" a hetero design where you set it so that some cores don't
> go above nominal frequency or the EPP value is tuned less aggressively
> on some cores.

> These knobs can have just as drastic of a result on battery life as
> adjusting the various power limiting knobs.  Most importantly these
> knobs have architectural limits that you won't be able to override so
> you can safely change them to min/max and see what happens.

I feel like we are discussing different targets here. When it comes to
computing tasks, you have a certain block of work that needs to be
done and after that the CPU is free. In this case, programs like tuned
(allegedly) optimize these settings so that they take the minimum
amount of power to complete that block of work.

However, games are different. Games have no problem burning power if
you let them and they are also playable at a variety of power levels.
Typically, unless the user caps the framerate and video quality of the
game it will use the full slow temp limit value. Even if they do set
that, the game will typically burn 3-4W more than what is needed
depending on TDP, EPP etc.

Therefore, the question we ask users is how loud do you want your
device to be and how long (in hours) do you want the battery to last.
This is done by ppt + the other settings, which are set automatically
based on ppt.

Then the users can compromise with what fidelity and fps they get
based on their TDP.

> I feel like specifically if you keep EPP at balance_performance, keep
> scaling_min_freq at lowest non linear frequency and change
> scaling_max_freq on a few of the cores you should be able to influence
> the battery life quite a bit while still keeping the system responsive.

The sweet spot on these APUs is max freq to be nominal (i.e., no
boost), EPP at balance_power or power for very low tdps, and min_freq
to be 0. Especially for min_freq, setting it to lowest non-linear
seems to have no effect.

Antheas

