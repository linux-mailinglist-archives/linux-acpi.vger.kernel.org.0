Return-Path: <linux-acpi+bounces-20577-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +cmbL6PjcmlJrAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20577-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 03:57:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB566FDE2
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 03:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8730303D2E0
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 02:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8634B663;
	Fri, 23 Jan 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="Ho5T6CBj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31AF349B00;
	Fri, 23 Jan 2026 02:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769136827; cv=none; b=RbBZgP9ayrXO8COl4P7Gzn0aTHFQZzocamKZOi2minN/QG1N96rl1CkyBh2pCwGIiSkY37UUG0nPU21csmEaJhEQOReA/ypQWvWV9UGUJOtSzQ/4fw84KP6rryRAl0R7QIzEPqrnxtY0pjzZPHQGCM0nR5IrOcv2ZnHzOQjg/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769136827; c=relaxed/simple;
	bh=YIplXluAYAX9NxGLAS+x4VFlvmh2qLXzkJq+Zzl2WrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y6MLr7jqMLiLk+aphWqNI4udhQFE42CAbgJigkcNkrz0bp0pzgjqCLFiQFy0/EvYQIUEAmbfeBdo1obqvCh49o/gKjwDRuxIYHmnLrkvJDhxe1uw9ZcP1Sc71c8bLw7FxAWnv9If4iNbXQZiQZu91zT6qPPZ3usX2awD8pfhaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=Ho5T6CBj; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=niMuD7qmOink79aNy0k8MqE20TChMuQ+l6yOVNmfKHI=;
	b=Ho5T6CBjtMMavH+MSsitospCa6oll27WQQ1Z/9q4ixESfLtnVGu4CtOqZO42NQFbErCZ51Zvk
	W137zzTV3CSyXAcPzeTbV8H2Wb+PA2FsW02o8dTdGZrOQBN9Kb2UCnS41GnmEvQNYJJds8TOGFu
	5eYGCGDz0dX1sZDJpW2wNXc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dy2Sf230hz12LD8;
	Fri, 23 Jan 2026 10:49:06 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id A109340539;
	Fri, 23 Jan 2026 10:53:03 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 23 Jan 2026 10:53:03 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 23 Jan
 2026 10:53:02 +0800
Message-ID: <483f36e1-4ddc-4c22-aaba-c78156ebc0e2@huawei.com>
Date: Fri, 23 Jan 2026 10:53:02 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: "Rafael J. Wysocki" <rafael@kernel.org>, Guenter Roeck
	<linux@roeck-us.net>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
CC: <linux-acpi@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Igor Raits
	<igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek
	<zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>,
	<lihuisong@huawei.com>
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20577-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:dkim,roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,gooddata.com:email];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0DB566FDE2
X-Rspamd-Action: no action


On 1/23/2026 4:42 AM, Rafael J. Wysocki wrote:
> On Thu, Jan 22, 2026 at 8:51 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 1/22/26 10:55, Rafael J. Wysocki wrote:
>>> On Thu, Jan 22, 2026 at 7:21 PM Jaroslav Pulchart
>>> <jaroslav.pulchart@gooddata.com> wrote:
>>>> Hello,
>>>>
>>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a regression
>>>> in the ACPI power meter hwmon interface. Reading power*_average sysfs
>>>> attributes blocks indefinitely and causes tasks to enter uninterruptible
>>>> sleep (D state).
>>> The most recent change in the acpi_power_meter driver was made in
>>> 6.15, so this is not a regression in that driver.
>>>
>>> Also, nothing suspicious is done in power1_average_min_show() and
>>> power1_average_min_store() AFAICS.
>>>
>> I suspect a circular locking problem between the hwmon lock and the
>> resource lock. Unfortunately I don't immediately see it.
>>
>> Would it be possible to test this with a kernel which has lock debugging
>> enabled ? I'd test it myself but I don't have a system available
>> that supports the acpi power meter.
> One problem I found in acpi_power_meter through code inspection is
> calling hwmon_device_unregister() under resource->lock in
> acpi_power_meter_notify(), which may be responsible for the observed
> symptoms, but then I'm not sure why it started to be visible after
> 6.18.
The hwmon_attr_show first hold hwdev->lock and then hold resource->lock 
in acpi_power_meter driver.
Although driver call hwmon_device_unregister under resource->lock in 
acpi_power_meter_notify(),
hwmon_device_unregister does't hold hwdev->lock.
So this may not be the root cause of this problem.

On the 6.19 kernel, ACPI power meter works well on my platform.
I don't konw what the difference about power meter is between your 
platform and my platform.

@Jaroslav Pulchart, does your platform support notify feature?
Is this issue probabilistic on your platform?
I suggest you can try to remove resource->lock before calling 
hwmon_device_unregister in notify.
Then check whether this is the issue here.

Best,
/Huisong

