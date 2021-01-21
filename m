Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F352FF88F
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 00:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbhAUXQH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 18:16:07 -0500
Received: from foss.arm.com ([217.140.110.172]:47806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbhAUXQD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 18:16:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D250411B3;
        Thu, 21 Jan 2021 15:15:08 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 194C53F68F;
        Thu, 21 Jan 2021 15:15:06 -0800 (PST)
Subject: Re: [PATCH] ACPI/IORT: Do not blindly trust DMA masks from firmware
To:     Moritz Fischer <mdf@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        moritzf@google.com, sudeep.holla@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210121191612.90387-1-mdf@kernel.org>
 <faa089d5-48e3-d51d-0d14-849e5446dbf4@arm.com> <YAnvckodi9MOTrV4@epycbox.lan>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8eb32be-0aca-e8a3-046b-e280ea9c31d1@arm.com>
Date:   Thu, 21 Jan 2021 23:15:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAnvckodi9MOTrV4@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-01-21 21:17, Moritz Fischer wrote:
> Robin,
> 
> On Thu, Jan 21, 2021 at 08:08:42PM +0000, Robin Murphy wrote:
>> On 2021-01-21 19:16, Moritz Fischer wrote:
>>> Address issue observed on real world system with suboptimal IORT table
>>> where DMA masks of PCI devices would get set to 0 as result.
>>>
>>> iort_dma_setup() would query the root complex' IORT entry for a DMA
>>> mask, and use that over the one the device has been configured with
>>> earlier.
>>>
>>> Ideally we want to use the minimum mask of what the IORT contains for
>>> the root complex and what the device was configured with, but never 0.
>>>
>>> Fixes: 5ac65e8c8941 ("ACPI/IORT: Support address size limit for root complexes")
>>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>>> ---
>>> Hi all,
>>>
>>> not sure I'm doing this right, but I think the current behavior (while a
>>> corner case) seems to also fail for 32 bit devices if the IORT specifies
>>> 64 bit. It works on my test system now with a 32 bit device.
>>
>> I suppose it could go wrong if it's an old driver that doesn't explicitly
>> set its own masks and assumes they will always be 32-bit. Technically we'd
>> consider that the driver's fault these days, but there's a lot of legacy
>> around still.
> 
> Huh, ok :) That's news to me. On my system I had three devices running
> into this, so yeah I think it's quite common.

Indeed, I'm sure there are plenty of drivers that haven't been touched 
in decades because they're complete and working, and back then they were 
allowed to make that assumption.

> If that's the official stance I can send patches for the drivers in
> question :)

It's certainly good practice, especially for older devices that are 
still popular enough to see use on the increasing variety of new 
systems. Some people are still using the infamous arm64 platform where 
all the RAM is above 40 bits, for instance, and who knows how creative 
system designers might continue to be, so better to give the driver a 
chance to bail out of probing in the rare event that explicitly setting 
its 32-bit masks *does* fail, rather than let it assume DMA should work 
then get confused when it doesn't.

>>> Open to suggestions for better solutions (and maybe the
>>> nc_dma_get_range() should have the same sanity check?)
>>
>> Honestly the more I come back to this, the more I think we should give up
>> trying to be clever and just leave the default masks alone beyond the
>> initial "is anything set up at all?" sanity checks. Setting the bus limit is
>> what really matters these days, and should be sufficient to encode any
>> genuine restriction. There's certainly no real need to widen the default
>> masks above 32 bits just because firmware suggests so, since the driver
>> should definitely be calling dma_set_mask() and friends later if it's
>>> 32-bit capable anyway.
>>
>>> Thanks,
>>> Moritz
>>>
>>> ---
>>>    drivers/acpi/arm64/iort.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index d4eac6d7e9fb..c48eabf8c121 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -1126,6 +1126,11 @@ static int rc_dma_get_range(struct device *dev, u64 *size)
>>>    	rc = (struct acpi_iort_root_complex *)node->node_data;
>>> +	if (!rc->memory_address_limit) {
>>> +		dev_warn(dev, "Root complex has broken memory_address_limit\n");
>>
>> Probably warrants a FW_BUG in there.
>>
>>> +		return -EINVAL;
>>> +	}
>>> +
>>>    	*size = rc->memory_address_limit >= 64 ? U64_MAX :
>>>    			1ULL<<rc->memory_address_limit;
>>> @@ -1172,9 +1177,9 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>>    		 */
>>>    		end = dmaaddr + size - 1;
>>>    		mask = DMA_BIT_MASK(ilog2(end) + 1);
>>> -		dev->bus_dma_limit = end;
>>> -		dev->coherent_dma_mask = mask;
>>> -		*dev->dma_mask = mask;
>>> +		dev->bus_dma_limit = min_not_zero(dev->bus_dma_limit, end);
>>
>> This doesn't need to change, since the default bus limit is 0 anyway (and
>> that means "no limit").
> Ok, I'll drop this.
>>
>>> +		dev->coherent_dma_mask = min_not_zero(dev->coherent_dma_mask, mask);
>>> +		*dev->dma_mask = min_not_zero(*dev->dma_mask, mask);
> 
> I'll keep those two?

Well...

>> AFAICS the only way an empty mask could get here now is from
>> nc_dma_get_range(), so I'd rather see a consistent warning there than just
>> silently start working around that too.
> 
> In my case the empty mask came from the pci dev branch returning a size
> of 1. (1 << 0).

In fact I think I was too hasty in saying even that - it actually looks 
like you can't get a mask of 0 either way. If memory_address_limit is 0, 
then size is 1, dmaaddr is 0 (since acpi_dma_get_range() had to fail in 
the first place), so end is 0, so mask is DMA_BIT_MASK(0 + 1), which is 
1. So min_not_zero() still does nothing :/

> I'll replace the dev_warn() with a pr_warn(FW_BUG ...) for both
> {nc,rc}_dma_get_range() cases then?

Yes, I think it's worth being consistent. And then we can't ever get 
past the "if (!ret)" condition without a valid size, so we definitely 
don't need to touch anything inside it. And by "valid" I mean that if 
someone goes to the effort of filling in that field with even a 1, then 
by 'eck we're givin'em the 1-bit DMA limit they asked for!

>> Of course IORT doesn't say these fields are optional (other than the lack of
>> a root complex limit in older table versions), so we're giving bad firmware
>> a pass to never be fixed, ho hum...
> 
> I think if we yell loud enough (like FW_BUG) that'll get people's
> attention?

Ha! I've got a machine where MSIs don't work (let alone SMMU 
translation...) because some of the device mapping offsets are pointing 
into random parts of the IORT like the middle of other nodes' headers. 
If it boots to a prompt at all, someone somewhere will be happy to ship 
it ;)

Robin.
