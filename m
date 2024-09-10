Return-Path: <linux-acpi+bounces-8221-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0B9741F5
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7938A2865FD
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFEF1A2C03;
	Tue, 10 Sep 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soILf2rC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5119ABCE;
	Tue, 10 Sep 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992482; cv=none; b=CHelmSF13EeOSQV6quSSBuoZ60/EPseJwOOMqUbu3/kNtDH54dGC9Qo89qcTY6DLr9H6QlCZOGXgzk5dDD09JFUBPalt20Y7r8EKVpfTTVNyNho/E/EwovI20CGFW9+amOSWWXcg34bq7wnIGBM33th4mj6LTuclHkq860sV2jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992482; c=relaxed/simple;
	bh=XGVjzIwXx/MBKVS4XKg2/d1fcKV0d41Na2ukA57BKQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9K44Je/WRac+aa+Vtoa6rMhUeyM79YaccGhLkfuxlmvRpbKAGQ2I0qM/4WtwhbkWHRzqr1d1rUHtHMkBNcj3LxBk+6Cuo8PlAgK6Dy+1N4JvlIapL3Ulz1iXtSe15rvrScY0KpexO/XygPJbmgmXwFE0H3RTS27crb8kx61tyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soILf2rC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB0CC4CEC3;
	Tue, 10 Sep 2024 18:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725992482;
	bh=XGVjzIwXx/MBKVS4XKg2/d1fcKV0d41Na2ukA57BKQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=soILf2rCLJC2h2Q4ntxwMhL54XEYmZ/cmc9z9wLKZ1i2mfKtqT1NOBQHIMgqAwY/N
	 5LbJS1MAAq1KA6VR7U3M3PNUCv1OkzvF5LQHSXuAK4fsQvdxdVoygVlQWK1MvUX6ri
	 ixJP7KddkW58S+w47n+6cwFd35FskXDTUIs1McL1/M+wz71zixma3zqCcdaVV45fQM
	 Cz3lLy8FtLdg+4cxBIA2adJRR6VTIC1Xe/ZdiEu2fQFTwU+Ew77vINPgNOVqUihXI8
	 wqlYRe6zAKgf/5urrgfsPCF+JWhuDcwrBYyyJOzeI1D2ZYnrH/LFJYtPGinr1xNrmC
	 RHLYbjJGpHGiA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5d5c7f24372so3507771eaf.0;
        Tue, 10 Sep 2024 11:21:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAR3oYEcfr8C0JoTJgYzpxBI/XNEVskl9IRBvrOJVWLwUCu5jiJMAdgK3lkb+MRM1us4Wyykr59KYm9TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2m4ib6XAdw3OCBVpwJdBw3ipDCatJBs83Y8PVfS8EANzPWao+
	x7EPYHRt+oPhy4eE847qwOdenO1qjNOybPlWkLbbfWJW5qEraGWwvWi00OIHrIkxw1U06K72it4
	QrPKHPZ02N2ViIa+1fFAkskWsVS8=
X-Google-Smtp-Source: AGHT+IEyhUtg2FFEJz7J6hwQ+scQiYyh2ECDWz2vcQf8fjkqrHoXwi4n7Nbv4ToE33FuL1PzzeSd33ZhsTwC7QhyUF8=
X-Received: by 2002:a05:6870:3509:b0:278:234e:6e42 with SMTP id
 586e51a60fabf-27b9daece08mr6612853fac.36.1725992481598; Tue, 10 Sep 2024
 11:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908053607.4213-1-luke@ljones.dev>
In-Reply-To: <20240908053607.4213-1-luke@ljones.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:21:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ii=P6mW2DFz0wNw2_nRYEe=ts+T=_pZvnV9aLoMAp-DA@mail.gmail.com>
Message-ID: <CAJZ5v0ii=P6mW2DFz0wNw2_nRYEe=ts+T=_pZvnV9aLoMAp-DA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Quirk ASUS ROG M16 to default to S3 sleep
To: "Luke D. Jones" <luke@ljones.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 7:36=E2=80=AFAM Luke D. Jones <luke@ljones.dev> wrot=
e:
>
> The 2023 ASUS ROG Zephyrus M16 can suffer from quite a variety of events
> causing wakeup from s2idle sleep. The events may come from the EC being
> noisey, from the MMC reader, from the AniMe matrix display on some models
> or from AC events.
>
> Defaulting to S3 sleep prevents all these wakeup issues.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/acpi/sleep.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 889f1c1a1fa9..c8ee8e42b0f6 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -351,6 +351,20 @@ static const struct dmi_system_id acpisleep_dmi_tabl=
e[] __initconst =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "1025C"),
>                 },
>         },
> +       /*
> +        * The ASUS ROG M16 from 2023 has many events which wake it from =
s2idle
> +        * resulting in excessive battery drain and risk of laptop overhe=
ating,
> +        * these events can be caused by the MMC or  y AniMe display if i=
nstalled.
> +        * The match is valid for all of the GU604V<x> range.
> +        */
> +       {
> +       .callback =3D init_default_s3,
> +       .ident =3D "ASUS ROG Zephyrus M16 (2023)",
> +       .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "ROG Zephyrus M16 GU604V"),
> +               },
> +       },
>         /*
>          * https://bugzilla.kernel.org/show_bug.cgi?id=3D189431
>          * Lenovo G50-45 is a platform later than 2012, but needs nvs mem=
ory
> --

Applied as 6.12 material, thanks!

