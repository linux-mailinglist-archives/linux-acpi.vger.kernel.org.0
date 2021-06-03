Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22E399B8E
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jun 2021 09:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFCH3n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 03:29:43 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34499 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhFCH3n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 03:29:43 -0400
Received: by mail-wr1-f45.google.com with SMTP id q5so4772802wrm.1
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jun 2021 00:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjHtr3gTuVS3B9K5gbkiLkfbQy+nc18Icq13dk6Hd1w=;
        b=gqAljoVqc5fs1ymDkbbBYpsEQ7RF47C3qAXxPM/IDZ7QGRMMt4Qm9KZjsynqPNnZFx
         G88bnyxRirGhQlA5aMJ+ZlaywFszPax9Ye7ymRdRlmNAfmC6tMZpNr5ASjvmgSW6oPNM
         psClF/DwNzrV5uPP9TD5iPoCD8EHb5usEhu3PuHfta13Zvk/12h15e0W98vrRkcdFvO5
         Vn+4SexMSyoG+9o8Qd2zKDwZiiHGcvL7/yN4eycIvfp9SK9ShWiJYWiDgECcBlxLjwNv
         jLcrHvpY2qI1Rubo8cyK7e3T9D2TTbHvDweU8BtFKgrSPQZBHY8QAq4bugMxn4Tk0MW3
         ftDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjHtr3gTuVS3B9K5gbkiLkfbQy+nc18Icq13dk6Hd1w=;
        b=VD+jAVNpCt5vIMIfELudZ9qHaQBlIsBfl2XPSsdc2MJu+gmaGszqxwblYgyfB/gOUI
         98MgMmTbo1ooIE9PCsRcjSkwHrZsMceyXKLzMeMLNYEMTaWT3s60APllAAYsauaMRoQQ
         Z6Zs4c9shJATZMjG2IHvqd3FZeoz2qUvjMCXDNWBTeKAmyJTgqdbNyYIPeNaTNNkz+hM
         1kLmR20nQrjGK+uhdoG9ZNyj6YIfPuJJJkziFuGkUhLdlNdXkDGnlox8BE421qXOACtT
         HQBeB3YGMDnA6vveZHFfW42vsTj3hTImTqhR+IYHeP3ylft47YF7Dm7TJznJRDxYsdk9
         /sZg==
X-Gm-Message-State: AOAM533l4BussNV6Uf+IVSD/Y9lHCtE0VFsnfMJ6AtOAFWTP1rDBnuuB
        IJSF9+L9S/Cm3MJkNRixjO471A==
X-Google-Smtp-Source: ABdhPJwRy3qSdOxODp9+jlDSTJTRJuDx6IpDrmgJgxbzvXau7vT2HNKEfmMsuaZf+pQ3I7sWqx4oxA==
X-Received: by 2002:adf:fd90:: with SMTP id d16mr8109626wrr.35.1622705218314;
        Thu, 03 Jun 2021 00:26:58 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id n2sm2121259wmb.32.2021.06.03.00.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 00:26:57 -0700 (PDT)
Date:   Thu, 3 Jun 2021 09:26:39 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org,
        mst@redhat.com, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, will@kernel.org,
        catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YLiELyo+KLuYqA24@myrica>
References: <20210602154444.1077006-3-jean-philippe@linaro.org>
 <202106030417.97asL7dA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106030417.97asL7dA-lkp@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 03, 2021 at 04:06:18AM +0800, kernel test robot wrote:
> >> drivers/acpi/scan.c:1540:26: error: no member named 'ops' in 'struct iommu_fwspec'
>            return fwspec ? fwspec->ops : NULL;
>                            ~~~~~~  ^
> >> drivers/acpi/scan.c:1564:9: error: implicit declaration of function 'iommu_probe_device' [-Werror,-Wimplicit-function-declaration]
>                    err = iommu_probe_device(dev);
>                          ^

These are only defined when CONFIG_IOMMU_API is set. IORT uses them inside
an #ifdef, I can do the same. Maybe moving these two functions to a new
drivers/acpi/iommu.c would be nicer, though.

Thanks,
Jean

>    2 errors generated.
> 
> 
> vim +1540 drivers/acpi/scan.c
> 
>   1535	
>   1536	static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
>   1537	{
>   1538		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   1539	
> > 1540		return fwspec ? fwspec->ops : NULL;
>   1541	}
>   1542	
>   1543	static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
>   1544							       const u32 *id_in)
>   1545	{
>   1546		int err;
>   1547		const struct iommu_ops *ops;
>   1548	
>   1549		/*
>   1550		 * If we already translated the fwspec there is nothing left to do,
>   1551		 * return the iommu_ops.
>   1552		 */
>   1553		ops = acpi_iommu_fwspec_ops(dev);
>   1554		if (ops)
>   1555			return ops;
>   1556	
>   1557		err = iort_iommu_configure_id(dev, id_in);
>   1558	
>   1559		/*
>   1560		 * If we have reason to believe the IOMMU driver missed the initial
>   1561		 * add_device callback for dev, replay it to get things in order.
>   1562		 */
>   1563		if (!err && dev->bus && !device_iommu_mapped(dev))
> > 1564			err = iommu_probe_device(dev);
>   1565	
>   1566		/* Ignore all other errors apart from EPROBE_DEFER */
>   1567		if (err == -EPROBE_DEFER) {
>   1568			return ERR_PTR(err);
>   1569		} else if (err) {
>   1570			dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
>   1571			return NULL;
>   1572		}
>   1573		return acpi_iommu_fwspec_ops(dev);
>   1574	}
>   1575	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


