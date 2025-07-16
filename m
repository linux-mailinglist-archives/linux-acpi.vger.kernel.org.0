Return-Path: <linux-acpi+bounces-15205-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43152B07D78
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 21:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7723AC9AA
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A102288C00;
	Wed, 16 Jul 2025 19:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niMoVXYN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB7221D5B8;
	Wed, 16 Jul 2025 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752693326; cv=none; b=GqWIA+PeN0SQ+VXhGGRTQmKH9YDssk0nR5ZQkGyYZ7Pra7/0ph+gqJuYKc1wYoV6C5mTwaeX/p2BCuhNdhsM5od5pT1Ot6GrriJ7m4zwWUaHdgpWu1nsAJxhLda1f2cGHKUlb5EhRffi3oGP0i2bT0sA7JLgjW/UWQ5ZxjANeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752693326; c=relaxed/simple;
	bh=4N3D0mV9fAJhJVXMiEgcyz3tWO3uL3DRXA1riDY7AyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdDXFYbLxDDoPMkV+QBJyQuJRcs7LdprdgzORQYChTId0BofxoERtcpM4PWposQlGAOAcrVcJeWbEUzdkARIuOD46Qg7hXAqdHGq7IFD0FinQaqDEZ9RD45I4jtJrrgZf1ktkaK49ZSE1P7wGqlGIp1syHUmBxwOf/+3N9XXVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niMoVXYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90148C4CEF4;
	Wed, 16 Jul 2025 19:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752693325;
	bh=4N3D0mV9fAJhJVXMiEgcyz3tWO3uL3DRXA1riDY7AyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=niMoVXYNNXgeKJqWziEe46AupDNORRIcaatSL6UkYXZzieeaMv08BrflIieLLK9/4
	 COxh5fwbyfKaPFtjnWucgESLgKeC6KJi2/pHdGBSVY/HUfPwPKO2dEaisjGWiGW19R
	 hEqjJFeZji8aCx3O1ybqoXpz3KLQ+vJxJEcfAv0xR2u0sXVJOT0ULnvPC1e6Go2EhM
	 JrSHq9jMUI3u6IHrVj4sRSd6FZ/LaOIz158MfZueN3ejIKGNG745HLs7Bx+FABuHyu
	 SJhxUYLFmQYMhnhvVaiXZkB02856CAT2n0t0zGYJ+0Tlcc83uw/2tY4EmuPtVAne95
	 UCZKkPYDen4uQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-613c7b65039so34320eaf.0;
        Wed, 16 Jul 2025 12:15:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0TEQO4553lV9aS3iDY3pqZy6GEZsEbv8XH/T9qjq06mR8UC3DdrtnuYZazQpXHZL+vB9mU4643k6F@vger.kernel.org, AJvYcCVcDAooTQPnSBeZhVZEf3VnsnovY32008GJDM92S9vhU4fediQQvU8vUAiYecEIWUJXrW7OhCdAvQRi3gTu@vger.kernel.org
X-Gm-Message-State: AOJu0YwKTRR/RDorO50oRgj7fwP0ztQPqjOf5bqZGVEoBbN2ssjF0ZNI
	4dTXDCjHEEOp+oR/iLLW+Yc7EmAp1CgUoXbwZqbynRqjxu7MEVwYQR8/g4va0XPDrtYKpvpcGCA
	r3JdpWiIGjbQ7v4x/Vx13Ag5ev+LRM7s=
X-Google-Smtp-Source: AGHT+IEvTv/ggyRIgatYX8jj6pi1Ing2OMrRQ+dXF0gg4eXsN/AjotWLhdtlqAald04JP+4oOgQqob65OSCcVKDSo7A=
X-Received: by 2002:a05:6808:1814:b0:408:f80a:bab9 with SMTP id
 5614622812f47-41d033f488dmr2488291b6e.11.1752693324796; Wed, 16 Jul 2025
 12:15:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123543.495628-1-hsukrut3@gmail.com>
In-Reply-To: <20250716123543.495628-1-hsukrut3@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Jul 2025 21:15:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gh2pARpomZnXiLegduYBczBG6ZGUSpzeo6RFb5XTwULg@mail.gmail.com>
X-Gm-Features: Ac12FXwIRuQuWNCRJKMvRfbs3VifhndfP-tUa3pmbr1B-eojFqmNIPv7xcGWNJc
Message-ID: <CAJZ5v0gh2pARpomZnXiLegduYBczBG6ZGUSpzeo6RFb5XTwULg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: TAD: Replace sprintf with sysfs_emit
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: rafel@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:36=E2=80=AFPM Sukrut Heroorkar <hsukrut3@gmail.co=
m> wrote:
>
> Replace use of sprintf in *_show attributes with sysfs_emit for writing
> to sysfs. While the current implementation works, sysfs_emit helps preven=
t
> potential buffer overflows and aligns with kernel documentation
> Documentation/filesystems/sysfs.rst.
>
> Tested on an x86_64 system with acpi_tad built as a module:
> - Inserted patched acpi_tad.ko successfully
> - Verified /sys/devices/platform/ACPI000E:00/time and /caps are accessibl=
e
> - Confirmed correct output from 'cat' with no dmesg errors
>
> Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  drivers/acpi/acpi_tad.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 825c2a8acea4..91d7d90c47da 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -233,7 +233,7 @@ static ssize_t time_show(struct device *dev, struct d=
evice_attribute *attr,
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%u:%u:%u:%u:%u:%u:%d:%u\n",
> +       return sysfs_emit(buf, "%u:%u:%u:%u:%u:%u:%d:%u\n",
>                        rt.year, rt.month, rt.day, rt.hour, rt.minute, rt.=
second,
>                        rt.tz, rt.daylight);
>  }
> @@ -428,7 +428,7 @@ static ssize_t caps_show(struct device *dev, struct d=
evice_attribute *attr,
>  {
>         struct acpi_tad_driver_data *dd =3D dev_get_drvdata(dev);
>
> -       return sprintf(buf, "0x%02X\n", dd->capabilities);
> +       return sysfs_emit(buf, "0x%02X\n", dd->capabilities);
>  }
>
>  static DEVICE_ATTR_RO(caps);
> --

Applied as 6.17 material, thanks!

