Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B848115D5D9
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 11:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387415AbgBNKfI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 05:35:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2427 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgBNKfH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 05:35:07 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 1D4FA64C7A29C3366FED;
        Fri, 14 Feb 2020 10:35:06 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Feb 2020 10:35:05 +0000
Received: from [127.0.0.1] (10.210.168.87) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 14 Feb
 2020 10:35:04 +0000
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
 <1a04ddf8-4903-2986-a94e-c070dc2c2160@huawei.com>
 <3c15a54a-18ac-265e-c16c-272577b9dead@arm.com>
 <bfc39a01-419a-9358-fd6d-c73fdcb9c881@huawei.com>
 <eedbafc2-019c-517f-4623-4b6ad80f5438@arm.com>
 <b9ca7718-3834-b42d-a36e-63c81f677a78@huawei.com>
 <20200213140006.GB31787@bogus>
 <76c2c4fa-3466-171b-3538-9a7374f4baae@huawei.com>
 <2feeb7aa-465c-6d40-920b-2c1aa25fbed6@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bf130dcb-73b5-7173-7111-f513e73fd12b@huawei.com>
Date:   Fri, 14 Feb 2020 10:35:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <2feeb7aa-465c-6d40-920b-2c1aa25fbed6@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.87]
X-ClientProxiedBy: lhreml710-chm.china.huawei.com (10.201.108.61) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>>
>>
>> ACPI Processor ID valid just means that there is an associated 
>> processor container entry which has a UID which matches the ACPI 
>> Processor ID for this node.
>>
>> I can't see anything to say that if the ACPI Processor ID valid flag 
>> is unset then the ACPI processor ID itself is not still a valid 
>> identifier. As such, it's implied that it is still valid. But the spec 
>> should be clarified here.
> 
> I see what your saying here, but I think the implication is that no 
> useful information is contained in the field when its not marked valid.
> "The flags field (...) includes a bit to describe whether (this field) 
> is valid"

OK, right. So I think that the wording can be improved in the spec, 
specifically around the meaning in ACPI Processor ID valid.

> 
> Make sure your looking at ACPI 6.3+ because its a lot cleaner than the 
> earlier revisions, particularly around the leaf node case.

So you have something newer than 
https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf?

> .

So my FW colleague tells me that they tried adding processor containers 
for hierarchy components, but the kernel complained. I don't know the 
specifics. I need to follow up on that.

Do I see this, which we could refer to:

https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/JunoPkg/AcpiTables/Dsdt.asl#L36

Any more pointers as references would be appreciated.

Thanks,
John
