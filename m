Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54B6FF80C
	for <lists+linux-acpi@lfdr.de>; Thu, 11 May 2023 19:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjEKRFf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 11 May 2023 13:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbjEKRFK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2023 13:05:10 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B87EF5;
        Thu, 11 May 2023 10:04:52 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-965aa9d1d19so243869866b.0;
        Thu, 11 May 2023 10:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683824690; x=1686416690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucqyEffPWs+q2vDtJcql/AcD+fR5Wr9S90IPFzwbVeY=;
        b=HdVKpEyTWeBdYbNx3jBMOXXFtZeUxisLTe47YGiEyl7AK3IhieQDRvxsD82a6hgIpD
         zKmtWWT3RueDM5DgCp4vnSTg5UN0kyAP3OXOei7+MwpuMO9/pvlxNFfj/9JI+XHQHn1C
         ptQelQbXkPzpzfgBV12QbtYJwk/RU9VSnUZXOcXdG88PO5L5WN9aDxXcHdvDNApTVTIN
         ER0YqqA6v7A9xS/fyDi6m/o/FOo7UR4Sog41IXdv4YWj9cUtcAcJl/phx+dj9W4oY+wp
         5hRujGw0PWcVgYyxpwjDD9Ge/mx6riMRJO/FLEXN7/mx57RUFipvUHyIkf4Y7Ay064ib
         7xZw==
X-Gm-Message-State: AC+VfDzkPy3LND5VQ+ZGI76Id+0rpxx/7TvpTbszjPVv/7d/KwFAwQtp
        8f0ZkmxKvmCjfJ/Pr+poJSh7bmEkGmTEjw6fcqw=
X-Google-Smtp-Source: ACHHUZ5PiZS8vYPauFUTvVaTGZa31hMPMhhD8wSCImznIslV74VXjHd24U7mcPuL+RLOfXkh2m6WRllBcyLPQ9l6WTI=
X-Received: by 2002:a17:906:518a:b0:959:37cc:190e with SMTP id
 y10-20020a170906518a00b0095937cc190emr18014763ejk.3.1683824690480; Thu, 11
 May 2023 10:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230329100951.1522322-1-sakari.ailus@linux.intel.com> <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20230329100951.1522322-3-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 11 May 2023 19:04:39 +0200
Message-ID: <CAJZ5v0gsCa+ejgmHX8u6sPtkTNFg06rsY5=ogmD4CGoqX0qvHg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

This one looks good to me, so formally

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please add this tag if you resubmit.

Alternatively, I can just queue it up, because IMV this is an
improvement regardless of the rest of the series.

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
