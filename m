Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DB15C064
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 15:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBMOd2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 09:33:28 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2423 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbgBMOd2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Feb 2020 09:33:28 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 839855F30B63786EFC09;
        Thu, 13 Feb 2020 14:33:26 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 13 Feb 2020 14:33:26 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 13 Feb
 2020 14:33:26 +0000
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Jeremy Linton <jeremy.linton@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <76c2c4fa-3466-171b-3538-9a7374f4baae@huawei.com>
Date:   Thu, 13 Feb 2020 14:33:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200213140006.GB31787@bogus>
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

On 13/02/2020 14:00, Sudeep Holla wrote:
> On Thu, Feb 13, 2020 at 11:52:09AM +0000, John Garry wrote:
> 
> [...]
> 

Hi Sudeep,

>>
>> As for when it's not set, it's unclear. My understanding is that the ACPI
>> processor id should still be used as the non-leaf node identifier, but it
>> would not match a UID for a processor container (as it may not exist).
>>
> 
> I can't infer anything that matches your understanding from the spec in
> this regard. If it's not set, then it is left to OSPM.
> 

ACPI Processor ID valid just means that there is an associated processor 
container entry which has a UID which matches the ACPI Processor ID for 
this node.

I can't see anything to say that if the ACPI Processor ID valid flag is 
unset then the ACPI processor ID itself is not still a valid identifier. 
As such, it's implied that it is still valid. But the spec should be 
clarified here.

>> The kernel does have behave according to this.
>>
> 
> According to what in the specification ?

That's just based on my interpretation, above. That being, the ACPI 
Processor ID is always valid, independent of whether ACPI Processor ID 
valid flag is set.

> 
>> So how I am misinterpreting this?
>>
> 
> May be you are not, it is just ambiguous in the spec, worth checking and
> fixing if it is an issue.

Absolutely agree on all of this.

> I reiterate we don't want to generate anything
> in the OS for this purpose.

I'm ok with that.

Cheers,
John
