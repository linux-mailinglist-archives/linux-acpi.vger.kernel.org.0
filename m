Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE42F2B0A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 10:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhALJRd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389586AbhALJRc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 04:17:32 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5823C061794
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2021 01:16:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id c7so1477749edv.6
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2021 01:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4Ma0KkD8d21UACM4ffQTckGsQRVOOOjeKQ7H9bkegg=;
        b=tqns5ex3W/22GNSQjU3yHEUq6Lx0NP96Ysb/ui4paO62uBN1fxSQTYwaE9hkYeZZQ3
         +OsoewHGvx/NJl0tGOelIJS7NW25gPVldz3D+LhuhiHgp1kwFsnVxvo1AxoWnGvC0v7f
         fPLYq75eocGKThJXMhyHGVDEhGZUrQ9eq/oII/jJtfNIxEbXNRxcwJwgouUnjpfdx8ST
         T8G5xSxjsCNmIYPDPyBO2+ILzXpirbSIuxR6yIkNmsNpTohxn35Qd+ULH8Tbw3mA5P3b
         YBjYT2owuHJcg3U/sfVhyg9K17im8jtzLM3LMh81MoBbUZC0i4VOIwNQ9qdwdgdr35xk
         iDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4Ma0KkD8d21UACM4ffQTckGsQRVOOOjeKQ7H9bkegg=;
        b=POVPJPmrHZcZXY6AQkCiYWSggWQaxMJ95sNLP0tt6hyg18M/pR1pY9JLNpgsLgd2gm
         um9BBte43KDG4gyG34fzQ6s6dQrrhPZuokvhaIT9eW5WCX/ItNQOJlOhVwS+K2S9SXNh
         GyfTbcziLoyZeCLK1HGu79xjZkhspo5oka8iAeYi4HNE3G3nL4Ac6tz/6bgU2g6g8xjG
         gzkuTIsYg2pQtz809/+8dY7ohvVyUG3UQvjmDsY5SJKWYPZBIplCQEdBJaI8PEJsyT/c
         mAvbxPnasmsiEJV2a/JHUq7o0+SBWGREDRcq6ACkFakN01kn3erAn9qJc2DyThua3yys
         xd/A==
X-Gm-Message-State: AOAM5327XOWv536V/Xz9BswcPvIlZniueitPd5NlkY4InbgKKdTIYx62
        87p/Y9eb9IRz3PhHCCpckG6x5Q==
X-Google-Smtp-Source: ABdhPJxkiyPcGha8EA9sg/7lQmn+O5OBib7oEZX270HhCUOKgigDK4OOnz98pAkIlqJKozflypcvug==
X-Received: by 2002:a05:6402:895:: with SMTP id e21mr2679030edy.284.1610443010649;
        Tue, 12 Jan 2021 01:16:50 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m7sm934913eji.118.2021.01.12.01.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 01:16:50 -0800 (PST)
Date:   Tue, 12 Jan 2021 10:16:31 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, vdumpa@nvidia.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
Message-ID: <X/1o72DTmzdCMhDz@myrica>
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
 <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Baolu,

On Tue, Jan 12, 2021 at 12:31:23PM +0800, Lu Baolu wrote:
> Hi Jean,
> 
> On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
> > Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> > on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> > mandating IOMMU-managed IOPF. The other device drivers now need to first
> > enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > ---
> >   include/linux/iommu.h | 20 +++++++++++++++++---
> >   1 file changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 583c734b2e87..701b2eeb0dc5 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -156,10 +156,24 @@ struct iommu_resv_region {
> >   	enum iommu_resv_type	type;
> >   };
> > -/* Per device IOMMU features */
> > +/**
> > + * enum iommu_dev_features - Per device IOMMU features
> > + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> > + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> > + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
> > + *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
> > + *			 some devices manage I/O Page Faults themselves instead
> > + *			 of relying on the IOMMU. When supported, this feature
> > + *			 must be enabled before and disabled after
> > + *			 %IOMMU_DEV_FEAT_SVA.
> 
> Is this only for SVA? We may see more scenarios of using IOPF. For
> example, when passing through devices to user level, the user's pages
> could be managed dynamically instead of being allocated and pinned
> statically.

Hm, isn't that precisely what SVA does?  I don't understand the
difference. That said FEAT_IOPF doesn't have to be only for SVA. It could
later be used as a prerequisite some another feature. For special cases
device drivers can always use the iommu_register_device_fault_handler()
API and handle faults themselves.

> If @IOMMU_DEV_FEAT_IOPF is defined as generic iopf support, the current
> vendor IOMMU driver support may not enough.

IOMMU_DEV_FEAT_IOPF on its own doesn't do anything useful, it's mainly a
way for device drivers to probe the IOMMU capability. Granted in patch
10 the SMMU driver registers the IOPF queue on enable() but that could be
done by FEAT_SVA enable() instead, if we ever repurpose FEAT_IOPF.

Thanks,
Jean
