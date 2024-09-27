Return-Path: <linux-acpi+bounces-8452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9181B987D6C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 06:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36D61C2194A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A255C15383A;
	Fri, 27 Sep 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ55A7/M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C61BC5C;
	Fri, 27 Sep 2024 04:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409694; cv=none; b=Y3PvtgSZsrk0j2zZEYEm4CwIw84+j7z6uvtpPnAxH5dStcwZTp7T34OGX7OkCZISNjqOBQ3od8DV94fHLxzAAYJpgyH4SkW7wm4HaIAC2nbPKr92YWaf1uWqnHxePEQCJtYfZq2yqpavM17ghLn5xN7mcdEhoF85HOy5cNUsxyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409694; c=relaxed/simple;
	bh=OuwGjPs/0GDD3zQ5oI1PNZjx040lrl2Tct1/Dwm8PYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktRI0qGcd8++Bf9oNXyGT40B2+baFd5+EKSzTl8zwPp9zckJ4es3fH7GRoR6qP95e2sZcuvutTj4bVevBcIf8XdsLxusYVeex112iM/E+BwLugodCycbPmzEVI4S7EnUZIyxsJIr658cayxACKN0g8SEsjvwJGdRIlk2ijT5kzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ55A7/M; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e24a2bc0827so1681963276.2;
        Thu, 26 Sep 2024 21:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727409692; x=1728014492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=si9NU6+TS92BTK0S+6BoVB1/3cDqujzSjrtcQVM8mWY=;
        b=FZ55A7/M0fvag2VRIfsLHXEVV44CCAYUJrR8cPHBtTL6JF88T+5f84E6NRjSy+KYoY
         UpZmkx3ZTV4EU6YgpfeL9FuYCjYo50h38Z61J3N7Ul5Eg+7fI9Ol4quu5+3jK+E0u8BS
         ikkgkM9L1GlN5c2G7r425EObJwsLysa1Ux9EtRn8kkFOYVfSPi+0J8jJBuZY5NDyus59
         uUU1nAj0WLd8X6wxk9w1REnhENenX4f7CF8UJgLGAXkW6xvKmc6xRlQrMqrMN2fVpxE/
         2VGxCt663OdwM+VloJnjXeUUIVP2RQLOG5GOkYfoOhLDjCjJpOBKBin3GARjinmwn55E
         gmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727409692; x=1728014492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si9NU6+TS92BTK0S+6BoVB1/3cDqujzSjrtcQVM8mWY=;
        b=CTMF/nO0snSFbYccRYycGGZnlgT0KQtq9XjegzKcyvCd1ZSCpS7x5z6CtoRO6p2lbS
         X0LONhOZZMQ4S+xygjuQg+RA8HTXZMfui6VY8wS2f0eYWNLpMRaUM+IrMFIpeu6G4UOj
         +Fuj1xZraWl6ZCcAGged2NS7RDA65zWpjsujN3Zz9bVgUplUWp3nsggrSSIKbtczWiQK
         wmKX8qKVGFOg/V7ceJUR6oc3H9j/HsPQ0XCSwPSOBwn6+EL0ED2zekEcRnZThfmzFFyA
         ulALqWIbFYv1xAG4Mk+iz3cuz9UM35xgIK/tD1YDDqqsCHH3AWG+oQFzbuRNmoIFjHWF
         K7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlDY7W+3QEJT9USro7qr0mjk8L77wAoBlPLDD2g7PNxO1GAPT8al0yVer0poaTUqAZCCsL2ekCuQgwci/8dKGc1NWRw==@vger.kernel.org, AJvYcCWsgy36QV/Bj5FXwOz2iGFSW/4QC9185XMduuVFxcd0VVnLctJueVOhqphTQHOjuSUmaFyv4jlaF/ttGyFt@vger.kernel.org, AJvYcCXqNufQ6kafKL6Kqk8SIeWamc539gZux76MshgWoebMENZqeylKfDqlHKRK1sCxHvZiLc2C67xPLbLm@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6Gbshp/SL5sX4UoDWWCk6PpEmdaclD8+MK0XviNzCYQWgNjO
	w8yV2bfXOzRcxa1m9bUvCdMp3gYONfmbJKbV2laXP9kD5SrK+N+pIojos3TQoXdk8YUKV7/VQ6J
	Pgd68Tl+H+HscS/JpFB780Y3kkUs=
X-Google-Smtp-Source: AGHT+IGGYdHguIIvNcmndNmNv7SGpBbSVaqzaIER1HlDyuB1+UtqBvkcaa6eJX0t7Dulfh5X1cWbx0Ct8w2XJ4wTwno=
X-Received: by 2002:a05:6902:150d:b0:e25:cf54:65d5 with SMTP id
 3f1490d57ef6-e2604b280d0mr1357366276.12.1727409691471; Thu, 26 Sep 2024
 21:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926025955.1728766-1-superm1@kernel.org> <20240926025955.1728766-3-superm1@kernel.org>
 <CAGwozwGXh1RV96hvSEd3HQoKGY+DeRPrhcKMxJUu7STRZURsmg@mail.gmail.com> <a7b94f15-114f-4088-9920-8cef790fc354@kernel.org>
In-Reply-To: <a7b94f15-114f-4088-9920-8cef790fc354@kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 26 Sep 2024 21:01:20 -0700
Message-ID: <CAFqHKTk8U1DoMjeZFYhm_abQ7mxWd6e6Phbm9kGCHPJHfOteHw@mail.gmail.com>
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Mario Limonciello <superm1@kernel.org>
Cc: Antheas Kapenekakis <lkml@antheas.dev>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, me@kylegospodneti.ch, 
	Denis Benato <benato.denis96@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

Hello all,

>>> I appreciate the proposal, but giving users this control seems similar
>>> to using tools like Ryzenadj or Ryzen Master, which are primarily for
>>> overclocking. Atleast Ryzen Master has a dedicated mailbox with PMFW.

> In the laptop market I agree with you. However, in the handheld
> market, users expect to be able to lower the power envelope of the
> device on demand in a granular fashion. As the battery drop is
> measured in Watts, tying a slider to Watts is a natural solution.
>
> Most of the time, when those controls are used it is to limit the
> thermal envelope of the device, not exceed it. We want to remove the
> use of these tools and allow manufacturers the ability to customise
> the power envelope they offer to users.

I agree with Mario here. Due to the use case and battery size, handheld users
intent is to minimize power draw while maintaining performance. The typical use
case in "per-watt" control is to manage this. It is usually done
per-game (either
manually by the user or recalled with userspace tools). We have found that the
'performance' profile alone won't always limit the power enough, which decreases
the playtime, and 'balanced' will limit it too much, decreasing performance.
Users want to be able to tune a "sweet spot" to get maximal performance from
both metrics.

>>> While some existing PMF mailboxes are being deprecated, and SPL has
>>> been removed starting with Strix[1] due to the APTS method.

>Hmm, what do you think about about offering a wrapper for this for
>people to manipulate?

>>> It's important to use some settings together rather than individually
>>> (which the users might not be aware of). For instance, updating SPL
>>> requires corresponding updates to STT limits to avoid negative outcomes.

>The tough part about striking the balance here is how would an end user
>know what values to set in tandem.  I think a lot of people just assume
>they can "just change SPL" and that's it and have a good experience.

I'm unsure of the generalized case here, but if we are using this to limit SPL
rather than raise it over design spec, then it would seem to me that STT would
be set to match or exceed SPL and the cooling solution would be able to
compensate for that. I'm happy to be corrected here if this is not a correct
assumption. I think there may be some variation on how manufacturers implement
this in the BIOS. For example, the Legion Go uses STT to push TDP to the
thermal limit (between SPL and SPPT) when using the ACPI profiles. Their
"custom" profile changes the behavior to fully respect the user set SPL/SPPT/
FPPT. I'm not sure if/how others handle this differently. In any case,
I would expect
the driver could handle this.

>> This suggestion was referring to a combined slider, much like the
>> suggestion below. So STT limits would be modified in tandem,
>> respecting manufacturer profiles. See comments below.
>>
>> If you find the name SPL disagreeable, it could be named {tdp,
>> tdp_min, tdp_max}. This is the solution used by Valve on the Steam
>> Deck (power1_cap{+min,max}, power2_cap{+min,max}).

>It's not so much that it's disagreeable term but Shyam is pointing out
>that SPL is no longer a valid argument to the platform mailbox.

I think intuitive generic terms would be ideal. [ppt|sppt|fppt]_limit[_min|_max]
are well understood by power users currently. There should be some
terminology that applies generally across different implementations of similar
concepts.

>> In addition, boost is seen as detrimental to handheld devices, with
>> most users disliking and disabling it. Steam Deck does not use boost.
>> It is disabled by Steam (power1_cap == power2_cap). So STT and STAPM
>> are not very relevant. In addition, Steam Deck van gogh has a more
>> linear response so TDP limits are less required.

I find this to be case by case, some games have more sudden/dynamic loads and
need the extra overhead, while others will waste it. Flexibility is important I
think. The Deck also benefits from scale and Steam integration right now so
publishers are able to, and do, tune for that device specifically. I don't know
how far the lessons from that device transfer to other handhelds. Having them
as an option, even if unused, would be a benefit.

>>> Additionally, altering these parameters can exceed thermal limits and
>>> potentially void warranties.
>>>
>>> Considering CnQF, why not let OEMs opt-in and allow the algorithm to
>>> manage power budgets, rather than providing these controls to users
>>> from the kernel when userspace tools already exist?

>The problem is all of the RE tools rely upon PCI config space access or
>/dev/mem access to manipulate undocumented register offsets.
>
>When the system is under kernel lockdown (such as with distro kernel
>when UEFI secure boot is turned on) then those interfaces are
>intentionally locked down.
>
>That's why I'm hoping we can strike some sort of balance at the request
>for some advanced users being able to tune values in a predictable
>fashion while also allowing OEMs to configure policies like CNQF or
>Smart PC when users for users that don't tinker.

>>> Please note that on systems with Smart PC enabled, if users manually
>>> adjust the system thermals, it can lead to the thermal controls
>>> becoming unmanageable.

>Yeah; that's why as this RFC patch I didn't let CNQF, ITS or Smart PC
>initialize.  Basically if manual control is enabled then "SPS" and
>manual sysfs control is the only thing available.

>> Much like you, we dislike AutoTDP solutions that use e.g., RyzenAdj, as they:
>>   1) Do not respect manufacturer limits
>>   2) Cause system instability such as stutters when setting values
>>   3) Can cause crashes if they access the mailbox at the same time as
>> the AMD drm driver.

>Yes.  Exactly why I feel that if we offer an interface instead people
>can use such an interface instead of these tools.

The general consensus on the userspace development side is that we'd like to
move away from needing to do these hacks to get the most from the hardware. I
would say things like RyzenAdj, ryzen_smu, acpi_call, etc. have provided enough
evidence that there is a gap in the baseline functionality that will ultimately
be filled *somehow*. I'd like to see a move towards this as an acceptable
in-kernel standard to replace those tools. In that same vein I think it's
important that common sense defaults and manufacturers intent are respected. I
have some ideas for how that could be done. If information is not
available for a
given device then the "custom" parameter will not be available in
power_profile_available and attempts to set to it will -EINVAL.
Similarly, have PPT
attrs only show in sysfs if that data is available.

- For legacy devices (and likely many smaller "boutique" manufacturers for the
  foreseeable future) a DMI table with limits for each supported attribute
  could provide this. Limiting this table to handhelds specifically would be
  acceptable to me, I don't see the value for laptops personally. For almost
  everything on the market currently we have this data, provided by the OEM.
- For devices with WMI (Legion Go, ROG Ally) the manufacturer has provided the
  methods to get these limits directly, so that could be handled in the
  appropriate manufacturer WMI drivers.
- For future devices this information should be (is?) included in the
  PMF tables in the BIOS and enabled automatically when detected by the driver,
  which will hopefully reduce the number of necessary kernel patches going
  forward.

