Return-Path: <linux-acpi+bounces-20779-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OItWHaINfGkyKQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20779-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 02:47:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D44FAB6418
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 02:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90149301413D
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2C21CC62;
	Fri, 30 Jan 2026 01:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="ZSqB55ex"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAE1F0E2E;
	Fri, 30 Jan 2026 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737629; cv=none; b=oz/FayMjnSnissOwyGKWUbvrQKrrR1mxRiMyYZFgrxJ6iIW7c7mLM/oMZTXXs4w3Tn3QtFrB7BLSL/Whb/g4unh102SWDfqLt8O4eGffiGAzxNvoPOuThCsyYXQMlBiLPO3ge6O1hwbFAyCWIIcpcMgKd/1+HfQu4EYFGqmmR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737629; c=relaxed/simple;
	bh=rhtjunAyLrQfKXt+o0o+R7BYwOZrQyp3aHgBfQwHpGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GJr1YvpWkUR4oapdhMuWS+efG7ISDxizv5bnWYrA5ByhdC/StoGK91J1JdcOwGVtsnxKxtSMJR9yDNhaL4+/1Ootfeu6mPeqxZoUr4BdnLcmDSbc6QouoXPoe79INyecXtqGZPguQr3Z0FLuGr2CNO1d+2ZPU/LdG/iecxdKjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=ZSqB55ex; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3woYsrYL4vY5mM4WGG6FK+ux8A1LQ5/qLYOgx3LgGh8=;
	b=ZSqB55exqiZXhkmuHhiHwxj7SBwf2Xgt1761TSvD6l3pYmR9e/Tgyg6E2g2wIx9GNvebPVVh4
	BBPkajdkl7gC6QO8KUYNjO3iQi0XbKWjVMvhoH/CE7zCHSennAsEdWqejxHfMnX4zXIwFVSqb2I
	P16bSfcP0o1I2W51pAWraLY=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4f2Jgp21H7z1cyT9;
	Fri, 30 Jan 2026 09:43:34 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id C62E240565;
	Fri, 30 Jan 2026 09:47:02 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 09:47:02 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 30 Jan
 2026 09:47:01 +0800
Message-ID: <b81b86c8-7780-4b11-8830-09ab9c7dd679@huawei.com>
Date: Fri, 30 Jan 2026 09:47:00 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Guenter Roeck
	<linux@roeck-us.net>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
CC: <linux-acpi@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Igor Raits
	<igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek
	<zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <6252535.lOV4Wx5bFT@rafael.j.wysocki>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20779-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,gooddata.com:email,huawei.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D44FAB6418
X-Rspamd-Action: no action


On 1/29/2026 10:18 PM, Rafael J. Wysocki wrote:
> On Wednesday, January 28, 2026 10:52:15 PM CET Guenter Roeck wrote:
>> On Wed, Jan 28, 2026 at 08:52:49PM +0100, Rafael J. Wysocki wrote:
>>> On Wednesday, January 28, 2026 7:45:32 PM CET Rafael J. Wysocki wrote:
>>>> On Wed, Jan 28, 2026 at 7:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>> Hi all,
>>>>>
>>>>> On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
>>>>>> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
>>>>>> <jaroslav.pulchart@gooddata.com> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
>>>>>>> in the ACPI power meter hwmon interface. Reading power*_average sysfs
>>>>>>> attributes blocks indefinitely and causes tasks to enter uninterruptible
>>>>>>> sleep (D state).
>>>>>> The most recent change in the acpi_power_meter driver was made in
>>>>>> 6.15, so this is not a regression in that driver.
>>>>>>
>>>>>> Also, nothing suspicious is done in power1_average_min_show() and
>>>>>> power1_average_min_store() AFAICS.
>>>>>>
>>>>> I decided to ask AI (Gemini 3, more specifically) for an analysis of the
>>>>> problem, using Chris Mason's prompts for guidance. Result is below.
>>>> So it agrees with me in the analysis part.
>>>>
>> Yes.
>>
>>>>> The suggested fix may be a feasible workaround. Let me know what you think.
>>>> Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
>>>> notifications compete with each other because they may try to
>>>> unregister the hwmon device at the same time.
>>>>
>> Good point.
>>
>>>> I would just add a separate lock for the notifier (a static one should
>>>> suffice) and make changes to "resource" only under resource->lock.
>>>>
>>>> Let me cut a prototype patch for this.
>>>>
>>> Something like the below (untested).
>>>
>>> Note that it also fixes the driver removal which is tangentially related to the
>>> problem at hand.
>> I can't test it either, but I ran it through Gemini and it tells me:
>>
>>    Fixes: tag missing (y) [Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hwmon_device_register")]
>>
>>    The commit addresses a deadlock regression introduced by the conversion to
>>    hwmon_device_register_with_info.
>>
>>    CHANGE-1: New static mutex `acpi_notify_lock` introduces global serialization.
>>    This prevents concurrent notification handling for multiple power meter devices.
>>    While likely a minor impact given the nature of the device, it technically reduces parallelism compared to the per-device locking used previously.
>>
>> Just for fun I tried again, this time using a model which is more prone to
>> false positives. It pretty much provided the same result in more detail.
>> It is a bit more verbose, so I attached it below. I also asked it to verify,
>> using the backtrace, if the patch is complete, and to suggest a patch
>> description. The result is also attached below.
>>
>> I think this is good enough for a formal patch. WDYT ?
> With all due respect to the AI, I think that it has missed a couple of things,
> so below it the patch with my version of the changelog.
>
> Also, it really wants to be two patches IMV, one adding the
> IS_ERR(resource->hwmon_dev) checks before hwmon device unregistration and
> another one fixing the deadlock in question on top of it.  Please let me know
> if you want me to split this one.
>
> Jaroslav, it would be nice to get some feedback on it from you as you seem to
> be the only person here who can test it.
>
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
>   
!IS_ERR(resource->hwmon_dev) may be not enough. There might be UAF in 
concurrent case.
How about do it like:
if (!IS_ERR_OR_NULL(resource->hwmon_dev)) {
        hwmon_device_unregister(resource->hwmon_dev);
        resource->hwmon_dev = NULL;
}
>   	remove_domain_devices(resource);
>   	free_capabilities(resource);
>
>
>
>
>

