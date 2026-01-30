Return-Path: <linux-acpi+bounces-20778-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIvUFkgEfGl9KAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20778-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 02:07:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3505B611C
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 02:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9675A300334A
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 01:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDCE318EF1;
	Fri, 30 Jan 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ4tiUI1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A82D592C
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769735236; cv=none; b=aT9ZTWkaQvVfg6fHYeBI2uJ1LAYuTCnkZnl7Yu7l29CFCfo9lrl16tcy4439o7vI8kicicVBHMMbAsK0ElIf9xjjmCSaPIGkh6Hf3gEhIX7xWXU/+VnKq0lZwLa+YbDDgNs0jCMMhVPJYE5EMQ4Jahk5x2hDKO/S1FxdzytbF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769735236; c=relaxed/simple;
	bh=ey8Fbrghv7IvrGEVHmiOmjsd9IdlArAVq9BRuOs7XZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDa8Rhlo+wXDrEmgs8u2WGacuvGs3Df6vDafMqJbo8yOHLY1j4MoqhjvHtlTvEdiWnBoxHHgjnR3YrVuUEVjdp1zXF/AvIdOGcNEzg6wUHCiD192NA1AyRaOmRnkKcbqzKRZ6ht7wVZuZGJgGA3yybOgbGy8HRC3OG9GFMbHi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ4tiUI1; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124a677c9afso1014445c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769735233; x=1770340033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=wAscem/PhzVmAIvKDxb8vKQL9uTniWeS58kyl4SqDM4=;
        b=FZ4tiUI10byymFfIiWGySG48CHuPAQ6xStmSX60g9beQTT+WFGKaG1jsNS4J/zZr0L
         478Gq0PYrcZtf5cqRWM7VdaUe9zO0nn/bqDvQ4NkK3KhbbSZEs3ysnRRihtrjCIqTEAX
         PoMCGPo0laLDQSXksNcOzy6c5aBqSI94vTHbvd2LECaWgoKk0URDGVP6vq13mELx2qZN
         VZ1+Pz/v27G2pBzX/NmNQl12o1nf399MzonV/DwYWMBJW/YGblClyF+fYsotBAA5p71R
         SCiDm8aBpHKYF29l+d59MJFSERx62LTPOsZdiH438LaqLY8tFIHWa3hnEcj7RRqVe8h+
         8bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769735233; x=1770340033;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAscem/PhzVmAIvKDxb8vKQL9uTniWeS58kyl4SqDM4=;
        b=Nz7TefYys8P6/g6FHKu6JCxYAhBotuQMCTiWNoWsRU6UvqZchfd7dcuaXsKdzrteQ2
         dDI6frcaX80AvTQdKY8GG4IWhMyqvwqC5or+JFNBJ2nKC2+ouD8SEKNN0dROOiF6vaJ2
         wjg8LQBuGwlsr3A5UcIdanuoq8rt7AkROQ8wyUNBe79eeX3gGIQqkMW2ePZ/RJ5zByDT
         YEElGhGcImjPiZJckZZ4K9k+tYbAzukd1UsAlhqx6kINsl1rMnXn9eWshZ2MEa3MzTiW
         +ysGwvR9bqlxzPDubZRhCczoV7OQintZclqWumQ5YXw5XUsmBT7T6Kg8y4wrUMb+H+65
         mtxg==
X-Gm-Message-State: AOJu0YzfgDjJ7/quXYNm+jCW+rD2MDY+SOUFSrnY96tXeB+4XEfKqEpi
	QxlS4nYiauKD3BDb0jcPyYCATWQMdv6XdRyoRGSXgjFcIB4HbuTT7AuF
X-Gm-Gg: AZuq6aJKPJp7xEi3mjuw6VgCdu/SprvSF9pgWewZ7IYkUwosyBfYZvaCsRQaW+k/XXY
	H9Ee9qOVHsyFS2LN0olfiYeGvNVF2NPMQ64Bt+hZop7/Ov2FdplturSapMK3s/HqMjFKc5nYFDX
	eOldB+TIbJmRMgFBJJ71rtx+IDjiORgprVIxlLctkVVlA8Nr3Z0kOkQb+XqXXlKJ4ZuQoBune0h
	mEbwPF3lR4GhmJnvFZfeYoL7CXpTRa9an+FdeCI5WXpPqwFH2rYXsX0pGJcHOiY6SiK4AMrbSAb
	7cfcjQpBjbMBUQT7rXNLpNwpAnWECqKiPUSFQgWOs8gsOzEfPXIbOKcUJ36dPjP/M8ygwJ2yXv5
	39WTR5CNAOi6uoorsgYLaNeHwo2E+LkTqx9b//hgHOk2Up6w5Di82wgFPtTtILhwKbQkcoBTA7T
	V42LhDjy/yCsY8/j0PqgyZ24RT7lIVc/AG9Diin6/zYTN/Xq6zrFCyciGcdw94
X-Received: by 2002:a05:7300:8b24:b0:2b7:1e86:35ee with SMTP id 5a478bee46e88-2b7c88dd706mr586827eec.28.1769735233062;
        Thu, 29 Jan 2026 17:07:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a17083dasm11526554eec.14.2026.01.29.17.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 17:07:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e30972fa-62de-401a-8fc2-a48a66ca2c73@roeck-us.net>
Date: Thu, 29 Jan 2026 17:07:11 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6252535.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20778-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,roeck-us.net:mid]
X-Rspamd-Queue-Id: E3505B611C
X-Rspamd-Action: no action

Hi Rafael,

On 1/29/26 06:18, Rafael J. Wysocki wrote:
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to acpi_power_meter_notify()
> 
> The acpi_power_meter driver's .notify() callback function,
> acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
> that is also acquired by callbacks in sysfs attributes of the device
> being unregistered which is prone to deadlocks between sysfs access and
> device removal.
> 
> Address this by moving the hwmon device removal in
> acpi_power_meter_notify() outside the lock in question, but notice
> that doing it alone is not sufficient because two concurrent
> METER_NOTIFY_CONFIG notifications may be attempting to remove the
> same device at the same time.  To prevent that from happening, add a
> new lock serializing the execution of the switch () statement in
> acpi_power_meter_notify().  For simplicity, it is a static mutex
> which should not be a problem from the performance perspective.
> 
> The new lock also allows the hwmon_device_register_with_info()
> in acpi_power_meter_notify() to be called outside the inner lock
> because it prevents the other notifications handled by that function
> from manipulating the "resource" object while the hwmon device based
> on it is being registered.  The sending of ACPI netlink messages from
> acpi_power_meter_notify() is serialized by the new lock too which
> generally helps to ensure that the order of handling firmware
> notifications is the same as the order of sending netlink messages
> related to them.
> 
> In addition, notice that hwmon_device_register_with_info() may fail
> in which case resource->hwmon_dev will become an error pointer,
> so add checks to avoid attempting to unregister the hwmon device
> pointer to by it in that case to acpi_power_meter_notify() and
> acpi_power_meter_remove().
> 
> Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register")
> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> --- a/drivers/hwmon/acpi_power_meter.c
> +++ b/drivers/hwmon/acpi_power_meter.c
> @@ -47,6 +47,8 @@
>   static int cap_in_hardware;
>   static bool force_cap_on;
>   
> +static DEFINE_MUTEX(acpi_notify_lock);
> +
>   static int can_cap_in_hardware(void)
>   {
>   	return force_cap_on || cap_in_hardware;
> @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
>   
>   	resource = acpi_driver_data(device);
>   
> +	guard(mutex)(&acpi_notify_lock);
> +
>   	switch (event) {
>   	case METER_NOTIFY_CONFIG:
> +		if (!IS_ERR(resource->hwmon_dev))
> +			hwmon_device_unregister(resource->hwmon_dev);
> +
>   		mutex_lock(&resource->lock);
> +
>   		free_capabilities(resource);
>   		remove_domain_devices(resource);
> -		hwmon_device_unregister(resource->hwmon_dev);
>   		res = read_capabilities(resource);
>   		if (res)
>   			dev_err_once(&device->dev, "read capabilities failed.\n");
>   		res = read_domain_devices(resource);
>   		if (res && res != -ENODEV)
>   			dev_err_once(&device->dev, "read domain devices failed.\n");
> +
> +		mutex_unlock(&resource->lock);
> +
>   		resource->hwmon_dev =
>   			hwmon_device_register_with_info(&device->dev,
>   							ACPI_POWER_METER_NAME,
> @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
>   							power_extra_groups);
>   		if (IS_ERR(resource->hwmon_dev))
>   			dev_err_once(&device->dev, "register hwmon device failed.\n");
> -		mutex_unlock(&resource->lock);
> +
>   		break;
>   	case METER_NOTIFY_TRIP:
>   		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
>   		return;
>   
>   	resource = acpi_driver_data(device);
> -	hwmon_device_unregister(resource->hwmon_dev);
> +	if (!IS_ERR(resource->hwmon_dev))
> +		hwmon_device_unregister(resource->hwmon_dev);

Gemini says that this is still racy:

Description: Race condition between remove and notify. acpi_power_meter_remove()
unregisters the hwmon device and frees the resource structure without acquiring
acpi_notify_lock. If acpi_power_meter_notify() is running concurrently (e.g.
waiting on the lock), remove() can free the resource while notify() still holds
a pointer to it. When notify() acquires the lock, it will access the freed
resource (Use-After-Free).

Additionally, both functions may attempt to unregister the same hwmon device
concurrently (Double Unregister) because remove() reads resource->hwmon_dev
without protection. acpi_power_meter_remove() must acquire acpi_notify_lock
and clear device->driver_data, and acpi_power_meter_notify() must re-validate
the resource pointer after acquiring the lock.

Maybe I am missing something, but I think it has a point. it is not a new
problem, but still ...

Thanks,
Guenter


