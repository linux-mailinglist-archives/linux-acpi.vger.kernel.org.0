Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4769138C25
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2020 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAMHFS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Jan 2020 02:05:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgAMHFS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jan 2020 02:05:18 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 90D8B53AD7DB6C6596EA;
        Mon, 13 Jan 2020 15:05:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 15:05:07 +0800
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
 <20200110121148.GA22244@e121166-lin.cambridge.arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3b45e62a-89bf-a950-d3de-1435cba9d1a8@huawei.com>
Date:   Mon, 13 Jan 2020 15:04:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20200110121148.GA22244@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/1/10 20:11, Lorenzo Pieralisi wrote:
> On Mon, Dec 30, 2019 at 08:27:04PM +0800, Hanjun Guo wrote:
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
>> Input base:  0x1000
>> ID Count:    0x100
>> Output base: 0x1000
>> Output reference: 0xC4  //ITS reference
>>
>> PCI hostbridge mapping entry 2:
>> Input base:  0x1100
>> ID Count:    0x100
>> Output base: 0x2000
>> Output reference: 0xD4  //ITS reference
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
>> I checked the ACPI tables in the tianocore/edk2-platforms [2], only
>> HiSilicon HIP07/08 did wrong, so just add HIP07/08 to the workaround
>> info table, if we break other platforms, we can add that later.
>>
>> [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
>> [1]: https://patchwork.kernel.org/patch/11292823/
>> [2]: https://github.com/tianocore/edk2-platforms
>>
>> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Commit log rewritten below - please update the code (and check the
> log) as per this thread discussion.

Thank you, I will resend it ASAP.

Thanks
Hanjun

