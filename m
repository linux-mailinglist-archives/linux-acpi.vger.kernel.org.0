Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF370DBA4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbjEWLnc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 May 2023 07:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjEWLnb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 07:43:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4451A138;
        Tue, 23 May 2023 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684842208; x=1716378208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aaqI9wdS02gTDK1ojqZYF0zBh+Swc1ZmlKPLRWsl0OM=;
  b=Veo+j9K65e3y+c5xVABbFYcjm+6TQPsJ5Pm9bcRfRgiGJPGq0JxpCkLh
   oi3qr/dHvZPb7Uq+x37UZ0h0RdMmpd6FgfGBiD2xoOoYDfMYZTYMmJXOP
   HRxmf9GfSkCnlUEthqNu7hyQZkF+3XZPsIe4adMoTTiDbX1JtJbDO8GBf
   Syt7y4xil88myP7IkfCeU/bR/y/VBkvlho3SidI+HxyX4DrbTqKF0jzFh
   lhzBC0D3ecTkkfxPoZIyhJ3W92nhPtLVpJxiEIn0N8h/ViSY+POgrSHFi
   2xpOw37iskm01/ZNDfYRqBKxHgAxeI7whfPcO+thZvVbzJt0TJNiU7XT0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="381453984"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="381453984"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 04:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="828072014"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; 
   d="scan'208";a="828072014"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 04:43:26 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 5FDC61202A8;
        Tue, 23 May 2023 14:43:23 +0300 (EEST)
Date:   Tue, 23 May 2023 11:43:23 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
Message-ID: <ZGym20IJEPytGqXI@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain>
 <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
 <ZGuYHGMQBzBi4myq@kekkonen.localdomain>
 <CAJZ5v0hW-JewnYP48sowLmi7=v00EBWJLLR-8mWBK8-DOeC=uA@mail.gmail.com>
 <ZGvPzfnr7CMjcjdY@kekkonen.localdomain>
 <CAJZ5v0isDNDxD-xAxdHiuZZAKPf6r-axs+aC09YGAyO-ow9o0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0isDNDxD-xAxdHiuZZAKPf6r-axs+aC09YGAyO-ow9o0g@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Tue, May 23, 2023 at 01:21:12PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, May 22, 2023 at 10:35 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, May 22, 2023 at 06:38:37PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, May 22, 2023 at 6:28 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > > On Mon, May 22, 2023 at 05:29:48PM +0200, Rafael J. Wysocki wrote:
> > > > > On Tue, May 16, 2023 at 1:24 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > > >
> > > > > > > > Add support for parsing property references using strings, besides
> > > > > > > > reference objects that were previously supported. This allows also
> > > > > > > > referencing data nodes which was not possible with reference objects.
> > > > > > > >
> > > > > > > > Also add pr_fmt() macro to prefix printouts.
> > > > > > > >
> > > > > > > > While at it, update copyright.
> > > > > > >
> > > > > > > Although I said that it looked good to me, some minor improvements can
> > > > > > > still be made.
> > > > > > >
> > > > > > > First off, the above changelog is a bit terse.
> > > > > > >
> > > > > > > I think that it would help to provide an example of device properties
> > > > > > > that would not be parsed properly before the change and can be parsed
> > > > > > > now.
> > > > > > >
> > > > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > > > ---
> > > > > > > >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> > > > > > > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > > > > > index b8d9eb9a433e..08831ffba26c 100644
> > > > > > > > --- a/drivers/acpi/property.c
> > > > > > > > +++ b/drivers/acpi/property.c
> > > > > > > > @@ -2,14 +2,17 @@
> > > > > > > >  /*
> > > > > > > >   * ACPI device specific properties support.
> > > > > > > >   *
> > > > > > > > - * Copyright (C) 2014, Intel Corporation
> > > > > > > > + * Copyright (C) 2014-2023, Intel Corporation
> > > > > > > >   * All rights reserved.
> > > > > > > >   *
> > > > > > > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > > - *          Darren Hart <dvhart@linux.intel.com>
> > > > > > > > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > > + *         Darren Hart <dvhart@linux.intel.com>
> > > > > > > > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > >
> > > > > > > I'm not sure if the whitespace change here is really useful.
> > > > > >
> > > > > > I did that to address a comment from Andy --- the earlier lines used spaces
> > > > > > for indentation.
> > > > > >
> > > > > > >
> > > > > > > > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > > >   */
> > > > > > > >
> > > > > > > > +#define pr_fmt(fmt) "ACPI: " fmt
> > > > > > > > +
> > > > > > > >  #include <linux/acpi.h>
> > > > > > > >  #include <linux/device.h>
> > > > > > > >  #include <linux/export.h>
> > > > > > > > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> > > > > > > >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> > > > > > > >                              struct fwnode_handle *ref_fwnode,
> > > > > > > >                              const union acpi_object **element,
> > > > > > > > -                            const union acpi_object *end, size_t num_args)
> > > > > > > > +                            const union acpi_object *end, size_t num_args,
> > > > > > > > +                            bool subnode_string)
> > > > > > >
> > > > > > > The meaning of the new argument isn't really clear.  it would be good
> > > > > > > to somehow help a casual reader of the code to find this out more
> > > > > > > easily.
> > > > > >
> > > > > > I can add comments to v9.
> > > > >
> > > > > If you can send me an example of ASL that will be parsed correctly
> > > > > after this change, but not before, it will help a bit.
> > > >
> > > > E.g. this bit from DisCo for Imaging 1.0 (Annex B.1):
> > > >
> > > >         Package () {
> > > >             "mipi-img-flash-leds",
> > > >             Package () {
> > > >                 "\\_SB.PCI0.I2C2.LEDD.LED0",
> > > >                 "\\_SB.PCI0.I2C2.LEDD.LED1"
> > > >             },
> > > >         },
> > > >
> > > > It's a property with a string reference to an ACPI non-device node,
> > > > although you can refer to device nodes as well.
> > >
> > > This example is missing the definition of LED0 or LED1 from which it
> > > would be clear that they are data nodes (or at least one of them is a
> > > data node).
> >
> > Ok, perhaps this one could work as a complete example, with a single
> > reference:
> >
> >         Package ()
> >         {
> >             "mipi-img-flash-leds",  "\\_SB.PCI0.I2C2.LEDD.LED0",
> >         }
> >
> >         Device (LEDD)
> >         {
> >             Name (_DSD, Package ()  // _DSD: Device-Specific Data
> >             {
> >                 ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), /* Hierarchical Data Extension */,
> >                 Package ()
> >                 {
> >                     Package ()
> >                     {
> >                         "mipi-img-flash-led-0",
> >                         "LED0",
> >                     }
> >                 },
> >             })
> >             Name (LED0, Package ()  // _DSD: Device-Specific Data
> >             {
> >                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
> >                 Package ()
> >                 {
> >                     Package ()
> >                     {
> >                         "mipi-img-max-current",
> >                         1000000,
> >                     }
> >                 }
> >             })
> >         }
> >
> 
> This works, thanks!
> 
> > >
> > > Also I'm kind of wondering about the "reference with arguments" part
> > > which seems to work differently depending on whether the reference is
> > > represented by a string or by a reference object.
> >
> > Yes. With (device) reference objects, it is possible currently to refer to
> > subnodes with the _DSD data extension child names of those nodes. This is
> > not done with string references as 1) any node can already be referenced so
> > there's no need to and 2) as node references are strings already, it's not
> > possible to distinguish node string references from _DSD data node names.
> > E.g.
> >
> >         "\\_SB.I2C0.LED0", "LED1"
> >
> >                            ^ ACPI object name or _DSD data node name?
> >
> 
> Has this behavior been documented anywhere?  Or is there any
> expectation to see anything like this shipping in production platform
> firmware?

Good question. Support for this was added by commit 4eb0c3bf5ee52f . AFAIR
it was intended to use this in DisCo for Imaging but after review (in a
rather liberal sense of the term) it was decided to use string-only
references, as in this patch.

I'm not aware of anyone needing this. They've been there for about five
years but I'd guess someone would complain if it stops working for them.

> 
> If any of the above isn't the case, I would be inclined to simply
> remove this special case and make both the "object reference" and
> "string" cases work in the same way and if someone needs to refer to a
> data node, they will just need to use a string (in which case it will
> be the only option).

Works for me.

-- 
Kind regards,

Sakari Ailus
