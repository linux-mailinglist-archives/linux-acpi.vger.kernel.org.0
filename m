Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEE970C25F
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjEVPaE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 22 May 2023 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjEVPaC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 11:30:02 -0400
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A456CA1;
        Mon, 22 May 2023 08:30:01 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-510f866ce78so672620a12.1;
        Mon, 22 May 2023 08:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684769400; x=1687361400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQvsAXlGcHvmtohT89vRy/bk6f34DtVATxwZoL4dvuM=;
        b=jkZ6mlP5RvT+Y4xyB9xsofKUVtC1cKMOvgjlgV9VwP3P2q1ChocbIExTZapFcctZ9i
         OEd9m3zaGZz8nWb3j4Oh7siTRfE5cvG98bSrCtZh9FG5YjFhyk3ol8kEse36a7K3OpeZ
         Z0FxOCrLjqJP8BwjgUyldp7JYRqdja/j1tW34Oar/cDn1wl08vTjrrSEMg/KHOMOvp6O
         cuDHJMEL0HjFxlF9c0J/BAQzo/oqYctF3Z3AteooLcXaBNDTbyK2K3ehjK0sCs4vZ3j/
         YTPrlyMogqVs7pqbJ+hgYr4e0WJNUYyNjN1nqfx/Pa4ZEgd47sfYavbPu8inXd830W/G
         wJqQ==
X-Gm-Message-State: AC+VfDwHg504m7k7AC2NhTqYYZd+dPu6YtmNHrWGrXNDFfsp5nedhKVz
        /GlfspRxX2gIVSvYlYqXJedl+Xg/lvkvJ32XzUfBwxLQ
X-Google-Smtp-Source: ACHHUZ7FQ/tHFvGSWcA2GKleuT4mcIJoQ0ioQEq6C24UOsJ0chiTYeLIUjbQGqbqSvMdD1OVoIQ6CBvFrkdC2vGanIo=
X-Received: by 2002:a17:906:5199:b0:965:9602:3ee1 with SMTP id
 y25-20020a170906519900b0096596023ee1mr9551591ejk.2.1684769399833; Mon, 22 May
 2023 08:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com> <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain>
In-Reply-To: <ZGNn9jOWmh0/aEOW@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 May 2023 17:29:48 +0200
Message-ID: <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
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

On Tue, May 16, 2023 at 1:24 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Add support for parsing property references using strings, besides
> > > reference objects that were previously supported. This allows also
> > > referencing data nodes which was not possible with reference objects.
> > >
> > > Also add pr_fmt() macro to prefix printouts.
> > >
> > > While at it, update copyright.
> >
> > Although I said that it looked good to me, some minor improvements can
> > still be made.
> >
> > First off, the above changelog is a bit terse.
> >
> > I think that it would help to provide an example of device properties
> > that would not be parsed properly before the change and can be parsed
> > now.
> >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index b8d9eb9a433e..08831ffba26c 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -2,14 +2,17 @@
> > >  /*
> > >   * ACPI device specific properties support.
> > >   *
> > > - * Copyright (C) 2014, Intel Corporation
> > > + * Copyright (C) 2014-2023, Intel Corporation
> > >   * All rights reserved.
> > >   *
> > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > - *          Darren Hart <dvhart@linux.intel.com>
> > > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > + *         Darren Hart <dvhart@linux.intel.com>
> > > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > I'm not sure if the whitespace change here is really useful.
>
> I did that to address a comment from Andy --- the earlier lines used spaces
> for indentation.
>
> >
> > > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> > >   */
> > >
> > > +#define pr_fmt(fmt) "ACPI: " fmt
> > > +
> > >  #include <linux/acpi.h>
> > >  #include <linux/device.h>
> > >  #include <linux/export.h>
> > > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> > >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> > >                              struct fwnode_handle *ref_fwnode,
> > >                              const union acpi_object **element,
> > > -                            const union acpi_object *end, size_t num_args)
> > > +                            const union acpi_object *end, size_t num_args,
> > > +                            bool subnode_string)
> >
> > The meaning of the new argument isn't really clear.  it would be good
> > to somehow help a casual reader of the code to find this out more
> > easily.
>
> I can add comments to v9.

If you can send me an example of ASL that will be parsed correctly
after this change, but not before, it will help a bit.
