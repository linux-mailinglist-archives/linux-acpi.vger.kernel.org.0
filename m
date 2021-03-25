Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E21134983E
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 18:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhCYRhF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 13:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhCYRhB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:37:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F76561A0E;
        Thu, 25 Mar 2021 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693821;
        bh=M2twXmtu97j9otFWI5zh//Nf5kn2DxkZlOPXyLaNlOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L2mrJVQplXi1fO3DchQqGuhtH1RRLKh+h5UoD9SCVT+ufeR6GzNO5MqWdWmuFbgC6
         gQ8hlsWvwAkeCpHoy7mtUPzWvZeVZ0VeA/7e+GUHZAkRWdKxUr33y9JRIIt8JMzCAG
         cI3Wm4ygdcH94MuNj/rX91vO7+4+/kM+a5NBcLZo4eyzhnSEQkhCNIOjKmD4oYAOEz
         eaVl30CEfM5piQ5rGCAI0yDVa57n528Da7sCVH7Vg5YzNIHlAX6K8KlS/wamZAVDX2
         kpRtyKskGkDaV30Q18Hec+e3lV1v9nVllMWKi0P9o6qcnGOOS5JhMZEcPcpsMo74CE
         XeC+56tfazvmg==
Date:   Thu, 25 Mar 2021 17:36:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v13 02/10] iommu/arm-smmu-v3: Use device properties for
 pasid-num-bits
Message-ID: <20210325173654.GB15504@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-3-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 10:26:38AM +0100, Jean-Philippe Brucker wrote:
> The pasid-num-bits property shouldn't need a dedicated fwspec field,
> it's a job for device properties. Add properties for IORT, and access
> the number of PASID bits using device_property_read_u32().
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/iommu.h                       |  2 --
>  drivers/acpi/arm64/iort.c                   | 13 +++++++------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ++-
>  drivers/iommu/of_iommu.c                    |  5 -----
>  4 files changed, 9 insertions(+), 14 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
