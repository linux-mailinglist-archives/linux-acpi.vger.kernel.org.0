Return-Path: <linux-acpi+bounces-9408-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1329BFFD9
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 09:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5E1F22E8C
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A821E1D54C5;
	Thu,  7 Nov 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aq80zYA0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D518754F;
	Thu,  7 Nov 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967760; cv=none; b=HlkZkhLjkSrOgBi0/Ns13H04O1+X2QJxiEQkkdU876/IanaBYDASpZN+Jb8LEdfPsj8c2wN7T+l9iGtVeq5FpW88n9mJg/wDRcrVzmPWkO66qSeufPPa3qw3CoFEhuPvGvL2l84xlWyB4bYxZiRvvoZUmaBe0i7qaneEuRVPJDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967760; c=relaxed/simple;
	bh=85d95EOC6Oqte7fumLBOEHPQaqEGaDtfepiLhrIjU2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSOn3JPKCgpcfdzFIPvYDlHBoJ8QMPAE/YmrBRJAJM/Fi38yWqevnXXnPUim/Gans/6F/LaXYC3T8tXWJaa0QsI4j+SnGHvNlDO/b5cIe2Aq6EmtPQDUBoVl82mPIenzoOZX7le8uybwQKTaDWrrJcBddsPiQdIyU6O0gNJ+y+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aq80zYA0; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730967677; x=1731572477; i=w_armin@gmx.de;
	bh=I9hvSUFaE10X2EU9MI0Ox4sZPM3HYsfCnT+OYayOcG4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aq80zYA0oOf7lRL5GuVgjXeYTr6oVKkb9jEk2X/7Y49VrxyrI70/MNg8dQ3pXi1W
	 IO2ecXMRWrPMQ1VrqIFTkIZlYQUQU1dVFBB02Mj3pTTAFHHMVpor4GLmxQHIMMYi3
	 Q9D4nGqJjN9dpDMSkZ7Gh7Hb6zFwFv1dbo3l2dnfuyMMvJCoWR6KqeRtFteWjWnuO
	 BD+HzkIQS9gzrtGakcwuvphDCZq7D/CNisxJBlCJsCfrJ5kpRmomXrpOuNLx/FZ1h
	 rAfAeeSKAjrph+/+c851PZT+iA1IgZJB8VHD0vwMUFw4prs1qWlZSzeCTB3nPF1cx
	 d7CW3zmPVmzIXbrDYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxlzC-1u1SWQ3g1G-00xLN5; Thu, 07
 Nov 2024 09:21:17 +0100
Message-ID: <cf6eb834-2337-4f5c-87e3-012713301912@gmx.de>
Date: Thu, 7 Nov 2024 09:21:14 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/20] ACPI: platform_profile: Unregister class and
 sysfs group on module unload
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
 <20241107060254.17615-10-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241107060254.17615-10-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DNDRuxiUduqoXNutn07yCfcVzwa3VRWGUqD4YjURJO3LwV8KSsh
 +uhOh7PNOQ28hAv9h5MQPGh7LmWGXlyPeG/juYQ0PyDb6S5HcSdZKtn/C6SjMfGbPO7btLx
 UwtqxyyF6KWnmRB6aaE8nBFQyhlPJrM7RLw2Aelm5e9ZUU5GLnNyFi5QG7B4Ur7uS+olPcT
 WEg3uzveIbtRIynuEPrIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZkfA+QeJLX8=;MVnF8T7iuOxwegsUGTaYTgahovS
 cawtppZF6g215yjMCh9U3kVxU5X89op57n4N8/Ew1Zu8VgfyTURnbaR5L2TeOXT4HenKLkNrY
 ijBR/x/8PXQGhVPAlCcvolBuR811eoelEJTSVu8ycPttz42nFy9GvtXLuEHdrNtn4wdBJzpqy
 /ZC6xQVK0GwqaMpooImBFU6IYmozslE75V+mG0uXeuFGPU95Qfa7XxCokiGiA/h3rf+EGldbJ
 E4pNDg7GKH0Mc4qRkYJCFT61B1beCe22z0CMMyKtAUrmzTs3PxAGjmas/w8H9ZvFpqewP00WR
 GqBnoVBaKSULr8JsUY0PrZfpPgjsT9BD3G+zcyXVo41uhGaADSmPaOUROwYFQKzj9rEosUSfA
 R4gl5dXejQpqDno+hghk8O6Trgpgvssg5Sxequ+Q03fPGS7Bv2h17V9UVmjrxxkRdEIpxwft6
 TbmIgXiKaUIgwBVP49shvzQUK98sWaAhoCw+zS0offHyvDwro37LzBTf2eWXU2g9W2V7Dne9t
 WINUvBGXwQUsLxplxdlaOVlWtU8IbKIsYPpifh9yCVxr5Fzuuq9e9PInP964Cam0AnC2dRlUc
 he19xMX4ZafBa2H2+vDKi0yxkUAwCz0dyzErN/T4+Eir/Ha4wMzGcjyP0soMQWZuBhvl32x5E
 r9QXZjMX8/XQBFSSGyx/E0pekvWfyEH8NR/v9XvwJbYREiDdZIc/t+rYpOXVWzv2c7+8/kWWY
 X8a3PBMRD5sDqoYn1JSTWIlVr8n718CeqCmu2NmK4GjaJ2NLI2XmSNW4wvNWCZB2AQZuHfd4t
 oX6rzXWiwWkXvcTMv9CZzUgdyqXXY5KE/S2Uegc+kM0vam/XHSlyh8NE+6P6pfDqViqSWGphm
 ShnnXtT+qQrPpefulGi+rtmktrE2Ex1m5PtH9BfEZZKhQjfvbhrRcIlU9

Am 07.11.24 um 07:02 schrieb Mario Limonciello:

> The class and sysfs group are no longer needed when the platform profile
> core is a module and unloaded.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index 652034b71ee9b..9caf070f77f6a 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -224,6 +224,13 @@ int platform_profile_remove(struct platform_profile=
_handler *pprof)
>   }
>   EXPORT_SYMBOL_GPL(platform_profile_remove);
>
> +static void __exit platform_profile_exit(void)
> +{
> +	class_unregister(&platform_profile_class);
> +	sysfs_remove_group(acpi_kobj, &platform_profile_group);

This will crash should the class still not exist.

I suggest you register the class and the legacy sysfs group during module =
initialization, and
add a is_visible() callback to the legacy sysfs group. Then you can use sy=
sfs_update_group() to
update the visibility of the sysfs files when platform profiles come and g=
o.

Also please squash this patch with the patch introducing the class infrast=
ructure.

Thanks,
Armin Wolf

> +}
> +module_exit(platform_profile_exit);
> +
>   MODULE_AUTHOR("Mark Pearson <markpearson@lenovo.com>");
>   MODULE_DESCRIPTION("ACPI platform profile sysfs interface");
>   MODULE_LICENSE("GPL");

