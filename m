Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E171B0757
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Apr 2020 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTLX0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Apr 2020 07:23:26 -0400
Received: from foss.arm.com ([217.140.110.172]:46736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgDTLX0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Apr 2020 07:23:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E465F1FB;
        Mon, 20 Apr 2020 04:23:25 -0700 (PDT)
Received: from [10.57.33.63] (unknown [10.57.33.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0CE33F237;
        Mon, 20 Apr 2020 04:23:24 -0700 (PDT)
Subject: Re: [PATCH] acpi: arm64/iort: Ensure DMA mask does not exceed device
 limit
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        sudeep.holla@arm.com, guohanjun@huawei.com
References: <20200420081131.16822-1-ardb@kernel.org>
 <20200420093055.GA7393@e121166-lin.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f71002a8-fc32-f271-1586-807fc6f50107@arm.com>
Date:   Mon, 20 Apr 2020 12:23:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420093055.GA7393@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-04-20 10:30 am, Lorenzo Pieralisi wrote:
> [+Robin]
> 
> On Mon, Apr 20, 2020 at 10:11:31AM +0200, Ard Biesheuvel wrote:
>> When calculating the DMA mask from the address limit provided by the
>> firmware, we add one to the ilog2() of the end address, and pass the
>> result to DMA_BIT_MASK().
>>
>> For an end address that is not a power-of-2 minus 1, this will result
>> in the mask to be wider than the limit, and cover memory that is not
>> addressable by the device. Instead, we should add 1 to 'end' before
>> taking the log, so that a limit of, say, 0x3fffffff gets translated
>> to a mask of 30, but any value below it gets translated to 29.
>>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   drivers/acpi/arm64/iort.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Need Robin's feedback on this - I was looking at:
> 
> a7ba70f1787f ("dma-mapping: treat dev->bus_dma_mask as a DMA limit")
> 
> I assume current code is *intended* but I shall let Robin comment
> on this.

The device masks represent what bits the device is capable of driving, 
so rounding up is the correct and intended behaviour - if the 
interconnect address map imposes a non-power-of-two limit, say 3.75GB, 
and the device can physically access all of that, then claiming the 
device can't drive bit 31 and trying to prevent it from accessing the 
upper 1.75GB is nonsense.

Although TBH none of this really matters much any more - as long as the 
limit is set correctly nothing bad will happen, and drivers are expected 
to replace these default masks anyway. In fact ancient drivers that 
still don't explicitly set their masks will be assuming the defaults are 
32-bit, so replacing them with something potentially wider actually 
invites a whole other set of problems. In the case of 
of_dma_configure(), it kept the code that combines (*not* replaces) the 
default device masks with a limit-based mask because it didn't do any 
harm, but equally it should now be entirely unnecessary, and confusion 
like this seems like an argument for finally removing it.

Robin.

> 
> Thanks,
> Lorenzo
> 
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 7d04424189df..aab2f51eff14 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1162,7 +1162,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>   		 * firmware.
>>   		 */
>>   		end = dmaaddr + size - 1;
>> -		mask = DMA_BIT_MASK(ilog2(end) + 1);
>> +		mask = DMA_BIT_MASK(ilog2(end + 1));
>>   		dev->bus_dma_limit = end;
>>   		dev->coherent_dma_mask = mask;
>>   		*dev->dma_mask = mask;
>> -- 
>> 2.17.1
>>
