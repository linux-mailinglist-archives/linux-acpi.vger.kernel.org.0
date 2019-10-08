Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D568ACFCD6
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2019 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfJHOxF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Oct 2019 10:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfJHOxF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Oct 2019 10:53:05 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD54205F4;
        Tue,  8 Oct 2019 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570546384;
        bh=HOwqEJnzYDjyfyw62/mg9zQ47IpabGqcr9GPShPewjw=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=mP2igvVtEnU1PgLtbmQACDyWbD4aoBpJBBrrLBjxggACvfraDKHi4zZDk79r5IIN1
         Zm+YM6bz23bgxX4MH4LMGQ73emCqM/L3TQI0QOgO5qIfGflaeDpamPjMRNbfbYUWQB
         bGsUAMhvMc+Yny1vE6Oo9fWzD78hxwR50oplwcvk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191004153750.GB823823@kroah.com>
References: <20190904211126.47518-1-saravanak@google.com> <20190904211126.47518-4-saravanak@google.com> <20190911102926.A9F8D2082C@mail.kernel.org> <20191004153750.GB823823@kroah.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Subject: Re: [PATCH v11 3/6] of: property: Add functional dependency link from DT bindings
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 07:53:02 -0700
Message-Id: <20191008145304.2BD54205F4@mail.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Greg Kroah-Hartman (2019-10-04 08:37:50)
> On Wed, Sep 11, 2019 at 03:29:25AM -0700, Stephen Boyd wrote:
> > Quoting Saravana Kannan (2019-09-04 14:11:22)
> > > +       int ret =3D 0;
> > > +       struct device_node *tmp_np =3D sup_np;
> > > +
> > > +       of_node_get(sup_np);
> > > +       /*
> > > +        * Find the device node that contains the supplier phandle.  =
It may be
> > > +        * @sup_np or it may be an ancestor of @sup_np.
> > > +        */
> > > +       while (sup_np && !of_find_property(sup_np, "compatible", NULL=
))
> > > +               sup_np =3D of_get_next_parent(sup_np);
> >=20
> > I don't get this. This is assuming that drivers are only probed for
> > device nodes that have a compatible string? What about drivers that make
> > sub-devices for clk support that have drivers in drivers/clk/ that then
> > attach at runtime later? This happens sometimes for MFDs that want to
> > split the functionality across the driver tree to the respective
> > subsystems.
>=20
> For that, the link would not be there, correct?

The parent device (MFD) would have the links because that is the device
node with the provider property like '#clock-cells'. The child clk
device that's populated by the MFD would be the one actually providing
the clk via a driver that may probe any time later, or never, depending
on if the clk driver is configured as a module or not. I fail to see how
this will work for these cases.

Is this logic there to find the parent of a regulator phandle and match
that to some driver? It looks like it.

>=20
> > > +static int of_link_property(struct device *dev, struct device_node *=
con_np,
> > > +                            const char *prop_name)
> > > +{
> > > +       struct device_node *phandle;
> > > +       const struct supplier_bindings *s =3D bindings;
> > > +       unsigned int i =3D 0;
> > > +       bool matched =3D false;
> > > +       int ret =3D 0;
> > > +
> > > +       /* Do not stop at first failed link, link all available suppl=
iers. */
> > > +       while (!matched && s->parse_prop) {
> > > +               while ((phandle =3D s->parse_prop(con_np, prop_name, =
i))) {
> > > +                       matched =3D true;
> > > +                       i++;
> > > +                       if (of_link_to_phandle(dev, phandle) =3D=3D -=
EAGAIN)
> > > +                               ret =3D -EAGAIN;
> >=20
> > And don't break?
>=20
> There was comments before about how this is not needed.  Frank asked
> that the comment be removed.  And now you point it out again :)
>=20
> Look at the comment a few lines up, we have to go through all of the
> suppliers.
>=20

Ok. The comment tells me what is happening but it misses the essential
part which is _why_ we must make links to each supplier and return
-EAGAIN.

