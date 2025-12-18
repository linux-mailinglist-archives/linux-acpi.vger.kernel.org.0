Return-Path: <linux-acpi+bounces-19644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656CCCCA785
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 07:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1F98304AF68
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Dec 2025 06:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9E63242C2;
	Thu, 18 Dec 2025 06:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="EwP5qRgg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD62857FA;
	Thu, 18 Dec 2025 06:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039447; cv=none; b=aTzCSQkNnc+TnOL7ckvpKuhhibG0s8/ltyIxIuGuEK7NbTGaIl4KrE5WRNHU3mrHd4LNwWMS92rVP8UEamf9gZLDOPxQpnZxUEzwewpG6QIiMUOuY6cB85yCl/A5Mw5viP+N2O4A6iXv04WPyH2JJ2meiMfEy+usD5UswgwYrzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039447; c=relaxed/simple;
	bh=SizuWiqIqZ8ezN4udoq7mTx/3t4f/tybBhLRZ1/49fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=auJsk4mHpfU73EkDqFDAhkYCEP5/B3LHSE8Yvuh0hP8SQRMEe1y/ooMBNE5kBQmYsma3JWErut9zHSdQ/0VUeTdN6dxwanGOLgVqeSYljWfwlnEHHiwEhUQvIdU2EFAhQuRKGEOOpZNeTfpKXuG3cC3JiRSC4ND2B3ecA6DLK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=EwP5qRgg; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=XvkJFEQkItonr9XR8mhewXPtYOya9WizgmajRRfi6js=;
	b=EwP5qRggB6LfkAfR0JnvVVLaoHyVrAaey7BbvvZyPxmhc6r7dthYL6LYfj2MZ8JOykGXnSGd9
	fDLsuhOy0aBoFjX7ZAITqem2umYgK8K9oZaGomm8Pw21/o7iUbTQyLEMBiEjPgt+Y3xXlnszimr
	5PXs0LVW3t2aUbXx7puqXiI=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dX12N4vTMz1T4GD;
	Thu, 18 Dec 2025 14:28:28 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 163E414022E;
	Thu, 18 Dec 2025 14:30:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 14:30:41 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 14:30:41 +0800
Message-ID: <5cda66c6-8e89-4931-830f-f1b25d53903e@huawei.com>
Date: Thu, 18 Dec 2025 14:30:40 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] ACPI: thermal: Adjust event notification routine
To: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
References: <6222428.lOV4Wx5bFT@rafael.j.wysocki>
 <5035876.GXAFRqVoOG@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <5035876.GXAFRqVoOG@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemn100009.china.huawei.com (7.202.194.112)


在 2025/12/10 22:43, Rafael J. Wysocki 写道:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Adjust acpi_thermal_notify() to cast its "data" argument to a struct
> acpi_thermal pointer istead of a struct acpi_device one, which allows
> the use of acpi_driver_data() to be limited and will facilitate
> subsequent changes.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/thermal.c |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -670,8 +670,7 @@ static void acpi_thermal_unregister_ther
>   
>   static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
>   {
> -	struct acpi_device *device = data;
> -	struct acpi_thermal *tz = acpi_driver_data(device);
> +	struct acpi_thermal *tz = data;
>   
>   	if (!tz)
>   		return;
> @@ -685,8 +684,8 @@ static void acpi_thermal_notify(acpi_han
>   		acpi_thermal_trips_update(tz, event);
>   		break;
>   	default:
> -		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
> -				  event);
> +		acpi_handle_debug(tz->device->handle,
> +				  "Unsupported event [0x%x]\n", event);
>   		break;
>   	}
>   }
> @@ -881,7 +880,7 @@ static int acpi_thermal_add(struct acpi_
>   		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temp_dk));
>   
>   	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> -						 acpi_thermal_notify, device);
> +						 acpi_thermal_notify, tz);
>   	if (result)
>   		goto flush_wq;
>   
LGTM,
Acked-by: lihuisong@huawei.com
>
>
>

