Return-Path: <linux-acpi+bounces-19430-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D65CA4F2F
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 19:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0854C30734C4
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74140338914;
	Thu,  4 Dec 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="NgOD5a4t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665930E0FA
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764873096; cv=none; b=og1fkA9aBP/tvLyWvclLF9X/FtOK7f17ELczwuD8redlG5jcGssFzLuG6geFduIChJW1bvsLUdApihBlD4YhgUAcDZq7BNHKco04UTAb1LY+lMDkB8iLHeqCFwXhChWaZsof5QEoy+ZKYT+I3Hmx3/PRTTuTA69VJrMZVeARkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764873096; c=relaxed/simple;
	bh=r30QPIs8tKhiboKF8ED9Q+RmAZE2qhYuJF0nI9oTTjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMmDGGtmw3SvgWF2WfjQoh/RzClE7tgtAx7ENQpUZpPrad6O6LovPxw7HqIFqIwnMGiyZoRZALflmNixwHLCR92nWouczA0Xr7QLdJl4iL5pjYm10nyKzM61H/W+S0Wb9EThAm2K20ZrrDoHs5taCrosJMoSTcxJT0hg3roKbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=NgOD5a4t; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 34985BDC8D
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 20:31:25 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 85A4EBCF33
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 20:31:23 +0200 (EET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A4EF92022E5
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 20:31:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764873083;
	bh=FHiHwiLxwOb9j5Wi+pl4o2MSMFSQ+mcxbMHgyk30u9o=;
	h=Received:From:Subject:To;
	b=NgOD5a4tTpDIWEMrp4xPiSWb527JONd3Q5n+6K7J1ShvQKxAgZeksbXcq+hsSVJJZ
	 YClt//gBNPeUp0rpztVz5GX+qiRN6CYMvKbdoZszGi4xAzJSYXTewHFGRW4eYgD/RH
	 YcEhRvIoMgDhzwYmcrP0vSzv1m2vRlhnp4nbpWl4KKObkc/7l8ZeisUNl7l56BfCYv
	 6/LRuxs2Mkb4n0oHu3D7iTbQw38+pu8OROzwQ6mfRlWKzHInCgKxkHoLMCDnfRuFvE
	 FKGKvjCJMCG+IH/18PKd6qhW+WHc5L7SiqD415r97idPBw1jCOnkPjpMzcACNNeiJ3
	 4SKwiXBHeg4bQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.52) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f52.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-5957d7e0bf3so2297826e87.0
        for <linux-acpi@vger.kernel.org>;
 Thu, 04 Dec 2025 10:31:22 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX7fnlOqFQoqwHIY6Tbs0h2hW2dL8kj5dSRRr2T5hYOmYK3W4ONCDKMfvXaS1vMTv7FdaTmEfS/GxJr@vger.kernel.org
X-Gm-Message-State: AOJu0YySbfvGsHvPIiQm0EK2W7amgRD138nR3WOwISbuHKSWU0O/RZTs
	AzoheRr4icXSLbkKLV8sUa+EGgTyTkIebD/oNFiLTjG8K3xNgvuT9Z8x5ocBiC+GPeFrgNWsBte
	g+CchIzmecXtBRUameSItxHc5ggrAs1A=
X-Google-Smtp-Source: 
 AGHT+IFyR548xUd2P5NQkOvaghnErSWbFKeS/zR3T8GWdCK13YFKiM5xCG/7x8W6MQInskHSHJD+tQ/0wWtIR8gbStc=
X-Received: by 2002:a05:651c:556:b0:37e:6a62:1279 with SMTP id
 38308e7fff4ca-37e6cca2ec3mr12885811fa.10.1764873081998; Thu, 04 Dec 2025
 10:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 4 Dec 2025 19:31:09 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
X-Gm-Features: AWmQ_blodRDtsShlcOFVzKWV9YX567OzWF6OqSsPoQbeReKPoHvSBf-ChpyLBkc
Message-ID: 
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Mario Limonciello <superm1@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <176487308298.2185810.17933575466911828244@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 4 Dec 2025 at 17:41, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Dec 4, 2025 at 4:04=E2=80=AFPM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> >
> > On 12/3/25 17:58, Rafael J. Wysocki wrote:
> > >> Add `/sys/power/lps0_screen_off` interface to allow userspace to con=
trol
> > >> Display OFF/ON DSM notifications at runtime.
> > > Why?
> > >
> > >> Writing "1" to this file triggers the OFF notification, and "0" trig=
gers the ON notification.
> > >>
> > >> Userspace should write "1" after turning off all physical and remote
> > >> displays. It should write "0" before turning on any of displays.
> > > This sets a limitation on the correct/expected usage of this
> > > interface.  How can the kernel ensure that the limitation is taken
> > > into account?  In principle, it should not allow OFF to be triggered
> > > if any displays are "on", for example.
> > >
> > > And what exactly do you mean by "turning off a display".  Cutting
> > > power from it or something else?
> >
> > The common lowest level denominator for the "turned off display" should
> > be that all display CRTCs are disabled and there are no active remote
> > desktop sessions.
> >
> > For example, firmware of Intel laptops tracks state of a built-in
> > display internally and treats display being tuned off when either
> > display's CRTC is disabled or when backlight level is set to 0. This ma=
y
> > be not the same for AMD firmware.
> >
> > Display On/Off notification is a hint to firmware that it's allowed to
> > put machine into a lower power state where UI presented to a user may
> > become non-interactive.

Jumping in for some more context

The display on/off notifications do not put the hw into a low power
state. It purely affects the presentation of the device. Specifically,
the keyboard backlight/RGB, and for some devices the power button
light/built-in controller for handhelds.

Although devices that pulse the power button light due to it are very
limited. In particular, I think it is Lenovo only. I have not run into
another manufacturer that uses it. Specifically, their consumer
revision. I would have to retest my thinkpad.

Most manufacturers hook into the sleep DSMs for the power button or,
e.g. Asus, with the LPS0 _DSMs.

If you think about it, it makes sense. Turning off the display does
not mean the device is not doing intensive work, such as rendering a
video. So CPU/GPU/power envelope are unaffected and that's true for
the ~7 manufacturers I tested.

A lot of manufacturers do limit the power envelope as a response to
the sleep _DSMs. Specifically, this is true for both Lenovo and Asus
consumer divisions. For a device such as the Go S, it also completely
turns off the fan. Typical power envelope is ~7W for this. This is
also why there is a _DSM for speeding up resume and why I had a faux
resume state in my series.

>
> To be precise, that's what MSDN has to say about it:
>
> "This _DSM Function will be invoked when the operating system has
> entered a state where all displays=E2=80=94local and remote, if any=E2=80=
=94have been
> turned off. This could occur based on some user action, e.g. a button
> press or lid close event, or expiration of some display power down
> timer."
>
> The "Intel Low-power S0 Idle" specification
> (https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_I=
dle.pdf)
> says almost the same thing.
>
> None of them says what kind of hint this is to the firmware and what
> the firmware is expected to do in response to it.

It is true that online documentation does not list the firmware
response. There is additional documentation that lists the exact entry
conditions for display on/off [1]

Specifically, while it is a prerequisite of the CRTCs, local/remote,
being turned off, the actual condition mirrors when userspace would
present a lockscreen to the user. I.e., if it is due to inactivity,
those notifications fire 5 seconds after displays turn off, and if it
is due to explicit action, e.g., power button, it is instant.

"However, the system continues to run and all applications continue to
operate normally as if the display was powered on." also implies that
no hw is powered off as part of this notification.

[1] https://learn.microsoft.com/en-us/windows-hardware/design/device-experi=
ences/display--sleep--and-hibernate-idle-timers

> > In practice, entering this lower power state makes device to pretend
> > that it has been suspended. On a laptop, keyboard backlight will be
> > turned off and power button LED will start blinking. This allows us to
> > implement the "resume to a dark mode", mentioned in the cover letter.
>
> Maybe, depending on what the firmware actually does.
>
> > It's up to userspace to make decision when and what DSM notification
> > should be issued, thus the new sysfs control.
>
> Why would it be up to user space?
>
> > There is no strict requirement on having displays to be turned off when
> > Display OFF notification is issued. Machine won't blow up when display
> > is enabled and OFF notification is set. Hence, it should be unnecessary
> > for kernel to be extra cautious RE trusting userspace.
>
> That is until one of them actually blows up when that happens.
>
> As it stands, I'm totally unconvinced.
>
> I generally think that allowing user space to trigger evaluation of
> AML via sysfs is risky, pretty much regardless of what the given AML
> has been designed for.  Turning that into kernel ABI is asking for
> trouble.

I would tentatively agree, specifically in the way this series/ABI is
phrased. My suggestion would be a more generalizable ABI that is not
x86/ms specific. This way it can be bounded as appropriate to be safe
and then expanded to other devices/drivers, including those that do
not have an accompanying modern standby implementation.

The risks for this are a bit overblown. A proper userspace
implementation would always ensure that the displays have turned off,
so in the case a niche device malfunctions with a display off
notification and an enabled CRTC would leave ample time for the 2-3
DRM patches required to block it on the kernel side to be merged.

Moreover, I have personally tested these DSMs on around ~9 devices by
~7 manufacturers, and we have been shipping a modified version of the
series I sent in 2024 to around 200k users. That series pulls the
notification firing above the place where DRM suspends the CRTCs and
there haven't been any issues due to it.

> Now, AFAIK this particular _DSM interface has been designed to be part
> of the "modern standby" (or equivalent) flows, not to be used
> separately, so assuming that it will always work the way you think it
> will when used separately is kind of walking on thin ice IMV.

In Windows, the modern standby flow is implemented in userspace as a
coalescing function of different programs through their power manager
and exposed to hardware through three notifications (DIsplay On/Off,
Sleep, LPS0)[2]. My current understanding is that when it comes to the
Linux desktop, it is also the responsibility of userspace to handle
these different states, so for userspace to be able to implement this,
it would need an ABI to configure the device into a similar state.

What would be the way forward for this? I do not think it is realistic
to defer implementing these features because they are only supposed to
work with Windows.

[2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experi=
ences/modern-standby-firmware-notifications

> And there is also a concern regarding all of the systems where this
> firmware interface is not present or not supported that will not get
> the "dark resume" experience associated with it.  If you want "dark
> resume" to be a feature of Linux, it should not depend on whether or
> not a particular firmware is there and actually works the way you
> like.
>

There are two implications here: 1) all hardware should support a
"dark resume" feature, 2) this feature should not be locked behind a
specific firmware/UEFI implementation.

First one is not true. Legacy hardware that is not built with the
ability to wake up periodically without turning on its fan, backlight,
power light and with a reduced power envelope will never get the full
benefit of such a feature set.

Second one is tenable with a proper ABI that can be implemented also
through e.g., EC platform drivers. In addition, pretty much all
laptops post ~2021 support a subset or all of these DSMs and S3
support has been retired, when it comes to AMD since the ~7000 series
APUs. This is not to say that all of it will work equally well though.

Antheas


