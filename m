Return-Path: <linux-acpi+bounces-4758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31C89C785
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373C3285869
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Apr 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FA13F011;
	Mon,  8 Apr 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqEpVgft"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D213F00A
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587934; cv=none; b=Zkx8VNRrJwIj+WHmutLe2SRj5S+dOirB6TaQDMSigIpBFcMzOxpCqthadWw1Dgn6BU/vjiH9nA4auAUwnScIJp3xFwG08SV1U+NfeTDkJjJ8InJShXMip5ZIxuQxs4GYU6iyy8+wUH5JR1pqaicb330oEqmqH02kt7C23PNYFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587934; c=relaxed/simple;
	bh=S+ta+94iqUiAQkHc95kv1N3GH9FZYVm8Z55B7DVEpk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+QhWgcz7ilBKmBDJi27Vx26cwIyoXr3jptuburBW5icVY+2KQpF+Ki+Y8zroMpnKGigYymlFv4y7rH7DLqadQfRcL09Fhse1VkYRVZxZvsTGBUim92b4JYIOW6E+iqSJiyMJIVPWGsb4UluLCtt7AIBIKXxbaGSivyjh2Tkme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqEpVgft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528E1C43394
	for <linux-acpi@vger.kernel.org>; Mon,  8 Apr 2024 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712587934;
	bh=S+ta+94iqUiAQkHc95kv1N3GH9FZYVm8Z55B7DVEpk4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oqEpVgftGohsHzP6mgjdcgKF4EYZBrDknF97PtMk+KifJnJ5mxStLNQiKgEOQ5LBK
	 BhuVXP4L97+gKffQj8T0behCIOzhbjL6xg+6SPit5hwmdd4qQ2ccx0JZIL14z8CYiR
	 Ay71mWwXFiv7wvbDiE1n5Mg4yznPHznua8obKvaNvVA9saeq2TxuYi/YrodR7TRras
	 I0qlMOrQkbEXfZeVveNiUJvJyR2n/n9eDdfpcx0g/Ddiu3qjvNY61xoZv6IXenEsZL
	 foysIGaFfv84E1qqgxsx1XQ/kuoWYAyY6RQ8cl2bqyBEjwh517T4h4iMtyf/KwRU9a
	 XzWK0+tqhvlEg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5a9c2045b8bso1046930eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 Apr 2024 07:52:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG6z0KufWLnMjXC9q92m6ez2ZijOq5LOygCqmCCK5X9r8J2uuucuYsbIfjl3n3YeJgu9RowxptkTLaoLvxvrFi6qI3NIxVkw27Hw==
X-Gm-Message-State: AOJu0YyfPQG3VrwzslEbCqSW6Tky9zTVNf1YgTwkKpd5Gj5x2Psq8+mn
	76XtJYyBHUgArwqm3fTMiayI2pElK3Hj3QWDpsmwEYpZfAOhb6OHeNij/ZagVF8e+k44ainzk6u
	9uxsWQShkwdRVduCmzqfhcHYJL7s=
X-Google-Smtp-Source: AGHT+IH9OJGCeSuDcNhjJEMyj8haSQHTXKN7U96E2tqDFdSMOyVFOx88D3PCj9TRgXoD05YdRV/8zADBk14h6MD3avg=
X-Received: by 2002:a05:6808:190e:b0:3c5:d7ff:1214 with SMTP id
 bf14-20020a056808190e00b003c5d7ff1214mr11010704oib.1.1712587933609; Mon, 08
 Apr 2024 07:52:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406135625.17118-1-hdegoede@redhat.com>
In-Reply-To: <20240406135625.17118-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 16:52:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iC14xtsqQMYDshdd-dwYv5Tb9fHWDMOskH+=TZsSHeyA@mail.gmail.com>
Message-ID: <CAJZ5v0iC14xtsqQMYDshdd-dwYv5Tb9fHWDMOskH+=TZsSHeyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: x86: utils: Mark SMO8810 accel on Dell XPS 15
 9550 as always present
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 3:58=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> The Dell XPS 15 9550 has a SMO8110 accelerometer /
> HDD freefall sensor which is wrongly marked as not present.
>
> Mark this as always present so that the dell-smo8800 driver
> can bind to it.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 90c3d2eab9e9..c7af2d2986fd 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -100,6 +100,15 @@ static const struct override_status_id override_stat=
us_ids[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Venue 11 Pro 7139"),
>               }),
>
> +       /*
> +        * The Dell XPS 15 9550 has a SMO8110 accelerometer /
> +        * HDD freefall sensor which is wrongly marked as not present.
> +        */
> +       PRESENT_ENTRY_HID("SMO8810", "1", SKYLAKE, {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9550"),
> +             }),
> +
>         /*
>          * The GPD win BIOS dated 20170221 has disabled the accelerometer=
, the
>          * drivers sometimes cause crashes under Windows and this is how =
the
> --

Applied as 6.10 material along with the [2/2], thanks!

