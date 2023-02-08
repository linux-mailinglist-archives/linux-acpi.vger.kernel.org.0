Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D81E68F8C8
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Feb 2023 21:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBHU0M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Feb 2023 15:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBHU0L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Feb 2023 15:26:11 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5486639CFC;
        Wed,  8 Feb 2023 12:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675887969; x=1707423969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1S/OSskZmAwmIGSRQH2mggp3Mf/j4uP40UTYr4GaC4=;
  b=Q/chbdhGVj7m5Qq0kuT8q3qGYrAQ36e65KSXjwJpZCszG8lb2Q0qDYgX
   9jcUl9MOzriegIJdff54kgqtn92V2NHmWNGxy9BoEQi4kavRrK0CmtvRd
   s9cDGOr2nYbW20iT5JqBuE2Y6l4O/J0xeiIzjQPuOu9is3G/ubJDiH4lh
   /IK0Jt5ukn8hQlH7oGH/TuHN4n5x1zRXQr0T3Dm5x85GOC+guPUDKSrKB
   11+yr/pBlYoDpeAq1KwLsUIPdVKI82zFkoESaWKg1TQrUwwJqDFPiDatn
   QA8bbZIsnFqnn+X/2LhkpSs/PKWY45vPwxVgq1kRlrf+sQXYrLLwgk1Lm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="329942483"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="329942483"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:26:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776182603"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776182603"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 12:26:07 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id D8824120D20;
        Wed,  8 Feb 2023 22:26:04 +0200 (EET)
Date:   Wed, 8 Feb 2023 22:26:04 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v4 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y+QFXGDUXEB4ablF@kekkonen.localdomain>
References: <20230208152807.3064242-1-sakari.ailus@linux.intel.com>
 <20230208152807.3064242-3-sakari.ailus@linux.intel.com>
 <Y+PROE+7o8yuoGB6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+PROE+7o8yuoGB6@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thanks for the review.

On Wed, Feb 08, 2023 at 06:43:36PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 08, 2023 at 05:28:01PM +0200, Sakari Ailus wrote:
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration. For now, only figure out where the descriptor is present in
> > order to allow adding information from it to related devices.
> 
> Nit-picks below that may be ignored. Up to you, guys.
> 
> ...
> 
> > +#define NO_CSI2_PORT (~1U)
> 
> A bit unclear why this value. Is it bitfield? Then GENMASK() would be better.
> Is it a plain value with a type limit? Then (UINT_MAX - 1) probably the best.

This value is used to signify that a port node isn't yet allocated for a
CSI-2 port. I can change this to UINT_MAX - 1.

> 
> ...
> 
> > +	ads->nodeptrs = (void *)(ads->nodes +
> > +				 ports_count * 2 + 1);
> 
> Now this fits one line.

Yes.

> 
> ...
> 
> > +	handle_refs = kcalloc(csi2_all.handle_count + 1, sizeof(*handle_refs),
> > +			      GFP_KERNEL);
> > +	if (!handle_refs) {
> > +		acpi_handle_debug(handle, "no memory for %zu handle refs\n",
> > +				  csi2_all.handle_count + 1);
> > +		return;
> > +	}
> 
> In a code above you used "1 + foo" approach if I'm not mistaken. Why here is
> the difference?

The last entry is a guardian (NULL handle). 1 + number of lanes is used
where the first lane is the clock lane.

> 
> ...
> 
> In some code comments which I removed before remarking you forgot the
> grammatical period.

Some comments aren't proper sentences. I'll see which could be improved by
adding a period.

-- 
Regards,

Sakari Ailus
