Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0072EAD98
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbhAEOou (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 09:44:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:42035 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbhAEOou (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 09:44:50 -0500
IronPort-SDR: 3Mr+wBXPmLDgN9wjKyn8HP2Khrq239eZmahAYePlmYnGiqSSNV3lZ9KOcTSyzh13WhbQRfH+ze
 uuKqsxQNZYuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="177214935"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="177214935"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:43:00 -0800
IronPort-SDR: uhjeaoOcMUJK1tKVMGlVbBf9DHk3DLD9PNv40IwVlaeVm4BS73iZ2rUpFTTWSidu/hUwexYFGv
 noGDwMdttgbg==
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="349883337"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 06:42:58 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kwnZ2-002Cxu-Mv; Tue, 05 Jan 2021 16:44:00 +0200
Date:   Tue, 5 Jan 2021 16:44:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rafael@kernel.org, bard.liao@intel.com
Subject: Re: [PATCH 1/2] Revert "device property: Keep secondary firmware
 node secondary by type"
Message-ID: <20210105144400.GM4077@smile.fi.intel.com>
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
 <20210105091146.25422-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105091146.25422-2-yung-chuan.liao@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 05, 2021 at 05:11:45PM +0800, Bard Liao wrote:
> While the commit d5dcce0c414f ("device property: Keep secondary firmware
> node secondary by type")
> describes everything correct in its commit message the change it made does
> the opposite and original commit c15e1bdda436 ("device property: Fix the
> secondary firmware node handling in set_primary_fwnode()") was fully
> correct. Thus, revert the former one here and improve documentation in
> the next patch.

Thanks for catching this!
Yes, my bad that I have misinterpreted Heikki's idea.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: d5dcce0c414f ("device property: Keep secondary firmware node secondary by type")
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 25e08e5f40bd..51b9545a050b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4433,7 +4433,7 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  		if (fwnode_is_primary(fn)) {
>  			dev->fwnode = fn->secondary;
>  			if (!(parent && fn == parent->fwnode))
> -				fn->secondary = ERR_PTR(-ENODEV);
> +				fn->secondary = NULL;
>  		} else {
>  			dev->fwnode = NULL;
>  		}
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


