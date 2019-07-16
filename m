Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C136A34C
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfGPHwm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 03:52:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfGPHwl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jul 2019 03:52:41 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8D4F24C29AFC5FF4B6B7;
        Tue, 16 Jul 2019 15:52:38 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Tue, 16 Jul 2019
 15:52:28 +0800
Subject: Re: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
To:     James Morse <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <kvmarm@lists.cs.columbia.edu>
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <8a8cd9d2-684e-2246-c1f9-5cf21aa2defc@huawei.com>
Date:   Tue, 16 Jul 2019 15:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/7/5 18:12, James Morse wrote:
> Hi guys,
> 
> (CC: +kvmarm list)
> 
> On 29/06/2019 03:42, Xiongfeng Wang wrote:
>> This patchset mark all the GICC node in MADT as possible CPUs even though it
>> is disabled. But only those enabled GICC node are marked as present CPUs.
>> So that kernel will initialize some CPU related data structure in advance before
>> the CPU is actually hot added into the system. This patchset also implement 
>> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
>> needed to enable CPU hotplug.
>>
>> To support CPU hotplug, we need to add all the possible GICC node in MADT
>> including those CPUs that are not present but may be hot added later. Those
>> CPUs are marked as disabled in GICC nodes.
> 
> ... what do you need this for?
> 
> (The term cpu-hotplug in the arm world almost never means hot-adding a new package/die to
> the platform, we usually mean taking CPUs online/offline for power management. e.g.
> cpuhp_offline_cpu_device())
> 
> It looks like you're adding support for hot-adding a new package/die to the platform ...
> but only for virtualisation.

I read the GIC driver these days. It is a lot of work to configure the GIC at runtime,
and this patchset doesn't support this.
Actually, my original idea is hot-adding cores to the platform, and it is only for virtualisation.
These cores need to be on the same physical package. The GIC is initialized when
the kernel boots and GICR is initialized when the core is hot-added and brought up.

> 
> I don't see why this is needed for virtualisation. The in-kernel irqchip needs to know
> these vcpu exist before you can enter the guest for the first time. You can't create them
> late. At best you're saving the host scheduling a vcpu that is offline. Is this really a
> problem?
> 
> If we moved PSCI support to user-space, you could avoid creating host vcpu threads until
> the guest brings the vcpu online, which would solve that problem, and save the host
> resources for the thread too. (and its acpi/dt agnostic)
> 
> I don't see the difference here between booting the guest with 'maxcpus=1', and bringing
> the vcpu online later. The only real difference seems to be moving the can-be-online
> policy into the hypervisor/VMM...
> 
> 
> I think physical package/die hotadd is a much bigger, uglier problem than doing the same
> under virtualisation. Its best to do this on real hardware first so we don't miss
> something. (cpu-topology, numa, memory, errata, timers?)
> I'm worried that doing virtualisation first means the firmware-requirements for physical
> hotadd stuff is "whatever Qemu does".
> 
> 
> Thanks,
> 
> James
> 
> .
> 

