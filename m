Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D334A834
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 19:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfFRRXh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Jun 2019 13:23:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729325AbfFRRXh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Jun 2019 13:23:37 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BB44A547BFFE83A7EBBF;
        Wed, 19 Jun 2019 01:23:34 +0800 (CST)
Received: from [127.0.0.1] (10.210.170.177) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Jun 2019
 01:23:32 +0800
Subject: Re: [PATCH v2 1/2] ACPI/PPTT: Add support for ACPI 6.3 thread flag
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190614223158.49575-1-jeremy.linton@arm.com>
 <20190614223158.49575-2-jeremy.linton@arm.com>
 <667f95c0-5aa9-f460-a49a-e6dfefc027d8@arm.com>
 <2d1b547f-f9ee-391c-c4f3-0232a08a86bc@arm.com>
 <718438d0-8648-897a-83e8-801146a0af86@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <rjw@rjwysocki.net>, <sudeep.holla@arm.com>, <lenb@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f6f7f9bb-547d-3fd3-f3f8-1d55181f63d7@huawei.com>
Date:   Tue, 18 Jun 2019 18:23:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <718438d0-8648-897a-83e8-801146a0af86@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.177]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/06/2019 15:40, Valentin Schneider wrote:
> On 18/06/2019 15:21, Jeremy Linton wrote:
> [...]
>>>> + * Return: -ENOENT if the PPTT doesn't exist, the CPU cannot be found or
>>>> + *       the table revision isn't new enough.
>>>> + * Otherwise returns flag value
>>>> + */
>>>
>>> Nit: strictly speaking we're not returning the flag value but its mask
>>> applied to the flags field. I don't think anyone will care about getting
>>> the actual flag value, but it should be made obvious in the doc:
>>
>> Or I clarify the code to actually do what the comments says. Maybe that is what John G was also pointing out too?
>>

No, I was just saying that the kernel topology can be broken without 
this series.

>
> Mmm I didn't find any reply from John regarding this in v1, but I wouldn't
> mind either way, as long as the doc & code are aligned.
>

BTW, to me, function acpi_pptt_cpu_is_thread() seems to try to do too 
much, i.e. check if the PPTT is new enough to support the thread flag 
and also check if it is set for a specific cpu. I'd consider separate 
functions here.

thanks,
John

> [...]
>
> .
>


