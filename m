Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87F14C167
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 21:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA1UHI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 15:07:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2325 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbgA1UHI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 15:07:08 -0500
Received: from lhreml701-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id CA9D9A9543D69BE1C047;
        Tue, 28 Jan 2020 20:07:06 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml701-cah.china.huawei.com (10.201.108.42) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 20:07:06 +0000
Received: from [127.0.0.1] (10.210.167.110) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 20:07:05 +0000
Subject: Re: [PATCH RFC 0/2] Add basic generic ACPI soc driver
To:     Jeremy Linton <jeremy.linton@arm.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <bb87efe5-d0be-498a-25a1-008a7bebd452@arm.com>
 <5ab3a97d-bbc4-6d5a-fd06-f8da324339ab@huawei.com>
 <6be8d175-477d-d163-3fe0-3ab562874ce4@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b4d00a0a-1bf9-9ccd-c734-f532cac523d1@huawei.com>
Date:   Tue, 28 Jan 2020 20:07:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <6be8d175-477d-d163-3fe0-3ab562874ce4@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.110]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jeremy,

>> I did consider DMI, but I want something more generic, i.e. could 
>> cover embedded/DT systems also.
>>
>> And I need to double check if DMI really has the info I require. Last 
>> time I checked, it didn't for my dev board, but I know that some 
>> fields are simply not filled in.
> 
> Well the info is probably there, but that doesn't mean it should be used 
> programmatically. As your board shows, its not that reliable. And 
> looking at the linked patch I see you mention that.

Right, I am trying to stay away from that.

> 
> 
>>
>>>
>>> But, quickly looking at the use case, I can't help but think you 
>>> don't really want any of the above, or the PPTT id. It seems the 
>>> mapping should actually be tied directly to the uncore PMU 
>>> definition, rather than a soc/machine/whatever identifier. Which 
>>> would imply keying off one of the ACPI object identifiers for the PMU 
>>> itself.
>>
>> So a PMU device (/sys/bus/event_source/devices) does not have a link 
>> to the ACPI object identifiers or uncore PMU platform device etc.
>>
>> And even if it did, there is no clear link between that ACPI object 
>> and the events it supports for that implementation.
> 
> Having a direct link isn't ideal either. It seems you do mention the pmu 
> naming conventions, which can be controlled based on ACPI object 
> identifiers.

Not necessarily.

  Something like "uncore_dmc_hsi1" where the appended bits
> could for example vary on _CID+_UID or DT name.

We already do include some naming from ACPI tables in naming (see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c?h=v5.5#n377), 
but this is not good enough. I'll explain below.

> 
> Not sure that is a particularly good suggestion either, but I do think 
> its a better idea to tie the mapping to the pmu type/man/version concept 
> than the SOC it appears in. The sysfs-bus-event_source-devices-* ABI 
> docs are noticeably silent on the format of the pmu name (is that 
> somewhere else?).

I would say that there is a lack of PMU naming convention, which I did 
note in my referenced patchset.

Apart from that, I think that this problem can be better explained with 
the SMMUv3 PMCG example.

So this PMU has support for a number of IMP DEF events. The SMMUv3 PMCG 
has no method to identify the implementation, so we cannot know which 
IMP DEF events are supported for a specific implementation.

The PMCG PMU naming is fixed, and is in the form smmuv3_pmcg_XXXX - so 
we cannot use some special naming. And the XXXX does not tell us 
anything about the implementation to help know the IMP DEF events.

Now the perf tool has support to know which CPU+uncore events are 
supported for a particular CPU through pmu-events feature - see 
tools/perf/pmu-events/README

The perf tool includes a number of per-CPU event tables.

The matching of per-CPU event table the perf tool uses is based on 
knowing the host CPUID - this is easy to retrieve this via some special 
arch-specific CPU reg, etc. So once it knows the CPUID, "perf list" 
command can show all the events for that CPU.

Now we can extend this idea for the PMCG PMU to support the IMP DEF 
events. For this, we add support for a table of "system" PMU events per 
SoC - similar to the CPU tables - containing the PMCG events. We cannot 
use the CPUID to match the event table for SoC, as a CPUID is not always 
specific to a SoC - that's definite for ARM world and definite for 
SMMUv3 PMCG. So then perf tool needs to know some SoC identifier to 
match the per-SoC events table. That's why I want the SoC id in readable 
form in sysfs.

To add a final note on uncore PMUs, for ARM this is bit of grey area. So 
currently we match uncore PMUs on CPUID. However I figure some SoC 
implementer could take, for example, an A72, and add some uncore PMUs. 
As such, we cannot always match on CPUID, so being able to match on a 
SoC identifier would be better also.

Hope it explains.

Thanks,
John
