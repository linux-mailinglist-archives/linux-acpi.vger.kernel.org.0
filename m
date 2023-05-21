Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A03070ACF6
	for <lists+linux-acpi@lfdr.de>; Sun, 21 May 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEUIVH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjEUISn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 04:18:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E3138
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684657122; x=1716193122;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Nltdqj1+yLFscqIMCZdovelKmFjnXYgPdLIs5/rUMm0=;
  b=G9KMEfrPKlVADtxlDM+MKT2D2qhHqxYecIcThfRNlAmfg/ha83eskcpN
   1kiAXQO7vouxxnAkb/Jxfj/w6kXwQn5elyg8W+rKtW15Gk3S2safoBkDP
   zjl2mXbSWu193SEaVEF04ou5U7J61xDpR4SgtWgit87UIKrYMRb8OKZbb
   sTQWaDelRfa6mR21J5dkVNHLYiwTJ8nwTRTZKSHcQZVwwYnjqNSz0KKfH
   mWToebY+i/On8ZPadct9cfA9O6WZ5Ef2XMOUFd0ekBC0WQrGgLRjXtmGy
   /7p6pwxGZSX5JLWwe6uqCrrUmeaOa7enGhSJL48VuWFWhVajmCHJqSHY9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="350189200"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="350189200"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 01:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="792903455"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="792903455"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 21 May 2023 01:18:39 -0700
Message-ID: <f92a9558-f202-40fd-7ace-14c40f675dc8@linux.intel.com>
Date:   Sun, 21 May 2023 16:17:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 01/10] iommu: Have __iommu_probe_device() check for
 already probed devices
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> This is a step toward making __iommu_probe_device() self contained.
> 
> It should, under proper locking, check if the device is already associated
> with an iommu driver and resolve parallel probes. All but one of the
> callers open code this test using two different means, but they all
> rely on dev->iommu_group.
> 
> Currently the bus_iommu_probe()/probe_iommu_group() and
> probe_acpi_namespace_devices() rejects already probed devices with an
> unlocked read of dev->iommu_group. The OF and ACPI "replay" functions use
> device_iommu_mapped() which is the same read without the pointless
> refcount.
> 
> Move this test into __iommu_probe_device() and put it under the
> iommu_probe_device_lock. The store to dev->iommu_group is in
> iommu_group_add_device() which is also called under this lock for iommu
> driver devices, making it properly locked.
> 
> The only path that didn't have this check is the hotplug path triggered by
> BUS_NOTIFY_ADD_DEVICE. The only way to get dev->iommu_group assigned
> outside the probe path is via iommu_group_add_device(). Today the only
> caller is VFIO no-iommu which never associates with an iommu driver. Thus
> adding this additional check is safe.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
