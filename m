Return-Path: <linux-acpi+bounces-19476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D32CAB3C4
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00A6730402E3
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504D2367D5;
	Sun,  7 Dec 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erBHnkGs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F320C1E832A
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765105627; cv=none; b=bkewUrzlWkcyB5bXpa8fLGtctTHG8p6Y4fWLZQi1GeejIaxHUAiuMqva2cFpFoOMtvETfJSMl7nGoB/K69aB5mzwoI5RxK0DFgLop299LyWZbXFl1Yv7ui7RtDh+HbkMvgi45+xZBEI0aeghm5My2z3guefH7EU9TpXoaVPqphU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765105627; c=relaxed/simple;
	bh=75IvYYZOlmSYw80cXu2quom+DEZx4LJh1Ew7AVU9kkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfM2oRUa6uKtOHFetsulzrZbm7k3ZKcIPLX0W5n9Ccogur3bbA1dRGa9yhlercy8W2zMNsHSHxfgcgTOnpiCuZBKOLM6X/WOel8I3sbUJyGAOeFXq7ambEePYhUQBd1guCiXdDaUINQ7SL2tsC1g+9eLtFZacL+xkipiDxlQQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erBHnkGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72012C19424
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 11:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765105626;
	bh=75IvYYZOlmSYw80cXu2quom+DEZx4LJh1Ew7AVU9kkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=erBHnkGsAKzwB2PlBhAJH8eYjj97C/pnJmCsvYZhybB6by7ypUht/6lAuVRPQY89Y
	 BSt3urv8JDoDK8hKBB/RowBlmKgYNSduC/KDJNVqazDxkaaG7URQDRMSFkOYxdCOTS
	 XzJ+KWx1lNYzeHiRBpewspqjJ8sY5t2ot2rGCxvrYcJkzV/HZ0oWyvaQus97nqZKOj
	 V1ZuJPRtpGh1vDe/RsPWRV7gLUyXAg5mRBf1px12OFIAatVPKS4rslAWGbECgWAtS9
	 +PR+5f67Gfxey14u/bEgqM6T1p2L3LmwbZexEyfrdHMsq6hGLDnNzruQu3rlKLkGIh
	 mmQMITdMxPp4Q==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3eae4e590a4so1720365fac.1
        for <linux-acpi@vger.kernel.org>; Sun, 07 Dec 2025 03:07:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSKa/DcYz4gQnbuXtQ8rCyYcWhtzocT4nKCOjvmAANlihcgk8+jam55FCrsgmLETtdR617dz5zy7KB@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJhCgU2+U1k2sQtSdnLPKCAY7xSpPTBXx8K22EVRpOZXhWpUn
	DxaCcFoO+NSpCmDA3iejRanAuV/FLxseLOkqGhi0/7PMtV9AwG6+wvPiJtqO2tc9hJ4g6e54ZH/
	lGwzAkVVI5uutAw+aWUFWtpG3rbyvxM8=
X-Google-Smtp-Source: AGHT+IGpUVMOs2vICJEU2c6I4+aXguD/8TSdOIk/NeFcup/UIYb40gHW6I1+luajliEnFtl763ZmzoQAHHWvtMMCKhA=
X-Received: by 2002:a05:6820:2d0c:b0:659:9a49:8e43 with SMTP id
 006d021491bc7-6599a8c7b41mr1853216eaf.19.1765105625689; Sun, 07 Dec 2025
 03:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com> <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com> <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com> <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
In-Reply-To: <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 7 Dec 2025 12:06:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
X-Gm-Features: AQt7F2qDeWzH1vFUMAEm3D9-aoMlcZR4alseErKCbW48-he9qpa7bPQGX3k2_1M
Message-ID: <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Mario Limonciello <superm1@kernel.org>, Robert Beckett <bob.beckett@collabora.com>, 
	linux-acpi@vger.kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"

GMail did something silly to my reply to this message, so resending it
in case it didn't make it to the lists.  Sorry for duplicates.

On Fri, Dec 5, 2025 at 11:52=E2=80=AFPM Antheas Kapenekakis
<lkml@antheas.dev> wrote:
>
> On Fri, 5 Dec 2025 at 17:32, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Dec 4, 2025 at 7:31=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.dev> wrote:
> > >
> > > On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >

[cut]

> >
> > In Linux, making the system look like it is suspended even though in
> > fact it isn't may be quite confusing, as a user may think that it is
> > now safe to put a laptop in a bag, for example, but in fact it isn't.
>
> My thesis would be a proper userspace implementation running on a
> laptop with a properly configured platform, it should be safe for the
> user to put the laptop in their bag, even if it wakes up briefly
> multiple times per hour without their knowledge or being perceivable.

That's what Android phones/tablets do, but that's a vertical software stack.

To implement something like this you need (a) support from the GFX driver
in the kernel to go into system suspend back and forth without turning
displays on and off, and (b) a mechanism to trigger system suspend
automatically after a period of inactivity while in the "displays off, no
GUI activity" state, and (c) support for system wakeup events in (b).

I'm not sure what the LPS0 _DSM role is in that.

> It is also a very valid point that this is a _very fine_ line that
> Windows crossed with its userspace implementation and soured the
> perception of Modern Standby for a lot of users. Buggy platform
> firmware/insufficient tooling/control for OEMs, early on also
> contributed to this.
>
> > > >
> > > > To be precise, that's what MSDN has to say about it:
> > > >
> > > > "This _DSM Function will be invoked when the operating system has
> > > > entered a state where all displays=E2=80=94local and remote, if any==E2=80=94have been
> > > > turned off. This could occur based on some user action, e.g. a button
> > > > press or lid close event, or expiration of some display power down
> > > > timer."
> > > >
> > > > The "Intel Low-power S0 Idle" specification
> > > > (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle=.pdf)
> > > > says almost the same thing.
> > > >
> > > > None of them says what kind of hint this is to the firmware and what
> > > > the firmware is expected to do in response to it.
> > >
> > > It is true that online documentation does not list the firmware
> > > response. There is additional documentation that lists the exact entry
> > > conditions for display on/off [1]
> > >
> > > Specifically, while it is a prerequisite of the CRTCs, local/remote,
> > > being turned off, the actual condition mirrors when userspace would
> > > present a lockscreen to the user. I.e., if it is due to inactivity,
> > > those notifications fire 5 seconds after displays turn off, and if it
> > > is due to explicit action, e.g., power button, it is instant.
> > >
> > > "However, the system continues to run and all applications continue t=
o
> > > operate normally as if the display was powered on." also implies that
> > > no hw is powered off as part of this notification.
> > >
> > > [1] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/display--sleep--and-hibernate-idle-timers
> >
> > Wouldn't just turning the display off be sufficient here?  Why do you
> > want to go for platform notification in addition to it?

[cut]

> There is a tendency by Microsoft to add OEM tooling that avoids the
> need for creating platform drivers.
>
> This includes the WMI implementation which allows Windows userspace to
> talk to hardware without having a signed platform driver, and now this
> standardized set of notifications. Maintaining a signed
> vulnerability-free driver is expensive.
>
> The Display On/Off notifications provide hooks for OEMs to customize
> the inactive appearance of their device. Mostly, this is through
> turning off auxiliary lights, such as the keyboard backlight.
>
> The sleep notifications provide a way for OEMs to limit the thermal
> envelope of their machine and make it look like it is asleep, so that
> it is safe for that device to wake up multiple times per hour,
> including in a bag, without looking like it is awake.

This is based on a very optimistic assumption that generally cannot be
verified I'm afraid.

(1) User space must not do anything silly like Bitcoin mining while
this is done.
(2) The firmware must not be cheating.
(3) The GFX driver needs to be able to transition transparently
between the "displays off" graphics state and the system suspend and
resume flows.
(4) The GFX driver activity needs to be coordinated at least somewhat
with whatever user space entity would be responsible for triggering
the notifications so they do not get completely out of sync.

> Here is an example with how these DSMs would work with thinkpads.
>
> Windows does not have a Thinkpad backlight driver. There is auxiliary
> and optional software, Vantage, which provides some of this. Assume it
> is not installed. Then, in Linux, assume you disable the thinkpad
> backlight driver, so upower loses control of the thinkpad keyboard
> backlight. The thinkpad keyboard backlight is automatically controlled
> by the EC through keyboard shortcuts. So are the power modes, via Fn+L
> M H.
>
> Then, assume that Linux implements these _DSMs, and hooks them via
> systemd as following: display on/off is hooked to occur when logind
> would lock the session, i.e. after 5 seconds of inactivity or pressing
> the power button. The sleep notifications are triggered by
> systemd-sleep, before suspend-then-hibernate begins.
>
> The end result is that after the display turns off, the keyboard
> backlight of the device will also turn off automatically without a
> platform driver. This is true for all modern standby laptops at least
> post ~2021. A lot of these do not have kernel drivers in linux.
>
> Then, if the sleep state is supported (spotty in thinkpads but
> available in a lot of other hw), when the RTC Wake Alarm/battery alarm
> wakes the device and systemd briefly checks whether it should
> hibernate, it will still look like it is asleep, and it will have a
> reduced power envelope, reducing the risk of overheating if it is in a
> bag and lowering standby power consumption.
>
> I.e., without requiring vendor software, platform drivers, both
> Windows and Linux present a full feature set out of the box.

I guess it would be rather useful to start the discussion with this
proposed flow, some time might have been saved by everyone.

IIUC, the point is to make the system look "suspended" if it goes out
of suspend briefly in response to a wakeup event (the other potential
"benefits" of what the notifications can possibly do are in the domain
of marketing IMV), but is it really worth the hassle?

Assuming that the answer is "yes", which I'm not convinced about at
all, can't the kernel simply defer the "screen on" notification to
some time after thawing user space, so it can avoid doing it and the
corresponding "screen off" one if the system is suspended again
quickly enough? Perhaps so long as the GFX driver opts in?

And now we get to the most important thing: even before trying to do
the above, let alone exposing anything to user space, the existing
suspend-to-idle flow in the kernel needs to be adjusted to do the
"screen off" notification much earlier and the "screen off"
notification much later than they are done today.  I think that you
should be able to argue convincingly for making this change.

If this doesn't universally work for whatever reason, anything more
will be out of the question.

