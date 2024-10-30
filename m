Return-Path: <linux-acpi+bounces-9136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEBB9B699E
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 17:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F511C20BD3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D09215024;
	Wed, 30 Oct 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j5ydOn/o"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D902C8EB;
	Wed, 30 Oct 2024 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307166; cv=none; b=OfmwIbdnz1YCR/BjxGK5AH8LN0FwrgL5nKW2V3oIwwf7sKSrdbGlrGr0DIDkHJy7b8GWfYT/BTexwfqQ/0BAFP+AxwqdNYHP6HiHStIZLfZiIpwTCjnL+g//bwjEkkdhT4LvMhtxf9z6m0WPEnlg4UhqTpeSIngC7qHKjgNPNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307166; c=relaxed/simple;
	bh=FrhdR0H7SLDZA6XsFsIzYM+EhpK7bnJryMCVRT1iNe4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hfyb6J2FrE0Xmfe/IyOzFSPMBclYl6oWVBSQApSLZpTPdAPoRJ7WPKZwDCBGOKwlQXhk4RUg2MmgLkBIjkpZGiO3aDmoxn11HjIyOBZA5dpWKLoTKKjndSERyxof6BAGU3i4zeVfqHOR0b68stzMRsHI6kf0XzdEySoUc9HlSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j5ydOn/o; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730306547;
	bh=FrhdR0H7SLDZA6XsFsIzYM+EhpK7bnJryMCVRT1iNe4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=j5ydOn/oNSuRmyD+3amgUBEoazFW+10NviKpxEmhPUCLCa4FRQt1rPeX+l16c7p+T
	 0Je4uokldLGmV3mkgxcBKVk8uzbkhnV/xrcHTAYLUI0K1RIpKFbo3DHcYON0xfMyRZ
	 QqmY650drxdCGlqbY9ngMtCqiJeyNv+gq5qcygy8=
Date: Wed, 30 Oct 2024 10:42:18 -0600 (CST)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Message-ID: <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>
In-Reply-To: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com>
References: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: battery: Check for error code from
 devm_mutex_init() call
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net>

Hi Andy,

Oct 30, 2024 10:28:03 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> Even if it's not critical, the avoidance of checking the error code
> from devm_mutex_init() call today diminishes the point of using devm
> variant of it. Tomorrow it may even leak something. Add the missed
> check.

Thanks!

Assuming you found this via some sort of tool and you already fixed up all =
the other places in the tree missing these checks,
wouldn't it make sense to mark devm_mutex_init() as __must_check?

> Fixes: 0710c1ce5045 ("ACPI: battery: initialize mutexes through devm_ API=
s")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

> ---
> drivers/acpi/battery.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 66662712e288..70f706d7634f 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1226,8 +1226,12 @@ static int acpi_battery_add(struct acpi_device *de=
vice)
> =C2=A0=C2=A0=C2=A0 strscpy(acpi_device_name(device), ACPI_BATTERY_DEVICE_=
NAME);
> =C2=A0=C2=A0=C2=A0 strscpy(acpi_device_class(device), ACPI_BATTERY_CLASS)=
;
> =C2=A0=C2=A0=C2=A0 device->driver_data =3D battery;
> -=C2=A0=C2=A0 devm_mutex_init(&device->dev, &battery->lock);
> -=C2=A0=C2=A0 devm_mutex_init(&device->dev, &battery->sysfs_lock);
> +=C2=A0=C2=A0 result =3D devm_mutex_init(&device->dev, &battery->lock);
> +=C2=A0=C2=A0 if (result)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result;
> +=C2=A0=C2=A0 result =3D devm_mutex_init(&device->dev, &battery->sysfs_lo=
ck);
> +=C2=A0=C2=A0 if (result)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result;
> =C2=A0=C2=A0=C2=A0 if (acpi_has_method(battery->device->handle, "_BIX"))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_bit(ACPI_BATTERY_XINFO_PRE=
SENT, &battery->flags);
>
> --
> 2.43.0.rc1.1336.g36b5255a03ac


