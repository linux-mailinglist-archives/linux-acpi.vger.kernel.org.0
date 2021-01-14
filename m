Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD72F6625
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jan 2021 17:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbhANQln (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jan 2021 11:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbhANQlm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jan 2021 11:41:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA15C061757
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jan 2021 08:41:02 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hs11so6782484ejc.1
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jan 2021 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PpcdUm/gcB3TMCtroKeX+86rJVww+0E1mxO6peOGnow=;
        b=FGHOZ9P0lE3tooUNruq7iIqeJ+RHltmSjWchoV2pjQXQDi8y359Fcjnd5WKAEXoTpK
         Y9OB1zMWocLiVTmE+InQdaXpQNjPDgUECLlWCOnGieGoM0J4RE/Wy7qXBK0sRi1DhEOs
         XVKh7vqG8/VFncTq/LU/PCwHf8zvYQDZF+x8FQplUHzBvgaonBa+BMGlMxcECbHfK8E3
         afZ/Nm8ZjPNH9Dti91WxyG1PxU1lPESE/XK7L1I+8CvnPM5MGPof6NUxHPf1rFmGa32u
         Ruke0VtajnvzD6VnyxNJgDPYRlLZHGk9L0cXHe6V3I1wPePxdBBMixEIBrLujoLqYjlM
         LIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PpcdUm/gcB3TMCtroKeX+86rJVww+0E1mxO6peOGnow=;
        b=Y1kbDKSHwh34p8bMt3y3mgI96ubl35iKe6ZrxWLL86l6UxfaUGuOC1KzEAqqHEZF/8
         W+o/c9AaQs0mrQ2rEDuQ2DpwCe7nkjfj3R0oMIX2zyS0K90anpN8DpLSJu5oVrqSMXK5
         DsejEnru3fI74yoiL4fWpJDTJT+071VwAulbdU0jJGhUM8lJi33qEzfiTtuHGfMjJ8dR
         GfZ4FI1rFdN6YOJRBu7BBBvNOqNastMqNczjhERcFo75nEV0fV17BuhBV8ZsA5qogNXY
         dWdlpHBg5+qJp7abY/M3o5DWrMX1kjm3nFFKdMcfTRoX2fsoSC1zgqdfQz1XdOXlnVjf
         gRrw==
X-Gm-Message-State: AOAM531hfSQBGbjS5f11Ay6k2U6q+lUMfSKuLQUgAgcUrvCM1oYGR7Wl
        sdbKDN5L5k8vIGz1TSp0QvGAVw==
X-Google-Smtp-Source: ABdhPJwiiUWF0wbqzhersCabuU1z96vEkPFvGfcvm3oB0CBDThtD+9g0uc7hvEvcDAoRh0d/m3WtnQ==
X-Received: by 2002:a17:906:b08f:: with SMTP id x15mr6030193ejy.36.1610642461135;
        Thu, 14 Jan 2021 08:41:01 -0800 (PST)
Received: from larix.localdomain (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
        by smtp.gmail.com with ESMTPSA id cw7sm2123574ejc.13.2021.01.14.08.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:41:00 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:41:44 +0100
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
Message-ID: <YAB0SHyUZbxprkL3@larix.localdomain>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
X-TUID: nq/+KJqkCM9u
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 13, 2021 at 08:10:28AM +0000, Tian, Kevin wrote:
> > >> Is this only for SVA? We may see more scenarios of using IOPF. For
> > >> example, when passing through devices to user level, the user's pages
> > >> could be managed dynamically instead of being allocated and pinned
> > >> statically.
> > >
> > > Hm, isn't that precisely what SVA does?  I don't understand the
> > > difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
> > > later be used as a prerequisite some another feature. For special cases
> > > device drivers can always use the iommu_register_device_fault_handler()
> > > API and handle faults themselves.
> > 
> >  From the perspective of IOMMU, there is a little difference between
> > these two. For SVA, the page table is from CPU side, so IOMMU only needs
> > to call handle_mm_fault(); For above pass-through case, the page table
> > is from IOMMU side, so the device driver (probably VFIO) needs to
> > register a fault handler and call iommu_map/unmap() to serve the page
> > faults.
> > 
> > If we think about the nested mode (or dual-stage translation), it's more
> > complicated since the kernel (probably VFIO) handles the second level
> > page faults, while the first level page faults need to be delivered to
> > user-level guest. Obviously, this hasn't been fully implemented in any
> > IOMMU driver.
> > 
> 
> Thinking more the confusion might come from the fact that we mixed
> hardware capability with software capability. IOMMU_FEAT describes
> the hardware capability. When FEAT_IOPF is set, it purely means whatever
> page faults that are enabled by the software are routed through the IOMMU.
> Nothing more. Then the software (IOMMU drivers) may choose to support
> only limited faulting scenarios and then evolve to support more complex 
> usages gradually. For example, the intel-iommu driver only supports 1st-level
> fault (thus SVA) for now, while FEAT_IOPF as a separate feature may give the
> impression that 2nd-level faults are also allowed. From this angle once we 
> start to separate page fault from SVA, we may also need a way to report 
> the software capability (e.g. a set of faulting categories) and also extend
> iommu_register_device_fault_handler to allow specifying which 
> category is enabled respectively. The example categories could be:
> 
> - IOPF_BIND, for page tables which are bound/linked to the IOMMU. 
> Apply to bare metal SVA and guest SVA case;

These don't seem to fit in the same software capability, since the action
to perform on incoming page faults is very different. In the first case
the fault handling is entirely contained within the IOMMU driver; in the
second case the IOMMU driver only tracks page requests, and offloads
handling to VFIO.

> - IOPF_MAP, for page tables which are managed through explicit IOMMU
> map interfaces. Apply to removing VFIO pinning restriction;

From the IOMMU perspective this is the same as guest SVA, no? VFIO
registering a fault handler and doing the bulk of the work itself.

> Both categories can be enabled together in nested translation, with 
> additional information provided to differentiate them in fault information.
> Using paging/staging level doesn't make much sense as it's IOMMU driver's 
> internal knowledge, e.g. VT-d driver plans to use 1st level for GPA if no 
> nesting and then turn to 2nd level when nesting is enabled.

I guess detailing what's needed for nested IOPF can help the discussion,
although I haven't seen any concrete plan about implementing it, and it
still seems a couple of years away. There are two important steps with
nested IOPF:

(1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
    comes with this information, but a PRI page request doesn't. The IOMMU
    driver has to first translate the IOVA to a GPA, injecting the fault
    into the guest if this translation fails by using the usual
    iommu_report_device_fault().

(2) Translating the faulting GPA to a HVA that can be fed to
    handle_mm_fault(). That requires help from KVM, so another interface -
    either KVM registering GPA->HVA translation tables or IOMMU driver
    querying each translation. Either way it should be reusable by device
    drivers that implement IOPF themselves.

(1) could be enabled with iommu_dev_enable_feature(). (2) requires a more
complex interface. (2) alone might also be desirable - demand-paging for
level 2 only, no SVA for level 1.

Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
receive incoming I/O page faults for this device and, when SVA is enabled,
feed them to the mm subsystem?  Enable that or return an error." I'm stuck
on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
above. IOMMU_DEV_FEAT_IOPF_FLAT?

That leaves space for the nested extensions. (1) above could be
IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with KVM (or
just an external fault handler) and could be used with either IOPF_FLAT or
IOPF_NESTED. We can figure out the details later. What do you think?

Thanks,
Jean
