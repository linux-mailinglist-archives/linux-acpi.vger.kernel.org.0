Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32C827ACBB
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Sep 2020 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI1LcZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Sep 2020 07:32:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:62254 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgI1LcZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Sep 2020 07:32:25 -0400
IronPort-SDR: jhDOPDNa/y56Zvd+kMP860Io9j1XjHIwriLNHSoXK+skiCwIswz1BbatAvN6WnWDrtWzR+2xC2
 AIaVLHvo4R3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149750857"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="149750857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 04:32:23 -0700
IronPort-SDR: wmwjLpx0vZ4fe9wPGrkgmvd3yCF9t5adWQZYclHblL03grnn1EqDHcYvjQZGOiceRKPDkOqwX1
 lbA4zn0exFFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="414950724"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Sep 2020 04:32:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 28 Sep 2020 14:32:20 +0300
Date:   Mon, 28 Sep 2020 14:32:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/3] software node: Power management operations for
 software nodes
Message-ID: <20200928113220.GA3987353@kuha.fi.intel.com>
References: <20200825135951.53340-1-heikki.krogerus@linux.intel.com>
 <20200825135951.53340-2-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jT7Xdcm1WVvAV9okkoicnEsFEvnLSLLNx6eJHMNxwX+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jT7Xdcm1WVvAV9okkoicnEsFEvnLSLLNx6eJHMNxwX+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 25, 2020 at 05:54:37PM +0200, Rafael J. Wysocki wrote:
> On Tue, Aug 25, 2020 at 3:59 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Adding separate PM operations vector for the software nodes.
> > The software node specific PM operations make it possible to
> > handle most PM related quirks separately in their own
> > functions instead of conditionally in the device driver's
> > generic PM functions (and in some cases all over the
> > driver). The software node specific PM operations will also
> > reduce the need to pass platform data in some cases, for
> > example from a core MFD driver to the child device drivers,
> > as from now on the core MFD driver will be able to implement
> > the PM quirks directly for the child devices without the
> > need to touch the drivers of those child devices.
> >
> > If a software node includes the PM operations, those PM
> > operations are always executed separately on top of the
> > other PM operations of the device, so the software node will
> > never replace any of the "normal" PM operations of the
> > device (including the PM domain's operations, class's or
> > bus's PM operations, the device drivers own operations, or
> > any other).
> 
> This isn't consistent with the code changes AFAICS.
> 
> The swnode PM operations are implemented as a PM domain ops, which
> means that they will be executed instead of any other existing ops
> rather than in addition to those.
> 
> For example, software_node_prepare() will skip bus type ops if they
> are present and there is no "primary" PM domain which seems not
> intended.

True. I thought the pm_generic_*() functions will take care of also
the bus ops, but of course they don't do that.

> Also some comments might help to understand the design.

OK.

thanks,

-- 
heikki
