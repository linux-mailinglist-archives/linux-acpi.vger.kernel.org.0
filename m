Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC92674B5A
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 05:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjATExS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 23:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjATExB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 23:53:01 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C8E6199;
        Thu, 19 Jan 2023 20:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189894; x=1705725894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gpQhvWWMNZ24mJkrY9xm4e0/kAGsmPtNbeIC2mHtNRI=;
  b=l6QF82/fz9F75zqNWlvlOefOTVmwjZDnu1vZo+PeyGxvmik3UdwhBrqn
   HiTEKK27kz5f7aOjdf6HCnHbKQ0zu3Cl0HBBQnnATKD1VsDpCcqQdDMzV
   JlfOGPfuvvRK6iHcOL+xFDiCwzl+bSUHsHCFnjBquTibghS1dvmWTSH+C
   BA0t01utK3QzKMlWnCV5Xo117yQO+uMW2foqxVOQ+npYipT0EaYh+k3gI
   gDlTO/IcvHW4vpvWmgX0kFK7aQDFPKDOgzuvXEivku3zEbW6vwOq/wMwW
   z/aXVlGxDAltNCAafVLO8cfZuErp0j1dyOegzHrD4d7OPZ+lq6CcbUm3B
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="387694184"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="387694184"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:09:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="610114524"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="610114524"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2023 08:09:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIXTi-00BkKA-0S;
        Thu, 19 Jan 2023 18:09:26 +0200
Date:   Thu, 19 Jan 2023 18:09:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:

...

> > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > 
> > str_has_prefix()
> 
> str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> generate much less code --- it's just a number.

Have you tried that? Because the strlen() over const string literals will be
optimized away on compilation time.

> > > +		return;

-- 
With Best Regards,
Andy Shevchenko


