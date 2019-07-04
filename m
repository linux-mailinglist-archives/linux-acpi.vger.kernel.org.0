Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F435F2B7
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2019 08:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfGDGUy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jul 2019 02:20:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfGDGUy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Jul 2019 02:20:54 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45670AA97B57D36471A2;
        Thu,  4 Jul 2019 14:20:44 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 14:20:36 +0800
Subject: Re: [PATCH RFC 0/3] Support CPU hotplug for ARM64
To:     Jia He <hejianet@gmail.com>, <rjw@rjwysocki.net>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>
References: <1561720392-45907-1-git-send-email-wangxiongfeng2@huawei.com>
 <2b22cf4d-9646-9f20-41ae-cceb83d9791b@gmail.com>
 <135ee490-a5a6-46c9-208e-81849b20d6b6@huawei.com>
 <7898e483-a8e4-39a2-358f-8fcf838c242f@gmail.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <e9acd13e-2501-4b62-496d-e8a5cb872191@huawei.com>
Date:   Thu, 4 Jul 2019 14:17:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7898e483-a8e4-39a2-358f-8fcf838c242f@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/7/4 14:04, Jia He wrote:
> Hi Xiongfeng
> 
> Sorry, I missed your latter mail, you used a emulated SCI interrupt

Yes, I only used a emulated SCI interrupt. My colleague is working on the qemu part.
He used the GED device in qemu. But there is still some other issues with the qemu
and he is working on it.

> 
> ---
> Cheers,
> Justin (Jia He)
> 
> On 2019/7/4 11:26, Xiongfeng Wang wrote:
>> Hi Justin,
>>
>> On 2019/7/4 11:00, Jia He wrote:
>>> Hi Xiongfeng
>>>
>>> It is a little bit awkful that I am also  investigating acpi based cpu hotplug issue silimar with
>>>
>>> your idea. My question is your purpose to implement the vcpu hotplug in arm64 qemu?
>> Yes, my purpose is to implement the vcpu hotplug in arm64 qemu. So that I can add or remove vcpu
>> without shutting down the Guest OS.
>>
>> Thanks,
>> Xiongfeng
>>
>>> Thanks for the ellaboration
>>>
>>> ---
>>> Cheers,
>>> Justin (Jia He)
>>>
>>> On 2019/6/28 19:13, Xiongfeng Wang wrote:
>>>> This patchset mark all the GICC node in MADT as possible CPUs even though it
>>>> is disabled. But only those enabled GICC node are marked as present CPUs.
>>>> So that kernel will initialize some CPU related data structure in advance before
>>>> the CPU is actually hot added into the system. This patchset also implement
>>>> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
>>>> needed to enable CPU hotplug.
>>>>
>>>> To support CPU hotplug, we need to add all the possible GICC node in MADT
>>>> including those CPUs that are not present but may be hot added later. Those
>>>> CPUs are marked as disabled in GICC nodes.
>>>>
>>>> Xiongfeng Wang (3):
>>>>     ACPI / scan: evaluate _STA for processors declared via ASL Device
>>>>       statement
>>>>     arm64: mark all the GICC nodes in MADT as possible cpu
>>>>     arm64: Add CPU hotplug support
>>>>
>>>>    arch/arm64/kernel/acpi.c  | 22 ++++++++++++++++++++++
>>>>    arch/arm64/kernel/setup.c | 19 ++++++++++++++++++-
>>>>    arch/arm64/kernel/smp.c   | 11 +++++------
>>>>    drivers/acpi/scan.c       | 12 ++++++++++++
>>>>    4 files changed, 57 insertions(+), 7 deletions(-)
>>>>
>>> .
>>>

