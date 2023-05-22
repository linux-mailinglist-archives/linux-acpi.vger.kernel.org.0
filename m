Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4738370B349
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 04:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjEVCki (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 22:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEVCkh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 22:40:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B09DD2
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 19:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684723236; x=1716259236;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xmzhWPnmJhTOy/cF278AiDEnzQcCzw7OgqRfXxJnCtk=;
  b=btyRGUPUp2Ru8VVwlyhTsu1H6ZIaDO3PEFrZmBDLZMkl76uxLTcpdgQI
   PDaVaRDsy3TwabtTMbaBd4TZYRm6r+xMb/nOl4vjdEKpEe+HS7jRvFNvI
   ch+rCUuxsxjl0tVIiKeoRAWdCwzIBEySRO/24yxj5cZ+0ocMfnci0gWuv
   fdlXaE093mgJmXHSpS5ojDfUJnYdftdh9jBi+Uk2YWV9LvsFNhgSsuJmK
   iYosiyFGff8O6n5apjMU2vL30rYtnlqrC9OR8/GitimZT5Ja+FKGROzio
   IKXnXrEh6prbZeQM04EZwI7WJt8OHfx3L/vsjhVEo9XMP5lLgPUkKZNkX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="332416861"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="332416861"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 19:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="773051627"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="773051627"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 21 May 2023 19:40:33 -0700
Message-ID: <dc5d6fb3-ed20-73f8-9ece-a4ff0d15998e@linux.intel.com>
Date:   Mon, 22 May 2023 10:39:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 10/10] iommu: Avoid locking/unlocking for
 iommu_probe_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/20/23 2:42 AM, Jason Gunthorpe wrote:
> Remove the race where a hotplug of a device into an existing group will
> have the device installed in the group->devices, but not yet attached to
> the group's current domain.
> 
> Move the group attachment logic from iommu_probe_device() and put it under
> the same mutex that updates the group->devices list so everything is
> atomic under the lock.
> 
> We retain the two step setup of the default domain for the
> bus_iommu_probe() case solely so that we have a more complete view of the
> group when creating the default domain for boot time devices. This is not
> generally necessary with the current code structure but seems to be
> supporting some odd corner cases like alias RID's and IOMMU_RESV_DIRECT or
> driver bugs returning different default_domain types for the same group.
> 
> During bus_iommu_probe() the group will have a device list but both
> group->default_domain and group->domain will be NULL.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
