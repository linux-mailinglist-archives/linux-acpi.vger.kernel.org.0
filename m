Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32316AE096
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Mar 2023 14:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjCGNbn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 7 Mar 2023 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCGNbb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Mar 2023 08:31:31 -0500
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3C7C957;
        Tue,  7 Mar 2023 05:31:08 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id x3so52166072edb.10;
        Tue, 07 Mar 2023 05:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678195856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Yfy1FqfOLTU+SCXhwV/aBsHgrNM7HH0u0r8sxJmhO8=;
        b=cxnyhjUu0PFXCDB6nM08JQ8oNhBWC6MOciII4s6H6OiSNgot07b6Eltwj5x6W9CnN4
         dNTM5y6U1W0NRed2rG9fpss3iAJsTaU+VSW/yB++6kh/LciVYGQlIFQ6QJCYWZFfa5zd
         mhYDw60UpUYIUh4LQ/CKGUk4huyrr7uwElEOl1fe6DRj9pfXUvAZfbBp22G7DbN3BkFi
         XaSvSo5ei8M2dhZWlUiWASs52pT6kcre1VjbvWIVYU3j8I/vTcgPC7bFVONJvZWxNBS8
         K/1W6Vg21GytK2dKPLtEec+1DfrhJ2paQIq18wv0QK22iPM1IMMYQFQm/ldVSYK64R1v
         FYxg==
X-Gm-Message-State: AO0yUKWhbphZVISe5AROjHkkinovo/z/DFJay37/CDqIuW+psUQneH8V
        6fadiOV0yB9qC+NVLkfAAIPa4NTLSDmbD0dZfdM=
X-Google-Smtp-Source: AK7set+GLk6lTQvfsci20w1N4x9V0F64Hc1DiadO8wDRWfJm5ls5fThItPgEbf5zC+svGIloWVq540KllrshG/eTKi4=
X-Received: by 2002:a05:6402:c17:b0:4bc:edde:1508 with SMTP id
 co23-20020a0564020c1700b004bcedde1508mr9643819edb.0.1678195856352; Tue, 07
 Mar 2023 05:30:56 -0800 (PST)
MIME-Version: 1.0
References: <20230208212712.3184953-1-sakari.ailus@linux.intel.com> <20230208212712.3184953-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20230208212712.3184953-2-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Mar 2023 14:30:45 +0100
Message-ID: <CAJZ5v0jNVUEmxpFaLen-ssRqWz_r_HXP2wnzsEavBZnrneTs4g@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] ACPI: property: Parse data node string references
 in properties
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 8, 2023 at 10:27 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Add support for parsing property references using strings, besides
> reference objects that were previously supported. This allows also
> referencing data nodes which was not possible with reference objects.
>
> Also add pr_fmt() macro to prefix printouts.
>
> While at it, update copyright.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 110 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 94 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index b8d9eb9a433ed..4db7701aeaf5c 100644
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

Is the above change really that useful?

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
> +               pr_err("bad node type for node %pfw\n", fwnode);

Is the log level here adequate?

I mean, what is a sysadmin seeing this message in the log expected to
do about it?

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
> 2.30.2
>
