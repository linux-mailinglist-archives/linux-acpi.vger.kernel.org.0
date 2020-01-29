Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 428C514C86F
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jan 2020 10:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgA2J6H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jan 2020 04:58:07 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2326 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgA2J6H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Jan 2020 04:58:07 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 6C5DEA6AF853B8C8AC10;
        Wed, 29 Jan 2020 09:58:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Jan 2020 09:58:05 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jan
 2020 09:58:04 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     Olof Johansson <olof@lixom.net>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
 <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
 <CAOesGMjrC=b781LLU-Btp1b9uKTiMXj8tF3rjK_Wy6Q4iaR+Rw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <734a01d8-3b50-48ca-1d94-d79d0e6610ff@huawei.com>
Date:   Wed, 29 Jan 2020 09:58:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAOesGMjrC=b781LLU-Btp1b9uKTiMXj8tF3rjK_Wy6Q4iaR+Rw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Olof,

>>>
>>> Based on everything I've seen so far, this should go under drivers/acpi instead.
>>
>> soc drivers seem to live in drivers/soc (non-arm32, anyway), so I
>> decided on this location. But drivers/acpi would also seem reasonable now.
> 
> We don't want drivers/soc to be too much of a catch-all -- it is meant
> for some of the glue pieces that don't have good homes elsewhere.
> Unfortunately, the slope is slippery and we've already gone down it a
> bit, but I think we can fairly clearly declare that this kind of
> cross-soc material is likely not the right home for it -- especially
> when drivers/acpi is a good fit in this case.

ok

> 
>>>> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
>>>> new file mode 100644
>>>> index 000000000000..34a1f5f8e063
>>>> --- /dev/null
>>>> +++ b/drivers/soc/acpi_generic.c
>>>> @@ -0,0 +1,102 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (c) John Garry, john.garry@huawei.com
>>>> + */
>>>> +
>>>> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +#include <linux/sys_soc.h>
>>>> +

[...]

>>>
>>> Hmm, this doesn't look like much of a driver to me. This looks like
>>> the export of an attribute to userspace, and should probably be done
>>> by ACPI core instead of creating an empty driver for it.
>>
>> OK, but I'm thinking that having a soc driver can be useful as it is
>> common to DT, and so userspace only has to check a single location. And
>> the soc driver can also cover multiple-chip systems without have to
>> reinvent that code for ACPI core. And it saves adding a new ABI.
> 
> While having a single location could be convenient, the actual data
> read/written would be different (I'm guessing).

Without doubt we would have different data sometimes between ACPI and DT 
FW..

And it is not ideal that the soc_id sysfs file could have different 
contents for the same SoC, depending on ACPI or DT.

> 
> We also already have a supposed standard way of figuring out what SoC
> we're on (toplevel compatible for the DT). 

 From checking some soc drivers, there is a distinction between how 
soc_id and machine is evaluated: machine comes from DT model, which 
looks standard; however soc_id seems to have different methods of 
evaluate, like sometimes reading some system id register (I'm checking 
exynos-chipid.c there).

We're just looking for soc_id. But, as before, it would probably be 
different between ACPI and DT, so not ideal.

So no matter what, I think
> userspace will need to handle two ways of probing this.
> 

That should not be a big problem.

> 

Thanks,
John

