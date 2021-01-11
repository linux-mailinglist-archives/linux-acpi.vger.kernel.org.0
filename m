Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54B2F12AC
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 13:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbhAKM60 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 07:58:26 -0500
Received: from mga09.intel.com ([134.134.136.24]:19306 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbhAKM60 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 07:58:26 -0500
IronPort-SDR: LoT3vkwoCskR2FOcijk4ohDA0eQpWoCBxt6Y4YZLBLQySxAR9oQwrZtsOqCNdqdW+tMNO8PNgu
 5/LjBgUW4t0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="178002962"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="178002962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 04:56:36 -0800
IronPort-SDR: rYQXHqKv5O3uuQA3e427T24HknA9G3wkZhKo2mwyILHTWFz9r0QGNRFJzThPjPlIQ2vfrvk3st
 f8enqWbH0Zdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="464152338"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Jan 2021 04:56:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Jan 2021 14:56:32 +0200
Date:   Mon, 11 Jan 2021 14:56:32 +0200
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
Message-ID: <20210111125632.GA2020859@kuha.fi.intel.com>
References: <20201123153148.52647-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jAaz2zELkJoKjHtxyfuKEi=ORuCCad-F0yp6KephieGg@mail.gmail.com>
 <20201204112318.GA4013126@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204112318.GA4013126@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 04, 2020 at 01:23:22PM +0200, Heikki Krogerus wrote:
> Hi Felipe,
> 
> On Mon, Nov 23, 2020 at 06:06:31PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Nov 23, 2020 at 4:32 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > I originally introduced these as part of my series where I was
> > > proposing PM ops for software nodes [1], but since that still needs
> > > work, I'm sending these two separately.
> > >
> > > So basically I'm only modifying dwc3-pci.c so it registers a software
> > > node directly at this point. That will remove one more user of
> > > platform_device_add_properties().
> > >
> > > [1] https://lore.kernel.org/lkml/20201029105941.63410-1-heikki.krogerus@linux.intel.com/
> > >
> > > thanks,
> > >
> > > Heikki Krogerus (2):
> > >   software node: Introduce device_add_software_node()
> > >   usb: dwc3: pci: Register a software node for the dwc3 platform device
> > >
> > >  drivers/base/swnode.c       | 69 ++++++++++++++++++++++++++++++++-----
> > >  drivers/usb/dwc3/dwc3-pci.c | 61 +++++++++++++++++++-------------
> > >  include/linux/property.h    |  3 ++
> > >  3 files changed, 100 insertions(+), 33 deletions(-)
> > >
> > > --
> > 
> > These look good to me.
> > 
> > If you want me to take them, though, I need an ACK from the dwc3 side.
> 
> Is this OK?

I think this went under you radar, so I'll resend these.

Br,

-- 
heikki
