Return-Path: <linux-acpi+bounces-11648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A7A4A325
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 20:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB83189BC5F
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 19:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9326E153;
	Fri, 28 Feb 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="B5Jc5dHn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BA2777E9;
	Fri, 28 Feb 2025 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772454; cv=none; b=J0PnhaP1wNSImd+0z0xUHZUuHD6TlIMY5sT14jbXdmi47NIvX4+hASYe5BuFYFb9tY+Yh/Bbth003NNsm2SBkEPyAcEHbmNskg73dy4rIuCNByahKzXqw6xbda5vemugl5YQ5OYbymJMl6Ni7VVAWSCOEuoxtWg6N/eao80ogw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772454; c=relaxed/simple;
	bh=xEvt8RmvhQq6+PWfXPb4XUbjyzGK/gBr+PGFTRFZqwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eC4fDvIXCKOmS5zGj4HFbm9oQUlGcCVSGTHzjg6EIh+V/PSModwTeO3LDAy6KGAmCq9RSLpiKcz+LXhktKKWoM/Xy+0XME+/K9e4OELi83LVJPN07u84IH5kp78Gst0VqD9MoYC4xWytSjKpRKMfp3SNrQhHZ5z0AjVVTDyvSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=B5Jc5dHn; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 3B8F62E092AA;
	Fri, 28 Feb 2025 21:54:08 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740772448;
	bh=YpdbUHfsA2dMMnsvxHRYYC0oY+1nRduPyGar+LCMowI=;
	h=Received:From:Subject:To;
	b=B5Jc5dHnHkReqHvR+OLOlKp3UdXK8fOUDq+ruMHChmBPQklGNIB2ErvA9Oh5r054J
	 ERsQMGPWFRGALw6vTvYnQQH7FoQfqL/OslpG3TbpcnH83pWTOYLBY959dOtgfOu19C
	 mO06pHV7qWSVQvxChdlDd0uaAaVfhCo0puG1A43c=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.178) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f178.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-307bc125e2eso27236211fa.3;
        Fri, 28 Feb 2025 11:54:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVGzCjqPItMkTvWcY1tmKLrJN/jlI2W1RsOAAWZDaGlvKyZSsFEEUvGRuANiEi7uypp4DCT+eLLGDZa@vger.kernel.org,
 AJvYcCWC/sJ1ryeBMF0zBztY7IauGv2xmeFKMS9Rb2t0EZ3ZaD2UBLq9H8FSxHn1+3MFdL7vnoGWdZYGtX07qkT5@vger.kernel.org,
 AJvYcCXWLEhTnYBc+X91ncwFF9kSvqp7geByY/PXBrmghdQJv/wPKnDFM7PC8SNTe7QKLzeBMWtK+wk2oN1HMvv6tCOBt03t/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMhuDe1pm5yiTgkR6NZAD1vHO62n03Y8aDBD1ySb+s9mvUSfzq
	SHoGIVVyeatXpM4MPZwUyGsdoH9dmTqf+mPd29EjKBJuKAytikfr0b60IjOtHynmO4yYWmz9JK4
	XZRELsrOF/7D+TQOh6tYj1DF8L5U=
X-Google-Smtp-Source: 
 AGHT+IFY41pPONfFNIiD8gq5TywMhxArTqqH/mViWbGKvJWJYfkROZ63qFqHfwhkNGLw5TnECgbX7qE+prLH7nYiT/Q=
X-Received: by 2002:a05:651c:4cb:b0:30b:91df:de5a with SMTP id
 38308e7fff4ca-30b932f6d77mr14822961fa.25.1740772447480; Fri, 28 Feb 2025
 11:54:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228170155.2623386-1-superm1@kernel.org>
 <fcf58c76-2c0b-4892-96aa-c9b5b35c3e68@app.fastmail.com>
 <7d76a774-9dad-4c94-b4df-7c040e9dbc47@kernel.org>
In-Reply-To: <7d76a774-9dad-4c94-b4df-7c040e9dbc47@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 28 Feb 2025 20:53:54 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFGx4n8NccKOJf1Bf1k7P8t_Xd3R4SHeij+s6X=NqBz9Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpjHHFDtnn9aXmpBmTay-XmcAaah119wQd4UneC0A5lICl_SGqkOcUkI9s
Message-ID: 
 <CAGwozwFGx4n8NccKOJf1Bf1k7P8t_Xd3R4SHeij+s6X=NqBz9Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: Mario Limonciello <superm1@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	me@kylegospodneti.ch, Denis Benato <benato.denis96@gmail.com>,
	"Limonciello, Mario" <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174077244862.26170.11038858076254116498@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Fri, 28 Feb 2025 at 20:45, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 2/28/2025 13:39, Mark Pearson wrote:
> > Hi Mario,
> >
> > On Fri, Feb 28, 2025, at 12:01 PM, Mario Limonciello wrote:
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When two drivers provide platform profile handlers but use different
> >> strings to mean (essentially) the same thing the legacy interface won't
> >> export them because it only shows profiles common to multiple drivers.
> >>
> >> This causes an unexpected behavior to people who have upgraded from an
> >> earlier kernel because if multiple drivers have bound platform profile
> >> handlers they might not be able to access profiles they were expecting.
> >>
> >> Introduce a concept of a "hidden choice" that drivers can register and
> >> the platform profile handler code will utilize when using the legacy
> >> interface.
> >>
> >> There have been some other attempts at solving this issue in other ways.
> >> This serves as an alternative to those attempts.
> >>
> >> Link:
> >> https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
> >> Link:
> >> https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
> >> Cc: Antheas Kapenekakis <lkml@antheas.dev>
> >> Cc: "Luke D. Jones" <luke@ljones.dev>
> >>
> >> Mario Limonciello (3):
> >>    ACPI: platform_profile: Add support for hidden choices
> >>    platform/x86/amd: pmf: Add 'quiet' to hidden choices
> >>    platform/x86/amd: pmf: Add balanced-performance to hidden choices
> >>
> >>   drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
> >>   drivers/platform/x86/amd/pmf/sps.c | 11 ++++
> >>   include/linux/platform_profile.h   |  3 +
> >>   3 files changed, 87 insertions(+), 21 deletions(-)
> >>
> >> --
> >> 2.43.0
> >
> > The patches are all good - but my question is do we really need the whole hidden implementation bit?
> >
> > If the options are not hidden, and someone chooses quiet or balanced-performance for the amd-pmf driver - does it really matter that it's going to do the same as low-power or performance?
> >
> > So, same feedback as I had for Antheas's patches. I understand why this is being proposed but for me it is making things unnecessarily complicated.
> >
> > My personal vote remains that the amd_pmf driver carries the superset to keep everyone happy (sorry - it sucks to be the CPU vendor that has to play nice with everyone).
> >
> > Mark
>
> Well so the problem with having all of them is specifically what happens
> when "only" amd-pmf is bound?
>
> If you advertise both "low power" and "quiet" it's really confusing to
> userspace what the difference is.
>
> The fact that it's actually 100% the same brings me to my personal
> opinion on all of this.  Although I spent time writing up this series to
> do it this way my "preference" is that we permanently alias "low power"
> and "quiet" to one another and update all drivers to use "low power"
> instead.
>
> Granted that doesn't help the case of balance-performance being hidden
> that Antheas mentioned for acer-wmi and legion-wmi but I don't know
> serious of a problem that actually is.

Hi Mark,
So I agree with Mario here on that. I actually made the patch you
suggested last Sunday [1].

But then I looked at it and thought to myself that I can't ship this,
so I did a v2, which is what I sent on Tuesday.

My priority here is to not disrupt the existing ABI with 6.14. This
would allow extending this discussion by a couple of weeks, so a more
permanent solution can be found.

If that would be the case, perhaps my patch series is more preferable
as, since it is smaller, it would be cleaner to revert.

Antheas

[1] https://github.com/hhd-dev/patchwork/commit/aae724e8c90da3605bd131672fea07cd866af55f

