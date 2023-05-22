Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CA970B29F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 02:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjEVAxo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 May 2023 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEVAxn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 May 2023 20:53:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030CDB
        for <linux-acpi@vger.kernel.org>; Sun, 21 May 2023 17:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684716823; x=1716252823;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eaUFfTIw8VLdTjEPi4kF8vNiaIbGrwf2Ooao2/3jTJI=;
  b=YIFmwXDYx3nbCaXGEbWBsApoADf84f9IIJk3NLKJLp1j4JFZzuv0lsK8
   virtftJ34J7pmKNIF9BiQphhXzG1JiuaHOYizdPGk6+zFW/oWd7kygipR
   /XyPOMKNyTGkKAvNyLwdMfe1gdwSuVkopBUxMvesXalZUPzjwWREjEfeF
   IJEnsn48+RhIxgiT265eWGijFOBpsdtH5Vb85nB283gmezwhNmirHW4Hm
   nkMjRmqwjuwZcdbgG2ITm4AJN/b/n1oto/gsFC/NVwQ1pE1c3xj/CRoa5
   L4NWCAB4I724UzqmH6xQLgMt/+cunBHYx5RLWtTMZFCxey2OZYuX7ixIH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="356019575"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="356019575"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2023 17:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736227748"
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="736227748"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 21 May 2023 17:53:39 -0700
Message-ID: <b5e0027b-bc14-42c4-e159-4749ec52bd88@linux.intel.com>
Date:   Mon, 22 May 2023 08:52:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 07/10] iommu: Do not export iommu_device_link/unlink()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <7-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7-v2-3c3bb7aa6e48+1916b-iommu_probe_jgg@nvidia.com>
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
> These are not used outside iommu.c, they should not be available to
> modular code.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
