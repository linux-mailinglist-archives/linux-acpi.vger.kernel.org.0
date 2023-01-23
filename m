Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406F677E65
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 15:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjAWOvj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 09:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjAWOvi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 09:51:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DAF1027A;
        Mon, 23 Jan 2023 06:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674485497; x=1706021497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBFVwFnSB+4lhqJQw2QnUrOxODVr0i8sRcjTBzPVaPo=;
  b=UFg2ufSIoyiFgdBjdAJ5aXO66/d6jUxWLgieM7BXiM8W4KMJnOHC76xP
   M30m6PSG6Y3ltQINMpXx5Q/tdOTVwKsqmi3qDeJ+8uMw8Qg0xaFsCkkHD
   ewxjCUuY8lJzoBM6hoINgvDSytacT3fOSdmNf5bQ6gFjZEO8uY0fAv/HY
   7OMo9a5dFo6FGUY9wJCAtu8ADOt2WcW5llHJV9q4y4mfvEyRAQKCAFkwa
   RyS0GTlzi38IcoxVN2XVYSHn7/hlQlanxH7dJc46K+7QX42TB3qMuU0z1
   lcT+vbQw21bbyAySwrozsnsVyVFeorsnOhZUuCh85gVBV69fP9wTxSYHC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="327313954"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="327313954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 06:51:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10598"; a="654980482"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="654980482"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 23 Jan 2023 06:51:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJyAX-00DmrJ-1z;
        Mon, 23 Jan 2023 16:51:33 +0200
Date:   Mon, 23 Jan 2023 16:51:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 1/8] ACPI: property: Parse data node string references
 in properties
Message-ID: <Y86e9YeHXrNLfwHY@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134617.265382-2-sakari.ailus@linux.intel.com>
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

On Mon, Jan 23, 2023 at 03:46:10PM +0200, Sakari Ailus wrote:
> Add support for parsing property references using strings, besides
> reference objects that were previously supported. This allows also
> referencing data nodes which was not possible with reference objects.
> 
> Also add pr_fmt() macro to prefix printouts.
> 
> While at it, update copyright.

...

> - * Copyright (C) 2014, Intel Corporation
> + * Copyright (C) 2014--2023, Intel Corporation

Isn't one dash enough? 

$ git grep -n 'opyright.*[0-9]--[0-9]' | wc -l
37

$ git grep -n 'opyright.*[0-9]-[0-9]' | wc -l
15064


>   * All rights reserved.
>   *
>   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
>   *          Darren Hart <dvhart@linux.intel.com>
>   *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> + *	    Sakari Ailus <sakari.ailus@linux.intel.com>

Seems wrong indentation in comparison to the others.

>   */

...

> +static struct fwnode_handle *
> +acpi_parse_string_ref(const struct fwnode_handle *fwnode, const char *refstring)
> +{
> +	acpi_handle scope, handle;
> +	struct acpi_data_node *dn;
> +	struct acpi_device *device;
> +	acpi_status status;
> +
> +	if (is_acpi_device_node(fwnode)) {

> +		scope = to_acpi_device_node(fwnode)->handle;

Interestingly that we have a helper for this -- ACPI_HANDLE_FWNODE()...

> +	} else if (is_acpi_data_node(fwnode)) {

> +		scope = to_acpi_data_node(fwnode)->handle;

...but not for this.

> +	} else {
> +		pr_err("bad node type for node %pfw\n", fwnode);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	status = acpi_get_handle(scope, refstring, &handle);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_debug(scope, "can't get handle for %s", refstring);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	device = acpi_fetch_acpi_dev(handle);
> +	if (device)
> +		return acpi_fwnode_handle(device);
> +
> +	status = acpi_get_data_full(handle, acpi_nondev_subnode_tag,
> +				    (void **)&dn, NULL);
> +	if (ACPI_FAILURE(status) || !dn) {
> +		acpi_handle_debug(handle, "can't find subnode");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return &dn->fwnode;
> +}

-- 
With Best Regards,
Andy Shevchenko


