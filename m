Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F8673E48
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jan 2023 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjASQL2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Jan 2023 11:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASQL1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jan 2023 11:11:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC99CB0;
        Thu, 19 Jan 2023 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674144685; x=1705680685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rFFNspM4PkcmcwS0KwDUA2pD12KposrRtHGWSG8muLM=;
  b=jEVENeUgvUwqRDfxbqjkJKbZCriHdvddQMO/cVBg5VLMC2YaWM1LpaKf
   WwC2XY1m6QqderZcO0iUPesXRT/l7dtBi1z3Ka2HXV0oYhbWTMjS9E3Ot
   QrntHv77Wj6z8Rl/vk/VwfE8s/UNJuOr6XlZoRu9UGyKynqXgfryJfMjL
   DULqZtRZSwTa9OGNklEhBHgg+2UpenLHcwdtHBR4pYC314/EZwlqRmgKG
   6XFpNJrFLpfbX5Iv9VtYppGhyzefDadwsbn0RjI6hU2XHXdNvNod44IjD
   mn0L71nPxyD/Viozaq7/Aamwp8nshB9gHEzVnqlre6OihXm7ILtpQQ9d9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="305004581"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="305004581"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 08:11:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802682237"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="802682237"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 08:11:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIXVQ-00BkMq-02;
        Thu, 19 Jan 2023 18:11:12 +0200
Date:   Thu, 19 Jan 2023 18:11:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8lrn0P0+CRPWUOV@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
 <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 19, 2023 at 06:09:26PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> > On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:

...

> > > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > > 
> > > str_has_prefix()
> > 
> > str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> > generate much less code --- it's just a number.
> 
> Have you tried that? Because the strlen() over const string literals will be
> optimized away on compilation time.

Probably that's the reason behind __always_inline for that function.

> > > > +		return;

-- 
With Best Regards,
Andy Shevchenko


