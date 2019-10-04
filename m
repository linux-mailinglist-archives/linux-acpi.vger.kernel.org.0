Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE8CBF59
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2019 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfJDPh5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Oct 2019 11:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389586AbfJDPh5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Oct 2019 11:37:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB3420830;
        Fri,  4 Oct 2019 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570203474;
        bh=YcIlppU4Lt9lhX27/S/eEJPaKSNRVLdTeNKE4mdQLkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XloKBE/pX20WzoK42eZ5i4VSzF0G8YyFlBDBEYnoiPhjatOgMsUkxeq5tQGpbtQqq
         wJLE2W6ukOgQtoxm7QXyZmrft6OnOGyoBItq0MISLpf5f7FaUetBaGjtDVpubnMDeW
         rhJSHJT9NH5V35mKhf14YUw/DGFHOem+uRP+t7hA=
Date:   Fri, 4 Oct 2019 17:37:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v11 3/6] of: property: Add functional dependency link
 from DT bindings
Message-ID: <20191004153750.GB823823@kroah.com>
References: <20190904211126.47518-1-saravanak@google.com>
 <20190904211126.47518-4-saravanak@google.com>
 <20190911102926.A9F8D2082C@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911102926.A9F8D2082C@mail.kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 11, 2019 at 03:29:25AM -0700, Stephen Boyd wrote:
> Quoting Saravana Kannan (2019-09-04 14:11:22)
> > Add device links after the devices are created (but before they are
> > probed) by looking at common DT bindings like clocks and
> > interconnects.
> > 
> > Automatically adding device links for functional dependencies at the
> > framework level provides the following benefits:
> > 
> > - Optimizes device probe order and avoids the useless work of
> >   attempting probes of devices that will not probe successfully
> >   (because their suppliers aren't present or haven't probed yet).
> > 
> >   For example, in a commonly available mobile SoC, registering just
> >   one consumer device's driver at an initcall level earlier than the
> >   supplier device's driver causes 11 failed probe attempts before the
> >   consumer device probes successfully. This was with a kernel with all
> >   the drivers statically compiled in. This problem gets a lot worse if
> >   all the drivers are loaded as modules without direct symbol
> >   dependencies.
> > 
> > - Supplier devices like clock providers, interconnect providers, etc
> >   need to keep the resources they provide active and at a particular
> >   state(s) during boot up even if their current set of consumers don't
> >   request the resource to be active. This is because the rest of the
> >   consumers might not have probed yet and turning off the resource
> >   before all the consumers have probed could lead to a hang or
> >   undesired user experience.
> > 
> >   Some frameworks (Eg: regulator) handle this today by turning off
> >   "unused" resources at late_initcall_sync and hoping all the devices
> >   have probed by then. This is not a valid assumption for systems with
> >   loadable modules. Other frameworks (Eg: clock) just don't handle
> >   this due to the lack of a clear signal for when they can turn off
> >   resources.
> 
> The clk framework disables unused clks at late_initcall_sync. What do
> you mean clk framework doesn't turn them off because of a clear signal?

There's a number of minor things you pointed out in this review.

Saravana, can you send a follow-on patch for the minor code cleanups
like formatting and the like that was found here?

> > +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> > +{
> > +       struct device *sup_dev;
> > +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> 
> Is it really a u32 instead of an unsigned int or unsigned long?
> 
> > +       int ret = 0;
> > +       struct device_node *tmp_np = sup_np;
> > +
> > +       of_node_get(sup_np);
> > +       /*
> > +        * Find the device node that contains the supplier phandle.  It may be
> > +        * @sup_np or it may be an ancestor of @sup_np.
> > +        */
> > +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> > +               sup_np = of_get_next_parent(sup_np);
> 
> I don't get this. This is assuming that drivers are only probed for
> device nodes that have a compatible string? What about drivers that make
> sub-devices for clk support that have drivers in drivers/clk/ that then
> attach at runtime later? This happens sometimes for MFDs that want to
> split the functionality across the driver tree to the respective
> subsystems.

For that, the link would not be there, correct?

> > +static int of_link_property(struct device *dev, struct device_node *con_np,
> > +                            const char *prop_name)
> > +{
> > +       struct device_node *phandle;
> > +       const struct supplier_bindings *s = bindings;
> > +       unsigned int i = 0;
> > +       bool matched = false;
> > +       int ret = 0;
> > +
> > +       /* Do not stop at first failed link, link all available suppliers. */
> > +       while (!matched && s->parse_prop) {
> > +               while ((phandle = s->parse_prop(con_np, prop_name, i))) {
> > +                       matched = true;
> > +                       i++;
> > +                       if (of_link_to_phandle(dev, phandle) == -EAGAIN)
> > +                               ret = -EAGAIN;
> 
> And don't break?

There was comments before about how this is not needed.  Frank asked
that the comment be removed.  And now you point it out again :)

Look at the comment a few lines up, we have to go through all of the
suppliers.

> > +static int __of_link_to_suppliers(struct device *dev,
> 
> Why the double underscore?
> 
> > +                                 struct device_node *con_np)
> > +{
> > +       struct device_node *child;
> > +       struct property *p;
> > +       int ret = 0;
> > +
> > +       for_each_property_of_node(con_np, p)
> > +               if (of_link_property(dev, con_np, p->name))
> > +                       ret = -EAGAIN;
> 
> Same comment.

Same response as above :)

thanks,

greg k-h
