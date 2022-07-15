Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32B757667A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 19:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiGOR7f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGOR7e (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 13:59:34 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A242AD1
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 10:59:33 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31c89653790so53920567b3.13
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 10:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OL115/uLnx4Z69H1KMkVWDc/oA2Cx5YMuZmCc/PXOW4=;
        b=H2Q//dttmkwWvJJYaaZfYLOFU+JwbPvmmGTkXusxNUzcoYrzskC6uYPFoGmSx94B5L
         GRJOIy4f4uP29hC2cSzmb1spzH1MfH0R8sE5MI2ewWJiluQq8Il3apvW3ZVBZOb94kix
         Z1ud5/WIynt1LU2OXeFDK9Mpl6McZAvs/I7D9+BmI9tBTpYSZzorxGK9JhRNzgZ113ef
         BqdKgJSrNE0VZE11RP29EjrGPyrzYp/BuKo1TjNiNrGQH65hI7UifYW9EGgB2f/pl3nO
         ird4QSFzVXIR1GV9Sme1ebjeEtoPnRKt9CT1zZSiSKLoG5R+v4a1kazjq7R8VjEGCufI
         +3XA==
X-Gm-Message-State: AJIora8QGFhATCbDCXSYqQIFSd22IVkwJP91x3UjNHO/sKXqJ1dUWMkA
        dZTu9onQ2Wug6CGZ+CRhnUY4gG9oTxSb/XMg+oq6s9W1
X-Google-Smtp-Source: AGRyM1ts1/vk2f17xUqQeA5k4bWym3UqetdbZSi8id11BN1h+f75mpWGxiSg4zc6/yQayt6kPzgaKinlsW/eK8MP9VA=
X-Received: by 2002:a0d:d952:0:b0:31d:789d:221c with SMTP id
 b79-20020a0dd952000000b0031d789d221cmr16865835ywe.515.1657907972494; Fri, 15
 Jul 2022 10:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220711112606.3050368-1-sakari.ailus@linux.intel.com> <20220711112606.3050368-8-sakari.ailus@linux.intel.com>
In-Reply-To: <20220711112606.3050368-8-sakari.ailus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:59:21 +0200
Message-ID: <CAJZ5v0gQuGYjH=twZKcy0FmsK6vVyboN0ubOXZqHVVNfyuP1PQ@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] ACPI: property: Add support for parsing buffer
 property UUID
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 11, 2022 at 1:24 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Add support for newly added buffer property UUID, as defined in the DSD
> guide.

A link to the DSD guide and a more specific reference to the relevant
part of it (eg. section number) would be handy.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 142 ++++++++++++++++++++++++++++++++++++----
>  include/acpi/acpi_bus.h |   3 +-
>  include/linux/acpi.h    |   2 +-
>  3 files changed, 132 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 236a847f1bfbd..7621f684212ff 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -55,14 +55,19 @@ static const guid_t ads_guid =
>         GUID_INIT(0xdbb8e3e6, 0x5886, 0x4ba6,
>                   0x87, 0x95, 0x13, 0x19, 0xf5, 0x2a, 0x96, 0x6b);
>
> +static const guid_t buffer_prop_guid =
> +       GUID_INIT(0xedb12dd0, 0x363d, 0x4085,
> +                 0xa3, 0xd2, 0x49, 0x52, 0x2c, 0xa1, 0x60, 0xc4);
> +
>  static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
> -                                          const union acpi_object *desc,
> +                                          union acpi_object *desc,
>                                            struct acpi_device_data *data,
>                                            struct fwnode_handle *parent);
> -static bool acpi_extract_properties(const union acpi_object *desc,
> +static bool acpi_extract_properties(acpi_handle handle,
> +                                   union acpi_object *desc,
>                                     struct acpi_device_data *data);
>
> -static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
> +static bool acpi_nondev_subnode_extract(union acpi_object *desc,
>                                         acpi_handle handle,
>                                         const union acpi_object *link,
>                                         struct list_head *list,
> @@ -81,7 +86,7 @@ static bool acpi_nondev_subnode_extract(const union acpi_object *desc,
>         INIT_LIST_HEAD(&dn->data.properties);
>         INIT_LIST_HEAD(&dn->data.subnodes);
>
> -       result = acpi_extract_properties(desc, &dn->data);
> +       result = acpi_extract_properties(handle, desc, &dn->data);
>
>         if (handle) {
>                 acpi_handle scope;
> @@ -156,7 +161,7 @@ static bool acpi_nondev_subnode_ok(acpi_handle scope,
>  }
>
>  static bool acpi_add_nondev_subnodes(acpi_handle scope,
> -                                    const union acpi_object *links,
> +                                    union acpi_object *links,
>                                      struct list_head *list,
>                                      struct fwnode_handle *parent)
>  {
> @@ -164,7 +169,7 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
>         int i;
>
>         for (i = 0; i < links->package.count; i++) {
> -               const union acpi_object *link, *desc;
> +               union acpi_object *link, *desc;
>                 acpi_handle handle;
>                 bool result;
>
> @@ -204,7 +209,7 @@ static bool acpi_add_nondev_subnodes(acpi_handle scope,
>  }
>
>  static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
> -                                          const union acpi_object *desc,
> +                                          union acpi_object *desc,
>                                            struct acpi_device_data *data,
>                                            struct fwnode_handle *parent)
>  {
> @@ -212,7 +217,8 @@ static bool acpi_enumerate_nondev_subnodes(acpi_handle scope,
>
>         /* Look for the ACPI data subnodes GUID. */
>         for (i = 0; i < desc->package.count; i += 2) {
> -               const union acpi_object *guid, *links;
> +               const union acpi_object *guid;
> +               union acpi_object *links;
>
>                 guid = &desc->package.elements[i];
>                 links = &desc->package.elements[i + 1];
> @@ -325,7 +331,7 @@ static bool acpi_is_property_guid(const guid_t *guid)
>
>  struct acpi_device_properties *
>  acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
> -                   const union acpi_object *properties)
> +                   union acpi_object *properties)
>  {
>         struct acpi_device_properties *props;
>
> @@ -377,7 +383,104 @@ static bool acpi_tie_nondev_subnodes(struct acpi_device_data *data)
>         return true;
>  }
>
> -static bool acpi_extract_properties(const union acpi_object *desc,
> +static void acpi_data_add_buffer_props(acpi_handle handle,
> +                                      struct acpi_device_data *data,
> +                                      union acpi_object *properties)
> +{
> +       struct acpi_device_properties *props;
> +       union acpi_object *package;
> +       size_t alloc_size;
> +       unsigned int i;
> +       u32 *count;
> +
> +       if (check_mul_overflow((size_t)properties->package.count,
> +                              sizeof(*package) + sizeof(void *),
> +                              &alloc_size) ||
> +           check_add_overflow(sizeof(*props) + sizeof(*package), alloc_size,
> +                              &alloc_size)) {
> +               acpi_handle_warn(handle,
> +                                "can't allocate memory for %u buffer props",
> +                                properties->package.count);
> +               return;
> +       }
> +
> +       props = kvzalloc(alloc_size, GFP_KERNEL);
> +       if (!props)
> +               return;
> +
> +       props->guid = &buffer_prop_guid;
> +       props->bufs = (void *)(props + 1);
> +       props->properties = (void *)(props->bufs + properties->package.count);
> +
> +       /* Outer package */
> +       package = props->properties;
> +       package->type = ACPI_TYPE_PACKAGE;
> +       package->package.elements = package + 1;
> +       count = &package->package.count;
> +       *count = 0;
> +
> +       /* Inner packages */
> +       package++;
> +
> +       for (i = 0; i < properties->package.count; i++) {
> +               struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
> +               union acpi_object *property = &properties->package.elements[i];
> +               union acpi_object *prop, *obj, *buf_obj;
> +               acpi_status status;
> +
> +               if (property->type != ACPI_TYPE_PACKAGE ||
> +                   property->package.count != 2) {
> +                       acpi_handle_warn(handle,
> +                                        "buffer property %u has %u entries\n",
> +                                        i, property->package.count);
> +                       continue;
> +               }
> +
> +               prop = &property->package.elements[0];
> +               obj = &property->package.elements[1];
> +
> +               if (prop->type != ACPI_TYPE_STRING ||
> +                   obj->type != ACPI_TYPE_STRING) {
> +                       acpi_handle_warn(handle,
> +                                        "wrong object types %u and %u\n",
> +                                        prop->type, obj->type);
> +                       continue;
> +               }
> +
> +               status = acpi_evaluate_object_typed(handle, obj->string.pointer,
> +                                                   NULL, &buf,
> +                                                   ACPI_TYPE_BUFFER);
> +               if (ACPI_FAILURE(status)) {
> +                       acpi_handle_warn(handle,
> +                                        "can't evaluate \"%*pE\" as buffer\n",
> +                                        obj->string.length,
> +                                        obj->string.pointer);
> +                       continue;
> +               }
> +
> +               package->type = ACPI_TYPE_PACKAGE;
> +               package->package.elements = prop;
> +               package->package.count = 2;
> +
> +               buf_obj = buf.pointer;
> +
> +               /* Replace the string object with a buffer object */
> +               obj->type = ACPI_TYPE_BUFFER;
> +               obj->buffer.length = buf_obj->buffer.length;
> +               obj->buffer.pointer = buf_obj->buffer.pointer;
> +
> +               props->bufs[i] = buf.pointer;
> +               package++;
> +               (*count)++;
> +       }
> +
> +       if (*count)
> +               list_add(&props->list, &data->properties);
> +       else
> +               kvfree(props);
> +}
> +
> +static bool acpi_extract_properties(acpi_handle scope, union acpi_object *desc,
>                                     struct acpi_device_data *data)
>  {
>         int i;
> @@ -387,7 +490,8 @@ static bool acpi_extract_properties(const union acpi_object *desc,
>
>         /* Look for the device properties GUID. */
>         for (i = 0; i < desc->package.count; i += 2) {
> -               const union acpi_object *guid, *properties;
> +               const union acpi_object *guid;
> +               union acpi_object *properties;
>
>                 guid = &desc->package.elements[i];
>                 properties = &desc->package.elements[i + 1];
> @@ -401,6 +505,12 @@ static bool acpi_extract_properties(const union acpi_object *desc,
>                     properties->type != ACPI_TYPE_PACKAGE)
>                         break;
>
> +               if (guid_equal((guid_t *)guid->buffer.pointer,
> +                              &buffer_prop_guid)) {
> +                       acpi_data_add_buffer_props(scope, data, properties);
> +                       continue;
> +               }
> +
>                 if (!acpi_is_property_guid((guid_t *)guid->buffer.pointer))
>                         continue;
>
> @@ -447,7 +557,7 @@ void acpi_init_properties(struct acpi_device *adev)
>         if (ACPI_FAILURE(status))
>                 goto out;
>
> -       if (acpi_extract_properties(buf.pointer, &adev->data)) {
> +       if (acpi_extract_properties(adev->handle, buf.pointer, &adev->data)) {
>                 adev->data.pointer = buf.pointer;
>                 if (acpi_of)
>                         acpi_init_of_compatible(adev);
> @@ -477,8 +587,14 @@ static void acpi_free_device_properties(struct list_head *list)
>         struct acpi_device_properties *props, *tmp;
>
>         list_for_each_entry_safe(props, tmp, list, list) {
> +               u32 i;
> +
>                 list_del(&props->list);
> -               kfree(props);
> +               /* Buffer data properties were separately allocated */
> +               if (props->bufs)
> +                       for (i = 0; i < props->properties->package.count; i++)
> +                               ACPI_FREE(props->bufs[i]);
> +               kvfree(props);
>         }
>  }
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 54c5566df9fe1..88a17fce49fd0 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -344,8 +344,9 @@ struct acpi_device_physical_node {
>
>  struct acpi_device_properties {
>         const guid_t *guid;
> -       const union acpi_object *properties;
> +       union acpi_object *properties;
>         struct list_head list;
> +       void **bufs;
>  };
>
>  /* ACPI Device Specific Data (_DSD) */
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 4f82a5bc6d987..93a695cab9d8a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1243,7 +1243,7 @@ static inline bool acpi_dev_has_props(const struct acpi_device *adev)
>
>  struct acpi_device_properties *
>  acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
> -                   const union acpi_object *properties);
> +                   union acpi_object *properties);
>
>  int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
>                        void **valptr);
> --
> 2.30.2
>
