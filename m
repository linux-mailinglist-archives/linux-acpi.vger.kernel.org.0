Return-Path: <linux-acpi+bounces-7237-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F1945F47
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2811F21BBD
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Aug 2024 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC6E1E486E;
	Fri,  2 Aug 2024 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orTJ3nZ8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347711E3CDB;
	Fri,  2 Aug 2024 14:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608366; cv=none; b=gBOajr9vlPa8WfqDgYSoPJ1wYF02J4PLTzlXVuI+Ta3wsKw4abnbvqn5tfkgE5UcOUhfM7oAKBOOxpuwSsMH3BXhKN/vhwIAJSvmuC/itvfg7+BtqX35bkJese6qL8eiUWnfVmGt28fK9NUMpcYcQ3Z/u69hY1TcpmWv3TfkzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608366; c=relaxed/simple;
	bh=+panpB8DFfcA059NGc95vh3luUsc08gjqk6S1gmG5rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9gM3xwZxgxAwBblCxjWxObVTAO9kuvy6ptnIuVUyxDKlNchP8Pya8Q0ud7LnBqMWueXhByDlPmZshEhmsJih1KcwuWrqrGCbCXUztO0PnVz5NfEZvmmmuPCB1gEXKh+bCKRmAnyvnPMrTRp2DYwe7WSNm964hsnNeh3o1NL/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orTJ3nZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DA4C4AF0B;
	Fri,  2 Aug 2024 14:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608365;
	bh=+panpB8DFfcA059NGc95vh3luUsc08gjqk6S1gmG5rY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=orTJ3nZ8Q4XwCNbnH7b4nc/06HVrqq3bittEWmca7QO1SoHergVVcIlNXaayK4MsL
	 jifOvU6AHrjimtZZaffH70jHTezDzVB/8bmeGyJ2F/vRfSTj3WRAC5ynU9f5FZI3+x
	 KUbEWMBs3JdEVUmzY2x7MWeJ3dPFs4dfp5xnfa6SfXH3fr4R4K0Fmt7Sz3KrF4LjxP
	 hsga80QgC3HppTngcRggDsHOJazUTk2cOwq9ckycXOM7AykksALDjdWrpzFxRsNDTV
	 ajxTDTwfaCtZIfk8hD5KDgraBzVfc3yGm05VwgompY+dX2+19VRkhM4Omy9EBdaA7e
	 5AYZOucJWCzZw==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26104de0b47so368202fac.2;
        Fri, 02 Aug 2024 07:19:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3hskB4fwGZOSUiBgrv5SWHpw50xLWMmyIComR/OHZbB6F4GN1aTYDNxxG0SyTWM57LwR72bFoQ5RSi1j/s52prRDnrJCfvsHmjbic2NVIXmfJfCynY8j7oG4KeZfdqSWHQCBYNNDjsQ==
X-Gm-Message-State: AOJu0Yz3Ll1IJz+m0fCJ3TBD9KZJ5XFj/3zSElz3JMGFinjuHf8tkfNf
	ruYEOVWuuikmhP1HUYb6Ph6XbOJsuCQWuWboTfUaoW58hT5v0IO/7VE1IIf1vTsGv0OzGsJ10h+
	/BtYWs54GbQ29s6xxw+n101ywjI4=
X-Google-Smtp-Source: AGHT+IEdiRH1stj758JGrz4aaomOqZQmruzFKfKwG8HauZQWcqWfkvdIHedz1TxcEOmDGjEy/RxDWhtuWThrZQcfXn0=
X-Received: by 2002:a05:6870:eca8:b0:260:edbc:d7fc with SMTP id
 586e51a60fabf-26891b2857bmr2562136fac.4.1722608365004; Fri, 02 Aug 2024
 07:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706081104.14493-1-qasim.majeed20@gmail.com> <20240706081104.14493-3-qasim.majeed20@gmail.com>
In-Reply-To: <20240706081104.14493-3-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 2 Aug 2024 16:19:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gzgwAwoZXNCFRTpSbscd9V1DJSD9k6QKh3QaKNVmDWsQ@mail.gmail.com>
Message-ID: <CAJZ5v0gzgwAwoZXNCFRTpSbscd9V1DJSD9k6QKh3QaKNVmDWsQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Updating a deprecated use of strcpy in battry.c file.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 6, 2024 at 10:11=E2=80=AFAM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replacing strcpy with strscpy.
> strcpy is a deprecated function.
> It should be removed from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
> ---
>  drivers/acpi/battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index b379401ff1c2..784f9234f1a4 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1193,8 +1193,8 @@ static int acpi_battery_add(struct acpi_device *dev=
ice)
>         if (!battery)
>                 return -ENOMEM;
>         battery->device =3D device;
> -       strcpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
> -       strcpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
> +       strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_NAME);
> +       strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS);
>         device->driver_data =3D battery;
>         mutex_init(&battery->lock);
>         mutex_init(&battery->sysfs_lock);
> --

Applied as 6.12 material with edited subject and changelog, thanks!

