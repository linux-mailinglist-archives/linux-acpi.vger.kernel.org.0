Return-Path: <linux-acpi+bounces-19528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FBCB14A1
	for <lists+linux-acpi@lfdr.de>; Tue, 09 Dec 2025 23:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F4D30BCC55
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Dec 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0542E8B6F;
	Tue,  9 Dec 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Ei3k8ked"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE426E706
	for <linux-acpi@vger.kernel.org>; Tue,  9 Dec 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765319278; cv=none; b=sgZG1f+aIpq6DGqvvW9CPTD4cuq32luXRI1nXvwVph8UUUqegc9CzUkFttvmisRJhoysTrDRmsjciuY0yCCKJR5TL9kl9GgWmgvdVxL8tQhN5Abpgpnk+TjOqNj0gFsIqYEKaKB8AUG9LTHGgpy+I5HDju4yl9LrBuyPzEsymB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765319278; c=relaxed/simple;
	bh=lGydI5EaAFCi6spWlLuXHA66k1nEWZwn9/VSbZfhc0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KsGohTTNstw7Ly3RUoD9OoiupHM8X4CYnfaul8N9alOoSG7k8gfrPM4xcIKllUaUvFbWjvBD320nbK5Wki1k7zH5O5OW1tXNoA5uF9suTAY/hI1MBAOZGCt6n2/ctP0SzwFO62D6shDrWhqT9DBrT1r5dlXU5b8R3EcMWmtRxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Ei3k8ked; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 4D0B8BDAA1
	for <linux-acpi@vger.kernel.org>; Wed, 10 Dec 2025 00:22:48 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 5F89ABC759
	for <linux-acpi@vger.kernel.org>; Wed, 10 Dec 2025 00:22:47 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 8CC8B201D74
	for <linux-acpi@vger.kernel.org>; Wed, 10 Dec 2025 00:22:46 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1765318966;
	bh=lGydI5EaAFCi6spWlLuXHA66k1nEWZwn9/VSbZfhc0A=;
	h=Received:From:Subject:To;
	b=Ei3k8kedfUKMGDo1Ns7SQkbe19J5FeHtCA+OJ2dU1NFGpOH+2eBcovYqZ6kNYVx9L
	 q5IlZh3NhCr72U4wzknFe+rVAR702NhqTEaV5tu2mO2nTC3dN07Fd8V32Fc3UeZSnu
	 QX/8vEzbKiKlCXIQ+1AQBmG6ZlBP8gcklTwYQZGBIsGqf9uH6AiwQmF0l8XmL1ndCn
	 uTspLF9ueBWfCnYI7rhPOCCtKZ6FvPV5Vi+Ce9w2vDOBxMKMH6iTeD2vZ9uowbMAZJ
	 LUrjbdvf6NqykdSd0o1Yi6oPhL+8nD0JvSQ0JEfGKy6di99suSH4i2vNTgfDueLwx0
	 wK3gqC2HldPGA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-37902f130e1so48496391fa.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 09 Dec 2025 14:22:46 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXg1x9DBI4Icnw/NQHnXkMbIAv0Uyi5v6isV3w/eS1UtIhTZX7qHDVYkcuLWf+FJFCg1lw9cOzeUii2@vger.kernel.org
X-Gm-Message-State: AOJu0YzNOpgl6f5T1/sujdy1evjqvfDsz2EEzR1fFppEaaktWSxKtys2
	Z1b5NJNf3DSCAPWioW8vke+u9rss2nrvQOBaEjoH3k7KRB5PNBEV5H22ExKkCveyIfP8GHsikN5
	7vJIskyc3h4mGW61ICQOJH0XNEinpwCY=
X-Google-Smtp-Source: 
 AGHT+IEkv4oSqBgSbJxD/nNZ7QvfuedOdmNIbC/8COeHH+QLLTos2su1W7h58FqSIggWJOgRBRZC/qq0js6WrD4rYUg=
X-Received: by 2002:a05:651c:1508:b0:373:a3e2:b907 with SMTP id
 38308e7fff4ca-37fb2082422mr1213231fa.10.1765318965968; Tue, 09 Dec 2025
 14:22:45 -0800 (PST)
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
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <CAGwozwHd5196hr7Ckvh9wVJiyw0MBUriz+oqNWhOSkEYbCVMtQ@mail.gmail.com>
 <CAJZ5v0j71mic4y2+TjZyNKe6NbSA8B74WHdyh_AxC-rZkQND5A@mail.gmail.com>
 <CAJZ5v0j3wNtqYQDsVr+74-Gn-WM9FDmoqxrLULVD+UJtfVgLtQ@mail.gmail.com>
 <CAGwozwEgfH+QRpBXNGhZG5hxNF28A3ALbrABGYJg7RuFKDrM0A@mail.gmail.com>
 <9e663a52-691c-4387-85b7-73e7f51086de@collabora.com>
In-Reply-To: <9e663a52-691c-4387-85b7-73e7f51086de@collabora.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 9 Dec 2025 23:22:33 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEQRcK13Ys9ER8YsLoWyYPDSLrdZjtC2KFYJ23DBC6K9w@mail.gmail.com>
X-Gm-Features: AQt7F2qw1dNqFUb-vAJpCLfyI_AxW1TL1cfTZsO-gFQTRdxhBxH7TUcu8gzidDI
Message-ID: 
 <CAGwozwEQRcK13Ys9ER8YsLoWyYPDSLrdZjtC2KFYJ23DBC6K9w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
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
X-PPP-Message-ID: 
 <176531896677.1306636.10020496199732859990@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 9 Dec 2025 at 23:14, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> ...
> >> So let me repeat for extra clarity.
> >>
> >> The only change related to the LPS0 "screen off" and "screen on"
> >> notifications that would be tentatively acceptable to me ATM, would be
> >> to modify the suspend-to-idle flow to do the "screen off" notification
> >> earlier (possibly even at the start of it) and the corresponding
> >> "screen on" notification later (possibly at the end of it), provided
> >> that one can convincingly argue that this should not introduce
> >> regressions.
> >>
> >
> > From what I recall that was my original plan.
> >
> > Yeah, it is a fair way forward. @Dmitry how would you like to approach
> > this? SInce you re-started the discussion. What is your timeline/KPIs
> > for this.
> >
> > I could personally try to whip up a small series after the merge
> > window by rewriting what I have[1]. I have more experience now in
> > drafting this kind of thing and that series added some cruft to the pm
> > core with multiple additions to platform_s2idle_ops
> >
> > There is a _small_ quantitative difference due to moving the calls.
> > Specifically, the power light responds a tad slower when waking a
> > device. For the legion go (non-s) devices, Lenovo added a dummy 5
> > second timer to resuming the controllers because of some Windows bugs,
> > and moving the calls causes the timer to start later. But that's the
> > OEM intended behavior...
> >
> > Antheas
> >
> > [1] https://github.com/bazzite-org/patchwork/commits/pm-bleeding/modern-standby/
>
> Am I understanding correctly that the plan is to have a 2-stage freezer
> for suspend-to-idle + standby mode? Rafael, could you please confirm
> that you're fine with this 2-stage freezer part of the proposal from
> Antheas?

2 stages here refers to a two patch series, where the first part moves
the firmware notifications to the beginning of the suspend sequence
and the second part introduces a sysfs entry.

This way, it can be verified that it is ok for these calls to be
moved, and thereafter they are only called before the suspend
sequence, not both depending on userspace involvement.

In your series, you introduce a call from userspace, but then do the
fallback call at the end of the suspend sequence/beginning of resume.

> What you expect to be a proper way of implementing a 2-stage freezer?
> Would it be a new executable capability, a new syscall or extension of
> existing one, a new cgroup type? How would you mark processes that
> should not be frozen on the first stage? Or it would be only the process
> that writes to /sysfs/power?

This would be handled by the init process without any kernel
extension, so it is a bit tangential.

You can reference the current freezer group in systemd-sleep for what
is done currently. It was introduced to prevent waking programs during
the transition to hibernation. In addition, freezing userspace _tends_
to improve VRAM evacuation when preparing for hibernation and cache
evacuation %, among other things.

So under systemd, the kernel essentially is only responsible for
freezing systemd.

> Thanks everyone for the very detailed input. It is all very productive,
> helps a lot with adjusting my understanding of the modern suspend features.
>
> Agree that the usefulness of the visual aspect of the Display
> notification is questionable. Previously I thought this mode involves
> power-limiting. The Sleep notification might be much more interesting then.
>
> I'm heading to vacation till Jan. Antheas, I will be happy to review and
> test your code if you'll have time to type a working prototype.
> Otherwise, will continue after the Holidays and likely will use your
> patches for the base.

Happy holidays. I am also heading off soon, but I might have some time
in the meantime.


Best,
Antheas



> --
> Best regards,
> Dmitry
>


