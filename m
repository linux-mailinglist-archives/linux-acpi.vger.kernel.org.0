Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF30014B6A4
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 15:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgA1OGp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 09:06:45 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728060AbgA1OEX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 09:04:23 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3EA43D9489E734582F3A;
        Tue, 28 Jan 2020 14:04:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 14:04:20 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 14:04:20 +0000
Subject: Re: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <jeremy.linton@arm.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-2-git-send-email-john.garry@huawei.com>
 <20200128123415.GB36168@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <60c79aaa-4c49-71b1-11be-8e41a6bf3c1d@huawei.com>
Date:   Tue, 28 Jan 2020 14:04:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200128123415.GB36168@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/01/2020 12:34, Sudeep Holla wrote:

Hi Sudeep,

> On Tue, Jan 28, 2020 at 07:14:18PM +0800, John Garry wrote:
>> The ACPI PPTT ID structure (see 6.2 spec, section 5.2.29.3) allows the
>> vendor to provide an identifier (or vendor specific part number) for a
>> particular processor hierarchy node structure. That may be a processor
>> identifier for a processor node, or some chip identifier for a processor
>> package node.
>>
> 
> Unfortunately, there were plans to deprecate this in favour of the new
> SOC_ID SMCCC API[1]. I am not sure if you or anyone in your company have
> access to UEFI ASWG mantis where you can look for the ECR for the PPTT
> Type 2 deprecation.

I wasn't aware and I can't get access...

Personally I would rather PPTT ID structure have a fixed field 
definition in future spec versions, rather than deprecate.

 From checking here, nobody has even used it (properly) for processor 
package nodes:
https://github.com/tianocore/edk2-platforms/tree/master/Platform

  I understand it's not ideal, but we need to converge,
> please take a look at both before further discussion.

I can only check the SMCCC extension which you pointed me at.

> 
> I personally would not prefer to add the support when I know it is getting
> deprecated. I am not sure on kernel community policy on the same.

So I need a generic solution for this, as my userspace tool requires a 
generic solution.

> 
> 
> [...]
> 
>>
>> The ID structure table has a number of fields, which are left open to
>> interpretation per implementation. However the spec does provide reference
>> examples of how the fields could be used. As such, just provide the
>> table fields directly in the API, which the caller may interpret (probably
>> as per spec example).
>>
> 
> The "open for interpretation" part is why it's not being favoured anymore
> by silicon vendors as OEM/ODMs can override the same.
> 
>> https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/
>>
> Ah, there's already quite a lot of dependency built for this feature :(

Not really. It's only an RFC ATM, and my requirement is a sysfs file to 
read the SoC id(s) (under ACPI FW). So I would still expect to be able 
to support this from the SMCCC extension method.

> 
> --
> Regards,
> Sudeep
> 
> [1] https://developer.arm.com/docs/den0028/c
> .
> 

Cheers,
John

