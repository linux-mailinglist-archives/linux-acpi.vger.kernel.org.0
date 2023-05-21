Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404E70AD21
	for <lists+linux-acpi@lfdr.de>; Sun, 21 May 2023 11:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjEUJJS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 05:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUJJR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 05:09:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7A7AC
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684660156; x=1716196156;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=heKkj2TnvrCjRt2R7xWsfK6yv4o+64Djjy0XBCmzP7s=;
  b=EMnc5i9EPgboaUwPMX5ZK9sRo6RdK6E2ItQwzqBYT09TuqMifcSR4yi8
   W/5lOnrWMETAchyTa5OlS9TZpWLuo7QbyB3lBgoZsrU9cBZ3f/v3fg4Wl
   rfZiqDxtsSjB7amlOTNZL3HbC/EKAVEoxKKln0YeWD94DUpsN81f4Ziyz
   36qsEOhPmXh03nO5dvx+IbaSeVEv41wAikkPZuNuWYS7g19h+fBe6kEhC
   JPombJZT50lJjUPKXU9MWOcSAAiWOAyspZMKNpb6Y/66pdEofm+YfoH7j
   AyQurC5IyiPbW8WBlMbmZDE8hM2CLv1uFrm07g/LP5L7v01xjhT67HrzE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="333046924"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="333046924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 02:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10716"; a="768162205"
X-IronPort-AV: E=Sophos;i="6.00,181,1681196400"; 
   d="scan'208";a="768162205"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 21 May 2023 02:09:13 -0700
Message-ID: <dca9acc5-8466-83f3-01f7-2194d9ec1109@linux.intel.com>
Date:   Sun, 21 May 2023 17:08:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 04/10] iommu: Simplify the
 __iommu_group_remove_device() flow
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> Instead of returning the struct group_device and then later freeing it, do
> the entire free under the group->mutex and defer only putting the
> iommu_group.
> 
> It is safe to remove the sysfs_links and free memory while holding that
> mutex.
> 
> Move the sanity assert of the group status into
> __iommu_group_free_device().
> 
> The next patch will improve upon this and consolidate the group put and
> the mutex into __iommu_group_remove_device().
> 
> __iommu_group_free_device() is close to being the paired undo of
> iommu_group_add_device(), following patches will improve on that.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
