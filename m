Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357E52ED128
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbhAGNtD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 08:49:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:46957 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbhAGNtC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 08:49:02 -0500
IronPort-SDR: RWMivdGxogsx/I0xdvXe6DnN44zHxrjP+1DlMX2Yc4ePhln2PWlJkgHgD5SK6WxT0IlTs6wqbf
 JLDlj2kiPUwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="177523629"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="177523629"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 05:47:16 -0800
IronPort-SDR: DmSr++MCQOciaw3XCdbUHzKV7I11iN0D1C6+9+HsH7ssE3tPjI8vZT/lmu9GMViC5PbLCPxrgr
 mWkFH1+k9EaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463041205"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 05:47:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 15:47:09 +0200
Date:   Thu, 7 Jan 2021 15:47:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, mchehab@kernel.org,
        sergey.senozhatsky@gmail.com, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        hverkuil-cisco@xs4all.nl, m.felsch@pengutronix.de,
        niklas.soderlund+renesas@ragnatech.se,
        prabhakar.mahadev-lad.rj@bp.renesas.com, slongerbeam@gmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 03/15] device property: Return true in
 fwnode_device_is_available for NULL ops
Message-ID: <20210107134709.GD940479@kuha.fi.intel.com>
References: <20210107132838.396641-1-djrscally@gmail.com>
 <20210107132838.396641-4-djrscally@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107132838.396641-4-djrscally@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 07, 2021 at 01:28:26PM +0000, Daniel Scally wrote:
> Some types of fwnode_handle do not implement the device_is_available()
> check, such as those created by software_nodes. There isn't really a
> meaningful way to check for the availability of a device that doesn't
> actually exist, so if the check isn't implemented just assume that the
> "device" is present.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Daniel Scally <djrscally@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v5:
> 
> 	- Changed the commit subject
> 
>  drivers/base/property.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 35b95c6ac0c6..0bf5260f14c6 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -837,9 +837,15 @@ EXPORT_SYMBOL_GPL(fwnode_handle_put);
>  /**
>   * fwnode_device_is_available - check if a device is available for use
>   * @fwnode: Pointer to the fwnode of the device.
> + *
> + * For fwnode node types that don't implement the .device_is_available()
> + * operation, this function returns true.
>   */
>  bool fwnode_device_is_available(const struct fwnode_handle *fwnode)
>  {
> +	if (!fwnode_has_op(fwnode, device_is_available))
> +		return true;
> +
>  	return fwnode_call_bool_op(fwnode, device_is_available);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_device_is_available);
> -- 
> 2.25.1

thanks,

-- 
heikki
