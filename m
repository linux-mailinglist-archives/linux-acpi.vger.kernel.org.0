Return-Path: <linux-acpi+bounces-9722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAD9D5526
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 23:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98036B239A6
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5E81DC1B7;
	Thu, 21 Nov 2024 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="dy884cPf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594031DC05D;
	Thu, 21 Nov 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732226593; cv=none; b=ARMFQN4dqAsq05WEHxOftJa9UpOf4wdLzg5F+7QrJgaFP8jHIFDIu5A9PBdLVQ0x9xnPACzMW1JYHRdSfOZz3SX1PkMQ1TPUTb7qA00R1QClNFAxmsKXQRVcvXqteelZ5d5BwBIoTr8jwJWL4pnO4H0uzjaltew0unHaX880yUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732226593; c=relaxed/simple;
	bh=Ros+bwO9Q/78EujOU7Y6eyGXbq2ExfNBOnLKVTgOVVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/3OUv7LrPyrFvID1qLzgVpyrd1zkJu+I1TXg+O03UamGExSFYqjE6P83PRQUZF/OtTmV7Fb8GYl/x5mrjo/dd7KT/q19zd1bUtNjSs4jxavr4fuG1jLIE0u4oi4gLY78NKOIoSPRWL41n5nx0nBxtQV6nqMd/XvRD0ME0s/+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=dy884cPf; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732226522; x=1732831322; i=w_armin@gmx.de;
	bh=MEp8dGg1PO0r/R+78/I2+LfYJ53XS9xvmlLw7gkP+JE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dy884cPf6L2VLJdZkaNYYZMrj13pkufR7cAqgO5v6t0qpWfSXk32fBNtlSHyQRV2
	 qUIpo72RewCg/sQEALSCJ9Sjl/mkYCSuPG72/URNXwVuOXl+QFdcdK3qFBOFxHI8E
	 L3WwJx+3iIy6ZmwLD1kCDehQuH3hXj5VrCwchXmUY5rtEUQIZY2LgQZr8YQpjjukM
	 eQrOwaw/sJZDQXxQQSC7w+e2dBch6ee/g1eSspCWySlyycHLRf/+AfSU7kK6GyffH
	 3x824e+4dGiE9vvvDjn/CqBXh4AgSFI1vnf2knVz2gnMAJltOMcGUwFy7275u3IXK
	 rhKBvxRuubhERxGoOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.129.90] ([176.6.148.212]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1u16yV3zf4-012Yc4; Thu, 21
 Nov 2024 23:02:02 +0100
Message-ID: <2a652c79-daaa-4ef7-9b92-4512a26d633a@gmx.de>
Date: Thu, 21 Nov 2024 23:01:56 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/22] platform/x86/dell: dell-pc: Create platform
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
References: <20241119171739.77028-1-mario.limonciello@amd.com>
 <20241119171739.77028-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241119171739.77028-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GYS5AOoGxqF0wXWDWQbStEiONjvFlvQC7x/UDdLufe4mr+RYYs6
 4RNr2/1T5EfL0VyJgzs3rPF1aw0rG2eBS8vJFTBHjElziSSc/THZLsEfDwFr3/2QRNiWqmt
 ZEhKawoSNkLUrvwoj04+7Uq1E4UYLS400uOiP9FtykNwYT2+V5FjnOh+IkjuvClznHBvWHH
 s/A5mUDarqNljjUmwmZEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wZgpFk+F8Ds=;sZBT09GJoZLUuLjWxAXIxp1RT2U
 iGLfb0OizrnkcdTLQDgu7dNKerwlrBBf7AthLq+f768/6dgGyGy/X+AjdKbSdJD8JfSv4yyuv
 GqFDcp5q2v77jIVOfpcOV24jZl3vtQcUwZVm5BOJBlB+nysOrpsS59ttlzYQZjY6ogXJdsND9
 H8woKwhRXBenCV3ds7iZsXqqGQL2FwUymc/l2PUVNQ1QPwRUf7qfCdF9qWmBIU118fg/5iYHw
 uRNuuq8FUdGhqpWcavSSTNidW6RGkyDpnZbIY4k5lEdhjwYoO1XeDJSnaa3LySsfHfjYK7ZVR
 tXOkXMeHq4yXqhoKYWQI8XakyjhfH2PbW0/Jyn44Lvxx5WLh7xeveDRINp+F+3FBIbwl6F9e/
 N4Q/XpOWlhziw8EuIgws9JWiHwOrkVKdroeg70bmmnCO7TCSNxAS5mzcqgaZ4O3M/OK/vVlSI
 lq3tX6UZ5vK4jbZhluOcIuDDMCL45Npew2DVMlWW5/XAmkNAXtY1TYCFDciX5KST94PbVcB0Y
 XR9yr69OdyaVjSx55Gtd086pwBeBKts8fxBwewJ7t169WwSDheWuaFgIKazEOi3B4q3fxg/u8
 zFU4TRItgrQS/f5ns/35J/AP2i5wcen7/nYc+oUl+t1oByomOiXRuiEFcqputqU0w7kXvHdUY
 tfCCkwM7bRRlK3Ivnt+QpsIYvhDAuoNXTNe4z5kmA6UKgnww8bkybVwS4Ttch0D6/8J9YKnZY
 3Jy4nJRryB6ApplPehAMz8STmLwoXFvMZa1Gl4gsKID14ZFoYeMveuYDP63JHcRt2B5tjEpAW
 JB/H7Tju9WpkfuE3fFn85NbtgF9FHkKXM2wqHdVHiKcKyvkU9nC8tyh4JX/WDIBN3NW9jm3e7
 lCzbtMqM3Hi1v8aMKqFAiJW4uT1rfMVCm2i2Sw+SOEG6nM5pTK2fInJA9

Am 19.11.24 um 18:17 schrieb Mario Limonciello:

> In order to have a device for the platform profile core to reference
> create a platform device for dell-pc.
>
> While doing this change the memory allocation for the thermal handler
> to be device managed to follow the lifecycle of that device.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v6:
>   * Use PLATFORM_DEVID_NONE (Armin)
> v5:
>   * use platform_device_register_simple()
> ---
>   drivers/platform/x86/dell/dell-pc.c | 32 +++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index 3cf79e55e3129..805497e44b3a5 100644
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
> @@ -244,9 +247,15 @@ static int thermal_init(void)
>   	if (!supported_modes)
>   		return 0;
>
> -	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
> -	if (!thermal_handler)
> +	platform_device =3D platform_device_register_simple("dell-pc", PLATFOR=
M_DEVID_NONE, NULL, 0);
> +	if (!platform_device)
>   		return -ENOMEM;

Sorry for taking so long to notice that, but the documentation for platfor=
m_device_register_simple() says:

	"Returns &struct platform_device pointer on success, or ERR_PTR() on
error." So please use IS_ERR() for checking the platform_device pointer,
since a simple NULL-check is not enough. Thanks, Armin Wolf

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
> @@ -262,20 +271,25 @@ static int thermal_init(void)
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
> +	platform_device_unregister(platform_device);
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

