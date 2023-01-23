Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE54677EBD
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjAWPHv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAWPHu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:07:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1391116E;
        Mon, 23 Jan 2023 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674486468; x=1706022468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzO2n8wSt+6WPLw+7OG0XeAurCZVYHzRVWciYTKK4pg=;
  b=NhF3P+x+betDiAkIQKDiP7JwxgOz7YAUdNX7GVmL137UCkcli6xY3bF5
   N+SqRzEpGoZ1JQSFj+UeuoXyCnU3/E24iG0201vKKdt1qNjRnY9dWPYOK
   DtMVOkFHxL9YRsb0/00KtOj8EM2pr9y+tJYXlz04vndYwFcTKnCs3+AR9
   sQ/HVMCJGoVswr0I0kVv5tFJdoyzRQYQnFR+RNKGi+F3cuzJ5/naGt+ID
   Hpfn4zsfMIFo+245a8ytH9riQqYMf6txzlGKaAdtzYjxb4JOfpmkCI/CI
   hNO04wR98wvLdfkOCx++ZjG3kbzO2xn07DIxZy7gr7xbuDMkSffBuJsBJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="353324637"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="353324637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="804168116"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="804168116"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jan 2023 07:07:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJyPd-00DnDu-1F;
        Mon, 23 Jan 2023 17:07:09 +0200
Date:   Mon, 23 Jan 2023 17:07:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 2/8] ACPI: property: Parse _CRS CSI-2 descriptor
Message-ID: <Y86inXQ+nEoFiosr@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-3-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134617.265382-3-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 03:46:11PM +0200, Sakari Ailus wrote:
> Parse newly added ACPI _CRS CSI-2 descriptor for CSI-2 and camera
> configuration. For now, only figure out where the descriptor is present in
> order to allow adding information from it to related devices.

...

> +	memcpy(inst->remote_name, csi2->resource_source.string_ptr,
> +	       csi2->resource_source.string_length);

Why don't we use strscpy()? Is it really strings? Or is it some abuse of
the ACPI object type?

...

> +static acpi_status scan_check_crs_csi2(acpi_handle handle, u32 nesting_level,
> +				       void *context, void **ret)
> +{
> +	struct scan_check_crs_csi2_context inst_context = {
> +		.handle = handle,
> +		.res_list = LIST_HEAD_INIT(inst_context.res_list),
> +	};
> +	struct list_head *list = context;
> +	struct crs_csi2 *csi2;

> +	INIT_LIST_HEAD(&inst_context.res_list);

Why do you need this? I don't see that variable is static...

> +	acpi_walk_resources(handle, METHOD_NAME__CRS,
> +			    scan_check_crs_csi2_instance, &inst_context);
> +
> +	if (list_empty(&inst_context.res_list))
> +		return AE_OK;
> +
> +	csi2 = kmalloc(sizeof(*csi2), GFP_KERNEL);
> +	if (!csi2)
> +		return AE_OK;
> +
> +	csi2->handle = handle;
> +	list_replace(&inst_context.res_list, &csi2->buses);
> +	list_add(&csi2->list, list);

Hmm... Can list_swap() be used here?

> +	return AE_OK;
> +}

...

> +	/*
> +	 * Figure out how much temporary storage we need for counting
> +	 * connections in each device.
> +	 */
> +	list_for_each_entry(csi2, &crs_csi2_handles, list) {
> +		struct crs_csi2_instance *inst;
> +
> +		handle_count++;

> +		list_for_each_entry(inst, &csi2->buses, list)
> +			handle_count++;

list_count_nodes()?

> +	}

...

> +	sort(handle_refs, handle_count, sizeof(*handle_refs), crs_handle_cmp,
> +	     NULL);

Yes, I would leave it on one line.

...

> +		if (check_mul_overflow(sizeof(*ads->ports) +
> +				       sizeof(*ads->nodes) * 2 +
> +				       sizeof(*ads->nodeptrs) * 2,
> +				       (size_t)this_count, &alloc_size) ||

Can this_count be of size_t type from the beginning?

> +		    check_add_overflow(sizeof(*ads) + sizeof(*ads->nodes) +
> +				       sizeof(*ads->nodeptrs) * 2,
> +				       alloc_size, &alloc_size)) {
> +			acpi_handle_warn(handle, "too many handles (%u)",
> +					 this_count);
> +			continue;
> +		}

...

> +		ads->nodeptrs = (void *)(ads->nodes +
> +					 this_count * 2 + 1);

Why this is not on one line? (I have got less than 80).

-- 
With Best Regards,
Andy Shevchenko


