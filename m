Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483D552EE03
	for <lists+linux-acpi@lfdr.de>; Fri, 20 May 2022 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbiETOWI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 May 2022 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350221AbiETOWE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 May 2022 10:22:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7762166469
        for <linux-acpi@vger.kernel.org>; Fri, 20 May 2022 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653056522; x=1684592522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IlQM99qMoOBV5PJlrUG89Chx3AY8uXcB59CoPPkNcqU=;
  b=EzCF2970vtCP1woXYZNj4k8AA32BpKnDhvzmTMEJuvl8624+aIm7n6Bl
   aDMWTOwQAoznYvXvylNMo4K86dYJc+/GX3DLQzRtdOKBZgsHh/W0fUIj1
   O4R75TH3KiNbCkIkHyihMT7Qruetu6OZNDifnySxUw46FrSyBfnuVAgYT
   Z82vpfJa6MhK+eavCcHGO64mIcBhcVzfpiLBsgZI/NF9kbHzQDglfJ66f
   6S7H7hoClkm/pq2M18JL/MwqQvA0OpkJsD0wp9JL0q6tmP8lAkCmjPZSC
   ToKL3nHY94VHRkXwo6KWTRtVeJxbDCAWXkFhadw64s/iVGvQmEvIXg//9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="271436435"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="271436435"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:22:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="524666519"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 07:22:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1ns3Vu-000GqW-O1;
        Fri, 20 May 2022 17:21:58 +0300
Date:   Fri, 20 May 2022 17:21:58 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 02/11] ACPI: acpica: Constify pathname argument for
 acpi_get_handle()
Message-ID: <YoekBq6zKocR/mGy@smile.fi.intel.com>
References: <20220506130025.984026-1-sakari.ailus@linux.intel.com>
 <20220506130025.984026-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0ip==ZYopb3sJvyrNpErpa1gGaJLk+OfLgff3x2tH98Og@mail.gmail.com>
 <YoUbUQkjKATrgf6n@paasikivi.fi.intel.com>
 <CAJZ5v0jvzHbD6fxNKYJ75eCc3A008fDTf8kA4nP5FK5EvuTS-w@mail.gmail.com>
 <YoVL/uDnwpfoVQwV@paasikivi.fi.intel.com>
 <CAJZ5v0i2UfBKdD1uHa8R-cuHiTbX1Fc3+ow=Pz1tcpfDhpWS3w@mail.gmail.com>
 <YocxciJSTkc5leZa@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YocxciJSTkc5leZa@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 20, 2022 at 09:13:06AM +0300, Sakari Ailus wrote:
> On Thu, May 19, 2022 at 08:05:00PM +0200, Rafael J. Wysocki wrote:

...

> Funnily enough, I saw no
> conflicts with your linux-next branch. git am is more picky than git rebase
> though.

My experience with both is telling me that it might be related to the context,
rebase is really trying hard to resolve possible conflicts / context issues
automatically. That said, I believe `git am -C1 ...` should solve that.

-- 
With Best Regards,
Andy Shevchenko


