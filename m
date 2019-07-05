Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0360438
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfGEKML (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 06:12:11 -0400
Received: from foss.arm.com ([217.140.110.172]:35052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbfGEKML (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 5 Jul 2019 06:12:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC872B;
        Fri,  5 Jul 2019 03:12:10 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779B73F703;
        Fri,  5 Jul 2019 03:12:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com, jonathan.cameron@huawei.com,
        kvmarm@lists.cs.columbia.edu
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
Date:   Fri, 5 Jul 2019 11:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi guys,

(CC: +kvmarm list)

On 29/06/2019 03:42, Xiongfeng Wang wrote:
> This patchset mark all the GICC node in MADT as possible CPUs even though it
> is disabled. But only those enabled GICC node are marked as present CPUs.
> So that kernel will initialize some CPU related data structure in advance before
> the CPU is actually hot added into the system. This patchset also implement 
> 'acpi_(un)map_cpu()' and 'arch_(un)register_cpu()' for ARM64. These functions are
> needed to enable CPU hotplug.
> 
> To support CPU hotplug, we need to add all the possible GICC node in MADT
> including those CPUs that are not present but may be hot added later. Those
> CPUs are marked as disabled in GICC nodes.

... what do you need this for?

(The term cpu-hotplug in the arm world almost never means hot-adding a new package/die to
the platform, we usually mean taking CPUs online/offline for power management. e.g.
cpuhp_offline_cpu_device())

It looks like you're adding support for hot-adding a new package/die to the platform ...
but only for virtualisation.

I don't see why this is needed for virtualisation. The in-kernel irqchip needs to know
these vcpu exist before you can enter the guest for the first time. You can't create them
late. At best you're saving the host scheduling a vcpu that is offline. Is this really a
problem?

If we moved PSCI support to user-space, you could avoid creating host vcpu threads until
the guest brings the vcpu online, which would solve that problem, and save the host
resources for the thread too. (and its acpi/dt agnostic)

I don't see the difference here between booting the guest with 'maxcpus=1', and bringing
the vcpu online later. The only real difference seems to be moving the can-be-online
policy into the hypervisor/VMM...


I think physical package/die hotadd is a much bigger, uglier problem than doing the same
under virtualisation. Its best to do this on real hardware first so we don't miss
something. (cpu-topology, numa, memory, errata, timers?)
I'm worried that doing virtualisation first means the firmware-requirements for physical
hotadd stuff is "whatever Qemu does".


Thanks,

James
