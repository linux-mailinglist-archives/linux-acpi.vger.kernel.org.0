Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C48675833
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Jan 2023 16:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjATPLc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Jan 2023 10:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjATPLb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jan 2023 10:11:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FBABFF77;
        Fri, 20 Jan 2023 07:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674227490; x=1705763490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j+EdujhDZBaTO8hvtwBSCNb0/UExevWfNZEijqjQWFM=;
  b=aPwiH2/AH86MNRMZHo7RPmJzTxzkRP6ZouP05UL7YK14Ml9XRp5ZF/Z2
   8u0Y46nHbB1Bw7FTgmI07fW/1MOLGot94bIJFmhSirfM4h7kzWGIEqBIc
   EsWmPRp162sUn3S3mGR2n2aDecVtrplXhlih+JKq5Z7ImpG9yOYwdpArq
   1RnoC/8Crcxp5HSpMIyxJb5WMpeE4zrWk9TCQXyhzgGr3qyTsg/bKOKwg
   VyMlQr6gYqQ7zW0NoRNKYWMsyYHgVhzmLlpFVHf8TeNWBpsCOtTWkYM1m
   RkGCO8MeNZjWzaWi/rAjXkEla9Rxrv9RALr5MIqO4GOCoMsT0INz6xOsY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="325634685"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="325634685"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 07:11:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="729143033"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="729143033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jan 2023 07:11:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pIt39-00CHOh-1a;
        Fri, 20 Jan 2023 17:11:27 +0200
Date:   Fri, 20 Jan 2023 17:11:27 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        linux-media@vger.kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y8qvHzbs1J9pS9nj@smile.fi.intel.com>
References: <20230117122244.2546597-1-sakari.ailus@linux.intel.com>
 <20230117122244.2546597-8-sakari.ailus@linux.intel.com>
 <Y8a+8q5hzkoPjpDO@smile.fi.intel.com>
 <Y8lnBeamT90z4aKY@paasikivi.fi.intel.com>
 <Y8lrNe9S4eIdWbXu@smile.fi.intel.com>
 <Y8qB/B5NfTWRi7Ma@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qB/B5NfTWRi7Ma@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 20, 2023 at 11:58:52AM +0000, Sakari Ailus wrote:
> On Thu, Jan 19, 2023 at 06:09:25PM +0200, Andy Shevchenko wrote:
> > On Thu, Jan 19, 2023 at 03:51:33PM +0000, Sakari Ailus wrote:
> > > On Tue, Jan 17, 2023 at 05:29:54PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Jan 17, 2023 at 02:22:43PM +0200, Sakari Ailus wrote:

...

> > > > > +	if (memcmp(elements[0].string.pointer, MIPI_IMG_PREFIX,
> > > > > +		   sizeof(MIPI_IMG_PREFIX) - 1))
> > > > 
> > > > str_has_prefix()
> > > 
> > > str_has_prefix() calls strlen() on prefix on every call. sizeof() will
> > > generate much less code --- it's just a number.
> > 
> > Have you tried that? Because the strlen() over const string literals will be
> > optimized away on compilation time.
> 
> Actually not. There seem to be an implementation of strlen() in
> include/linux/fortify-string.h that would seem to be capable of doing that.
> However its use is conditional to kernel configuration.

Ah, you missed probably the ability of the complier to find constant literals
and replace the strlen() with plain number.

You may play with godbolt and see how optimization (-O2) makes this happen.

-- 
With Best Regards,
Andy Shevchenko


