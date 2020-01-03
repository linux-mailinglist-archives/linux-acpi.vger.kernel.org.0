Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989F712F6B0
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Jan 2020 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgACKXT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Jan 2020 05:23:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:37052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgACKXS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 3 Jan 2020 05:23:18 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DE4739F734ABD3D7E3F7;
        Fri,  3 Jan 2020 18:23:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 18:23:06 +0800
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
To:     John Garry <john.garry@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Robert Richter <rrichter@marvell.com>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
 <639f61ab-e692-caaf-9b4e-b848b05caee2@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <963352e6-8ee1-6a8b-d098-9625ad2c980c@huawei.com>
Date:   Fri, 3 Jan 2020 18:20:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <639f61ab-e692-caaf-9b4e-b848b05caee2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/1/2 19:18, John Garry wrote:
> +
> 
> On 30/12/2019 12:27, Guohanjun (Hanjun Guo) wrote:
>> The IORT spec [0] says Number of IDs = The number of IDs in the range minus
>> one, it is confusing but it was written down in the first version of the
>> IORT spec. But the IORT ID mapping function iort_id_map() did something
>> wrong from the start, which bails out if:
>>
>> the request ID >= the input base + number of IDs
>>
>> This is wrong because it ignored the "minus one", and breaks some valid
>> usecases such as ID mapping to contain single device mapping without
>> single mapping flag set.
>>
>> Pankaj Bansal proposed a solution to fix the issue [1], which bails
>> out if:
>>
>> the request ID > the input base + number of IDs
>>
>> This works as the spec defined, unfortunately some firmware didn't
>> minus one for the number of IDs in the range, and the propoased
>> solution will break those systems in this way:
>>
>> PCI hostbridge mapping entry 1:
>> Input base:  0x1000
>> ID Count:    0x100
>> Output base: 0x1000
>> Output reference: 0xC4  //ITS reference
>>
>> PCI hostbridge mapping entry 2:
>> Input base:  0x1100
>> ID Count:    0x100
>> Output base: 0x2000
>> Output reference: 0xD4  //ITS reference
>>
>> Two mapping entries which the second entry's Input base = the first
>> entry's Input base + ID count, so for requester ID 0x1100 will map
>> to ITS 0xC4 not 0xD4 if we update '>=' to '>'.
>>
>> So introduce a workaround to match the IORT's OEM information for
>> the broken firmware, also update the logic of the ID mapping for
>> firmwares report the number of IDs as the IORT spec defined, to
>> make the code compatible for both kinds of system.
>>
>> I checked the ACPI tables in the tianocore/edk2-platforms [2], 
> 
> Hi Hanjun,
> 
> only
>> HiSilicon HIP07/08 did wrong, so just add HIP07/08 to the workaround
>> info table, 
> 
> Are you asserting that other platforms are ok on the basis that NumIds = large power of 2 - 1, e.g. 0xffff? Is this strictly proper?

No, some platforms with no opensource ACPI tables, are
not covered.

> 
> if we break other platforms, we can add that later.
>>
> 
> I think that it would be better to audit others now as well as best as reasonably possible. There is somewhat limited coverage in [2].

I will Cc people form Mavell, Ampere, and Ard who is know Socionext very well,
that's the best I can do.

Thanks
Hanjun

