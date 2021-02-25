Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4D325169
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 15:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBYOS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 09:18:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13378 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhBYOS3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 09:18:29 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DmZZx32Dhz7q8b;
        Thu, 25 Feb 2021 22:16:09 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 22:17:40 +0800
Subject: Re: [PATCH v1 1/4] ACPI: processor: Get rid of ACPICA message
 printing
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <5138173.kHyPcihzTF@kreacher> <10245832.OiMb8u2cOm@kreacher>
 <0faea0bd-107b-5c4c-5324-e0cd5e5cfba4@huawei.com>
 <CAJZ5v0i01rX0b-=dDJEdGsK2=6D3tXbC_wdOByTF_mJ0ggTPJQ@mail.gmail.com>
 <CAJZ5v0hwouj_1KpZ_RrC3r50RxngvinBBJVgNhQkwA3bw0oXag@mail.gmail.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <816edceb-983b-03d7-4a96-d325658417fd@huawei.com>
Date:   Thu, 25 Feb 2021 22:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hwouj_1KpZ_RrC3r50RxngvinBBJVgNhQkwA3bw0oXag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/2/25 2:06, Rafael J. Wysocki wrote:
> On Tue, Feb 23, 2021 at 3:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Tue, Feb 23, 2021 at 12:31 PM Hanjun Guo <guohanjun@huawei.com> wrote:
>>>
>>> On 2021/2/23 2:59, Rafael J. Wysocki wrote:
>>>> Index: linux-pm/drivers/acpi/processor_idle.c
>>>> ===================================================================
>>>> --- linux-pm.orig/drivers/acpi/processor_idle.c
>>>> +++ linux-pm/drivers/acpi/processor_idle.c
>>>
>>> In this file, function acpi_processor_cstate_first_run_checks()
>>> has a wrong pr_notice():
>>>
>>> pr_notice("ACPI: processor limited to max C-state %d\n",
>>>                  max_cstate);
>>>
>>> Since we have pr_fmt() for this file, "ACPI:" is duplicate,
>>> we'd better cleanup this as below:
>>>
>>> pr_notice("processor limited to max C-state %d\n", max_cstate);
>>
>> Thanks for pointing this out, I'll make this change when applying the patch.
> 
> Actually, this issue is not strictly related to the patch here, so I'm
> going to send a separate patch to fix it.

Make sense to me as well.

Thanks
Hanjun
