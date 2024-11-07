Return-Path: <linux-acpi+bounces-9407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43259BFFCF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83A21C21600
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971B71D8DFE;
	Thu,  7 Nov 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qgy1pHpk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1F19882F;
	Thu,  7 Nov 2024 08:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967461; cv=none; b=so/5fBa0lHeT+wgBeWFQ9mB2LIr288DMulTX1caCIT9HvADNb2444eCsRK9raqJ/8OaLMy6xt5nnWkJj/4JJdUUoYM/d1hcYis9y6+eSI73n1KpqEUPdl1XqyuzaIm/zOroblU5MOqsC5o3ieUsXd8nrdJVv4Q/mYxvEQJPIjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967461; c=relaxed/simple;
	bh=2NjahVnCUgcQciT5lNgqb0JbXjkYEMai78e9B1QNy18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=We3Tqgqx0gvCrzvAwiA1bjWPyFIaiClylY/ClSuAV0cGHUnso7D6yryikfFEqC2Jo83GHW/nsBa8cWOrc4PWOTDSNGOo7UB7q7TLCJvIBtBVuUEsWZxgcjbv4GTAZCuae7SDgBs1uj9vkoMgz7ETEtXpnvsy5JCcgWy70P9OCaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qgy1pHpk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730967387; x=1731572187; i=w_armin@gmx.de;
	bh=UGFzxjUb7KWED/miJsb/OCWPlLtXLgvQBQR657nyhBg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qgy1pHpkZ+le6YtbjfBUJdiWi/7h02XWD+AqyEnpfUUHbodIkIaucDKe1D/p9UzK
	 biHDfX8wbbEfyEGaoMuGFJ5fmwmRSBPVY8iP9PvZpECJCOz/Sv1RjQu5S6v7t79Og
	 gefDe5rj1D7kJY+/WEBSh+flZSy1qJIVQgQ0UkDjWJI6iIa1xTdKOEyE7dRBaDQI6
	 fIWpGZNbL0KjFlk1MkZOf7ts6gSRV8z7NQYxevNMZ69D9vBDWN6oV1QlWE8s86pr8
	 StJ7785pcOHGRpxtO/+qWvlNNb1G2uSKFM8/xCsDkI3kcNZiwoi9Nm2/LAxrxYtaf
	 zrRtk3I0VbNNGkV3kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXXuB-1tJZBs2CtD-00LUzK; Thu, 07
 Nov 2024 09:16:27 +0100
Message-ID: <84a647ba-50ec-4d60-b4be-758ff50335bd@gmx.de>
Date: Thu, 7 Nov 2024 09:16:25 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/20] ACPI: platform_profile: Create class for ACPI
 platform profile
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-9-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-9-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nn+j1vVOhxtyUpFwa6lTyQHFnFB3vcawej8N+j8It2wcC2uyRjR
 pPzrv48D71bMjgSLpwiw4IQxWUFc1Cm3GNnxKzqzIuUCe+Fqrnuhbqg5pK6I0RRUx1kOQ0n
 B30+MbkFe5J8iJ3tRx7P0NeiyD55rmFXxm2oSaUzY6mUoFpsSadfBLUPvnLFkTtiC3kK7Kj
 oSEEpFjOO4LGfoaIuiUTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5EI5/5mBm9s=;jbk6v0AyLdxl1ZzXCLl+fJzWMa8
 +6fei72x4zshBDNlru1jBO0b1HWIzh3wOYfBLNa6x0YVT3OrYpqBdv/smHjBUdiXH1gD233Zw
 UKVQAlDFKEozs77PtkJOneelzTQw2j4uM+GiT1HUccZPbviVIoLkYn+gY5Yx5/3aLzyWfY56m
 xqGzL+E4HyvGHIgE7UkwOl/lMNHpAh/mVvEzeWA4eaIcH9oHYiHqPQ85xdIb3S5AnqUTJxRh1
 MkIaj6vnRlYzqs8YRIitafm5DiMA2f1c7VX2xZHF4UxricgB5/DWP7MGOkNFWnaQk2rblObDr
 +p6S/fHL9HnwseIpmVaEyQ1Odh8lw+3qx8Jt1Hxynul/emavYfflKofhLEhKy7qs9dmxQHt1l
 Qzpyh5QbJCmwZK2+sBeXcXHK/4Cdfl5+FbTYm5fL1XUQ0nW76OxTS8w0bNvNu5lu+z3jZj9Ks
 WSRCAepL6/WBYWVMyjV0Vcq5xsDUhgLrjkJnQwRmIwH3vG9vUgdNH+mO9kX3b5ffXc+pA90HS
 GwMbre1LjODtVvyFVOYVF8RNOXlY1GYA/Hv6N7hUASVmf6/XhQ5rqyRuKy+yfo2R1dh8cppq+
 LRDJPCRkhgoCX0XFsEvrYJbAXr7Gx+S6D17Anov1b0k+Vjc8zzqRwXJmBg7c6jz5cyQfrl3cj
 hK0chWTv9+GWDDtvvPJ4TNU9VxpY1g8blV4kb1j9JHkJTCsDnaactwCKTtjw7dwW1pgwNDutu
 a7CwhMDhybuikbUgCR7lvXpxGF7jPJVsNydWJvaeVfsiroGEci62RwiykWo5cvjPraD10V0v8
 IMPoCC2hAiaFRFN532LApw8/GyxwRl6slvcv9Z/MHfmZw=

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> When registering a platform profile handler create a class device
> that will allow changing a single platform profile handler.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v5:
>   * Use ida instead of idr
>   * Use device_unregister instead of device_destroy()
>   * MKDEV (0, 0)
> ---
>   drivers/acpi/platform_profile.c  | 50 +++++++++++++++++++++++++++++---
>   include/linux/platform_profile.h |  2 ++
>   2 files changed, 48 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 0450bdae7c88b..652034b71ee9b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -5,6 +5,7 @@
>   #include <linux/acpi.h>
>   #include <linux/bits.h>
>   #include <linux/init.h>
> +#include <linux/kdev_t.h>
>   #include <linux/mutex.h>
>   #include <linux/platform_profile.h>
>   #include <linux/sysfs.h>
> @@ -22,6 +23,12 @@ static const char * const profile_names[] =3D {
>   };
>   static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
>
> +static DEFINE_IDA(platform_profile_ida);
> +
> +static const struct class platform_profile_class =3D {
> +	.name =3D "platform-profile",
> +};
> +
>   static ssize_t platform_profile_choices_show(struct device *dev,
>   					struct device_attribute *attr,
>   					char *buf)
> @@ -113,6 +120,8 @@ void platform_profile_notify(void)
>   {
>   	if (!cur_profile)
>   		return;
> +	if (!class_is_registered(&platform_profile_class))
> +		return;
>   	sysfs_notify(acpi_kobj, NULL, "platform_profile");
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_notify);
> @@ -123,6 +132,9 @@ int platform_profile_cycle(void)
>   	enum platform_profile_option next;
>   	int err;
>
> +	if (!class_is_registered(&platform_profile_class))
> +		return -ENODEV;
> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		if (!cur_profile)
>   			return -ENODEV;
> @@ -163,20 +175,50 @@ int platform_profile_register(struct platform_prof=
ile_handler *pprof)
>   	if (cur_profile)
>   		return -EEXIST;
>
> -	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> -	if (err)
> -		return err;
> +	if (!class_is_registered(&platform_profile_class)) {
> +		/* class for individual handlers */
> +		err =3D class_register(&platform_profile_class);
> +		if (err)
> +			return err;
> +		/* legacy sysfs files */
> +		err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
> +		if (err)
> +			goto cleanup_class;
> +	}
> +
> +	/* create class interface for individual handler */
> +	pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);

Missing error handling.

> +	pprof->class_dev =3D device_create(&platform_profile_class, NULL,
> +					 MKDEV(0, 0), NULL, "platform-profile-%d",
> +					 pprof->minor);

Two things:

1. Please allow drivers to pass in their struct device so the resulting cl=
ass device
has a parent device. This would allow userspace applications to determine =
which device
handles which platform profile device. This parameter is optional and can =
be NULL.

2. Please use the fourth argument of device_create() instead of dev_set_dr=
vdata().

Thanks,
Armin Wolf

> +	if (IS_ERR(pprof->class_dev)) {
> +		err =3D PTR_ERR(pprof->class_dev);
> +		goto cleanup_ida;
> +	}
> +	dev_set_drvdata(pprof->class_dev, pprof);
>
>   	cur_profile =3D pprof;
>   	return 0;
> +
> +cleanup_ida:
> +	ida_free(&platform_profile_ida, pprof->minor);
> +
> +cleanup_class:
> +	class_unregister(&platform_profile_class);
> +
> +	return err;
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_register);
>
>   int platform_profile_remove(struct platform_profile_handler *pprof)
>   {
> +	int id;
>   	guard(mutex)(&profile_lock);
>
> -	sysfs_remove_group(acpi_kobj, &platform_profile_group);
> +	id =3D pprof->minor;
> +	device_unregister(pprof->class_dev);
> +	ida_free(&platform_profile_ida, id);
> +
>   	cur_profile =3D NULL;
>   	return 0;
>   }
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_p=
rofile.h
> index 58279b76d740e..d92a035e6ba6a 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -28,6 +28,8 @@ enum platform_profile_option {
>
>   struct platform_profile_handler {
>   	const char *name;
> +	struct device *class_dev;
> +	int minor;
>   	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>   	int (*profile_get)(struct platform_profile_handler *pprof,
>   				enum platform_profile_option *profile);

