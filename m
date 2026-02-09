Return-Path: <linux-acpi+bounces-20906-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJVgOWjViWklCAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20906-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 13:39:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9219610ED15
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 13:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3435F300BD8A
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED86376475;
	Mon,  9 Feb 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NItwjxEI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C488371074
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640736; cv=none; b=oLPPF7RqrRzV9/iFqX5SfwaSeT2tdaBesY3KMMrHAdfTYSityWV0ecZ3J1M4hiPG/CIz50jLEgzL0dDRI89aVJ8Mabp4lugUNqtMth+O43jTEc68ezk18BhvFgdFD/pTC19ixv+pk8B79i1ZDyU17HzUb19kOiz/3HXyb0Nb/30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640736; c=relaxed/simple;
	bh=9pCCU5WsSbvzWudbbglgjxAmo0Z0Om2N/Zc5dAaXgWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIjPGeWcWcBqTaPAkUP8kbl767cjOMrISzVG7jMVlKMr335GZ4CqCq7qiciRugn0lxktgksjPtrWDOuxah2So4Vqn1uwqvp+W+0ViobJrQXkmASya30ewVjLRkY6OocAjHjqmewTnHBoQa77Tn7xjY+xJD1s/Mckcf8M8KOIGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NItwjxEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4301AC116C6
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770640736;
	bh=9pCCU5WsSbvzWudbbglgjxAmo0Z0Om2N/Zc5dAaXgWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NItwjxEIgKYHOvVfu4g2BPHMVijRaBPiwA8duVZz8soQ/3XCsKrg9gqdi88eGixpC
	 l8X8MOSOCBEIC5JOo90oA1LC4bDkp4uLeoQJhliyXiYktB9FQlXky+Na5T9MjhciHc
	 uEN04GEQ42yA1d345lp7s7CvT1YW9hwIIQOdiWZAv7hME8xYyrtP7peFfl0uKSB3HC
	 /b25xT0R6MO0bwSmc1Kd8TRNgB0Myh44bUxFSDRwbEeTT2LqaA0ZtxmvwKFGZo2isz
	 TrdlZpjJXE/PZ4LTSrgBnV7PkDt8DJlaaThj06KWHbYGdOAwT0k7BS1uD5RwgmKwFM
	 E77Mf49hFsGPA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382f9930e54so37478831fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2026 04:38:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVoFDbUflPtem4udBJpYqF5YQi0G/951c9vvPuGPKDx8/nCcfGCHlWJ5NiRp4MJDAOKUofBS78UxglF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2IACjgfGTgvm+exKevsMTcVHKQDEj4v0NibU8A2pBxVKQWGWN
	qQpdlW4WeGjjdNj0BChsR53xc8jN5OLgGfVQTlV8pgeRN2+2XFUbHYzR859/F2IaJX87cFXVxgb
	z2uxjZu6oGeaUyCuH8KpDbxEtGotO6xgtWR77f0lIxQ==
X-Received: by 2002:a2e:a816:0:b0:383:55ad:58e1 with SMTP id
 38308e7fff4ca-386b569675bmr34779211fa.16.1770640734921; Mon, 09 Feb 2026
 04:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org>
 <aRyf7qDdHKABppP8@opensource.cirrus.com> <CAMRc=MfD7ZbwU4akkCJNgmRPwgSOqSVi2-L2dJDOBHrfdD-yZw@mail.gmail.com>
 <aRy31U8EQA1DO/R6@opensource.cirrus.com> <CAMRc=MfNf+WMtSW=Wag0QHAaYzcRe9igrbOeRZiY92KmOH70oQ@mail.gmail.com>
 <CAMRc=MdKN4Uj4RZk=3L82c0-0Z0CihbAfzVK0zMBb9Tsjh3BqQ@mail.gmail.com>
 <CAMRc=MeYEoiXWCdYNSmmbquMwmt99vPgzW+0gmX22Of9o127+A@mail.gmail.com> <aYmBYlEcbVJ2ELZ_@google.com>
In-Reply-To: <aYmBYlEcbVJ2ELZ_@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 9 Feb 2026 13:38:41 +0100
X-Gmail-Original-Message-ID: <CAMRc=McVrhxA2WuUDxn+dWziug-GyJkazYZyDJ6qFkj7o9xdEQ@mail.gmail.com>
X-Gm-Features: AZwV_QhWrKnBVp75GDOvtMEizdhSMAaSxccMve2e83_gjIHMdK9qE4sfEseL-P8
Message-ID: <CAMRc=McVrhxA2WuUDxn+dWziug-GyJkazYZyDJ6qFkj7o9xdEQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, patches@opensource.cirrus.com, 
	Yauhen Kharuzhy <jekhor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20906-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[opensource.cirrus.com,linaro.org,linux.intel.com,gmail.com,linuxfoundation.org,kernel.org,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9219610ED15
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 7:44=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Wed, Nov 19, 2025 at 10:13:30AM +0100, Bartosz Golaszewski wrote:
> > On Wed, Nov 19, 2025 at 9:41=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > On Wed, Nov 19, 2025 at 9:35=E2=80=AFAM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > >
> > > > I have an idea for fixing it, let me cook up a patch. It'll still b=
e a
> > > > bit hacky but will at least create a true link.
> > > >
> > >
> > > Scratch that, I didn't notice before but we register both devices fro=
m
> > > MFD core. We can just set up software nodes there.
> > >
> >
> > Here you go: https://lore.kernel.org/all/20251119-cs42l43-gpio-swnodes-=
v1-1-25996afebd97@linaro.org/
> >
> > Please give it a try. This is independent from this series and should
> > probably be backported to stable.
>
> So think breaks more drivers:
>
> https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
>
> I think it may also break:
>
> arch/arm/mach-omap1/board-nokia770.c
> arch/arm/mach-pxa/devices.c
> arch/arm/mach-pxa/devices.h
> arch/arm/mach-pxa/gumstix.c
> arch/arm/mach-pxa/pxa25x.c
> arch/arm/mach-pxa/pxa27x.c
> arch/arm/mach-pxa/spitz.c
> arch/arm/mach-tegra/board-paz00.c

Most of them seem to use software nodes correctly. Nokia 770 could
potentially break depending on the timing but the lookup uses the
right string.

> arch/x86/platform/geode/geode-common.c

Looks like a correct case of referencing the software node to me.

> drivers/platform/x86/barco-p50-gpio.c
> drivers/platform/x86/pcengines-apuv2.c
>

Same here. Nothing here seems to depend on a label and there are real
links between the GPIO chip's and consumer's software nodes.

The problem we triggered here was caused by a GPIO consumer who would
create a bogus software node locally without any real link to the
provider. It would then depend on the provider being named a certain
way to look up its GPIO. That doesn't seem to be the case in the above
files.

Bartosz

