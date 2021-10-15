Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05B042ECDE
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Oct 2021 10:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhJOI4B (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Oct 2021 04:56:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25192 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhJOI4B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Oct 2021 04:56:01 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HW0Qh4lQ2z8tgb;
        Fri, 15 Oct 2021 16:52:44 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:53:53 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 16:53:52 +0800
Subject: Re: [PATCH] acpi: arm64: fix section mismatch warning
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Arnd Bergmann <arnd@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210927141921.1760209-1-arnd@kernel.org>
 <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
 <20211013090254.GA9901@lpieralisi>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <220f6cfb-80b1-44db-ce1d-462af5dbf74e@huawei.com>
Date:   Fri, 15 Oct 2021 16:53:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211013090254.GA9901@lpieralisi>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/10/13 17:02, Lorenzo Pieralisi wrote:
> On Tue, Oct 12, 2021 at 03:03:29PM +0800, Hanjun Guo wrote:
>> Hi Arnd,
>>
>> On 2021/9/27 22:19, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> In a gcc-11 randconfig build I came across this warning:
>>>
>>> WARNING: modpost: vmlinux.o(.text.unlikely+0x2c084): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
>>> The function next_platform_timer() references
>>> the variable __initdata acpi_gtdt_desc.
>>> This is often because next_platform_timer lacks a __initdata
>>> annotation or the annotation of acpi_gtdt_desc is wrong.
>>>
>>> This happens when next_platform_timer() fails to get inlined
>>> despite the inline annotation. Adding '__init' solves the issue,
>>> and it seems best to remove the 'inline' in the process seems
>>> better anyway.
>>
>> There was a patch to fix this issue as well [1],
>> but not merged yet.
>>
>> [1]: https://lore.kernel.org/linux-acpi/7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com/T/
> 
> My bad, we did not coordinate well - I noticed your Acked-by but as a
> rule we should also CC LAKML and Catalin/Will (if they aren't CCed) on
> the reply to make sure they can actually see it.

It's my bad. I will make sure LAKML and Catalin/Will are CCed next time
when I reply the email.

Thanks
Hanjun
