Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415EE2CED01
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Dec 2020 12:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgLDLZD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Dec 2020 06:25:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:21992 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgLDLZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Dec 2020 06:25:03 -0500
IronPort-SDR: bpwbxSIbTvituL4H7G5isqh4UQ3YaX9L1K7sXlHpzBhD7XErGcCgG1MbxgvNo+JWU2tsvnpRZR
 /FquEPV67MrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173518019"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="173518019"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 03:23:22 -0800
IronPort-SDR: v9bNW00gKieqeSryPmnm9xh9U8RkPJlGVFX0+Bcr3vFvqs1pO94h3YNcnk+6L4nNouK7wnhjxo
 vlrTstwbSS+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="435784644"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 04 Dec 2020 03:23:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 04 Dec 2020 13:23:18 +0200
Date:   Fri, 4 Dec 2020 13:23:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] Remove one more platform_device_add_properties() call
Message-ID: <20201204112318.GA4013126@kuha.fi.intel.com>
References: <20201123153148.52647-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jAaz2zELkJoKjHtxyfuKEi=ORuCCad-F0yp6KephieGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jAaz2zELkJoKjHtxyfuKEi=ORuCCad-F0yp6KephieGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Felipe,

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

Is this OK?

thanks,

-- 
heikki
