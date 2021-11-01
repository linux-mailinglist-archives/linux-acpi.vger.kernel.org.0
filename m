Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76639441C41
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 15:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKAOLf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 10:11:35 -0400
Received: from mga17.intel.com ([192.55.52.151]:46573 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAOLf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 10:11:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="211786115"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="211786115"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:08:28 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="449268058"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 07:08:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mhXyr-002gvb-6F;
        Mon, 01 Nov 2021 16:08:09 +0200
Date:   Mon, 1 Nov 2021 16:08:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YX/0yCUlGM35vEXS@smile.fi.intel.com>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <a318e4edc13e5a3ff95b901871b8929746535715.1635317102.git.yu.c.chen@intel.com>
 <YXkn8aBvAVEXxgdp@smile.fi.intel.com>
 <20211101093320.GA18982@chenyu5-mobl1>
 <YX/NwEdw26wzKFvQ@smile.fi.intel.com>
 <20211101131434.GA32880@chenyu5-mobl1>
 <YX/ouT/hi5ccaxsz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YX/ouT/hi5ccaxsz@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 01, 2021 at 02:16:41PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 01, 2021 at 09:14:34PM +0800, Chen Yu wrote:
> > On Mon, Nov 01, 2021 at 01:21:36PM +0200, Andy Shevchenko wrote:

...

> > Ok, I'll switch to global variables in next version.
> 
> Wait, no, why?

But why should we have a duplication of basically static data?

> Keep them per-device unless you can somehow be
> guaranteed there will never be more than one of these ACPI devices in a
> system.

I guess you missed my point. These definitions are _always_ the same.
It does not matter how many devices in the system.

Chen, is my perception correct?
If no, then do what Greg says.

> It's simpler this way, no need to worry about global state at
> all.

Actually I have no idea why we even have strings in  and not raw buffers.
Moreover, I haven't got why even we have them in uAPI.

-- 
With Best Regards,
Andy Shevchenko


