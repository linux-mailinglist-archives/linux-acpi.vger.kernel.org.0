Return-Path: <linux-acpi+bounces-9368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EEB9BF762
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 20:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D963E1C229B4
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 19:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F90D1DFDAF;
	Wed,  6 Nov 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="pj2EC0Q9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6806209F47;
	Wed,  6 Nov 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730921941; cv=none; b=h0+NN9g7V5UKzkaIC9aw4LzwnXE/3hsVVIkCwT6u4OdFrvcb48HXwJfMVW0m4ALqX03YSaHMqjKEjwuGSGGqOhrt/Qic/CUc/Od7OfICG0HOQsZl4SAy/hVPnJZPqX/ZFJc+eQinO5I9nfoZ11jc/xrtk8uGS+EyZ7qRwBrsr/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730921941; c=relaxed/simple;
	bh=HiCzIvkCW8MyO7NuYdiCDgGHjjseI8QbfQA4A5ThJHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFXix1UpK0BgiQ+V3OF5Fdh2DWUck+E3FdWY8VHNv2KX56jEA4qT84DpN8to//moEi920PuQSDm23rSYvAbFWVYv7qfu8ZkrG93+pD9x/hN/egLeREa1oqNBS3/A7SHDgl0oDa+j05B0BYmMMXPCP/TIsSO5o2Zr8+ngbbwNB7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=pj2EC0Q9; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730921868; x=1731526668; i=w_armin@gmx.de;
	bh=DWkopg69mn8S4SfXiFt/DcVunJCaA2dwQYyTiUNVYY4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pj2EC0Q9vQdOBQh0BrBKfehA6q/grE9zCbjsVZGT7oSYyt1VdjCYU4ZoN4pF4qRO
	 E0mg2jpHdUIvwhFoJKGR86matj58mhcqxk1JM90cxGUFWnpGSgLEWkQ+56gmbOsoy
	 Zb3NfifLivJmhBrOcNizH83Gdjersd1KNxB0z5vV37xlm5UYhzrQeY3Sv6zCGV8Oc
	 xUSrxnYFPTbHGj6jF01l7gGOpdb+UZiYsM3SCLfA1uYYm5uJEJJC7QB0GcBy9sXq/
	 atu0k06NO07Kmj4T3vC5FtxScw2mVm9XnAQQudRIB7ZSWmsKKfkx47mQVBir21gRC
	 NuE5lpjHHwNZwsbcIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1teIn32Q9l-00aXeR; Wed, 06
 Nov 2024 20:37:48 +0100
Message-ID: <1ce2e9f0-9b18-4c8e-b5ef-08795704a17f@gmx.de>
Date: Wed, 6 Nov 2024 20:37:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/20] platform/x86/dell: dell-pc: Create platform
 device
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
References: <20241105153316.378-1-mario.limonciello@amd.com>
 <20241105153316.378-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241105153316.378-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXPG+XJerwMrXIeld8wFRfVFnJI4WcbE/wBi2vt+UXFGezhodEi
 v2bJwk9D1mc8karoqY7bksJqfpN5h2q/u993sVycDs2OhnRMVoQK/KfIrLASwYrwn3BzFDb
 HJ575ZtKAq/JHsEOx3D50QexYilfSeZjGUpsOy/zkXek0mNr6WzrG35IergHE0rCo3wLn2Q
 jBR/tybvFupf4sCm4+Spw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DfE0K5Okpxs=;C9NNR5C324DtBHOjNMjQndf5+pv
 Y3ORZ9RDlG5DRRJ3lM9LE43BoLxbhfalPAUAgD6OFuk1q3NilOBJES+rYoVI2ax3VVwB7gSp9
 zyycKl8zO+KGYKdWFo5sYIgy9iCLLtCNWBgjpCErgt+A1owSXOzmlkJRAJI9WX+HbSaJ2hLxL
 fiKZXnGy44Ij67HUWUf5tYe0PAh6/CEV4R/L8o1A4lFwPEMBO5ZaTHg0htMBA/9AMj2Bh3hjs
 i7QQsamBn+AaCVPom2SNxX9O8ah7wBwz2nD3pwksHoAvxHhRHEp9ghOua85vF/oqqe70qa8Hz
 p6c/1URrkRoRUBaq3vgPTE0hImevzk61cRTj3e1I0M5PzNDSBTpfFd6PgBvBkykauJeXQUNau
 9keypamRXw9EI2Eq7b+Y+s2e+KtVUgZG3VDXqagMPIzJ5xA6sMI7+fUnBZVncDzuuIbUqqe2v
 306XwH5zzjUzjUYZj0iEmbDELTFdDG9uXMnddI93FzRiWdogo7GKBRO0dumlL1hoAwWK26hv9
 QAkzwu4DXNmRxSPeYfMKOXEuKuwBqd3gK8UGyzVxXJ44VGUOl3mDmVn1od0m83B+te6DCIVOg
 cXcXwVDbRxjdiQ9mhQI22ET/zV04TP2EkXt1PWiE6D+Bfoc13Vd1QnzSbPdr8krPV5+1Z8wCd
 y/EEp6mPSWrwDt3HWrjKqXkh4QiHJSPIzwdY5lv12cZpbSO50gnaBO5uGwtmvUKdRyfkaoIP9
 yU6HIArrmDlc9FAwm/6d6w3BqN9qW8we7cvO8ZOx54rOC2URsODvajCmGMJTwgurOnnbsKkwK
 TskIgSSjUw1mVmh7tnUrGRSw==

Am 05.11.24 um 16:32 schrieb Mario Limonciello:

> In order to have a device for the platform profile core to reference
> create a platform device for dell-pc.
>
> While doing this change the memory allocation for the thermal handler
> to be device managed to follow the lifecycle of that device.
>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/dell/dell-pc.c | 35 +++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index 3cf79e55e3129..b145fedb6b710 100644
> --- a/drivers/platform/x86/dell/dell-pc.c
> +++ b/drivers/platform/x86/dell/dell-pc.c
> @@ -18,10 +18,13 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/platform_profile.h>
> +#include <linux/platform_device.h>
>   #include <linux/slab.h>
>
>   #include "dell-smbios.h"
>
> +static struct platform_device *platform_device;
> +
>   static const struct dmi_system_id dell_device_table[] __initconst =3D =
{
>   	{
>   		.ident =3D "Dell Inc.",
> @@ -244,9 +247,18 @@ static int thermal_init(void)
>   	if (!supported_modes)
>   		return 0;
>
> -	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> -	if (!thermal_handler)
> +	platform_device =3D platform_device_alloc("dell-pc", PLATFORM_DEVID_NO=
NE);
> +	if (!platform_device)
>   		return -ENOMEM;
> +	ret =3D platform_device_add(platform_device);

Please use platform_device_register_simple() here.

Other than that:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +	if (ret)
> +		goto cleanup_platform_device;
> +
> +	thermal_handler =3D devm_kzalloc(&platform_device->dev, sizeof(*therma=
l_handler), GFP_KERNEL);
> +	if (!thermal_handler) {
> +		ret =3D -ENOMEM;
> +		goto cleanup_platform_device;
> +	}
>   	thermal_handler->name =3D "dell-pc";
>   	thermal_handler->profile_get =3D thermal_platform_profile_get;
>   	thermal_handler->profile_set =3D thermal_platform_profile_set;
> @@ -262,20 +274,25 @@ static int thermal_init(void)
>
>   	/* Clean up if failed */
>   	ret =3D platform_profile_register(thermal_handler);
> -	if (ret) {
> -		kfree(thermal_handler);
> -		thermal_handler =3D NULL;
> -	}
> +	if (ret)
> +		goto cleanup_thermal_handler;
> +
> +	return 0;
> +
> +cleanup_thermal_handler:
> +	thermal_handler =3D NULL;
> +
> +cleanup_platform_device:
> +	platform_device_del(platform_device);
>
>   	return ret;
>   }
>
>   static void thermal_cleanup(void)
>   {
> -	if (thermal_handler) {
> +	if (thermal_handler)
>   		platform_profile_remove();
> -		kfree(thermal_handler);
> -	}
> +	platform_device_unregister(platform_device);
>   }
>
>   static int __init dell_init(void)

