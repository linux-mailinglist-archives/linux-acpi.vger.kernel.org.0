Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFB867E111
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jan 2023 11:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjA0KIp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Jan 2023 05:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjA0KIo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jan 2023 05:08:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA9B3EC40;
        Fri, 27 Jan 2023 02:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674814123; x=1706350123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f67KzVxHpdXmqPA8CszlUnWN06gxy+VJ0oxvgBWzgFw=;
  b=KiNugtqFm0hO1elXkrEfsTzpLczGu6Dw7qu8JnuVdBwGAGI/RQQ3Cd02
   zyGe+jKtTToFCgTBP146G/IYMCiQVLgaOK+xO+F6UkRXijYEH7qySS0gH
   8s5PTT+leZmH0af9RsVonsw4JOolf3DWEDR894mYQxegv+EOapqZgnDGY
   JDVddKvIRFob5AToCpCEUlgTKe+03lvMBKUMdP6uyNTBiYYTJkno7pRKm
   nKNlAeKSfPuZcnBfBaa5Tpf9TpswsuIraO/X9RoQcIJKOJsKgFIicKXTT
   koAk37WctvIg9NG6bkfOsou/zVtGCmUHeizrePUdMKLiapUMTk1XbmC9o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="329183496"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="329183496"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 02:08:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="726647928"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; 
   d="scan'208";a="726647928"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jan 2023 02:08:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pLLey-00FuNs-0e;
        Fri, 27 Jan 2023 12:08:40 +0200
Date:   Fri, 27 Jan 2023 12:08:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y9Oip7cLqWgdzKry@smile.fi.intel.com>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125224101.401285-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 26, 2023 at 12:40:55AM +0200, Sakari Ailus wrote:
> Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> configuration. For now, only figure out where the descriptor is present in
> order to allow adding information from it to related devices.

...

> +	if (status != AE_OK) {

ACPI_FAILURE()

> +		acpi_handle_warn(inst_context->handle,
> +				 "cannot get handle for %s\n",
> +				 csi2->resource_source.string_ptr);
> +		return AE_OK;
> +	}

...

> +	struct scan_check_crs_csi2_context inst_context = {
> +		.handle = handle,
> +		.res_list = LIST_HEAD_INIT(inst_context.res_list),
> +	};
> +	struct list_head *list = context;
> +	struct crs_csi2 *csi2;

> +	INIT_LIST_HEAD(&inst_context.res_list);

Do you still need this?

...

> +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> +			    scan_check_crs_csi2_instance, &inst_context);
> +
> +	if (list_empty(&inst_context.res_list))
> +		return AE_OK;

I'm wondering if you can utilize acpi_dev_get_resources().

...

> +	/* Collect the devices that have a _CRS CSI-2 resource */
> +	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,

Other serial buses limit the DEPTH by 32, why do we need more here?

> +			    scan_check_crs_csi2, NULL, &crs_csi2_handles, NULL);

...

> +	sort(handle_refs, handle_count, sizeof(*handle_refs), crs_handle_cmp,
> +	     NULL);

A single line?

...

> +		if (check_mul_overflow(sizeof(*ads->ports) +
> +				       sizeof(*ads->nodes) * 2 +
> +				       sizeof(*ads->nodeptrs) * 2,
> +				       (size_t)this_count, &alloc_size) ||

So, now you know why this_count can't be type of size_t?

> +		    check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
> +				       sizeof(*ads->nodeptrs) * 2,
> +				       alloc_size, &alloc_size)) {
> +			acpi_handle_warn(handle, "too many handles (%u)",
> +					 this_count);
> +			continue;
> +		}

-- 
With Best Regards,
Andy Shevchenko


