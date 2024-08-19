Return-Path: <linux-acpi+bounces-7665-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3C8956C85
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A141C2168B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E9416C857;
	Mon, 19 Aug 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCD5a4Sn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B416132F;
	Mon, 19 Aug 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076013; cv=none; b=tYT5MaMT01VMCycalrbdsukxqkxbXHMZ80t6DYypCaL+y3JeI4OaFManHsy3AlIQagwPJFpVwLysCZ9O9A6V8NEByYQXN8rkIdUzS/+6QTzHVP/9i3IT4wUmIrkCzlvN/n+iOr+m0uQEyjFEQ8fibSZABKp/gqUhByJHNnpVB2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076013; c=relaxed/simple;
	bh=3WLrkjUnr9LlqLwIEsGZ1N/7WjLoqXupEz/SOJAYq7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGgsI4+7+ANO43OGFS5rPxOQDOC6w2LM+vahOmpVZECMuwqANV2Rk3YG9Ge5hIEg5D4NGqbWBeGqb7RRGrMklOiNCNRkDeA3WdfouPOHVbZE9Dl4joRCJ98jkzFkbT91LDXpUXgEV/DnRZP8Mnf8Fp3E+e4vtso1C6DeyPxjSYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCD5a4Sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6E3C4AF0E;
	Mon, 19 Aug 2024 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724076013;
	bh=3WLrkjUnr9LlqLwIEsGZ1N/7WjLoqXupEz/SOJAYq7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pCD5a4Snq+pWCR43HGybi8uhb2LTCbbEvx6O3waFOhlXCpJLzdC0UViD1vKV09t0P
	 V5Sg5/E7BQIx3TwBkSdLTRgW61hFqdrptnuFepUPXuk1J64GOPLJvxpBa9VwUHX6VT
	 FDmyrU6vLYSBrjH/QMwqj4kNAM2ouwnhvZA9ksfWCmyOSj0+6eJECEPM6mPBGsRMrW
	 4xawj8Oz/c+NdE5Gr/1ZhVlK88/WrwMgju7m1iYzbsRfcLNREwW+Pxs5vDfZH2OqZA
	 jCCKhXLeOr4g7IquP2YC213u0pmbgkdEodxEupOaydx+PK2wddFIvUHtWTh9buiQ6M
	 u9pMwxGxdC7Ag==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2635abdc742so545345fac.2;
        Mon, 19 Aug 2024 07:00:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXqfIHR7e0jDrPTjSKNmob67aHelgDUU6Mge4uKltUvOkPWcCDUHHzWRHOilPW7dXWXuYyAHhkCBdE@vger.kernel.org, AJvYcCXyJeBnCZnaylLMKZmKoduf9GtkChaPEObB8xjnr+WYIIFZ+0+gfT/JOUsPTbuUx+1+p2agVZGWw+VnyeYrVwCkLaNS+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWz5e6sASVKspn0dYYTcncN2PIb60J8nYO9NJ0Tva1pvrltD5k
	9vc1H4imZmxw5RQCwZMNPvJ39l+vK4+HZ3p0KE+CZsjJahGGNRpE3rmGzRlvkpZuBckOaO1GJAd
	VwjYLtiaEHU1Fk1aOAdR1G5cyoJU=
X-Google-Smtp-Source: AGHT+IGcDoqLgza7vPj01i2Jw/Z7VOE0538tkQpE47TOLRLTY+IvwaqIwtPPkILmDyaquWJA0iDPj0JncgUYV4+fWCM=
X-Received: by 2002:a05:6870:ecaa:b0:260:e5e1:2411 with SMTP id
 586e51a60fabf-2701c50f7abmr5632480fac.6.1724076012360; Mon, 19 Aug 2024
 07:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814190159.15650-1-hdegoede@redhat.com> <Zr0PD5d2bqpikxf_@smile.fi.intel.com>
In-Reply-To: <Zr0PD5d2bqpikxf_@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Aug 2024 15:59:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jLe_NF5+2RQanyPWng9wYXEtuxcTrapcW8QX-wshjm5g@mail.gmail.com>
Message-ID: <CAJZ5v0jLe_NF5+2RQanyPWng9wYXEtuxcTrapcW8QX-wshjm5g@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI/video / platform/x86: Add backlight=native quirk
 for Dell OptiPlex 7760 AIO
To: Andy Shevchenko <andy@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:10=E2=80=AFPM Andy Shevchenko <andy@kernel.org> =
wrote:
>
> On Wed, Aug 14, 2024 at 09:01:56PM +0200, Hans de Goede wrote:
> > Hi Rafael,
> >
> > 6.10 has a new backlight driver for UART attached backlight controller
> > boards found in some Dell All in One models.
> >
> > Now the first AIO has turned up which has not only the DSDT bits for th=
is,
> > but also an actual controller attached to the UART, yet it is not using
> > this controller for backlight control (it needs GPU native control).
> >
> > I did not tie the dell-uart-backlight into acpi_video_get_backlight_typ=
e()
> > yet, so the first 2 patches in this series deal with that and the third
> > patch adds a DMI quirk to select native backlight control on top.
> >
> > Backlight control used to work on the Dell OptiPlex 7760 AIO with kerne=
l
> > 6.9 and older, so this is a regression and I would like to see this
> > series merged as fixes for 6.11.
> >
> > Rafael, the drivers/platform/x86/dell/dell-uart-backlight.c are small
> > and isolated. So I believe it is best if you take the entire series,
> > to avoid conflicts if any other drivers/apci/video_detect.c DMI quirks
> > show up this cycle.
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> I find this quite small and I agree this would be nice to have as fixes.

Applied as fixes for 6.11-rc, thanks!

