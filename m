Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AA1296F6B
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463859AbgJWMfw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 08:35:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:50491 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373078AbgJWMfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 08:35:51 -0400
IronPort-SDR: 7BNfCakLMaEFZGcEC5Yf4najxrgrYw35gNWEi90LdH5zCqNyScSHccZuQa6PfelIkZqERYuIkD
 XD9qo1W2t5Xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167789278"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="167789278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 05:35:48 -0700
IronPort-SDR: yX3P1NLute2OCFJbEoV2QgCeJ3Khe2GYWQ1s2O/XgWeGaIkBy0U6njMb8AAT2MWShOKKjD80aN
 4NWoOOjn9brw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="423415808"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2020 05:35:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 23 Oct 2020 15:35:44 +0300
Date:   Fri, 23 Oct 2020 15:35:44 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v1 2/2] device property: Don't clear secondary pointer
 for shared primary firmware node
Message-ID: <20201023123544.GB614478@kuha.fi.intel.com>
References: <20201022184100.71659-1-andriy.shevchenko@linux.intel.com>
 <20201022184100.71659-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022184100.71659-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 22, 2020 at 09:41:00PM +0300, Andy Shevchenko wrote:
> It appears that firmware nodes can be shared between devices. In such case
> when a (child) device is about to be deleted, its firmware node may be shared
> and ACPI_COMPANION_SET(..., NULL) call for it breaks the secondary link
> of the shared primary firmware node.
> 
> In order to prevent that, check, if the device has a parent and parent's
> firmware node is shared with its child, and avoid crashing the link.
> 
> Fixes: c15e1bdda436 ("device property: Fix the secondary firmware node handling in set_primary_fwnode()")
> Reported-by: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 41feab679fa1..78114ddac755 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4264,6 +4264,7 @@ static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
>   */
>  void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  {
> +	struct device *parent = dev->parent;
>  	struct fwnode_handle *fn = dev->fwnode;
>  
>  	if (fwnode) {
> @@ -4278,7 +4279,8 @@ void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
>  	} else {
>  		if (fwnode_is_primary(fn)) {
>  			dev->fwnode = fn->secondary;
> -			fn->secondary = ERR_PTR(-ENODEV);
> +			if (!(parent && fn == parent->fwnode))
> +				fn->secondary = ERR_PTR(-ENODEV);
>  		} else {
>  			dev->fwnode = NULL;
>  		}
> -- 
> 2.28.0

-- 
heikki
