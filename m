Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C9775C733
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jul 2023 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjGUMzT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Jul 2023 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGUMzS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Jul 2023 08:55:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A4A10CB
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jul 2023 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689944117; x=1721480117;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8BRn7i97o91cbVCL7dSS5ELK+F4Z9qj6dXHbqb81iw=;
  b=nP3QBxOw3fYu2Sr0It7zGq4NKpVpNf2NFP5eRryf4RDoQKo+biNEnA/a
   3MX4o5reqvSQA8iyM5lLfG+lnYkDwWc5YyAsekrp7kxX7r6UktByTSjOk
   iaLmDP5gCX+F++k/5miBtRm/WJwaeYIDMNHwgc3hXYmWz6KanMX0Dyb1W
   J7l2fxILlRyLVTgslI9ztZ8l7uyfPjuNlOcTwX7HJM4kAApJMXrZSkwmH
   SzRW9adABLyvSBxQFyDvyX9SuyrcvWBRzn1k16YSanZHxkEZlqiQFFOzE
   Tam2o2Z6QrOE5+Z5Q3bB0co0cnK/TCwFL58KdLDDNzpOoePWjWldl2OIQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346613934"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346613934"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 05:55:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="718805006"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="718805006"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 21 Jul 2023 05:55:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMpf7-0057Z6-25;
        Fri, 21 Jul 2023 15:55:13 +0300
Date:   Fri, 21 Jul 2023 15:55:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     rafael@kernel.org, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Subject: Re: [PATCH v3 2/4] ACPI: NHLT: Introduce acpi_gbl_nhlt
Message-ID: <ZLqAMf2eakwSfBgs@smile.fi.intel.com>
References: <20230721094722.300586-1-cezary.rojewski@intel.com>
 <20230721094722.300586-3-cezary.rojewski@intel.com>
 <ZLpigtZ0ptwhhWEi@smile.fi.intel.com>
 <95930a64-d7eb-7d88-d7ee-13a319674d77@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95930a64-d7eb-7d88-d7ee-13a319674d77@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 21, 2023 at 02:44:42PM +0200, Cezary Rojewski wrote:
> On 2023-07-21 12:48 PM, Andy Shevchenko wrote:
> > On Fri, Jul 21, 2023 at 11:47:20AM +0200, Cezary Rojewski wrote:

...

> > > @@ -594,6 +594,9 @@ config ACPI_PRMT
> > 
> > > +config ACPI_NHLT
> > 
> > Wouldn't be better to squeeze it to the most ordered piece of the file, so
> > the list of the table support code files will be kinda ordered?
> 
> I may be wrong about this, but it seems that the driver/acpi/Kconfig file
> does not list tables supported in any kind of ordered fashion. I'd refrain
> from reordering the Kconfig in this very patch and rather have such job done
> in a separate series instead.

Yes, but my point to make this job easier to whoever will do it.

> > Otherwise looks good to me, FWIW,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


