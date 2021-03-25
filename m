Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96B434984B
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 18:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhCYRiH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 13:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhCYRiB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Mar 2021 13:38:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D01861A28;
        Thu, 25 Mar 2021 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616693881;
        bh=kLU4dMuIpS+s+W/i7Bpf406Q9DoXN9YHgPK4PWuvqqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7F02zsvW5dF2qOyc0dqsQKG32TjW3bT97zlZn+2iAnDga/2TG37hUAE/4J3bXFcl
         HVA07BhW1NVdoJ05AOUQ9hfTidbZzhSpcaL65eedcLytYKRRrTornGWQo2WgqHIjD1
         fGK/+tkAohjvKGMZiKht+liPFkHq/o4mQuOGq+DY1HqwwtiO7JLt+Bm4dLC1mQIB1J
         qiJFP4X9DxYvO/LoezN/z+SfcOBml/5kJa/E/Qmj61gKhAYcxm+uewRWx7jNzZQudn
         pjOBfCV5bvYS6e/90TadJdfPWpnuvnM/Ta4Z9cDUyJN55iJ6EhSl9M0yGvGlL20kYt
         2CcHyVUXG1frg==
Date:   Thu, 25 Mar 2021 17:37:53 +0000
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
Subject: Re: [PATCH v13 01/10] iommu: Fix comment for struct iommu_fwspec
Message-ID: <20210325173753.GC15504@willie-the-truck>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 10:26:37AM +0100, Jean-Philippe Brucker wrote:
> Commit 986d5ecc5699 ("iommu: Move fwspec->iommu_priv to struct
> dev_iommu") removed iommu_priv from fwspec and commit 5702ee24182f
> ("ACPI/IORT: Check ATS capability in root complex nodes") added @flags.
> Update the struct doc.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/iommu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Will Deacon <will@kernel.org>

Will
