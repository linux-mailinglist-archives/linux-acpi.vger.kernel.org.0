Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66DF444685
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhKCRFC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:05:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:41107 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhKCRFB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:05:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="218740619"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="218740619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:01:08 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="560943923"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:01:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miJay-003Jxx-Pp;
        Wed, 03 Nov 2021 18:58:40 +0200
Date:   Wed, 3 Nov 2021 18:58:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>, rafael@kernel.org,
        mika.westerberg@linux.intel.com
Subject: Re: [PATCH 1/3] ACPI: Make acpi_fwnode_handle safer
Message-ID: <YYK/wFZLKVjpnV96@smile.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-2-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103133406.659542-2-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 03:34:04PM +0200, Sakari Ailus wrote:
> Check that the fwnode argument passed to acpi_fwnode_handle is non-NULL,

acpi_fwnode_handle()

> and return NULL if it is, otherwise the fwnode. Thus the caller doesn't
> have to ensure the argument is a valid non-NULL fwnode.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Cc: stable@vger.kernel.org # v5.15 and up
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/acpi/acpi_bus.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 53b6e9f9de7b4..c34d94521d40c 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -445,7 +445,7 @@ static inline bool acpi_data_node_match(const struct fwnode_handle *fwnode,
>  
>  static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
>  {
> -	return &adev->fwnode;
> +	return adev ? &adev->fwnode : NULL;
>  }
>  
>  static inline void *acpi_driver_data(struct acpi_device *d)
> -- 
> 2.30.2
> 
> 

-- 
With Best Regards,
Andy Shevchenko


