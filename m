Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304DD2ED178
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 15:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbhAGOLz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 09:11:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:8588 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbhAGOLy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 Jan 2021 09:11:54 -0500
IronPort-SDR: ovUtzH4X10UgL385lMlcg8jsEM470ZJDIujiP3VPgnek/qWSj6+AaG99Q6IcWWd6GOCVcC/cS6
 tU3uD9uxpVBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="173922046"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="173922046"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 06:10:09 -0800
IronPort-SDR: AFRQfezu+sziFYghK9Dr4Ju24eKUvnteVn7kOwhtT5/sD+GfmKEv50C0Z+tLnYz2EOhG1eZgZN
 dyetWb0OgAKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="463045941"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 07 Jan 2021 06:10:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 07 Jan 2021 16:10:05 +0200
Date:   Thu, 7 Jan 2021 16:10:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
        rafael@kernel.org, bard.liao@intel.com
Subject: Re: [PATCH 1/2] Revert "device property: Keep secondary firmware
 node secondary by type"
Message-ID: <20210107141005.GH940479@kuha.fi.intel.com>
References: <20210105091146.25422-1-yung-chuan.liao@linux.intel.com>
 <20210105091146.25422-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105091146.25422-2-yung-chuan.liao@linux.intel.com>
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
> 
> Fixes: d5dcce0c414f ("device property: Keep secondary firmware node secondary by type")
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

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

-- 
heikki
