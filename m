Return-Path: <linux-acpi+bounces-7954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3872E9642E9
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 13:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CC01F26141
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 11:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2569C19006B;
	Thu, 29 Aug 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQApt/2c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005218E039
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 11:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930574; cv=none; b=H1hmtnzXEoFQryRBjqtq8Ri0Dtmyrf+eKpydUK0iG2K3HlhekdnIUHE+Jv5Hkbmt2RyjjG8qfRMzavaUbBJYS57o0jYYAWeba4bf11TDrCcpzrMls1WES3ua2wqylW/AimpPFzAni7VhLfGpOu0ChFfK+Ui8SL8Vee5OJesYdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930574; c=relaxed/simple;
	bh=/veolSWLcmp0Z11C91AygYcm5wuX2AvVqZy7VlTZh3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geYoS4ZRHdf8J7L0c3eO99WdttY5/ZSh+rG3BXf1h1zq7kxtZB3wulARR2e5OUNUwF1JQ7Vtx36SXNMtkRd7KcFImQbyhThZA4NuE5dLfqJi6KmBnXGuKCUQcyY2CXx0x7ED+JyQ77o28LoAEmeQmzuPkfkyoke3G/epqykjXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQApt/2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F2FC4CEC1
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 11:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724930573;
	bh=/veolSWLcmp0Z11C91AygYcm5wuX2AvVqZy7VlTZh3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VQApt/2crqgwZu4Mfc8uASUAPr8GK/lnaq57xTUcFXK5DzG3xcCvpC7P1TcBA1cLp
	 J3lwmycA10dvlOwhScwzjmCfGSURXRLWWDW2N/AUYouXE/68LxGAtxFk6VOs+Kd17I
	 Np5MGhVZTs1uOyfEzydDW5VMP5vNxH4fr1cCpBBbXj15+TyV75ILy/47DxPvdQJTNx
	 6hJrT8jpM8aOTGo9uyKoEJNRaXh8Exyj/G+mfWij/xB/NegiFmuLMLcFHl1/hH9pL+
	 Q37hQf+e0Zh2Wr+rWqg0dbR0ieipuBvxl8M2BrgrHzpk69uLPO1JyRo9amjo+C4iNB
	 JK4XXil53jX7g==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3df0b748e08so162788b6e.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 04:22:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWRE6Sdl9ayB1IRWavAzQFFFWbuMB5lFUcIdlBARucO/kVNirWkQhCx954djcacXERRExnPcBn4pNLp@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKNRy9xloGGOyuyxqrNNvlB6L8xol2C+oVbVUMFAVdtGjETaO
	hEKYoVS5+nEkqiuh2fVznodKUm71O6GYV0odT6ynjDyYI+m7bCpc6KIsneiWVLUrZATqRiW9JFj
	PSV+uE7vON+85CLonVYU6wGTRqAY=
X-Google-Smtp-Source: AGHT+IGz6swHLLPinURwfgHpK3jX+62iGrohYfxfAkQbMqn+mtOsN6NU42gl/j4ZQVjHzFbdVUOsCuQ3y0Ioff3p8AI=
X-Received: by 2002:a54:4e81:0:b0:3d9:2baa:9fd3 with SMTP id
 5614622812f47-3df09b55016mr375051b6e.20.1724930573159; Thu, 29 Aug 2024
 04:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825132322.6776-1-hdegoede@redhat.com>
In-Reply-To: <20240825132322.6776-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Aug 2024 13:22:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0htPD7N0ySrwrqbz+fYZmKP9FAz2tfwFET-2sgNnsqv_g@mail.gmail.com>
Message-ID: <CAJZ5v0htPD7N0ySrwrqbz+fYZmKP9FAz2tfwFET-2sgNnsqv_g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: video: Make Lenovo Yoga Tab 3 X90F DMI match
 less strict
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2024 at 3:23=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
> turns out that the 2G version has a DMI product name of
> "CHERRYVIEW D1 PLATFORM" where as the 4G version has
> "CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
> unique enough that the product-name check is not necessary.
>
> Drop the product-name check so that the existing DMI match for the 4G
> RAM version also matches the 2G RAM version.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 674b9db7a1ef..e33ab5a2f489 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -896,7 +896,6 @@ static const struct dmi_system_id video_detect_dmi_ta=
ble[] =3D {
>          /* Lenovo Yoga Tab 3 Pro YT3-X90F */
>          .matches =3D {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
>                 DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
>                 },
>         },
> --

Applied as 6.12 material along with the [2/2], thanks!

