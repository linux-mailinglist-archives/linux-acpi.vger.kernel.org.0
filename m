Return-Path: <linux-acpi+bounces-20907-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA/9B+/giWkKDQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20907-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 14:28:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86B10FB04
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 14:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A4AD301D339
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 13:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D05A37882B;
	Mon,  9 Feb 2026 13:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBOIE+S+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED928378815
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643516; cv=pass; b=Ly9FQggydsIVovs0+RVaOUNsEl4+WsWt2D4aFCFmvLdYG8LkQqgLGj9JK8WO4FEJoKXiBvSlEI78Qkz9ccNxsMQGXPeE5mQQHeylS4T54F2BeqUaSGlJnioJlshNFudEbTlTqtXDjnu2rX1lt9KKtckmxENN6mUZqMd6ZXI9nOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643516; c=relaxed/simple;
	bh=I0kT/5gQP7hegeGg5e5RlenRbFh1Bxpc+bwQQS5s/UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNBAthG5sfzsfxFzbYvKk+u2eNUOpF8a/JW2u4msFs7YkegXV1nQF982dyYXio63lXWCgf2/8OVRR1TmFOu2eBo1HA91X3KlK8wy842uIoUszocmkE8VjwOB1kZEn565DRvIp+BZPvsyoX/6rJ1sviOCqihJjG1G2kmxl4cNrno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBOIE+S+; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b885e8c6727so443257666b.1
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2026 05:25:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770643514; cv=none;
        d=google.com; s=arc-20240605;
        b=lg/3S3vsiRFiIqXLBXleQTfcfqlRe/mnUxj16+JDpZ9l8hvGozZ2/Etn7TOdNBBKHj
         b+3aL3UoJeTFiEWfjAMIHQgN+9MtVNygt21eBaCwQA1wlJhyVugKPB/yvBpBhSKPkcSp
         H6VQSZXcMX6gVi3WjaVqlpmbwLCTVkxNwkVq1ySI3lLrV+ImyK8d+06VLXWp103c40SP
         qwpFXqPJpJDtKZOgzc8gHPvmRQ62TwmRY8/l8JaZogfcolotdgaShLElL1hsrVzOtN82
         30sRIjR7zJw1t/mR8z6cYrEvy0117Q/81xfeiY/67hMz68aZ/CeP0qZ96p2XLlev5APO
         pe5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I0kT/5gQP7hegeGg5e5RlenRbFh1Bxpc+bwQQS5s/UM=;
        fh=spVY/wElbvMvdBcYyKOv2rpXNkNmnCtW3Z114sir+qE=;
        b=Ljc9BgP64EF946fPLHDffOo6PYeS029BSzPaxIsfQNu3FGQfFnHOpG26/hlh4W4DhS
         QAMKR23nrLrIrCqLqbnjS9tpT+KiJoxcNOvSeL0HOPfhRw7nMEZobjURt9xEYC/tJ4+F
         H0oCBm1rQlfnUQM33ctJ4qUZFk+0w8TJMLPc2/tCEbsoPT7AJyFmQ5MoEIAhz+vs0vGY
         hRVp7wKzvPzy5NMAg3f6pY6gvRIxBVsul0Q+zlhteFfv+Q2OI5m2UCzdgUt1q6X5mBbC
         rkTIwk2Mv0ZyUPHGGDDAn3J5jMCVw6Z7cqmA75VvmlOy4Qoo7UFebCUc+oLtHB/bXgUb
         BMTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770643514; x=1771248314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0kT/5gQP7hegeGg5e5RlenRbFh1Bxpc+bwQQS5s/UM=;
        b=QBOIE+S+s1+sWKDWzOHhHkg9e3xrmsYj7FJOP+KUgqbVr8CRu45AmiXcOXqvqyDuQm
         3RBNsmN+d5RdWyILA4+UQ0MLmIumDsobyc0s7AzikNJBAbe8jDvuxpuA8hjXqJJ9gDjp
         3tVOo9085E2/lAR9bo3krK679EgG+hkh2xUBzIUV/feNUCrf/4hzLQ/psv0+ry4ybGSU
         hZp5mI7Gx7e/HKrzFFGU0Q1hDzUFtn7azlhpDOrsfJazaKFBP7yJ0iLOKRYANIIHejNW
         2QF8BBHkxM1/2ANEZzXoUhX5cOHg0Jj70hRPQPbeg6g3uTn9rTwfaxdAbb3bVZ8gJgZk
         CAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770643514; x=1771248314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0kT/5gQP7hegeGg5e5RlenRbFh1Bxpc+bwQQS5s/UM=;
        b=t1e7PuAJzgP5UMBHOx6oL84DHcrf+ERkuyIMx3tmKXm2h23hZ6w4f3WSgRE3MwgsFA
         QIhosOs2R9resRTeh9YTOV7Rw7zEkV+ehw4XRBzbkRRmXE2hIDWF4SbxgQ0XGN+FwJRK
         7zIqonsRdv6hmGBSdmT6uS/Jf1L46b6waKPMIczSs0CMMtRIN2/MqCS4RjQlO7NRrYs/
         U6CSNZ2Zpw6mIZk+6c/DZFDFe4gipeKgLYK/EZLTpkQoRx8sRi9GCBuHEBokDPZINM7d
         Q946j7NR4BMJ+VJEmFtXTH8VcQJZMrVDGqKceziV5a+JmzfMUFOI9ao/gSkn86hd6j/w
         cknw==
X-Forwarded-Encrypted: i=1; AJvYcCUfQ8pqi34ZukAoxuPIgPpYw6iR+USa31e1BK1c0BGqamkF4uTGWGrP/BDTd7MQy+3zcsQCfN0Zow8A@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1WhTBmx/IRSkRzJgFHECPfIycy2PA0bLPcpj053T42gphdHP
	FnGog0VEZwEEMnoZj6LrjqfIHLiuDuz2WYYqqyvPipf8ddUqn+v8gn2UL8armV1fXpNesfejBVU
	ONdjyD+k36ALwVbYp0VuAZNi8RpJRr0s=
X-Gm-Gg: AZuq6aLboHvCOBBZMD0AHEHAFi0KaXYrGzhw/P06Pq8OWr30Ufx92ek+897JdqoKr47
	SReKb5t4+sL8+JkeMsR39JW69Wpo4D7GzB8dE2sm7x8wHDI28aTEPjFE/UZAzUr4OeBoyp1mc73
	qZmsoxIPrZHzZosy2m5EoC2xBVQFtSFNIoQx9dWKlvGNtdjch+RboTjX+2NE0kUlD28HOqthosw
	2i+V5OzRyfmEqakl7vTMvhOJqXzGQEQrkOY2LrPA5TwLMBR4q4TeKbL5B/Qy+wNPRltA/CXTeTT
	z4dJ9Uo=
X-Received: by 2002:a17:907:3cc2:b0:b8e:d4ed:5ed8 with SMTP id
 a640c23a62f3a-b8edb9adc12mr649043966b.19.1770643514004; Mon, 09 Feb 2026
 05:25:14 -0800 (PST)
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
 <CAMRc=MeYEoiXWCdYNSmmbquMwmt99vPgzW+0gmX22Of9o127+A@mail.gmail.com>
 <aYmBYlEcbVJ2ELZ_@google.com> <CAMRc=McVrhxA2WuUDxn+dWziug-GyJkazYZyDJ6qFkj7o9xdEQ@mail.gmail.com>
In-Reply-To: <CAMRc=McVrhxA2WuUDxn+dWziug-GyJkazYZyDJ6qFkj7o9xdEQ@mail.gmail.com>
From: Yauhen Kharuzhy <jekhor@gmail.com>
Date: Mon, 9 Feb 2026 15:25:02 +0200
X-Gm-Features: AZwV_Qi65eUt9PrDI6DGksyux3YxGvBaXIykhTNQbqZXW_sIubyYDEhQoM67reY
Message-ID: <CAKWEGV5_u-kysd0S+CN_TtwHg_Ekp+jue87d4R+QuYzJKssTxw@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20907-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jekhor@gmail.com,linux-acpi@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,opensource.cirrus.com,linaro.org,linux.intel.com,linuxfoundation.org,kernel.org,pengutronix.de,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6F86B10FB04
X-Rspamd-Action: no action

=D0=BF=D0=BD, 9 =D1=84=D0=B5=D0=B2=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 14:38=
, Bartosz Golaszewski <brgl@kernel.org>:
>
> On Mon, Feb 9, 2026 at 7:44=E2=80=AFAM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > On Wed, Nov 19, 2025 at 10:13:30AM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Nov 19, 2025 at 9:41=E2=80=AFAM Bartosz Golaszewski <brgl@bgd=
ev.pl> wrote:
> > > >
> > > > On Wed, Nov 19, 2025 at 9:35=E2=80=AFAM Bartosz Golaszewski <brgl@b=
gdev.pl> wrote:
> > > > >
> > > > > I have an idea for fixing it, let me cook up a patch. It'll still=
 be a
> > > > > bit hacky but will at least create a true link.
> > > > >
> > > >
> > > > Scratch that, I didn't notice before but we register both devices f=
rom
> > > > MFD core. We can just set up software nodes there.
> > > >
> > >
> > > Here you go: https://lore.kernel.org/all/20251119-cs42l43-gpio-swnode=
s-v1-1-25996afebd97@linaro.org/
> > >
> > > Please give it a try. This is independent from this series and should
> > > probably be backported to stable.
> >
> > So think breaks more drivers:
> >
> > https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
> >
> > I think it may also break:
> >
> > arch/arm/mach-omap1/board-nokia770.c
> > arch/arm/mach-pxa/devices.c
> > arch/arm/mach-pxa/devices.h
> > arch/arm/mach-pxa/gumstix.c
> > arch/arm/mach-pxa/pxa25x.c
> > arch/arm/mach-pxa/pxa27x.c
> > arch/arm/mach-pxa/spitz.c
> > arch/arm/mach-tegra/board-paz00.c
>
> Most of them seem to use software nodes correctly. Nokia 770 could
> potentially break depending on the timing but the lookup uses the
> right string.
>
> > arch/x86/platform/geode/geode-common.c
>
> Looks like a correct case of referencing the software node to me.
>
> > drivers/platform/x86/barco-p50-gpio.c
> > drivers/platform/x86/pcengines-apuv2.c
> >
>
> Same here. Nothing here seems to depend on a label and there are real
> links between the GPIO chip's and consumer's software nodes.
>
> The problem we triggered here was caused by a GPIO consumer who would
> create a bogus software node locally without any real link to the
> provider. It would then depend on the provider being named a certain
> way to look up its GPIO. That doesn't seem to be the case in the above
> files.

The driver drivers/platform/x86/x86-android-tablets/core.c also
creates fake gpiochip software nodes
to use them in PROPERTY_ENTRY_GPIO definitions (see
drivers/platform/x86/x86-android-tablets/lenovo.c for examples).

I use the same approach for rt5677 gpiochip in my changes for Lenovo
YB1-X90 tablet (not mainlined yet) and this is broken also now.


--=20
Yauhen Kharuzhy

