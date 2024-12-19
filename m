Return-Path: <linux-acpi+bounces-10205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195619F86E3
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 22:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3AF818972A2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF01AE875;
	Thu, 19 Dec 2024 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="z++815eq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673921509BD;
	Thu, 19 Dec 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643692; cv=none; b=SBgn0MEkmCoJ7i8OhEXbv6HDCH2i0pmvuj3v+YBApPp/y02LD1iol4m1d26Qern0h52ZG+K2CjoXJzuDHwSHkWc3eeETEk3ZFKZhzLTbiZfwEHdSi07FLpBiB3r5+UTX/CgUGYZC1AcETnv034b+Tf17AO5ISfpCFra1Oia9+wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643692; c=relaxed/simple;
	bh=U1niAaaatu8bTc2zm9Wk8I64xKE3hnjktNws/GTJToE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNWB656nJeQ9Y2isVonjfl+ARAEvhS4l2zZf/3oytZy/816pUryGGk7a42GExYU6MCbWjRLpkeDklLds2c0e7YQ51GlO2p52uCU7ENdOHS+Z9nEIoCkKtJ4e+9NuyEMQXjUQPaCk1U3iWOg0AZ0PW3fj63GpmOscNjkmA06Br64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=z++815eq; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 500712E0274F;
	Thu, 19 Dec 2024 23:28:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1734643687;
	bh=OCiVoxejQcuLoeoN/9r+ZfVXKZFdwJs2B0Lb0WOToGY=;
	h=Received:From:Subject:To;
	b=z++815eqP+gR32I4DrSir4JubB9lhVjdcJPh2ONfErfaETm3kSFV1mzjhdJomlqFB
	 hBNeQKXzDllWw5TR7xVH4SYz1DZLB/H5aXIhvbvX/d18d4Tm8e4gGvAxGroxsj6a2B
	 oHC51lKQLZvC4SWARkb+qSPL6AdklZoIFR1qK4TM=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2ffd6af012eso14883431fa.2;
        Thu, 19 Dec 2024 13:28:06 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5C2Azlh9wdkLH9cS7+XOQvRL8yooaEuFb+NQtJvrxl+Lsbg30U/QDCCRGDIQrWOejggR2ET5hIeBSWiaPyyIrM/1sIw==@vger.kernel.org,
 AJvYcCWtTsda6byyL4M12AUbEpZnd7NbGlTM/Hi0cSTuDjIKsNNC7D8QU4MnvO8Zbtz7ETxnodxGrqrF4vbt@vger.kernel.org,
 AJvYcCXXa8VS9bg/NvXnyWJUA9FRVpPdGMmThCyiDF2jZ8pb1pObVkeuwut2O5J5vXTe6jQdVVzuGOCxQygYNauU@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8YwEbkdImlT9w3SUHTRxfVrkuW526EnJJJniLDO68gUhqR9K
	sHr1ae1FGK6p1IzKVUXcFeFflhg2gcPqv8Ve5auXTfmjff6HgtaOkKX7UUdVrWmy4SFtqawaW5l
	D5Jtr3Ij7UcgLFWjt7NYTebSers8=
X-Google-Smtp-Source: 
 AGHT+IGsuLnSHmFYR5Npt0yvuCg3HEuuQti2q8q/jKW5FIMhMsJuZhX3aueFti896D1tfLPtQYZMK4BwaonCkc9FQk4=
X-Received: by 2002:a2e:a54b:0:b0:300:317c:9b75 with SMTP id
 38308e7fff4ca-30468572d2dmr1601871fa.12.1734643685382; Thu, 19 Dec 2024
 13:28:05 -0800 (PST)
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
 <CAGwozwG3WCOa6s0_73-e1-iQOwMy413tBqj8WXk=J5FPkq3+QA@mail.gmail.com>
 <d56cc2e1-fe4f-4694-a987-6e0a49134c7f@kernel.org>
In-Reply-To: <d56cc2e1-fe4f-4694-a987-6e0a49134c7f@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 19 Dec 2024 22:27:53 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG8dFQfPzPVDa=rwKYLnraw7kRoLOZELZrkrW0tEfEsug@mail.gmail.com>
Message-ID: 
 <CAGwozwG8dFQfPzPVDa=rwKYLnraw7kRoLOZELZrkrW0tEfEsug@mail.gmail.com>
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
 <173464368671.7317.16409914136375568751@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Thu, 19 Dec 2024 at 22:21, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 12/19/2024 15:10, Antheas Kapenekakis wrote:
> > On Thu, 19 Dec 2024 at 17:14, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >> On 12/19/2024 09:24, Antheas Kapenekakis wrote:
> >>> On Thu, 19 Dec 2024 at 15:50, Mario Limonciello <superm1@kernel.org> wrote:
> >>>>
> >>>> On 12/19/2024 07:12, Antheas Kapenekakis wrote:
> >>>>> Hi Mario,
> >>>>> given that there is a Legion Go driver in the works, and Asus already
> >>>>> has a driver, the only thing that would be left for locking down ACPI
> >>>>> access is manufacturers w/o vendor APIs.
> >>>>>
> >>>>> So, can we restart the conversation about this driver? It would be
> >>>>> nice to get to a place where we can lock down /dev/mem and ACPI by
> >>>>> spring.
> >>>>
> >>>> As Shyam mentioned we don't have control for limits by the PMF driver
> >>>> for this on PMF v2 (Strix) or later platforms.
> >>>>
> >>>> So if we were to revive this custom discussion it would only be for
> >>>> Phoenix and Hawk Point platforms.
> >>>
> >>> That's unfortunate.
> >>>
> >>>>>
> >>>>> Moreover, since the other two proposed drivers use the
> >>>>> firmware_attributes API, should this be used here as well?
> >>>>
> >>>> I do feel that if we revive this conversation specifically for Phoenix
> >>>> and Hawk Point platforms yes we should use the same API to expose it to
> >>>> userspace as those other two drivers do.
> >>>>
> >>>> I'd like Shyam's temperature on this idea though before anyone spends
> >>>> time on it.  If he's amenable would you want to work on it?
> >>>
> >>> We currently expect the 2025 lineup to include a lot of Strix Point
> >>> handhelds, so I'd like a solution that works with that. OneXPlayer
> >>> released a model already, and GPD is getting ready to ship as well.
> >>>
> >>> Yeah, I could throw some hours to it after I go through some overdue stuff.
> >>>
> >>>>>
> >>>>> By the way, you were right about needing a taint for this. Strix Point
> >>>>> fails to enter a lower power state during sleep if you set it to lower
> >>>>> than 10W. This is not ideal, as hawk point could go down to 5 while
> >>>>> still showing a power difference, but I am unsure where this bug
> >>>>> should be reported. This is both through ryzenadj/ALIB
> >>>>
> >>>> Who is to say this is a bug?  Abusing a debugging interface with a
> >>>> reverse engineered tool means you might be able to configure a platform
> >>>> out of specifications.
> >>>
> >>> The spec being 10+W would be very undesirable for handhelds with Strix
> >>> Point, so I'd hope somebody looks into it, esp. if it can be fixed
> >>> with a BIOS fw update before more handhelds come out. I can raise the
> >>> minimum TDP to 10W, with some user complaints.
> >>>
> >>> Asus and Lenovo use the same mailbox so they'd share the issue too.
> >>>
> >>> FYI for a typical handheld with e.g., a 60Wh battery, a 10W envelope
> >>> results in around 20-22W total consumption which is around 2.5 hours.
> >>> Hawk Point can be TDP limited down to 16W total consumption (TDP ~7W)
> >>> and can go down to 8W with frame limiting etc. I do not have numbers
> >>> for Strix Point yet, but to match Hawk Point it has to allow TDP to go
> >>> down to 7W. I think for 2025, customer expectation will be 6-8 hours+
> >>> at low wattages.
> >>>
> >>
> >> I've got a fundamental question - why the fixation on PPT?
> >>
> >> This just sets "limits" for the package.  In Windows it's probably the
> >> best knob to tune to adjust performance in an effort to extend battery
> >> life, but in Linux we have a lot of other knobs:
> >>
> >> * the ability to tune EPP (energy_performance_preference)
> >> * set min and max CPU frequencies (scaling_min_freq, scaling_max_freq)
> >
> > We use both of these.
> >
> >> * offline cores at will
> >
> > if a core is parked and you try to write into its sysfs entrypoints,
> > we found that this might cause a userspace program to hang
> > indefinitely. Since a lot of settings are per core that's problematic
> > and since it does not help much most TDP programs dont offer it
> > anymore.
>
> This sounds like a kernel bug if you're hanging programs when trying to
> write to sysfs files of offlined cores.  If we can get that fixed having
> that in your toolbelt is quite useful.  I'm sure there are plenty of
> games that don't really need all the cores up and you can save some power.
>
> Can you get a simple reproducer for me into a bug report to look at next
> year?

I will try to. This was relayed to me. Disabling SMT also causes a
crash on the Ally when going to sleep.

> >
> >> * change DPM setting in the GPU driver (power_dpm_force_performance_level)
> >
> > I think we played with this mostly to try to get lower than 800mhz.
> > However, going lower than 800mhz in these APUs causes issues.
> >
> >> All the core related knobs can be changed on a per-core basis.  So for
> >> example even on a non-heterogeneous design you could potentially make it
> >> perform "like" a hetero design where you set it so that some cores don't
> >> go above nominal frequency or the EPP value is tuned less aggressively
> >> on some cores.
> >
> >> These knobs can have just as drastic of a result on battery life as
> >> adjusting the various power limiting knobs.  Most importantly these
> >> knobs have architectural limits that you won't be able to override so
> >> you can safely change them to min/max and see what happens.
> >
> > I feel like we are discussing different targets here. When it comes to
> > computing tasks, you have a certain block of work that needs to be
> > done and after that the CPU is free. In this case, programs like tuned
> > (allegedly) optimize these settings so that they take the minimum
> > amount of power to complete that block of work.
> >
> > However, games are different. Games have no problem burning power if
> > you let them and they are also playable at a variety of power levels.
> > Typically, unless the user caps the framerate and video quality of the
> > game it will use the full slow temp limit value. Even if they do set
> > that, the game will typically burn 3-4W more than what is needed
> > depending on TDP, EPP etc.
>
> Part of what I'm wondering is if our 4 levels of EPP values "aren't
> enough" for optimization on a per game basis.
>
> IMO They're incredibly rigid.  I do have a patch that can expose "raw"
> numbers for amd-pstate like intel-pstate does, but I haven't brought it
> on the lists yet because I'm still discussing it with others internal to
> AMD.
>
> EPP is really about responsiveness in games.

EPP performance is so detrimental we hide it. It destroys performance
by sucking power from the GPU. EPP balance_performance is only useful
in certain emulators that need a lot of CPU. Only balance_power is
useful. Then, for TDPs lower than 10, setting EPP to power milks
another 1-2W

> >
> > Therefore, the question we ask users is how loud do you want your
> > device to be and how long (in hours) do you want the battery to last.
> > This is done by ppt + the other settings, which are set automatically
> > based on ppt.
> >
> > Then the users can compromise with what fidelity and fps they get
> > based on their TDP.
> >
> >> I feel like specifically if you keep EPP at balance_performance, keep
> >> scaling_min_freq at lowest non linear frequency and change
> >> scaling_max_freq on a few of the cores you should be able to influence
> >> the battery life quite a bit while still keeping the system responsive.
> >
> > The sweet spot on these APUs is max freq to be nominal (i.e., no
> > boost), EPP at balance_power or power for very low tdps, and min_freq
> > to be 0. Especially for min_freq, setting it to lowest non-linear
> > seems to have no effect.
>
> Min freq can't go to 0, but maybe you mean the unitless perf value of 0,
> right?
>
> There is a pretty big current swing you'll have going from perf 0 vs the
> swing you get from lowest nonlinear perf.  It might not be visually
> noticeable, but I think it would be good to characterize how many joules
> are used for a given predictable gaming "workload" to decide what to do.

I set min_freq for the CPUs to the minimum one which maybe you are
right it is 400mhz. When it comes to games, 1.4GHz (nonlinear) vs
400mhz does not make much of a difference.

Antheas

