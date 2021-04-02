Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054FC35247C
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 02:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDBAfk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 20:35:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15464 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhDBAfk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 20:35:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FBLd75H6vzwR1g;
        Fri,  2 Apr 2021 08:33:31 +0800 (CST)
Received: from [10.174.178.147] (10.174.178.147) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 2 Apr 2021 08:35:30 +0800
Subject: Re: [PATCH v14 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <will@kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <robh+dt@kernel.org>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <Jonathan.Cameron@huawei.com>,
        <eric.auger@redhat.com>, <iommu@lists.linux-foundation.org>,
        <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <kevin.tian@intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>,
        <zhukeqian1@huawei.com>, <wangzhou1@hisilicon.com>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-3-jean-philippe@linaro.org>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5e0037ea-7c1a-ecbd-e5db-89050679650e@huawei.com>
Date:   Fri, 2 Apr 2021 08:35:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210401154718.307519-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.147]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/4/1 23:47, Jean-Philippe Brucker wrote:
> The pasid-num-bits property shouldn't need a dedicated fwspec field,
> it's a job for device properties. Add properties for IORT, and access
> the number of PASID bits using device_property_read_u32().
> 
> Suggested-by: Robin Murphy<robin.murphy@arm.com>
> Acked-by: Jonathan Cameron<Jonathan.Cameron@huawei.com>
> Acked-by: Will Deacon<will@kernel.org>
> Reviewed-by: Eric Auger<eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker<jean-philippe@linaro.org>
> ---
>   include/linux/iommu.h                       |  2 --
>   drivers/acpi/arm64/iort.c                   | 13 +++++++------

Acked-by: Hanjun Guo <guohanjun@huawei.com>
