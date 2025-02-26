Return-Path: <linux-acpi+bounces-11504-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7454A46E53
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 23:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED0A188BA7D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 22:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5950725BAB1;
	Wed, 26 Feb 2025 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="2P7POLzv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F5525BAA0;
	Wed, 26 Feb 2025 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608145; cv=none; b=gxFQY9wl26Ui1tg93tD3bzYao7AWaBdSnPogGCp3j/LhbFwIt/BI+kZohNK5j8raFwZKOil4oIVgcZQWWs8KN8jcxnQ10Pw+z0mCZKQbethrSs5OdT1ofX17yJjBMVwTIDx8qMl5sovTXiwStrhfcLAv/Do4ROFV8AxO/e1ZeD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608145; c=relaxed/simple;
	bh=nB+jmAHxPZ3soQmc5wLgDtK8Av2gzHEq4MFA/UQ0nAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cxwLrXLNF1lX/lP00AIuIhdVrtGlNqPgf9hfmhhpeP1sO9a8n6Aabqoi2KzdWuQ+IpVIKf4/OiqvVDwqcz0+jkLYqvaT0xtSXKcBk2OW8/+G2+mOi8retCuXUU2ff2l24aq5PSjb/SwWZP0CJaHZ7oC+TwhKBV7hFI52NGsxx2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=2P7POLzv; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 49D992E08410;
	Thu, 27 Feb 2025 00:15:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740608131;
	bh=VgIwtkMZ00hXOGNLHlqyEU83xt25hqz8jtzstHZ0Rbo=;
	h=Received:From:Subject:To;
	b=2P7POLzvQF3ldZmQNpUlDEFHdn0IgH8qKgCOmnUTM3OVCKMov+Y4ix8k1TuzJyKjF
	 ejkfIwUpm63e0H48uLRXS7s1dQAeVlAq976pudNSQglUvw/Zg0cfvQQOkmus8pqsGi
	 L2iqIYJ0imAwPkR4RlhEaJ4ytgCMtfQ6j6kdcBh4=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-30613802a6bso3677941fa.1;
        Wed, 26 Feb 2025 14:15:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWC/VeId7UW2g0rq3aKHg0Dbwo8w+1i8hvXGSCgLaINgtUizuL7yCaoDcHWuU6ikhzWEQuBSJnIIUzqpU3vQ4l30NL0jw==@vger.kernel.org,
 AJvYcCXFb1Z5hxbFf0PJNBvvHd4C7UUQIxBPrQ0faAF1f7vLMqAtDC7qcidA6ApVWl/BslS8b0ZIWUKIGmAS@vger.kernel.org,
 AJvYcCXh1Ug0b9tAHmHAUuDmyXarW+ebGELeyH+S7D0Lp2JXOYLJE2KUMP865YBwBejckuwaBOUHi7BT7uSTPO+F@vger.kernel.org
X-Gm-Message-State: AOJu0YyqtzEVj4qHg4EZvAUrxz6WgGkrTa0IqzNlM8kFnrdnnvLA5ze7
	NyzMj3S7ikiv1cPUlZW21vBw8McAoij+XklJxFhWeRXORcejmWA/Qio4X2rGB7TDKqw7YEaJu/U
	xAcKJXzmfI7eq44RH37qwbABImUU=
X-Google-Smtp-Source: 
 AGHT+IFg4wyGK6VF2wjPjpIZ8OKnRzWWaJZk6o/Gjb7Is6KTQDwhUqgOfMyd55qPLWosSWcc5Up9ckS22GBNFVqu8cQ=
X-Received: by 2002:a2e:968b:0:b0:304:68e5:eabd with SMTP id
 38308e7fff4ca-30a80c0f0admr41386401fa.3.1740608130090; Wed, 26 Feb 2025
 14:15:30 -0800 (PST)
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
 <CAGwozwHAKbR4y9cW8H0nmESS7yv6RrXtgcZyEdz1Wy2e8tAdqQ@mail.gmail.com>
 <CAJZ5v0ihavOHCzfqMc7nd7HUaxYta7-vBBTo6WoJ3gDduZ6iRA@mail.gmail.com>
In-Reply-To: 
 <CAJZ5v0ihavOHCzfqMc7nd7HUaxYta7-vBBTo6WoJ3gDduZ6iRA@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Wed, 26 Feb 2025 23:15:16 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwEkGDfhUoCSM6eA-1QN3-pCixT-YVPBNY4bLUZYxvff8Q@mail.gmail.com>
X-Gm-Features: AQ5f1JqPcnpjoEwypmX0Ot_L-bCpE2CHv_Ze7HXHX5i7ZuRYsRKVxaYGbPY5yHs
Message-ID: 
 <CAGwozwEkGDfhUoCSM6eA-1QN3-pCixT-YVPBNY4bLUZYxvff8Q@mail.gmail.com>
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
 <174060813166.13020.1806907721096684722@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Wed, 26 Feb 2025 at 21:04, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Top-posting not welcome.

?

> On Wed, Feb 26, 2025 at 8:52=E2=80=AFPM Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
> > >
> > > What about adding "quiet" as a "hidden choice" to amd-pmf such that i=
t
> > > would allow the test_bit(*bit, handler->choices) check in
> > > _store_class_profile() to pass, but it would not cause this "choice"
> > > to become visible in the new I/F (or when amd-pmf becomes the only
> > > platform-profile driver) and it would be aliased to "low-power"
> > > internally?
> >
> > This is what this patch series essentially does. It makes amd-pmf
> > accept all choices but only show its own in its own handler and when
> > it is the only option
>
> No, it does more than this.

I would say functionality-wise no. The patch could be minified further.

>  For instance, it is not necessary to do
> anything about PLATFORM_PROFILE_BALANCED_PERFORMANCE in it.

I do not see a difference between QUIET and BALANCED_PERFORMANCE, any
driver occluding either causes the same issue. Severity is debatably
lower on BP though.

> The structure of it is questionable either.  It really should be two
> patches, one modifying the ACPI platform-profile driver and the other
> changing amd-pmf on top of this.

Ack. I can spin it up as 2 patches.

> Moreover, I'm not entirely convinced that the "secondary" driver
> concept is needed to address the problem at hand.

Any suggestions on that front would be welcome. This is just the way I
came up with doing it.

Best,
Antheas

