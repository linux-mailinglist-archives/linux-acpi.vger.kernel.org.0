Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A670B2E0
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 03:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjEVBot (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 21:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjEVBoq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 21:44:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82404D2
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 18:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684719879; x=1716255879;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6SOQe/1i7ESxVfMLC7Q050UYtfAJ+dtZJDKbqpBo6mk=;
  b=Mt/CE904DLIwrKkYJe0SHc+0EORRx5Cn8rYWfwgxJLO1NOBpqMzJvr37
   prHy+KHhyAi7UdqRZAfjsdhouRfd+RW7DEYqDACd2+xpb18vU9uk170qh
   2JQdq+d8w3dS/cM6eN7vAUqksGu4NUniczRkkoUMZQ2F4sWRyHWqVuRH6
   /Ljq/M15r0pglt1oIk6OWrDc70ZaahghRFAv/18j0+FUYZGYdItAYCnbF
   68Ozt5myY66g1vvS46XkJw3DyPFXI7OIihSRfFTgwnnXp355aeQBB0IhF
   GRHxGqHkZZ6YTQP5f5g5Y0vot0KgfTKYze/xcCFy1jz7CvSpMTvxnCGki
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="355149109"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="355149109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 18:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736237888"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="736237888"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2023 18:44:37 -0700
Message-ID: <eab789ac-89e4-2159-bd4e-c281f0e4b39b@linux.intel.com>
Date:   Mon, 22 May 2023 09:43:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 08/10] iommu: Always destroy the iommu_group during
 iommu_release_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <8-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
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
> Have release fully clean up the iommu related parts of the struct device,
> no matter what state they are in.
> 
> Split the logic so that the three things owned by the iommu core are
> always cleaned up:
>   - Any attached iommu_group
>   - Any allocated dev->iommu and its contents including a fwsepc
>   - Any attached driver via a struct group_device
> 
> This fixes a minor bug where a fwspec created without an iommu_group being
> probed would not be freed.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
