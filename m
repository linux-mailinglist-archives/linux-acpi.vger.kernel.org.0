Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A18A6CC704
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 17:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjC1PrJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjC1Pqo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 11:46:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5874555A4;
        Tue, 28 Mar 2023 08:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680018387; x=1711554387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=crYNrhIhM7PRuqfGdrlhMT8HHw0ZnTUbj41Yu9kTScw=;
  b=QcZWGcySBPRaa75EULVf/BRygANhbBSNO550llDiX1vXQKHDQt2MU80v
   aAbjaWCNo82aAZEs+CenP3NCRX4rMccKuc8OJhjL/T3RKEyYghQ+pJGZw
   pgC2rPqqEizwsZnusCypYkGbXHvsO30YzF9/SpdPwzQBs480GhKKskg3K
   gnTv4Lfy985efONmF8Z//U3gG2oqlRs523RlNpPmiKIaiYv38s5UassRf
   x+mXg1Ugt1U/6Emsl+jOU31MwCpXy7nT6cBilML3ret+l743CeJ8pXTFz
   xk6ya3VYDjkzIKSqhTT15sDGd9fo0fgQrpZ+MZEKsYqRoLAIk+vXVZwqf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="321006627"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="321006627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="716526153"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716526153"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2023 08:46:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phBWh-009gFI-2N;
        Tue, 28 Mar 2023 18:46:23 +0300
Date:   Tue, 28 Mar 2023 18:46:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZCMLz4M37vrE5XJZ@smile.fi.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
 <ZCMDyVoFWizx+tOp@smile.fi.intel.com>
 <ZCMHTZgXnLCWjCje@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMHTZgXnLCWjCje@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 06:27:09PM +0300, Sakari Ailus wrote:
> On Tue, Mar 28, 2023 at 06:12:09PM +0300, Andy Shevchenko wrote:
> > On Tue, Mar 28, 2023 at 01:12:56PM +0300, Sakari Ailus wrote:

...

> > > +	struct scan_check_crs_csi2_context inst_context = {
> > > +		.handle = handle,
> > > +		.res_head = LIST_HEAD_INIT(inst_context.res_head),
> > > +	};
> > > +	struct crs_csi2 *csi2;
> > > +
> > > +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> > > +			    scan_check_crs_csi2_instance, &inst_context);
> > > +
> > > +	if (list_empty(&inst_context.res_head))
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Found entry, so allocate memory for it, fill it and add it to the
> > > +	 * list.
> > > +	 */
> > > +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> > > +	if (!csi2)
> > 
> > Who is going to release resources allocated in the callback above?
> 
> This is done by crs_csi2_release(), called from acpi_bus_scan_crs_csi2().

Isn't it a bit counter intuitive?

> > > +		return; /* There's nothing we really can do about this. */


-- 
With Best Regards,
Andy Shevchenko


