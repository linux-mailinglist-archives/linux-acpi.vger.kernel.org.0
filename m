Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CB681C8A
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 22:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjA3VSi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 16:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjA3VSh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 16:18:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89AB3608E;
        Mon, 30 Jan 2023 13:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675113516; x=1706649516;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qe+WmYJgRNGkTMxI0SNXZg1RIUYyuZL/j/KynyoRHnQ=;
  b=A8jbAVU1MLjLtnRrkP8QjwwrqApMnp2Uj4FrZs6pElIr2LUppHi9Zgdx
   4Pu5bL8Cr8ZYz8BZJd1091719f46N4BXv66P3/vK2zeFux7jqnnzh9Ush
   puperYYiKiNLg5Im1wNvis/bSDG+Ztx2WT4loFY1lrfWKZaATyhWh5lDm
   GZ3vn9SVEMofon0uO7PaDIoiqWgqTVHqOVxem1hpbJ/9Er5zzduyQ7Etb
   EBK+9bgTMVqKnhbS1Cdd1nWOeLf3jqV6Er7b+faKBC/gI4Idow8eQU/Jw
   OcPqieobkU7fRgVmcTj280opYk3c1I/Gj9IjsAoL/IzQtywKYPkQTHnNe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327695641"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327695641"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:18:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="788167665"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="788167665"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:18:33 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id C3FC21202B0;
        Mon, 30 Jan 2023 23:18:30 +0200 (EET)
Date:   Mon, 30 Jan 2023 23:18:30 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v3 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y9g0JvBWvn9Rsi7Q@kekkonen.localdomain>
References: <20230125224101.401285-1-sakari.ailus@linux.intel.com>
 <20230125224101.401285-3-sakari.ailus@linux.intel.com>
 <Y9Oip7cLqWgdzKry@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Oip7cLqWgdzKry@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

Thank you for the review.

On Fri, Jan 27, 2023 at 12:08:39PM +0200, Andy Shevchenko wrote:
> On Thu, Jan 26, 2023 at 12:40:55AM +0200, Sakari Ailus wrote:
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration. For now, only figure out where the descriptor is present in
> > order to allow adding information from it to related devices.
> 
> ...
> 
> > +	if (status != AE_OK) {
> 
> ACPI_FAILURE()

Yes.

> 
> > +		acpi_handle_warn(inst_context->handle,
> > +				 "cannot get handle for %s\n",
> > +				 csi2->resource_source.string_ptr);
> > +		return AE_OK;
> > +	}
> 
> ...
> 
> > +	struct scan_check_crs_csi2_context inst_context = {
> > +		.handle = handle,
> > +		.res_list = LIST_HEAD_INIT(inst_context.res_list),
> > +	};
> > +	struct list_head *list = context;
> > +	struct crs_csi2 *csi2;
> 
> > +	INIT_LIST_HEAD(&inst_context.res_list);
> 
> Do you still need this?

Oops. Forgot to remove it, I'll do in v4.

> 
> ...
> 
> > +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> > +			    scan_check_crs_csi2_instance, &inst_context);
> > +
> > +	if (list_empty(&inst_context.res_list))
> > +		return AE_OK;
> 
> I'm wondering if you can utilize acpi_dev_get_resources().

We don't have an acpi_device yet. I'd rather keep scanning for _CRS CSI2
resources here, as we'd otherwise have to split creating acpi_device's and
registering them into two.

I'd say if someone had implemented this like that, I'd ask them to change
it.

> 
> ...
> 
> > +	/* Collect the devices that have a _CRS CSI-2 resource */
> > +	acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, ACPI_UINT32_MAX,
> 
> Other serial buses limit the DEPTH by 32, why do we need more here?

I'm using the same value as for scanning devices to be added. Effectively
this is not a practical limit but it doesn't need to be.

> 
> > +			    scan_check_crs_csi2, NULL, &crs_csi2_handles, NULL);
> 
> ...
> 
> > +	sort(handle_refs, handle_count, sizeof(*handle_refs), crs_handle_cmp,
> > +	     NULL);
> 
> A single line?

Can do...

> 
> ...
> 
> > +		if (check_mul_overflow(sizeof(*ads->ports) +
> > +				       sizeof(*ads->nodes) * 2 +
> > +				       sizeof(*ads->nodeptrs) * 2,
> > +				       (size_t)this_count, &alloc_size) ||
> 
> So, now you know why this_count can't be type of size_t?

Forgot to change this one, thanks!

> 
> > +		    check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
> > +				       sizeof(*ads->nodeptrs) * 2,
> > +				       alloc_size, &alloc_size)) {
> > +			acpi_handle_warn(handle, "too many handles (%u)",
> > +					 this_count);
> > +			continue;
> > +		}
> 

-- 
Kind regards,

Sakari Ailus
