Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A05C2C1208
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Nov 2020 18:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgKWRfE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Nov 2020 12:35:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:7338 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730867AbgKWRfE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Nov 2020 12:35:04 -0500
IronPort-SDR: j26Ja5nMiItW+fDhRu78sZ5m+HUyMzGaO/4SeHWTxXIFyYNcHYG/Db+XX+jc9xwWta61N7J0mm
 geF4ErHfok7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="159577500"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="159577500"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:35:03 -0800
IronPort-SDR: icjRiGPYcByjDGJSIMRLn5mZ8P4BP1y84bzFOOpMtPmduaZvWYlUsyGqrGQQL5rzhJDYbUKPHC
 10uOLSE1aaGA==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="332261026"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 09:35:01 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1khFkx-009DgZ-Eu; Mon, 23 Nov 2020 19:36:03 +0200
Date:   Mon, 23 Nov 2020 19:36:03 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 0/2] Remove one more platform_device_add_properties() call
Message-ID: <20201123173603.GJ4077@smile.fi.intel.com>
References: <20201123153148.52647-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jAaz2zELkJoKjHtxyfuKEi=ORuCCad-F0yp6KephieGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jAaz2zELkJoKjHtxyfuKEi=ORuCCad-F0yp6KephieGg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 23, 2020 at 06:06:31PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 23, 2020 at 4:32 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > I originally introduced these as part of my series where I was
> > proposing PM ops for software nodes [1], but since that still needs
> > work, I'm sending these two separately.
> >
> > So basically I'm only modifying dwc3-pci.c so it registers a software
> > node directly at this point. That will remove one more user of
> > platform_device_add_properties().
> >
> > [1] https://lore.kernel.org/lkml/20201029105941.63410-1-heikki.krogerus@linux.intel.com/
> >
> > thanks,
> >
> > Heikki Krogerus (2):
> >   software node: Introduce device_add_software_node()
> >   usb: dwc3: pci: Register a software node for the dwc3 platform device
> >
> >  drivers/base/swnode.c       | 69 ++++++++++++++++++++++++++++++++-----
> >  drivers/usb/dwc3/dwc3-pci.c | 61 +++++++++++++++++++-------------
> >  include/linux/property.h    |  3 ++
> >  3 files changed, 100 insertions(+), 33 deletions(-)
> >
> > --
> 
> These look good to me.
> 
> If you want me to take them, though, I need an ACK from the dwc3 side.

Btw, I have tested this on one of the platform with DWC3 and found no
regression, so feel free to add

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


