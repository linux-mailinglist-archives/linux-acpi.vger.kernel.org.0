Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC97B345C36
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 11:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhCWKu3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Mar 2021 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhCWKuY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 Mar 2021 06:50:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A7AC061574
        for <linux-acpi@vger.kernel.org>; Tue, 23 Mar 2021 03:50:23 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j18so20261185wra.2
        for <linux-acpi@vger.kernel.org>; Tue, 23 Mar 2021 03:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TiNGA0w46W0DjeaRBmIW710uv+94txA6fMa8wJF8/2Q=;
        b=mWO/oC5mO6oGl5TwUc/XE8tIMSX7VxOcDdlbHfhCSBVlbQTybNFD1lCAa8OttR+vqj
         PFUVBAKJyAbA4x8h3Tt3qDHLt0OI6S1dqhKd8ZgufU6mjoQ8V/gHkzBQjlIEJm/BQjBk
         UaPPLrHkri/DbBxUWVBfaQMAS5chdSH5o1eJGj9K+TDYeEn/Pv45cItajIOeWLLSkiyM
         UUQeEi+z5/gxIcg7hcB/clJa1t5RmMt0oslFk1yipoNByc1MBIUxRia7dm3csLQbUdJ4
         4M69TOF0Bs7qIsZDO2KJodBhr1Ug1lQr1oFitpxhpJ8Pzlru/fHMPhInweLjLbjmO5Dj
         VItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TiNGA0w46W0DjeaRBmIW710uv+94txA6fMa8wJF8/2Q=;
        b=duFn0qElVJw6lwHAr7MVfvNO1jx1KW52l90432MkV/dy6STVDnWV2iQIL0qc4QjmlD
         pakiMSrRNmUVyCPXSSWER2qEsvwwwT9ryUUBwfJNrll/uzCn7nu5rS1ss46FylrO+4A7
         VM3M8eAfdcocDVhiX8gvepQIiZ/PORDCr/JJYs8k8eUeG9vqB/4tvs3gnrCVV5utZuVp
         Ogf7s/CQbG3w0nKHEoCGviliF4H1qP7/X+4K6A6ohKoOQDnqnQVI6ks37aW06n4lt3xK
         FAGrX9EhP62PaGjZiSk0FKEatU8a0S3mj4VzWTOJrAQJHweHvQnkCX3C0Or8XlrIDhhi
         a2zQ==
X-Gm-Message-State: AOAM5302rZJaSLeOlnr8INCVCgg6uXptEbciJ03muoe7ukVQIgyUs4Kd
        R7jERnaDIHesRT2W2kFfDzZ6ouuIlmPErA==
X-Google-Smtp-Source: ABdhPJyOKKIrD/pjZAo/IQd/VFIPF+OXMG0WMUWGBA1d5PjzWwZOVtYOML7nn713yG/tg4OoOLlQ0A==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr3249954wrs.86.1616496622079;
        Tue, 23 Mar 2021 03:50:22 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id y18sm23894467wrq.61.2021.03.23.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 03:50:21 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:50:03 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: [PATCH v13 06/10] iommu: Add a page fault handler
Message-ID: <YFnH20Fy31CwEj7n@myrica>
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-7-jean-philippe@linaro.org>
 <20210302155957.620db372@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302155957.620db372@jacob-builder>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 02, 2021 at 03:59:57PM -0800, Jacob Pan wrote:
> Hi Jean-Philippe,
> 
> A few comments from the p.o.v of converting VT-d to this framework. Mostly
> about potential optimization. I think VT-d SVA code will be able to use this
> work.
> +Ashok provided many insight.
> 
> FWIW,
> Reviewed-by:Jacob Pan <jacob.jun.pan@linux.intel.com>

Thanks!

> On Tue,  2 Mar 2021 10:26:42 +0100, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> > +int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> > +{
> > +	int ret;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +
> > +	struct device *dev = cookie;
> > +	struct dev_iommu *param = dev->iommu;
> > +
> > +	lockdep_assert_held(&param->lock);
> > +
> > +	if (fault->type != IOMMU_FAULT_PAGE_REQ)
> > +		/* Not a recoverable page fault */
> > +		return -EOPNOTSUPP;
> > +
> > +	/*
> > +	 * As long as we're holding param->lock, the queue can't be
> > unlinked
> > +	 * from the device and therefore cannot disappear.
> > +	 */
> > +	iopf_param = param->iopf_param;
> > +	if (!iopf_param)
> > +		return -ENODEV;
> > +
> > +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> > +		iopf = kzalloc(sizeof(*iopf), GFP_KERNEL);
> > +		if (!iopf)
> > +			return -ENOMEM;
> > +
> > +		iopf->fault = *fault;
> > +
> > +		/* Non-last request of a group. Postpone until the last
> > one */
> Would be nice to have an option here to allow non-deferred handle_mm_fault.
> Some devices may have a large group.
> 
> FYI, VT-d also needs to send page response before the last one (LPIG).
> "A Page Group Response Descriptor is issued by software in response to a
> page request with data or a page request (with or without data) that
> indicated that it was the last request in a group."
> 
> But I think we deal with that when we convert. Perhaps just treat the
> request with data as LPIG.

Sure that seems fine. Do you mean that the vt-d driver will set the
IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE flag for PR-with-data?  Otherwise we
could introduce a new flag. I prefer making it explicit rather than having
IOPF consumers infer that a response is needed when seeing
IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA set, because private_data wouldn't be
reusable by other architectures.

> Also adding a trace event would be nice, similar to CPU page fault.

Agreed, the tracepoints in my development tree (along with the lower-level
page_request/response tracepoints) have been indispensable for debugging
hardware and SVA applications

> > +		list_add(&iopf->list, &iopf_param->partial);
> > +
> > +		return 0;
> > +	}
> > +
> > +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> > +	if (!group) {
> > +		/*
> > +		 * The caller will send a response to the hardware. But
> > we do
> > +		 * need to clean up before leaving, otherwise partial
> > faults
> > +		 * will be stuck.
> > +		 */
> > +		ret = -ENOMEM;
> > +		goto cleanup_partial;
> > +	}
> > +
> > +	group->dev = dev;
> > +	group->last_fault.fault = *fault;
> > +	INIT_LIST_HEAD(&group->faults);
> > +	list_add(&group->last_fault.list, &group->faults);
> > +	INIT_WORK(&group->work, iopf_handle_group);
> > +
> > +	/* See if we have partial faults for this group */
> > +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)
> > {
> > +		if (iopf->fault.prm.grpid == fault->prm.grpid)
> Just curious, the iopf handler is registered per arm_smmu_master dev. Is
> the namespace of group ID also within an arm_smmu_master?

Yes for both PCIe PRI and SMMU stall, the namespace is within one device
(one RequesterID or StreamID)

> Can one arm_smmu_master support multiple devices?

No, it's a single device

> 
> For VT-d, group ID is per PCI device.
> 
> > +			/* Insert *before* the last fault */
> > +			list_move(&iopf->list, &group->faults);
> > +	}
> > +
> This is fine with devices supports small number of outstanding PRQs.
> VT-d is setting the limit to 32. But the incoming DSA device will support
> 512.
> 
> So if we pre-sort IOPF by group ID and put them in a per group list, would
> it be faster? I mean once the LPIG comes in, we just need to search the
> list of groups instead of all partial faults. I am not against what is done
> here, just exploring optimization.

Yes I think that's worth exploring, keeping the groups in a rb_tree or something
like that, for easy access and update. Note that I don't have a system
with non-LPIG faults, so I can't test any of this at the moment

Thanks,
Jean
