Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7AE70C34A
	for <lists+linux-acpi@lfdr.de>; Mon, 22 May 2023 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjEVQ2T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 May 2023 12:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjEVQ2S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 May 2023 12:28:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6FEED;
        Mon, 22 May 2023 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684772897; x=1716308897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H5GgvBigcBxFtdbQeYzqPsUbJD2j1M75ciCMaH5cGsc=;
  b=LtOVePVq7uh+bvuAtFi4HPXVM0rnmUZO+iClypmf36QJKmbt7zAGKD6K
   DH1hUFnNmZ65ulpAcNU3wBWlG9zh0yfVIlsvqV2yhVE5SzsOW97+Y7W9o
   aUPUvakxDEQlMl0qDgVR+putBc885lYYbDTzSvqImuL+akmXUTNDnWLlE
   RhatxTkdaTbzSjE0VD9PvC4IbT5IrEngUOZv5R1P6RCB96XV4L8h39ZWQ
   RaciPBsSF7Z23ejODub1SqYfhhSv/sWHBmcS12BRct85OE2QoGzChBnHJ
   6nlC7FP7KFve2SbvcpHIjVDoxZs3KDur0vFignioT5/WDydcd+kjCIeqs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418680636"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="418680636"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 09:28:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768603236"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="768603236"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 09:28:15 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id AFB89122FB0;
        Mon, 22 May 2023 19:28:12 +0300 (EEST)
Date:   Mon, 22 May 2023 16:28:12 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
Message-ID: <ZGuYHGMQBzBi4myq@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
 <ZGNn9jOWmh0/aEOW@kekkonen.localdomain>
 <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iPcSc_x9g1tpTOVVaEB+9O_6N8SFqWSgG_ku+dNqveQg@mail.gmail.com>
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

On Mon, May 22, 2023 at 05:29:48PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 16, 2023 at 1:24 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> > > <sakari.ailus@linux.intel.com> wrote:
> > > >
> > > > Add support for parsing property references using strings, besides
> > > > reference objects that were previously supported. This allows also
> > > > referencing data nodes which was not possible with reference objects.
> > > >
> > > > Also add pr_fmt() macro to prefix printouts.
> > > >
> > > > While at it, update copyright.
> > >
> > > Although I said that it looked good to me, some minor improvements can
> > > still be made.
> > >
> > > First off, the above changelog is a bit terse.
> > >
> > > I think that it would help to provide an example of device properties
> > > that would not be parsed properly before the change and can be parsed
> > > now.
> > >
> > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > ---
> > > >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> > > >  1 file changed, 94 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > index b8d9eb9a433e..08831ffba26c 100644
> > > > --- a/drivers/acpi/property.c
> > > > +++ b/drivers/acpi/property.c
> > > > @@ -2,14 +2,17 @@
> > > >  /*
> > > >   * ACPI device specific properties support.
> > > >   *
> > > > - * Copyright (C) 2014, Intel Corporation
> > > > + * Copyright (C) 2014-2023, Intel Corporation
> > > >   * All rights reserved.
> > > >   *
> > > >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > - *          Darren Hart <dvhart@linux.intel.com>
> > > > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > + *         Darren Hart <dvhart@linux.intel.com>
> > > > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > I'm not sure if the whitespace change here is really useful.
> >
> > I did that to address a comment from Andy --- the earlier lines used spaces
> > for indentation.
> >
> > >
> > > > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> > > >   */
> > > >
> > > > +#define pr_fmt(fmt) "ACPI: " fmt
> > > > +
> > > >  #include <linux/acpi.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/export.h>
> > > > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> > > >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> > > >                              struct fwnode_handle *ref_fwnode,
> > > >                              const union acpi_object **element,
> > > > -                            const union acpi_object *end, size_t num_args)
> > > > +                            const union acpi_object *end, size_t num_args,
> > > > +                            bool subnode_string)
> > >
> > > The meaning of the new argument isn't really clear.  it would be good
> > > to somehow help a casual reader of the code to find this out more
> > > easily.
> >
> > I can add comments to v9.
> 
> If you can send me an example of ASL that will be parsed correctly
> after this change, but not before, it will help a bit.

E.g. this bit from DisCo for Imaging 1.0 (Annex B.1):

	Package () {
	    "mipi-img-flash-leds",
	    Package () {
		"\\_SB.PCI0.I2C2.LEDD.LED0",
		"\\_SB.PCI0.I2C2.LEDD.LED1"
	    },
	},

It's a property with a string reference to an ACPI non-device node,
although you can refer to device nodes as well.

You can get the spec from here:
<URL:https://www.mipi.org/mipi-disco-for-imaging-download>.

-- 
Kind regards,

Sakari Ailus
