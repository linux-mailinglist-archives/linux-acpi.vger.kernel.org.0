Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7776F3AC51E
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jun 2021 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhFRHoT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Jun 2021 03:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhFRHoT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jun 2021 03:44:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B977C061574
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 00:42:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t7so7310486edd.5
        for <linux-acpi@vger.kernel.org>; Fri, 18 Jun 2021 00:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v52H1DGhwEBbToMjprp5OIYmxTHaBZzbygv2ty6zyTA=;
        b=dDj24zSRZV8EKE1Zp5M2dp1HZFeICLy7YE63TfpDkIVzJZ3FoLPsFddFh34nqv4QP2
         PFD9Ui270iQuK0zRwTOO4pOnL7P8YOPTpL3GAjDMCrZQsJvqZAHVhoMjz/TTdRgt3wgG
         A0PCgJpU8RqU0ZEc0RK2TE6Ehk3W87VKdkB+QlxLecfy5oBkUOr67zlULx0LW7V7VMZ2
         RHk4FDYAuvEiO5g7Bn+hBd9COd/bHu1i8c0qYLGm3ZXlo761c0LOSFBaXroaWNm3zXvL
         M5/5OVmWLndb68QIRJdLdgw67BpWLd7NhXDYappZvvUk+wpD1T5NQh+6Ok5rHTWGUYST
         qvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v52H1DGhwEBbToMjprp5OIYmxTHaBZzbygv2ty6zyTA=;
        b=Qzzb5Bo/YgGcECPVpT51tSB7OTufBRmYWjoLeLFy9uy3080B/Df90XrD5rwuAnG9nQ
         k23lEFQdtmQnWTXUlOCdnNgOpWxuj3km3Yvz7ngtDOiiljuIAmcoP0gusU1KajtzjxIT
         ajsN5qfgKE3v534YbMmFSG2bn6mm/Z8EeSQe8CXTElPbujcaGGZT1CO2d3PFHG+lQVoZ
         T0K975Gq5AjHhVi5/jE2IufXxqQ6J2wZY1kJVrflHXR+wDCD7+0yA+Cm71RZq+XZWRkz
         tzWIOZJgJ7rRcANWf7YeK69nNrAnK7WqtooMY8Fc001LzJo8WUKHBCG1yyCe+DXpSTir
         8y2w==
X-Gm-Message-State: AOAM5310Xv58MksWXYYf4su61TiKqHmNss00NornF/WieDHvXZ7pMiv8
        z3g9exKotyGCteJmjx2WnGtu2Q==
X-Google-Smtp-Source: ABdhPJwIMcxh29slWUpqVvymbEU7IrUGEPStgx5v5WFVtHmmlxhiXwp4hieNxZEXP8fTg0+HhYxHlw==
X-Received: by 2002:a05:6402:b76:: with SMTP id cb22mr3227635edb.112.1624002126744;
        Fri, 18 Jun 2021 00:42:06 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id br24sm683484ejb.55.2021.06.18.00.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 00:42:06 -0700 (PDT)
Date:   Fri, 18 Jun 2021 09:41:46 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, will@kernel.org, catalin.marinas@arm.com,
        baolu.lu@linux.intel.com, dwmw2@infradead.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, sebastien.boeuf@intel.com,
        robin.murphy@arm.com, kevin.tian@intel.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com
Subject: Re: [PATCH v4 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YMxOOq8YIBhRhzQM@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-3-jean-philippe@linaro.org>
 <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c53c9cf-43e6-11c2-6ee3-530ad1f87aec@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Eric,

On Wed, Jun 16, 2021 at 11:35:13AM +0200, Eric Auger wrote:
> > -const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
> > -						const u32 *id_in)
> > +int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
> >  {
> >  	struct acpi_iort_node *node;
> > -	const struct iommu_ops *ops;
> > +	const struct iommu_ops *ops = NULL;

Oops, I need to remove this (and add -Werror to my tests.)


> > +static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
> > +						       const u32 *id_in)
> > +{
> > +	int err;
> > +	const struct iommu_ops *ops;
> > +
> > +	/*
> > +	 * If we already translated the fwspec there is nothing left to do,
> > +	 * return the iommu_ops.
> > +	 */
> > +	ops = acpi_iommu_fwspec_ops(dev);
> > +	if (ops)
> > +		return ops;
> > +
> > +	err = iort_iommu_configure_id(dev, id_in);
> > +
> > +	/*
> > +	 * If we have reason to believe the IOMMU driver missed the initial
> > +	 * add_device callback for dev, replay it to get things in order.
> > +	 */
> > +	if (!err && dev->bus && !device_iommu_mapped(dev))
> > +		err = iommu_probe_device(dev);
> Previously we had:
>     if (!err) {
>         ops = iort_fwspec_iommu_ops(dev);
>         err = iort_add_device_replay(dev);
>     }
> 
> Please can you explain the transform? I see the
> 
> acpi_iommu_fwspec_ops call below but is it not straightforward to me.

I figured that iort_add_device_replay() is only used once and is
sufficiently simple to be inlined manually (saving 10 lines). Then I
replaced the ops assignment with returns, which saves another line and may
be slightly clearer?  I guess it's mostly a matter of taste, the behavior
should be exactly the same.

> Also the comment mentions replay. Unsure if it is still OK.

The "replay" part is, but "add_device" isn't accurate because it has since
been replaced by probe_device. I'll refresh the comment.

Thanks,
Jean
