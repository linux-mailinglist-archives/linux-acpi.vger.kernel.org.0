Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F512E26EB
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Dec 2020 13:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLXMmh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Dec 2020 07:42:37 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:46178 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgLXMmg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2020 07:42:36 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AC005A1D;
        Thu, 24 Dec 2020 13:41:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608813712;
        bh=J/8sxE1HCRi3qy+XlujR1ZWY51W837kVZDGvsYwH3VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrcTe9Wv7dxB/G451JnRL2NfU6J+09V4l9RjvYlsNUOfkswXW2TDbY7qjQDzEP1iv
         aGoHkXR39j3JqD8l1lvspdWNuDuly1ZF6M1En3YyMzN5r1UlUnZW+oY6fJmFYULiI0
         vzCot/qducG4HcxNTUml86J/ZTviHLi8ktaJDVwA=
Date:   Thu, 24 Dec 2020 14:41:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Subject: Re: [PATCH v3 06/14] include: fwnode.h: Define format macros for
 ports and endpoints
Message-ID: <X+SMiJ1dC7AlZZI+@pendragon.ideasonboard.com>
References: <20201224010907.263125-1-djrscally@gmail.com>
 <20201224010907.263125-7-djrscally@gmail.com>
 <CAHp75Ve8YRygEn3wcbmnSPthG+R_-9hhkAdMLk7jgiPi=jnJ5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Ve8YRygEn3wcbmnSPthG+R_-9hhkAdMLk7jgiPi=jnJ5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

Thank you for the patch.

On Thu, Dec 24, 2020 at 02:17:07PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 24, 2020 at 3:12 AM Daniel Scally wrote:
> >
> > OF, ACPI and software_nodes all implement graphs including nodes for ports
> > and endpoints. These are all intended to be named with a common schema,
> > as "port@n" and "endpoint@n" where n is an unsigned int representing the
> > index of the node. To ensure commonality across the subsystems, provide a
> > set of macros to define the format.
> 
> Nitpicks below, but in general that's what I meant, thanks!
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> (after addressing nitpicks)
> 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Daniel Scally <djrscally@gmail.com>
> > ---
> > Changes in v3
> >         - Patch introduced
> >
> >  include/linux/fwnode.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> > index 9506f8ec0974..52889efceb7d 100644
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -32,6 +32,19 @@ struct fwnode_endpoint {
> >         const struct fwnode_handle *local_fwnode;
> >  };
> >
> > +/*
> > + * ports and endpoints defined in OF, ACPI and as software_nodes should all
> > + * follow a common naming scheme; use these macros to ensure commonality across
> > + * the subsystems.
> > + *
> > + * The *PREFIX_LEN macros refer to the length of the "port@" and "endpoint@"
> 
> *PREFIX_LEN -> *_PREFIX_LEN
> 
> > + * sections of the naming scheme.
> > + */
> > +#define FWNODE_GRAPH_PORT_NAME_FORMAT          "port@%u"
> > +#define FWNODE_GRAPH_PORT_NAME_PREFIX_LEN      5
> > +#define FWNODE_GRAPH_ENDPOINT_NAME_FORMAT      "endpoint@%u"
> > +#define FWNODE_GRAPH_ENDPOINT_PREFIX_LEN       9
> 
> _FORMAT -> _FMT (however, V4L2 guys may correct me, because IIRC _FMT
> suffix is also used for other things in v4l2.

This isn't related to V4L2, so it doesn't matter much :-) I personally
prefer spelling names out in full when that wouldn't result in too long
lines, but it's really a matter of personal preference, I don't mind
either way.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> >  #define NR_FWNODE_REFERENCE_ARGS       8
> >
> >  /**

-- 
Regards,

Laurent Pinchart
