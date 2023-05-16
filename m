Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7632E704C44
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjEPLYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjEPLYo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:24:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFB2A9;
        Tue, 16 May 2023 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684236282; x=1715772282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=PLz5kUJwm6+Uo72T8/fevIqkkcMk4QEsLZQw49/HHJc=;
  b=Uw6TMuWv4zn+346bsyWRiyzOZjuMAIcVZPvcqWdlPw1phC9gH15CFeYw
   aRmlKbVCwljPLSBI8+bbNpUUzvEu87LL11+mxA+yy03U8m+7QGlwaGLth
   JyOop62ivNwFu1mJFimYVNQGVwGBXpMv+aEI1FhiC3+uTHeJBIBaSLN/D
   FdvzcIgpJSrM+H9YWryGsmwWRW+PwJqsYqzGYCnLzArgz8Tu9peSvKg86
   mx4ej7PCG02nyUNkAjv1HMcWiJnGJ2cftg/+NeraOxPnBEkTQAE3Wn0u4
   6UwukHhPTLHWpqH7L+pcEkmu46r4HSYMdOX3mOKkbnPiYNegvP4tNo+XE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353731978"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="353731978"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="845643480"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="845643480"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:24:40 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
        by kekkonen.fi.intel.com (Postfix) with ESMTP id 41B1D120279;
        Tue, 16 May 2023 14:24:38 +0300 (EEST)
Date:   Tue, 16 May 2023 11:24:38 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
Message-ID: <ZGNn9jOWmh0/aEOW@kekkonen.localdomain>
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com>
 <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
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

On Fri, May 12, 2023 at 06:04:26PM +0200, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Add support for parsing property references using strings, besides
> > reference objects that were previously supported. This allows also
> > referencing data nodes which was not possible with reference objects.
> >
> > Also add pr_fmt() macro to prefix printouts.
> >
> > While at it, update copyright.
> 
> Although I said that it looked good to me, some minor improvements can
> still be made.
> 
> First off, the above changelog is a bit terse.
> 
> I think that it would help to provide an example of device properties
> that would not be parsed properly before the change and can be parsed
> now.
> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 94 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index b8d9eb9a433e..08831ffba26c 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -2,14 +2,17 @@
> >  /*
> >   * ACPI device specific properties support.
> >   *
> > - * Copyright (C) 2014, Intel Corporation
> > + * Copyright (C) 2014-2023, Intel Corporation
> >   * All rights reserved.
> >   *
> >   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> > - *          Darren Hart <dvhart@linux.intel.com>
> > - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > + *         Darren Hart <dvhart@linux.intel.com>
> > + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> I'm not sure if the whitespace change here is really useful.

I did that to address a comment from Andy --- the earlier lines used spaces
for indentation.

> 
> > + *         Sakari Ailus <sakari.ailus@linux.intel.com>
> >   */
> >
> > +#define pr_fmt(fmt) "ACPI: " fmt
> > +
> >  #include <linux/acpi.h>
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> > @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
> >  static int acpi_get_ref_args(struct fwnode_reference_args *args,
> >                              struct fwnode_handle *ref_fwnode,
> >                              const union acpi_object **element,
> > -                            const union acpi_object *end, size_t num_args)
> > +                            const union acpi_object *end, size_t num_args,
> > +                            bool subnode_string)
> 
> The meaning of the new argument isn't really clear.  it would be good
> to somehow help a casual reader of the code to find this out more
> easily.

I can add comments to v9.

> 
> >  {
> >         u32 nargs = 0, i;
> >
> > @@ -803,13 +807,16 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
> >          * Find the referred data extension node under the
> >          * referred device node.
> >          */
> > -       for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
> > -            (*element)++) {
> > -               const char *child_name = (*element)->string.pointer;
> > -
> > -               ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode, child_name);
> > -               if (!ref_fwnode)
> > -                       return -EINVAL;
> > +       if (subnode_string) {
> > +               for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
> > +                    (*element)++) {
> > +                       const char *child_name = (*element)->string.pointer;
> > +
> > +                       ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
> > +                                                                     child_name);
> > +                       if (!ref_fwnode)
> > +                               return -EINVAL;
> > +               }
> >         }
> >
> >         /*
> > @@ -820,7 +827,8 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
> >         for (i = 0; (*element) + i < end && i < num_args; i++) {
> >                 acpi_object_type type = (*element)[i].type;
> >
> > -               if (type == ACPI_TYPE_LOCAL_REFERENCE)
> > +               if (type == ACPI_TYPE_LOCAL_REFERENCE ||
> > +                   (!subnode_string && type == ACPI_TYPE_STRING))
> >                         break;
> >
> >                 if (type == ACPI_TYPE_INTEGER)
> > @@ -844,6 +852,43 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
> >         return 0;
> >  }
> >
> > +static struct fwnode_handle *
> > +acpi_parse_string_ref(const struct fwnode_handle *fwnode, const char *refstring)
> > +{
> > +       acpi_handle scope, handle;
> > +       struct acpi_data_node *dn;
> > +       struct acpi_device *device;
> > +       acpi_status status;
> > +
> > +       if (is_acpi_device_node(fwnode)) {
> > +               scope = to_acpi_device_node(fwnode)->handle;
> > +       } else if (is_acpi_data_node(fwnode)) {
> > +               scope = to_acpi_data_node(fwnode)->handle;
> > +       } else {
> > +               pr_debug("bad node type for node %pfw\n", fwnode);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       status = acpi_get_handle(scope, refstring, &handle);
> > +       if (ACPI_FAILURE(status)) {
> > +               acpi_handle_debug(scope, "can't get handle for %s", refstring);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       device = acpi_fetch_acpi_dev(handle);
> > +       if (device)
> > +               return acpi_fwnode_handle(device);
> > +
> > +       status = acpi_get_data_full(handle, acpi_nondev_subnode_tag,
> > +                                   (void **)&dn, NULL);
> > +       if (ACPI_FAILURE(status) || !dn) {
> > +               acpi_handle_debug(handle, "can't find subnode");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       return &dn->fwnode;
> 
> So on failure this function always returns the same error code.  Can
> it return NULL instead which can be translated into an error code by
> the caller?

Sure, makes sense.

> 
> > +}
> > +
> >  /**
> >   * __acpi_node_get_property_reference - returns handle to the referenced object
> >   * @fwnode: Firmware node to get the property from
> > @@ -886,6 +931,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >         const union acpi_object *element, *end;
> >         const union acpi_object *obj;
> >         const struct acpi_device_data *data;
> > +       struct fwnode_handle *ref_fwnode;
> >         struct acpi_device *device;
> >         int ret, idx = 0;
> >
> > @@ -909,16 +955,29 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >
> >                 args->fwnode = acpi_fwnode_handle(device);
> >                 args->nargs = 0;
> > +               return 0;
> > +       case ACPI_TYPE_STRING:
> > +               if (index)
> > +                       return -ENOENT;
> > +
> > +               ref_fwnode = acpi_parse_string_ref(fwnode, obj->string.pointer);
> > +               if (IS_ERR(ref_fwnode))
> > +                       return PTR_ERR(ref_fwnode);
> > +
> > +               args->fwnode = ref_fwnode;
> > +               args->nargs = 0;
> > +
> >                 return 0;
> >         case ACPI_TYPE_PACKAGE:
> >                 /*
> >                  * If it is not a single reference, then it is a package of
> > -                * references followed by number of ints as follows:
> > +                * references, followed by number of ints as follows:
> >                  *
> >                  *  Package () { REF, INT, REF, INT, INT }
> >                  *
> > -                * The index argument is then used to determine which reference
> > -                * the caller wants (along with the arguments).
> > +                * Here, REF may be either a local reference or a string. The
> > +                * index argument is then used to determine which reference the
> > +                * caller wants (along with the arguments).
> >                  */
> >                 break;
> >         default:
> > @@ -942,7 +1001,26 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
> >
> >                         ret = acpi_get_ref_args(idx == index ? args : NULL,
> >                                                 acpi_fwnode_handle(device),
> > -                                               &element, end, num_args);
> > +                                               &element, end, num_args, true);
> > +                       if (ret < 0)
> > +                               return ret;
> > +
> > +                       if (idx == index)
> > +                               return 0;
> > +
> > +                       break;
> > +               case ACPI_TYPE_STRING:
> > +                       ref_fwnode =
> > +                               acpi_parse_string_ref(fwnode,
> > +                                                     element->string.pointer);
> > +                       if (IS_ERR(ref_fwnode))
> > +                               return PTR_ERR(ref_fwnode);
> > +
> > +                       element++;
> > +
> > +                       ret = acpi_get_ref_args(idx == index ? args : NULL,
> > +                                               ref_fwnode, &element, end,
> > +                                               num_args, false);
> >                         if (ret < 0)
> >                                 return ret;
> >
> > --

-- 
Regards,

Sakari Ailus
