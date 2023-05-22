Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B1270CB40
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 22:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjEVUf5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjEVUfc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 16:35:32 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526C5F4;
        Mon, 22 May 2023 13:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684787729; x=1716323729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7N6rDj5rVH8bpnWib0FQj2temCKXyDOfvQY30QqX8dg=;
  b=hkUn48G+qTPIxchNuwToPx5NDli5UQxvRHJoBZFizoDquw8ELxrau4w3
   87oCwZzD6QIFeumoCDCqfYXtOqtih6LbecKsfkZqGdHPGCVoELj9p94qJ
   /0dXiZR344ZAWGYjh4PHp+SRjg+9Zjd0bhie7YEB0zNeKgUEHHz8bgFTe
   meamWBKT47uZf72GbcK/JjS2MnLveQ5og0bSk5rsQrdupJnTtSRMB4jm5
   FCWMN+RzKJ8IDf3s8lajnF05/gxAQolHgS3nIMoDBhx1jEQariYv6EAWO
   qri4oz2kXifFRrKz8V94sHdlOM52wV517losdW1Dm/iQnBv0mNiNV67Kd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="353059611"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="353059611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="734407654"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="734407654"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 13:35:26 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id F2B67120CAC;
        Mon, 22 May 2023 23:25:49 +0300 (EEST)
Date:   Mon, 22 May 2023 20:25:49 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
Message-ID: <ZGvPzfnr7CMjcjdY@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain>
 <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
 <ZGuYHGMQBzBi4myq@kekkonen.localdomain>
 <CAJZ5v0hW-JewnYP48sowLmi7=v00EBWJLLR-8mWBK8-DOeC=uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hW-JewnYP48sowLmi7=v00EBWJLLR-8mWBK8-DOeC=uA@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Mon, May 22, 2023 at 06:38:37PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, May 22, 2023 at 6:28 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> > On Mon, May 22, 2023 at 05:29:48PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 16, 2023 at 1:24 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > > On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> > > > > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > >
> > > > > > Add support for parsing property references using strings, besides
> > > > > > reference objects that were previously supported. This allows also
> > > > > > referencing data nodes which was not possible with reference objects.
> > > > > >
> > > > > > Also add pr_fmt() macro to prefix printouts.
> > > > > >
> > > > > > While at it, update copyright.
> > > > >
> > > > > Although I said that it looked good to me, some minor improvements can
> > > > > still be made.
> > > > >
> > > > > First off, the above changelog is a bit terse.
> > > > >
> > > > > I think that it would help to provide an example of device properties
> > > > > that would not be parsed properly before the change and can be parsed
> > > > > now.
> > > > >
> > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > ---
> > > > > >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> > > > > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > > > index b8d9eb9a433e..08831ffba26c 100644
> > > > > > --- a/drivers/acpi/property.c
> > > > > > +++ b/drivers/acpi/property.c
> > > > > > @@ -2,14 +2,17 @@
> > > > > >  /*
> > > > > >   * ACPI device specific properties support.
> > > > > >   *
> > > > > > - * Copyright (C) 2014, Intel Corporation
> > > > > > + * Copyright (C) 2014-2023, Intel Corporation
> > > > > >   * All rights reserved.
> > > > > >   *
> > > > > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > - *          Darren Hart <dvhart@linux.intel.com>
> > > > > > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > + *         Darren Hart <dvhart@linux.intel.com>
> > > > > > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > I'm not sure if the whitespace change here is really useful.
> > > >
> > > > I did that to address a comment from Andy --- the earlier lines used spaces
> > > > for indentation.
> > > >
> > > > >
> > > > > > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > >   */
> > > > > >
> > > > > > +#define pr_fmt(fmt) "ACPI: " fmt
> > > > > > +
> > > > > >  #include <linux/acpi.h>
> > > > > >  #include <linux/device.h>
> > > > > >  #include <linux/export.h>
> > > > > > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> > > > > >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> > > > > >                              struct fwnode_handle *ref_fwnode,
> > > > > >                              const union acpi_object **element,
> > > > > > -                            const union acpi_object *end, size_t num_args)
> > > > > > +                            const union acpi_object *end, size_t num_args,
> > > > > > +                            bool subnode_string)
> > > > >
> > > > > The meaning of the new argument isn't really clear.  it would be good
> > > > > to somehow help a casual reader of the code to find this out more
> > > > > easily.
> > > >
> > > > I can add comments to v9.
> > >
> > > If you can send me an example of ASL that will be parsed correctly
> > > after this change, but not before, it will help a bit.
> >
> > E.g. this bit from DisCo for Imaging 1.0 (Annex B.1):
> >
> >         Package () {
> >             "mipi-img-flash-leds",
> >             Package () {
> >                 "\\_SB.PCI0.I2C2.LEDD.LED0",
> >                 "\\_SB.PCI0.I2C2.LEDD.LED1"
> >             },
> >         },
> >
> > It's a property with a string reference to an ACPI non-device node,
> > although you can refer to device nodes as well.
> 
> This example is missing the definition of LED0 or LED1 from which it
> would be clear that they are data nodes (or at least one of them is a
> data node).

Ok, perhaps this one could work as a complete example, with a single
reference:

	Package ()
        {
	    "mipi-img-flash-leds",  "\\_SB.PCI0.I2C2.LEDD.LED0",
	}

        Device (LEDD)
        {
            Name (_DSD, Package ()  // _DSD: Device-Specific Data
            {
                ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), /* Hierarchical Data Extension */,
                Package ()
                {
                    Package ()
                    {
                        "mipi-img-flash-led-0", 
                        "LED0",
                    }
                },
            })
            Name (LED0, Package ()  // _DSD: Device-Specific Data
            {
                ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
                Package ()
                {
                    Package ()
                    {
                        "mipi-img-max-current", 
                        1000000,
                    }
                }
            })
	}


> 
> Also I'm kind of wondering about the "reference with arguments" part
> which seems to work differently depending on whether the reference is
> represented by a string or by a reference object.

Yes. With (device) reference objects, it is possible currently to refer to
subnodes with the _DSD data extension child names of those nodes. This is
not done with string references as 1) any node can already be referenced so
there's no need to and 2) as node references are strings already, it's not
possible to distinguish node string references from _DSD data node names.
E.g.

	"\\_SB.I2C0.LED0", "LED1"

			   ^ ACPI object name or _DSD data node name?

> 
> > You can get the spec from here:
> > <URL:https://www.mipi.org/mipi-disco-for-imaging-download>.
> 
> Sure, but it alone won't help me much with documenting this code change.

Not as such but the spec is publicly available now.

-- 
Kind regards,

Sakari Ailus
