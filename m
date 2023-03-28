Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16856CC5B8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 17:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjC1PRD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjC1PQs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 11:16:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86B10A80;
        Tue, 28 Mar 2023 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680016564; x=1711552564;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vb59PNyUVqWjggbHwzdHKWwpkLGvflNshiCzVN0hkbE=;
  b=ZY1tca7oBmAqqFVp3SzfAv/qSR5FOg+QMd9cXbF3jJ8+B3zxhRw2S/6p
   WWep2s7IC8/hp+OfQlFM8JZnqnZPcoS/t2G4E9vZ1yZD1KWh65pVMNfZP
   2PlwF61OolStTA1KuHcB+kfM7su9mdrJVHhbgrUmWDT3vcdmOogTmUrkf
   mJ1lpAbs4QfjjxEZ7kHdY2E5MdxRtyBxF0hZBkJ4G77iwgjiCAyl59A1a
   iWwcVQWReRSkp6c3SJlJQqgVla00NuwEN1CSsSTeh7TeMOeciykWBqeiZ
   opWxNgEBcNTEmynA0nWz/sgrA2BDfjJAAWbcco3+Fd4V2Hb02Ca9Ylz9y
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="405533633"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="405533633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 08:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="716516123"
X-IronPort-AV: E=Sophos;i="5.98,297,1673942400"; 
   d="scan'208";a="716516123"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 28 Mar 2023 08:12:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1phAzZ-009fhT-1h;
        Tue, 28 Mar 2023 18:12:09 +0300
Date:   Tue, 28 Mar 2023 18:12:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v7 03/10] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <ZCMDyVoFWizx+tOp@smile.fi.intel.com>
References: <20230328101303.1458570-1-sakari.ailus@linux.intel.com>
 <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328101303.1458570-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 28, 2023 at 01:12:56PM +0300, Sakari Ailus wrote:
> Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> configuration, associate it with appropriate devices and allocate memory for
> software nodes needed to create a DT-like data structure for drivers.

...

> +struct acpi_scan_context {
> +	struct acpi_device *device;
> +	struct list_head postponed_head;

Make it first?

> +	struct acpi_scan_context_csi2 csi2;
> +};

...

> +void acpi_bus_scan_check_crs_csi2(acpi_handle handle, struct acpi_scan_context *ctx)
> +{
> +	struct scan_check_crs_csi2_context inst_context = {
> +		.handle = handle,
> +		.res_head = LIST_HEAD_INIT(inst_context.res_head),
> +	};
> +	struct crs_csi2 *csi2;
> +
> +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> +			    scan_check_crs_csi2_instance, &inst_context);
> +
> +	if (list_empty(&inst_context.res_head))
> +		return;
> +
> +	/*
> +	 * Found entry, so allocate memory for it, fill it and add it to the
> +	 * list.
> +	 */
> +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> +	if (!csi2)

Who is going to release resources allocated in the callback above?

> +		return; /* There's nothing we really can do about this. */
> +
> +	csi2->handle = handle;
> +	list_replace(&inst_context.res_head, &csi2->buses);
> +	list_add(&csi2->list, &ctx->csi2.crs_csi2_head);
> +
> +	/* This handle plus remote handles in _CRS CSI2 resource descriptors */
> +	ctx->csi2.handle_count += 1 + inst_context.handle_count;
> +}

...

> +	/*
> +	 * Allocate memory for ports, node pointers (number of nodes +
> +	 * 1 (guardian), nodes (root + number of ports * 2 (for for
> +	 * every port there is an endpoint)).
> +	 */

for for ?

I am a bit lost here. Can you put the above in more mathematical language?

> +	overflow = check_mul_overflow(sizeof(*ads->ports) +
> +				      sizeof(*ads->nodes) * 2 +
> +				      sizeof(*ads->nodeptrs) * 2,
> +				      ports_count, &alloc_size);
> +	overflow = overflow ||
> +		   check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
> +				      sizeof(*ads->nodeptrs) * 2,
> +				      alloc_size, &alloc_size);
> +	if (overflow) {
> +		acpi_handle_warn(handle,
> +				 "too many _CRS CSI2 resource handles (%zu)",
> +				 ports_count);
> +		return;
> +	}


-- 
With Best Regards,
Andy Shevchenko


