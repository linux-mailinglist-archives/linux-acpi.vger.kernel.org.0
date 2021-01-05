Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8622EAD9C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbhAEOpf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 09:45:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:5664 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbhAEOpf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 09:45:35 -0500
IronPort-SDR: 0wKfKPwklrv6LJ+gE8f9q8pdEn2VySIqPUUSzfkjwDZ5BkbEHKSobWQApwe1+6PlAQZ85n2WAP
 Ts02rEvvusbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="238665577"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="238665577"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:43:47 -0800
IronPort-SDR: isNkmx9pp854yTHO9IEOrwSKG0Lqa3pJgJ6TU3J/etfYbIPq1xqdtWv5NBApKeoEQEWoK5OWgx
 CWSeDxZR6Wgw==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421796225"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:43:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwnZj-002Cyn-Ff; Tue, 05 Jan 2021 16:44:43 +0200
Date:   Tue, 5 Jan 2021 16:44:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org, bard.liao@intel.com
Subject: Re: [PATCH 2/2] device property: add description of fwnode cases
Message-ID: <20210105144443.GN4077@smile.fi.intel.com>
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
 <20210105091146.25422-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105091146.25422-3-yung-chuan.liao@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 05, 2021 at 05:11:46PM +0800, Bard Liao wrote:
> There are only four valid fwnode cases which are
> - primary --> secondary --> -ENODEV
> - primary --> NULL
> - secondary --> -ENODEV
> - NULL
> 
> dev->fwnode should be converted between the 4 cases above no matter
> how/when set_primary_fwnode() and set_secondary_fwnode() are called.
> Describe it in the code so people will keep it in mind.

Thanks! It will help in the future to understand better this code.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/base/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 51b9545a050b..17eb14607074 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4414,6 +4414,12 @@ static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>   *
>   * Set the device's firmware node pointer to @fwnode, but if a secondary
>   * firmware node of the device is present, preserve it.
> + *
> + * Valid fwnode cases are:
> + *  - primary --> secondary --> -ENODEV
> + *  - primary --> NULL
> + *  - secondary --> -ENODEV
> + *  - NULL
>   */
>  void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  {
> @@ -4432,6 +4438,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  	} else {
>  		if (fwnode_is_primary(fn)) {
>  			dev->fwnode = fn->secondary;
> +			/* Set fn->secondary = NULL to keep fn as a primary fwnode */
>  			if (!(parent && fn == parent->fwnode))
>  				fn->secondary = NULL;
>  		} else {
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


