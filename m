Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C130A2BF
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 08:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhBAHhC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 02:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232177AbhBAHhA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 02:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612164934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xIIyMdYX4ss9YyVUqtXNFUPDM8yR2OxXJHbAJpn06hc=;
        b=efZjtEizggs2z14M4Xk9lvTNpy5aNQnzVTuWdVpWf1hHKvn/332BY6iUOkwW2+BaAJ3djt
        ogDbTLvinIYVmziT4xelbr5ceP3eoqns66HlCpva3XmzE2m619Qnis9LaK71Dv45YdG0Mm
        /Ejv62C4TJx4hO5xPJMvk5gh2KVge1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-O7QH08jgPK6rXsyzh-FQIw-1; Mon, 01 Feb 2021 02:35:30 -0500
X-MC-Unique: O7QH08jgPK6rXsyzh-FQIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E113E10054FF;
        Mon,  1 Feb 2021 07:35:26 +0000 (UTC)
Received: from [10.36.113.43] (ovpn-113-43.ams2.redhat.com [10.36.113.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C16335F705;
        Mon,  1 Feb 2021 07:35:20 +0000 (UTC)
Subject: Re: [PATCH v12 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-4-jean-philippe@linaro.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <f706b2f8-fcd8-4b49-0f1b-5ee7ed996256@redhat.com>
Date:   Mon, 1 Feb 2021 08:35:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210127154322.3959196-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> mandating IOMMU-managed IOPF. The other device drivers now need to first
> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA. Enabling
> IOMMU_DEV_FEAT_IOPF on its own doesn't have any effect visible to the
> device driver, it is used in combination with other features.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  include/linux/iommu.h | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b7ea11fc1a93..00348e4c3c26 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -156,10 +156,24 @@ struct iommu_resv_region {
>  	enum iommu_resv_type	type;
>  };
>  
> -/* Per device IOMMU features */
> +/**
> + * enum iommu_dev_features - Per device IOMMU features
> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
> + *			 enabling %IOMMU_DEV_FEAT_SVA requires
> + *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
> + *			 Faults themselves instead of relying on the IOMMU. When
> + *			 supported, this feature must be enabled before and
> + *			 disabled after %IOMMU_DEV_FEAT_SVA.
> + *
> + * Device drivers query whether a feature is supported using
> + * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
> + */
>  enum iommu_dev_features {
> -	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
> -	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
> +	IOMMU_DEV_FEAT_AUX,
> +	IOMMU_DEV_FEAT_SVA,
> +	IOMMU_DEV_FEAT_IOPF,
>  };
>  
>  #define IOMMU_PASID_INVALID	(-1U)
> 

