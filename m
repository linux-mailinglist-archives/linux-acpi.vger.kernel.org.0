Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148462FB923
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 15:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395412AbhASOS1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 09:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389854AbhASKRt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jan 2021 05:17:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D884AC061575
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jan 2021 02:17:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y187so16197161wmd.3
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jan 2021 02:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UOCaNFGn8qpkTDzGnatAjkLM9ck0E2AazlgdK9gboJ4=;
        b=QD87Pn3W+Re5ufLbkWhCkzqvZ/+9A1VMq6Cpc2o9IIWv5cfzqzWOkTL/Of7gjH6EYk
         sxqbyCsM6OB5YZ2GXYGVcTpvFCAw11aiEGVETWqYHejTw+6yGH9f4A5TygoZoUk630FK
         WI1fDC7P8JWsRMBZTQZrTJ3jtmVxbu3jGVUD/wKwWfV4Yg+i0qClff+9ucTwjubdxCCt
         4CbcPfEnYDDMSjamXU2ldnJvncO76AwzxoFmiO87WMAGv5m6ZN+uTtM1OUgPnSz9/b4z
         W7iBp8uYw/0GU9TshvvnorexHM7uwECFb0GIz83iYFMSd/CsvbZyFUco+xZ/5PsH6GVe
         0wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UOCaNFGn8qpkTDzGnatAjkLM9ck0E2AazlgdK9gboJ4=;
        b=VZu7c795KfnPlCsyduQ9YKyLkuLzhkr4JnlHDicm5O9dgXa2BjNtY/DzCfoiVMnlfq
         R5FNdktWBt+KdkLIHCBBbBH/XPLtITw7JLquvPcorLY55nw+npG5+cfRENS97NqYmtiA
         zfwYnh9wPQYLRIOWiH3yBTc2OcJUjr46OJ3l1hCYHd3TjjKOctSnsU8O5L6g7ncm7+qz
         656CEFw1DKA4YfFT78xhlmu8aTjJUtB/yN1C+dy5eYkHkdJ1seCGnimfxSJPDVjRPIu3
         8q0QazbJlzhg66m/GJhH//eZe186ZLT4MohB7uvcGfeQUjV2Cfwi5VCZOjz5gflr+G89
         It5g==
X-Gm-Message-State: AOAM5337Ld4zCrvP7Mr2TwTcd2ttbhXuNUzmTAO+E8xv7esxu/zKooPR
        zcPIBEcu9XosbulyZhGfZY5+8w==
X-Google-Smtp-Source: ABdhPJwi964FZpWtpaHGKGUwgdiVe5a4w9/d4IuQfbqMX1SZ+lU2/MFLQP7L80VpVdKZbL3TFcGFYw==
X-Received: by 2002:a7b:c456:: with SMTP id l22mr3054466wmi.73.1611051425483;
        Tue, 19 Jan 2021 02:17:05 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w18sm34729229wrn.2.2021.01.19.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 02:17:04 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:16:46 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-accelerators@lists.ozlabs.org" 
        <linux-accelerators@lists.ozlabs.org>,
        "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "vivek.gautam@arm.com" <vivek.gautam@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <YAaxjmJW+ZMvrhac@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
 <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
 <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB188653AF6EFA0E55DE17815F8CA40@MWHPR11MB1886.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 06:54:28AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Saturday, January 16, 2021 11:54 AM
> > 
> > Hi Jean,
> > 
> > On 2021/1/15 0:41, Jean-Philippe Brucker wrote:
> > > I guess detailing what's needed for nested IOPF can help the discussion,
> > > although I haven't seen any concrete plan about implementing it, and it
> > > still seems a couple of years away. There are two important steps with
> > > nested IOPF:
> > >
> > > (1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
> > >      comes with this information, but a PRI page request doesn't. The
> > IOMMU
> > >      driver has to first translate the IOVA to a GPA, injecting the fault
> > >      into the guest if this translation fails by using the usual
> > >      iommu_report_device_fault().
> 
> The IOMMU driver can walk the page tables to find out the level information.
> If the walk terminates at the 1st level, inject to the guest. Otherwise fix the 
> mm fault at 2nd level. It's not efficient compared to hardware-provided info,
> but it's doable and actual overhead needs to be measured (optimization exists
> e.g. having fault client to hint no 2nd level fault expected when registering fault
> handler in pinned case).
> 
> > >
> > > (2) Translating the faulting GPA to a HVA that can be fed to
> > >      handle_mm_fault(). That requires help from KVM, so another interface -
> > >      either KVM registering GPA->HVA translation tables or IOMMU driver
> > >      querying each translation. Either way it should be reusable by device
> > >      drivers that implement IOPF themselves.
> 
> Or just leave to the fault client (say VFIO here) to figure it out. VFIO has the
> information about GPA->HPA and can then call handle_mm_fault to fix the
> received fault. The IOMMU driver just exports an interface for the device drivers 
> which implement IOPF themselves to report a fault which is then handled by
> the IOMMU core by reusing the same faulting path.
> 
> > >
> > > (1) could be enabled with iommu_dev_enable_feature(). (2) requires a
> > more
> > > complex interface. (2) alone might also be desirable - demand-paging for
> > > level 2 only, no SVA for level 1.
> 
> Yes, this is what we want to point out. A general FEAT_IOPF implies more than
> what this patch intended to address.
> 
> > >
> > > Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
> > > receive incoming I/O page faults for this device and, when SVA is enabled,
> > > feed them to the mm subsystem?  Enable that or return an error." I'm stuck
> > > on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
> > > is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
> > > above. IOMMU_DEV_FEAT_IOPF_FLAT?
> > >
> > > That leaves space for the nested extensions. (1) above could be
> > > IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with
> > KVM (or
> > > just an external fault handler) and could be used with either IOPF_FLAT or
> > > IOPF_NESTED. We can figure out the details later. What do you think?
> > 
> > I agree that we can define IOPF_ for current usage and leave space for
> > future extensions.
> > 
> > IOPF_FLAT represents IOPF on first-level translation, currently first
> > level translation could be used in below cases.
> > 
> > 1) FL w/ internal Page Table: Kernel IOVA;
> > 2) FL w/ external Page Table: VFIO passthrough;
> > 3) FL w/ shared CPU page table: SVA
> > 
> > We don't need to support IOPF for case 1). Let's put it aside.
> > 
> > IOPF handling of 2) and 3) are different. Do we need to define different
> > names to distinguish these two cases?
> > 
> 
> Defining feature names according to various use cases does not sound a
> clean way. In an ideal way we should have just a general FEAT_IOPF since
> the hardware (at least VT-d) does support fault in either 1st-level, 2nd-
> level or nested configurations. We are entering this trouble just because
> there is difficulty for the software evolving to enable full hardware cap
> in one batch. My last proposal was sort of keeping FEAT_IOPF as a general
> capability for whether delivering fault through the IOMMU or the ad-hoc
> device, and then having a separate interface for whether IOPF reporting
> is available under a specific configuration. The former is about the path
> between the IOMMU and the device, while the latter is about the interface
> between the IOMMU driver and its faulting client.
> 
> The reporting capability can be checked when the fault client is registering 
> its fault handler, and at this time the IOMMU driver knows how the related 
> mapping is configured (1st, 2nd, or nested) and whether fault reporting is 
> supported in such configuration. We may introduce IOPF_REPORT_FLAT and 
> IOPF_REPORT_NESTED respectively. while IOPF_REPORT_FLAT detection is 
> straightforward (2 and 3 can be differentiated internally based on configured 
> level), IOPF_REPORT_NESTED needs additional info to indicate which level is 
> concerned since the vendor driver may not support fault reporting in both 
> levels or the fault client may be interested in only one level (e.g. with 2nd
> level pinned).

I agree with this plan (provided I understood it correctly this time):
have IOMMU_DEV_FEAT_IOPF describing the IOPF interface between device and
IOMMU. Enabling it on its own doesn't do anything visible to the driver,
it just probes for capabilities and enables PRI if necessary. For host
SVA, since there is no additional communication between IOMMU and device
driver, enabling IOMMU_DEV_FEAT_SVA in addition to IOPF is sufficient.
Then when implementing nested we'll extend iommu_register_fault_handler()
with flags and parameters. That will also enable advanced dispatching (1).

Will it be necessary to enable FEAT_IOPF when doing VFIO passthrough
(injecting to the guest or handling it with external page tables)?
I think that would be better. Currently a device driver registering a
fault handler doesn't know if it will get recoverable page faults or only
unrecoverable ones.

So I don't think this patch needs any change. Baolu, are you ok with
keeping this and patch 4?

Thanks,
Jean
