Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9295CC6A5
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2019 01:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731618AbfJDXrZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Oct 2019 19:47:25 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36627 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731234AbfJDXrY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Oct 2019 19:47:24 -0400
Received: by mail-oi1-f194.google.com with SMTP id k20so7231088oih.3
        for <linux-acpi@vger.kernel.org>; Fri, 04 Oct 2019 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3hvzIJAwdUIDj60PRswdy4jtQ7pq65dmvuMEDrZAxmY=;
        b=sByyKd4dF7wI4oDmjRslrGtLmmRydXZiFQq1Jujk/HqPa81MECMvjff4PRTpIrLM1T
         FtLi6/h2ZbRbvBRXdT6WETrB/ZO8N5CI4HzDQn5YxSPO8hu0y1aCRWAmC7qi8Qm8rLvn
         iQS80cCwjcGnf1mF69Ga/IeY8Ca+re5cJH+xiP5vf//YhD1uxWudUffkfsP2NWIKRS1T
         k9IBszQIRfGPzU18tOeIXFNyApc6D4VwLg0pKtZdq2KYHIrG66Re9wIqbWrEjoNOrCX2
         fJ8CXcYv+khgS7KxwG1LhMPBM7UFAJA83B+9mP+9I+lTIWgRrGjRG/Kbbpv0P/QT72fT
         eNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3hvzIJAwdUIDj60PRswdy4jtQ7pq65dmvuMEDrZAxmY=;
        b=EA5oI9lxSKxj4DMCfFZcedZGOjLpd1U37zC/p9fkKLYPy0g7DwJgf/dgCo1S57AGg3
         t4O99c50+bwoTNLVYygQomDoeGNz1+DVJgrrifHeWdzAaDDRT1hAqGJ1wSabph791huc
         a+OWsZBoCNiCkg8NatFVuxJp2z/s5bzVmJyxwX+DD5+ms773cV8NHEdJPRL2BnD1sXOm
         ZdchXZET08eG4piwscxyaFAxyxi9n4ww5PGNrQT9Hhtxq6L2CvvdzypFC879+CYJI+OE
         MpwCmudz2q8sT3bE+yuOhQsUUHWso4VBhtkaPKA/t/c8lQtcyuPjqN73Px5nd2CamYC5
         eveg==
X-Gm-Message-State: APjAAAU+VBCz1k3d1CbVznf/kspDLEbOIL2SUbvrgtudB7W53MOFB+F5
        fusRMzH9KK78gyX5H1fPIK46Cf7yO2CFE4Le9RbRmQ==
X-Google-Smtp-Source: APXvYqyQuIwtgG5lkzf5p8L7oWSkX7l/6aAhPD0T8bNKplxUKfl+D7zNAdO+WZSNpxhAwm2aZQ2M3v/hP61zb0kEqCg=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr9366466oie.30.1570232843672;
 Fri, 04 Oct 2019 16:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190904211126.47518-1-saravanak@google.com> <20190904211126.47518-4-saravanak@google.com>
 <20190911102926.A9F8D2082C@mail.kernel.org> <20191004153750.GB823823@kroah.com>
In-Reply-To: <20191004153750.GB823823@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 4 Oct 2019 16:46:47 -0700
Message-ID: <CAGETcx-TFL3OAtPvU9_Sjovz4zk+YU+S7yAC7T0Vo7aRuQdWAA@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] of: property: Add functional dependency link from
 DT bindings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Collins <collinsd@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 4, 2019 at 8:37 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 11, 2019 at 03:29:25AM -0700, Stephen Boyd wrote:
> > Quoting Saravana Kannan (2019-09-04 14:11:22)
> > > Add device links after the devices are created (but before they are
> > > probed) by looking at common DT bindings like clocks and
> > > interconnects.
> > >
> > > Automatically adding device links for functional dependencies at the
> > > framework level provides the following benefits:
> > >
> > > - Optimizes device probe order and avoids the useless work of
> > >   attempting probes of devices that will not probe successfully
> > >   (because their suppliers aren't present or haven't probed yet).
> > >
> > >   For example, in a commonly available mobile SoC, registering just
> > >   one consumer device's driver at an initcall level earlier than the
> > >   supplier device's driver causes 11 failed probe attempts before the
> > >   consumer device probes successfully. This was with a kernel with all
> > >   the drivers statically compiled in. This problem gets a lot worse if
> > >   all the drivers are loaded as modules without direct symbol
> > >   dependencies.
> > >
> > > - Supplier devices like clock providers, interconnect providers, etc
> > >   need to keep the resources they provide active and at a particular
> > >   state(s) during boot up even if their current set of consumers don't
> > >   request the resource to be active. This is because the rest of the
> > >   consumers might not have probed yet and turning off the resource
> > >   before all the consumers have probed could lead to a hang or
> > >   undesired user experience.
> > >
> > >   Some frameworks (Eg: regulator) handle this today by turning off
> > >   "unused" resources at late_initcall_sync and hoping all the devices
> > >   have probed by then. This is not a valid assumption for systems with
> > >   loadable modules. Other frameworks (Eg: clock) just don't handle
> > >   this due to the lack of a clear signal for when they can turn off
> > >   resources.
> >
> > The clk framework disables unused clks at late_initcall_sync. What do
> > you mean clk framework doesn't turn them off because of a clear signal?
>
> There's a number of minor things you pointed out in this review.
>
> Saravana, can you send a follow-on patch for the minor code cleanups
> like formatting and the like that was found here?

Will do next week.

Thanks,
Saravana

>
> > > +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> > > +{
> > > +       struct device *sup_dev;
> > > +       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> >
> > Is it really a u32 instead of an unsigned int or unsigned long?
> >
> > > +       int ret = 0;
> > > +       struct device_node *tmp_np = sup_np;
> > > +
> > > +       of_node_get(sup_np);
> > > +       /*
> > > +        * Find the device node that contains the supplier phandle.  It may be
> > > +        * @sup_np or it may be an ancestor of @sup_np.
> > > +        */
> > > +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> > > +               sup_np = of_get_next_parent(sup_np);
> >
> > I don't get this. This is assuming that drivers are only probed for
> > device nodes that have a compatible string? What about drivers that make
> > sub-devices for clk support that have drivers in drivers/clk/ that then
> > attach at runtime later? This happens sometimes for MFDs that want to
> > split the functionality across the driver tree to the respective
> > subsystems.
>
> For that, the link would not be there, correct?
>
> > > +static int of_link_property(struct device *dev, struct device_node *con_np,
> > > +                            const char *prop_name)
> > > +{
> > > +       struct device_node *phandle;
> > > +       const struct supplier_bindings *s = bindings;
> > > +       unsigned int i = 0;
> > > +       bool matched = false;
> > > +       int ret = 0;
> > > +
> > > +       /* Do not stop at first failed link, link all available suppliers. */
> > > +       while (!matched && s->parse_prop) {
> > > +               while ((phandle = s->parse_prop(con_np, prop_name, i))) {
> > > +                       matched = true;
> > > +                       i++;
> > > +                       if (of_link_to_phandle(dev, phandle) == -EAGAIN)
> > > +                               ret = -EAGAIN;
> >
> > And don't break?
>
> There was comments before about how this is not needed.  Frank asked
> that the comment be removed.  And now you point it out again :)
>
> Look at the comment a few lines up, we have to go through all of the
> suppliers.
>
> > > +static int __of_link_to_suppliers(struct device *dev,
> >
> > Why the double underscore?
> >
> > > +                                 struct device_node *con_np)
> > > +{
> > > +       struct device_node *child;
> > > +       struct property *p;
> > > +       int ret = 0;
> > > +
> > > +       for_each_property_of_node(con_np, p)
> > > +               if (of_link_property(dev, con_np, p->name))
> > > +                       ret = -EAGAIN;
> >
> > Same comment.
>
> Same response as above :)
>
> thanks,
>
> greg k-h
