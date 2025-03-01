Return-Path: <linux-acpi+bounces-11671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B11A4ACC1
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0DC916FF68
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD421D90B3;
	Sat,  1 Mar 2025 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Qy7I7jum"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4A2CA8;
	Sat,  1 Mar 2025 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740845738; cv=none; b=pYaDuupjqzdQEkIfEWLl/AN6w2qZ5YHC7tTghAqlfuEH3J1vsGLDVltf1HCjV2/fxe3Q1UM1Zf/9Su8rdAtXvTzcCbUK4COfGyTRCS0syCJjbfmBnhgjggvN1NwppB3ySwUSUXWiB1OktGymkAkAFQnCaU5Qxvx/c76MhAadx/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740845738; c=relaxed/simple;
	bh=rO1haNxXJjWBYp2kLi6/7nyMr/AhMrO1WGMIJIAY850=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIp0ARQjbt5mZCWsggs6E45x0I3UX0z8iwEVVLQ4r8MBoRYmeQwuTzvrbuL7ByGi+qjWwna/rzLV0TTxLUNBrktHq2j+IGikPCtNvaSKYQ4xHMV7CIy/mQCN7h005s3xtrfr8ViB/4TdJ3LK1FceUMittNGILfgb6HWXK21t9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Qy7I7jum; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 55EE82E09033;
	Sat,  1 Mar 2025 18:15:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740845733;
	bh=3/AcPH/u9ITuQ7NTcxKxHIGPzA5C4yDHZ1oG//9xL9A=;
	h=Received:From:Subject:To;
	b=Qy7I7jumfuV1+6qe11a+LHkimOGE+WVlADM1JE4cUX8STdtvrpceFwnCt5saoU90J
	 kUCbM+TYMu6C1QNHJg6e83QQ0O5EJy74bK9SOAReaBrvQpSXhRVIiTr6bJUwb9qBbX
	 Cx7CaoJR/tou9VSDtl4Pr1cg/z3xkGHO5pogA1fc=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.167.54) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f54.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-54959d1a856so572140e87.1;
        Sat, 01 Mar 2025 08:15:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUhKevkT218i8u9HZkseIOlEsFmb3k3uEfaExWWzNDqB5jv3U13j2oCMFdTLxAyw9CZ5sqBfyrhGWFe@vger.kernel.org,
 AJvYcCVNl6FsqFfZ+krCj8oISJVCqiu4XBrAubs/3n6CJ4ss8PecvjYGRSAuaAi8j7ybqv1T1YjAzTVMZOtBw4e/gmFhDW4Xdg==@vger.kernel.org,
 AJvYcCXSMKZfTAu9mt4smJ1hX4FcQuX6q8qAmkFK3cfwkn4mm8PmvytGCo6P+i8Wcy1z4tSa72gmRDl4KQiL+ixF@vger.kernel.org
X-Gm-Message-State: AOJu0YyRcqpHjgqRDH0026J8YeJevPn4ToVCf+aR38RB2X2FdxrF4WOn
	YIlMD+yOtjx3PwFGS7+ZfMJdl4zdUbslRT9YBKXsTYN+YOMtW+7fLscYOmVIqkOm4qsHLNC3tDC
	adgTCAPn9WccBbYwoDJwjVbQXba4=
X-Google-Smtp-Source: 
 AGHT+IHbExRxjvJB9s6yCP7YhEA0jsc9zdBDbT7Z0uVUbMlGSC9o/vHqoa+g+ZdfS5ZlUnTKYhTY7lpQoxNLucKzu4Q=
X-Received: by 2002:ac2:4f03:0:b0:546:1ea9:6230 with SMTP id
 2adb3069b0e04-549432ccb0dmr4259256e87.1.1740845731596; Sat, 01 Mar 2025
 08:15:31 -0800 (PST)
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
 <CAGwozwFm1HeLNtJNGOdQCe_poWeNNeOB=3EzizFx_p2rB-RXbQ@mail.gmail.com>
 <59634335-9365-454b-8f07-1b8f564e5f29@kernel.org>
In-Reply-To: <59634335-9365-454b-8f07-1b8f564e5f29@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 1 Mar 2025 17:15:20 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEVDkArYZLg+pvZrh02TtGM4+6EH5GCRpjxEAwMH4xZ+A@mail.gmail.com>
X-Gm-Features: AQ5f1JpmW8KqGpSi_TpKYo-21bQ3yyMuN7mTCy2oKRPXp15Soz8cMWKb2QL5Mvs
Message-ID: 
 <CAGwozwEVDkArYZLg+pvZrh02TtGM4+6EH5GCRpjxEAwMH4xZ+A@mail.gmail.com>
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
 <174084573283.17645.2878387510956579562@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Sat, 1 Mar 2025 at 17:04, Mario Limonciello <superm1@kernel.org> wrote:
>
>
>
> On 3/1/25 08:06, Antheas Kapenekakis wrote:
> > On Sat, 1 Mar 2025 at 14:52, Mario Limonciello <superm1@kernel.org> wrote:
> >>
> >>>>> Let me know what you think!
> >>>>
> >>>> I don't really like that profiles can get out of sync, this is asking
> >>>> for a non-deterministic behavior that can be difficult to diagnose
> >>>> issues and also difficult for userspace to work with.
> >>>
> >>> I agree with Mario here. Imagine two drivers, one with low-power and
> >>> one with quiet. They both begin at performance.
> >>>
> >>> Then, userspace software gets confused (incl. ppd) and sets firmware
> >>> profile to low-power. The latter gets left in performance, causing
> >>> excess drain.
> >>>
> >>> I do not believe the legacy interface should be deprecated. Right now,
> >>> amd-pmf is a NOOP in most devices
> >>
> >> "Most" devices is not accurate.  There are a lot of devices that it does
> >> enable.  In the gaming space right now it's often behaving as a no-op.
> >
> > That would be a fair description. Can you give some examples of
> > devices that use the interface? Devices with and without vendor
> > software.
>
> Off hand the Framework 13 and 16 AMD both use PMF exclusively.  So do a
> bunch of HP commercial laptops.

I will ask Kyle to check it out.

> Mark can keep me honest, but I want to say the Strix Thinkpad laptops
> have both PMF and vendor interface (thinkpad-acpi).

Hm, yeah that would be interesting to hear about

>   >>
> >> "Power mode" is a concept, it doesn't just apply to configuring sPPT and
> >> fPPT.  I envisage that a vendor that actively uses PMF and their own
> >> interface would be changing different things by the different interfaces.
> >>
> >> For "example" PMF may reconfigure sPPT, fPPT, STT and STAPM but their
> >> driver may notify their EC to change a fan curve.
> >
> > No. If PMF changes these values it also needs to change the fan curve
> > itself via the BIOS notification. Doing otherwise would lead to
> > situations where users do not install the vendor driver and cook their
> > device.
>
> Fan curves are just that; curves.  They just control how quickly fans
> ramp up not whether or not they "work".

The APU reaches a similar temperature (Tctl) across a wide TDP range,
so temperature cannot be used on its own to determine fan speed.
Manufacturers that provide different fan curves depending on the TDP
mode usually cap the maximum fan speed on low TDPs. So you can get
funny situations where the device is set to 30W, but the fan runs as
if its using 10W leading to thermal soaking. So it is very important
for those to be inline.

> But in any case; that's a firmware issue not a platform profile design
> issue.

It would be a hypothetical scenario. I do not expect such a device to exist.

> > So I expect that when PMF controls things it controls
> > everything. I would expect if vendors fallback to the pmf firmware
> > notifications while also providing vendor software there would be some
> > synergy between them, such as changing which fan preset is selected by
> > the PMF interface.
> >
>
> I can't control what vendors do; it's their decision how to manage their
> systems.  All I can do is provide infrastructure to help.

This was more of my intuition of how I would expect amd-pmf
integration to be done in Windows where one of the drivers might be
missing.

Since only thinkpads are expected to do both, perhaps Mark can check
out how they work. I have a thinkpad that is 11th gen intel.

Antheas

