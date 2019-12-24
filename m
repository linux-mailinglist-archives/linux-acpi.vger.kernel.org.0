Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C41129C53
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2019 02:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLXBLN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Dec 2019 20:11:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726833AbfLXBLN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Dec 2019 20:11:13 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 31C863129C7C45629912;
        Tue, 24 Dec 2019 09:11:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Dec 2019
 09:11:03 +0800
Subject: Re: [RFC PATCH 1/2] ACPICA/IORT: Correct the comment for id_count
To:     John Garry <john.garry@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "Erik Schmauss" <erik.schmauss@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1577092997-9852-1-git-send-email-guohanjun@huawei.com>
 <efd1d3fd-0e7c-64af-f226-5f263e48d88c@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <02a5dc75-d1f1-9df5-3ce2-482fbf86075b@huawei.com>
Date:   Tue, 24 Dec 2019 09:10:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <efd1d3fd-0e7c-64af-f226-5f263e48d88c@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/12/23 18:35, John Garry wrote:
> On 23/12/2019 09:23, Hanjun Guo wrote:
>> In IORT spec
>> (http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf),
>> id_num means Number of IDs minus one, update the comment.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>
>> This patch just for comments, needs to be upstream in ACPICA first.
>>
>>   include/acpi/actbl2.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index e45ced2..382642f 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
>> @@ -104,7 +104,7 @@ enum acpi_iort_node_type {
>>     struct acpi_iort_id_mapping {
>>       u32 input_base;        /* Lowest value in input range */
>> -    u32 id_count;        /* Number of IDs */
>> +    u32 id_count;        /* Number of IDs in the range minus one */
> 
> The IORT spec also uses the term "Length" in the examples...

More confusing...

