Return-Path: <linux-acpi+bounces-5545-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC98B807C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 21:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40241C222D5
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE7D194C96;
	Tue, 30 Apr 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWLQ9lko"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1777710B
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 19:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505032; cv=none; b=PmgY+6uS2p9qRKdVmJamwviOliuxPpEXbtDvffvzlJfT8VKbq1wvA/Da1JSmqFMxLsg4ugFxdCZb4OTg2M9T8HJjlbT3S7kUjanIEHygBFr2X3f6ybwOj5kYCfcqMDhB59brlVKkpGLVkJLjOMfwSn5hs49tqXWyDjyvjFG837U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505032; c=relaxed/simple;
	bh=eZ1a3+HBFQ+20Ko51ORkFileiF8TfO0wYgb1T3c6F8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F74ELxDVKVz2lFrELn73/DsbwAnHMEKIj82Z4np3e2ltjmAzUcYwry0PPIQ7LYaAq83yGBzAb9fiJJbPOg7e6WuKQtfvXYCIzQiVbrspO7P5pV0/Q/4S4v4vuZPbT4/MBl5UoRo3KM9FdDMMqySQFC65MHABMezKV7voLXYqZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWLQ9lko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67535C2BBFC
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714505032;
	bh=eZ1a3+HBFQ+20Ko51ORkFileiF8TfO0wYgb1T3c6F8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SWLQ9lko0q2GnN1Er1LYy1++Ou6ThUJP78fC84GqAMlJbM5ox/LE8wFRrEJAkKdHv
	 s9e5fxdCZeEaI0jpvK7P/T2jIkRMP8aimt7sELbSgX2Vp/1lAQVfDFQeMfd6cyXj5L
	 KLI2mQtV5Pfzo1TU0SpNPIDUp5AUstv6ouuSSTFjsg/ldoabec4lj7WAWf7+AMjo7q
	 oboPGt7mGVJXFm9k9p088YYcW8O0srCPkRo/UWcORz/XGQibMqYcKqk2DGvbzxxMXq
	 7XCElHCDadllpjjQzj5CxQyo3KOjBZVPbZyCHplzrjEyvdDFlU7nIwjKf2w2SGbgJ0
	 rsdXlwfDiWJjw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5acf5723325so1536493eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 12:23:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yya38rAwZlqLtnPPQNGVDZ9wtm9k2I1osJIP5iJLvZeep7Htqz1
	K6N3Iwg3AUHlgQXCrx21MHJWmBBd/g0zkEdto5lKnJc0mkVlFsuYMPLFk1br2sEhxbIflgjifsA
	v98YbXsSE94hDc4o4eGgiybQqObk=
X-Google-Smtp-Source: AGHT+IGsiOwkUuqWg4lSoUDrMUJvX6OYOuH/8rRHww74lqsP0QGZlGpUha/OBDMBa6/O1G1THL7xz6RvZyFtQ6HPNG0=
X-Received: by 2002:a4a:2546:0:b0:5a7:db56:915c with SMTP id
 v6-20020a4a2546000000b005a7db56915cmr349261ooe.1.1714505031383; Tue, 30 Apr
 2024 12:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428170841.487584-1-tamim@fusetak.com>
In-Reply-To: <20240428170841.487584-1-tamim@fusetak.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:23:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jrw0frQPcMF94SWOSD=J4ktFyTo0jc1kuBKTsiHf-+Wg@mail.gmail.com>
Message-ID: <CAJZ5v0jrw0frQPcMF94SWOSD=J4ktFyTo0jc1kuBKTsiHf-+Wg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MV
To: Tamim Khan <tamim@fusetak.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	Gianni <gianni.casagrande.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 28, 2024 at 7:10=E2=80=AFPM Tamim Khan <tamim@fusetak.com> wrot=
e:
>
> Like various other Asus Vivobook and Expertbook laptops, the Asus
> Vivobook Pro N6506MV has a DSDT table that describes IRQ 1 as ActiveLow
> while the kernel is overriding it to Edge_High. This prevents the interna=
l
> keyboard from working. This patch prevents this issue by adding this lapt=
op
> to the override table that prevents the kernel from overriding this IRQ
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218745
> Tested-by: Gianni <gianni.casagrande.mail@gmail.com>
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 59423fe9d0f2..23d6f5d4206f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -517,6 +517,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "E1504GAB"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook Pro N6506MV */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
> +               },
> +       },
>         {
>                 /* LG Electronics 17U70P */
>                 .matches =3D {
> --

Applied as 6.10 material, thanks!

