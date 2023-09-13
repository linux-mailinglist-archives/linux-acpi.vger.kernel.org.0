Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631DC79E6A1
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Sep 2023 13:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbjIMLZ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Sep 2023 07:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjIMLZZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Sep 2023 07:25:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD87D1726
        for <linux-acpi@vger.kernel.org>; Wed, 13 Sep 2023 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694604321; x=1726140321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4XNSWGCsKZsmpN5R7g55RLtZXn9UrfrGXR0zOz1zMrc=;
  b=WWWXTdPDs79Gl8T7FU0cpp9ADNlJR7j89jtsfY+4wBHPYGgvIh2w10hB
   oMc3nPApfnsOyrrH/6fuBjks5SjYeWPVvCj48mVVaR4YDadI64ApttUS6
   HIRH3x/Dbrmy30gsnIgmC4bVUrzNRC69ToVRVCrUYz5phdo/aCbprqIL+
   za2p7pMmrkgZvuMlpkIhhcPadBiDl1pZHAMFtKyEeLhQiScLcIi6Fjl2P
   fd+rEwrJXjW+mzZRXocUutxCuWxMJzJpcaVXNRNLBvuYPpAHpi5G+eAgg
   FkjdoMi7LVfnWo91L+MUpvqbw2LUOYvQhrNKkvSqmekkq8Hc5SUaU0fG6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375962143"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="375962143"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074912979"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="1074912979"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:25:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qgNzh-008qkF-1v;
        Wed, 13 Sep 2023 14:25:17 +0300
Date:   Wed, 13 Sep 2023 14:25:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ken Xue <Ken.Xue@amd.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org, cwhuang@linux.org.tw
Subject: Re: [PATCH V4] acpi: trigger wakeup key event from power button
Message-ID: <ZQGcHbamHx66clr6@smile.fi.intel.com>
References: <20230913002145.743571-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913002145.743571-1-Ken.Xue@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 13, 2023 at 08:21:46AM +0800, Ken Xue wrote:
> Andorid can wakeup from various wakeup sources, but only several wakeup
> sources can wake up screen with right events(POWER, WAKEUP) from input
> device.
> 
> Regarding pressing acpi power button, it can resume system and
> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS are set in
> pm1a_sts, but kernel does not report any key event to user space during
> resuming by default.
> 
> So, send wakeup key event to user space during resuming from power button.

LGTM from code perspective, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
assuming that maintainers will check the code from functional perspective.

-- 
With Best Regards,
Andy Shevchenko


