Return-Path: <linux-acpi+bounces-20780-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNtvK5cQfGl7KQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20780-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 02:59:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5164FB64E1
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 02:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEA7D300F9F5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E131619D;
	Fri, 30 Jan 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="DLP3Frf9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FDB32A3D7;
	Fri, 30 Jan 2026 01:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769738388; cv=none; b=ZNbTkOWNRAZSZ+qWlYJGa2HO9rZjZGAfVR2QszfJxnmnRs6eVvrIJBbbesB1CScdI2jAVdjQVk86/hbNfzpE12bBgYlSSSdlIrQckxxt4rPqUZedH6FWdxeyyTdfd0v4Vcbh6ZV25S4zpSiOycdbBHzOeEtNuE/OSfKXcWSArLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769738388; c=relaxed/simple;
	bh=Hvkr6IZ5XACZqD3+ANSaZuO+iyVlTguwLJBvUaozllc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z7IOlvcEWiDALt9HQxqYNZlUIHF1I+yPEojyko4bLzJCPuTU9kUDhv+3l9pq1fQE9XaR8OGohs7ga4kvRr9Ius5dVlb0YfTpyvbNFTsTaszz0VqKoiq/8bw1UG7SXzgTz/sHtXE1cbC3vRuK8OF0YDJcAiO/v4dJtOsmarI7ZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=DLP3Frf9; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qbA8Ecr1jQu1uOwstxFWUr2HkCfew3zAUXf5SiCArK8=;
	b=DLP3Frf9ekZ96o06YGT1yu2GeIX3U/KocajRs0i50XQERqcTRjrdcLmRHKsNgyycMJ8HA7tO0
	DHA5OuJb1LQPg0ffa7c/GKeiZGnrf2jAcoJHAyfu5EEhi+VBZOJe1P5iV9vbV51Rw4ZIkxHhnLl
	pbc1OCDUzCjIQXX+MNfJsGM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f2Jxx0p2TznTVF;
	Fri, 30 Jan 2026 09:55:49 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E84540539;
	Fri, 30 Jan 2026 09:59:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Jan 2026 09:59:41 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 30 Jan
 2026 09:59:41 +0800
Message-ID: <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
Date: Fri, 30 Jan 2026 09:59:40 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Sudeep.Holla@arm.com>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com>
 <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[h-partners.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20780-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:dkim];
	TAGGED_RCPT(0.00)[linux-acpi];
	FROM_NEQ_ENVFROM(0.00)[lihuisong@huawei.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5164FB64E1
X-Rspamd-Action: no action

Hi Rafael,

On 1/15/2026 8:18 PM, lihuisong (C) wrote:
>
> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
>> On Tue, Nov 25, 2025 at 8:29 AM Huisong Li <lihuisong@huawei.com> wrote:
>>> The global switch of cpuidle can be turned back on in some case.
>>> So add enable_cpuidle().
>> No, this is not going to work.  The "off" switch only affects
>> initialization AFAICS.
> I think it would be work.
> The cpuidle_not_available() also see the "off" on do_idle().
> And cpuidle_idle_call() check this function first and then select idle 
> state.
> Cpuidle doesn't select and enter idle state if this fuction return true.
I verified that disable_cpuidle() effectively prevents all CPUs from 
entering any idle states and the cpuidle function is correctly restored 
after calling enable_cpuidle().
What do you think?

Best,
/Huisong
>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>> ---
>>>   drivers/cpuidle/cpuidle.c | 5 ++++-
>>>   include/linux/cpuidle.h   | 2 ++
>>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index 56132e843c99..980ddfd3d930 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -48,7 +48,10 @@ void disable_cpuidle(void)
>>>   {
>>>          off = 1;
>>>   }
>>> -
>>> +void enable_cpuidle(void)
>>> +{
>>> +       off = 0;
>>> +}
>>>   bool cpuidle_not_available(struct cpuidle_driver *drv,
>>>                             struct cpuidle_device *dev)
>>>   {
>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>> index a9ee4fe55dcf..94c030748af3 100644
>>> --- a/include/linux/cpuidle.h
>>> +++ b/include/linux/cpuidle.h
>>> @@ -168,6 +168,7 @@ struct cpuidle_driver {
>>>   };
>>>
>>>   #ifdef CONFIG_CPU_IDLE
>>> +extern void enable_cpuidle(void);
>>>   extern void disable_cpuidle(void);
>>>   extern bool cpuidle_not_available(struct cpuidle_driver *drv,
>>>                                    struct cpuidle_device *dev);
>>> @@ -203,6 +204,7 @@ extern struct cpuidle_driver 
>>> *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>>>   static inline struct cpuidle_device *cpuidle_get_device(void)
>>>   {return __this_cpu_read(cpuidle_devices); }
>>>   #else
>>> +static inline void enable_cpuidle(void) { }
>>>   static inline void disable_cpuidle(void) { }
>>>   static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
>>>                                           struct cpuidle_device *dev)
>>> -- 
>>> 2.33.0
>>>

