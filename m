Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05167563C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 14:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjATN7p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 08:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjATN7p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 08:59:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC5C13ED;
        Fri, 20 Jan 2023 05:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674223184; x=1705759184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6hxlWeTZ3wO0s346jXlTNQvBt5F9mG2+mI8oEMzYhoI=;
  b=HSi59Y3HZdH6kGJy1Gxb9unJaBtaDtnSp4KeRg3LVb4DtfPEdS4r38fz
   zLy0EIim0eyYIRni0313tqZjJqfH029c+ApoS64p+ylRdPtBYWU/n3Zd/
   ZJ3Zxy/cOqzFG/qT2k4DU9wGADb2+126ocUT2ej4g0URSWVPxfmEEuY/x
   EPLkcxA+WaqxvAzWTaJPrTXXiRJ9tNASHdw0VwZB8DRhDjiRZA7Zmi0sL
   JsgmPGDyEnQ9mMmSGHMup5v5yt76T+gBJY5h/gXgysklKgVSrdN4ZC5aI
   i88oFvMGPSUUodO6fGG4rHJywVi1Hghs7+ZG5se2GS75XLtwBKAkkqDin
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="327675533"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="327675533"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 05:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638161021"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638161021"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 05:59:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIrvg-00CELW-1W;
        Fri, 20 Jan 2023 15:59:40 +0200
Date:   Fri, 20 Jan 2023 15:59:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8qeTK0I5C1Acy3m@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
 <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
 <Y8lrn0P0+CRPWUOV@smile.fi.intel.com>
 <Y8qEDXxKS8VO8NLv@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qEDXxKS8VO8NLv@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 20, 2023 at 12:07:41PM +0000, Sakari Ailus wrote:
> On Thu, Jan 19, 2023 at 06:11:11PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 19, 2023 at 06:09:26PM +0200, Andy Shevchenko wrote:
> > > On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> > > > On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > > > > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:

...

> > > > > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > > > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > > > > 
> > > > > str_has_prefix()
> > > > 
> > > > str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> > > > generate much less code --- it's just a number.
> > > 
> > > Have you tried that? Because the strlen() over const string literals will be
> > > optimized away on compilation time.
> > 
> > Probably that's the reason behind __always_inline for that function.
> 
> For str_has_prefix() the reason probably is that inlining that function
> generates less code than when not doing so.

Yes and also allows to optimize strlen() away.
So I suggest to use that function.

If assembly is different (WRT strlen("...const literal...") case),
I would like to know the exact configuration options and the code
that makes a call to strlen().

-- 
With Best Regards,
Andy Shevchenko


