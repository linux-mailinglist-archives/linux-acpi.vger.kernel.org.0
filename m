Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D58326593
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Feb 2021 17:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBZQat (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Feb 2021 11:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhBZQat (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Feb 2021 11:30:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E8C061574
        for <linux-acpi@vger.kernel.org>; Fri, 26 Feb 2021 08:30:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m1so8347530wml.2
        for <linux-acpi@vger.kernel.org>; Fri, 26 Feb 2021 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YseGCzjDY6Y9V6UnbishTzBOzoHsbNnd9gsiT/rD4RA=;
        b=tQLe1JHOEXTleWsdIuaOOPFqSVPu3mCeA6TcjLifl2wxU/KM4XGpZX8Yx0dCAHaW6d
         mHtO5yeUCHv5fMJyKep3uAP8VRbo+AdHxyHU2nu2qrLU9zy83N57wRuJ9nvfuGbNsf1y
         t3JncbHK4lR5phiBL8itjkJ0H5JhbuqwVFBf2z0jPSvxspjx1oU6V0a+l4QTveikN+vb
         xxOoPYCFylLaPPwTTYRLg6ySIpLZbeQ+/AnNdVXf+9eBX7Aq52he62+DQQDDLb1z5n3t
         Sc55bZX3Lj7xktY12gN9f4AAwH14wmJW9bb/7X23mqX4EeJGpeplhVSs8fjYrDliYMU4
         gSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YseGCzjDY6Y9V6UnbishTzBOzoHsbNnd9gsiT/rD4RA=;
        b=BxsLFANSdfvHFV7g9eDd5RwjFrSe4IVcxqoUmDDibBcKOOdBGYoFuYn79bMSfc1rHV
         TgCxG5nJCTnP1rAWmM7obA9B689BYKSf39Q3R6GcJ/FQqmv++wY7C6DAGRoRUaIMZrBw
         rMaz+H0WXpVpBzd/NpnQx1fqbr4lAVXLR8VyvBJ2mJEsuw2zB3ybjD+0kgF7eOybVT/a
         0Uh3y7ik+m1ImhbICWxi8SwM+0MJarTtiDhZ7xjhytUjjqli6Qwrw9V1c1Q88wVGRKtu
         Vsdty3eKuq26n4iGTCDfYtXQTsCI/vNF8X5pJ7gwK1D6AyY235svgOsM5ulNcBCA7cgp
         XAOA==
X-Gm-Message-State: AOAM533hG9q4XnWukgLPBbz6FUwuFqu6S1tlnybjMAR7wj4+7z/mh/LZ
        DKcUAv2PHXY5YRrj1gNzw7ML6w==
X-Google-Smtp-Source: ABdhPJznohOy8DU3GAcT3VQqrhXcbpg1fj10haa/AaOP7FATIiWNhrtlU7CTl34ihXGj7Pt2jEU/zw==
X-Received: by 2002:a1c:9a47:: with SMTP id c68mr3610043wme.63.1614356999337;
        Fri, 26 Feb 2021 08:29:59 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m11sm1326750wrz.40.2021.02.26.08.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:29:58 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:29:38 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     joro@8bytes.org, will@kernel.org, vivek.gautam@arm.com,
        guohanjun@huawei.com, linux-acpi@vger.kernel.org,
        zhangfei.gao@linaro.org, lenb@kernel.org,
        devicetree@vger.kernel.org, kevin.tian@intel.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        rjw@rjwysocki.net, iommu@lists.linux-foundation.org,
        sudeep.holla@arm.com, robin.murphy@arm.com,
        linux-accelerators@lists.ozlabs.org
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YDkh8qR7csPB68sC@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
 <YBfij71tyYvh8LhB@myrica>
 <fabffd28-7497-2758-c2bf-9d31aa562085@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fabffd28-7497-2758-c2bf-9d31aa562085@hisilicon.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Zhou,

On Fri, Feb 26, 2021 at 05:43:27PM +0800, Zhou Wang wrote:
> On 2021/2/1 19:14, Jean-Philippe Brucker wrote:
> > Hi Zhou,
> > 
> > On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
> >>> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> >>>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> >>>  			CTXDESC_CD_0_V;
> >>>  
> >>> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> >>> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> >>> +		if (smmu_domain->stall_enabled)
> >>
> >> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
> >> The reason is if not CD.S will also be set when ssid is 0, which is not needed.
> > 
> > Some drivers may want to get stall events on SSID 0:
> > https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t
> > 
> > Are you seeing an issue with stall events on ssid 0?  Normally there
> > shouldn't be any fault on this context, but if they happen and no handler
> > is registered, the SMMU driver will just abort them and report them like a
> > non-stall event.
> 
> Hi Jean,
> 
> I notice that there is problem. In my case, I expect that CD0 is for kernel
> and other CDs are for user space. Normally there shouldn't be any fault in
> kernel, however, we have RAS case which is for some reason there may has
> invalid address access from hardware device.
> 
> So at least there are two different address access failures: 1. hardware RAS problem;
> 2. software fault fail(e.g. kill process when doing DMA). Handlings for these
> two are different: for 1, we should reset hardware device; for 2, stop related
> DMA is enough.

Right, and in case 2 there should be no report printed since it can be
triggered by user, while you probably want to be loud in case 1.

> Currently if SMMU returns the same signal(by SMMU resume abort), master device
> driver can not tell these two kinds of cases.

This part I don't understand. So the SMMU sends a RESUME(abort) command,
and then the master reports the DMA error to the device driver, which
cannot differentiate 1 from 2?  (I guess there is no SSID in this report?)
But how does disabling stall change this?  The invalid DMA access will
still be aborted by the SMMU.

Hypothetically, would it work if all stall events that could not be
handled went to the device driver?  Those reports would contain the SSID
(or lack thereof), so you could reset the device in case 1 and ignore case
2. Though resetting the device in the middle of a stalled transaction
probably comes with its own set of problems.

> From the basic concept, if a CD is used for kernel, its S bit should not be set.
> How about we add iommu domain check here too, if DMA domain we do not set S bit for
> CD0, if unmanaged domain we set S bit for all CDs?

I think disabling stall for CD0 of a DMA domain makes sense in general,
even though I don't really understand how that fixes your issue. But
someone might come up with a good use-case for receiving stall events on
DMA mappings, so I'm wondering whether the alternative solution where we
report unhandled stall events to the device driver would also work for
you.

Thanks,
Jean
