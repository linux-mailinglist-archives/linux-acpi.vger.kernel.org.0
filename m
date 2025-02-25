Return-Path: <linux-acpi+bounces-11474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD558A44D63
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 21:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B437A189D33C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2025 20:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852AF212F98;
	Tue, 25 Feb 2025 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="5cPPTy+A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3371ACED7;
	Tue, 25 Feb 2025 20:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515078; cv=none; b=tQouXTe+mXd0Upl7XBh/f5AYiO3qgRZeIweutAREr2/JgEjku40B1otxs6Fp22cloCmM+GbbQS4UEXxO8Y12q5E466oKmvQdVTqs1kZZkXHmbSvNV/JvAVmkSPAbhBXk6c7vDBmFT9hWHzCV6gHpJv2ipMAV0XwjLOxS8lC0QLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515078; c=relaxed/simple;
	bh=AcwTcKmfInQbAZOqb4dvorihzjJAczTme/Zg1EZMMRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNnTDfNMkIEWgZI8SijMfHvOgFxeMU+0xuZhG3m/y1EPmlwE97KQEYJxGEYgY1bUFOR43WGLzdIOiSKiQFQm48zaAC4PNW/eE1YLINaxnF2qfs8hsO1KOfDAwar9fAyjut0Pxqz+xyW1q1xwb55Q2kfU90vStMj6xK/ALn93FqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=5cPPTy+A; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id D0DAA2E07BC8;
	Tue, 25 Feb 2025 22:24:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740515071;
	bh=AcwTcKmfInQbAZOqb4dvorihzjJAczTme/Zg1EZMMRI=;
	h=Received:From:Subject:To;
	b=5cPPTy+A/x48DQvmCMvpBlhHmDgfk2VE+a1VsTMAy2hXOagQAg1lQW8RLTYxY8zcu
	 SWhjv0/3XHKCjQNvIJ+TwRx/4vnBt/3D3FVxKZK+gBSds+FrOF1nXPmOkJba8w47xz
	 YoZhw+f9FYd8I6dKmZyPkytEHTlYN9s2WOHzipm8=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-3092643f4aaso1761431fa.1;
        Tue, 25 Feb 2025 12:24:30 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUAMJJ+NE6NZzzK4+3pacZ3z1iejTZCkj7TNm+viyz/MePeVBNnRUtX32REnvoffh58Kpf3y3MF2dQmcMvl@vger.kernel.org,
 AJvYcCW0KiaIIH+IN0Vdy0RYFIt4C0gu39NeVsvIhkcWGP1Nuv73BKxRyV9YhHsYTTJeyGqe+yJuYlc/Ckr3@vger.kernel.org,
 AJvYcCXkxVf9MPTqpcdrndeXyWJniQA6vZidnDa2STg4F0r0Oyg3oORd9XRtJZzlxuL2j7w/D6yIxa6YkfZw5wCo7WO4XpUX1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDszEcXT1j44L6di79Y0SEVMx48yG6eZudxxbjdFWGb2S1l3+6
	uvbcDXKDOhpahGe9glmJNiS4uPAGEBdM6dFE+SAFXhlPWGOmQux7vBNW8NsXJ0qbEWj2GfwG9bJ
	VmzHdB16XaUSREPdzHRWA2xv5zzE=
X-Google-Smtp-Source: 
 AGHT+IFW1BzXd/SWdychJfJva4EEaTal6rwJbQZHyDydFnbFd5/UhiKgmrA/liDXhCS6EvXSmcqemGbqUMvSajr5J+Q=
X-Received: by 2002:a2e:c49:0:b0:309:2696:c293 with SMTP id
 38308e7fff4ca-30a505bbb9bmr93748571fa.4.1740515070102; Tue, 25 Feb 2025
 12:24:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev>
 <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de>
 <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
 <CAGwozwEEbsLOJROm7rW-240Zoqh3K_JOtZE_NL8AnLy1eChR6A@mail.gmail.com>
 <CAJZ5v0jpSN_Tq6D3OrRj5KDuXwqVuzcwyNXwEuL90fr=juH48g@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0jpSN_Tq6D3OrRj5KDuXwqVuzcwyNXwEuL90fr=juH48g@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 25 Feb 2025 21:24:18 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHAKbR4y9cW8H0nmESS7yv6RrXtgcZyEdz1Wy2e8tAdqQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo-YXTQsk6kizRYpFDfvj0ZJrBEf8feP27iP90wsb9JW8GXNp7UBJhdpgk
Message-ID: 
 <CAGwozwHAKbR4y9cW8H0nmESS7yv6RrXtgcZyEdz1Wy2e8tAdqQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, Luke Jones <luke@ljones.dev>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Limonciello, Mario" <mario.limonciello@amd.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>,
	me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <174051507137.19406.17156529916513827378@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

This is what this patch series essentially does. It makes amd-pmf
accept all choices but only show its own in its own handler and when
it is the only option

On Tue, 25 Feb 2025 at 21:22, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 25, 2025 at 7:07=E2=80=AFAM Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
> >
> > Yes, making asus-wmi use low-power is indeed the easiest solution, but
> > if I thought it was good enough, I would have done that already as a
> > downstream consumer of the kernel.
> >
> > I just want to be done with this once and for all, so I spent an extra
> > hour today solving this in a cleaner way.
>
> What about adding "quiet" as a "hidden choice" to amd-pmf such that it
> would allow the test_bit(*bit, handler->choices) check in
> _store_class_profile() to pass, but it would not cause this "choice"
> to become visible in the new I/F (or when amd-pmf becomes the only
> platform-profile driver) and it would be aliased to "low-power"
> internally?

