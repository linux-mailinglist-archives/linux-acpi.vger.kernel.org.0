Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E980A387466
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbhERIu6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 04:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhERIu6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2021 04:50:58 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C80C061573
        for <linux-acpi@vger.kernel.org>; Tue, 18 May 2021 01:49:40 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 76BDB2FA; Tue, 18 May 2021 10:49:38 +0200 (CEST)
Date:   Tue, 18 May 2021 10:49:37 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
Subject: Re: [PATCH v4 2/8] iommu/dma: Introduce generic helper to retrieve
 RMR info
Message-ID: <YKN/ocoHvOdbH43j@8bytes.org>
References: <20210513134550.2117-1-shameerali.kolothum.thodi@huawei.com>
 <20210513134550.2117-3-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513134550.2117-3-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 13, 2021 at 02:45:44PM +0100, Shameer Kolothum wrote:
> +/**
> + * struct iommu_rmr - Reserved Memory Region details per IOMMU
> + * @list: Linked list pointers to hold RMR region info
> + * @base_address: base address of Reserved Memory Region
> + * @length: length of memory region
> + * @sid: associated stream id
> + * @flags: flags that apply to the RMR node
> + */
> +struct iommu_rmr {
> +	struct list_head	list;
> +	phys_addr_t		base_address;
> +	u64			length;
> +	u32			sid;
> +	u32			flags;
> +};
> +
> +/* RMR Remap permitted */
> +#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
> +

This struct has lots of overlap with 'struct iommu_resv_region'. Any
reason the existing struct can't be used here?

Regards,

	Joerg

