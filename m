Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E770B341
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 04:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEVCfj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 22:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEVCfj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 22:35:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DABF
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 19:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684722938; x=1716258938;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OBnrxtIzz48wzmeh7S+AaCrm0N9o9EGx5LnaVLGcdVc=;
  b=XhJDw9EpwWgNITp7Rcbeh4cq1HH4W1iFDmH4zDBzDo4pHK+BB+N3v4UE
   75lwOKgppPjmoIQxBLDZWMuTjiqVn+o4Xao9yQtvjSWHJ0KnfMBHobQKK
   9i/rv4u49KPLLY62HiDShMMHPOaXvDPavcAT3gfSX39qWwt30hxruDdEI
   P1MaYKZmDwcyVwhtaOdsKnK0p576oQchRVs7n0FQ+6A0IzAdVBsYBe1Tz
   B1RK8Hk4Tc+gT/CMadGw11dZtkn8H0Wqps7g7M37Ze4c3X2KQJBw50Nvr
   K5BgkQMUapwcaMQTe9td86tJkTq/ntCuN8PCyE6QGhHIifO78pHtEp+35
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="342263810"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="342263810"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 19:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="706359300"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="706359300"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 21 May 2023 19:35:34 -0700
Message-ID: <8900ceec-ce7f-841e-28c1-1c31bd6edda5@linux.intel.com>
Date:   Mon, 22 May 2023 10:34:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 09/10] iommu: Split iommu_group_add_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <9-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
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
> Move the list_add_tail() for the group_device into the critical region
> that immediately follows in __iommu_probe_device(). This avoids one case
> of unlocking and immediately re-locking the group->mutex.
> 
> Consistently make the caller responsible for setting dev->iommu_group,
> prior patches moved this into iommu_init_device(), make the no-driver path
> do this in iommu_group_add_device().
> 
> This completes making __iommu_group_free_device() and
> iommu_group_alloc_device() into pair'd functions.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
