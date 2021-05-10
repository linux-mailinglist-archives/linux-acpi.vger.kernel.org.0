Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA70378E0D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 15:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhEJNDR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 09:03:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:30707 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243429AbhEJMTj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 08:19:39 -0400
IronPort-SDR: Evd8opFPGzhCVFT1ay/CUKsm3Tu+v47ZN2tc3UMlS7kshakAmpVo4VxpOkgu1dZQ+THJzUITPC
 glLbxSgFpqEg==
X-IronPort-AV: E=McAfee;i="6200,9189,9979"; a="260444372"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="260444372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:18:24 -0700
IronPort-SDR: IRU+4kJB9UCczVymR3GBVIkbepiApWDkwC6FafTPRDfJ6V8R8VbqaIbgHlKguFrqphC+dNLBXo
 BWg7KDYnXWMg==
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="468101379"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 05:18:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lg4rc-00BAFN-NV; Mon, 10 May 2021 15:18:20 +0300
Date:   Mon, 10 May 2021 15:18:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ACPI: scan: Fix a memory leak in an error handling path
Message-ID: <YJkkjI6+k34ZoQ69@smile.fi.intel.com>
References: <63bf4e87eb42fa3fff2cd87eb605ebcc01f4b2f7.1620458525.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63bf4e87eb42fa3fff2cd87eb605ebcc01f4b2f7.1620458525.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 08, 2021 at 09:23:09AM +0200, Christophe JAILLET wrote:
> If 'acpi_device_set_name()' fails, we must free
> 'acpi_device_bus_id->bus_id' or there is a (potential) memory leak.

Good catch!
I guess I have lost it somewhere in the middle of developing the mentioned fix.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Fixes: eb50aaf960e3 ("ACPI: scan: Use unique number for instance_no")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index a22778e880c2..651a431e2bbf 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -700,6 +700,7 @@ int acpi_device_add(struct acpi_device *device,
>  
>  		result = acpi_device_set_name(device, acpi_device_bus_id);
>  		if (result) {
> +			kfree_const(acpi_device_bus_id->bus_id);
>  			kfree(acpi_device_bus_id);
>  			goto err_unlock;
>  		}
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


