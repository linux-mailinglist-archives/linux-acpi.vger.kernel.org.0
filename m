Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDACF6780F3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 17:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAWQIL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 11:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjAWQIK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 11:08:10 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772BA23D9F;
        Mon, 23 Jan 2023 08:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674490089; x=1706026089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gm/h4JqSPjmuC0rKybWIYbjPhlw06c8HPm9jqSJ6Yd8=;
  b=MibJlaoCSgoS5kVsDq2iuM1oqBEVBoOUlyDpE+iSJ08MAJODqKMFUf5D
   EPWiRTSvhrSMBDFYK/o5ACvFBPiyNagNYqouq8lOKh7i0XFNZ3L/eqEc8
   OqBsUUzKbh2wmPOutm/vI77csuqZdfYObhGYNXhpZoM3kXPRFf4kD01N1
   LWzcPkxCamhwCa9z/SJE+FrDq8yJ1OV5cXAsfE23HPkhNH4+2OrIuJZzo
   6pNMioXW6M9LzZkCiwhH95nP/uQdRxLx+juB/lGiX7vNAe9AU/ahEg7Oh
   Q9hNAHcpbOf9lyvYQHmNOywigQdq+GdWixjNthnUSPj41n3SpLaffPdqd
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328163400"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328163400"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:07:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="835608238"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="835608238"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 08:07:46 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 77D2211F782;
        Mon, 23 Jan 2023 18:07:43 +0200 (EET)
Date:   Mon, 23 Jan 2023 18:07:43 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y86wzwrlvro3RFto@kekkonen.localdomain>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-3-sakari.ailus@linux.intel.com>
 <Y86inXQ+nEoFiosr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86inXQ+nEoFiosr@smile.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Mon, Jan 23, 2023 at 05:07:09PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 03:46:11PM +0200, Sakari Ailus wrote:
> > Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> > configuration. For now, only figure out where the descriptor is present in
> > order to allow adding information from it to related devices.
> 
> ...
> 
> > +	memcpy(inst->remote_name, csi2->resource_source.string_ptr,
> > +	       csi2->resource_source.string_length);
> 
> Why don't we use strscpy()? Is it really strings? Or is it some abuse of
> the ACPI object type?

I didn't find a guarantee it would be nil terminated. Albeit I'm fine
switching to strscpy() if there's such a guarantee.

> 
> ...
> 
> > +static acpi_status scan_check_crs_csi2(acpi_handle handle, u32 nesting_level,
> > +				       void *context, void **ret)
> > +{
> > +	struct scan_check_crs_csi2_context inst_context = {
> > +		.handle = handle,
> > +		.res_list = LIST_HEAD_INIT(inst_context.res_list),
> > +	};
> > +	struct list_head *list = context;
> > +	struct crs_csi2 *csi2;
> 
> > +	INIT_LIST_HEAD(&inst_context.res_list);
> 
> Why do you need this? I don't see that variable is static...

Ah. It's not static. But this is a leftover from development time and can
be removed, it's initialised in variable declaration.

> 
> > +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> > +			    scan_check_crs_csi2_instance, &inst_context);
> > +
> > +	if (list_empty(&inst_context.res_list))
> > +		return AE_OK;
> > +
> > +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> > +	if (!csi2)
> > +		return AE_OK;
> > +
> > +	csi2->handle = handle;
> > +	list_replace(&inst_context.res_list, &csi2->buses);
> > +	list_add(&csi2->list, list);
> 
> Hmm... Can list_swap() be used here?

We're replacing an entry in a list and then adding an entry to another. How
would you use list_swap() here?

> 
> > +	return AE_OK;
> > +}
> 
> ...
> 
> > +	/*
> > +	 * Figure out how much temporary storage we need for counting
> > +	 * connections in each device.
> > +	 */
> > +	list_for_each_entry(csi2, &crs_csi2_handles, list) {
> > +		struct crs_csi2_instance *inst;
> > +
> > +		handle_count++;
> 
> > +		list_for_each_entry(inst, &csi2->buses, list)
> > +			handle_count++;
> 
> list_count_nodes()?

Are you suggesting adding a new list API function or using one that's not
in the linux-acpi/testing branch yet?

> 
> > +	}
> 
> ...
> 
> > +	sort(handle_refs, handle_count, sizeof(*handle_refs), crs_handle_cmp,
> > +	     NULL);
> 
> Yes, I would leave it on one line.

Works for me.

> 
> ...
> 
> > +		if (check_mul_overflow(sizeof(*ads->ports) +
> > +				       sizeof(*ads->nodes) * 2 +
> > +				       sizeof(*ads->nodeptrs) * 2,
> > +				       (size_t)this_count, &alloc_size) ||
> 
> Can this_count be of size_t type from the beginning?

I think so.

> 
> > +		    check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
> > +				       sizeof(*ads->nodeptrs) * 2,
> > +				       alloc_size, &alloc_size)) {
> > +			acpi_handle_warn(handle, "too many handles (%u)",
> > +					 this_count);
> > +			continue;
> > +		}
> 
> ...
> 
> > +		ads->nodeptrs = (void *)(ads->nodes +
> > +					 this_count * 2 + 1);
> 
> Why this is not on one line? (I have got less than 80).

Probably there was more on that line but I forgot to unwrap when removing
whatever was there. I'll address this for v3.

-- 
Kind regards,

Sakari Ailus
