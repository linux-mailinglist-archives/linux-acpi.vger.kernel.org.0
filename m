Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1853444468A
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhKCRF4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:05:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:24543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhKCRF4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:05:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="230268875"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="230268875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:02:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="468174212"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:02:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miJeV-003K0s-9E;
        Wed, 03 Nov 2021 19:02:19 +0200
Date:   Wed, 3 Nov 2021 19:02:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH 3/3] ACPI: Make acpi_node_get_parent() local
Message-ID: <YYLAm1X+lFykwTSg@smile.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-4-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103133406.659542-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 03:34:06PM +0200, Sakari Ailus wrote:
> acpi_node_get_parent() isn't used outside drivers/acpi/property.c. Make it
> local.

Always in favour for such patches!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 3 ++-
>  include/linux/acpi.h    | 7 -------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 7403ee2816eb8..49301d1bba4ff 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1084,7 +1084,8 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>   * Returns parent node of an ACPI device or data firmware node or %NULL if
>   * not available.
>   */
> -struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode)
> +static struct fwnode_handle *
> +acpi_node_get_parent(const struct fwnode_handle *fwnode)
>  {
>  	if (is_acpi_data_node(fwnode)) {
>  		/* All data nodes have parent pointer so just return that */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 375715b0535fb..c65a754b1db53 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1168,7 +1168,6 @@ int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
>  
>  struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  					    struct fwnode_handle *child);
> -struct fwnode_handle *acpi_node_get_parent(const struct fwnode_handle *fwnode);
>  
>  struct acpi_probe_entry;
>  typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
> @@ -1273,12 +1272,6 @@ acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>  	return NULL;
>  }
>  
> -static inline struct fwnode_handle *
> -acpi_node_get_parent(const struct fwnode_handle *fwnode)
> -{
> -	return NULL;
> -}
> -
>  static inline struct fwnode_handle *
>  acpi_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
>  			     struct fwnode_handle *prev)
> -- 
> 2.30.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


