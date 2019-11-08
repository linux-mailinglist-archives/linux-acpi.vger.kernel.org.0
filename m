Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63F25F3C88
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKHAF7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:05:59 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48637 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfKHAF7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:05:59 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 657f9753bd504601; Fri, 8 Nov 2019 01:05:55 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 2/5] driver core: Allow a device to wait on optional suppliers
Date:   Fri, 08 Nov 2019 01:05:55 +0100
Message-ID: <2876287.EbKXPN90gv@kreacher>
In-Reply-To: <CAGETcx9KSwXgrc0PaWQtBuiET-0ts9HNgjzRcioewjqzjuQGSg@mail.gmail.com>
References: <20191028220027.251605-1-saravanak@google.com> <1593797.btdyhENphq@kreacher> <CAGETcx9KSwXgrc0PaWQtBuiET-0ts9HNgjzRcioewjqzjuQGSg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, November 5, 2019 11:35:28 PM CET Saravana Kannan wrote:
> Looks like I squashed/rebased a bit incorrectly. It's fixed in the
> next patch in the series.

Well, that still is somewhat bisection-unfriendly.

> On Tue, Nov 5, 2019 at 2:29 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Monday, October 28, 2019 11:00:23 PM CET Saravana Kannan wrote:
> > > Before this change, if a device is waiting on suppliers, it's assumed
> > > that all those suppliers are needed for the device to probe
> > > successfully. This change allows marking a devices as waiting only on
> > > optional suppliers. This allows a device to wait on suppliers (and link
> > > to them as soon as they are available) without preventing the device
> > > from being probed.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/core.c    | 28 +++++++++++++++++++++++++---
> > >  include/linux/device.h |  3 +++
> > >  2 files changed, 28 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 17ed054c4132..48cd43a91ce6 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -480,13 +480,25 @@ EXPORT_SYMBOL_GPL(device_link_add);
> > >   * This function is NOT meant to be called from the probe function of the
> > >   * consumer but rather from code that creates/adds the consumer device.
> > >   */
> > > -static void device_link_wait_for_supplier(struct device *consumer)
> > > +static void device_link_wait_for_supplier(struct device *consumer,
> > > +                                       bool need_for_probe)
> > >  {
> > >       mutex_lock(&wfs_lock);
> > >       list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
> > > +     consumer->links.need_for_probe = need_for_probe;
> > >       mutex_unlock(&wfs_lock);
> > >  }
> > >
> > > +static void device_link_wait_for_mandatory_supplier(struct device *consumer)
> > > +{
> > > +     device_link_wait_for_supplier(consumer, true);
> > > +}
> > > +
> > > +static void device_link_wait_for_optional_supplier(struct device *consumer)
> > > +{
> > > +     device_link_wait_for_supplier(consumer, false);
> > > +}
> > > +
> > >  /**
> > >   * device_link_add_missing_supplier_links - Add links from consumer devices to
> > >   *                                       supplier devices, leaving any
> > > @@ -656,7 +668,8 @@ int device_links_check_suppliers(struct device *dev)
> > >        * probe.
> > >        */
> > >       mutex_lock(&wfs_lock);
> > > -     if (!list_empty(&dev->links.needs_suppliers)) {
> > > +     if (!list_empty(&dev->links.needs_suppliers) &&
> > > +         dev->links.need_for_probe) {
> > >               mutex_unlock(&wfs_lock);
> > >               return -EPROBE_DEFER;
> > >       }
> > > @@ -760,6 +773,15 @@ void device_links_driver_bound(struct device *dev)
> > >  {
> > >       struct device_link *link;
> > >
> > > +     /*
> > > +      * If a device probes successfully, it's expected to have created all
> > > +      * the device links it needs to or make new device links as it needs
> > > +      * them. So, it no longer needs to wait on any suppliers.
> > > +      */
> > > +     mutex_lock(&wfs_lock);
> > > +     list_del_init(&dev->links.needs_suppliers);
> > > +     mutex_unlock(&wfs_lock);
> > > +
> > >       device_links_write_lock();
> > >
> > >       list_for_each_entry(link, &dev->links.consumers, s_node) {
> > > @@ -2393,7 +2415,7 @@ int device_add(struct device *dev)
> > >
> > >       if (fwnode_has_op(dev->fwnode, add_links)
> > >           && fwnode_call_int_op(dev->fwnode, add_links, dev))
> > > -             device_link_wait_for_supplier(dev);
> > > +             device_link_wait_for_mandatory_supplier(dev, true);
> >
> > Does this compile even?
> >
> > The function takes one argument according to the definition above ...
> >
> > >       bus_probe_device(dev);
> > >       if (parent)
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index f1f2aa0b19da..4fd33da9a848 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -1156,6 +1156,8 @@ enum dl_dev_state {
> > >   * @consumers: List of links to consumer devices.
> > >   * @needs_suppliers: Hook to global list of devices waiting for suppliers.
> > >   * @defer_sync: Hook to global list of devices that have deferred sync_state.
> > > + * @need_for_probe: If needs_suppliers is on a list, this indicates if the
> > > + *               suppliers are needed for probe or not.
> > >   * @status: Driver status information.
> > >   */
> > >  struct dev_links_info {
> > > @@ -1163,6 +1165,7 @@ struct dev_links_info {
> > >       struct list_head consumers;
> > >       struct list_head needs_suppliers;
> > >       struct list_head defer_sync;
> > > +     bool need_for_probe;
> > >       enum dl_dev_state status;
> > >  };
> > >
> > >
> >
> >
> >
> >
> 




