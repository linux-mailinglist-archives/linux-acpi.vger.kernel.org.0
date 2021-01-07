Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E943B2ED17E
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 15:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbhAGONW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 09:13:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:3997 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbhAGONV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 09:13:21 -0500
IronPort-SDR: UwsH1x60SKyq4n0jBWw7J80qkJA4ziuKEdWQXWzMILNoq8vkHWLD3R3GxflxMoo85bAfkW5Gj+
 guFr1MrBD7NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="262198860"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="262198860"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:11:27 -0800
IronPort-SDR: hVZyhe5iC0dPVUEVIwinYLdVV7dZRGwMlg2rK9AgsUtSQDwavyivHZj3HsRWpSZs4+XSkZJmf/
 1B2Zjrq7krtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463046195"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 06:11:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:11:24 +0200
Date:   Thu, 7 Jan 2021 16:11:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        rafael@kernel.org, bard.liao@intel.com
Subject: Re: [PATCH 2/2] device property: add description of fwnode cases
Message-ID: <20210107141123.GI940479@kuha.fi.intel.com>
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
 <20210105091146.25422-3-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105091146.25422-3-yung-chuan.liao@linux.intel.com>
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
> 
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

thanks,

-- 
heikki
