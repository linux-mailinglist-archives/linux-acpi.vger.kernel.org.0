Return-Path: <linux-acpi+bounces-8453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B84C9880A2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432552816F4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 08:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33E189B95;
	Fri, 27 Sep 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Gv2cb+c5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBA17A597;
	Fri, 27 Sep 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727426666; cv=none; b=K6EMfPdM78QGM8J7Md6lhWGJGtvKqvL36dZHim6j82z8QlfpNzeFw6NrpEAbzQke6r5Ku6DTMGfM19piwd3K3Jv3VMvO53KFBbazczEEssvbTjB0CYyNmTe+uBp1vxKdvfxzc6rN/oZrrrrdcLyPH5/lJYi9v4als5ybzb9m3v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727426666; c=relaxed/simple;
	bh=kKsjcny6CMU5KzLuhtV3n2+I/I360GXhY9cHff1RWmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxakZIqCItgf28Zikf67Xs82ROmY55pZHbDL1zjYBUFWtme6GbfFoIcEu35fOoIixMxH6ZV4ERb/ACnriGzJTfHBxmlKMtgnJddFilK16VhUp3WhimDqXCWmrI0EZddEd6M0s57uq7v5W7zxn0NTY0phqVrOaUo+2QpycxVwyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Gv2cb+c5; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 128212E07D9D;
	Fri, 27 Sep 2024 11:44:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1727426653;
	bh=69T7zfnP6GOZKoL/6mQso2td37BvgkbgXKOcJVYhRT8=;
	h=Received:From:Subject:To;
	b=Gv2cb+c5VI3XYF27iGSj0xdYum9gvuJ0UQdS6NNpc/QW6p+OCVzDFK2rDT1LtzpEw
	 4qrP2678tnqVwSrhQA/FeCSiBvfnfUQ8yFzVFPjUod4zSDWiHEB0kDFrI3p/FxGU3k
	 r4dnhd2J3P4Szu16nIDRvTNemevRfPt0guWT1cRQ=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-2f77fe7ccc4so21934561fa.2;
        Fri, 27 Sep 2024 01:44:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUagLfZJPY1aSbTuiqrhitneE9ZIUQKk1WZLw5e/j/Ut4E/yXtKXWGY5TBDAEHmh6XygeAmdTyOTVseTK45XEFT1DqAOg==@vger.kernel.org,
 AJvYcCVN6gNaSl3JmPpmJs3gLlW+BAxa0Vn4MFa5ILvrz78Ky3F+OeyoN7/IQjkkk6s1Fj/4BJ/8+FYAhF56@vger.kernel.org,
 AJvYcCX0bjRGDlv0rz8gtp2VtB4UmzsNBXm/lm9+r5PY9zD20Cb+7u5dmLp34HEMFZVtFfDx8mPlmWudYIlX8yrN@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tccr20AIDzDV5KNmF2JsPpjm7DzwTOZlJ2Mjmfn9G7M4ugvI
	MZebq4bS/DjEHREwjWe5DzvGpXAYAv9xew8Rl9GSQj8RoKCexAhmX+quL2Fwp6xLMHX8GqHH4+q
	i0SlSwcz/d/XsO3n0qSssAURlPUc=
X-Google-Smtp-Source: 
 AGHT+IEjhKd9cNPkRjJbIs7s1Z/U/c86xn99AMdNQt4YFu0A6Ntw5ezEX0R32Zpgs2vWsM6HDgMWlIOo0NcZ/91UreQ=
X-Received: by 2002:a2e:bc17:0:b0:2f6:649e:bf70 with SMTP id
 38308e7fff4ca-2f9d3e6a97cmr16023961fa.26.1727426652178; Fri, 27 Sep 2024
 01:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <5a75b73f-dcb1-4a45-9526-194a3451b5c6@amd.com>
 <CAGwozwGtqwOOfrUpjLghW4JCKqcFk9ut-X0MBvHAm37YVS51tw@mail.gmail.com>
 <f516dd07-7d7b-403e-a55e-6bf21dbea9b4@kernel.org>
In-Reply-To: <f516dd07-7d7b-403e-a55e-6bf21dbea9b4@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 27 Sep 2024 10:44:00 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEvLUbqUGBvHh18tSb7nh9ttKQFxXG-LcQ+W80WSdktgA@mail.gmail.com>
Message-ID: 
 <CAGwozwEvLUbqUGBvHh18tSb7nh9ttKQFxXG-LcQ+W80WSdktgA@mail.gmail.com>
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
 <172742665355.30615.13341340152223826272@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Mario,

On Thu, 26 Sept 2024 at 20:09, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 9/26/2024 06:00, Antheas Kapenekakis wrote:
> > Hi Shyam,
> >
> >> I appreciate the proposal, but giving users this control seems similar
> >> to using tools like Ryzenadj or Ryzen Master, which are primarily for
> >> overclocking. Atleast Ryzen Master has a dedicated mailbox with PMFW.
> >
> > In the laptop market I agree with you. However, in the handheld
> > market, users expect to be able to lower the power envelope of the
> > device on demand in a granular fashion. As the battery drop is
> > measured in Watts, tying a slider to Watts is a natural solution.
> >
> > Most of the time, when those controls are used it is to limit the
> > thermal envelope of the device, not exceed it. We want to remove the
> > use of these tools and allow manufacturers the ability to customise
> > the power envelope they offer to users.
> >
> >> While some existing PMF mailboxes are being deprecated, and SPL has
> >> been removed starting with Strix[1] due to the APTS method.
>
> Hmm, what do you think about about offering a wrapper for this for
> people to manipulate?

Having a single call that sets everything would be my preference, so I
would support this.

Although looking at [1], seems like it will be separate calls anway.

Link: https://github.com/torvalds/linux/blob/master/drivers/platform/x86/amd/pmf/sps.c#L193
[1]

> >> It's important to use some settings together rather than individually
> >> (which the users might not be aware of). For instance, updating SPL
> >> requires corresponding updates to STT limits to avoid negative outcomes.
> >
>
> The tough part about striking the balance here is how would an end user
> know what values to set in tandem.  I think a lot of people just assume
> they can "just change SPL" and that's it and have a good experience.

Spoken like a true linux user. Users do not know what a kernel or
sysfs is and they will not be touching any of this. It just needs to
be baby-proofed enough so for the 5 users that do it is safe.

Let us focus on the problem here. There are currently around 5
manufacturers shipping products in a space where granular TDP control
is expected and where AMD has not provided them with a solution.

And for this, there are two issues. First, there is no standard for
granular TDP control tuned by the manufacturer. Second, when such a
standard is created, there is a healthy pool of devices in the market
where the manufacturer cannot be expected to provide an updated BIOS
for them.
Therefore, we need a proposal where 1) the manufacturer can provide
granular TDP controls in a fully customizable manner (e.g., with a LUT
that controls everything), and 2) for devices that will not get that
tuning, a custom profile setting that will expose important tuning
parameters to userspace so that we can retrofit it and extend the
their lifespan.

> > This suggestion was referring to a combined slider, much like the
> > suggestion below. So STT limits would be modified in tandem,
> > respecting manufacturer profiles. See comments below.
> >
> > If you find the name SPL disagreeable, it could be named {tdp,
> > tdp_min, tdp_max}. This is the solution used by Valve on the Steam
> > Deck (power1_cap{+min,max}, power2_cap{+min,max}).
>
> It's not so much that it's disagreeable term but Shyam is pointing out
> that SPL is no longer a valid argument to the platform mailbox.

I'd tend to agree since the current mailbox targets that I know of are
STAPM limit (for STAPM) and skin temp limit (for STT). Since you used
the term SPL, I carried that over to the proposal, but it would not
control SPL. Instead it would control both of the former, including
sPPT and fPPT (if that is still supported; unclear in [1]; but
disabling boost will be a requirement).

> >
> > In addition, boost is seen as detrimental to handheld devices, with
> > most users disliking and disabling it. Steam Deck does not use boost.
> > It is disabled by Steam (power1_cap == power2_cap). So STT and STAPM
> > are not very relevant. In addition, Steam Deck van gogh has a more
> > linear response so TDP limits are less required.
> >
> >> Additionally, altering these parameters can exceed thermal limits and
> >> potentially void warranties.
> >>
> >> Considering CnQF, why not let OEMs opt-in and allow the algorithm to
> >> manage power budgets, rather than providing these controls to users
> >> from the kernel when userspace tools already exist?
>
> The problem is all of the RE tools rely upon PCI config space access or
> /dev/mem access to manipulate undocumented register offsets.
>
> When the system is under kernel lockdown (such as with distro kernel
> when UEFI secure boot is turned on) then those interfaces are
> intentionally locked down.
>
> That's why I'm hoping we can strike some sort of balance at the request
> for some advanced users being able to tune values in a predictable
> fashion while also allowing OEMs to configure policies like CNQF or
> Smart PC when users for users that don't tinker.

I will have to repeat that as far as the handheld market is concerned,
we are not talking about advanced users. Instead, we are talking for
all users.

> >>
> >> Please note that on systems with Smart PC enabled, if users manually
> >> adjust the system thermals, it can lead to the thermal controls
> >> becoming unmanageable.
>
> Yeah; that's why as this RFC patch I didn't let CNQF, ITS or Smart PC
> initialize.  Basically if manual control is enabled then "SPS" and
> manual sysfs control is the only thing available.

Sounds like you have your work cut out for you if the custom profile
is supposed to dynamically load.

> >
> > Much like you, we dislike AutoTDP solutions that use e.g., RyzenAdj, as they:
> >   1) Do not respect manufacturer limits
> >   2) Cause system instability such as stutters when setting values
> >   3) Can cause crashes if they access the mailbox at the same time as
> > the AMD drm driver.
> >
>
> Yes.  Exactly why I feel that if we offer an interface instead people
> can use such an interface instead of these tools.

While (in Bazzite) we have a solution that works very reliably and is
safe (not RyzenAdj), we have to begin cleaning up loose ends so that
we can 1) enable TDP control in a stock secureboot kernel with early
lockdown enabled (e.g., Fedora), 2) provide manufacturers with certain
reliability guarantees so they can warranty units running under linux,
3) prepare our solutions for being packaged in upstream distribution
repositories (Debian, Fedora), where using an existing solution is a
blocker as they do not provide or should provide such hardware access
when secure boot is enabled.

Though, since manufacturers like Ayaneo currently use RyzenAdj in
Windows, I might be nitpicking too much.

As for why Secure Boot is important, let add [2], where Rockstar
points the finger to Valve for BattlEye not working. Much of the
anticheat issue is due to the fact that it is trivial to cheat without
having a secureboot enabled kernel with the early lockdown flag
engaged, as it allows both custom drivers and userspace to gain access
to sensitive process memory in a way that is undetectable by
anticheat. Vanguard does not work in Linux for much of the same
reason.

Steam Deck is, for those uninitiated, a device that does not carry
Secureboot keys, and SteamOS is a distribution that does not support
Secure boot. Although both can change (Steam Deck BIOS supports secure
boot). However, Bazzite is secure boot enabled and we encourage our
users to leave it enabled, although for the moment they have to enroll
our MOK key, which most of them do.

Antheas

Link: https://www.pcgamer.com/games/grand-theft-auto/gta-online-is-no-longer-compatible-with-steam-deck-thanks-to-its-new-anti-cheat-software-despite-battleye-having-an-opt-in-system-for-this-sort-of-thing/
[2]

