Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B282E441D10
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 16:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhKAPF3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 11:05:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:49981 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231304AbhKAPF2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 11:05:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="228483707"
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="228483707"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 08:02:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,199,1631602800"; 
   d="scan'208";a="531208440"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 08:02:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mhYpF-002heC-Ip;
        Mon, 01 Nov 2021 17:02:17 +0200
Date:   Mon, 1 Nov 2021 17:02:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YYABeZuRdVk8qNgu@smile.fi.intel.com>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <a318e4edc13e5a3ff95b901871b8929746535715.1635317102.git.yu.c.chen@intel.com>
 <YXkn8aBvAVEXxgdp@smile.fi.intel.com>
 <20211101093320.GA18982@chenyu5-mobl1>
 <YX/NwEdw26wzKFvQ@smile.fi.intel.com>
 <20211101131434.GA32880@chenyu5-mobl1>
 <YX/ouT/hi5ccaxsz@kroah.com>
 <YX/0yCUlGM35vEXS@smile.fi.intel.com>
 <20211101145757.GA35522@chenyu5-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101145757.GA35522@chenyu5-mobl1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 01, 2021 at 10:57:57PM +0800, Chen Yu wrote:
> On Mon, Nov 01, 2021 at 04:08:08PM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 01, 2021 at 02:16:41PM +0100, Greg Kroah-Hartman wrote:

...

> > Actually I have no idea why we even have strings in  and not raw buffers.
> > Moreover, I haven't got why even we have them in uAPI.
> I see. These uuid could be put into the .c and there is no need for the
> user to be aware of these values.

Right! Because I haven't found any use of UUID in uAPI (even in raw form).

-- 
With Best Regards,
Andy Shevchenko


