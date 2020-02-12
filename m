Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2CFC15AB17
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 15:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgBLOlI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 09:41:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2415 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727092AbgBLOlH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 09:41:07 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 8BFA844D9C204BC93554;
        Wed, 12 Feb 2020 14:41:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 14:41:05 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 12 Feb
 2020 14:41:05 +0000
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
Date:   Wed, 12 Feb 2020 14:41:04 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200212135551.GB36981@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 12/02/2020 13:55, Sudeep Holla wrote:
> On Wed, Feb 12, 2020 at 12:48:33PM +0000, John Garry wrote:
>> On 12/02/2020 11:59, Sudeep Holla wrote:
> 
> [...]
> 

Hi Sudeep,

>>> Yes, as mentioned above. We are not going to do extra work for lazy firmware.
>>
>> I don't think it's reasonable to just label this as lazy. The table may just
>> not have the flag set unintentionally. FW and software guys make mistakes,
>> like the mistakes in PPTT, itself.
>>
> 
> We are not talking about flags, it's UID and it is pretty important if
> there are more than one objects of same time.
> 

I am talking about the Processor ID valid flag, which is specifically 
related.

>>> Linux also will be lazy on such platform and provide weird unique numbers
>>> like in the above case you have mentioned.
>>
>> Personally I think that the kernel can be do better than provide meaningless
>> values like this, since it knows the processor IDs and which physical
>> package they belong to.
>>
> 
> This was discussed quite a lot, I can dig and point you to it. That's the
> reason for choosing offset. We are *not going back* to this again. Fix the
> firmware before it gets copied for all future platforms and Linux has to
> deal with that *forever*.

I would liked to have been made aware earlier of the oversight. Quite 
often we only find problems when someone or something complains.

It is a strange API to provide offsets like this, and I did not realize 
that they were actually being exposed to userspace.

> 
>> If not, at least make the user know of potential deficiencies in the table.
>>
> 
> How ? What are your suggestions ? Does adding a warning or note that UID
> is missing and offset is chosen help ? 

I'd say so. I know now, but let's save others the potential hassle. And 
having this debate again.

I am kind of fine with that.

How about something like this:

--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
acpi_table_header *table,
   if (level == 0 || cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
	return cpu_node->acpi_processor_id;
+   if (level == PPTT_ABORT_PACKAGE)
+	pr_warn_once("ACPI Processor ID valid not set for physical package 
node, will use node table offset as substitute for UID\n");
                 return ACPI_PTR_DIFF(cpu_node, table);
         }
         pr_warn_once("PPTT table found, but unable to locate core %d 
(%d)\n",

Thanks,
John
