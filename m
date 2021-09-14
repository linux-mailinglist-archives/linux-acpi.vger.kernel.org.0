Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E940B050
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhINOOd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 10:14:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:28113 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233300AbhINOOc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 10:14:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="283006157"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="283006157"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 07:13:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="609642663"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Sep 2021 07:13:05 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Sep 2021 17:13:05 +0300
Date:   Tue, 14 Sep 2021 17:13:04 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Nettleton <jon@solid-run.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
Message-ID: <YUCt8KJAGnXdffHx@kuha.fi.intel.com>
References: <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
 <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
 <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
 <2485ac73-6df6-3939-5ee5-ef650d951054@nxp.com>
 <YTn6dx2rRsLZ6GDJ@kuha.fi.intel.com>
 <YTn7G/Mgm18JfV9k@kuha.fi.intel.com>
 <ffe89a41-59c3-499b-1553-0c15f386df01@nxp.com>
 <e9bc1397-99b7-a57e-4860-80d146848e2c@nxp.com>
 <YTtR2pLEMFDubtqi@kuha.fi.intel.com>
 <56544211-7407-3de2-e30d-d1dbb7b2aeb2@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56544211-7407-3de2-e30d-d1dbb7b2aeb2@nxp.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 10, 2021 at 04:00:49PM +0300, Laurentiu Tudor wrote:
> >> I've spent some time looking into this and it  turns out that in the
> >> ACPI case, device_create_managed_software_node() ends up being called
> >> twice, first here [1] and after that, in the IORT code here [2]. With
> >> the proposed patch this causes software_node_notify(KOBJ_ADD) being
> >> called twice thus triggering the dup sysfs entry warning.
> >> Any comments / ideas welcomed.
> >>
> >> [1] https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc3/host.c#L111
> > 
> > I think the problem here is that the secondary fwnode get's replaced
> > because the primary fwnode is shared. Can you test it with this, just
> > to see if the problem goes away:
> > 
> > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > index f29a264635aa1..e4b40f8b8f242 100644
> > --- a/drivers/usb/dwc3/host.c
> > +++ b/drivers/usb/dwc3/host.c
> > @@ -76,7 +76,6 @@ int dwc3_host_init(struct dwc3 *dwc)
> >         }
> >  
> >         xhci->dev.parent        = dwc->dev;
> > -       ACPI_COMPANION_SET(&xhci->dev, ACPI_COMPANION(dwc->dev));
> >  
> >         dwc->xhci = xhci;
> 
> 
> Thanks for looking into this! Yes, this does make the issue go away.

We need to think about how to solve this one. The problem is that we
have to share the ACPI node between the parent dwc3 device and child
xHCI, but at the same xHCI needs to have its own software node.

The fwnode->secondary pointer does not quite bend to this. If the
primary fwnode is shared, the secondary fwnode has to be shared as
well.

thanks,

-- 
heikki
