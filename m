Return-Path: <linux-acpi+bounces-20793-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEmrGivUfWm9TwIAu9opvQ
	(envelope-from <linux-acpi+bounces-20793-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 11:06:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B7C1783
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 11:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B650F3002304
	for <lists+linux-acpi@lfdr.de>; Sat, 31 Jan 2026 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0B33A9E8;
	Sat, 31 Jan 2026 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="IPXOr/Uf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1A32863A;
	Sat, 31 Jan 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769853990; cv=none; b=BS/09BMdO2eVvuU+M+tXS0hCz90//Cfn7rAuWTLAY8MBQXbZyjtjhSBtZ5f7kyAG5lZgOCduosoJ9ObW8WOfMUIAvaIn5sSDEIlRXnN86Oj38hsV6IxuDq47MsIos6LxZj31CPlXGM5scHKFI8eBS22Q+1r2tsZCj3+2fh/qQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769853990; c=relaxed/simple;
	bh=tAFAjQYAEwyzJwJm4npU0MWJPLKgIG5SE1yVRi+D8qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZOnneFLyYd/e/oJmwHpdwWdRYx4cJcm5r7SQZgqIUJDEegTvfB5Pfki51VTrs6q00ABqxogvlwfrqnABgGGR520vmykksTJHWWVGdKZrN0qGYLa0dGVLUuYLxBHdUPFBexe0rYIwmKdPdPQ4PHOr/t+cqK4mZFvbHhJ3XfGH/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=IPXOr/Uf; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Cbl68WIFyMtlM1bsnS9e9JwHwzg6RzjTHaaF6rzNdTg=;
	b=IPXOr/Uf1a85lOy/KQ7o6BkMhTy0hLaSiZ086mZppeGNfA613Llmt1IDwrlXkqBBzpopFJ2g+
	m6uLb2qvYdP74N1Oh4Y9eufmEA6tCuY13/Qs42aK0OeE5P2yYBXAtbN8JzVE6OO/5eEes/tby3B
	7/Y3zYvH8TK/4JaR3bwd7PA=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4f37jN23v0zmV6j;
	Sat, 31 Jan 2026 18:02:48 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id B700940567;
	Sat, 31 Jan 2026 18:06:18 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 31 Jan 2026 18:06:05 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 31 Jan
 2026 18:06:04 +0800
Message-ID: <0d8ab2ec-c296-4087-9f77-4389813c75a7@huawei.com>
Date: Sat, 31 Jan 2026 18:06:03 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Guenter Roeck <linux@roeck-us.net>, Jaroslav Pulchart
	<jaroslav.pulchart@gooddata.com>, <linux-acpi@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Igor Raits <igor@gooddata.com>, Daniel Secik
	<daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, "Jiri
 Jurica" <jiri.jurica@gooddata.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki>
 <b81b86c8-7780-4b11-8830-09ab9c7dd679@huawei.com>
 <a980cd48-6dd1-4e90-a872-821ffe799281@roeck-us.net>
 <b1e5f8dc-4093-4f03-946c-e455612a0c73@huawei.com>
 <CAJZ5v0gvSdm+FpaO8=RhfvE8SOQTTGwhmBhw9WJ6QLXkmahuww@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0gvSdm+FpaO8=RhfvE8SOQTTGwhmBhw9WJ6QLXkmahuww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20793-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gooddata.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 041B7C1783
X-Rspamd-Action: no action


On 1/31/2026 1:53 AM, Rafael J. Wysocki wrote:
> On Fri, Jan 30, 2026 at 9:40 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>>
>> On 1/30/2026 1:07 PM, Guenter Roeck wrote:
>>> On 1/29/26 17:47, lihuisong (C) wrote:
>>>> On 1/29/2026 10:18 PM, Rafael J. Wysocki wrote:
>>>>> On Wednesday, January 28, 2026 10:52:15 PM CET Guenter Roeck wrote:
>>>>>> On Wed, Jan 28, 2026 at 08:52:49PM +0100, Rafael J. Wysocki wrote:
>>>>>>> On Wednesday, January 28, 2026 7:45:32 PM CET Rafael J. Wysocki
>>>>>>> wrote:
>>>>>>>> On Wed, Jan 28, 2026 at 7:18 PM Guenter Roeck
>>>>>>>> <linux@roeck-us.net> wrote:
>>>>>>>>> Hi all,
>>>>>>>>>
>>>>>>>>> On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
>>>>>>>>>> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
>>>>>>>>>> <jaroslav.pulchart@gooddata.com> wrote:
>>>>>>>>>>> Hello,
>>>>>>>>>>>
>>>>>>>>>>> after upgrading from kernel 6.17.y to 6.18.y we started to
>>>>>>>>>>> observe a regression
>>>>>>>>>>> in the ACPI power meter hwmon interface. Reading
>>>>>>>>>>> power*_average sysfs
>>>>>>>>>>> attributes blocks indefinitely and causes tasks to enter
>>>>>>>>>>> uninterruptible
>>>>>>>>>>> sleep (D state).
>>>>>>>>>> The most recent change in the acpi_power_meter driver was made in
>>>>>>>>>> 6.15, so this is not a regression in that driver.
>>>>>>>>>>
>>>>>>>>>> Also, nothing suspicious is done in power1_average_min_show() and
>>>>>>>>>> power1_average_min_store() AFAICS.
>>>>>>>>>>
>>>>>>>>> I decided to ask AI (Gemini 3, more specifically) for an
>>>>>>>>> analysis of the
>>>>>>>>> problem, using Chris Mason's prompts for guidance. Result is below.
>>>>>>>> So it agrees with me in the analysis part.
>>>>>>>>
>>>>>> Yes.
>>>>>>
>>>>>>>>> The suggested fix may be a feasible workaround. Let me know what
>>>>>>>>> you think.
>>>>>>>> Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
>>>>>>>> notifications compete with each other because they may try to
>>>>>>>> unregister the hwmon device at the same time.
>>>>>>>>
>>>>>> Good point.
>>>>>>
>>>>>>>> I would just add a separate lock for the notifier (a static one
>>>>>>>> should
>>>>>>>> suffice) and make changes to "resource" only under resource->lock.
>>>>>>>>
>>>>>>>> Let me cut a prototype patch for this.
>>>>>>>>
>>>>>>> Something like the below (untested).
>>>>>>>
>>>>>>> Note that it also fixes the driver removal which is tangentially
>>>>>>> related to the
>>>>>>> problem at hand.
>>>>>> I can't test it either, but I ran it through Gemini and it tells me:
>>>>>>
>>>>>>     Fixes: tag missing (y) [Fixes: 16746ce8adfe ("hwmon:
>>>>>> (acpi_power_meter) Replace the deprecated hwmon_device_register")]
>>>>>>
>>>>>>     The commit addresses a deadlock regression introduced by the
>>>>>> conversion to
>>>>>>     hwmon_device_register_with_info.
>>>>>>
>>>>>>     CHANGE-1: New static mutex `acpi_notify_lock` introduces global
>>>>>> serialization.
>>>>>>     This prevents concurrent notification handling for multiple
>>>>>> power meter devices.
>>>>>>     While likely a minor impact given the nature of the device, it
>>>>>> technically reduces parallelism compared to the per-device locking
>>>>>> used previously.
>>>>>>
>>>>>> Just for fun I tried again, this time using a model which is more
>>>>>> prone to
>>>>>> false positives. It pretty much provided the same result in more
>>>>>> detail.
>>>>>> It is a bit more verbose, so I attached it below. I also asked it
>>>>>> to verify,
>>>>>> using the backtrace, if the patch is complete, and to suggest a patch
>>>>>> description. The result is also attached below.
>>>>>>
>>>>>> I think this is good enough for a formal patch. WDYT ?
>>>>> With all due respect to the AI, I think that it has missed a couple
>>>>> of things,
>>>>> so below it the patch with my version of the changelog.
>>>>>
>>>>> Also, it really wants to be two patches IMV, one adding the
>>>>> IS_ERR(resource->hwmon_dev) checks before hwmon device
>>>>> unregistration and
>>>>> another one fixing the deadlock in question on top of it. Please let
>>>>> me know
>>>>> if you want me to split this one.
>>>>>
>>>>> Jaroslav, it would be nice to get some feedback on it from you as
>>>>> you seem to
>>>>> be the only person here who can test it.
>>>>>
>>>>> ---
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related
>>>>> to acpi_power_meter_notify()
>>>>>
>>>>> The acpi_power_meter driver's .notify() callback function,
>>>>> acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
>>>>> that is also acquired by callbacks in sysfs attributes of the device
>>>>> being unregistered which is prone to deadlocks between sysfs access and
>>>>> device removal.
>>>>>
>>>>> Address this by moving the hwmon device removal in
>>>>> acpi_power_meter_notify() outside the lock in question, but notice
>>>>> that doing it alone is not sufficient because two concurrent
>>>>> METER_NOTIFY_CONFIG notifications may be attempting to remove the
>>>>> same device at the same time.  To prevent that from happening, add a
>>>>> new lock serializing the execution of the switch () statement in
>>>>> acpi_power_meter_notify().  For simplicity, it is a static mutex
>>>>> which should not be a problem from the performance perspective.
>>>>>
>>>>> The new lock also allows the hwmon_device_register_with_info()
>>>>> in acpi_power_meter_notify() to be called outside the inner lock
>>>>> because it prevents the other notifications handled by that function
>>>>> from manipulating the "resource" object while the hwmon device based
>>>>> on it is being registered.  The sending of ACPI netlink messages from
>>>>> acpi_power_meter_notify() is serialized by the new lock too which
>>>>> generally helps to ensure that the order of handling firmware
>>>>> notifications is the same as the order of sending netlink messages
>>>>> related to them.
>>>>>
>>>>> In addition, notice that hwmon_device_register_with_info() may fail
>>>>> in which case resource->hwmon_dev will become an error pointer,
>>>>> so add checks to avoid attempting to unregister the hwmon device
>>>>> pointer to by it in that case to acpi_power_meter_notify() and
>>>>> acpi_power_meter_remove().
>>>>>
>>>>> Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the
>>>>> deprecated hwmon_device_register")
>>>>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>    drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
>>>>>    1 file changed, 14 insertions(+), 3 deletions(-)
>>>>>
>>>>> --- a/drivers/hwmon/acpi_power_meter.c
>>>>> +++ b/drivers/hwmon/acpi_power_meter.c
>>>>> @@ -47,6 +47,8 @@
>>>>>    static int cap_in_hardware;
>>>>>    static bool force_cap_on;
>>>>> +static DEFINE_MUTEX(acpi_notify_lock);
>>>>> +
>>>>>    static int can_cap_in_hardware(void)
>>>>>    {
>>>>>        return force_cap_on || cap_in_hardware;
>>>>> @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
>>>>>        resource = acpi_driver_data(device);
>>>>> +    guard(mutex)(&acpi_notify_lock);
>>>>> +
>>>>>        switch (event) {
>>>>>        case METER_NOTIFY_CONFIG:
>>>>> +        if (!IS_ERR(resource->hwmon_dev))
>>>>> +            hwmon_device_unregister(resource->hwmon_dev);
>>>>> +
>>>>>            mutex_lock(&resource->lock);
>>>>> +
>>>>>            free_capabilities(resource);
>>>>>            remove_domain_devices(resource);
>>>>> -        hwmon_device_unregister(resource->hwmon_dev);
>>>>>            res = read_capabilities(resource);
>>>>>            if (res)
>>>>>                dev_err_once(&device->dev, "read capabilities
>>>>> failed.\n");
>>>>>            res = read_domain_devices(resource);
>>>>>            if (res && res != -ENODEV)
>>>>>                dev_err_once(&device->dev, "read domain devices
>>>>> failed.\n");
>>>>> +
>>>>> +        mutex_unlock(&resource->lock);
>>>>> +
>>>>>            resource->hwmon_dev =
>>>>> hwmon_device_register_with_info(&device->dev,
>>>>>                                ACPI_POWER_METER_NAME,
>>>>> @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
>>>>>                                power_extra_groups);
>>>>>            if (IS_ERR(resource->hwmon_dev))
>>>>>                dev_err_once(&device->dev, "register hwmon device
>>>>> failed.\n");
>>>>> -        mutex_unlock(&resource->lock);
>>>>> +
>>>>>            break;
>>>>>        case METER_NOTIFY_TRIP:
>>>>>            sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
>>>>> @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
>>>>>            return;
>>>>>        resource = acpi_driver_data(device);
>>>>> -    hwmon_device_unregister(resource->hwmon_dev);
>>>>> +    if (!IS_ERR(resource->hwmon_dev))
>>>>> +        hwmon_device_unregister(resource->hwmon_dev);
>>>> !IS_ERR(resource->hwmon_dev) may be not enough. There might be UAF in
>>>> concurrent case.
>>>> How about do it like:
>>>> if (!IS_ERR_OR_NULL(resource->hwmon_dev)) {
>>> Not sure what you mean with 'concurrent' case. There is a potential
>>> race with the
>> Apologize for your confusion. What I mean is as mentioned in your other
>> mail.
>>> notification code, as mentioned in my other mail. Question is if the
>>> acpi subsystem
>>> disables notification calls before the remove function is called, and
>>> guarantees
>>> that no notifications are pending. If so, I don't think there is a
>>> problem.
>>> Also, resource->hwmon_dev should never be NULL.
>>>
>> All right,
>> the resource is already released and this notify should not be entered
>> again if remove() is called first.
>>
>> But the .remove() of acpi_power_meter driver must clear the
>> 'driver_data' in acpi_device.
>> In this way, even if ACPI subsystem doesn't disable notification,
> But the ACPI subsystem does disable the notification, so what's the problem?
ok, so that's no problem.
>
>> the notify also doesn't perform any action after calling .remove().

