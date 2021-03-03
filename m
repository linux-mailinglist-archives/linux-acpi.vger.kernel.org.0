Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC832C427
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358503AbhCDALd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:33426 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1451163AbhCCGBA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 01:01:00 -0500
IronPort-SDR: TjJEI59cqI/jo6Sggtd68K09zMhHPI7Zkd4/VQJrAS7mCLiDk8GnSGMSYY2uMVDR22YFccebjr
 CSyLu4FL1zPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206791061"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="206791061"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:57:29 -0800
IronPort-SDR: R62d52h746g5jdI/PQNmcxq5OSTnWJB+uv/9hPrMByomQh5KxmP10wVscZDChXanwcANWupg5v
 nKj4lGouhEoQ==
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="367485784"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:57:29 -0800
Date:   Tue, 2 Mar 2021 21:57:27 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     joro@8bytes.org, will@kernel.org, vivek.gautam@arm.com,
        guohanjun@huawei.com, zhukeqian1@huawei.com,
        wangzhou1@hisilicon.com, linux-acpi@vger.kernel.org,
        zhangfei.gao@linaro.org, lenb@kernel.org,
        devicetree@vger.kernel.org, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, eric.auger@redhat.com,
        vdumpa@nvidia.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net,
        shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
        robin.murphy@arm.com, linux-accelerators@lists.ozlabs.org,
        baolu.lu@linux.intel.com, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v13 06/10] iommu: Add a page fault handler
Message-ID: <20210303055727.GF1914@otc-nc-03>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-7-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302092644.2553014-7-jean-philippe@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 10:26:42AM +0100, Jean-Philippe Brucker wrote:
[snip]

> +
> +static enum iommu_page_response_code
> +iopf_handle_single(struct iopf_fault *iopf)
> +{
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags = 0;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm = iommu_sva_find(prm->pasid);
> +	if (IS_ERR_OR_NULL(mm))
> +		return status;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_extend_vma(mm, prm->addr);
> +	if (!vma)
> +		/* Unmapped area */
> +		goto out_put_mm;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> +		access_flags |= VM_READ;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> +		access_flags |= VM_WRITE;
> +		fault_flags |= FAULT_FLAG_WRITE;
> +	}
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> +		access_flags |= VM_EXEC;
> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> +	}
> +
> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> +		fault_flags |= FAULT_FLAG_USER;
> +
> +	if (access_flags & ~vma->vm_flags)
> +		/* Access fault */
> +		goto out_put_mm;
> +
> +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);

Should we add a trace similar to trace_page_fault_user() or kernel in
arch/x86/kernel/mm/fault.c 

or maybe add a perf_sw_event() for device faults? 

Cheers,
Ashok
