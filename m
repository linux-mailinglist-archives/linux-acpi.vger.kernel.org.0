Return-Path: <linux-acpi+bounces-11669-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73332A4AB83
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C9E189596E
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C611D7E30;
	Sat,  1 Mar 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="1qTyQF7Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542D3594D;
	Sat,  1 Mar 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838019; cv=none; b=VyHblQhm8q37p+9NgTWAOvF5QALY+FHG4tYlfVYSWiiTQN9Ru67dSTc5rRlLIInSGkRmgEo5sVvjS2DM1Bkac1TI+KJDH9oq75g5a58yT2Cj60L/qIsnvGaZfttP4Zq4C+OISf6TMHWgwqAfLKIogaWCxg+wed81oMI49PuUGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838019; c=relaxed/simple;
	bh=vrPYk6k8//Z0LQK1regWtHWe5PuTPpuqGxoiQap+kko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVpKxuXu/B9qFnHD9SocLUjJpRDdEsSKzHGBfXqFZoo1Ige1sOBbMXts7g9sxEymlD7myQDOFZIG/dwkAsdWyrglyHBTD7pCX0MYGWw1rbS27+9q6IsCx4VLAydB/62HY3AEHxi72r802ASFhVquANh2OkIb13XIz0usd18SW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=1qTyQF7Y; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 6F4CC2E0901F;
	Sat,  1 Mar 2025 16:06:53 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740838014;
	bh=RwsK4RjSMl7klWHS4mPb9Zf8jMU2TS66K1Ehm0StR5U=;
	h=Received:From:Subject:To;
	b=1qTyQF7YzRIBgHtlYVPNqoNbgGB6rEXeEZ8RmfnhAqeO2CnMjCps+skvNqp6UiW6K
	 /cv1GcriHXGxtnOkuHQB6MnAn2uf9Cg4C5WJMMtizCihXnueTmO5Vnki4GCVUHzqCO
	 ovAZcWxUN5oC53C2a7JKPelmZa+51dkyNwjccnVA=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f175.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-30b99c6cd35so13308271fa.0;
        Sat, 01 Mar 2025 06:06:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWXYsg0xK99nkRhCzAAw5Aka41IZE3D9XrCiyjqO0LoIYt1n4wPtLRrNOb/4gMpkYD/I9jGq8QilZ4a@vger.kernel.org,
 AJvYcCXIAN551vPDQTC6kxIcx5r7TC4QDCHqWlOkueIpj8zwAmzd7kf7+EehQQ7CXxcqGZGReO+uKftlnG+YKJwYO3O/XNcSvA==@vger.kernel.org,
 AJvYcCXw4Ignh3Epe/4Lkk9v+tl8FPtg9fJPGo4BYHZXiyuNPoxvxE937g8plKDW2dGJyUJKaHouIbl8v3CElk0V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kkpQYBrzKFbyTkLLh8yF490JXJMQcVkSKsWuSTOPoCUGewgZ
	7rBoAzGCAcwt22uL1Tvd8952UqONZBQ/5NSjQSDuHSqZyshRojWWX+K34LFoticE2K5vTuB5abn
	NszkALLsTV3SX72TDz0pj4GkQhLA=
X-Google-Smtp-Source: 
 AGHT+IFBhQ5fJmY292t4rD6gX1zynSjGq+0ykDB3y5hBEMyDS0YcEgbUhfceJRUcrDeFbeUJcCa/d2vI3cUQrmq7+5o=
X-Received: by 2002:a2e:91cb:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-30b9330796fmr24702791fa.37.1740838012713; Sat, 01 Mar 2025
 06:06:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
 <20250228170155.2623386-2-superm1@kernel.org>
 <D84F6QF8EU3D.3RUI1PKXP2DZ3@gmail.com>
 <6f56571a-3090-4323-a29d-008b916abf39@kernel.org>
 <CAGwozwGFLQxGEQ-nb+d9yrikz=fx+u48mpTYUyUtvgFD-9ypQg@mail.gmail.com>
 <09674d15-d639-4cb3-837a-9575f0028a76@kernel.org>
In-Reply-To: <09674d15-d639-4cb3-837a-9575f0028a76@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 15:06:40 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFm1HeLNtJNGOdQCe_poWeNNeOB=3EzizFx_p2rB-RXbQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqIjbWgJGnwdOm0VcOOeHeD8d1OlDPG9mXO8Pk0MD74jIyMxcQSnj2yTDg
Message-ID: 
 <CAGwozwFm1HeLNtJNGOdQCe_poWeNNeOB=3EzizFx_p2rB-RXbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: platform_profile: Add support for hidden
 choices
To: Mario Limonciello <superm1@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	"open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174083801397.2184.11357227051122834707@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 14:52, Mario Limonciello <superm1@kernel.org> wrote:
>
> >>> Let me know what you think!
> >>
> >> I don't really like that profiles can get out of sync, this is asking
> >> for a non-deterministic behavior that can be difficult to diagnose
> >> issues and also difficult for userspace to work with.
> >
> > I agree with Mario here. Imagine two drivers, one with low-power and
> > one with quiet. They both begin at performance.
> >
> > Then, userspace software gets confused (incl. ppd) and sets firmware
> > profile to low-power. The latter gets left in performance, causing
> > excess drain.
> >
> > I do not believe the legacy interface should be deprecated. Right now,
> > amd-pmf is a NOOP in most devices
>
> "Most" devices is not accurate.  There are a lot of devices that it does
> enable.  In the gaming space right now it's often behaving as a no-op.

That would be a fair description. Can you give some examples of
devices that use the interface? Devices with and without vendor
software.

> > so there is actually 0 reason for
> > generic power handlers to move to the new API. Just extra work. So
> > lets make sure the legacy endpoint works properly for the foreseeable
> > future.
> >
> > Also, when power handlers start moving to the new interface, they will
> > hardcode choices based on the name. As they should. TDP needs to be
> > customized per device/manufacturer. So moving handlers between
> > low-power and quiet will not be possible.
> >
> > @Mario: I do not have a device with an amd-pmf integration. All of
> > mine have stub handlers. I would expect that a properly configured pmf
> > handler for e.g., Asus would do the same as the armoury interface, so
> > that users do not have to rely to vendor software on WIndows. Then
> > power profiles would be synced between windows and armoury. In that
> > case, we have a problem of setting the power mode twice. What would be
> > the mitigation for something like that?
> >
> > Antheas
>
> "Power mode" is a concept, it doesn't just apply to configuring sPPT and
> fPPT.  I envisage that a vendor that actively uses PMF and their own
> interface would be changing different things by the different interfaces.
>
> For "example" PMF may reconfigure sPPT, fPPT, STT and STAPM but their
> driver may notify their EC to change a fan curve.

No. If PMF changes these values it also needs to change the fan curve
itself via the BIOS notification. Doing otherwise would lead to
situations where users do not install the vendor driver and cook their
device. So I expect that when PMF controls things it controls
everything. I would expect if vendors fallback to the pmf firmware
notifications while also providing vendor software there would be some
synergy between them, such as changing which fan preset is selected by
the PMF interface.

> If we really end up with a situation that vendor interface and PMF do
> the same thing we can cross that bridge then.

