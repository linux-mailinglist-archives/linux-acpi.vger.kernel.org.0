Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F101F414F8A
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Sep 2021 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbhIVSEO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Sep 2021 14:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhIVSEN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Sep 2021 14:04:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A162CC061574
        for <linux-acpi@vger.kernel.org>; Wed, 22 Sep 2021 11:02:43 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id s16so3469210pfk.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Sep 2021 11:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=an6XTyp8uBzrGIm8VthzqOaurFhFc1KyG06IOfAStAA=;
        b=EwqISUaWBJ8O5geTpZwGyi7fQL+1ypivOGpEWay2ffpMgSyrQ/R+Mw2qWV7wfQVmhF
         GtM9v1WUE4U9ys8rICKPHNwbQ60714zTq3ZlQMokC/BQa7P0uTnYfstsA2XrXP7V9zPd
         CTf+5xFq62zey6lfmMfQIEORp13sh9EIX+dqLzwZnQo7PCXWvGckQSLV1oPwpsguDpwu
         1gnSkO0ocJnjH3dt4gv6QSeO/SgqbJkFaO2wEfdMx32vJyusQEydSmDwDWMRHYopk5j8
         qSLro7xL06koQ84b7V6QLizDTH/JMdNv6RmNX6QM3AP/fmwDf86XcsfJY2aWFljX75UF
         lBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=an6XTyp8uBzrGIm8VthzqOaurFhFc1KyG06IOfAStAA=;
        b=zMkQ5Tm5rYuRV+dVkAYhSN1m/UER6f5VE9l3pUXPrzm+G+5u3cSVnfwX7qOZa2LjVc
         MbFTBA9rSC7ZdJ+9EyrK3oy3gA04yCZgdIgyXAVXECWEd4HIUXtBN/DWTXhebJ6glq6G
         RRp7FFthPy5B662Z+TtwpxB5iCysHYdgoFVcRUELBxtpC7fxWVqcC7ihlN7o4W8we4qu
         MtljdR407xHPVoLE6n6vNIJiyw96I7oMhjVD2o2E14/GmwVhihcxOKKEA3Aj0FyDYNFH
         9vlXvEcd6eavByu3Y09jc/RUpnWpzPFEa+uDVsbCgAHD6nCjlXyrBoSKERdB3N3nok+2
         /0iw==
X-Gm-Message-State: AOAM533UaQOj/0kxonsETK4jyCAarLaUOkYCp30bSLv+ccJXonL9KNQ3
        RaufLeD0SYtZw2IERtSXUnEGBBhU4FiNnPDT71Whsg==
X-Google-Smtp-Source: ABdhPJw0SmYwBNzhTX9tMVeKLmcFAe2cJ59lQc/vwN6mFo19kXHNTh9pxMz/Ay8xJNhJvOlvtfHXiz0+HEErn0y13ME=
X-Received: by 2002:a63:68c6:: with SMTP id d189mr150299pgc.377.1632333763202;
 Wed, 22 Sep 2021 11:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210922152919.6940-1-justin.he@arm.com>
In-Reply-To: <20210922152919.6940-1-justin.he@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 22 Sep 2021 11:02:32 -0700
Message-ID: <CAPcyv4giSfXxf-GzmvKBvUExfuYZTjfjOSzK74PzQb3jmv6H=w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Use fallback node id when numa info in NFIT
 table is incorrect
To:     Jia He <justin.he@arm.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 22, 2021 at 8:29 AM Jia He <justin.he@arm.com> wrote:
>
> When ACPI NFIT table is failing to populate correct numa information
> on arm64, dax_kmem will get NUMA_NO_NODE from the NFIT driver.
>
> Without this patch, pmem can't be probed as RAM devices on arm64 guest:
>   $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 128M
>   kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
>   kmem: probe of dax0.0 failed with error -22
>

I'll add:

Cc: <stable@vger.kernel.org>
Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use
like normal RAM")

...other than that, looks good to me.

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/acpi/nfit/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index a3ef6cce644c..7dd80acf92c7 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3007,6 +3007,18 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
>                 ndr_desc->target_node = NUMA_NO_NODE;
>         }
>
> +       /* Fallback to address based numa information if node lookup failed */
> +       if (ndr_desc->numa_node == NUMA_NO_NODE) {
> +               ndr_desc->numa_node = memory_add_physaddr_to_nid(spa->address);
> +               dev_info(acpi_desc->dev, "changing numa node from %d to %d for nfit region [%pa-%pa]",
> +                       NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
> +       }
> +       if (ndr_desc->target_node == NUMA_NO_NODE) {
> +               ndr_desc->target_node = phys_to_target_node(spa->address);
> +               dev_info(acpi_desc->dev, "changing target node from %d to %d for nfit region [%pa-%pa]",
> +                       NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
> +       }
> +
>         /*
>          * Persistence domain bits are hierarchical, if
>          * ACPI_NFIT_CAPABILITY_CACHE_FLUSH is set then
> --
> 2.17.1
>
