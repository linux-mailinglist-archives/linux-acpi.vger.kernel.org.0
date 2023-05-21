Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6895D70ADA5
	for <lists+linux-acpi@lfdr.de>; Sun, 21 May 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEULpx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjEULUc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 07:20:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C49410C4
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684667399; x=1716203399;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+h60Y/O3l7VXQU+u85xeDYR7sDkQUZvus34jpLoH5QY=;
  b=DC0MntTtd8YsH9RC1PJUCZRYWwbIog1/7vMPA+T9jLnKd1O+DsGO7QU8
   dzkWFqgk33vrBP5htgDBz3jYlLzGIq9/g8VmaeR75tTUtXuCsD/tZN8UN
   E+ggOhb+oV0Dg7P5AeWEMpkWISRHiaJ/fk+JtP4StGwnTTOS1qOGPgaCr
   h3eRGJddHBkjZGHVR9o5g5V1oQZw/v/m/vSYxvVEKZSQBiZBvC30D/wDC
   pXhGf8UyehXshSSXwQwuYRDSdYfvBk4WG9SEEVgLuIzxYs90hsHSVA+8I
   62MPU+CVp4E5FY323weR1bJsFbswbSlkrMtzcJcZIRpwihDHtekSqp3dI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="355041155"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="355041155"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 04:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="768185778"
X-IronPort-AV: E=Sophos;i="6.00,182,1681196400"; 
   d="scan'208";a="768185778"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2023 04:09:56 -0700
Message-ID: <f52ef321-ad1a-3664-8100-b3ae78add3ee@linux.intel.com>
Date:   Sun, 21 May 2023 19:09:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 05/10] iommu: Add iommu_init/deinit_device() paired
 functions
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <5-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> Move the driver init and destruction code into two logically paired
> functions.
> 
> There is a subtle ordering dependency in how the group's domains are
> freed, the current code does the kobject_put() on the group which will
> hopefully trigger the free of the domains before the module_put() that
> protects the domain->ops.
> 
> Reorganize this to be explicit and documented. The domains are cleaned up
> by iommu_deinit_device() if it is the last device to be deinit'd from the
> group.  This must be done in a specific order - after
> ops->release_device() and before the module_put(). Make it very clear and
> obvious by putting the order directly in one function.
> 
> Leave WARN_ON's in case the refcounting gets messed up somehow.
> 
> This also moves the module_put() and dev_iommu_free() under the
> group->mutex to keep the code simple.
> 
> Building paired functions like this helps ensure that error cleanup flows
> in __iommu_probe_device() are correct because they share the same code
> that handles the normal flow. These details become relavent as following
> patches add more error unwind into __iommu_probe_device(), and ultimately
> a following series adds fine-grained locking to __iommu_probe_device().
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
