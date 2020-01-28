Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8514C0F4
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 20:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgA1T2Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 14:28:16 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2324 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbgA1T2Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 14:28:16 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DCEEB7FA2427FC51A8A0;
        Tue, 28 Jan 2020 19:28:12 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 19:28:12 +0000
Received: from [127.0.0.1] (10.210.167.110) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 19:28:11 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
 <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
 <CAJZ5v0jN5ED_U2s06--8Rx-S4g-wuVxw9YPR12_WL3TnV81_Ag@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b6cc7edd-fbb9-ed7a-412e-0d75e4c8ec2b@huawei.com>
Date:   Tue, 28 Jan 2020 19:28:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jN5ED_U2s06--8Rx-S4g-wuVxw9YPR12_WL3TnV81_Ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.110]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


>>>>
>>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>>> ---
>>>>    drivers/soc/Makefile       |   1 +
>>>>    drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 103 insertions(+)
>>>>    create mode 100644 drivers/soc/acpi_generic.c
>>>>
>>>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>>>> index 8b49d782a1ab..2a59a30a22cd 100644
>>>> --- a/drivers/soc/Makefile
>>>> +++ b/drivers/soc/Makefile
>>>> @@ -3,6 +3,7 @@
>>>>    # Makefile for the Linux Kernel SOC specific device drivers.
>>>>    #
>>>>
>>>> +obj-$(CONFIG_ACPI_PPTT)                += acpi_generic.o
>>>>    obj-$(CONFIG_ARCH_ACTIONS)     += actions/
>>>>    obj-$(CONFIG_SOC_ASPEED)       += aspeed/
>>>>    obj-$(CONFIG_ARCH_AT91)                += atmel/
>>>
>>> Based on everything I've seen so far, this should go under drivers/acpi instead.
>>
>> soc drivers seem to live in drivers/soc (non-arm32, anyway), so I
>> decided on this location. But drivers/acpi would also seem reasonable now.
> 

Hi Rafael,

> Any reasons for not putting it into drivers/acpi/pptt.c specifically?
> .

I don't think so.

One thing is that the code does a one-time scan of the PPTT to find all 
processor package nodes with ID structures to register the soc devices - 
so we would need some new call from from acpi_init() for that.

Thanks,
John


