Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0CD536446
	for <lists+linux-acpi@lfdr.de>; Fri, 27 May 2022 16:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbiE0OhM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 May 2022 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiE0OhK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2022 10:37:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE922F01B
        for <linux-acpi@vger.kernel.org>; Fri, 27 May 2022 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653662228; x=1685198228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Uw7sT+nMEqMEJdR1SkoAILr7uR3w3r7JLzv+EExD1g=;
  b=e1BgsJ2ULBXADfQVm4dXJO9sESnI7GSEFrfYIAgJxOQ+JYlXN6WxiQFz
   WxGlueRV5QyOf97fgx3GR3ROy8GzFga4pQJyGdmUqZtB/CSn8O9lhaaPI
   ++LmWtqb8WEI6IQ3dwuRqz1+GCiD/O2BYP8p11vhx2+X6/uPclF/vkR2r
   CrSg7DSfHMOkV66zMtSO8wu8vVxJFGWdClKdAzKzYBGYyuQ4G9aZxeIj3
   lCSwon31PtO0kTmUwNpZaWW/h519rFHBGcwSJqsPRwvBxyUT/BuCpinx4
   yTzMzIklUzRLR7+Ig8weT5c80X7GwM2VHZBTfw68N1H+d0REo8zhu5eW0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="273308441"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="273308441"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:37:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="560796675"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:37:07 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 4B5892057F;
        Fri, 27 May 2022 17:37:05 +0300 (EEST)
Date:   Fri, 27 May 2022 17:37:05 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v3 4/8] ACPI: property: Move property ref argument
 parsing into a new function
Message-ID: <YpDiERZcjLzpo6cP@paasikivi.fi.intel.com>
References: <20220525130123.767410-1-sakari.ailus@linux.intel.com>
 <20220525130123.767410-5-sakari.ailus@linux.intel.com>
 <Yo5nWSQFqPxnIfqh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo5nWSQFqPxnIfqh@smile.fi.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Wed, May 25, 2022 at 08:28:57PM +0300, Andy Shevchenko wrote:
> On Wed, May 25, 2022 at 04:01:19PM +0300, Sakari Ailus wrote:
> > Split out property reference argument parsing out of the
> > __acpi_node_get_property_reference() function into a new one,
> > acpi_get_ref_args(). The new function will be needed also for parsing
> > string references soon.
> 
> ...
> 
> > +static int
> > +acpi_get_ref_args(struct fwnode_reference_args *args,
> 
> You can at least make these two on one line.

Agreed.

> 
> > +		  struct fwnode_handle *ref_fwnode,
> 
> Calling it fwnode would save a few lines of code even with your strictness
> of 80.

I'm just moving the code as much as possible as-is from elsewhere, thus
preferring to keep the naming.

> 
> > +		  const union acpi_object **element,
> > +		  const union acpi_object *end, size_t num_args)
> > +{
> > +	u32 nargs = 0, i;
> > +
> > +	/*
> > +	 * Find the referred data extension node under the
> > +	 * referred device node.
> > +	 */
> > +	for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
> > +	     (*element)++) {
> > +		const char *child_name = (*element)->string.pointer;
> 
> I believe this on one line is better to read.

I assume you mean the for loop.

I have to disargee. Everything doesn't automatically become better by
putting more stuff on the same line.

> 
> > +		ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
> > +							      child_name);
> 
> This too.

I think this would be affected less than the loop. 

-- 
Kind regards,

Sakari Ailus
