Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D1347D69
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2019 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFQIoh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 04:44:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33878 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbfFQIoh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 Jun 2019 04:44:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E0CD46922DA6B0343C85;
        Mon, 17 Jun 2019 16:44:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Mon, 17 Jun 2019
 16:44:30 +0800
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>
References: <1560586872-40099-1-git-send-email-guohanjun@huawei.com>
 <86k1dkpruy.wl-marc.zyngier@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3a638192-9ef1-ba4a-9975-6c0b22ce5b64@huawei.com>
Date:   Mon, 17 Jun 2019 16:44:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <86k1dkpruy.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marc,

On 2019/6/17 15:56, Marc Zyngier wrote:
> Hi Hanjun,
> 
> On Sat, 15 Jun 2019 09:21:12 +0100,
> Hanjun Guo <guohanjun@huawei.com> wrote:
>>
>> The @linaro.org address is not working and bonucing, so update the
>> references.
>>
>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 57f496c..2fed10f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -364,7 +364,7 @@ F:	drivers/acpi/fan.c
>>  
>>  ACPI FOR ARM64 (ACPI/arm64)
>>  M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> -M:	Hanjun Guo <hanjun.guo@linaro.org>
>> +M:	Hanjun Guo <guohanjun@huawei.com>
>>  M:	Sudeep Holla <sudeep.holla@arm.com>
>>  L:	linux-acpi@vger.kernel.org
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 
> You may also want to consider adding an entry into .mailmap, so that
> scripts get the right address.

Thank you for the kind reminder, I will send a updated patch.

Thanks
Hanjun

