Return-Path: <linux-acpi+bounces-20356-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B85D22F3F
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 08:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68456309EE25
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539F82D9EDB;
	Thu, 15 Jan 2026 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="cb3PVqQD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDA32E15F
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768463386; cv=none; b=W+tChaL5eYCe038feReUBIV6iWj5yL/BbohFo3YciEdvl+TlKLZ01thr46k4ouFwr4skc0hwbhuUlsxQlwAmwdvQrZPDMfrHzryrdR2Eig219C8XBvmaNxclZT1tAn4Gynd2a69TvQBSCcRFNsMTyhGV08g4cDm7/wWLBlz8p/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768463386; c=relaxed/simple;
	bh=/eV0MUi+e2QCE/kEZ72sJ7VNC+RMsWrL3OEGusFHwyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWeXlkxW9JfcQiCQ/Hj6mePwQq/C6JqiBT+r13w3+EGQnyn1YNn4rC3ckBiTAXJB6TOX/8NzTKsM5P4apNXnyMLObHDZJF1lj7vbDYApQaBvZQaqR33obgfNVodVcX01xilbtylSgPmCRZqsggPWrN5+T5pzDhJR/LxjM1ftqFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=cb3PVqQD; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id EF3DD40A92
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 07:49:30 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id D7E1E40B74
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 07:49:27 +0000 (UTC)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 0AAF420249A
	for <linux-acpi@vger.kernel.org>; Thu, 15 Jan 2026 09:49:27 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1768463367;
	bh=/eV0MUi+e2QCE/kEZ72sJ7VNC+RMsWrL3OEGusFHwyc=;
	h=Received:From:Subject:To;
	b=cb3PVqQDfHlouYVTeO5WyX2tKxJphC31AOdUvYBs3F96xe6GCJA3F1cEzZpTAWhPZ
	 WZoW1pI5JTFeY60z5329iwmYbkPJSLYea3fHuqxnrnFjR5lIae/a0E24AbUIZyxytv
	 jh3JBD0Trke3Y6PnLeBXntjvWUypbXn07rZCrI/9SkpArdA49ZhZRKwGgjiYuMX8el
	 dEzymvPWxLxirz5pyiattFRPqRiZ4ApgBxg3MBZPkxGF4c6nAxeQWhdco2OagXMSg0
	 hReuN2aFQV/2X8t/sLtrrCYiLxAyfZAYK9MLmHu1lQtLEeZGt6aGWzknfAhfL8GRJ5
	 m/udvUPzDREMw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f173.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-382f9930e54so13055871fa.1
        for <linux-acpi@vger.kernel.org>;
 Wed, 14 Jan 2026 23:49:26 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUpSRO26tN6Bz7F1k8uZaCzrtvF1bexsn9JgwIsBDK8nOd+F5LlQCYzy6Iugw87A3oOQNNqGUSJLZtt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe12cjwo0LAj1w7L+MMu6Oga8XtLIDqkwjj7ZhkkN/WjnpMjFp
	jgD/FFfPuytjEVNo6Mu8wzDC/1YJLPQtV7Yz/D7uj0MnKKK0Sk/ChfpltTMOfy1LgpMdkuVO/Fv
	qfCZypaWVt+XUnKXIm/8pRV61X3gOElE=
X-Received: by 2002:a05:651c:551:b0:382:4f57:e8d1 with SMTP id
 38308e7fff4ca-3836effcad3mr7054071fa.18.1768463366458; Wed, 14 Jan 2026
 23:49:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
 <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
 <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
 <ab4d90d8-3212-4571-9f92-ac4facd3aa33@collabora.com>
In-Reply-To: <ab4d90d8-3212-4571-9f92-ac4facd3aa33@collabora.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 15 Jan 2026 09:49:15 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF7aVapmRYczm+=rPfVDXH0i6UArQtg1TRgc7Vi6+XYxA@mail.gmail.com>
X-Gm-Features: AZwV_QiKHptTyzLZUNZHxU283KLf4ampz8nJS0iBFH5X6US2i_LgFo5Lx_tn8K8
Message-ID: 
 <CAGwozwF7aVapmRYczm+=rPfVDXH0i6UArQtg1TRgc7Vi6+XYxA@mail.gmail.com>
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
	jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
	rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
	superm1@kernel.org, systemd-devel@lists.freedesktop.org,
 xaver.hugl@gmail.com,
	John Schoenick <johns@valvesoftware.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176846336724.126202.3648425050513174169@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 15 Jan 2026 at 01:07, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 1/13/26 13:11, Antheas Kapenekakis wrote:
> > <snip>

Hi Dmitry,
let me go inline.

> The primary goal is to support screen-off DSM for a power-efficient
> background games downloading [1] and further resume-to-dark on Steam
> Deck and other handhelds. There is no strict timeline, usual "sooner the
> better". Downstreams will use customized WIP solution till upstream will
> get necessary generic interfaces.
>
> [1] https://store.steampowered.com/news/app/1675200/view/771930569635267984

Ok, this makes things clearer. I had done some testing to see the
viability of such approach.

One big problem [1] had was that the compression algorithm that Steam
used was very CPU intensive. However, it was announced that that
changed, which makes low power downloads more viable.

However, even so, I do not think the sleep DSM is designed for
prolonged background use and certain devices might overheat.
Specifically, I think the Go S disables its fan while in that DSM.
Looking back to what Windows does, it only uses the Sleep state to do
periodic polling, and if there are updates it transitions to display
off.

This is a fair approach for [1]. For example, device wakes up every
two hours while connected to a charger, stays on sleep state, checks
for updates, and if there are any and conditions are met, transitions
to display off and starts downloading.

However, this means you do not get a smaller tdp limit. Given you
control the unfrozen userspace in that state though, such a limit does
not help either. The device will use what it needs to for downloads.
This makes the SD 5W low power mode puzzling, as it means downloads
will potentially take longer and I would be punished as a user for
using that mode. Instead, Steam should be optimized to use less than
5W or perhaps 10W when downloading from gigabit in some way.

Two more considerations in this case are that a lot of devices will
turn off their controllers when entering display off. And the rest
when entering sleep. This is good because when you are in dark resume,
the RGB of the device has turned off. But for [1] it is problematic
because it assumes the controller works and is what is used to wake
the device so the mode is broken. For Legion, Sleep is used to turn
off the controller, and for other devices Sleep Entry/Exit. New in ROG
Xbox Ally devices is that the controller no longer turns off, but it
is muted.

The other consideration is that three additional patches are needed
for ROG Ally devices to work correctly with this series, 2 cleanup
commits and 1 small delay. But after that it should be drop in. I
cannot comment on the new hid drivers for Asus and Legion that are
currently being developed. Particularly, hid-legion-go(?) has a
reset_resume() cb where it should have used resume? Or not anything?
The legion controllers save os mode until they disconnect, which they
do with this series, so the driver would always re-initialize on
wake-up.

> A common approach for upstreaming is to divide problem into smaller
> manageable parts. That's what I'm planning to focus on now to see if we
> can start easy with a minimal changes.

Sure. One potential approach for this is this series, where the first
part does the plumbing and the second part the exposing. They can be
merged independently.

I also made sure to address Rafael's comments, so the ABI of this
series is completely independent of ACPI, S0ix or whether the device
has a display. I also removed all references to Intel, AMD specific
power envelope terminology. Moreover, most of the logic now resides in
suspend.c and the hooks are in platform_ calls, so it can be
implemented for other platforms easily.

However, the first part of this series does some refactorings which
assume a favorable outcome. If we do not want to assume that, a
simpler initial series would just move the MS/display on/off DSMs to
.begin() in s2idle.c. If you think that would be easier to merge, you
are welcome to start with that. Then this series would be refactored
on top and merged as a single unit. Keep in mind the ROG Ally conflict
would also arise in this case as well.

> Please don't worry about the credit. You did a significant ground work
> that is well recognized by now. Thanks a lot for your efforts and help.
> Starting from scratch of course won't be a good approach with all the
> broad testing you've done.

Great. Sounds good to me.

Antheas

> --
> Best regards,
> Dmitry
>


