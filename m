Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA8F30A64D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 12:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhBALP1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 06:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhBALPZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 06:15:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFBC061574
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 03:14:44 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e15so12805543wme.0
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 03:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L2OCKKQQHglqUwYJM9UBUI+jPzsS7a6jZ5mkXorxUPk=;
        b=N5BZOmcQ5eaoia0uXY2fCg9xo8VYDzkvrXIaWmQwtR+0Z8YRR6TlUeDokPLVe5BCAW
         H3DC+wWCtna8njs76VVMhasaFKCAmpk4MXeFzqZT20bYlATjWYenkCVu1g/0mPrjcl0j
         vnUIqMT+MDwaZrWmgHMw2Sm12ewqP8o6plvIvTPhLqrOZ3p5Yi21gzjj/uR53DxDIbI2
         ADPvi5zgh2zFy7ir5STtR3+suU4Ff1pwnOABA6sqUUNBYg1DDwphrMiys69QC5ku3nEm
         +L2ZMenCdJkhpE9TKQV1cBrKC0bGo/JGER5i3i9dpNa/XF2aCYYWDNo7jd7jF/w5ofp8
         Zicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2OCKKQQHglqUwYJM9UBUI+jPzsS7a6jZ5mkXorxUPk=;
        b=jYL6zdzj6Pu7a8fMA0qQq9UAXdofem/qMt3M1txxUNVHB9je2oQmBq1QhQnYdMBwTY
         70HaJKwzMSGaUP8AGbWVUOz8vgubNQF7iefXO1JD4O2l151VuBcp1vUjoATx7dumx6d9
         xKSXi7i9/vz41rWl/DcPQ0UBor6ZKtmIC9yiuZTRd5pa2UaBbAdDj+KgSh9dsTNqRqbE
         mbDUq4lLFZ0yIpmPnJkVQ0LS0wG2mZdTxOzNXshkD3lXy2Prw1GQJhQILcpnB9gZ2AB2
         rlzGVQhguOr56RKOC5p8ayb5LUtMMTsGesYcFBOQfKJ+eyDeKPa4zmIcdxY7/u4xU+G6
         Rt3w==
X-Gm-Message-State: AOAM5329uYtcaAh5XqmrelzR91TsoFpj4c9TsPGLaiNfKmXC1Gt8UJfV
        ytSHp6Ay8VbEDP5Qxh9SnAbBgA==
X-Google-Smtp-Source: ABdhPJxHrA/jAlwYZxpdhywNDQAzvWYPSxBihzr6oYOFEMnHxFQec2SJ/QJ9CVoDRLEeW3uaLbQm5w==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr1165953wmh.60.1612178083354;
        Mon, 01 Feb 2021 03:14:43 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id e4sm27187437wrw.96.2021.02.01.03.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:14:42 -0800 (PST)
Date:   Mon, 1 Feb 2021 12:14:23 +0100
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
Message-ID: <YBfij71tyYvh8LhB@myrica>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
 <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Zhou,

On Mon, Feb 01, 2021 at 09:18:42AM +0800, Zhou Wang wrote:
> > @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
> >  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
> >  			CTXDESC_CD_0_V;
> >  
> > -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> > -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> > +		if (smmu_domain->stall_enabled)
> 
> Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
> The reason is if not CD.S will also be set when ssid is 0, which is not needed.

Some drivers may want to get stall events on SSID 0:
https://lore.kernel.org/kvm/20210125090402.1429-1-lushenming@huawei.com/#t

Are you seeing an issue with stall events on ssid 0?  Normally there
shouldn't be any fault on this context, but if they happen and no handler
is registered, the SMMU driver will just abort them and report them like a
non-stall event.

Thanks,
Jean
