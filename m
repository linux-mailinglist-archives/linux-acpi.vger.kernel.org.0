Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECD7406C5D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Sep 2021 14:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhIJMmH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 Sep 2021 08:42:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:57795 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234994AbhIJMl4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 Sep 2021 08:41:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="219206797"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="219206797"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 05:38:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="607397416"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 10 Sep 2021 05:38:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 10 Sep 2021 15:38:50 +0300
Date:   Fri, 10 Sep 2021 15:38:50 +0300
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
Message-ID: <YTtR2pLEMFDubtqi@kuha.fi.intel.com>
References: <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
 <YPVufjevu5WaaIxQ@smile.fi.intel.com>
 <2a0f7fa6-b164-eeb4-118a-acd57d79a484@nxp.com>
 <CAHp75VcYt+VQq4jp9JdkA4EpGqtks2sP-NRkfSbGj+-Vn5ke=g@mail.gmail.com>
 <c2186f2c-8be0-6f44-e442-8cb8cbd5f2c2@nxp.com>
 <2485ac73-6df6-3939-5ee5-ef650d951054@nxp.com>
 <YTn6dx2rRsLZ6GDJ@kuha.fi.intel.com>
 <YTn7G/Mgm18JfV9k@kuha.fi.intel.com>
 <ffe89a41-59c3-499b-1553-0c15f386df01@nxp.com>
 <e9bc1397-99b7-a57e-4860-80d146848e2c@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9bc1397-99b7-a57e-4860-80d146848e2c@nxp.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 10, 2021 at 03:05:16PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 9/9/2021 5:01 PM, Laurentiu Tudor wrote:
> > 
> > 
> > On 9/9/2021 3:16 PM, Heikki Krogerus wrote:
> >> On Thu, Sep 09, 2021 at 03:13:47PM +0300, Heikki Krogerus wrote:
> >>> On Tue, Sep 07, 2021 at 06:59:18PM +0300, Laurentiu Tudor wrote:
> >>>>
> >>>>
> >>>> On 7/26/2021 10:59 AM, Laurentiu Tudor wrote:
> >>>>>
> >>>>>
> >>>>> On 7/20/2021 1:27 PM, Andy Shevchenko wrote:
> >>>>>> On Tue, Jul 20, 2021 at 12:22 PM Laurentiu Tudor
> >>>>>> <laurentiu.tudor@nxp.com> wrote:
> >>>>>>> On 7/19/2021 3:22 PM, Andy Shevchenko wrote:
> >>>>>>>> On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
> >>>>>>>>> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
> >>>>>>>>>> On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
> >>>>>>>>>> <andriy.shevchenko@linux.intel.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
> >>>>>>>>>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>>>>>>>>>
> >>>>>>>>>>>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> >>>>>>>>>>>> software nodes, thus leading to underflow errors. Balance the refcount by
> >>>>>>>>>>>> bumping it in the device_create_managed_software_node() function.
> >>>>>>>>>>>>
> >>>>>>>>>>>> The error [1] was encountered after adding a .shutdown() op to our
> >>>>>>>>>>>> fsl-mc-bus driver.
> >>>>>>>>>>>
> >>>>>>>>>>> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
> >>>>>>>>>>> later on), I can tell that probably something is wrong in the ->shutdown()
> >>>>>>>>>>> method itself.
> >>>>>>>>>>
> >>>>>>>>>> Isn't the other alternative to just remove the second kobject_put from
> >>>>>>>>>> KOBJ_REMOVE ?
> >>>>>>>>>
> >>>>>>>>> Or maybe on top of Heikki's suggestion, replace the calls to
> >>>>>>>>> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?
> >>>>>>>>
> >>>>>>>> _noearn will hide the problem. It was there, it was removed from there.
> >>>>>>>> Perhaps we have to understand the root cause better (some specific flow?).
> >>>>>>>>
> >>>>>>>> Any insight from you on the flow when the issue appears? I.o.w. what happened
> >>>>>>>> on the big picture that we got into the warning you see?
> >>>>>>>
> >>>>>>> I encountered the initial issue when trying to shut down a system booted
> >>>>>>> with ACPI but only after adding a .shutdown() callback to our bus driver
> >>>>>>> so that the devices are properly taken down. The problem was that
> >>>>>>> software_node_notify(), on KOBJ_REMOVE was dropping the reference count
> >>>>>>> twice leading to an underflow error. My initial proposal was to just
> >>>>>>> bump the refcount in device_create_managed_software_node(). The device
> >>>>>>> properties that triggered the problem are created here [1].
> >>>>>>>
> >>>>>>> Heikko suggested that instead of manually incrementing the refcount to
> >>>>>>> use software_node_notify(KOBJ_ADD). This triggered the second issue, a
> >>>>>>> duplicated sysfs entry warning originating in the usb subsystem:
> >>>>>>> device_create_managed_software_node() ends up being called twice, once
> >>>>>>> here [2] and secondly, the place I previous mentioned [1].
> >>>>>>
> >>>>>> This [3] is what I have reported against DWC3 when ->shutdown() has
> >>>>>> been added there. And here [4] is another thread about the issue with
> >>>>>> that callback. The ->release() callback is called at put_device() [5]
> >>>>>> and ->shutdown() is called before that [6]. That said, can you inspect
> >>>>>> your ->shutdown() implementation once more time and perhaps see if
> >>>>>> there is anything that can be amended?
> >>>>>>
> >>>>>
> >>>>> Will do, thanks for the pointers. It could be that we mess something out
> >>>>> in how we use the driver model.
> >>>>>
> >>>>
> >>>> Quick (and late, sorry) update from my side. I've spent time on
> >>>> debugging our bus, did found some issues but, at least for now, none are
> >>>> related to sw node.
> >>>> In the mean time, I noticed in the swnode code that
> >>>> device_add_software_node() calls software_node_notify(KOBJ_ADD) while
> >>>> device_create_managed_software_node() doesn't. Updating [1] the later
> >>>> with the call to software_node_notify(KOBJ_ADD) does seem to fix the
> >>>> issue I'm seeing.
> >>>>
> >>>> Could this be a problem? Any comments appreciated.
> >>>>
> >>>> One more thing perhaps worth mentioning is that, at least for now, there
> >>>> are few uses for this device_create_managed_software_node() api,
> >>>> mentioning here a couple of them:
> >>>>  - arm64 iort code - this seems to be triggering the issue i'm getting
> >>>>  - dwc3 usb - Andy reported similar issues here, maybe the issue is common?
> >>>>
> >>>> [1]
> >>>> @@ -1113,6 +1125,15 @@ int device_create_managed_software_node(struct
> >>>> device *dev,
> >>>>         to_swnode(fwnode)->managed = true;
> >>>>         set_secondary_fwnode(dev, fwnode);
> >>>>
> >>>> +       /*
> >>>> +        * If the device has been fully registered by the time this
> >>>> function is
> >>>> +        * called, software_node_notify() must be called separately so
> >>>> that the
> >>>> +        * symlinks get created and the reference count of the node is
> >>>> kept in
> >>>> +        * balance.
> >>>> +        */
> >>>> +       if (device_is_registered(dev))
> >>>> +               software_node_notify(dev, KOBJ_ADD);
> >>>> +
> >>>>         return 0;
> >>>>  }
> >>>
> >>> That should be fixed indeed. Please send that after -rc1 is out.
> >>
> >> I mean, resend :-)
> >>
> > 
> > Right, actually I just noticed that this is the fix you suggested last
> > time we discussed. :-) I forgot about it, sorry.
> > There's still the WARN_ON() [1] triggered by the usb subsys, apparently
> > happening only (!) in ACPI boot scenario, so +Lorenzo.
> > I'll delay the sending a bit to try to understand what's going on.
> 
> I've spent some time looking into this and it  turns out that in the
> ACPI case, device_create_managed_software_node() ends up being called
> twice, first here [1] and after that, in the IORT code here [2]. With
> the proposed patch this causes software_node_notify(KOBJ_ADD) being
> called twice thus triggering the dup sysfs entry warning.
> Any comments / ideas welcomed.
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/usb/dwc3/host.c#L111

I think the problem here is that the secondary fwnode get's replaced
because the primary fwnode is shared. Can you test it with this, just
to see if the problem goes away:

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f29a264635aa1..e4b40f8b8f242 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -76,7 +76,6 @@ int dwc3_host_init(struct dwc3 *dwc)
        }
 
        xhci->dev.parent        = dwc->dev;
-       ACPI_COMPANION_SET(&xhci->dev, ACPI_COMPANION(dwc->dev));
 
        dwc->xhci = xhci;

> [2] https://elixir.bootlin.com/linux/latest/source/drivers/acpi/arm64/iort.c#L952

I didn't yet look at that one.

thanks,

-- 
heikki
