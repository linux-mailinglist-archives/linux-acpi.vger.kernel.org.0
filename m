Return-Path: <linux-acpi+bounces-9406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540F9BFFB4
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4803D2837A5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22C1D04A0;
	Thu,  7 Nov 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WkRDY5D8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38117DE36;
	Thu,  7 Nov 2024 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966956; cv=none; b=F/pG+Bu0AaXmGstiztEJQu96Lx6lqBTr/1/iPPz84bIcXTIqppJbKgq+WDG3I1heh2olK+qwT+zi7OgIkMhoqzznBLSLlIvG4ACszDf08dsLyTr8zrsz8pfx5K0YWcHuOQtyRCT5iDj6LBhuAruNjP13ktf1xtequjSl5uNZT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966956; c=relaxed/simple;
	bh=xN93vbxTt1KARVgg9O/phRnB94KjPdT5gScJ//vyk4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjWTBK+SuCHHzbMRZAFaJ56XTUD5lsAiFpabiNJYDWkWfwgA7o3hBKrgXBptffQZMTiSNu8Xf4zUsZZKPdSthfRDx5xT693OZck5QKDPDYDJn+pDms8DrOvwwoGjZpacyq0WkyiISi4WMjAMNxuJy27qCVyUCgqiDn2l9Mjfne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WkRDY5D8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730966878; x=1731571678; i=w_armin@gmx.de;
	bh=+sD67PMdHq3t7fB6r4132ZHSKpmpOxOGf4hTSOkDNlE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WkRDY5D8U10s+r0IdropUaQr3mwW4MHHroJ2VVy5Yr7pavLefp/rBWyyg8TdbkLm
	 Jq1QoeUTGE7tDvrEY0Q7zuH1BOsLY6gUScEAdGQlbOvPQ8JE7Ud+fYZm/NhWXMWpK
	 8w0cbYRIsgV2hg/+/hLnIrvOfimrGAAVrmOpoXJG2A31Z5EI+R/fs0BNb57KK/TYe
	 ETViZmEtMzw6aY2YgYRa02KrBWl12SIoS2gmd2+JrpRBSGupLjDzcZVxWaplSefmo
	 aIICGVSk//D8RJMMNK7tqilmHfAHZybuMOpBY+5QXPw65IaBSjq+sGjwT5Tyl+mBI
	 hQMV1H0ZMzpGM0NpYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQ5vc-1tUs7a2I4W-00Qg28; Thu, 07
 Nov 2024 09:07:58 +0100
Message-ID: <44462a90-5151-4b49-830e-528bc5451030@gmx.de>
Date: Thu, 7 Nov 2024 09:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/20] platform/x86/dell: dell-pc: Create platform
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SMQWaSNdx1FuesT/I28AtdxEBOPax+cWkkuE/rRc6UY7kGdwXA2
 MRsf0zGrYruuYk5e6Zv0ZEuo5qJCxt8F2QTp6xtPMGHLMJcyYnbqgLtJzf09jFrD40OBAEo
 fUMZ744S5NoUQfpFWQYPqpAJI2C5LAEOxZ6ILC9tO8RP6tzW0qBR4Sdpcx4lbRTC1jpiW45
 LzGMJtInkzM0rBBwyoDcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Kj58pHIuaf8=;DMZmlhuVjlZKLOxJ2ObNdWoBhBT
 F+9ovY68nEZ5XBA3j8GQS+S6VuXyKVezFv2ACLk8ow24YVOBdMd2dY+qKPPruwt09wM6NDHyM
 7O/wl4k9HWYaFsImBJ4Ytwdhtn41uWpx3EokA+o3z+Dmo6ahvV6azjW/Eq2lJ0/8pGokdhJAn
 xfQo9gog0fn3RkqVBxSpX8+W7HQmGWgP3XYFvgPEP1JsEq958sXmOj1rVLf6U1vluJDcol/bj
 9Som1Xg9rkLLecuQU4WvFg6dh2D7BE6E6bMHhYA+VlEttndkN4T0qiYmo94mFRyt/g3jzkVSF
 XS4l8tNorR8nlYVcMTDFJMsesR2F2X40Y2WboroAHnuiHJxHq0u4q6IlcDD4BFXMHTmHx5fIB
 3xJgbkmaqPkTElxpWRUlwkUiKFbmeqf/4j3yYceAUfwYyHznwe5eA0Rg5TL8jAao9jphLNEfY
 Se9EvP0+MAnVf9C0dA0i6lLvLHbV4J+iuXlrqSnovdovbyzFYYi6NUlbUb6zyRpUpuQACgglf
 vToQ30ER7KwDnzo1BtcNng+EKi9leGXZVSrjMrten6T8bWH0D9aCBFMouJCR2jRRmBOCX0bIz
 8dhVw23fNXvi3yHSuG63qjZBcjN0DhI3aqVKKmuViivetuI6IrxyzxoOfrA6+34oYw3e4AjBy
 8hUvLwFpW8u4o9wpIOHIepURhgSLXC8s6K4dzIf0c2yaXSvE+P/gaipkbo6LMP3olQvmfWUfJ
 IbWsvvdMS2zCOwaxBDKMeIcJfhFdO1jfpf4q3hocp3WPfrsdvuWq68rwx7ShrJ1HbIoxZPagp
 DriyMoLZESxB0K4Aav3HhxbT2H2d+HtVtFAqMJal2zf+s=

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

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
> v5:
>   * use platform_device_register_simple()
> ---
>   drivers/platform/x86/dell/dell-pc.c | 32 +++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/platform/x86/dell/dell-pc.c b/drivers/platform/x86/=
dell/dell-pc.c
> index 3cf79e55e3129..0cd9b26572b61 100644
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
> +	platform_device =3D platform_device_register_simple("dell-pc", -1, NUL=
L, 0);

Please keep using PLATFORM_DEVID_NONE here.

Thanks,
Armin Wolf

> +	if (!platform_device)
>   		return -ENOMEM;
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

