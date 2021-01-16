Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688E2F8B0C
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Jan 2021 04:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAPDz6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 22:55:58 -0500
Received: from mga02.intel.com ([134.134.136.20]:63412 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbhAPDz5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 22:55:57 -0500
IronPort-SDR: VsWmLMw5uxQrGa8iI4Lf9S3XBK7wQODrEHtXV3WyOWA5Enu50CADFHl1J2EuoOL+9XggtMn4C2
 seSy+oS4WMtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="165726851"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="165726851"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 19:54:09 -0800
IronPort-SDR: 7RhNQTovQFrnfgsrcED9MhwANujPxOXtWf4Cq1X9OVAbauLpkRRAXSUed/tegFsW9b4aiT9/qz
 us0wXXg3dWaA==
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="382896643"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.175.94]) ([10.249.175.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 19:54:03 -0800
Cc:     baolu.lu@linux.intel.com, "joro@8bytes.org" <joro@8bytes.org>,
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
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
 <X/1o72DTmzdCMhDz@myrica>
 <c88e5d74-098d-7f1d-a7bb-a89e40fb8fa4@linux.intel.com>
 <MWHPR11MB18868F53E5A9E0CF9975042B8CA90@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YAB0SHyUZbxprkL3@larix.localdomain>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <636814a9-7dea-06f6-03ec-6a98dd30b7e3@linux.intel.com>
Date:   Sat, 16 Jan 2021 11:54:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAB0SHyUZbxprkL3@larix.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 2021/1/15 0:41, Jean-Philippe Brucker wrote:
> I guess detailing what's needed for nested IOPF can help the discussion,
> although I haven't seen any concrete plan about implementing it, and it
> still seems a couple of years away. There are two important steps with
> nested IOPF:
> 
> (1) Figuring out whether a fault comes from L1 or L2. A SMMU stall event
>      comes with this information, but a PRI page request doesn't. The IOMMU
>      driver has to first translate the IOVA to a GPA, injecting the fault
>      into the guest if this translation fails by using the usual
>      iommu_report_device_fault().
> 
> (2) Translating the faulting GPA to a HVA that can be fed to
>      handle_mm_fault(). That requires help from KVM, so another interface -
>      either KVM registering GPA->HVA translation tables or IOMMU driver
>      querying each translation. Either way it should be reusable by device
>      drivers that implement IOPF themselves.
> 
> (1) could be enabled with iommu_dev_enable_feature(). (2) requires a more
> complex interface. (2) alone might also be desirable - demand-paging for
> level 2 only, no SVA for level 1.
> 
> Anyway, back to this patch. What I'm trying to convey is "can the IOMMU
> receive incoming I/O page faults for this device and, when SVA is enabled,
> feed them to the mm subsystem?  Enable that or return an error." I'm stuck
> on the name. IOPF alone is too vague. Not IOPF_L1 as Kevin noted, since L1
> is also used in virtualization. IOPF_BIND and IOPF_SVA could also mean (2)
> above. IOMMU_DEV_FEAT_IOPF_FLAT?
> 
> That leaves space for the nested extensions. (1) above could be
> IOMMU_FEAT_IOPF_NESTED, and (2) requires some new interfacing with KVM (or
> just an external fault handler) and could be used with either IOPF_FLAT or
> IOPF_NESTED. We can figure out the details later. What do you think?

I agree that we can define IOPF_ for current usage and leave space for
future extensions.

IOPF_FLAT represents IOPF on first-level translation, currently first
level translation could be used in below cases.

1) FL w/ internal Page Table: Kernel IOVA;
2) FL w/ external Page Table: VFIO passthrough;
3) FL w/ shared CPU page table: SVA

We don't need to support IOPF for case 1). Let's put it aside.

IOPF handling of 2) and 3) are different. Do we need to define different
names to distinguish these two cases?

Best regards,
baolu
