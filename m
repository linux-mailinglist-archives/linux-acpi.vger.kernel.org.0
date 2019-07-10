Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E268B64A77
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2019 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfGJQHx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Jul 2019 12:07:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59990 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbfGJQHx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Jul 2019 12:07:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6AG3pPd062869;
        Wed, 10 Jul 2019 16:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=BE1yB3fPvpdXk97fgYAyuiJ4zekQnI+c6hQabHQPTaU=;
 b=pzrqcAewAbQuxiFqeWXeY399fUqp88GBhnaMqtbEgm+QV62iOnQIaSMzix5Eb38Qqx41
 sxb7R6tHbMwnfKe/Wggo/ySXe9gPI0lgtNy+6ZOlmKauXcOAQ6fnpQ1pwRGfVG1LmYVT
 b2U3hOAt/b5PuD11vTzYISnR5BQ+7JkJg5MignUHI+LzWXV5dLC4w72pgDOxcRZEaE73
 iPhLLAGS41CbYJAwZdUl90A8E6cpitlKt6DWLPnLxi/FJv4PE+20XMeCK5xWYk732At/
 IxPvuPCXfXeYZ9qh6YrPKFSW5rUu42qOJa4a61w6siEg4bT/FeS3j3beoKjirg5DeM6D lQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tjkkpu59s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 16:07:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6AG3Cs8134548;
        Wed, 10 Jul 2019 16:05:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tmwgxk18c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jul 2019 16:05:27 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6AG5O3P003424;
        Wed, 10 Jul 2019 16:05:24 GMT
Received: from [10.159.239.91] (/10.159.239.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Jul 2019 09:05:23 -0700
Subject: Re: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
To:     Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     guohanjun@huawei.com, john.garry@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        huawei.libin@huawei.com, jonathan.cameron@huawei.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
 <51cc9a5c-9968-c4b1-0bc7-870f44a3a761@oracle.com>
 <06ef13e1-fffe-d4a2-721e-f666f331fb3c@arm.com>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <d65c2aca-470f-177d-57cf-6375c989054c@oracle.com>
Date:   Wed, 10 Jul 2019 09:05:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <06ef13e1-fffe-d4a2-721e-f666f331fb3c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9314 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907100182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9314 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907100182
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/10/2019 2:15 AM, Marc Zyngier wrote:
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

Maybe I'm not following the alternative proposal completely, but 
wouldn't a guest VM (who happens to be in control of its OS) be able to 
add/online vCPU resources without approval from the VMM this way?

Thanks,
-Maran

>> Thanks,
>> -Maran
>>
>>> I think physical package/die hotadd is a much bigger, uglier problem than doing the same
>>> under virtualisation. Its best to do this on real hardware first so we don't miss
>>> something. (cpu-topology, numa, memory, errata, timers?)
>>> I'm worried that doing virtualisation first means the firmware-requirements for physical
>>> hotadd stuff is "whatever Qemu does".
> For sure, I want to model the virtualization side after the actual HW,
> and not the other way around. Live reconfiguration of the interrupt
> topology (and thus the whole memory map) will certainly be challenging.
>
> Thanks,
>
> 	M.

