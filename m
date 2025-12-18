Return-Path: <linux-acpi+bounces-19648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F52CCA8E1
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368B930813CE
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E132FA12;
	Thu, 18 Dec 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="DAny6Ucp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24B2FCC0E;
	Thu, 18 Dec 2025 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040523; cv=none; b=rKKOlHsxhSX5p6rIcKDS28CGkqMJttD4gDm9jAK7eodZuQLo4XIvDca/ZMV273xFwYog9JSRR5gw5NsEN2eR8rBeS+CbvIz+pP2UP0TGeObnRBoBEAdHupsUjB1UbHGWKkb2ixp0I4tVczH0TuatXN2snilTrFDDSSMMNoj+FIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040523; c=relaxed/simple;
	bh=Bvb5nZ22E/b873OqxdM4nSK/zggRk9sx7lpf3PWsqXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=duApAcy89Zu0vUvgTGIRMG3vOJs3C52cfdy80CtOLuJxMG9aj2Aymvj75vG5s7Sg5mGVdX9WHnwNlI9xXuzUBv844AROtBQhCmLCYqbv7P+XNkcckdv1cX6hsbDh2pseM30rzvONRFurxCLdtVRUr6FkdlCaqi/sKgygXKV7XhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=DAny6Ucp; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ScoFQ/ansEWIXKq9P4dDY9uGDVCyUcrXN7vBp9sF7wc=;
	b=DAny6UcpfOnH2UDzatQ/BtphXMG9GlG9hypD2m3XmDVu0Eyg0eplA8jK1IcMrL8/+sVYTFlcN
	E80unBrng28gbwcva1IhWyX49pDrrjgxkC++zo1iiHo4mxEMpi6JGLLVs0JeVAo1VKH6lZX9DFg
	pfhYjNcFXuPLTAdUypEo/dA=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dX1R35KmWz1T4KF;
	Thu, 18 Dec 2025 14:46:23 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 281CF140278;
	Thu, 18 Dec 2025 14:48:37 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 14:48:36 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 14:48:36 +0800
Message-ID: <be2d54f7-77f1-4412-b650-4266f3b8882d@huawei.com>
Date: Thu, 18 Dec 2025 14:48:35 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] ACPI: thermal: Rework system suspend and resume
 handling
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>,
	<lihuisong@huawei.com>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
 <3024049.e9J7NaK4W3@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <3024049.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/12/10 22:44, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In the process of handling system resume, acpi_thermal_resume() attempts
> to power up active cooling devices to guarantee that they will be
> operational when the ACPI thermal check queued by it runs.  However,
> the only kind of cooling devices that can be bound to ACPI thermal zones
> is fans and they are already powered up by the ACPI fan driver resume,
> which additionally takes "ACPI 4" fans that don't need to be powered
> up into account.
>
> For this reason, remove the part of acpi_thermal_resume() related to
> fans and in order to ensure that it will run after powering up all fans,
> rename it to acpi_thermal_complete() and point the .complete() driver
> callback to it.  Analogously, rename acpi_thermal_suspend() to
> acpi_thermal_prepare() and point the .prepare() driver callback to it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/thermal.c |   37 +++++++++++++------------------------
>   1 file changed, 13 insertions(+), 24 deletions(-)
>
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -911,37 +911,26 @@ static void acpi_thermal_remove(struct p
>   }
>   
>   #ifdef CONFIG_PM_SLEEP
> -static int acpi_thermal_suspend(struct device *dev)
> +static int acpi_thermal_prepare(struct device *dev)
>   {
>   	/* Make sure the previously queued thermal check work has been done */
>   	flush_workqueue(acpi_thermal_pm_queue);
>   	return 0;
>   }
>   
> -static int acpi_thermal_resume(struct device *dev)
> +static void acpi_thermal_complete(struct device *dev)
>   {
> -	struct acpi_thermal *tz = dev_get_drvdata(dev);
> -	int i, j;
> -
> -	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
> -		struct acpi_thermal_trip *acpi_trip = &tz->trips.active[i].trip;
> -
> -		if (!acpi_thermal_trip_valid(acpi_trip))
> -			break;
> -
> -		for (j = 0; j < acpi_trip->devices.count; j++)
> -			acpi_bus_update_power(acpi_trip->devices.handles[j], NULL);
> -	}
> -
> -	acpi_queue_thermal_check(tz);
> -
> -	return AE_OK;
> +	acpi_queue_thermal_check(dev_get_drvdata(dev));
>   }
> -#else
> -#define acpi_thermal_suspend	NULL
> -#define acpi_thermal_resume	NULL
> -#endif
> -static SIMPLE_DEV_PM_OPS(acpi_thermal_pm, acpi_thermal_suspend, acpi_thermal_resume);
> +
> +static const struct dev_pm_ops acpi_thermal_pm_ops = {
> +	.prepare = acpi_thermal_prepare,
> +	.complete = acpi_thermal_complete,
> +};
> +#define ACPI_THERMAL_PM	&acpi_thermal_pm_ops
> +#else /* !CONFIG_PM_SLEEP */
> +#define ACPI_THERMAL_PM	NULL
> +#endif /* CONFIG_PM_SLEEP */
>   
>   static const struct acpi_device_id  thermal_device_ids[] = {
>   	{ACPI_THERMAL_HID, 0},
> @@ -955,7 +944,7 @@ static struct platform_driver acpi_therm
>   	.driver = {
>   		.name = "acpi-thermal",
>   		.acpi_match_table = thermal_device_ids,
> -		.pm = &acpi_thermal_pm,
> +		.pm = ACPI_THERMAL_PM,
>   	},
>   };
>   
This rework is good to me. It is more reasonable.
Acked-by: lihuisong@huawei.com
>
>
>
>

