Return-Path: <linux-acpi+bounces-17889-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90583BEB448
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 20:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2996E00E6
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28B332900;
	Fri, 17 Oct 2025 18:51:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB4330317;
	Fri, 17 Oct 2025 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727070; cv=none; b=gZbJ9k1znaf7m7lTYJeLwLf80cCJKCUQ3JGZ+KnI0maCWglqHZNWFkkrP5GB3FISAsFp4GP5Ex2BKLkCMQaouHg7Ywcymg/aBzaqEUwNfSzOvgQ8HyUmNx8Ob6hSSqA7rE5sZTxiS53DhzHSAjImHRU6v+DuwdEdv0IBCoPvbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727070; c=relaxed/simple;
	bh=G1+j7w2q4cwBcC9C/ZrytHkbD3meW93djXSrG1vo5r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKDVS5Lp0rxp3pgowbjaeAgLzzFPMHk2lR9uObCmqeXkAQ9vqHdtdDL4pFsrfiIY6ns4hEJkSUKUxtV0/awDWwkW4+PivG9ap5yavU+7zh0/YEGkPLu+nf+VcIXMcZ0cwbc52sQ2Lcv6o2zpvL2oo0LIcZBRMuN62x5Xh72MVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C8E31595;
	Fri, 17 Oct 2025 11:51:00 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8336E3F6A8;
	Fri, 17 Oct 2025 11:51:02 -0700 (PDT)
Message-ID: <7c2723fb-b5dd-4ae7-802b-8c9b2dadd78a@arm.com>
Date: Fri, 17 Oct 2025 19:50:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/29] ACPI / MPAM: Parse the MPAM table
To: Fenghua Yu <fenghuay@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-7-james.morse@arm.com>
 <53c52ef8-823e-4627-8fff-e09da33d8e7b@nvidia.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <53c52ef8-823e-4627-8fff-e09da33d8e7b@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 02/10/2025 04:21, Fenghua Yu wrote:
> On 9/10/25 13:42, James Morse wrote:
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.
>>
>> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
>> the MPAM driver with optional discovered data.


>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
>> new file mode 100644
>> index 000000000000..fd9cfa143676
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c

>> +static int acpi_mpam_parse_resource(struct mpam_msc *msc,
>> +                    struct acpi_mpam_resource_node *res)
>> +{
>> +    int level, nid;
>> +    u32 cache_id;
>> +
>> +    switch (res->locator_type) {
>> +    case ACPI_MPAM_LOCATION_TYPE_PROCESSOR_CACHE:
>> +        cache_id = res->locator.cache_locator.cache_reference;
>> +        level = find_acpi_cache_level_from_id(cache_id);
>> +        if (level <= 0) {
>> +            pr_err_once("Bad level (%u) for cache with id %u\n", level, cache_id);
> 
> Since level could be negative value here, printing it as %u converts it to positive value
> and will cause debug difficulty. For example, -ENOENT returned by
> find_acpi_cache_level_from_id() will be printed as 4294967294(instead of -2) which is hard
> to know the error code.
> 
> Suggest to change this to %d:

Sure, its never meant to be seen!


>             pr_err_once("Bad level (%d) for cache with id %u\n", level, cache_id);
> 
>> +            return -EINVAL;
>> +        }
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_CACHE,
>> +                       level, cache_id);
>> +    case ACPI_MPAM_LOCATION_TYPE_MEMORY:
>> +        nid = pxm_to_node(res->locator.memory_locator.proximity_domain);
>> +        if (nid == NUMA_NO_NODE)
>> +            nid = 0;
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>> +                       255, nid);
>> +    default:
>> +        /* These get discovered later and treated as unknown */
>> +        return 0;
>> +    }
>> +}

>> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
>> +                     struct platform_device *pdev,
>> +                     u32 *acpi_id)
>> +{
>> +    char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1];
>> +    bool acpi_id_valid = false;
>> +    struct acpi_device *buddy;
>> +    char uid[11];
>> +    int err;
>> +
>> +    memset(&hid, 0, sizeof(hid));
>> +    memcpy(hid, &tbl_msc->hardware_id_linked_device,
>> +           sizeof(tbl_msc->hardware_id_linked_device));
>> +
>> +    if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
>> +        *acpi_id = tbl_msc->instance_id_linked_device;
>> +        acpi_id_valid = true;
>> +    }
>> +
>> +    err = snprintf(uid, sizeof(uid), "%u",
>> +               tbl_msc->instance_id_linked_device);
>> +    if (err >= sizeof(uid)) {
> 
> err could be negative error code.

Not here it can't, from lib/vsprintf.c's documentation of snprintf()
| * The return value is the number of characters which would be
| * generated for the given input, excluding the trailing null,
| * as per ISO C99.  If the return is greater than or equal to
| * @size, the resulting string is truncated.

> This error validation only checks size but not error code.
> 
> Better to change it to
> 
>         if (err < 0 || err >= sizeof(uid))
> 


Thanks,

James

