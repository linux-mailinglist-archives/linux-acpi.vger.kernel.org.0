Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3896A36F
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2019 10:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfGPH7d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jul 2019 03:59:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42407 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfGPH7d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Jul 2019 03:59:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so8698309pff.9;
        Tue, 16 Jul 2019 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=wDfDJUQ8Kh24S4w4S2kYx9iH7GvKV6D4nFcrENbi2ME=;
        b=bVylv0GH5JJtwmXvJMyJ+I3QIJ0Yz+/V/yjBw8RctIo327Ov1tlt3RDrlw9RCHtkvS
         ZCrtNbd5DaUZyz/7G+X9HauKl5Cq76wJryN64l0pNQSqWSw6d101rS564h2h/7R4YhY3
         qMzRupey3BXSiOE9fri8g3c6QpBnwqVO9hv7ptplaeXN94OYLAChrfEUkSSfpyd8RxIy
         xGKJR2K46hbZnFpLL3XkD5zWHB6lFZEmRPFNz3MRXjH7HKlJyACmPMYaf5/8XyL6EX6w
         v7JZt2G/vw/JKkkFG42lyrVBPgMT2d2oS46Z5SExYBpu0neWDO7YTaDjUUuxelZt4Cxs
         PBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=wDfDJUQ8Kh24S4w4S2kYx9iH7GvKV6D4nFcrENbi2ME=;
        b=NRkPUyG8tKFfsY1wRdK0ybywLHy1HEwC9e7PT8gBCbrEdq6shpuDSAoP7HPJGnGeVo
         3bfp1OI7boC9cj7jqfMREsTZ3ASgA9ZJTo+lTYPlV3uJLy0l3yJEt/mD6axeLYgM7KA3
         EoxWwwPvRlTFfLrEEdhE7leN053hy1nyLGkPSRoXOFSL5dtKPP8ugPrC+Ibd8cGSvy+X
         1rlQXLTn8euYHR3EBG8nXpqZVpzoKnAup99ShkUJeunP76g6RC3Rbv9mcRcp8Z8uOLPN
         Uq0bzEJJyHA7CRCc7/62WVn+BHH3hzxUcFq6ZVTVuazkI1ALebBxEUIINlTXW7/42quD
         TXrA==
X-Gm-Message-State: APjAAAVPMxzUgBy/E5QLcRqjMA9vIgj2sFOHXF784xRVZqD1NuscHwFI
        UokRvw8bQLejPkZoicIY7bs=
X-Google-Smtp-Source: APXvYqzwX0ZLCeqZ1Sou3FMes0IK5sTjahJt7/OI8UrRbZeOJe3vZb/j+KyXrbHYBs18ucoIipgRjA==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr33210399pjo.140.1563263972001;
        Tue, 16 Jul 2019 00:59:32 -0700 (PDT)
Received: from [0.0.0.0] (104.129.187.94.16clouds.com. [104.129.187.94])
        by smtp.gmail.com with ESMTPSA id o128sm23093652pfb.42.2019.07.16.00.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 00:59:31 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Maran Wilson <maran.wilson@oracle.com>,
        James Morse <james.morse@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     jonathan.cameron@huawei.com, john.garry@huawei.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, huawei.libin@huawei.com,
        guohanjun@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
 <51cc9a5c-9968-c4b1-0bc7-870f44a3a761@oracle.com>
 <06ef13e1-fffe-d4a2-721e-f666f331fb3c@arm.com>
From:   Jia He <jiakernel2@gmail.com>
Organization: ARM
Message-ID: <1a7b2f39-ca77-5b5f-cbb5-6356e51b0d7a@gmail.com>
Date:   Tue, 16 Jul 2019 15:59:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <06ef13e1-fffe-d4a2-721e-f666f331fb3c@arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marc

On 2019/7/10 17:15, Marc Zyngier wrote:
> On 09/07/2019 20:06, Maran Wilson wrote:
>> On 7/5/2019 3:12 AM, James Morse wrote:
>>> Hi guys,
>>>
>>> (CC: +kvmarm list)
>>>
>>> On 29/06/2019 03:42, Xiongfeng Wang wrote:
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
>>> ... what do you need this for?
>>>
>>> (The term cpu-hotplug in the arm world almost never means hot-adding a new package/die to
>>> the platform, we usually mean taking CPUs online/offline for power management. e.g.
>>> cpuhp_offline_cpu_device())
>>>
>>> It looks like you're adding support for hot-adding a new package/die to the platform ...
>>> but only for virtualisation.
>>>
>>> I don't see why this is needed for virtualisation. The in-kernel irqchip needs to know
>>> these vcpu exist before you can enter the guest for the first time. You can't create them
>>> late. At best you're saving the host scheduling a vcpu that is offline. Is this really a
>>> problem?
>>>
>>> If we moved PSCI support to user-space, you could avoid creating host vcpu threads until
>>> the guest brings the vcpu online, which would solve that problem, and save the host
>>> resources for the thread too. (and its acpi/dt agnostic)
>>>
>>> I don't see the difference here between booting the guest with 'maxcpus=1', and bringing
>>> the vcpu online later. The only real difference seems to be moving the can-be-online
>>> policy into the hypervisor/VMM...
>> Isn't that an important distinction from a cloud service provider's
>> perspective?
>>
>> As far as I understand it, you also need CPU hotplug capabilities to
>> support things like Kata runtime under Kubernetes. i.e. when
>> implementing your containers in the form of light weight VMs for the
>> additional security ... and the orchestration layer cannot determine
>> ahead of time how much CPU/memory resources are going to be needed to
>> run the pod(s).
> Why would it be any different? You can pre-allocate your vcpus, leave
> them parked until some external agent decides to signal the container
> that it it can use another bunch of CPUs. At that point, the container
> must actively boot these vcpus (they aren't going to come up by magic).
>
> Given that you must have sized your virtual platform to deal with the
> maximum set of resources you anticipate (think of the GIC
> redistributors, for example), I really wonder what you gain here.
I agree with your point in GIC aspect. It will mess up things if it makes

GIC resource hotpluggable in qemu. But it also would be better that vmm

only startup limited vcpu thread resource.

How about:

1. qemu only starts only N vcpu thread (-smp N, maxcpus=M)

2. qemu reserves the GIC resource with maxium M vcpu number

3. when qmp cmd cpu hotplug-add is triggerred, send a GED event to guest kernel

4. guest kernel recv it and trigger the acpi plug process.

Currently ACPI_CPU_HOTPLUG is enabled for Kconfig but completely not workable.


---
Cheers,
Jia
