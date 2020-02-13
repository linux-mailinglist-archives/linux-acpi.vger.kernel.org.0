Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EE115C8D9
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2020 17:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgBMQwr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Feb 2020 11:52:47 -0500
Received: from foss.arm.com ([217.140.110.172]:50924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbgBMQwq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 13 Feb 2020 11:52:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 230C8328;
        Thu, 13 Feb 2020 08:52:46 -0800 (PST)
Received: from [192.168.122.164] (U201426.austin.arm.com [10.118.28.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A1213F6CF;
        Thu, 13 Feb 2020 08:52:46 -0800 (PST)
Subject: Re: About PPTT find_acpi_cpu_topology_package()
To:     John Garry <john.garry@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
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
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <2feeb7aa-465c-6d40-920b-2c1aa25fbed6@arm.com>
Date:   Thu, 13 Feb 2020 10:52:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <76c2c4fa-3466-171b-3538-9a7374f4baae@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,


On 2/13/20 8:33 AM, John Garry wrote:
> On 13/02/2020 14:00, Sudeep Holla wrote:
>> On Thu, Feb 13, 2020 at 11:52:09AM +0000, John Garry wrote:
>>
>> [...]
>>
> 
> Hi Sudeep,
> 
>>>
>>> As for when it's not set, it's unclear. My understanding is that the 
>>> ACPI
>>> processor id should still be used as the non-leaf node identifier, 
>>> but it
>>> would not match a UID for a processor container (as it may not exist).
>>>
>>
>> I can't infer anything that matches your understanding from the spec in
>> this regard. If it's not set, then it is left to OSPM.
>>
> 
> ACPI Processor ID valid just means that there is an associated processor 
> container entry which has a UID which matches the ACPI Processor ID for 
> this node.
> 
> I can't see anything to say that if the ACPI Processor ID valid flag is 
> unset then the ACPI processor ID itself is not still a valid identifier. 
> As such, it's implied that it is still valid. But the spec should be 
> clarified here.

I see what your saying here, but I think the implication is that no 
useful information is contained in the field when its not marked valid.
"The flags field (...) includes a bit to describe whether (this field) 
is valid"

Make sure your looking at ACPI 6.3+ because its a lot cleaner than the 
earlier revisions, particularly around the leaf node case.
