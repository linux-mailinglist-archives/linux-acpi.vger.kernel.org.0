Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53841700C82
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjELQEo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 12 May 2023 12:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjELQEl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 12:04:41 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3626BF;
        Fri, 12 May 2023 09:04:40 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-50bcd46bf47so2361570a12.0;
        Fri, 12 May 2023 09:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683907478; x=1686499478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XoqJaUFP1Hw2OJCBuV44nR0f113Cthlu5ULmbzGnNk=;
        b=lYBkPM+6PvhcZKQ5W9xIQJxRBvGrrPfgHGhY/fynZYtHfl7EELDup3aCZWFpQHu2W4
         TS7wONdyyvGC/jskJEpQxOzfhsq5EiPNdoszgQ4BNFsE/plbimSnzFUioFRjAXCry8ad
         YvFA0hF5mGEp5PrD1ZBgazALSb65/qgmKF6jVhimCHcK5lU3MNxUupv2XuVPQSks26gB
         upL0Ue/tH/82RXSK/mD3tkFeGHP4fArGpJq//DPf8jhkfZS0OvQGSEAjNl81140nYxIb
         gNW+qvD8cbdip89OTfdzuQyVdljiIAX0jrpHLMMLaGyTu4kgJLUuD/znvHXhZw+4+oFm
         AUxQ==
X-Gm-Message-State: AC+VfDxmZL94rGflxoPK8VAlfhTbApmhik/skWtwP6hcMRH+WUN43TpF
        pFcbZy2O7FkE7OaqkfgjqJ390TGLsllxrFFq28y+Fj/x
X-Google-Smtp-Source: ACHHUZ5JMNmN5ef/02EKDml82v5uTzXU1nMK52fXiZ1UnN47XyKpP9WfiKcU+y1QrUJDEyNMlWgLg7BE1nzH748SgCY=
X-Received: by 2002:a17:906:217:b0:94f:66af:b1f7 with SMTP id
 23-20020a170906021700b0094f66afb1f7mr20181354ejd.1.1683907478301; Fri, 12 May
 2023 09:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 May 2023 18:04:26 +0200
Message-ID: <CAJZ5v0gG1Zc8h8Lt_tKJp8u7b-nH0Rxt=2j9RqptMVc8r0vL7Q@mail.gmail.com>
Subject: Re: [PATCH v8 02/10] ACPI: property: Parse data node string
 references in properties
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
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

On Wed, Mar 29, 2023 at 12:10 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Add support for parsing property references using strings, besides
> reference objects that were previously supported. This allows also
> referencing data nodes which was not possible with reference objects.
>
> Also add pr_fmt() macro to prefix printouts.
>
> While at it, update copyright.

Although I said that it looked good to me, some minor improvements can
still be made.

First off, the above changelog is a bit terse.

I think that it would help to provide an example of device properties
that would not be parsed properly before the change and can be parsed
now.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 94 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index b8d9eb9a433e..08831ffba26c 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -2,14 +2,17 @@
>  /*
>   * ACPI device specific properties support.
>   *
> - * Copyright (C) 2014, Intel Corporation
> + * Copyright (C) 2014-2023, Intel Corporation
>   * All rights reserved.
>   *
>   * Authors: Mika Westerberg <mika.westerberg@linux.intel.com>
> - *          Darren Hart <dvhart@linux.intel.com>
> - *          Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> + *         Darren Hart <dvhart@linux.intel.com>
> + *         Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm not sure if the whitespace change here is really useful.

> + *         Sakari Ailus <sakari.ailus@linux.intel.com>
>   */
>
> +#define pr_fmt(fmt) "ACPI: " fmt
> +
>  #include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> @@ -795,7 +798,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  static int acpi_get_ref_args(struct fwnode_reference_args *args,
>                              struct fwnode_handle *ref_fwnode,
>                              const union acpi_object **element,
> -                            const union acpi_object *end, size_t num_args)
> +                            const union acpi_object *end, size_t num_args,
> +                            bool subnode_string)

The meaning of the new argument isn't really clear.  it would be good
to somehow help a casual reader of the code to find this out more
easily.

>  {
>         u32 nargs = 0, i;
>
> @@ -803,13 +807,16 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
>          * Find the referred data extension node under the
>          * referred device node.
>          */
> -       for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
> -            (*element)++) {
> -               const char *child_name = (*element)->string.pointer;
> -
> -               ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode, child_name);
> -               if (!ref_fwnode)
> -                       return -EINVAL;
> +       if (subnode_string) {
> +               for (; *element < end && (*element)->type == ACPI_TYPE_STRING;
> +                    (*element)++) {
> +                       const char *child_name = (*element)->string.pointer;
> +
> +                       ref_fwnode = acpi_fwnode_get_named_child_node(ref_fwnode,
> +                                                                     child_name);
> +                       if (!ref_fwnode)
> +                               return -EINVAL;
> +               }
>         }
>
>         /*
> @@ -820,7 +827,8 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
>         for (i = 0; (*element) + i < end && i < num_args; i++) {
>                 acpi_object_type type = (*element)[i].type;
>
> -               if (type == ACPI_TYPE_LOCAL_REFERENCE)
> +               if (type == ACPI_TYPE_LOCAL_REFERENCE ||
> +                   (!subnode_string && type == ACPI_TYPE_STRING))
>                         break;
>
>                 if (type == ACPI_TYPE_INTEGER)
> @@ -844,6 +852,43 @@ static int acpi_get_ref_args(struct fwnode_reference_args *args,
>         return 0;
>  }
>
> +static struct fwnode_handle *
> +acpi_parse_string_ref(const struct fwnode_handle *fwnode, const char *refstring)
> +{
> +       acpi_handle scope, handle;
> +       struct acpi_data_node *dn;
> +       struct acpi_device *device;
> +       acpi_status status;
> +
> +       if (is_acpi_device_node(fwnode)) {
> +               scope = to_acpi_device_node(fwnode)->handle;
> +       } else if (is_acpi_data_node(fwnode)) {
> +               scope = to_acpi_data_node(fwnode)->handle;
> +       } else {
> +               pr_debug("bad node type for node %pfw\n", fwnode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       status = acpi_get_handle(scope, refstring, &handle);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_handle_debug(scope, "can't get handle for %s", refstring);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       device = acpi_fetch_acpi_dev(handle);
> +       if (device)
> +               return acpi_fwnode_handle(device);
> +
> +       status = acpi_get_data_full(handle, acpi_nondev_subnode_tag,
> +                                   (void **)&dn, NULL);
> +       if (ACPI_FAILURE(status) || !dn) {
> +               acpi_handle_debug(handle, "can't find subnode");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       return &dn->fwnode;

So on failure this function always returns the same error code.  Can
it return NULL instead which can be translated into an error code by
the caller?

> +}
> +
>  /**
>   * __acpi_node_get_property_reference - returns handle to the referenced object
>   * @fwnode: Firmware node to get the property from
> @@ -886,6 +931,7 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>         const union acpi_object *element, *end;
>         const union acpi_object *obj;
>         const struct acpi_device_data *data;
> +       struct fwnode_handle *ref_fwnode;
>         struct acpi_device *device;
>         int ret, idx = 0;
>
> @@ -909,16 +955,29 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>
>                 args->fwnode = acpi_fwnode_handle(device);
>                 args->nargs = 0;
> +               return 0;
> +       case ACPI_TYPE_STRING:
> +               if (index)
> +                       return -ENOENT;
> +
> +               ref_fwnode = acpi_parse_string_ref(fwnode, obj->string.pointer);
> +               if (IS_ERR(ref_fwnode))
> +                       return PTR_ERR(ref_fwnode);
> +
> +               args->fwnode = ref_fwnode;
> +               args->nargs = 0;
> +
>                 return 0;
>         case ACPI_TYPE_PACKAGE:
>                 /*
>                  * If it is not a single reference, then it is a package of
> -                * references followed by number of ints as follows:
> +                * references, followed by number of ints as follows:
>                  *
>                  *  Package () { REF, INT, REF, INT, INT }
>                  *
> -                * The index argument is then used to determine which reference
> -                * the caller wants (along with the arguments).
> +                * Here, REF may be either a local reference or a string. The
> +                * index argument is then used to determine which reference the
> +                * caller wants (along with the arguments).
>                  */
>                 break;
>         default:
> @@ -942,7 +1001,26 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>
>                         ret = acpi_get_ref_args(idx == index ? args : NULL,
>                                                 acpi_fwnode_handle(device),
> -                                               &element, end, num_args);
> +                                               &element, end, num_args, true);
> +                       if (ret < 0)
> +                               return ret;
> +
> +                       if (idx == index)
> +                               return 0;
> +
> +                       break;
> +               case ACPI_TYPE_STRING:
> +                       ref_fwnode =
> +                               acpi_parse_string_ref(fwnode,
> +                                                     element->string.pointer);
> +                       if (IS_ERR(ref_fwnode))
> +                               return PTR_ERR(ref_fwnode);
> +
> +                       element++;
> +
> +                       ret = acpi_get_ref_args(idx == index ? args : NULL,
> +                                               ref_fwnode, &element, end,
> +                                               num_args, false);
>                         if (ret < 0)
>                                 return ret;
>
> --
