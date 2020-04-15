Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EACB1AAFC0
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Apr 2020 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411132AbgDORb4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Apr 2020 13:31:56 -0400
Received: from foss.arm.com ([217.140.110.172]:50518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411215AbgDORbx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 753D41FB;
        Wed, 15 Apr 2020 10:31:52 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6613F68F;
        Wed, 15 Apr 2020 10:31:46 -0700 (PDT)
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        ard.biesheuvel@linaro.org, ioana.ciornei@nxp.com,
        diana.craciun@oss.nxp.com, maz@kernel.org, jon@solid-run.com,
        pankaj.bansal@nxp.com, makarand.pawagi@nxp.com,
        calvin.johnson@nxp.com, V.Sethi@nxp.com, cristian.sovaiala@nxp.com,
        Stuart.Yoder@arm.com, jeremy.linton@arm.com, joro@8bytes.org,
        tglx@linutronix.de, jason@lakedaemon.net
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
 <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <78086898-d54f-63d0-f1f4-301ef2a8ea83@arm.com>
Date:   Wed, 15 Apr 2020 18:31:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020-04-15 4:44 pm, Laurentiu Tudor wrote:
> 
> 
> On 4/14/2020 5:32 PM, Lorenzo Pieralisi wrote:
>> On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
>>> Hi Lorenzo,
>>>
>>> On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
>>>> On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>>
>>>>> The devices on this bus are not discovered by way of device tree
>>>>> but by queries to the firmware. It makes little sense to trick the
>>>>> generic of layer into thinking that these devices are of related so
>>>>> that we can get our dma configuration. Instead of doing that, add
>>>>> our custom dma configuration implementation.
>>>>>
>>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>> ---
>>>>>   drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
>>>>>   1 file changed, 30 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>> index 36eb25f82c8e..eafaa0e0b906 100644
>>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>>> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>>>   static int fsl_mc_dma_configure(struct device *dev)
>>>>>   {
>>>>>   	struct device *dma_dev = dev;
>>>>> +	struct iommu_fwspec *fwspec;
>>>>> +	const struct iommu_ops *iommu_ops;
>>>>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>>>>> +	int ret;
>>>>> +	u32 icid;
>>>>>   
>>>>>   	while (dev_is_fsl_mc(dma_dev))
>>>>>   		dma_dev = dma_dev->parent;
>>>>>   
>>>>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>>>>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>>>>> +	if (!fwspec)
>>>>> +		return -ENODEV;
>>>>> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
>>>>> +	if (!iommu_ops)
>>>>> +		return -ENODEV;
>>>>> +
>>>>> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	icid = mc_dev->icid;
>>>>> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
>>>>
>>>> I see. So with this patch we would use the MC named component only to
>>>> retrieve the iommu_ops
>>>
>>> Right. I'd also add that the implementation tries to follow the existing
>>> standard .dma_configure implementations, e.g. of_dma_configure +
>>> of_iommu_configure. I'd also note that similarly to the ACPI case, this
>>> MC FW device is probed as a platform device in the DT scenario, binding
>>> here [1].
>>> A similar approach is used for the retrieval of the msi irq domain, see
>>> following patch.
>>>
>>>> - the streamid are injected directly here bypassing OF/IORT bindings translations altogether.
>>>
>>> Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
>>> the smmu driver to do some processing on the raw streamid coming from
>>> the firmware. I have not yet tested this with ACPI but expect it to
>>> work, however, it's debatable how valid is this approach in the context
>>> of ACPI.
>>
>> Actually, what I think you need is of_map_rid() (and an IORT
>> equivalent, that I am going to write - generalizing iort_msi_map_rid()).
>>
>> Would that be enough to enable IORT "normal" mappings in the MC bus
>> named components ?
>>
> 
> At a first glance, looks like this could very well fix the ACPI
> scenario, but I have some unclarities on the approach:
>   * are we going to rely in DT and ACPI generic layers even if these
> devices are not published / enumerated through DT or ACPI tables?

Assuming you mean the DPRC devices rather than the MC itself, then yes; 
in that sense it's exactly the same as how we treat 
dynamically-discovered PCI devices.

>   * the firmware manages and provides discrete streamids for the devices
> it exposes so there's no translation involved. There's no
>     requestor_id / input_id involved but it seems that we would still do
> some kind of translation relying for this on the DT/ACPI functions.

Wrong - last time I looked, what that firmware actually manages are 
*ICIDs* for the devices, not SMMU Stream IDs or GIC Device IDs; what 
DT/ACPI specifies is a translation from ICID to Stream ID/Device ID. The 
ICID is very much the requester/input ID for that translation. Yes, in 
practice the "translation" is effectively always a trivial identity 
mapping, but conceptually it most definitely exists. Yes, the subtlety 
is incredibly easy to overlook because it's basically drawing a 
distinction between one end of some wires vs. the other end, but it matters.

(and of course "trivial 1:1 translation" isn't even true in the case of 
SMMU Stream ID values, since IIRC they are really composed of 5 
different inputs, only one of which is (part of) the incoming ICID)

>   * MC firmware has its own stream_id (e.g. on some chips 0x4000, others
> 0xf00, so outside the range of stream_ids used for the mc devices)
>     while for the devices on this bus, MC allocates stream_ids from a
> range (e.g. 0x17 - 0x3f). Is it possible to describe this in the IORT table?

If it represents a unique ICID allocated to the MC itself, then sure, it 
simply goes through the mapping like anything else. Just like a PCI host 
bridge owns requester ID 0:0.0 and thus whatever Stream ID/Device ID 
that might map to.

If (for the sake of argument, because AIUI everything is an ICID in this 
particular case) it's some hard-wired thing that exists in Stream 
ID/Device ID space only, then it's a little trickier, but still in 
scope. In DT we have a lovely distinction between between "originating 
from the node" and "translated through the node", e.g. "msi-parent" vs. 
"msi-map"; IORT is not quite as clear-cut, but there are at least a few 
options. If the valid input ID space is smaller than 32 bits, then the 
"Named Component as bridge" binding could simply define special 
out-of-range values to represent IDs originating from the bridge itself, 
such that the NC driver knows what to do and from IORT's point of view 
everything is just a normal mapping. Alternatively there's already the 
example of SMMUv3 where we can have a mix of the normal mappings from 
Stream ID to Device ID for the upstream masters plus a single mapping 
for the SMMU's own Device ID - admittedly that depends on the additional 
SMMUv3-specific Device ID Mapping Index property, but if necessary it 
might be workable to have a de-facto interface for NCs that only 
considers single mappings when configuring the NC itself, and only 
considers normal mappings when configuring its children. Or maybe define 
a new mapping flag or NC property if there's a real need to specify such 
a situation unambiguously at the IORT level.

>   * Regarding the of_map_rid() use you mentioned, I was planning to
> decouple the mc bus from the DT layer by dropping the use of
> of_map_rid(), see patch 4.
> I briefly glanced over the iort code and spotted this static function:
> iort_iommu_xlate(). Wouldn't it also help, of course after making it public?

I won't speak for Lorenzo or claim we've agreed on an approach at all 
(not least because in all honesty we haven't really discussed it beyond 
these various email threads), but FWIW my vision is that ultimately the 
DT/ACPI code would expose a *_dma_configure() interface that takes an 
optional input ID, or (perhaps more likely) an explicit pair of 
interfaces for "configure this regular device" and "configure this 
device based on this 'host' device and this ID", and it becomes the bus 
code's responsibility to pass the right device(s) and deal with multiple 
IDs (i.e. for starters all the PCI alias stuff goes back to the PCI code 
where it really should be, rather than having multiple copies of magic 
PCI awareness deep down in DT/ACPI code).

Robin.
