Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0322319C1EF
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387866AbgDBNSN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 09:18:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2631 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387752AbgDBNSN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 09:18:13 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3DFDCB91ECFB8F4713C1;
        Thu,  2 Apr 2020 14:18:10 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.242) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 2 Apr 2020
 14:18:07 +0100
Subject: Re: [PATCH] ACPI: PPTT: Inform user that table offset used for
 Physical processor node ID
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeremy.linton@arm.com>, <linuxarm@huawei.com>,
        <wanghuiqiang@huawei.com>
References: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
 <20200402123501.GA26588@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a861c0a5-2967-98a8-9666-428bef4891c9@huawei.com>
Date:   Thu, 2 Apr 2020 14:17:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200402123501.GA26588@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.242]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 02/04/2020 14:08, Sudeep Holla wrote:
> (I see 2 copies of this patch, replying on the latest)

I sent 2x copies accidentally. WFH....

> 
> On Thu, Apr 02, 2020 at 08:22:25PM +0800, John Garry wrote:
>> If the the Processor ID valid is not set for a Physical Processor Package
>> node, then the node table offset is used as a substitute. As such, we
>> may get info like this from sysfs:
>>
>> root@(none)$ pwd
>> /sys/devices/system/cpu/cpu0/topology
>> root@(none)$ more physical_package_id
>> 56
>>
>> Inform the user of this in the bootlog, as it is much less than ideal, and
>> they can remedy this in their FW.
>>
>> This topic was originally discussed in:
>> https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a
>>
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

thanks

> 
> --
> Regards,
> Sudeep
> .
> 

