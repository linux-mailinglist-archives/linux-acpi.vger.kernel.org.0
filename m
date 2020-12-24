Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DD62E26F9
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 13:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgLXM4G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 07:56:06 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46316 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgLXM4F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 07:56:05 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89B6CA1D;
        Thu, 24 Dec 2020 13:55:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608814522;
        bh=vdQrgqNa1TiikvlUXAcbMyAF84ZPZrALP2GLp8KKG18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hsNkO0Ehz7i1XDTGj0XDsADHRkgLU+aASLzYqYmQ/el3C8JR5UeK1QpF80Jhcp8Pk
         ofM7145UVyy7I9eyYhBHIA2yj1FTKSj0g8LcynBD4e9RGWSzyYzrGhLxVhSoWD+DP5
         ZVM77eK7f+Vqo5czQfTENomCT+/D+aIJdyBgQNcs=
Date:   Thu, 24 Dec 2020 14:55:14 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devel@acpica.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        kieran.bingham+renesas@ideasonboard.com,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        niklas.soderlund+renesas@ragnatech.se,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 07/14] software_node: Add support for fwnode_graph*()
 family of functions
Message-ID: <X+SPsks5itN9OFqB@pendragon.ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-8-djrscally@gmail.com>
 <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vft7gg1AcKCEU+E74eB_ZMouHFd-8uZ7pcVj5CoJzZpvQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,

On Thu, Dec 24, 2020 at 02:24:12PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 3:14 AM Daniel Scally wrote:
> >
> > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> > This implements the remaining .graph_* callbacks in the
> 
> .graph_* ==> ->graph_*() ?
> 
> > fwnode operations structure for the software nodes. That makes
> > the fwnode_graph*() functions available in the drivers also
> 
> graph*() -> graph_*() ?
> 
> > when software nodes are used.
> >
> > The implementation tries to mimic the "OF graph" as much as
> > possible, but there is no support for the "reg" device
> > property. The ports will need to have the index in their
> > name which starts with "port@" (for example "port@0", "port@1",
> 
> > ...)
> 
> Looks not good, perhaps move to the previous line, or move port@1 example here?
> 
> > and endpoints will use the index of the software node
> > that is given to them during creation. The port nodes can
> > also be grouped under a specially named "ports" subnode,
> > just like in DT, if necessary.
> >
> > The remote-endpoints are reference properties under the
> > endpoint nodes that are named "remote-endpoint".
> 
> Few nitpicks here and there, after addressing them,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Co-developed-by: Daniel Scally <djrscally@gmail.com>
> > Signed-off-by: Daniel Scally <djrscally@gmail.com>
> > ---
> > Changes in v3
> >         - Changed software_node_get_next_endpoint() to drop the variable
> >         named "old"
> >         - Used the macros defined in 06/14 instead of magic numbers
> >         - Added some comments to explain behaviour a little where it's unclear
> >
> >  drivers/base/swnode.c | 112 +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 111 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 2d07eb04c6c8..ff690029060d 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -540,6 +540,112 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
> >         return 0;
> >  }
> >
> > +static struct fwnode_handle *
> > +swnode_graph_find_next_port(const struct fwnode_handle *parent,
> > +                           struct fwnode_handle *port)
> > +{
> > +       struct fwnode_handle *old = port;
> > +
> > +       while ((port = software_node_get_next_child(parent, old))) {
> > +               /*
> > +                * ports have naming style "port@n", so we search for children
> > +                * that follow that convention (but without assuming anything
> > +                * about the index number)
> > +                */
> 
> > +               if (!strncmp(to_swnode(port)->node->name, "port@",
> 
> You may use here corresponding _FMT macro.
> 
> > +                            FWNODE_GRAPH_PORT_NAME_PREFIX_LEN))
> > +                       return port;
> > +               old = port;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +static struct fwnode_handle *
> > +software_node_graph_get_next_endpoint(const struct fwnode_handle *fwnode,
> > +                                     struct fwnode_handle *endpoint)
> > +{
> > +       struct swnode *swnode = to_swnode(fwnode);
> > +       struct fwnode_handle *parent;
> > +       struct fwnode_handle *port;
> > +
> > +       if (!swnode)
> > +               return NULL;
> > +
> > +       if (endpoint) {
> > +               port = software_node_get_parent(endpoint);
> > +               parent = software_node_get_parent(port);
> > +       } else {
> > +               parent = software_node_get_named_child_node(fwnode, "ports");
> > +               if (!parent)
> > +                       parent = software_node_get(&swnode->fwnode);
> > +
> > +               port = swnode_graph_find_next_port(parent, NULL);
> > +       }
> > +
> > +       for (; port; port = swnode_graph_find_next_port(parent, port)) {
> > +               endpoint = software_node_get_next_child(port, endpoint);
> > +               if (endpoint) {
> > +                       fwnode_handle_put(port);
> > +                       break;
> > +               }
> > +       }
> > +
> > +       fwnode_handle_put(parent);
> > +
> > +       return endpoint;
> > +}
> > +
> > +static struct fwnode_handle *
> > +software_node_graph_get_remote_endpoint(const struct fwnode_handle *fwnode)
> > +{
> > +       struct swnode *swnode = to_swnode(fwnode);
> > +       const struct software_node_ref_args *ref;
> > +       const struct property_entry *prop;
> > +
> > +       if (!swnode)
> > +               return NULL;
> > +
> > +       prop = property_entry_get(swnode->node->properties, "remote-endpoint");
> > +       if (!prop || prop->type != DEV_PROP_REF || prop->is_inline)
> > +               return NULL;
> > +
> > +       ref = prop->pointer;
> > +
> > +       return software_node_get(software_node_fwnode(ref[0].node));
> > +}
> > +
> > +static struct fwnode_handle *
> > +software_node_graph_get_port_parent(struct fwnode_handle *fwnode)
> > +{
> > +       struct swnode *swnode = to_swnode(fwnode);
> > +
> > +       swnode = swnode->parent;
> > +       if (swnode && !strcmp(swnode->node->name, "ports"))
> > +               swnode = swnode->parent;
> > +
> > +       return swnode ? software_node_get(&swnode->fwnode) : NULL;
> > +}
> > +
> > +static int
> > +software_node_graph_parse_endpoint(const struct fwnode_handle *fwnode,
> > +                                  struct fwnode_endpoint *endpoint)
> > +{
> > +       struct swnode *swnode = to_swnode(fwnode);
> > +       int ret;
> > +
> > +       /* Ports have naming style "port@n", we need to select the n */
> 
> > +       ret = kstrtou32(swnode->parent->node->name + FWNODE_GRAPH_PORT_NAME_PREFIX_LEN,
> 
> Maybe a temporary variable?
> 
>   unsigned int prefix_len = FWNODE_GRAPH_PORT_NAME_PREFIX_LEN;
>   ...
>   ret = kstrtou32(swnode->parent->node->name + prefix_len,

Honestly I'm wondering if those macros don't hinder readability. I'd
rather write

	+ strlen("port@")

and let the compiler optimize this to a compile-time constant.

> > +                       10, &endpoint->port);
> > +       if (ret)
> > +               return ret;
> > +
> > +       endpoint->id = swnode->id;
> > +       endpoint->local_fwnode = fwnode;
> > +
> > +       return 0;
> > +}
> > +
> >  static const struct fwnode_operations software_node_ops = {
> >         .get = software_node_get,
> >         .put = software_node_put,
> > @@ -551,7 +657,11 @@ static const struct fwnode_operations software_node_ops = {
> >         .get_parent = software_node_get_parent,
> >         .get_next_child_node = software_node_get_next_child,
> >         .get_named_child_node = software_node_get_named_child_node,
> > -       .get_reference_args = software_node_get_reference_args
> > +       .get_reference_args = software_node_get_reference_args,
> > +       .graph_get_next_endpoint = software_node_graph_get_next_endpoint,
> > +       .graph_get_remote_endpoint = software_node_graph_get_remote_endpoint,
> > +       .graph_get_port_parent = software_node_graph_get_port_parent,
> > +       .graph_parse_endpoint = software_node_graph_parse_endpoint,
> >  };
> >
> >  /* -------------------------------------------------------------------------- */

-- 
Regards,

Laurent Pinchart
