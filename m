Return-Path: <linux-acpi+bounces-20750-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7sOyCB2+emn8+AEAu9opvQ
	(envelope-from <linux-acpi+bounces-20750-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 02:55:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C2AAE80
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 02:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B3EAD30058E4
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 01:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49E2DCF6C;
	Thu, 29 Jan 2026 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="VcUF2FGG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A942561AB;
	Thu, 29 Jan 2026 01:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769651736; cv=none; b=RCpDVCB++anmoMM1dx3rTlumx7Z/9rhXIIZUk8WNvf8ktrCQVH4O1f91SBywyT1Pwc3uQP3wLVkvxhqJXGhM6U1SlohhDPBQ8WQG1PqjSqjm2l9D5RtCXL5kSxzX5615JyovUA9E1uhdJhzzdDu6pYbhN50z0f2BR+qOnwvTacg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769651736; c=relaxed/simple;
	bh=MEXBrquo/PCOd0uRgpmoxeREdZ8LpaLgZWnZ3qWnt/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WtC9efxAnGUZd19YsU+UPR18cpHECGdL5rzm9IrA8DMK+hsCmPG+mfERSuQhHPhZUiKahyO3nbma5ECVFu1n2Tya123tCczgyhXluVeFe28paQFbMeCQZ7oM61ou6o6Puf72Y3xlzvo9kcmo3x0VfbAsHSJMQneQtRKGsb4F9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=VcUF2FGG; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=A/UvhHyoPaHdbp7UqqLLaxXvByURp7Lh1KHTQR7hlkg=;
	b=VcUF2FGG8IDzklrmoWl84WbNDB1pONDENjN7WI0Z0AVDzKAVuxwoQlry2R1yJKpzV+WrH2zdW
	kE9kLmOrwl8fMtg4026OrKD+xhBAS4UVgkq8pXRUrCv1YQL4UK4K0Z6XZlxHvNKFXUx9Si16nwW
	l4IwJoFp4lmfP+d7d1iKaxU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4f1hv42Ldfzcb4v;
	Thu, 29 Jan 2026 09:51:12 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7152A4056B;
	Thu, 29 Jan 2026 09:55:23 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Jan 2026 09:55:22 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 29 Jan
 2026 09:55:21 +0800
Message-ID: <38db0583-95f0-47cd-b2e8-c525094bd9eb@huawei.com>
Date: Thu, 29 Jan 2026 09:55:17 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	<linux-acpi@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Igor Raits
	<igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek
	<zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <1d969bd7-4969-455d-9600-e4be14a78217@roeck-us.net>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <1d969bd7-4969-455d-9600-e4be14a78217@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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
	TAGGED_FROM(0.00)[bounces-20750-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:dkim,huawei.com:mid];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F9C2AAE80
X-Rspamd-Action: no action


On 1/29/2026 2:18 AM, Guenter Roeck wrote:
> Hi all,
>
> On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
>> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
>> <jaroslav.pulchart@gooddata.com> wrote:
>>> Hello,
>>>
>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
>>> in the ACPI power meter hwmon interface. Reading power*_average sysfs
>>> attributes blocks indefinitely and causes tasks to enter uninterruptible
>>> sleep (D state).
>> The most recent change in the acpi_power_meter driver was made in
>> 6.15, so this is not a regression in that driver.
>>
>> Also, nothing suspicious is done in power1_average_min_show() and
>> power1_average_min_store() AFAICS.
>>
> I decided to ask AI (Gemini 3, more specifically) for an analysis of the
> problem, using Chris Mason's prompts for guidance. Result is below.
>
> The suggested fix may be a feasible workaround. Let me know what you think.
>
> Thanks,
> Guenter
>
> ---
> Summary of crash or warning
> Deadlock in acpi_power_meter driver between sysfs read and ACPI notify.
>
> Kernel version if available
> 6.18.6-1.gdc.el9.x86_64
>
> Cleaned up copy of oops or stack trace
> [  740.721209] Call Trace:
> [  741.467334]  power_meter_read+0x1ea/0x2c0 [acpi_power_meter]
> [  741.475320]  hwmon_attr_show+0x5e/0x130
> [  741.481343]  dev_attr_show+0x19/0x60
> [  741.487325]  sysfs_kf_seq_show+0xbf/0x140
> [  741.494315]  seq_read_iter+0x112/0x510
> [  741.503544]  vfs_read+0x215/0x340
>
> [  740.286380] INFO: task alloy:5901 blocked for more than 122 seconds.
> [  740.326290] Call Trace:
> [  740.336311]  __schedule+0x2b5/0x690
> [  740.341312]  schedule+0x23/0x80
> [  740.354335]  __mutex_lock.constprop.0+0x3c9/0xa00
> [  740.360318]  hwmon_attr_show+0x36/0x130
>
> Explanation of the problem
> The acpi_power_meter driver exhibits a deadlock when acpi_power_meter_notify
> is called with METER_NOTIFY_CONFIG while a userspace process is concurrently
> reading a sysfs attribute (e.g., power1_average).
>
> The deadlock occurs because acpi_power_meter_notify acquires resource->lock
> and then calls hwmon_device_unregister. The hwmon_device_unregister function
> (via device_unregister and kernfs_remove) waits for all active sysfs callbacks
> to complete. However, the active sysfs callback (power_meter_read) tries to
> acquire resource->lock which is already held by acpi_power_meter_notify.
>
> Sequence of events:
> 1. Userspace reads power1_average.
> 2. hwmon_attr_show is called. It calls power_meter_read.
> 3. power_meter_read attempts to acquire resource->lock.
> 4. Concurrently, ACPI triggers acpi_power_meter_notify with METER_NOTIFY_CONFIG.
> 5. acpi_power_meter_notify acquires resource->lock.
> 6. acpi_power_meter_notify calls hwmon_device_unregister.
> 7. hwmon_device_unregister waits for the active hwmon_attr_show (and thus
>     power_meter_read) to return.
> 8. power_meter_read is blocked waiting for resource->lock.
> 9. acpi_power_meter_notify is blocked waiting for power_meter_read to finish.
Great analysis. Amazing.
Fully figured out this issue.

