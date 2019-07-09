Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED2863BAD
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2019 21:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfGITHN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Jul 2019 15:07:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47996 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfGITHN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jul 2019 15:07:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69J46u1188721;
        Tue, 9 Jul 2019 19:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Yv+yrBeYqVkGCt6LLOk5beU+S3/T8S7t8pToxYNFrvA=;
 b=4yCSg4XWjehbQ+4vOWcfPZ8mTO11RReysfIntOl88QF69DGa5deUYpF9+QgwBEwJ34EI
 gocSLnUM0idJqrKQOjf9egsxG00NemUDBqrkIuFhJNefyMAaN5TRSSPnrA7FjspzSkWn
 BPZJDO/V6dcyf79+yEgzcZo3A2yyaSPKkHzkR9RAaWcilWXtupRah7XberXC5nNvQ40b
 3+Sh3WNOLn0SH/cXQ6kh4EzeubRnu7ylogU2nlYPrJm18OmQL/IyHw66ZJ1hZPqYlJs4
 MIQCnAlADG2JrhpwoegQ4WUvijFEFvtX+0pRHuRLDr7YiSrBs9S0FlczRyFpH0vJQnPs Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tjm9qp3q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 19:06:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x69IvwWt190370;
        Tue, 9 Jul 2019 19:06:51 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2tjgru9d9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jul 2019 19:06:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x69J6lep030169;
        Tue, 9 Jul 2019 19:06:48 GMT
Received: from [10.159.233.89] (/10.159.233.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jul 2019 12:06:47 -0700
Subject: Re: [RFC PATCH v2 0/3] Support CPU hotplug for ARM64
To:     James Morse <james.morse@arm.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     jonathan.cameron@huawei.com, john.garry@huawei.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, huawei.libin@huawei.com,
        guohanjun@huawei.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
References: <1561776155-38975-1-git-send-email-wangxiongfeng2@huawei.com>
 <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
From:   Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <51cc9a5c-9968-c4b1-0bc7-870f44a3a761@oracle.com>
Date:   Tue, 9 Jul 2019 12:06:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <82879258-46a7-a6e9-ee54-fc3692c1cdc3@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907090224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9313 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907090225
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 7/5/2019 3:12 AM, James Morse wrote:
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
> ... what do you need this for?
>
> (The term cpu-hotplug in the arm world almost never means hot-adding a new package/die to
> the platform, we usually mean taking CPUs online/offline for power management. e.g.
> cpuhp_offline_cpu_device())
>
> It looks like you're adding support for hot-adding a new package/die to the platform ...
> but only for virtualisation.
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

Isn't that an important distinction from a cloud service provider's 
perspective?

As far as I understand it, you also need CPU hotplug capabilities to 
support things like Kata runtime under Kubernetes. i.e. when 
implementing your containers in the form of light weight VMs for the 
additional security ... and the orchestration layer cannot determine 
ahead of time how much CPU/memory resources are going to be needed to 
run the pod(s).

Thanks,
-Maran

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
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

