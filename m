Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889043AC734
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 11:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhFRJSg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 05:18:36 -0400
Received: from foss.arm.com ([217.140.110.172]:37680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhFRJSf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Jun 2021 05:18:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF711424;
        Fri, 18 Jun 2021 02:16:26 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2FDE3F694;
        Fri, 18 Jun 2021 02:16:23 -0700 (PDT)
Subject: Re: [PATCH v4 2/6] ACPI: Move IOMMU setup code out of IORT
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>
Cc:     kevin.tian@intel.com, mst@redhat.com, catalin.marinas@arm.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        sebastien.boeuf@intel.com, guohanjun@huawei.com, will@kernel.org,
        dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org,
        lenb@kernel.org
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-3-jean-philippe@linaro.org>
 <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com> <YMxOOq8YIBhRhzQM@myrica>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ff35c106-6254-1a6f-4b95-32a25bbccb96@arm.com>
Date:   Fri, 18 Jun 2021 10:16:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YMxOOq8YIBhRhzQM@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-06-18 08:41, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On Wed, Jun 16, 2021 at 11:35:13AM +0200, Eric Auger wrote:
>>> -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>>> -						const u32 *id_in)
>>> +int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
>>>   {
>>>   	struct acpi_iort_node *node;
>>> -	const struct iommu_ops *ops;
>>> +	const struct iommu_ops *ops = NULL;
> 
> Oops, I need to remove this (and add -Werror to my tests.)
> 
> 
>>> +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
>>> +						       const u32 *id_in)
>>> +{
>>> +	int err;
>>> +	const struct iommu_ops *ops;
>>> +
>>> +	/*
>>> +	 * If we already translated the fwspec there is nothing left to do,
>>> +	 * return the iommu_ops.
>>> +	 */
>>> +	ops = acpi_iommu_fwspec_ops(dev);
>>> +	if (ops)
>>> +		return ops;
>>> +
>>> +	err = iort_iommu_configure_id(dev, id_in);
>>> +
>>> +	/*
>>> +	 * If we have reason to believe the IOMMU driver missed the initial
>>> +	 * add_device callback for dev, replay it to get things in order.
>>> +	 */
>>> +	if (!err && dev->bus && !device_iommu_mapped(dev))
>>> +		err = iommu_probe_device(dev);
>> Previously we had:
>>      if (!err) {
>>          ops = iort_fwspec_iommu_ops(dev);
>>          err = iort_add_device_replay(dev);
>>      }
>>
>> Please can you explain the transform? I see the
>>
>> acpi_iommu_fwspec_ops call below but is it not straightforward to me.
> 
> I figured that iort_add_device_replay() is only used once and is
> sufficiently simple to be inlined manually (saving 10 lines). Then I
> replaced the ops assignment with returns, which saves another line and may
> be slightly clearer?  I guess it's mostly a matter of taste, the behavior
> should be exactly the same.

Right, IIRC the multiple assignments to ops were more of a haphazard 
evolution inherited from the DT version, and looking at it now I think 
the multiple-return is indeed a bit nicer.

Similarly, it looks like the factoring out of iort_add_device_replay() 
was originally an attempt to encapsulate the IOMMU_API dependency, but 
things have moved around a lot since then, so that seems like a sensible 
simplification to make too.

Robin.

> 
>> Also the comment mentions replay. Unsure if it is still OK.
> 
> The "replay" part is, but "add_device" isn't accurate because it has since
> been replaced by probe_device. I'll refresh the comment.
> 
> Thanks,
> Jean
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
