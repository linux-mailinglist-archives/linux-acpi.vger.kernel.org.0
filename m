Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C5F6CC64D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 17:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjC1P3i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjC1P3X (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 11:29:23 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E8FF03;
        Tue, 28 Mar 2023 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680017290; x=1711553290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rWzmYaZOEqfDUK9iwpHFpSX6GO5J3KqMZk9wrDzikz4=;
  b=XZ5CDz27XSFOA1Ikg2JoG73FO5HnL04WGGLFZyh7k+2+4VkMB0Bigq3D
   X8fKaBv2YNebEHawqxw5IjLZhzofYFA0uQxKVPAsYNTGNe4PqK2/W16R1
   Z52mkhYJKOzunbtUiD6tPEnwXqfa2mgzEW0pG/1I/guaJaD0Fj7/FVUfN
   NIYlzB3zVJofBZkaweAqPVoA+0aRoCADb/OF2gTf3eaNZBMlQazs2BfY/
   FkBEBUNfiZwsQ8K2zV0ur5B2PpRAI/hO+8Q5zBh5tde0owzdA8jQ34vWl
   Q2JB26mJP/u2+H5aRvUEOoELvW48TiekxhrmPmDKydS9pmWNZNq6FeAnf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324495848"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="324495848"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="929954251"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="929954251"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:27:12 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id C017411F937;
        Tue, 28 Mar 2023 18:27:09 +0300 (EEST)
Date:   Tue, 28 Mar 2023 18:27:09 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZCMHTZgXnLCWjCje@kekkonen.localdomain>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
 <ZCMDyVoFWizx+tOp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCMDyVoFWizx+tOp@smile.fi.intel.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thank you for the review.

On Tue, Mar 28, 2023 at 06:12:09PM +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 01:12:56PM +0300, Sakari Ailus wrote:
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration, associate it with appropriate devices and allocate memory for
> > software nodes needed to create a DT-like data structure for drivers.
> 
> ...
> 
> > +struct acpi_scan_context {
> > +	struct acpi_device *device;
> > +	struct list_head postponed_head;
> 
> Make it first?

Soon this isn't the only list here, only one of them can be first. But I
guess there is some benefit nonetheless.

> 
> > +	struct acpi_scan_context_csi2 csi2;
> > +};
> 
> ...
> 
> > +void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx)
> > +{
> > +	struct scan_check_crs_csi2_context inst_context = {
> > +		.handle = handle,
> > +		.res_head = LIST_HEAD_INIT(inst_context.res_head),
> > +	};
> > +	struct crs_csi2 *csi2;
> > +
> > +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> > +			    scan_check_crs_csi2_instance, &inst_context);
> > +
> > +	if (list_empty(&inst_context.res_head))
> > +		return;
> > +
> > +	/*
> > +	 * Found entry, so allocate memory for it, fill it and add it to the
> > +	 * list.
> > +	 */
> > +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> > +	if (!csi2)
> 
> Who is going to release resources allocated in the callback above?

This is done by crs_csi2_release(), called from acpi_bus_scan_crs_csi2().

> 
> > +		return; /* There's nothing we really can do about this. */
> > +
> > +	csi2->handle = handle;
> > +	list_replace(&inst_context.res_head, &csi2->buses);
> > +	list_add(&csi2->list, &ctx->csi2.crs_csi2_head);
> > +
> > +	/* This handle plus remote handles in _CRS CSI2 resource descriptors */
> > +	ctx->csi2.handle_count += 1 + inst_context.handle_count;
> > +}
> 
> ...
> 
> > +	/*
> > +	 * Allocate memory for ports, node pointers (number of nodes +
> > +	 * 1 (guardian), nodes (root + number of ports * 2 (for for
> > +	 * every port there is an endpoint)).
> > +	 */
> 
> for for ?
> 
> I am a bit lost here. Can you put the above in more mathematical language?

The first "for" is in the sense of "because". I can replace it if you think
it'd be clearer that way. 

There is simply a single endpoint for every port, as DisCo for Imaging does
not support the notion of endpoints (where you could have multiple
connections with more endpoints).

-- 
Kind regards,

Sakari Ailus
