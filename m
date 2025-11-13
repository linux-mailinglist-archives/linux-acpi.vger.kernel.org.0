Return-Path: <linux-acpi+bounces-18860-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65858C57567
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B24E26D2
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Nov 2025 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC8334CFCE;
	Thu, 13 Nov 2025 12:10:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783234AB09;
	Thu, 13 Nov 2025 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763035806; cv=none; b=FAzefpBvQABErs/7GE3qfGKaXRhek1u00BIk84wn/a4cfSmONFSJSY1bMmP6VIOhJ75TvCDkAQ4E7LFFYiSqQ9mFaKFf95XFGpUDRADJrZ+vgUqBzYd0bP20j6LrcNq6jcR5H5ElJVyClfHMxU2aNB9pMf9aWn2PXxOEAVZWrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763035806; c=relaxed/simple;
	bh=QE3OY4AETodcvC/5PU4dsR+k4aeF9N9nFjpYGIfZldA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/IQ3Rf0+l1Duxxfj6TizYgv6S8TDIrKXPBWK0As8jLQnqjI6oiippSqlq5D65u6Gf6Cam3Khz6N8+nRqS/cx7/UM0gGDJNnKZd1niATDwXe6LJ9CtzeEEWQjz6uLYL7iQF6IBOkbp/rCR9biCafpWvotLbE157JVhyfx6++CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5889512FC;
	Thu, 13 Nov 2025 04:09:55 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3115F3F5A1;
	Thu, 13 Nov 2025 04:09:58 -0800 (PST)
Message-ID: <d9694bdf-ab58-4706-8e1e-8266d7ac2ecd@arm.com>
Date: Thu, 13 Nov 2025 12:09:56 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
To: Fenghua Yu <fenghuay@nvidia.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-10-ben.horgan@arm.com>
 <26396142-4f14-4175-85ba-2e8d780abbd9@nvidia.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <26396142-4f14-4175-85ba-2e8d780abbd9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Fenghua,

On 11/13/25 02:16, Fenghua Yu wrote:
> Hi, Ben and James,
> 
> On 11/7/25 04:34, Ben Horgan wrote:
>> From: James Morse <james.morse@arm.com>
>>
>> Add code to parse the arm64 specific MPAM table, looking up the cache
>> level from the PPTT and feeding the end result into the MPAM driver.
>>
>> This happens in two stages. Platform devices are created first for the
>> MSC devices. Once the driver probes it calls acpi_mpam_parse_resources()
>> to discover the RIS entries the MSC contains.
>>
>> For now the MPAM hook mpam_ris_create() is stubbed out, but will update
>> the MPAM driver with optional discovered data about the RIS entries.
>>
>> CC: Carl Worth <carl@os.amperecomputing.com>
>> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
>> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
[...]

>> +        if (nid == NUMA_NO_NODE) {
>> +            pr_debug("Bad proxmity domain %lld, using node 0 instead\n",
> 
> Typo.
> s/proxmity/proximity/

Done.

> 
>> +                 res->locator.memory_locator.proximity_domain);
>> +            nid = 0;
>> +        }
>> +        return mpam_ris_create(msc, res->ris_index, MPAM_CLASS_MEMORY,
>> +                       255, nid);
>> +    default:
>> +        /* These get discovered later and are treated as unknown */
>> +        return 0;
>> +    }
>> +}
>> +
>> +int acpi_mpam_parse_resources(struct mpam_msc *msc,
>> +                  struct acpi_mpam_msc_node *tbl_msc)
>> +{
>> +    int i, err;
>> +    char *ptr, *table_end;
>> +    struct acpi_mpam_resource_node *resource;
>> +
>> +    ptr = (char *)(tbl_msc + 1);
>> +    table_end = ptr + tbl_msc->length;
> 
> tbl_msc->length equals size of the ENTIRE msc node. ptr points to the
> end of tbl_msc. ptr + tbl_msc->length is past the end of the msc node.
> This will access data outside of this MSC node.
> 
> Better to change to:
> +    table_end = (char *)tbl_msc + tbl_msc->length;

Yes, makes sense.

> 
>> +    for (i = 0; i < tbl_msc->num_resource_nodes; i++) {
>> +        u64 max_deps, remaining_table;
>> +
>> +        if (ptr + sizeof(*resource) > table_end)
>> +            return -EINVAL;
>> +
>> +        resource = (struct acpi_mpam_resource_node *)ptr;
>> +
>> +        remaining_table = table_end - ptr;
>> +        max_deps = remaining_table / sizeof(struct acpi_mpam_func_deps);
>> +        if (resource->num_functional_deps > max_deps) {
>> +            pr_debug("MSC has impossible number of functional
>> dependencies\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +        err = acpi_mpam_parse_resource(msc, resource);
>> +        if (err)
>> +            return err;
>> +
>> +        ptr += sizeof(*resource);
>> +        ptr += resource->num_functional_deps * sizeof(struct
>> acpi_mpam_func_deps);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Creates the device power management link and returns true if the
>> + * acpi id is valid and usable for cpu affinity.  This is the case
>> + * when the linked device is a processor or a processor container.
>> + */
>> +static bool __init parse_msc_pm_link(struct acpi_mpam_msc_node *tbl_msc,
>> +                     struct platform_device *pdev,
>> +                     u32 *acpi_id)
>> +{
>> +    char hid[sizeof(tbl_msc->hardware_id_linked_device) + 1] = { 0 };
>> +    bool acpi_id_valid = false;
>> +    struct acpi_device *buddy;
>> +    char uid[11];
>> +    int len;
>> +
>> +    memcpy(hid, &tbl_msc->hardware_id_linked_device,
>> +           sizeof(tbl_msc->hardware_id_linked_device));
>> +
>> +    if (!strcmp(hid, ACPI_PROCESSOR_CONTAINER_HID)) {
>> +        *acpi_id = tbl_msc->instance_id_linked_device;
>> +        acpi_id_valid = true;
>> +    }
>> +
>> +    len = snprintf(uid, sizeof(uid), "%u",
>> +               tbl_msc->instance_id_linked_device);
>> +    if (len >= sizeof(uid)) {
>> +        pr_debug("Failed to convert uid of device for power
>> management.");
>> +        return acpi_id_valid;
>> +    }
>> +
>> +    buddy = acpi_dev_get_first_match_dev(hid, uid, -1);
>> +    if (buddy)
>> +        device_link_add(&pdev->dev, &buddy->dev, DL_FLAG_STATELESS);
> 
> Refcount leak here?
> 
> Refcount of the device object pointed by buddy is not released and
> refcount leaks.
> > Better to change to:
> +    if (buddy) {
> +        device_link_add(...);
> +        acpi_dev_put(buddy);  <====== release refcount here
> +    }


Yes, device_link_add() calls get_device() to increment the refcount and
so the acpi_dev_put() is required.

> 
> or free refcount automatically:
> +DEFINE_FREE(acpi_dev_put, struct acpi_device *, if (_T) acpi_dev_put(_T))
> ...
> +    struct acpi_device *buddy __free(acpi_dev_put);
> ...
> 
>> +
>> +    return acpi_id_valid;
>> +}
>> +
>> +static int decode_interface_type(struct acpi_mpam_msc_node *tbl_msc,
>> +                 enum mpam_msc_iface *iface)
>> +{
>> +    switch (tbl_msc->interface_type) {
>> +    case ACPI_MPAM_MSC_IFACE_MMIO:
>> +        *iface = MPAM_IFACE_MMIO;
>> +        return 0;
>> +    case ACPI_MPAM_MSC_IFACE_PCC:
>> +        *iface = MPAM_IFACE_PCC;
>> +        return 0;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +static struct platform_device * __init acpi_mpam_parse_msc(struct
>> acpi_mpam_msc_node *tbl_msc)
>> +{
>> +    struct platform_device *pdev __free(platform_device_put) =
>> +        platform_device_alloc("mpam_msc", tbl_msc->identifier);
>> +    int next_res = 0, next_prop = 0, err;
>> +    /* pcc, nrdy, affinity and a sentinel */
>> +    struct property_entry props[4] = { 0 };
>> +    /* mmio, 2xirq, no sentinel. */
>> +    struct resource res[3] = { 0 };
>> +    struct acpi_device *companion;
>> +    enum mpam_msc_iface iface;
>> +    char uid[16];
>> +    u32 acpi_id;
>> +
>> +    if (!pdev)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    /* Some power management is described in the namespace: */
>> +    err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
>> +    if (err > 0 && err < sizeof(uid)) {
>> +        companion = acpi_dev_get_first_match_dev("ARMHAA5C", uid, -1);
>> +        if (companion)
>> +            ACPI_COMPANION_SET(&pdev->dev, companion);
> 
> Ditto. companion's refcount leak here as well?

Looks like it. Added a acpi_dev_put().

> 
>> +        else
>> +            pr_debug("MSC.%u: missing namespace entry\n",
>> +                 tbl_msc->identifier);
>> +    }
>> +
>> +    if (decode_interface_type(tbl_msc, &iface)) {
>> +        pr_debug("MSC.%u: unknown interface type\n", tbl_msc-
>> >identifier);
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    if (iface == MPAM_IFACE_MMIO)
>> +        res[next_res++] = DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
>> +                               tbl_msc->mmio_size,
>> +                               "MPAM:MSC");
>> +    else if (iface == MPAM_IFACE_PCC)
>> +        props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
>> +                            tbl_msc->base_address);
>> +
>> +    acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
>> +
>> +    WARN_ON_ONCE(next_res > ARRAY_SIZE(res));
> 
> Not sure if this WARN_ON_ONCE() is really helpful.
> 
> Even before this WARN happens, previously res[next_res] accesseing
> outside of res[] may hit panic or data corruption already.
> 
> Maybe it's better to add a helper to access res[] and report error when
> accessing out of res[] scope. A few places can call the helper to access
> res[]:

This warning looks to be there just to catch programming errors. There
are 3 places next_res could be incremented and res[] has 3 entries so I
don't see how an out of bounds access could occur without code changes
and as accesses are made using res[next_res++], or equivalent, it is
likely this warning would be hit if a new res is added without
remembering to increase the size of the array. Given this, I'll keep
this code as it is.

> 
> +static int add_resource(struct resource *res, int *idx, int max,
> +            struct resource new_res)
> +{
> +    if (*idx >= max) {
> +        pr_err("Too many resources (max %d)\n", max);
> +        return -ENOSPC;
> +    }
> +    res[(*idx)++] = new_res;
> +    return 0;
> +}
> 
> Then can call the helper to replace res[next_res++]:
> +    if (iface == MPAM_IFACE_MMIO) {
> +        err = add_resource(res, &next_res, ARRAY_SIZE(res),
> +                 DEFINE_RES_MEM_NAMED(tbl_msc->base_address,
> +                               tbl_msc, +                           
> mmio_size,
> +                               "MPAM:MSC"));
> +        if (err)
> +            return ERR_PTR(-ENOSPC);
> +    }
> 
>> +    err = platform_device_add_resources(pdev, res, next_res);
>> +    if (err)
>> +        return ERR_PTR(err);
>> +
>> +    props[next_prop++] = PROPERTY_ENTRY_U32("arm,not-ready-us",
>> +                        tbl_msc->max_nrdy_usec);
>> +
>> +    /*
>> +     * The MSC's CPU affinity is described via its linked power
>> +     * management device, but only if it points at a Processor or
>> +     * Processor Container.
>> +     */
>> +    if (parse_msc_pm_link(tbl_msc, pdev, &acpi_id))
>> +        props[next_prop++] = PROPERTY_ENTRY_U32("cpu_affinity",
>> acpi_id);
>> +
>> +    WARN_ON_ONCE(next_prop > ARRAY_SIZE(props));
> 
> Ditto for this WARN here?

Similarly to above, this is just guarding against later adding more
properties. This one can be tightened though as
device_create_managed_software_node() expects a zero terminated array.
Changing to:

WARN_ON_ONCE(next_prop > ARRAY_SIZE(props) - 1);

> 
> [SNIP]
> 
> Thanks.
> 
> -Fenghua
Thanks,

Ben


