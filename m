Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F7170DB63
	for <lists+linux-acpi@lfdr.de>; Tue, 23 May 2023 13:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjEWLV1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 23 May 2023 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjEWLV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 07:21:27 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43574C4;
        Tue, 23 May 2023 04:21:25 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-96f66fbd770so102359266b.1;
        Tue, 23 May 2023 04:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684840884; x=1687432884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFPUweTrAffiPwJGiH9UChLK/G8bNMCR9q4viNntd6c=;
        b=Sjho2MOjnmAR/OwjmjvAlL99F2rWfqFN6XeHAC0KA64+i2kCI67q0YuHb5srDLyPvA
         0Di0M8L+wWX8InNm4VblAS8yW8C0eAChqws2Fd5kHbDa2r0OVAfLj8YbsyBEa2DVdqcv
         te+jtY/FpFxmFDtLFBjgI5sKOYuyLd6oSdqDeCkdKR61Q4ICxzJDVjXS1i4ke25UL2re
         E8U8Ld+whZmGiNJ0TR/AaVBdF6daOPkmjwfAsvcWmm97U4k3Rlj6CgOJLVKA9RIq0zzG
         Tan2Zl52s0Yt195qO7lRYU6xiIlSBA1t/zgbHNAarCFa0lPzOp1XcPd8knMIM80sQIsF
         9RUQ==
X-Gm-Message-State: AC+VfDwp78rsicJ5vsW6Z2CjHMSxHx7Eq+xGYqu+RHeo85FCH3N+HIZj
        0EqR81J0sT9pXRr7x7vNp51wzYg5Gmb1/SWNvvoPdkcL
X-Google-Smtp-Source: ACHHUZ5YAYWtIalxE1Oi6FbFIdcasxDESNNeSgqjzzcuxFb5GXIj2ppxdFnO87Vz12RZisrf/UyKaKHpzV7PU9RoFmA=
X-Received: by 2002:a17:906:212:b0:94e:9235:d77d with SMTP id
 18-20020a170906021200b0094e9235d77dmr11771790ejd.0.1684840883587; Tue, 23 May
 2023 04:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com> <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain> <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
 <ZGuYHGMQBzBi4myq@kekkonen.localdomain> <CAJZ5v0hW-JewnYP48sowLmi7=v00EBWJLLR-8mWBK8-DOeC=uA@mail.gmail.com>
 <ZGvPzfnr7CMjcjdY@kekkonen.localdomain>
In-Reply-To: <ZGvPzfnr7CMjcjdY@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 May 2023 13:21:12 +0200
Message-ID: <CAJZ5v0isDNDxD-xAxdHiuZZAKPf6r-axs+aC09YGAyO-ow9o0g@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On Mon, May 22, 2023 at 10:35 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, May 22, 2023 at 06:38:37PM +0200, Rafael J. Wysocki wrote:
> > On Mon, May 22, 2023 at 6:28 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Mon, May 22, 2023 at 05:29:48PM +0200, Rafael J. Wysocki wrote:
> > > > On Tue, May 16, 2023 at 1:24 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> > > > > > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > > > > > <sakari.ailus@linux.intel.com> wrote:
> > > > > > >
> > > > > > > Add support for parsing property references using strings, besides
> > > > > > > reference objects that were previously supported. This allows also
> > > > > > > referencing data nodes which was not possible with reference objects.
> > > > > > >
> > > > > > > Also add pr_fmt() macro to prefix printouts.
> > > > > > >
> > > > > > > While at it, update copyright.
> > > > > >
> > > > > > Although I said that it looked good to me, some minor improvements can
> > > > > > still be made.
> > > > > >
> > > > > > First off, the above changelog is a bit terse.
> > > > > >
> > > > > > I think that it would help to provide an example of device properties
> > > > > > that would not be parsed properly before the change and can be parsed
> > > > > > now.
> > > > > >
> > > > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > > ---
> > > > > > >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> > > > > > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > > > > index b8d9eb9a433e..08831ffba26c 100644
> > > > > > > --- a/drivers/acpi/property.c
> > > > > > > +++ b/drivers/acpi/property.c
> > > > > > > @@ -2,14 +2,17 @@
> > > > > > >  /*
> > > > > > >   * ACPI device specific properties support.
> > > > > > >   *
> > > > > > > - * Copyright (C) 2014, Intel Corporation
> > > > > > > + * Copyright (C) 2014-2023, Intel Corporation
> > > > > > >   * All rights reserved.
> > > > > > >   *
> > > > > > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > > > - *          Darren Hart <dvhart@linux.intel.com>
> > > > > > > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > > + *         Darren Hart <dvhart@linux.intel.com>
> > > > > > > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > >
> > > > > > I'm not sure if the whitespace change here is really useful.
> > > > >
> > > > > I did that to address a comment from Andy --- the earlier lines used spaces
> > > > > for indentation.
> > > > >
> > > > > >
> > > > > > > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > > >   */
> > > > > > >
> > > > > > > +#define pr_fmt(fmt) "ACPI: " fmt
> > > > > > > +
> > > > > > >  #include <linux/acpi.h>
> > > > > > >  #include <linux/device.h>
> > > > > > >  #include <linux/export.h>
> > > > > > > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> > > > > > >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> > > > > > >                              struct fwnode_handle *ref_fwnode,
> > > > > > >                              const union acpi_object **element,
> > > > > > > -                            const union acpi_object *end, size_t num_args)
> > > > > > > +                            const union acpi_object *end, size_t num_args,
> > > > > > > +                            bool subnode_string)
> > > > > >
> > > > > > The meaning of the new argument isn't really clear.  it would be good
> > > > > > to somehow help a casual reader of the code to find this out more
> > > > > > easily.
> > > > >
> > > > > I can add comments to v9.
> > > >
> > > > If you can send me an example of ASL that will be parsed correctly
> > > > after this change, but not before, it will help a bit.
> > >
> > > E.g. this bit from DisCo for Imaging 1.0 (Annex B.1):
> > >
> > >         Package () {
> > >             "mipi-img-flash-leds",
> > >             Package () {
> > >                 "\\_SB.PCI0.I2C2.LEDD.LED0",
> > >                 "\\_SB.PCI0.I2C2.LEDD.LED1"
> > >             },
> > >         },
> > >
> > > It's a property with a string reference to an ACPI non-device node,
> > > although you can refer to device nodes as well.
> >
> > This example is missing the definition of LED0 or LED1 from which it
> > would be clear that they are data nodes (or at least one of them is a
> > data node).
>
> Ok, perhaps this one could work as a complete example, with a single
> reference:
>
>         Package ()
>         {
>             "mipi-img-flash-leds",  "\\_SB.PCI0.I2C2.LEDD.LED0",
>         }
>
>         Device (LEDD)
>         {
>             Name (_DSD, Package ()  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("dbb8e3e6-5886-4ba6-8795-1319f52a966b"), /* Hierarchical Data Extension */,
>                 Package ()
>                 {
>                     Package ()
>                     {
>                         "mipi-img-flash-led-0",
>                         "LED0",
>                     }
>                 },
>             })
>             Name (LED0, Package ()  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
>                 Package ()
>                 {
>                     Package ()
>                     {
>                         "mipi-img-max-current",
>                         1000000,
>                     }
>                 }
>             })
>         }
>

This works, thanks!

> >
> > Also I'm kind of wondering about the "reference with arguments" part
> > which seems to work differently depending on whether the reference is
> > represented by a string or by a reference object.
>
> Yes. With (device) reference objects, it is possible currently to refer to
> subnodes with the _DSD data extension child names of those nodes. This is
> not done with string references as 1) any node can already be referenced so
> there's no need to and 2) as node references are strings already, it's not
> possible to distinguish node string references from _DSD data node names.
> E.g.
>
>         "\\_SB.I2C0.LED0", "LED1"
>
>                            ^ ACPI object name or _DSD data node name?
>

Has this behavior been documented anywhere?  Or is there any
expectation to see anything like this shipping in production platform
firmware?

If any of the above isn't the case, I would be inclined to simply
remove this special case and make both the "object reference" and
"string" cases work in the same way and if someone needs to refer to a
data node, they will just need to use a string (in which case it will
be the only option).
