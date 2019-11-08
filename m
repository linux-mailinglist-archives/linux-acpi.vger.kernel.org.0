Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FB2F3C94
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfKHAIm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Nov 2019 19:08:42 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38841 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfKHAIl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Nov 2019 19:08:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id v24so3687605otp.5
        for <linux-acpi@vger.kernel.org>; Thu, 07 Nov 2019 16:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CdRcgdPPcTDb9iILEnie34cS22AyZ+s0MuyZNLTIdPc=;
        b=OMiV97rFdjjolJL7K+mFvRE2r5QNvRPWhZ9yBFxn9cSIfsJT3iKtXkIZ/NZ36mb6wp
         vEIGwZv+Txfb3eoLv1sly/OCoilMgsv6oKbGWeItyhYfWMH5VuklLuhu672xrykES2MY
         1ptQ6+IU9sbP0ETaS6ZwBxODhRviDidckAT7U6b29eDdbBsIrETpAM3XhJR7LxgD7WLN
         UCUlBl+rZ7vUCzCgNEK37pmG8mONVJA/gkj1fpXsXrdbGh5svzQNakDK+1W3X+K/qcg/
         Ujk60pEKuDdYuvw/Jso8Lzn7uXW3/Y0I+qVE73Q8W/fsvurb9M0ZKNuRzVmhjL7YtadB
         k9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CdRcgdPPcTDb9iILEnie34cS22AyZ+s0MuyZNLTIdPc=;
        b=W/tJd3Jl+aZnzgVzzXMpC8vNhMDis5q+injk3teFrcBxOKAgQBLywIq2IVTEh0Aqcm
         DPD7F96WXRgO3HeYBdSuKjUAxMWzjPpgfMDY3O3VgWMOudRHKY/eKPAywJdxcxCSL4Dk
         3ohXw25UnlWJ7hI0ciAafHTjqX40hVTXKeFMrAKCkMa1+5q2Ziwj6RAxWqQB2ah8eqLG
         m+qxAvveBrq7Cfzpt5aBZUu3lgOF1UAEfTtGxxrnokZN85JvFFCesQ6SDHKPAxtUKu9r
         N6eprsTLlOp2HLAOnaVV7bJb1y0cuf5kvtiQ6PlezSrPrBqI/8MaPXSQxekCMchgBxRM
         FxLQ==
X-Gm-Message-State: APjAAAVRHi2Mf62wOYg7C1ZYWRMlGN2tUGaJEdzBptGGljesPBNW+9Ic
        hm4vzUFSJIdQ3t2Rz2aLWnwwiv0+gx5VcoGt7IpDtg==
X-Google-Smtp-Source: APXvYqx0/HLtAvC80DJKdIL3Q5or5GXelew6sVCxuc0Un2WE8IFieq2+Jke4vEpVdBn6zIYda4lypuSdXr1EZPhn58U=
X-Received: by 2002:a05:6830:1d4c:: with SMTP id p12mr4607913oth.139.1573171719519;
 Thu, 07 Nov 2019 16:08:39 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <1593797.btdyhENphq@kreacher>
 <CAGETcx9KSwXgrc0PaWQtBuiET-0ts9HNgjzRcioewjqzjuQGSg@mail.gmail.com> <2876287.EbKXPN90gv@kreacher>
In-Reply-To: <2876287.EbKXPN90gv@kreacher>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Nov 2019 16:08:02 -0800
Message-ID: <CAGETcx9_NpmmeLH8XCECYfMxPzoXnE+g6MqPOL2CF1N9wHrf_w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] driver core: Allow a device to wait on optional suppliers
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 7, 2019 at 4:05 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, November 5, 2019 11:35:28 PM CET Saravana Kannan wrote:
> > Looks like I squashed/rebased a bit incorrectly. It's fixed in the
> > next patch in the series.
>
> Well, that still is somewhat bisection-unfriendly.

Agreed. I was just answering why it compiled fine. Sorry about the
screw up. Any sorry about the accidental top posting last time.

-Saravana

>
>
> > On Tue, Nov 5, 2019 at 2:29 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Monday, October 28, 2019 11:00:23 PM CET Saravana Kannan wrote:
> > > > Before this change, if a device is waiting on suppliers, it's assumed
> > > > that all those suppliers are needed for the device to probe
> > > > successfully. This change allows marking a devices as waiting only on
> > > > optional suppliers. This allows a device to wait on suppliers (and link
> > > > to them as soon as they are available) without preventing the device
> > > > from being probed.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/core.c    | 28 +++++++++++++++++++++++++---
> > > >  include/linux/device.h |  3 +++
> > > >  2 files changed, 28 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index 17ed054c4132..48cd43a91ce6 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -480,13 +480,25 @@ EXPORT_SYMBOL_GPL(device_link_add);
> > > >   * This function is NOT meant to be called from the probe function of the
> > > >   * consumer but rather from code that creates/adds the consumer device.
> > > >   */
> > > > -static void device_link_wait_for_supplier(struct device *consumer)
> > > > +static void device_link_wait_for_supplier(struct device *consumer,
> > > > +                                       bool need_for_probe)
> > > >  {
> > > >       mutex_lock(&wfs_lock);
> > > >       list_add_tail(&consumer->links.needs_suppliers, &wait_for_suppliers);
> > > > +     consumer->links.need_for_probe = need_for_probe;
> > > >       mutex_unlock(&wfs_lock);
> > > >  }
> > > >
> > > > +static void device_link_wait_for_mandatory_supplier(struct device *consumer)
> > > > +{
> > > > +     device_link_wait_for_supplier(consumer, true);
> > > > +}
> > > > +
> > > > +static void device_link_wait_for_optional_supplier(struct device *consumer)
> > > > +{
> > > > +     device_link_wait_for_supplier(consumer, false);
> > > > +}
> > > > +
> > > >  /**
> > > >   * device_link_add_missing_supplier_links - Add links from consumer devices to
> > > >   *                                       supplier devices, leaving any
> > > > @@ -656,7 +668,8 @@ int device_links_check_suppliers(struct device *dev)
> > > >        * probe.
> > > >        */
> > > >       mutex_lock(&wfs_lock);
> > > > -     if (!list_empty(&dev->links.needs_suppliers)) {
> > > > +     if (!list_empty(&dev->links.needs_suppliers) &&
> > > > +         dev->links.need_for_probe) {
> > > >               mutex_unlock(&wfs_lock);
> > > >               return -EPROBE_DEFER;
> > > >       }
> > > > @@ -760,6 +773,15 @@ void device_links_driver_bound(struct device *dev)
> > > >  {
> > > >       struct device_link *link;
> > > >
> > > > +     /*
> > > > +      * If a device probes successfully, it's expected to have created all
> > > > +      * the device links it needs to or make new device links as it needs
> > > > +      * them. So, it no longer needs to wait on any suppliers.
> > > > +      */
> > > > +     mutex_lock(&wfs_lock);
> > > > +     list_del_init(&dev->links.needs_suppliers);
> > > > +     mutex_unlock(&wfs_lock);
> > > > +
> > > >       device_links_write_lock();
> > > >
> > > >       list_for_each_entry(link, &dev->links.consumers, s_node) {
> > > > @@ -2393,7 +2415,7 @@ int device_add(struct device *dev)
> > > >
> > > >       if (fwnode_has_op(dev->fwnode, add_links)
> > > >           && fwnode_call_int_op(dev->fwnode, add_links, dev))
> > > > -             device_link_wait_for_supplier(dev);
> > > > +             device_link_wait_for_mandatory_supplier(dev, true);
> > >
> > > Does this compile even?
> > >
> > > The function takes one argument according to the definition above ...
> > >
> > > >       bus_probe_device(dev);
> > > >       if (parent)
> > > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > > index f1f2aa0b19da..4fd33da9a848 100644
> > > > --- a/include/linux/device.h
> > > > +++ b/include/linux/device.h
> > > > @@ -1156,6 +1156,8 @@ enum dl_dev_state {
> > > >   * @consumers: List of links to consumer devices.
> > > >   * @needs_suppliers: Hook to global list of devices waiting for suppliers.
> > > >   * @defer_sync: Hook to global list of devices that have deferred sync_state.
> > > > + * @need_for_probe: If needs_suppliers is on a list, this indicates if the
> > > > + *               suppliers are needed for probe or not.
> > > >   * @status: Driver status information.
> > > >   */
> > > >  struct dev_links_info {
> > > > @@ -1163,6 +1165,7 @@ struct dev_links_info {
> > > >       struct list_head consumers;
> > > >       struct list_head needs_suppliers;
> > > >       struct list_head defer_sync;
> > > > +     bool need_for_probe;
> > > >       enum dl_dev_state status;
> > > >  };
> > > >
> > > >
> > >
> > >
> > >
> > >
> >
>
>
>
>
