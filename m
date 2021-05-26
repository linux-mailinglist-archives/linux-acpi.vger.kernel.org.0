Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29525391456
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 12:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhEZKFz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhEZKFz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 06:05:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C115C061756
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 03:04:23 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jt22so1491535ejb.7
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6vKl5wXX6m3B8S615pg0hNiDymSmdGcKHVZ5IanzTbQ=;
        b=RvdlZigy0NWOWJ5IX5kOqv4M+9H8owkJpPuwqCEa0ZFeXMQvC2wnCU0G1XLX2Oh6Qc
         UAXeaBKUhYPqs1/d/mttTaGZGK9zKg+9e4AxltWH+fx4279o+OGKgeEKOSqFliABtgMd
         F5RxumrPAmjoNhm4FfbM/nnmwiar30lyihH6qjQ/l9AeaQfwTFxDUQ5ihdPJQg49O5EB
         xqKeQmK8Hhze3vM0He32bxgYZrIYVzF1W6r7Zf3YaPHaylVedwvZbQi2Ub/EoitPSdKS
         9isi5bRJBqy0mWSlA6p4kk3B9OZH1XzUFbOe0Q2MUXOGJckm8xFm2WR4gOBvIf1ClDZb
         zwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6vKl5wXX6m3B8S615pg0hNiDymSmdGcKHVZ5IanzTbQ=;
        b=lnOf+z5ansLz8B0cMXKsDCYwzfdoD8KXPNgwQ1QU9LrH7hXQ6kuOirioi1/pk5SiJR
         KPpvDz2UUIUd7+tll2CsEpYjrJOPwbWfa0w26CRV/nZd1VF4ahehnPkTxFkMat530VmL
         hZNd99mGTvp96BTL0MLCfUJdjzPkbh4Uw2WDH//kxNN2n7pECR5rFenTviY7JzgwWfj6
         gYrKpEWj3cyIGVbCUwbH4bviaXttk9pOdwl2KkCKQnaZJN1cQlIE1E0ZiquAy4hrnDF8
         TOQUu56VT7qeIowmoA5H4kpUB4OUqhNCfKcKEsF+OYk31gtMDI8gewZ4SyRQNHwg2mdk
         HCgw==
X-Gm-Message-State: AOAM530HQVQC+6DZItXzdevSWcBj3jtky6ijWRSaRVu69Syo0ys4fOCb
        gPjabTV+bcBdtz1Jp4C7vH4lNQ==
X-Google-Smtp-Source: ABdhPJyikgVRUFu3nC9T4AMVWatJFwbVikBSeD8fXfrM/F9mmEI89dlrOXNO+Hf2sPTVJ5KE1IhXEQ==
X-Received: by 2002:a17:906:7f06:: with SMTP id d6mr32984690ejr.189.1622023461876;
        Wed, 26 May 2021 03:04:21 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
        by smtp.gmail.com with ESMTPSA id j4sm9339398edq.13.2021.05.26.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:04:21 -0700 (PDT)
Date:   Wed, 26 May 2021 12:04:03 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Eric Auger <eric.auger@redhat.com>, sebastien.boeuf@intel.com,
        Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 3/6] ACPI: Add driver for the VIOT table
Message-ID: <YK4dE+46ukG1Gcza@myrica>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-4-jean-philippe@linaro.org>
 <CAJZ5v0hoM-y2ajCVx8y4pXdPgAiNUBU6NUZ9m==NiVH8QcvWtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hoM-y2ajCVx8y4pXdPgAiNUBU6NUZ9m==NiVH8QcvWtw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 21, 2021 at 06:39:24PM +0200, Rafael J. Wysocki wrote:
> > diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> > new file mode 100644
> > index 000000000000..710e5a5eac70
> > --- /dev/null
> > +++ b/drivers/acpi/viot.c
> > @@ -0,0 +1,350 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Virtual I/O topology
> 
> In the first place, more information on what this is all about, please.
> 
> What it does and how it is used.

Sure, I can add:

 *
 * The Virtual I/O Translation Table (VIOT) describes the topology of
 * para-virtual IOMMUs and the endpoints they manage. The OS uses it to
 * initialize devices in the right order, preventing endpoints from
 * issuing DMA before their IOMMU is ready. 
 *
 * When binding a driver to a device, before calling the device driver's
 * probe() method, the driver infrastructure calls dma_configure(). At
 * that point the VIOT driver looks for an IOMMU associated to the device
 * in the VIOT table. If an IOMMU exists and has been initialized, the
 * VIOT driver initializes the device's IOMMU fwspec, allowing the DMA
 * infrastructure to invoke the IOMMU ops when the device driver
 * configures DMA mappings. If an IOMMU exists and hasn't yet been
 * initialized, VIOT returns -EPROBE_DEFER to postpone probing the device
 * until the IOMMU is available.
 */

Thanks,
Jean
