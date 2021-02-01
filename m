Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC25F30A644
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 12:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhBALNh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 06:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhBALNh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 06:13:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B62C061574
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 03:12:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c127so12785067wmf.5
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 03:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AdJJsztSa/PfLkxaK9hi3wgOAf3rWJfVmETfVbPhDQM=;
        b=BJZkUaVlvArotMj35gc4Ryn1jzYpJODmz4BeBqXzrXY8uWYM5d/12aV/f7BgcY6I96
         Sz6IrQvhl4kgb1SpJ5/bNviOzCPmpquY54HzywVEmd6hLl0TdDy/tpVkg5EphHmkgaBh
         t8P55uFMT3rvXvz8DVI44pagXmLgXNXbAq1DIZBYF8TG2YbVC+COX6RmQ2GL3woWeq57
         FpWICNVRpruje4QN6AUBZyTEq7ciqt+XUhg00r4CJGPi1Gp4cHMcGh4Tx6or9Jwc0OMV
         75G38yLv2UNNalUAfk/h+NfjYgTJo8EO6E1Lr9T4EysKvQ+2BDYaBsJqXEDGw5WaJUn/
         u4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AdJJsztSa/PfLkxaK9hi3wgOAf3rWJfVmETfVbPhDQM=;
        b=E5CSfntjAqVYc7RsJEBgRK5nqGxiEyRe94SmyAziBwmfYSMeNvS+/hL8DEMOFqQQET
         3ts6CpILdW2JIbC0rpcsk3p2kBWSAbYLv5aWUpiukXpfXdPUMoN0gs+qRkoVSwk4t0hY
         /z5+b59Meq8xISUFeTJ77hpr7XNnJQPR37Za4vfb4/YbaJ/W0nfVfH17S4nCgc77KQRQ
         SdG2Y4m7UtbWOpvT3Kw12HK7NQ63qhQXmin15RdBJ0wDGq1bPv/VUGIWKXOsCh+heW7J
         otKW+c+iSK0VybiN/nkVvQlO7Vx27yqTVOg5VXZ9NuBmv8NPMLgEjPwYPWw3BB3YsVCN
         NCvg==
X-Gm-Message-State: AOAM532oQhf05++5PHRcmzp6RoSX71G7jTKE2muH/BsjAOEGBpxW2FFf
        Fer4t3b8fmlNniYuOklMZnZJdA==
X-Google-Smtp-Source: ABdhPJzbSmxDnOHXTAtKhAr3owNj0X97Hbyhk6zyvU9cBi4RZpPy0aY0Qw5qlS8+s51rHeesopHFbA==
X-Received: by 2002:a05:600c:228c:: with SMTP id 12mr14691553wmf.101.1612177975252;
        Mon, 01 Feb 2021 03:12:55 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v25sm21276665wmh.4.2021.02.01.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:12:54 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:12:35 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        Jonathan.Cameron@huawei.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YBfiIwdVP1dXg7Yt@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0c609eeb-00b0-7573-fed7-5bc1e6c0b0d1@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Jan 31, 2021 at 07:29:09PM +0100, Auger Eric wrote:
> Hi Jean,
> 
> Some rather minor comments§questions below that may not justify a respin.
> 
> On 1/27/21 4:43 PM, Jean-Philippe Brucker wrote:
> > -static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
> > +bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master)
> >  {
> > -	return false;
> > +	/* We're not keeping track of SIDs in fault events */
> shall we? [*] below

That would require storing the incoming SID into the iommu_fault_event
struct, and retrieve it in arm_smmu_page_response(). Easy enough, but I
don't think it's needed for existing devices.

> > +	if (master->num_streams != 1)
> > +		return false;
[...]
> > +static int arm_smmu_page_response(struct device *dev,
> > +				  struct iommu_fault_event *unused,
> > +				  struct iommu_page_response *resp)
> > +{
> > +	struct arm_smmu_cmdq_ent cmd = {0};
> > +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +	int sid = master->streams[0].id;
> [*]
> > +
> > +	if (master->stall_enabled) {
> > +		cmd.opcode		= CMDQ_OP_RESUME;
> > +		cmd.resume.sid		= sid;
> > +		cmd.resume.stag		= resp->grpid;
> > +		switch (resp->code) {
> > +		case IOMMU_PAGE_RESP_INVALID:
> add fallthrough?

I think fallthrough is mainly useful to tell reader and compiler that a
break was omitted on purpose. When two cases are stuck together the intent
to merge the flow is clear enough in my opinion. GCC's
-Wimplicit-fallthrough doesn't warn in this case.

> > +		case IOMMU_PAGE_RESP_FAILURE:
> > +			cmd.resume.resp = CMDQ_RESUME_0_RESP_ABORT;
> > +			break;
[...]
> > +static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
> > +{
> > +	int ret;
> > +	u32 reason;
> > +	u32 perm = 0;
> > +	struct arm_smmu_master *master;
> > +	bool ssid_valid = evt[0] & EVTQ_0_SSV;
> > +	u32 sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> > +	struct iommu_fault_event fault_evt = { };
> > +	struct iommu_fault *flt = &fault_evt.fault;
> > +
> > +	/* Stage-2 is always pinned at the moment */
> > +	if (evt[1] & EVTQ_1_S2)
> > +		return -EFAULT;
> > +
> > +	master = arm_smmu_find_master(smmu, sid);
> > +	if (!master)
> > +		return -EINVAL;
> > +
> > +	if (evt[1] & EVTQ_1_RnW)
> > +		perm |= IOMMU_FAULT_PERM_READ;
> > +	else
> > +		perm |= IOMMU_FAULT_PERM_WRITE;
> > +
> > +	if (evt[1] & EVTQ_1_InD)
> > +		perm |= IOMMU_FAULT_PERM_EXEC;
> > +
> > +	if (evt[1] & EVTQ_1_PnU)
> > +		perm |= IOMMU_FAULT_PERM_PRIV;
> > +
> > +	switch (FIELD_GET(EVTQ_0_ID, evt[0])) {
> > +	case EVT_ID_TRANSLATION_FAULT:
> > +	case EVT_ID_ADDR_SIZE_FAULT:
> > +	case EVT_ID_ACCESS_FAULT:
> > +		reason = IOMMU_FAULT_REASON_PTE_FETCH;
> Doesn't it rather map to IOMMU_FAULT_REASON_ACCESS?
> /* access flag check failed */"

Good point, I guess it didn't exist when I wrote this. And ADDR_SIZE_FAULT
corresponds to IOMMU_FAULT_REASON_OOR_ADDRESS now, right?

By the way the wording on those two fault reasons, "access flag" and
"stage", seems arch-specific - x86 names are "accessed flag" and "level".

> > +		break;
> > +	case EVT_ID_PERMISSION_FAULT:
> > +		reason = IOMMU_FAULT_REASON_PERMISSION;
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (evt[1] & EVTQ_1_STALL) {
> > +		flt->type = IOMMU_FAULT_PAGE_REQ;
> > +		flt->prm = (struct iommu_fault_page_request) {
> > +			.flags = IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE,
> > +			.grpid = FIELD_GET(EVTQ_1_STAG, evt[1]),
> > +			.perm = perm,
> > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > +		};
> > +
> > +		if (ssid_valid) {
> > +			flt->prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > +			flt->prm.pasid = FIELD_GET(EVTQ_0_SSID, evt[0]);
> > +		}
> > +	} else {
> > +		flt->type = IOMMU_FAULT_DMA_UNRECOV;
> > +		flt->event = (struct iommu_fault_unrecoverable) {
> > +			.reason = reason,
> > +			.flags = IOMMU_FAULT_UNRECOV_ADDR_VALID |
> > +				 IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID,
> nit: shall IOMMU_FAULT_UNRECOV_FETCH_ADDR_VALID be set here? Supported
> unrecoverable faults feature the IPA field which is UNKNOWN for S1
> translations. fetch_addr rather was
> corresponding to WALK_EABT.Fetch_addr to me.

Right I should drop the IPA part entirely, since we don't report S2 faults
in this patch.

Thanks,
Jean

> > +			.perm = perm,
> > +			.addr = FIELD_GET(EVTQ_2_ADDR, evt[2]),
> > +			.fetch_addr = FIELD_GET(EVTQ_3_IPA, evt[3]),
> > +		};

