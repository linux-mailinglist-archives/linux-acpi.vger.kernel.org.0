Return-Path: <linux-acpi+bounces-19448-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9DCCA89A2
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 18:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB7853026FA5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F683596EF;
	Fri,  5 Dec 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6l9MhJo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D08A357738
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955360; cv=none; b=rEKZcHB1I8GsbkT4TtV+aVAYgtiiapc7W2Si7A0ekGzbZGtgNGnUUDzSfl1XWGxwwmibej8pCpkmVe3fdXkBN5hDPSjxjx+KGAu7RMbDfLFAh/tABzPjflnpH1XwcKg82Vzt1gZXvErApYdDXiM8Ose/GNNBPqdueNNBG/l0X/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955360; c=relaxed/simple;
	bh=sZ9ojCxV5T8d6VmR7Tz0Xn787JbH+WM8f8GhV0f7XOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5F5mzLRTrp+ZwWLQjPwtokfta5GOe7Cx3EK03O7u8F+cAthHQuH8BebmXSJkjZi60GQFFIDYicY0ieONaDA80SKz8llEuyfk2Iu4t04cRApfkob4PlfCVlyOJE/HEpoiqLKFlMKg+EG3ImwawTn/bnPBaGLw1qF/0usyq7U9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6l9MhJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AECC2BC9E
	for <linux-acpi@vger.kernel.org>; Fri,  5 Dec 2025 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764955359;
	bh=sZ9ojCxV5T8d6VmR7Tz0Xn787JbH+WM8f8GhV0f7XOI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G6l9MhJoZ45D2Ul+pQeVI8xo9yYoAaDVwXu/ewqIGhDtNgU0ObLuNK43tdFd03AN5
	 k6qlhqkiejlkCTEDLv9JRi0RukvhDAtlCrnQRchqtZNrQiErRG2BPmd9mUM3nxYRT/
	 Da2P4+hcqZabTpCAn5jVCGemrZtBv23DzfAZBQzOku1+2NK60lpdfk4eo8E2JspskZ
	 1IGyT/r3HDxN4pyEfsvWVBtDt8On8lFOLPaXz52BidKe160a1i7hzwmJ4xc50LLRV7
	 xvCe6ApU7YPs5x5V91OYrySCz0ru9aqYz1EGaNO/ht0xv1SvOgm8iu6th5zlrIQQWK
	 cfLat5OZewbzg==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-450ccefe6ffso1429036b6e.1
        for <linux-acpi@vger.kernel.org>; Fri, 05 Dec 2025 09:22:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaHECnh9V3HcUXtZgtrvS10fW0G/QZmgZAgDVYNlfXgrDPb9XZGGbm3882q+5tO0YRTSNNPIHknmU3@vger.kernel.org
X-Gm-Message-State: AOJu0YyWP+lJpDlOMevIXBjxfSiYh9IgrWl/J2pLXArSusKM7DwKZnDQ
	mooYsLxxidkPNJgjN1JT+E0dHYj1+AacWIZO8sxSSVT1ACelzj7MZmqb/a+L0aDCmSfM3nFicaC
	jdgKkOaQnN4yL0P53Nt9btQBvWhgj8vI=
X-Google-Smtp-Source: AGHT+IFUpJdSJiWLMpS6m0qfBccQEMpPv/9UAmmKeLAbQsyCHSLbIo9b+8JBK4vvO3tcMgI0WEJaHb6MBUeyhzIU1xY=
X-Received: by 2002:a05:6808:10d4:b0:453:316a:7782 with SMTP id
 5614622812f47-4539d1a3536mr2692b6e.14.1764955358886; Fri, 05 Dec 2025
 09:22:38 -0800 (PST)
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
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com> <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
In-Reply-To: <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Dec 2025 18:22:27 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkDNVAL5802FNa_2HVe37jZhhA3KLW1cFhULohauP-pUogyy9poBe2GG1E
Message-ID: <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs interface
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Antheas Kapenekakis <lkml@antheas.dev>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Robert Beckett <bob.beckett@collabora.com>, 
	linux-acpi@vger.kernel.org, kernel@collabora.com, 
	linux-kernel@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Xaver Hugl <xaver.hugl@gmail.com>, 
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>, 
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>, 
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 5:47=E2=80=AFPM Mario Limonciello (AMD) (kernel.org)
<superm1@kernel.org> wrote:
>
> > I would start with the graphics stacks and teach them to
> > runtime-suspend the HW when the displays go off.  No firmware
> > notifications are needed for this to work.
>
> Well the problem with this is there is a sizable latency to runtime
> suspend hardware when displays go off.  For example you would need to
> redo link training when you spin the hardware back up.
>
> What we do today (AMD *dGPU* centric) is runtime suspend the hardware
> when no displays are connected and nothing else is using the GPU (for
> offload purposes).

The latency problem can be addressed by using autosuspend instead of
synchronous suspend.  Just set the autosuspend timer when displays go
off.

> On AMD APU we don't use runtime suspend.  If you ignore the latency I
> could see an argument for proxying the status of displays to indicate
> runtime suspended, but I don't know what it really buys you.

Well, the lack of runtime PM is a problem and I don't see how it can
be overcome easily.

The main issue is that when the system is resuming and there is no
runtime PM support, the device in question must be powered up during
the system resume flow.

> > Then, I would teach
> > graphics drivers to leave the devices in runtime-suspend if they are
> > runtime-suspended when system suspend starts and to leave them in
> > runtime-suspend throughout the system suspend and resume, so they are
> > still runtime-suspended whey system resume is complete.  I'm not sure
> > how far away graphics stacks are from this, but at least some of them
> > support runtime PM, so maybe the fruits don't hang very high.  With
> > that, you'd just need a way to trigger a system suspend after a period
> > of inactivity when the displays are off and you have your "dark mode".
>
> I think even without kernel changes this can be accomplished today with
> userspace.
>
> There will be change events when the displays are turned off and you can
> listen to and set a timer to enter system suspend based upon how long
> they are off.

True, but that's just about suspending.  To avoid powering up devices
on the way back from system suspend, runtime PM support and
integration of it with system suspend-resume is necessary.

