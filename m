Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F7442953
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 09:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhKBIbZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Nov 2021 04:31:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:45498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhKBIbZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Nov 2021 04:31:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="229932632"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="229932632"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2021 01:28:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800"; 
   d="scan'208";a="638113795"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 02 Nov 2021 01:28:42 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Nov 2021 10:28:41 +0200
Date:   Tue, 2 Nov 2021 10:28:41 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] software node: Skip duplicated software_node sysfs
Message-ID: <YYD2uXPcnFmiy54c@kuha.fi.intel.com>
References: <20211101200346.16466-1-quic_qiancai@quicinc.com>
 <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcrWPdR8EVGpcsniQedT0J4X700N7thFs6+srTP1MTgwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 02, 2021 at 01:51:34AM +0200, Andy Shevchenko wrote:
> On Monday, November 1, 2021, Qian Cai <quic_qiancai@quicinc.com> wrote:
> 
> > A recent commit allowed device_create_managed_software_node() to call
> > software_node_notify() which could generate duplicated "software_node"
> > sysfs files. For example,
> >
> > "/devices/platform/808622B7:01/xhci-hcd.3.auto/software_node"
> >
> > Since it was created earlier from another path,
> >
> >   sysfs_create_link
> >   software_node_notify
> >   device_add
> >   platform_device_add
> >   dwc3_host_init
> >   dwc3_probe
> >   platform_probe
> >   really_probe.part.0
> >   really_probe
> >   __driver_probe_device
> >   driver_probe_device
> >   __driver_attach
> >   bus_for_each_dev
> >   driver_attach
> >   bus_add_driver
> >   driver_register
> >   __platform_driver_register
> >   dwc3_driver_init at drivers/usb/dwc3/core.c:2072
> >   do_one_initcall
> >
> > Fixed it by using sysfs_create_link_nowarn() in software_node_notify() to
> > avoid those bad messages during booting,
> 
> 
> No, it’s not so easy. What you are doing is a papering over the real issue
> which is the limitation of the firmware nodes to two. What we need is to
> drop the link from struct fwnode_handle, move it to upper layer and modify
> all fwnode ops to be used over the list of fwnode:s.
> 
> XHCI driver and DWC3 are sharing the primary fwnode, but at the same time
> they wanted to have _different_ secondary ones when role is switched. This
> can’t be done in the current design. And here is the symptom what you got.

I'm actually not sure what is going on in this case, because this is
the ACPI enumerated BSW board, at least based on the ACPI ID?

That board should not have the initial secondary fwnode assigned by
the time the dwc3 host driver is called.


> sysfs: cannot create duplicatefilename '/devices/platform/808622B7:
> > 01/xhci-hcd.3.auto/software_node'
> >  Call trace:
> >   dump_backtrace
> >   show_stack
> >   dump_stack_lvl
> >   dump_stack
> >   sysfs_warn_dup
> >   sysfs_do_create_link_sd.isra.0
> >   sysfs_create_link
> >   software_node_notify
> >   device_create_managed_software_node
> >   iort_named_component_init
> >   iort_iommu_configure_id
> >   acpi_dma_configure_id
> >   platform_dma_configure
> >   really_probe.part.0
> >   really_probe
> >   __driver_probe_device
> >   driver_probe_device
> >   __driver_attach
> >   bus_for_each_dev
> >   driver_attach
> >   bus_add_driver
> >   driver_register
> >   __platform_driver_register
> >   xhci_plat_init
> >   do_one_initcall
> >   kernel_init_freeable
> >   kernel_init
> >   ret_from_fork
> >
> > Fixes: 5aeb05b27f81 ("software node: balance refcount for managed software
> > nodes")
> > Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> > ---
> >  drivers/base/swnode.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 4debcea4fb12..0a266c312aa3 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -1126,17 +1126,15 @@ void software_node_notify(struct device *dev)
> >         if (!swnode)
> >                 return;
> >
> > -       ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
> > "software_node");
> > -       if (ret)
> > +       ret = sysfs_create_link_nowarn(&dev->kobj, &swnode->kobj,
> > +                                      "software_node");
> > +       if (ret && ret != -EEXIST)
> >                 return;
> >
> > -       ret = sysfs_create_link(&swnode->kobj, &dev->kobj, dev_name(dev));
> > -       if (ret) {
> > +       if (!sysfs_create_link(&swnode->kobj, &dev->kobj, dev_name(dev)))
> > +               kobject_get(&swnode->kobj);
> > +       else if (!ret)
> >                 sysfs_remove_link(&dev->kobj, "software_node");
> > -               return;
> > -       }
> > -
> > -       kobject_get(&swnode->kobj);
> >  }
> >
> >  void software_node_notify_remove(struct device *dev)

thanks,

-- 
heikki
