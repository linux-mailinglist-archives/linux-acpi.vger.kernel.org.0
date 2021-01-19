Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C172FB919
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbhASOTI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 09:19:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2373 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405273AbhASLNM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2021 06:13:12 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKm9H2SNgz67d33;
        Tue, 19 Jan 2021 19:08:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 12:12:25 +0100
Received: from localhost (10.47.77.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 11:12:24 +0000
Date:   Tue, 19 Jan 2021 11:11:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>
Subject: Re: [PATCH v9 01/10] iommu: Remove obsolete comment
Message-ID: <20210119111144.00002130@Huawei.com>
In-Reply-To: <20210108145217.2254447-2-jean-philippe@linaro.org>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
        <20210108145217.2254447-2-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.36]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 Jan 2021 15:52:09 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
> dev_iommu") removed iommu_priv from fwspec. Update the struct doc.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org

Hi Jean-Philippe,

Flags parameter doesn't have any docs in this structure and should
do given kernel-doc should be complete.  It probably spits out a warning
for this if you build with W=1

Not sure if it makes sense to fix that in this same patch, or as a different
one as the responsible patch is a different one.
Looks like that came in:
Commit 5702ee24182f ("ACPI/IORT: Check ATS capability in root complex nodes")

Also, good to get this patch merged asap so we cut down on the noise in the
interesting part of this series!

FWIW
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan


> ---
>  include/linux/iommu.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b3f0e2018c62..26bcde5e7746 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -570,7 +570,6 @@ struct iommu_group *fsl_mc_device_group(struct device *dev);
>   * struct iommu_fwspec - per-device IOMMU instance data
>   * @ops: ops for this device's IOMMU
>   * @iommu_fwnode: firmware handle for this device's IOMMU
> - * @iommu_priv: IOMMU driver private data for this device
>   * @num_pasid_bits: number of PASID bits supported by this device
>   * @num_ids: number of associated device IDs
>   * @ids: IDs which this device may present to the IOMMU

