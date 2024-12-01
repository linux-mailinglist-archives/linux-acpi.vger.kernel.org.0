Return-Path: <linux-acpi+bounces-9840-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574599DF69E
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2024 18:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11002162D71
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2024 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745E1D79A3;
	Sun,  1 Dec 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="S1jrKzlW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79392B9BC;
	Sun,  1 Dec 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733073705; cv=none; b=RcHgkuLcah2gy7u14fYGasLHe9pdJ2hn2nHJeKd+b0P4wyTe0d1qZKxmEBplnfl310LHg81mi+2UQQ0Rv45A25H+/rXDkRipISMbXAutJoqSzdlTuwpu1gDS9jOHKras/K3UaFu5kLn6RvkCgB0oRCW3o/HbnIj2GcSnvHJLd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733073705; c=relaxed/simple;
	bh=WYM+3aoWpBMkzrC1SLc9RmBAak0AnFq3MZSg+R4I5xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dilZY04E6XzdcaZk0UCDfzz9FQlQ5ATnHQ6knGFs8/ZUVrONp3CiHjWPjEdzHE7dQvicJLayQvZecWAP0Xy/jqaHg1aYDyoOkHo1Y4SUVkBzzkPHIGIRZ59yKD3FovC5K1MI5HvpK8CPWCGQbNbcsaKyKZvaVilEKRrZodYum04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=S1jrKzlW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733073631; x=1733678431; i=w_armin@gmx.de;
	bh=jCx+3gGsxs2P5V42DaDTiaCKoU2vBLgtwXwpBVRgqlk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=S1jrKzlWF/B6mA8RU7kpThweWpZWnIaI1zEip/u1ScCci/Vxrr8ILUdYEGwPLouQ
	 MdkJXniPL8jfkZ2A2eHvGnJBKKRzZcQRXtJ6uKcmGL7/4vDMqFCru5jZR2Uf8PUz3
	 EN8qICsRxqlLdAhdRlILL6QqGbPBnimD1egCuMTDQF0UM3nHmjpIiJ27OXbzrx7qv
	 E0CVnDWqIquVZYRjZ1cMvU2/4tAld5OwxU1RP7q452DA+OnTPl4U2pRiEBBkpy7QX
	 qvUM2Tb71tYG0VwAg2okggWI+Nta3idcT/dWRytc3/GbQWJhsltXQP5I5khlR6s1h
	 9JL8Lg4LzJ1SCesH7A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.14] ([141.30.226.119]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1sxVqL0shC-00KkXS; Sun, 01
 Dec 2024 18:20:31 +0100
Message-ID: <fcc69efe-2c3f-467e-acd3-05af69082234@gmx.de>
Date: Sun, 1 Dec 2024 18:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/22] platform/x86/dell: dell-pc: Create platform
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
References: <20241130140454.455-1-mario.limonciello@amd.com>
 <20241130140454.455-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241130140454.455-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WylpFN/tvFGO1rQ2y2VT0txw3KcXPEIJRnYHXv2ZZ0j6CXPnORa
 1LlHK/NNeSL61mIXf9xVY5VTmdlV7MqrHvqQdhbmwJIk9Kvl9RhkTaPqW852Qe588xgWclE
 6t3UJoSyMLlnJ4ZU5zINDqJcTlTyfu8n0Pp3DSRPrmpL7qz9lDm1eLQHb13S17e7c9Oqdto
 9d2Wr9Bnz0S6rMiYR7MQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vlPctLMIxKU=;GEAkJyy6WXnzLoClOZJc4riVMCn
 QB27P9KKRW563JdiGQ5zmnQ7W99fFXHovDEc8c5g7/cOI3lgR69eDfiAPmgW0wSYz+0rOw+1V
 6cvLeK1qJgPXCit6PXePcZPwt7aFU6osOinveiwenIaH1o+v6Cd9AmHImpi7iKUkoybzqyPs7
 KiDNZlarsPUM19sm6n90z63jSK5Rte0S6OcKjC+6OwNv/RjcdrDtQBLNXKJVosyillJ+M4Az9
 fx/tMk+39pAcVhoVXdNCH9xBX6U0664qR8QLsBIdqgerYHbPBIFyAvt6EsqJBS1yuubFrNeGs
 7XAJ+xnpZlMqiBJdzhB6jfSJ8QxUWwLYFA+ra3SM1K9AImQGdNlsbYYeWes4HfB1q4M6ThOx5
 AGZf0ecfQoINIkqPeS06RoEleyLF8Gu6TcriP15kRyBFAqusTKT2vK7pJ++klXs1p+tE/BApK
 BskyfSjmU7QVIiuzRbWX9O8Ss+ntTV4KouowrmFPl2MPFioJU0hj+ezPaA3dm26m+XB1VywXz
 X93QXxV44u8DBWuHMimbFm49XcsyY4m/CjKC7zt/GfABRa7VLAYP+NQIqztj2mk8UrGClorBF
 6yRuhOYMJsBVHEcjvjbyZjnn4pREREn2d+9Ac1xAMCl0eCq4WjEohOhi+peSNscmAU4JbPSQI
 LoTs8qVkokKvft0ATCT2oK5lfzQnXr6+KAGvRB/r+tcL9RDWn8hO703Ml4yYNrPw50lpfB7z/
 xEa2aOYwXFJWAngm6KnkwYYSSG1SkkbVx3nY+POdOzp0lOfNbWJk3Srvu3mjcuYe/fc6hrDBG
 yUgjXpDV2J+XsbmgbR8OrL4qgqS9NtrvO8AIu5J6Pg8waKCs0dXwEd0GQD1TM/oWa4zPv+F4P
 Ch2qY5h3V/adONmPn5qbXD5lam+i8Zv7KWOuw7cTPE8FGl15OC19r1Cl3TC7b5WRDNMWIUVmG
 1r9ttrODRd+RdXSkkTb9VEAIGtSeCZMn+JMTnjw3AgcbASXWuLlWxXucAgIcijXKPhxZNV4NB
 wXJF/Z9Ibo+mrmrwxoe6d+3ztFcoUMUK4pSNP5Xr5JoW8T0hcsE6vC1KqkofywJ1cRUtsKfxP
 D3c5lk12c5Z//m1J27418d2p7UUgh6

Am 30.11.24 um 15:04 schrieb Mario Limonciello:

> In order to have a device for the platform profile core to reference
> create a platform device for dell-pc.
>
> While doing this change the memory allocation for the thermal handler
> to be device managed to follow the lifecycle of that device.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v8:
>   * Use IS_ERR()/ERR_PTR()
> ---
>   drivers/platform/x86/dell/dell-pc.c | 34 ++++++++++++++++++++---------
>   1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index 3cf79e55e3129..8bacbde0f0506 100644
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
> -		return -ENOMEM;
> +	platform_device =3D platform_device_register_simple("dell-pc", PLATFOR=
M_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(platform_device))
> +		return ERR_PTR(platform_device);

ERR_PTR() -> PTR_ERR()

With that being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

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

