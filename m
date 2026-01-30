Return-Path: <linux-acpi+bounces-20781-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMkkGLU8fGkXLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20781-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 06:08:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA48B7316
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 06:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB05300D943
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 05:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A933C32863A;
	Fri, 30 Jan 2026 05:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPvpzaao"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF322F7468
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 05:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749682; cv=none; b=ItbivDrndK3N8thVyzXR3W+GJ6S5spxsw15Hn0YFtMu99+f1YE/P0l4N8NqUWB/EIAA43HEtVol3L8ScjWsHR0s3jSCYCrouErXorfGIIIBgwzpv97yt/mhP7cxJAONpZgu9uApvSC73b6RK6LoTtC1Hu3sgnkTzRQekUTG/L9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749682; c=relaxed/simple;
	bh=GSH5tHk5SWKVSklEWFc2Ly4oI1ecK6IsxFkPVk7eAfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7XrbTp/hUoHwp6O8fh6Q1Ulc98PVOPhW9LVQAmMV6zpswrugOv9zFO/r1t6838tKHFGwrtMKXUhsliijRhqp1pVWA2mFeAZxT7Zi6MOcijh2dpooOp+iCcWvmtQup+KFoXJygFcLflwO1mYbcvQJZiVTlw0OQqNZf6tUnPBfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPvpzaao; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a79ded11a2so12222475ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jan 2026 21:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769749680; x=1770354480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ol3KulPHGcGLaSH0nqQg+1bDoYZNOGYWiNxRmEAa5U=;
        b=gPvpzaaoVQbBn+RCCvGCzOlApMe6fHYJ4agRj23XzofVFNBkHRyCI0Vc5EKsmdruF0
         swXuIh/shsin7pR9+XFCXLs2HU03vdsoeLVd19DMH7zBE9Tj8To2nvQ/ftUCJaW8pUMB
         abiTMhweoDEgSG1ZTIpUWbxI1RMLCFDxxsknZ5JZBeik2DsHd5k4GtxOYlkZmMu6Kr1G
         66Vu+5mwJBhY7GZYcxFD8p1x4vGQ/LtccmldGyl49leZNtxP1H1yS7mdMmDwkWlZIHyW
         9WFqTPq8vMP5pjCyHdhxpGM3ls35w5vtYHrjGOH8lTruct4RJnjPufwdgZfADk6sHpGZ
         WUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769749680; x=1770354480;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ol3KulPHGcGLaSH0nqQg+1bDoYZNOGYWiNxRmEAa5U=;
        b=OmbJyWYKrgRkyskcrtHHqF8acC+HCo/QRKx1h8PXOttrM2NeRij/dL0ZAvxct3m6Q3
         tF94HCtpwRn+wjLB1pnqYkXSEMhVGUtnSJT9xW/fp2tnZ2QbqWsWwHogiVPb/o86h0p+
         nQmUZHmE2ACy4CkC70cP05pMaC4lHATwjd5bzQtdgyX9LUnD1Ll48cHt9M9PKE+oaNSi
         Pb4VfifnwOVI7W2Nt5WTiAQinr3aV2emBEJc2C1epJBEJN9CRtW/jkj/L8jRf5V8kokB
         3RivzEsP/Ebh9a1tv8DVDmkXQ56HrYV5tzdl+Vjcdq2Fomimy5VYlVoYARkyjjP7k5HO
         uILA==
X-Gm-Message-State: AOJu0Yy9NuT7YhVtqDcZs8u2kbvtH5noQLLr0xnUJksJHMs4wMMfG3Er
	+3nuYuVidRdSKOXJgjDaC8moOKB2lfxjli2CAy31ThKR9HHp2vhTq/a/
X-Gm-Gg: AZuq6aIxKAfREljW8x32xQdezOcoz30U0Ja98VToeq29iSbqM9Ciy5uSqIWI7zcYOKw
	vlpkgcLuDhWh4AwIwQNCJBt4N1y7N8PxYF5LuCS3AKAmgHc8USAujd6Ueqo+3ybHWeTEYCy2U7V
	qElQASil8ttWPG1UOv+89vRpPa5seyjiJSiTOJ8tQyIaB6iE5wl3uVClvdUc/srFts+ET1Di1fK
	C6SYslJ0pq4keoZoCOb76b/rnUeR8MqgnDl+fXtfADenty2LpFV+OY6qclEdcc24WhZdfpl5Myp
	pEkvVa9uCFP+4nVStG/IR6AQmWa2YemKub/BIikqyNiUocZDXVm/mRw16R5Nlru+gLlWvZ+gizY
	9x7ZCscw56cdHlgrVbMdT3FnuEStju8acCAiRjrqimqTQqU4hI3oYCAAqczqp1junzzHq1d5XE7
	87zueIbYR3y4r6JA1iq/fBF1Vk16GS3/lTr5As4D1cW5v7fP7VTP0Rwmq1G+ev
X-Received: by 2002:a17:903:2bcc:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2a8d9592d8dmr16849295ad.5.1769749679909;
        Thu, 29 Jan 2026 21:07:59 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b41390bsm62784535ad.23.2026.01.29.21.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 21:07:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a980cd48-6dd1-4e90-a872-821ffe799281@roeck-us.net>
Date: Thu, 29 Jan 2026 21:07:57 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
To: "lihuisong (C)" <lihuisong@huawei.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki>
 <b81b86c8-7780-4b11-8830-09ab9c7dd679@huawei.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <b81b86c8-7780-4b11-8830-09ab9c7dd679@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-20781-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[roeck-us.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@roeck-us.net,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 8CA48B7316
X-Rspamd-Action: no action

On 1/29/26 17:47, lihuisong (C) wrote:
> 
> On 1/29/2026 10:18 PM, Rafael J. Wysocki wrote:
>> On Wednesday, January 28, 2026 10:52:15 PM CET Guenter Roeck wrote:
>>> On Wed, Jan 28, 2026 at 08:52:49PM +0100, Rafael J. Wysocki wrote:
>>>> On Wednesday, January 28, 2026 7:45:32 PM CET Rafael J. Wysocki wrote:
>>>>> On Wed, Jan 28, 2026 at 7:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
>>>>>>> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
>>>>>>> <jaroslav.pulchart@gooddata.com> wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
>>>>>>>> in the ACPI power meter hwmon interface. Reading power*_average sysfs
>>>>>>>> attributes blocks indefinitely and causes tasks to enter uninterruptible
>>>>>>>> sleep (D state).
>>>>>>> The most recent change in the acpi_power_meter driver was made in
>>>>>>> 6.15, so this is not a regression in that driver.
>>>>>>>
>>>>>>> Also, nothing suspicious is done in power1_average_min_show() and
>>>>>>> power1_average_min_store() AFAICS.
>>>>>>>
>>>>>> I decided to ask AI (Gemini 3, more specifically) for an analysis of the
>>>>>> problem, using Chris Mason's prompts for guidance. Result is below.
>>>>> So it agrees with me in the analysis part.
>>>>>
>>> Yes.
>>>
>>>>>> The suggested fix may be a feasible workaround. Let me know what you think.
>>>>> Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
>>>>> notifications compete with each other because they may try to
>>>>> unregister the hwmon device at the same time.
>>>>>
>>> Good point.
>>>
>>>>> I would just add a separate lock for the notifier (a static one should
>>>>> suffice) and make changes to "resource" only under resource->lock.
>>>>>
>>>>> Let me cut a prototype patch for this.
>>>>>
>>>> Something like the below (untested).
>>>>
>>>> Note that it also fixes the driver removal which is tangentially related to the
>>>> problem at hand.
>>> I can't test it either, but I ran it through Gemini and it tells me:
>>>
>>>    Fixes: tag missing (y) [Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register")]
>>>
>>>    The commit addresses a deadlock regression introduced by the conversion to
>>>    hwmon_device_register_with_info.
>>>
>>>    CHANGE-1: New static mutex `acpi_notify_lock` introduces global serialization.
>>>    This prevents concurrent notification handling for multiple power meter devices.
>>>    While likely a minor impact given the nature of the device, it technically reduces parallelism compared to the per-device locking used previously.
>>>
>>> Just for fun I tried again, this time using a model which is more prone to
>>> false positives. It pretty much provided the same result in more detail.
>>> It is a bit more verbose, so I attached it below. I also asked it to verify,
>>> using the backtrace, if the patch is complete, and to suggest a patch
>>> description. The result is also attached below.
>>>
>>> I think this is good enough for a formal patch. WDYT ?
>> With all due respect to the AI, I think that it has missed a couple of things,
>> so below it the patch with my version of the changelog.
>>
>> Also, it really wants to be two patches IMV, one adding the
>> IS_ERR(resource->hwmon_dev) checks before hwmon device unregistration and
>> another one fixing the deadlock in question on top of it.  Please let me know
>> if you want me to split this one.
>>
>> Jaroslav, it would be nice to get some feedback on it from you as you seem to
>> be the only person here who can test it.
>>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to acpi_power_meter_notify()
>>
>> The acpi_power_meter driver's .notify() callback function,
>> acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
>> that is also acquired by callbacks in sysfs attributes of the device
>> being unregistered which is prone to deadlocks between sysfs access and
>> device removal.
>>
>> Address this by moving the hwmon device removal in
>> acpi_power_meter_notify() outside the lock in question, but notice
>> that doing it alone is not sufficient because two concurrent
>> METER_NOTIFY_CONFIG notifications may be attempting to remove the
>> same device at the same time.  To prevent that from happening, add a
>> new lock serializing the execution of the switch () statement in
>> acpi_power_meter_notify().  For simplicity, it is a static mutex
>> which should not be a problem from the performance perspective.
>>
>> The new lock also allows the hwmon_device_register_with_info()
>> in acpi_power_meter_notify() to be called outside the inner lock
>> because it prevents the other notifications handled by that function
>> from manipulating the "resource" object while the hwmon device based
>> on it is being registered.  The sending of ACPI netlink messages from
>> acpi_power_meter_notify() is serialized by the new lock too which
>> generally helps to ensure that the order of handling firmware
>> notifications is the same as the order of sending netlink messages
>> related to them.
>>
>> In addition, notice that hwmon_device_register_with_info() may fail
>> in which case resource->hwmon_dev will become an error pointer,
>> so add checks to avoid attempting to unregister the hwmon device
>> pointer to by it in that case to acpi_power_meter_notify() and
>> acpi_power_meter_remove().
>>
>> Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register")
>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
>>   1 file changed, 14 insertions(+), 3 deletions(-)
>>
>> --- a/drivers/hwmon/acpi_power_meter.c
>> +++ b/drivers/hwmon/acpi_power_meter.c
>> @@ -47,6 +47,8 @@
>>   static int cap_in_hardware;
>>   static bool force_cap_on;
>> +static DEFINE_MUTEX(acpi_notify_lock);
>> +
>>   static int can_cap_in_hardware(void)
>>   {
>>       return force_cap_on || cap_in_hardware;
>> @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
>>       resource = acpi_driver_data(device);
>> +    guard(mutex)(&acpi_notify_lock);
>> +
>>       switch (event) {
>>       case METER_NOTIFY_CONFIG:
>> +        if (!IS_ERR(resource->hwmon_dev))
>> +            hwmon_device_unregister(resource->hwmon_dev);
>> +
>>           mutex_lock(&resource->lock);
>> +
>>           free_capabilities(resource);
>>           remove_domain_devices(resource);
>> -        hwmon_device_unregister(resource->hwmon_dev);
>>           res = read_capabilities(resource);
>>           if (res)
>>               dev_err_once(&device->dev, "read capabilities failed.\n");
>>           res = read_domain_devices(resource);
>>           if (res && res != -ENODEV)
>>               dev_err_once(&device->dev, "read domain devices failed.\n");
>> +
>> +        mutex_unlock(&resource->lock);
>> +
>>           resource->hwmon_dev =
>>               hwmon_device_register_with_info(&device->dev,
>>                               ACPI_POWER_METER_NAME,
>> @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
>>                               power_extra_groups);
>>           if (IS_ERR(resource->hwmon_dev))
>>               dev_err_once(&device->dev, "register hwmon device failed.\n");
>> -        mutex_unlock(&resource->lock);
>> +
>>           break;
>>       case METER_NOTIFY_TRIP:
>>           sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>> @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
>>           return;
>>       resource = acpi_driver_data(device);
>> -    hwmon_device_unregister(resource->hwmon_dev);
>> +    if (!IS_ERR(resource->hwmon_dev))
>> +        hwmon_device_unregister(resource->hwmon_dev);
> !IS_ERR(resource->hwmon_dev) may be not enough. There might be UAF in concurrent case.
> How about do it like:
> if (!IS_ERR_OR_NULL(resource->hwmon_dev)) {

Not sure what you mean with 'concurrent' case. There is a potential race with the
notification code, as mentioned in my other mail. Question is if the acpi subsystem
disables notification calls before the remove function is called, and guarantees
that no notifications are pending. If so, I don't think there is a problem.
Also, resource->hwmon_dev should never be NULL.

Thanks,
Guenter

>         hwmon_device_unregister(resource->hwmon_dev);
>         resource->hwmon_dev = NULL;
> }
>>       remove_domain_devices(resource);
>>       free_capabilities(resource);
>>
>>
>>
>>
>>


