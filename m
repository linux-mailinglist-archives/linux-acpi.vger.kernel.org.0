Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C773531A247
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 17:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBLQCw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 11:02:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:16237 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhBLQCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Feb 2021 11:02:47 -0500
IronPort-SDR: 8yXtrBgcADJLrDdU81RZj0ccJEvNcNQTxjm0Vrzov11pCUB7niyKmcA6FQd899i6Y0HW5JHbUM
 mMeiTy/rD2hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="243922204"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="243922204"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 08:00:58 -0800
IronPort-SDR: jmkGWaefk30Gj6XR3MPMvxBU9HSfjwkiqAAW1s8P4kmC8eKvAuIwGwIZjQv81Ve73KUwMSHvzB
 BrqLb4qqlSdw==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="491013539"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 08:00:56 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lAasI-004X4Z-Db; Fri, 12 Feb 2021 18:00:54 +0200
Date:   Fri, 12 Feb 2021 18:00:54 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v2 5/5] ACPI: property: Refactor
 acpi_data_prop_read_single()
Message-ID: <YCamNlCxK9nb8XrZ@smile.fi.intel.com>
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
 <20210212141121.62115-5-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jot6w2AdTCmxn4Hw2zOzJk2JSrTaeH9cQR4or2N9HjCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jot6w2AdTCmxn4Hw2zOzJk2JSrTaeH9cQR4or2N9HjCg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 03:31:24PM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 12, 2021 at 3:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

> > Refactor acpi_data_prop_read_single() for less LOCs and better maintenance.

Thanks for review, my answers below.

...

> > +       if (ret)
> > +               return ret;
> 
> else if (!val)
>         ret = 1;

But then it become a bug again :-)

...

> And this is just not looking good to me, sorry.

Yeah, I think this patch is not needed right now. At least it seems no gain
from it.


-- 
With Best Regards,
Andy Shevchenko


