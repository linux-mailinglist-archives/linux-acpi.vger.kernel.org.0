Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966ED70C39C
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjEVQiw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 22 May 2023 12:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjEVQiv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 12:38:51 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B5E9;
        Mon, 22 May 2023 09:38:50 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-96f72e6925cso82507666b.1;
        Mon, 22 May 2023 09:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773529; x=1687365529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbXmGtSpDb/1zESGxKbzMRnI2ZUXEWWp4U9KoUTW0ks=;
        b=XsS+kwLRHWs6uPDa0UsJSGjzBcOQ1N6rsA7oF64HLoWadb0Iy7RMJDQXbFnTSff/GZ
         MmTEsabY+HOgiNcGfOPN6pNzx6Ie4w2nxli7R7Y1Zbf0dLsd7jex44v0qqp0rssPaAVg
         irmD5GcCIpI2+Ql3uiQSWu4kiRw2ofWje9G/KVjDwxN1PQy2H1aAQ5hWFgCGoS+b4Rdd
         5XSt8mAmrZRNNe4NXiqzSYMPO1UstdVNbz7vVZJdeNXUZjrdWSzDI3/Kp4xrlL0bMI7l
         wNzFnEdq8dvmwE3bGHeRwuHXiFCW8CwUrtVlg0KbKfJLGZ8KSC1uiONb3xCf59Zstam+
         hJTw==
X-Gm-Message-State: AC+VfDwAq8fGo0fOMkNpvw36p/1zaSIfpi1RZbC8q4fG8WnJh6WUTuue
        Qpxb3iOfDfVyG6jwIfWe5kUumV7lsnOTsxk/p1g=
X-Google-Smtp-Source: ACHHUZ6UCUY75L6F2Ueh9y8rBz7msfucJ2viGIUmsGnIduqSK/4bd3jm+Sp+opH81RJre3xuDP2SwtrHySXd/nhoPRE=
X-Received: by 2002:a17:906:778c:b0:953:2918:71e7 with SMTP id
 s12-20020a170906778c00b00953291871e7mr10365988ejm.5.1684773528674; Mon, 22
 May 2023 09:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com> <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain> <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
 <ZGuYHGMQBzBi4myq@kekkonen.localdomain>
In-Reply-To: <ZGuYHGMQBzBi4myq@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 18:38:37 +0200
Message-ID: <CAJZ5v0hW-JewnYP48sowLmi7=v00EBWJLLR-8mWBK8-DOeC=uA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Sakari,

On Mon, May 22, 2023 at 6:28 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Mon, May 22, 2023 at 05:29:48PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 16, 2023 at 1:24 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > > On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> > > > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Add support for parsing property references using strings, besides
> > > > > reference objects that were previously supported. This allows also
> > > > > referencing data nodes which was not possible with reference objects.
> > > > >
> > > > > Also add pr_fmt() macro to prefix printouts.
> > > > >
> > > > > While at it, update copyright.
> > > >
> > > > Although I said that it looked good to me, some minor improvements can
> > > > still be made.
> > > >
> > > > First off, the above changelog is a bit terse.
> > > >
> > > > I think that it would help to provide an example of device properties
> > > > that would not be parsed properly before the change and can be parsed
> > > > now.
> > > >
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> > > > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > > >
> > > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > > index b8d9eb9a433e..08831ffba26c 100644
> > > > > --- a/drivers/acpi/property.c
> > > > > +++ b/drivers/acpi/property.c
> > > > > @@ -2,14 +2,17 @@
> > > > >  /*
> > > > >   * ACPI device specific properties support.
> > > > >   *
> > > > > - * Copyright (C) 2014, Intel Corporation
> > > > > + * Copyright (C) 2014-2023, Intel Corporation
> > > > >   * All rights reserved.
> > > > >   *
> > > > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > - *          Darren Hart <dvhart@linux.intel.com>
> > > > > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > + *         Darren Hart <dvhart@linux.intel.com>
> > > > > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > I'm not sure if the whitespace change here is really useful.
> > >
> > > I did that to address a comment from Andy --- the earlier lines used spaces
> > > for indentation.
> > >
> > > >
> > > > > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > >   */
> > > > >
> > > > > +#define pr_fmt(fmt) "ACPI: " fmt
> > > > > +
> > > > >  #include <linux/acpi.h>
> > > > >  #include <linux/device.h>
> > > > >  #include <linux/export.h>
> > > > > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> > > > >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> > > > >                              struct fwnode_handle *ref_fwnode,
> > > > >                              const union acpi_object **element,
> > > > > -                            const union acpi_object *end, size_t num_args)
> > > > > +                            const union acpi_object *end, size_t num_args,
> > > > > +                            bool subnode_string)
> > > >
> > > > The meaning of the new argument isn't really clear.  it would be good
> > > > to somehow help a casual reader of the code to find this out more
> > > > easily.
> > >
> > > I can add comments to v9.
> >
> > If you can send me an example of ASL that will be parsed correctly
> > after this change, but not before, it will help a bit.
>
> E.g. this bit from DisCo for Imaging 1.0 (Annex B.1):
>
>         Package () {
>             "mipi-img-flash-leds",
>             Package () {
>                 "\\_SB.PCI0.I2C2.LEDD.LED0",
>                 "\\_SB.PCI0.I2C2.LEDD.LED1"
>             },
>         },
>
> It's a property with a string reference to an ACPI non-device node,
> although you can refer to device nodes as well.

This example is missing the definition of LED0 or LED1 from which it
would be clear that they are data nodes (or at least one of them is a
data node).

Also I'm kind of wondering about the "reference with arguments" part
which seems to work differently depending on whether the reference is
represented by a string or by a reference object.

> You can get the spec from here:
> <URL:https://www.mipi.org/mipi-disco-for-imaging-download>.

Sure, but it alone won't help me much with documenting this code change.
