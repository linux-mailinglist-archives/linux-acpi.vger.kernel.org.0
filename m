Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31814419A8
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 11:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhKAKTW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 06:19:22 -0400
Received: from mga06.intel.com ([134.134.136.31]:12199 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230298AbhKAKTV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 06:19:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291826685"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="291826685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 03:16:48 -0700
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="488572933"
Received: from shiweiyu-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.221])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 03:16:45 -0700
Date:   Mon, 1 Nov 2021 18:16:41 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <20211101101641.GA20219@chenyu5-mobl1>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <b37584e515c36882990295097386e783da29110e.1635317102.git.yu.c.chen@intel.com>
 <YXktrG1LhK5tj2uF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YXktrG1LhK5tj2uF@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 01:45:00PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 27, 2021 at 03:08:05PM +0800, Chen Yu wrote:
> > Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> > (Root of Trust), which allows PFRU handler and other PFRU drivers to
> > produce telemetry data to upper layer OS consumer at runtime.
> > 
> > The linux provides interfaces for the user to query the parameters of
> 
> Linux kernel
>
Ok. 
> > telemetry data, and the user could read out the telemetry data
> > accordingly.
> > 
> > The corresponding userspace tool and man page will be introduced at
> > tools/power/acpi/pfru.
> 
> ...
> 
> > +#include <linux/acpi.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/file.h>
> > +#include <linux/fs.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/mm.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/string.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/uio.h>
> > +#include <linux/uuid.h>
> 
> + blank line?
> 
Ok.
> > +#include <uapi/linux/pfru.h>
> 
> ...
> 
> > +static DEFINE_IDA(pfru_log_ida);
> 
> Do you need any mutex against operations on IDA? (I don't remember
> if it incorporates any synchronization primitives).
> 
The IDA uses a spinlock_irqsave() to protect the bitmap.
> ...
> 
> Looking into the code I have feelings of déjà-vu. Has it really had
> nothing in common with the previous patch?
> 
They both invokes _DSM to trigger the low level actions. However the input
parameters and return ACPI package as well as the functions are different
and hard to extract the common code between them.
> ...
> 
> > +static int valid_log_level(int level)
> > +{
> > +	return level == LOG_ERR || level == LOG_WARN ||
> > +		level == LOG_INFO || level == LOG_VERB;
> 
> Indentation.
> 
Ok, will add.
> > +}
> 
> ...
> 
> 
> This ordering in ->probe() is not okay:
> 	devm_*()
> 	non-devm_*()
> 	devm_*()
> 	non-devm_*()
> 
> One mustn't interleave these. The allowed are:
> 
> Case 1:
> 	non-devm_*()
> 
> Case 2:
> 	devm_*()
> 
> Case 3:
> 	devm_*()
> 	non-devm_*()
> 
> Otherwise in ->remove() you have wrong release ordering which may hide
> subtle bugs.
> 
Got it. I'll fix it in next version.
> Above comment is applicable to the other patch as well as some comments
> from there are applicable here.
> 
Ok.

Thanks,
Chenyu
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
