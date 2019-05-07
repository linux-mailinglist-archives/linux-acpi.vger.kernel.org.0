Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8EB169B1
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2019 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEGR6h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 7 May 2019 13:58:37 -0400
Received: from foss.arm.com ([217.140.101.70]:32920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbfEGR6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 7 May 2019 13:58:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01B23A78;
        Tue,  7 May 2019 10:58:37 -0700 (PDT)
Received: from [192.168.100.241] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C52043F5AF;
        Tue,  7 May 2019 10:58:33 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] arm64: SPE ACPI enablement
To:     Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, linuxarm@huawei.com, john.garry@huawei.com
References: <20190503232407.37195-1-jeremy.linton@arm.com>
 <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <82032e5b-0cb5-e48f-ab51-ba5d5f9dceec@arm.com>
Date:   Tue, 7 May 2019 12:58:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5eaa1607-4bf0-a320-e9cf-2d51eca912c6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/4/19 6:06 AM, Hanjun Guo wrote:
> Hi Jeremy, Mark,
> 
> On 2019/5/4 7:24, Jeremy Linton wrote:
>> This patch series enables the Arm Statistical Profiling
>> Extension (SPE) on ACPI platforms.
>>
>> This is possible because ACPI 6.3 uses a previously
>> reserved field in the MADT to store the SPE interrupt
>> number, similarly to how the normal PMU is described.
>> If a consistent valid interrupt exists across all the
>> cores in the system, a platform device is registered.
>> That then triggers the SPE module, which runs as normal.
>>
>> We also add the ability to parse the PPTT for IDENTICAL
>> cores. We then use this to sanity check the single SPE
>> device we create. This creates a bit of a problem with
>> respect to the specification though. The specification
>> says that its legal for multiple tree's to exist in the
>> PPTT. We handle this fine, but what happens in the
>> case of multiple tree's is that the lack of a common
>> node with IDENTICAL set forces us to assume that there
>> are multiple non-IDENTICAL cores in the machine.
> 
> Adding this patch set on top of latest mainline kernel,
> and tested on D06 which has the SPE feature, in boot message
> shows it was probed successfully:
> 
> arm_spe_pmu arm,spe-v1: probed for CPUs 0-95 [max_record_sz 128, align 4, features 0x7]
> 
> but when I test it with spe events such as
> 
> perf record -c 1024 -e arm_spe_0/branch_filter=0/ -o spe ls
> 
> it fails with:
> failed to mmap with 12 (Cannot allocate memory),
> 
> Confirmed that patch [0] is merged and other perf events are working
> fine.

Its pretty easy to get into the weeds with this driver, does it work 
with examples like:

https://lkml.org/lkml/2018/1/14/122

> I narrowed this issue down that mmap() failed to alloc 4M memory
> in perf tool but seems have no relationship with this SPE patch set,
> then I'm lost, could you take look please?
> 
> Thanks
> Hanjun
> 
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=528871b456026e6127d95b1b2bd8e3a003dc1614
> 

