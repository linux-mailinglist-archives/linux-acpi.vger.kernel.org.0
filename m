Return-Path: <linux-acpi+bounces-19429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CADCA4918
	for <lists+linux-acpi@lfdr.de>; Thu, 04 Dec 2025 17:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C69343005D38
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Dec 2025 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5490346E56;
	Thu,  4 Dec 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLNIRzFU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC2A1DF970
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764866507; cv=none; b=HTenSudIULzMY54uUv1yx9cR/Tw7FJUF5QFFeq0n0tZo2hR8hr51NPAY1rGPzKoj4wQJuOYOHy/hz3ePnzNV8aEPfUFe90F4ortWWWhuXExh8agk9IynYmRrxZ3JZTFXBTTaVMIZSLkE5VZStQSetbRxKtMVV35vhqEg11ji/JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764866507; c=relaxed/simple;
	bh=nv+az/vA3K1avcB/U3jaW73GjapHKyh3UYcT67zoXyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjk8jgHzgy54ZRCz3OH1ueoS3P/IY+0iT2gkiYisUcRQGtC1Wg7fQh7iCBMy5Eu+uC/VZKG4E3iNR8jmnauW9dHtNoApL/l32iVI+8djlMDQffhHRstjhYVUO6yrMrx8Lvj1Q/+5yNL2j4He3ZfvzCyt3nlhTjxYi8GQ4U9TSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLNIRzFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D4C19423
	for <linux-acpi@vger.kernel.org>; Thu,  4 Dec 2025 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764866507;
	bh=nv+az/vA3K1avcB/U3jaW73GjapHKyh3UYcT67zoXyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KLNIRzFUQaLTrLrDAhxXsb+tFIs9HfZ1TSnBbHpbXZTGpTARG1zNpOhrc1wDmXPIC
	 4NEak0Hkx89RqkRy5D/dbqum7AMWTLfDaXnRy4NDGhdmJzpjJEmL54lEBYJ9hTbOTr
	 KWL1Gi0J/ANiGQ4xrDc1jQ4HjPNITS9kggoxzys7MOUXgiAXjl1qKd3kZiQhUwRYkK
	 aufLM14gpi3aERY3VBqwWhuENkT9Td992S7iN1tYVHbt+UYD9NgFlfVnz9EsJbfncS
	 X1z8joCueD9L+wviCh5uXsYQpWQYi8jrpqXYbt/Q6TZSQlJHWmirIGYB85mGQdTI3L
	 9eVwFaXWGWLdg==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6597b877066so689709eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 04 Dec 2025 08:41:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkC79yepRIPHEi5Khb630P59dydy823ltcZXKIxMWSmticERucdPkJUl5deWg8fHSEBB4ps4pN0qg4@vger.kernel.org
X-Gm-Message-State: AOJu0YycAeWt/0g3nptnrRlepUV161dlh6VjTOqrc4MKwIIF5yTVFOHI
	AZ/kWbm7zGnLk0BAsmbWslx5KjJ2977+P2IHjCMKm41ouNVyA4rkG8YhBhpER3WuH2tuP4uGXkD
	0/aOfnZektmVNsVdbnIb8t2iqPmMyf0U=
X-Google-Smtp-Source: AGHT+IExziO/wClSDkcsmF3JZY9mMkjWA/1wHGBjRI1ZYbcUBy4WdNb0huBz9eUl/2YGs0aOEhKEIbFSrrMOZRltihc=
X-Received: by 2002:a05:6820:201a:b0:657:71ec:544f with SMTP id
 006d021491bc7-6597263ef8dmr2925440eaf.2.1764866506290; Thu, 04 Dec 2025
 08:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com> <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
In-Reply-To: <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Dec 2025 17:41:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
X-Gm-Features: AWmQ_blbOxXzW56bggbVrVX6G5y3d4dEw8W79L-pw-X8HtjTcdH_Eqbe0cOm7Pg
Message-ID: <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <superm1@kernel.org>, 
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org, 
	kernel@collabora.com, linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>, Antheas Kapenekakis <lkml@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:04=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 12/3/25 17:58, Rafael J. Wysocki wrote:
> >> Add `/sys/power/lps0_screen_off` interface to allow userspace to contr=
ol
> >> Display OFF/ON DSM notifications at runtime.
> > Why?
> >
> >> Writing "1" to this file triggers the OFF notification, and "0" trigge=
rs the ON notification.
> >>
> >> Userspace should write "1" after turning off all physical and remote
> >> displays. It should write "0" before turning on any of displays.
> > This sets a limitation on the correct/expected usage of this
> > interface.  How can the kernel ensure that the limitation is taken
> > into account?  In principle, it should not allow OFF to be triggered
> > if any displays are "on", for example.
> >
> > And what exactly do you mean by "turning off a display".  Cutting
> > power from it or something else?
>
> The common lowest level denominator for the "turned off display" should
> be that all display CRTCs are disabled and there are no active remote
> desktop sessions.
>
> For example, firmware of Intel laptops tracks state of a built-in
> display internally and treats display being tuned off when either
> display's CRTC is disabled or when backlight level is set to 0. This may
> be not the same for AMD firmware.
>
> Display On/Off notification is a hint to firmware that it's allowed to
> put machine into a lower power state where UI presented to a user may
> become non-interactive.

To be precise, that's what MSDN has to say about it:

"This _DSM Function will be invoked when the operating system has
entered a state where all displays=E2=80=94local and remote, if any=E2=80=
=94have been
turned off. This could occur based on some user action, e.g. a button
press or lid close event, or expiration of some display power down
timer."

The "Intel Low-power S0 Idle" specification
(https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idl=
e.pdf)
says almost the same thing.

None of them says what kind of hint this is to the firmware and what
the firmware is expected to do in response to it.

> In practice, entering this lower power state makes device to pretend
> that it has been suspended. On a laptop, keyboard backlight will be
> turned off and power button LED will start blinking. This allows us to
> implement the "resume to a dark mode", mentioned in the cover letter.

Maybe, depending on what the firmware actually does.

> It's up to userspace to make decision when and what DSM notification
> should be issued, thus the new sysfs control.

Why would it be up to user space?

> There is no strict requirement on having displays to be turned off when
> Display OFF notification is issued. Machine won't blow up when display
> is enabled and OFF notification is set. Hence, it should be unnecessary
> for kernel to be extra cautious RE trusting userspace.

That is until one of them actually blows up when that happens.

As it stands, I'm totally unconvinced.

I generally think that allowing user space to trigger evaluation of
AML via sysfs is risky, pretty much regardless of what the given AML
has been designed for.  Turning that into kernel ABI is asking for
trouble.

Now, AFAIK this particular _DSM interface has been designed to be part
of the "modern standby" (or equivalent) flows, not to be used
separately, so assuming that it will always work the way you think it
will when used separately is kind of walking on thin ice IMV.

And there is also a concern regarding all of the systems where this
firmware interface is not present or not supported that will not get
the "dark resume" experience associated with it.  If you want "dark
resume" to be a feature of Linux, it should not depend on whether or
not a particular firmware is there and actually works the way you
like.

