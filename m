Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 953A5D9B4A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfJPUPG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 16:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732607AbfJPUPG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 16 Oct 2019 16:15:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8810120659;
        Wed, 16 Oct 2019 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571256904;
        bh=RKuiPtNCZS/1l7g/H5esKdXCQ13IvDoiKYefxqGO+rE=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=dsobUYKKZjaVAYCLzAVo2RAlCOYiB9KRVsKDDq+u9RbLCkjf1T8X37qZ+akdIwmHi
         2TPsyunRS5GLZ/4PXt4qg5ezfuiuCJ/kaRV3GraZIR+hUlz/+pevd0C0MGPIevzwrw
         gqa2hQ8446Y1FNGtq+LfbQUQc+y/8bql+JxmqIhw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx-FjF+bktBgL6h0ORH3MU4vMM9JNC2oB8Myn8KqvnmhDg@mail.gmail.com>
References: <20190904211126.47518-1-saravanak@google.com> <20190904211126.47518-4-saravanak@google.com> <20190911102926.A9F8D2082C@mail.kernel.org> <20191004153750.GB823823@kroah.com> <20191008145304.2BD54205F4@mail.kernel.org> <CAGETcx-FjF+bktBgL6h0ORH3MU4vMM9JNC2oB8Myn8KqvnmhDg@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v11 3/6] of: property: Add functional dependency link from DT bindings
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 13:15:03 -0700
Message-Id: <20191016201504.8810120659@mail.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Saravana Kannan (2019-10-08 11:57:49)
> On Tue, Oct 8, 2019 at 7:53 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Greg Kroah-Hartman (2019-10-04 08:37:50)
> > > On Wed, Sep 11, 2019 at 03:29:25AM -0700, Stephen Boyd wrote:
> > > > Quoting Saravana Kannan (2019-09-04 14:11:22)
> > > > > +       int ret =3D 0;
> > > > > +       struct device_node *tmp_np =3D sup_np;
> > > > > +
> > > > > +       of_node_get(sup_np);
> > > > > +       /*
> > > > > +        * Find the device node that contains the supplier phandl=
e.  It may be
> > > > > +        * @sup_np or it may be an ancestor of @sup_np.
> > > > > +        */
> > > > > +       while (sup_np && !of_find_property(sup_np, "compatible", =
NULL))
> > > > > +               sup_np =3D of_get_next_parent(sup_np);
> > > >
> > > > I don't get this. This is assuming that drivers are only probed for
> > > > device nodes that have a compatible string? What about drivers that=
 make
> > > > sub-devices for clk support that have drivers in drivers/clk/ that =
then
> > > > attach at runtime later? This happens sometimes for MFDs that want =
to
> > > > split the functionality across the driver tree to the respective
> > > > subsystems.
> > >
> > > For that, the link would not be there, correct?
> >
> > The parent device (MFD) would have the links because that is the device
> > node with the provider property like '#clock-cells'. The child clk
> > device that's populated by the MFD would be the one actually providing
> > the clk via a driver that may probe any time later, or never, depending
> > on if the clk driver is configured as a module or not. I fail to see how
> > this will work for these cases.
> >
> > Is this logic there to find the parent of a regulator phandle and match
> > that to some driver? It looks like it.
>=20
> In the case of an MFD creating "fake" children devices, the parent MFD
> device's driver is responsible for handling the sync state callback.
> It'll get the sync_state callback after all the child devices'
> consumers have probed. The MFD driver will need to do the sync state
> clean up for the children devices or pass it on to the child devices'
> drivers (whatever makes sense for that specific MFD) by whatever means
> those specific drivers talk to each other (direct calls, registering
> callbacks, etc).
>=20
> If they are real sub-devices, then they should really be captured in
> DT as child devices and then the child device's drivers will get the
> sync state callback directly.

It seems sort of hand-wavy at the moment. Is the plan to actually
implement this for MFDs that are doing these things? It's really hard to
understand this patch series without any actual users.

From my perspective using driver probe as the signal that some resource
like clks or regulators has been consumed and configured into the proper
state is completely wrong. It makes a large assumption that driver probe
is actually putting the device into some state that has taken over
ownership of the device state by the time probe returns. That isn't
always the case when you consider things like the display or GPU don't
do much until their device is opened by userspace.

It would be better to involve the various kernel frameworks in this
decision by having those frameworks intercept the acquisition of the
resources they provide and track consumers to the point where we can be
certain all consumers have requested and configured the resources they
need to operate properly without something go wrong. Maybe we need
drivers to indicate this to frameworks somehow so that we don't turn the
regulator off for the screen when the screen driver probes but the GPU
driver hasn't started drawing anything there because userspace isn't
running yet?

I'm trying to take a step back and understand the bigger picture here.
From what I can tell we're trying to answer the question "When have all
the consumers of this resource put their constraints in place?" This is
because we want to actively cleanup resources that have been left on or
misconfigured by bootloader/firmware code but we can't be certain when
to do that and if we should do that at all. Is that right?

