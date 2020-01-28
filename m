Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 040B014C086
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgA1TER (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 14:04:17 -0500
Received: from foss.arm.com ([217.140.110.172]:33906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgA1TEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 14:04:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CBA6328;
        Tue, 28 Jan 2020 11:04:16 -0800 (PST)
Received: from [192.168.122.167] (unknown [10.118.28.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E15503F52E;
        Tue, 28 Jan 2020 11:04:15 -0800 (PST)
Subject: Re: [PATCH RFC 0/2] Add basic generic ACPI soc driver
To:     John Garry <john.garry@huawei.com>, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     arnd@arndb.de, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, guohanjun@huawei.com,
        gregkh@linuxfoundation.org
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <bb87efe5-d0be-498a-25a1-008a7bebd452@arm.com>
 <5ab3a97d-bbc4-6d5a-fd06-f8da324339ab@huawei.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <6be8d175-477d-d163-3fe0-3ab562874ce4@arm.com>
Date:   Tue, 28 Jan 2020 13:04:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5ab3a97d-bbc4-6d5a-fd06-f8da324339ab@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/28/20 11:28 AM, John Garry wrote:
> On 28/01/2020 16:56, Jeremy Linton wrote:
>> Hi,
>>
> 
> Hi Jeremy,
> 
>> On 1/28/20 5:14 AM, John Garry wrote:
>>> A requirement has come up recently to be able to read system SoC 
>>> packages
>>> identifiers from userspace [0].
>>>
>>> For device tree FW-based systems, this would be quite 
>>> straightforward, in
>>> that we could add a soc driver for that system and use the DT model
>>> identifier as the soc id - that's how most soc drivers seem to do it.
>>>
>>> For ACPI-based systems, the only place I know to get (put) such SoC
>>> information is in the PPTT, specifically the ID Type Structure for a
>>> processor package node. A processor package node describes a physical
>>> boundary of a processor topology.
>>
>> Well presumably that is one of the use cases for DMI, which has fields 
>> for the processor/socket as well as the machine vendor.
> 
> I did consider DMI, but I want something more generic, i.e. could cover 
> embedded/DT systems also.
> 
> And I need to double check if DMI really has the info I require. Last 
> time I checked, it didn't for my dev board, but I know that some fields 
> are simply not filled in.

Well the info is probably there, but that doesn't mean it should be used 
programmatically. As your board shows, its not that reliable. And 
looking at the linked patch I see you mention that.


> 
>>
>> But, quickly looking at the use case, I can't help but think you don't 
>> really want any of the above, or the PPTT id. It seems the mapping 
>> should actually be tied directly to the uncore PMU definition, rather 
>> than a soc/machine/whatever identifier. Which would imply keying off 
>> one of the ACPI object identifiers for the PMU itself.
> 
> So a PMU device (/sys/bus/event_source/devices) does not have a link to 
> the ACPI object identifiers or uncore PMU platform device etc.
> 
> And even if it did, there is no clear link between that ACPI object and 
> the events it supports for that implementation.

Having a direct link isn't ideal either. It seems you do mention the pmu 
naming conventions, which can be controlled based on ACPI object 
identifiers. Something like "uncore_dmc_hsi1" where the appended bits 
could for example vary on _CID+_UID or DT name.

Not sure that is a particularly good suggestion either, but I do think 
its a better idea to tie the mapping to the pmu type/man/version concept 
than the SOC it appears in. The sysfs-bus-event_source-devices-* ABI 
docs are noticeably silent on the format of the pmu name (is that 
somewhere else?).



