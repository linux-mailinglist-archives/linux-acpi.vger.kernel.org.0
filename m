Return-Path: <linux-acpi+bounces-20378-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2BD246C3
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 13:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E816F3048142
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FA138A715;
	Thu, 15 Jan 2026 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="XTyFOCgk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610D72848A1;
	Thu, 15 Jan 2026 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479534; cv=none; b=XfIyDuJ9Gc/hhSAG4rqOyZ41TNOASxTMoY6QP+MiZTgO4SZN4QmiC6+LeIvZhG3Xc0m99IkqMZgh6qN3n4QH3m++72DEBYoLfjJPfz/nsWyi5Gd9VLP9LZaTZ5Fq/UwWKQKAglsmF+/yzI511CWxizXMYdaOqrXYz4dYf0XWCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479534; c=relaxed/simple;
	bh=fGfabifBTMEShecDx41TnTsyINHz7UynmUeJ6mjGxzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UsT7m8jm9hG/bFswcOCvPcyPpbJf95497wmF/54WQsrBhSbNCmHweCtwESTlD2icLha/nVVDA+q0zIojZuNn/bZ3oIc2ScSPw7fP8rajLvS/VqmDCJorCNRDj44Gqg9pgYpt3VcgWyMt67T2ZuJaT6jZIBlCXJw08ZH0/gqtNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=XTyFOCgk; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6CUcluFwz/pdkw4pNM9/29YhuQyoDd74QB4LuSrXpoU=;
	b=XTyFOCgkaPONxci6ER8nI2K8aGZwncbEuxOVZDWtNVZTj13PIpWJPSK6ISFWqrDPi9JLtspmG
	hBMb1+nfujq9sz1DtZ5s4HgZDmud+Qt6fyHBQhNXxGS2b6uGbTgpYzzoih/SxiofWAGS8CNrofl
	50ComqDCx2mD/X8fv8orXgo=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dsMPC2vXdzcb45;
	Thu, 15 Jan 2026 20:14:55 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 07A9340567;
	Thu, 15 Jan 2026 20:18:42 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Jan 2026 20:18:41 +0800
Received: from [10.67.121.59] (10.67.121.59) by kwepemn100009.china.huawei.com
 (7.202.194.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 20:18:41 +0800
Message-ID: <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com>
Date: Thu, 15 Jan 2026 20:18:40 +0800
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
	<zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>, <yubowen8@huawei.com>,
	<lihuisong@huawei.com>
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com>
 <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
From: "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn100009.china.huawei.com (7.202.194.112)


On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
> On Tue, Nov 25, 2025 at 8:29 AM Huisong Li <lihuisong@huawei.com> wrote:
>> The global switch of cpuidle can be turned back on in some case.
>> So add enable_cpuidle().
> No, this is not going to work.  The "off" switch only affects
> initialization AFAICS.
I think it would be work.
The cpuidle_not_available() also see the "off" on do_idle().
And cpuidle_idle_call() check this function first and then select idle 
state.
Cpuidle doesn't select and enter idle state if this fuction return true.
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/cpuidle/cpuidle.c | 5 ++++-
>>   include/linux/cpuidle.h   | 2 ++
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 56132e843c99..980ddfd3d930 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -48,7 +48,10 @@ void disable_cpuidle(void)
>>   {
>>          off = 1;
>>   }
>> -
>> +void enable_cpuidle(void)
>> +{
>> +       off = 0;
>> +}
>>   bool cpuidle_not_available(struct cpuidle_driver *drv,
>>                             struct cpuidle_device *dev)
>>   {
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index a9ee4fe55dcf..94c030748af3 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -168,6 +168,7 @@ struct cpuidle_driver {
>>   };
>>
>>   #ifdef CONFIG_CPU_IDLE
>> +extern void enable_cpuidle(void);
>>   extern void disable_cpuidle(void);
>>   extern bool cpuidle_not_available(struct cpuidle_driver *drv,
>>                                    struct cpuidle_device *dev);
>> @@ -203,6 +204,7 @@ extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev)
>>   static inline struct cpuidle_device *cpuidle_get_device(void)
>>   {return __this_cpu_read(cpuidle_devices); }
>>   #else
>> +static inline void enable_cpuidle(void) { }
>>   static inline void disable_cpuidle(void) { }
>>   static inline bool cpuidle_not_available(struct cpuidle_driver *drv,
>>                                           struct cpuidle_device *dev)
>> --
>> 2.33.0
>>

