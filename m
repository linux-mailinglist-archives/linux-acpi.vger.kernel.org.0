Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD643371C7
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Mar 2021 12:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhCKLvD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Mar 2021 06:51:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:42346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhCKLux (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 11 Mar 2021 06:50:53 -0500
IronPort-SDR: vyicxoGIzpW/visRc0nrhpsHPKKqTg3gx1+D7xvZqjYfYJ4+zuM6A7LEwtg2/8z520g28xf+x+
 wjOJ+3oCcvpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186275838"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="186275838"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 03:50:52 -0800
IronPort-SDR: AcBLfGfazTer+re1icfOtOn5/NwK7at8iAymizUpfTNqtlQSJto0TkNl7KXJB5ql8PDdQ0DbaH
 jIc4GZ2zj57Q==
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="448263474"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 03:50:51 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lKJq5-00BZS6-1s; Thu, 11 Mar 2021 13:50:49 +0200
Date:   Thu, 11 Mar 2021 13:50:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add entry for the software nodes
Message-ID: <YEoEGRZIJ81NzOgQ@smile.fi.intel.com>
References: <20210311082521.39342-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311082521.39342-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 11, 2021 at 11:25:21AM +0300, Heikki Krogerus wrote:
> Making Andy and myself (Heikki) the designated reviewers of
> the thing. The software node mailing list shall be
> linux-acpi@vger.kernel.org for now.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f032f45bc9512..a76b6c926004e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16616,6 +16616,13 @@ F:	drivers/firmware/arm_sdei.c
>  F:	include/linux/arm_sdei.h
>  F:	include/uapi/linux/arm_sdei.h
>  
> +SOFTWARE NODES
> +R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> +L:	linux-acpi@vger.kernel.org
> +S:	Maintained
> +F:	drivers/base/swnode.c
> +
>  SOFTWARE RAID (Multiple Disks) SUPPORT
>  M:	Song Liu <song@kernel.org>
>  L:	linux-raid@vger.kernel.org
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


