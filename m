Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685B015AD8C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 17:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgBLQlt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 11:41:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2417 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbgBLQlt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 11:41:49 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3E82A7C504FEDD7BB71E;
        Wed, 12 Feb 2020 16:41:47 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 16:41:47 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 12 Feb
 2020 16:41:46 +0000
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
 <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
Date:   Wed, 12 Feb 2020 16:41:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>
>> How about something like this:
>>
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct 
>> acpi_table_header *table,
>>    if (level == 0 || cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>>      return cpu_node->acpi_processor_id;
>> +   if (level == PPTT_ABORT_PACKAGE)
>> +    pr_warn_once("ACPI Processor ID valid not set for physical 
>> package node, will use node table offset as substitute for UID\n");
> 

Hi Jeremy,

> To clarify my other email there, since I can't seem to type clearly..
> 
> Just note that find_acpi_cpu_topology_hetero_id() is also using a 
> PPTT_ABORT_PACKAGE termination.

OK, so I may need to check the flag == ACPI_PPTT_PHYSICAL_PACKAGE also.

BTW, Is the value returned by find_acpi_cpu_topology_hetero_id() also 
exposed to userspace some way? Or any other PPTT offsets?

> 
> 
>>                  return ACPI_PTR_DIFF(cpu_node, table);
>>          }
>>          pr_warn_once("PPTT table found, but unable to locate core %d 
>> (%d)\n",
>>

I'll validate Sudeep's suggestion to set the Processor ID valid flag and 
appropriate processor id for the physical package cpu node with an 
experimental firmware before sending any patch. There seems to be a bit 
of doubt on your part regarding that.

Thanks,
John
