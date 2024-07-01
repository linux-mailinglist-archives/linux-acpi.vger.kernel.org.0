Return-Path: <linux-acpi+bounces-6716-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A2791E732
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 20:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869271C20D68
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8B16EB6E;
	Mon,  1 Jul 2024 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4ZHmqWE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481A16D9DB;
	Mon,  1 Jul 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857464; cv=none; b=lA3azq243xXUy6pZO9KAKP6lBfkFI0YA4HTY5haay9J2ymI0uFTaR4jQ8YCGy167R021IZGSLKyqgMob2gTQg4Ci8H5a001dTVjSqelx7Aob5p4FTn5Vb2bD/UOg81RAPYtIiMwSGkCx4s3MigyU1j+ZYK2McuFq2pbltvynSK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857464; c=relaxed/simple;
	bh=T1HHsQL1cp7GHIolyLrOtq44GdhsnKzNF5VI7774Res=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdlNQGDAyG6ycB93u3zHm2lARO/1XXpRJ875V6H6WR4YFIUktymoTwohXpw4tdLyShwBjwdMIot9ppkD7UCK90I1sp618wPJEmjBk9wvlzQiYyUPblVKCwn5V31LngeOOVpakzkeuYRjKSp9itijrF6S2c/TZ9GnoS/KZgO+kTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4ZHmqWE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A74C116B1;
	Mon,  1 Jul 2024 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719857463;
	bh=T1HHsQL1cp7GHIolyLrOtq44GdhsnKzNF5VI7774Res=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S4ZHmqWEjOUsO94b1suFp8CeAC7zdVOc4KKbLu90fpe9pW5PA1i/iZnjgM7W8oAG1
	 YTolIvRYy8oQWAkfcINb7/7twLS8v+q2NbwXvwmauK16bke+RampQWRqwihtD5S6Or
	 PRXZUyvT9pDeTGjZ/0jpEOoIeLzxg+ybxfxSDHUTLwuw7XSMRdemKmHwOXwXILocDh
	 dULQDASGFqwIDf3hZWoCVz5o6eHGYoZ9z8fpYijAXVJN+SfYN/k7zkDozUx9EWoPVG
	 xxxc9kkNLjj496Y3qjePzkkYQJ+hlFe5KBKKDRHME5JIy/LIKLxoydTEjCQBRBDgaK
	 2/gPEzPuhOiaA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25cd2b51fd3so436439fac.3;
        Mon, 01 Jul 2024 11:11:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNl1aP4ds11636hSp1r7dmQTBokgr0ywMzp7qZiKDrwGBiRAwMLwsIaHGIF+pjx+AG9bRs1Ledz9KCLs+t5Z+Z6R+sdKZ+jZETEZ9HBgCXyl08C37k14jZOylntECXIVQ/HPwzM10Pvw==
X-Gm-Message-State: AOJu0YyD7ijzACZAC3MEVMmjoIbGCfrVQh6JDyAmXqmjgX68/fI+tzdi
	X1whoV/W3WBVAdakrfM9TMYP4+HMuLxG7yIRUuIImNKSg+EqKEuKFXMuWEBATUdQvs1udQR6Ncq
	NKVpgiMbKRumRso5EUuli6PKTj/c=
X-Google-Smtp-Source: AGHT+IFkJ5n9eacsv7HBNduFQK0PZSjK3DFzu1xyqyeGUVfvBhPzZ4daHk0oHJtG925NcLgtuyp33wyGbgjtPesYfVk=
X-Received: by 2002:a05:6870:46a8:b0:25c:f5f8:a822 with SMTP id
 586e51a60fabf-25db33f8baamr6661470fac.1.1719857462710; Mon, 01 Jul 2024
 11:11:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240630173510.9481-1-qasim.majeed20@gmail.com>
In-Reply-To: <20240630173510.9481-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jul 2024 20:10:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hmtVZRqh1U+n07Quvp0JpLtxO+Z0bVZsubQRoqvCfExg@mail.gmail.com>
Message-ID: <CAJZ5v0hmtVZRqh1U+n07Quvp0JpLtxO+Z0bVZsubQRoqvCfExg@mail.gmail.com>
Subject: Re: [PATCH v2] Updating a vulnerable use of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In what way exactly is it vulnerable?

Both ACPI_VIDEO_DEVICE_NAME and ACPI_VIDEO_CLASS are kernel symbols.

On Sun, Jun 30, 2024 at 7:36=E2=80=AFPM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replacing strcpy with strscpy and memory bound the copy.
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
> ---
>  drivers/acpi/acpi_video.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 1fda30388297..6113baffd53f 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1128,8 +1128,8 @@ static int acpi_video_bus_get_one_device(struct acp=
i_device *device, void *arg)
>                 return -ENOMEM;
>         }
>
> -       strcpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME);
> -       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_VIDEO_DEVICE_NAME, strlen(=
ACPI_VIDEO_DEVICE_NAME));
> +       strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, strlen(ACPI_=
VIDEO_CLASS));

Why is a runtime check needed here if all of the sizes in question are
known at compile time?

>
>         data->device_id =3D device_id;
>         data->video =3D video;
> @@ -2010,8 +2010,8 @@ static int acpi_video_bus_add(struct acpi_device *d=
evice)
>         }
>
>         video->device =3D device;
> -       strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
> -       strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME, strlen(ACP=
I_VIDEO_BUS_NAME));
> +       strscpy(acpi_device_class(device), ACPI_VIDEO_CLASS, strlen(ACPI_=
VIDEO_CLASS));
>         device->driver_data =3D video;
>
>         acpi_video_bus_find_cap(video);
> --

