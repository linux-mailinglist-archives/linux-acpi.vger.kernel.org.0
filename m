Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF03C15ABAC
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 16:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBLPFX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 10:05:23 -0500
Received: from foss.arm.com ([217.140.110.172]:33922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728428AbgBLPFX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 10:05:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 206E8328;
        Wed, 12 Feb 2020 07:05:23 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97E953F68F;
        Wed, 12 Feb 2020 07:05:22 -0800 (PST)
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     Sudeep Holla <sudeep.holla@arm.com>,
        John Garry <john.garry@huawei.com>
Cc:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "liuqi (BA)" <liuqi115@huawei.com>
References: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
 <20200212115945.GA36981@bogus>
 <be88fdfc-50a0-9753-4f8f-d80c303892be@huawei.com>
 <20200212135551.GB36981@bogus>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <0edb6aa9-c96f-71c1-a3ab-a95df4c07317@arm.com>
Date:   Tue, 11 Feb 2020 12:49:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212135551.GB36981@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 2/12/20 7:55 AM, Sudeep Holla wrote:
> On Wed, Feb 12, 2020 at 12:48:33PM +0000, John Garry wrote:
>> On 12/02/2020 11:59, Sudeep Holla wrote:
> 
> [...]
> 
>>> Yes, as mentioned above. We are not going to do extra work for lazy firmware.
>>
>> I don't think it's reasonable to just label this as lazy. The table may just
>> not have the flag set unintentionally. FW and software guys make mistakes,
>> like the mistakes in PPTT, itself.
>>
> 
> We are not talking about flags, it's UID and it is pretty important if
> there are more than one objects of same time.

But, this hints at my reservations with this approach. If you wanted to 
have your processors numbered 0...x and your sockets numbered 0...y, 
there could be overlap in the processor container objects, which should 
also be avoided.

> 
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
> 
>> If not, at least make the user know of potential deficiencies in the table.
>>
> 
> How ? What are your suggestions ? Does adding a warning or note that UID
> is missing and offset is chosen help ? I am kind of fine with that.
> 
> --
> Regards,
> Sudeep
> 

