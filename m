Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0743C7EC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhJ0KsE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 06:48:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:19097 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241535AbhJ0KsA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 27 Oct 2021 06:48:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230079956"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230079956"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:45:26 -0700
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="597316964"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 03:45:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mfgQW-001RFx-N2;
        Wed, 27 Oct 2021 13:45:00 +0300
Date:   Wed, 27 Oct 2021 13:45:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YXktrG1LhK5tj2uF@smile.fi.intel.com>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <b37584e515c36882990295097386e783da29110e.1635317102.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b37584e515c36882990295097386e783da29110e.1635317102.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 03:08:05PM +0800, Chen Yu wrote:
> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.
> 
> The linux provides interfaces for the user to query the parameters of

Linux kernel

> telemetry data, and the user could read out the telemetry data
> accordingly.
> 
> The corresponding userspace tool and man page will be introduced at
> tools/power/acpi/pfru.

...

> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/uio.h>
> +#include <linux/uuid.h>

+ blank line?

> +#include <uapi/linux/pfru.h>

...

> +static DEFINE_IDA(pfru_log_ida);

Do you need any mutex against operations on IDA? (I don't remember
if it incorporates any synchronization primitives).

...

Looking into the code I have feelings of déjà-vu. Has it really had
nothing in common with the previous patch?

...

> +static int valid_log_level(int level)
> +{
> +	return level == LOG_ERR || level == LOG_WARN ||
> +		level == LOG_INFO || level == LOG_VERB;

Indentation.

> +}

...


This ordering in ->probe() is not okay:
	devm_*()
	non-devm_*()
	devm_*()
	non-devm_*()

One mustn't interleave these. The allowed are:

Case 1:
	non-devm_*()

Case 2:
	devm_*()

Case 3:
	devm_*()
	non-devm_*()

Otherwise in ->remove() you have wrong release ordering which may hide
subtle bugs.

Above comment is applicable to the other patch as well as some comments
from there are applicable here.

-- 
With Best Regards,
Andy Shevchenko


