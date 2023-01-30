Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EDE681CE6
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjA3Vit (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjA3Vis (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:38:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8614849438;
        Mon, 30 Jan 2023 13:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114698; x=1706650698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AgoJHErVkNpJitIgrzOlmq5y36lFrHFz8i1N6bfkrzQ=;
  b=fe9+R/P8Lq07iU+zHiVSDxVJpHF1Xq34RKp7c2nNAlL5UIm1dw3MVyL1
   OEtniHsud8eyYZaBTqSLMobcbt1Dl9nb9uCjdNA+z6RxsEUd0NWY6lHUi
   ybxbjnfeQhRGHX6sRhVbWUnjD/JHbe8BchVy/It2TQabaIV3gk3jFRTqI
   k421YPI/Q0fq3MmGD3ueuqirgQgcdC/PCdo7Sk2sup9IXEsjZJMqtQzt0
   d/UP5Nc8rsRM89OBYVOHnrx258Gg9bKzkDKKWN8ZDWH9OgpldAGpRtr6p
   HWFHcsrAq5lU63TKRtrKuivUZ2r4qhNWFzpIzzEa9PrhngeNZ+9fTauW0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308025304"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="308025304"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727659432"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="727659432"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2023 13:37:54 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pMbqb-00HYyO-1E;
        Mon, 30 Jan 2023 23:37:53 +0200
Date:   Mon, 30 Jan 2023 23:37:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y9g4sSdDgplq1niN@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-3-sakari.ailus@linux.intel.com>
 <Y9Oip7cLqWgdzKry@smile.fi.intel.com>
 <Y9g0JvBWvn9Rsi7Q@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9g0JvBWvn9Rsi7Q@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 30, 2023 at 11:18:30PM +0200, Sakari Ailus wrote:
> On Fri, Jan 27, 2023 at 12:08:39PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 26, 2023 at 12:40:55AM +0200, Sakari Ailus wrote:

...

> > > +	/* Collect the devices that have a _CRS CSI-2 resource */
> > > +	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
> > 
> > Other serial buses limit the DEPTH by 32, why do we need more here?
> 
> I'm using the same value as for scanning devices to be added. Effectively
> this is not a practical limit but it doesn't need to be.

Hmm... Theoretically one may supply a malformed table, quite compact, but with
huge amount of "fake" devices. I would limit this the same way. If we got a
report of the depth not being enough we may bump based on the reality. This also
may limit scanning time.

> > > +			    scan_check_crs_csi2, NULL, &crs_csi2_handles, NULL);

-- 
With Best Regards,
Andy Shevchenko


