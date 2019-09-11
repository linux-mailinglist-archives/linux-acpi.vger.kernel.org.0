Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1F7AFA5A
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Sep 2019 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfIKK32 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Sep 2019 06:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfIKK32 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Sep 2019 06:29:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F8D2082C;
        Wed, 11 Sep 2019 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568197766;
        bh=2QH9tO++sD0K1VC26C41JauePumM5ZNCTIM+ZgvwDfI=;
        h=In-Reply-To:References:Cc:To:From:Subject:Date:From;
        b=lCE390KFYmAWmZPIxkVfJEsfInsTl4uvMYnQRhhv63zcaEXPWj1T6DfKycsZtxi58
         rykHZYgwLMzQUe2pvUUwXRAcxVh9y9Fx1UhLC/iu1F8XG7FDlJI5uvJAW5i1P77DXT
         ltfYAV4Yr7iV9j3260uIJ8UTBziw+4YR2rFwKl+I=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190904211126.47518-4-saravanak@google.com>
References: <20190904211126.47518-1-saravanak@google.com> <20190904211126.47518-4-saravanak@google.com>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com, kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v11 3/6] of: property: Add functional dependency link from DT bindings
User-Agent: alot/0.8.1
Date:   Wed, 11 Sep 2019 03:29:25 -0700
Message-Id: <20190911102926.A9F8D2082C@mail.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Saravana Kannan (2019-09-04 14:11:22)
> Add device links after the devices are created (but before they are
> probed) by looking at common DT bindings like clocks and
> interconnects.
>=20
> Automatically adding device links for functional dependencies at the
> framework level provides the following benefits:
>=20
> - Optimizes device probe order and avoids the useless work of
>   attempting probes of devices that will not probe successfully
>   (because their suppliers aren't present or haven't probed yet).
>=20
>   For example, in a commonly available mobile SoC, registering just
>   one consumer device's driver at an initcall level earlier than the
>   supplier device's driver causes 11 failed probe attempts before the
>   consumer device probes successfully. This was with a kernel with all
>   the drivers statically compiled in. This problem gets a lot worse if
>   all the drivers are loaded as modules without direct symbol
>   dependencies.
>=20
> - Supplier devices like clock providers, interconnect providers, etc
>   need to keep the resources they provide active and at a particular
>   state(s) during boot up even if their current set of consumers don't
>   request the resource to be active. This is because the rest of the
>   consumers might not have probed yet and turning off the resource
>   before all the consumers have probed could lead to a hang or
>   undesired user experience.
>=20
>   Some frameworks (Eg: regulator) handle this today by turning off
>   "unused" resources at late_initcall_sync and hoping all the devices
>   have probed by then. This is not a valid assumption for systems with
>   loadable modules. Other frameworks (Eg: clock) just don't handle
>   this due to the lack of a clear signal for when they can turn off
>   resources.

The clk framework disables unused clks at late_initcall_sync. What do
you mean clk framework doesn't turn them off because of a clear signal?

> This leads to downstream hacks to handle cases like this
>   that can easily be solved in the upstream kernel.
>=20
>   By linking devices before they are probed, we give suppliers a clear
>   count of the number of dependent consumers. Once all of the
>   consumers are active, the suppliers can turn off the unused
>   resources without making assumptions about the number of consumers.
>=20
> By default we just add device-links to track "driver presence" (probe
> succeeded) of the supplier device. If any other functionality provided
> by device-links are needed, it is left to the consumer/supplier
> devices to change the link when they probe.
>=20

Are there tabs above? Indentation looks off.

> diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentat=
ion/admin-guide/kernel-parameters.rst
> index d05d531b4ec9..6d421694d98e 100644
> --- a/Documentation/admin-guide/kernel-parameters.rst
> +++ b/Documentation/admin-guide/kernel-parameters.rst
> @@ -127,6 +127,7 @@ parameter is applicable::
>         NET     Appropriate network support is enabled.
>         NUMA    NUMA support is enabled.
>         NFS     Appropriate NFS support is enabled.
> +       OF      Devicetree is enabled.
>         OSS     OSS sound support is enabled.
>         PV_OPS  A paravirtualized kernel is enabled.
>         PARIDE  The ParIDE (parallel port IDE) subsystem is enabled.

This could be split off and applied for dt_cpu_ftrs=3D in
Documentation/admin-guide/kernel-parameters.txt

> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index d7fa75e31f22..23b5ee5b0570 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -25,6 +25,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/string.h>
> +#include <linux/moduleparam.h>
> =20
>  #include "of_private.h"
> =20
> @@ -985,6 +986,245 @@ of_fwnode_device_get_match_data(const struct fwnode=
_handle *fwnode,
>         return of_device_get_match_data(dev);
>  }
> =20
> +static bool of_is_ancestor_of(struct device_node *test_ancestor,

Maybe add kernel-doc indicating that this function returns with the
of_node requiring an of_node_put() call on it, unless it returns false
in which case it doesn't?

> +                             struct device_node *child)
> +{
> +       of_node_get(child);
> +       while (child) {
> +               if (child =3D=3D test_ancestor) {
> +                       of_node_put(child);
> +                       return false;
> +               }
> +               child =3D of_get_next_parent(child);
> +       }
> +       return true;
> +}
> +
> +/**
> + * of_link_to_phandle - Add device link to supplier from supplier phandle
> + * @dev: consumer device
> + * @sup_np: phandle to supplier device tree node
> + *
> + * Given a phandle to a supplier device tree node (@sup_np), this functi=
on
> + * finds the device that owns the supplier device tree node and creates a
> + * device link from @dev consumer device to the supplier device. This fu=
nction
> + * doesn't create device links for invalid scenarios such as trying to c=
reate a
> + * link with a parent device as the consumer of its child device. In such
> + * cases, it returns an error.

Doesn't device links have problems with making cycles between providers
and consumers? We have some scenarios where two clk providers are
consumers of each other but it isn't a parent child relationship.
They're peers on the SoC bus and there isn't a cycle in the clk tree but
there is a cycle between the two device nodes and providers. I don't see
the avoidance here but maybe I missed something?

> + *
> + * Returns:
> + * - 0 if link successfully created to supplier
> + * - -EAGAIN if linking to the supplier should be reattempted
> + * - -EINVAL if the supplier link is invalid and should not be created
> + * - -ENODEV if there is no device that corresponds to the supplier phan=
dle
> + */
> +static int of_link_to_phandle(struct device *dev, struct device_node *su=
p_np)
> +{
> +       struct device *sup_dev;
> +       u32 dl_flags =3D DL_FLAG_AUTOPROBE_CONSUMER;

Is it really a u32 instead of an unsigned int or unsigned long?

> +       int ret =3D 0;
> +       struct device_node *tmp_np =3D sup_np;
> +
> +       of_node_get(sup_np);
> +       /*
> +        * Find the device node that contains the supplier phandle.  It m=
ay be
> +        * @sup_np or it may be an ancestor of @sup_np.
> +        */
> +       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> +               sup_np =3D of_get_next_parent(sup_np);

I don't get this. This is assuming that drivers are only probed for
device nodes that have a compatible string? What about drivers that make
sub-devices for clk support that have drivers in drivers/clk/ that then
attach at runtime later? This happens sometimes for MFDs that want to
split the functionality across the driver tree to the respective
subsystems.

> +       if (!sup_np) {
> +               dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np=
);
> +               return -ENODEV;
> +       }
> +
> +       /*
> +        * Don't allow linking a device node as a consumer of one of its
> +        * descendant nodes. By definition, a child node can't be a funct=
ional
> +        * dependency for the parent node.
> +        */
> +       if (!of_is_ancestor_of(dev->of_node, sup_np)) {
> +               dev_dbg(dev, "Not linking to %pOFP - is descendant\n", su=
p_np);
> +               of_node_put(sup_np);
> +               return -EINVAL;
> +       }
> +       sup_dev =3D get_dev_from_fwnode(&sup_np->fwnode);
> +       of_node_put(sup_np);
> +       if (!sup_dev)
> +               return -EAGAIN;
> +       if (!device_link_add(dev, sup_dev, dl_flags))
> +               ret =3D -EAGAIN;
> +       put_device(sup_dev);
> +       return ret;
> +}
> +
> +/**
> + * parse_prop_cells - Property parsing function for suppliers
> + *
> + * @np:                Pointer to device tree node containing a list
> + * @prop_name: Name of property to be parsed. Expected to hold phandle v=
alues
> + * @index:     For properties holding a list of phandles, this is the in=
dex
> + *             into the list.
> + * @list_name: Property name that is known to contain list of phandle(s)=
 to
> + *             supplier(s)
> + * @cells_name:        property name that specifies phandles' arguments =
count
> + *
> + * This is a helper function to parse properties that have a known fixed=
 name
> + * and are a list of phandles and phandle arguments.
> + *
> + * Returns:
> + * - phandle node pointer with refcount incremented. Caller must of_node=
_put()
> + *   on it when done.
> + * - NULL if no phandle found at index
> + */
> +static struct device_node *parse_prop_cells(struct device_node *np,
> +                                           const char *prop_name, int in=
dex,
> +                                           const char *list_name,
> +                                           const char *cells_name)
> +{
> +       struct of_phandle_args sup_args;
> +
> +       if (strcmp(prop_name, list_name))
> +               return NULL;
> +
> +       if (of_parse_phandle_with_args(np, list_name, cells_name, index,
> +                                      &sup_args))
> +               return NULL;
> +
> +       return sup_args.np;
> +}
> +
> +static struct device_node *parse_clocks(struct device_node *np,
> +                                       const char *prop_name, int index)
> +{
> +       return parse_prop_cells(np, prop_name, index, "clocks", "#clock-c=
ells");
> +}

Can this use of_parse_clkspec() instead? If it is exported out of the
clk framework (which is weird to me for other reasons) then it should
work to call that with the index passed in to this function. Ideally we
don't have more than one place where we parse clock specifiers for a
node.

Another question is what happens for devices that are in DT but are
using "clock-ranges"? As far as I know there are some DTS files that use
that property to only send the clocks to some bus node that then lets
devices find the "clocks" and "clock-names" properties from the bus node
instead of from the node that corresponds to their device.

> +
> +static struct device_node *parse_interconnects(struct device_node *np,
> +                                              const char *prop_name, int=
 index)
> +{
> +       return parse_prop_cells(np, prop_name, index, "interconnects",
> +                               "#interconnect-cells");
> +}
> +
> +static int strcmp_suffix(const char *str, const char *suffix)

And this doesn't go to lib/string.c why?

> +{
> +       unsigned int len, suffix_len;
> +
> +       len =3D strlen(str);
> +       suffix_len =3D strlen(suffix);
> +       if (len <=3D suffix_len)
> +               return -1;
> +       return strcmp(str + len - suffix_len, suffix);
> +}
> +
> +static struct device_node *parse_regulators(struct device_node *np,
> +                                           const char *prop_name, int in=
dex)
> +{
> +       if (index || strcmp_suffix(prop_name, "-supply"))
> +               return NULL;
> +
> +       return of_parse_phandle(np, prop_name, 0);
> +}
> +
> +/**
> + * struct supplier_bindings - Property parsing functions for suppliers
> + *
> + * @parse_prop: function name
> + *     parse_prop() finds the node corresponding to a supplier phandle
> + * @parse_prop.np: Pointer to device node holding supplier phandle prope=
rty
> + * @parse_prop.prop_name: Name of property holding a phandle value
> + * @parse_prop.index: For properties holding a list of phandles, this is=
 the
> + *                   index into the list

This is interesting kernel-doc. I've never seen it before. Does it work?

> + *
> + * Returns:
> + * parse_prop() return values are
> + * - phandle node pointer with refcount incremented. Caller must of_node=
_put()
> + *   on it when done.
> + * - NULL if no phandle found at index
> + */
> +struct supplier_bindings {
> +       struct device_node *(*parse_prop)(struct device_node *np,
> +                                         const char *prop_name, int inde=
x);

Maybe this should be a typedef instead of a struct unless you plan to
put more members in this struct? Or are arrays of function pointers
impossible?

> +};
> +
> +static const struct supplier_bindings bindings[] =3D {

This variable name is really bad. Please make it much more specific to
this file instead of being called 'bindings' so that grepping for it and
looking for it in kallsyms isn't difficult.

> +       { .parse_prop =3D parse_clocks, },
> +       { .parse_prop =3D parse_interconnects, },
> +       { .parse_prop =3D parse_regulators, },
> +       {},

Nitpick: Don't put a comma after the sentinel so that it causes a
compile error to follow it with another "valid" entry.

> +};
> +
> +/**
> + * of_link_property - Create device links to suppliers listed in a prope=
rty
> + * @dev: Consumer device
> + * @con_np: The consumer device tree node which contains the property
> + * @prop_name: Name of property to be parsed
> + *
> + * This function checks if the property @prop_name that is present in the
> + * @con_np device tree node is one of the known common device tree bindi=
ngs
> + * that list phandles to suppliers. If @prop_name isn't one, this functi=
on
> + * doesn't do anything.
> + *
> + * If @prop_name is one, this function attempts to create device links f=
rom the
> + * consumer device @dev to all the devices of the suppliers listed in
> + * @prop_name.
> + *
> + * Any failed attempt to create a device link will NOT result in an imme=
diate
> + * return.  of_link_property() must create links to all the available su=
pplier
> + * devices even when attempts to create a link to one or more suppliers =
fail.
> + */
> +static int of_link_property(struct device *dev, struct device_node *con_=
np,
> +                            const char *prop_name)
> +{
> +       struct device_node *phandle;
> +       const struct supplier_bindings *s =3D bindings;
> +       unsigned int i =3D 0;
> +       bool matched =3D false;
> +       int ret =3D 0;
> +
> +       /* Do not stop at first failed link, link all available suppliers=
. */
> +       while (!matched && s->parse_prop) {
> +               while ((phandle =3D s->parse_prop(con_np, prop_name, i)))=
 {
> +                       matched =3D true;
> +                       i++;
> +                       if (of_link_to_phandle(dev, phandle) =3D=3D -EAGA=
IN)
> +                               ret =3D -EAGAIN;

And don't break?

> +                       of_node_put(phandle);
> +               }
> +               s++;
> +       }
> +       return ret;
> +}
> +
> +static int __of_link_to_suppliers(struct device *dev,

Why the double underscore?

> +                                 struct device_node *con_np)
> +{
> +       struct device_node *child;
> +       struct property *p;
> +       int ret =3D 0;
> +
> +       for_each_property_of_node(con_np, p)
> +               if (of_link_property(dev, con_np, p->name))
> +                       ret =3D -EAGAIN;

Same comment.

> +
> +       return ret;
> +}
