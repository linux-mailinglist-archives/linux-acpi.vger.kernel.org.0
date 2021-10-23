Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CED84383C2
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Oct 2021 15:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhJWNVm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Oct 2021 09:21:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:16628 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhJWNVm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 23 Oct 2021 09:21:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="229721453"
X-IronPort-AV: E=Sophos;i="5.87,175,1631602800"; 
   d="scan'208";a="229721453"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 06:19:21 -0700
X-IronPort-AV: E=Sophos;i="5.87,175,1631602800"; 
   d="scan'208";a="496049093"
Received: from yli135-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.169.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 06:19:18 -0700
Date:   Sat, 23 Oct 2021 21:19:14 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tools: Introduce power/acpi/pfru/pfru
Message-ID: <20211023131914.GB28269@chenyu5-mobl1>
References: <cover.1634899519.git.yu.c.chen@intel.com>
 <0159379f2f15c79959fd597874f162ebc3cf711b.1634899519.git.yu.c.chen@intel.com>
 <YXMbJMifGM2izSZO@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXMbJMifGM2izSZO@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2021 at 11:12:20PM +0300, Andy Shevchenko wrote:
> On Sat, Oct 23, 2021 at 01:10:32AM +0800, Chen Yu wrote:
> > Introduce a user space tool to make use of the interface exposed by
> > Platform Firmware Runtime Update and Telemetry drivers. The users
> > can use this tool to do firmware code injection, driver update and
> > to retrieve the telemetry data.
> 
> ...
> 
> >  #include <linux/ioctl.h>
> > +#ifdef __KERNEL__
> >  #include <linux/uuid.h>
> > +#else
> > +#include <uuid/uuid.h>
> > +#include <linux/types.h>
> > +#endif
> 
> This is exactly my point why you mustn't use uuid.h in uAPI headers.
>
Ok, will remove uuid.h. 
> > +	while (1) {
> 
> Why not  while ((c = getopt_long(...)) != -1) ?
> 
Ok, changed it to this form.
> > +		int option_index = 0;
> > +
> > +		c = getopt_long(argc, argv, option_string,
> > +				long_options, &option_index);
> > +		if (c == -1)
> > +			break;
> 
> > +		}
> > +	}
> > +}
> 
> ...
> 
> > +	char *uuid = malloc(37);
> 
> libuuid doesn't have helpers for this?
> 
There's no helper for uuid allocation AFAIK.
> Split assignment so if will be closer to its user.
> 
Ok, will do.

thanks,
Chenyu
