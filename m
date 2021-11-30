Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DA463F7A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Nov 2021 21:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhK3UyQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Nov 2021 15:54:16 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35517 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343810AbhK3UyO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Nov 2021 15:54:14 -0500
Received: by mail-oi1-f173.google.com with SMTP id m6so43823104oim.2
        for <linux-acpi@vger.kernel.org>; Tue, 30 Nov 2021 12:50:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8Q6aY4EMUgXUXDAIPcuICUnjTlt+j+d7ZEk8IT0l70=;
        b=nca9unU+XkWSXCPU+8Fx8SpDgboXnrzRu6mQarsmOTVxhPdrykt+wPwSFoIuDb6kWk
         Ew4xnIOPevq3HCTeghV8XLWDS3zPUHOLkD/ugZliZMw9XcHCKaPQgDjktfYWxt2DG8z6
         G6UtMhVVtYHwLRQcLfCTZgGWykRyqdsSbP4oOaGXNu/t5DL61dPpkzp7eNTWaSYpxFNQ
         +d0u5MmRL28mS3MBf1w6CLSh1a4QwS7Ia56kAihJ90FmkXOjr0cdgl4Y4DXt1ZXenrCP
         OirhkiDpi8ozERA46VfpLC7VvymTXtWqZLQMeQ+MkpA8fINxP2C5DIdc5UkKAoA7JCzh
         Vgwg==
X-Gm-Message-State: AOAM533tBjfAQKdd642k1JfG5tk8N+YQUzmxqmVT9rwYeNAmMYNnfdl8
        rNdX+7AJIuVyd5isA3YY4byQztls7cNIMg+TCQw=
X-Google-Smtp-Source: ABdhPJy8f0Zwa3fQLYQQzqOfPffsqcfwgy6ZgSHXAHMSxpAmuoJrQMiwhD749h8D6ca8KqFLQ+bgL9c7gcGr/ss3yz4=
X-Received: by 2002:aca:eb0b:: with SMTP id j11mr1369896oih.51.1638305454822;
 Tue, 30 Nov 2021 12:50:54 -0800 (PST)
MIME-Version: 1.0
References: <20211130153250.935726-1-sakari.ailus@linux.intel.com>
 <20211130153250.935726-3-sakari.ailus@linux.intel.com> <YaZJiAYTFOGgoCAt@smile.fi.intel.com>
 <YaaMoNdtcOAICs/u@paasikivi.fi.intel.com>
In-Reply-To: <YaaMoNdtcOAICs/u@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Nov 2021 21:50:43 +0100
Message-ID: <CAJZ5v0gEgOvcwAd00Qia3-VfBJirSQA8+kU+sUgSMi4ELBf7eQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] Documentation: ACPI: Fix data node reference documentation
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 30, 2021 at 9:42 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Tue, Nov 30, 2021 at 05:55:52PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 30, 2021 at 05:32:46PM +0200, Sakari Ailus wrote:
> > > The data node reference documentation was missing a package that must
> > > contain the property values, instead property name and multiple values
> > > being present in a single package. This is not aligned with the _DSD spec.
> > > Fix it by adding the package for the values.
> > >
> > > Also add the missing "reg" properties to two numbered nodes.
> > >
> > > Fixes: b10134a3643d ("ACPI: property: Document hierarchical data extension references")
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  .../firmware-guide/acpi/dsd/data-node-references.rst      | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > > index b7ad47df49de0..166bf9a944bc8 100644
> > > --- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > > +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> > > @@ -5,7 +5,7 @@
> > >  Referencing hierarchical data nodes
> > >  ===================================
> > >
> > > -:Copyright: |copy| 2018 Intel Corporation
> > > +:Copyright: |copy| 2018, 2021 Intel Corporation
> > >  :Author: Sakari Ailus <sakari.ailus@linux.intel.com>
> > >
> > >  ACPI in general allows referring to device objects in the tree only.
> > > @@ -52,12 +52,14 @@ the ANOD object which is also the final target node of the reference.
> > >         Name (NOD0, Package() {
> > >             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >             Package () {
> > > +               Package () { "reg", 0 },
> > >                 Package () { "random-property", 3 },
> > >             }
> > >         })
> > >         Name (NOD1, Package() {
> > >             ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
> > >             Package () {
> > > +               Package () { "reg", 1 },
> > >                 Package () { "anothernode", "ANOD" },
> > >             }
> > >         })
> > > @@ -74,7 +76,9 @@ the ANOD object which is also the final target node of the reference.
> > >         Name (_DSD, Package () {
> > >             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >             Package () {
> > > -               Package () { "reference", ^DEV0, "node@1", "anothernode" },
> >
> > > +               Package () { "reference",
> > > +                            Package () { ^DEV0,
> > > +                                         "node@1", "anothernode" } },
> >
> > Can it be rather this
> >
> >                   Package () {
> >                       "reference", Package () { ^DEV0, "node@1", "anothernode" }
> >                   },
> >
> > or this way
> >
> >                   Package () {
> >                       "reference", Package () {
> >                          ^DEV0, "node@1", "anothernode"
> >                       }
> >                   },
> >
> > ?
>
> How about:
>
>                     Package () {
>                         "reference",
>                         Package () { ^DEV0, "node@1", "anothernode" },
>                     },
>

Please keep "reference" and the following Package () on the same line.
