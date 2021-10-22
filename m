Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0C9437F29
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhJVUPE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 16:15:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:65337 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232750AbhJVUPD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 16:15:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216294112"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216294112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 13:12:45 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445414060"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 13:12:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1me0tp-000Eem-6w;
        Fri, 22 Oct 2021 23:12:21 +0300
Date:   Fri, 22 Oct 2021 23:12:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tools: Introduce power/acpi/pfru/pfru
Message-ID: <YXMbJMifGM2izSZO@smile.fi.intel.com>
References: <cover.1634899519.git.yu.c.chen@intel.com>
 <0159379f2f15c79959fd597874f162ebc3cf711b.1634899519.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0159379f2f15c79959fd597874f162ebc3cf711b.1634899519.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 23, 2021 at 01:10:32AM +0800, Chen Yu wrote:
> Introduce a user space tool to make use of the interface exposed by
> Platform Firmware Runtime Update and Telemetry drivers. The users
> can use this tool to do firmware code injection, driver update and
> to retrieve the telemetry data.

...

>  #include <linux/ioctl.h>
> +#ifdef __KERNEL__
>  #include <linux/uuid.h>
> +#else
> +#include <uuid/uuid.h>
> +#include <linux/types.h>
> +#endif

This is exactly my point why you mustn't use uuid.h in uAPI headers.

...

> +	while (1) {

Why not  while ((c = getopt_long(...)) != -1) ?

> +		int option_index = 0;
> +
> +		c = getopt_long(argc, argv, option_string,
> +				long_options, &option_index);
> +		if (c == -1)
> +			break;

> +		}
> +	}
> +}

...

> +	char *uuid = malloc(37);

libuuid doesn't have helpers for this?

Split assignment so if will be closer to its user.

> +	if (!uuid) {
> +		perror("Can not allocate uuid buffer\n");
> +		exit(1);
> +	}

-- 
With Best Regards,
Andy Shevchenko


