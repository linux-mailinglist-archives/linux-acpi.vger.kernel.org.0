Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6D80F43D8
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Nov 2019 10:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfKHJtv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Nov 2019 04:49:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33363 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbfKHJtu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Nov 2019 04:49:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id u13so4709097ote.0;
        Fri, 08 Nov 2019 01:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXhk35FnSv3RYE2duWbbP8N7X18rhZ+eNW/MZeoOBgU=;
        b=r/cW/KHO2PENnIlBy9OkqH0LVaHKDJNPKJkyj+P/t3dfspkPv0sXKqr46j17XPE9KN
         7CFVLHuA9Wx1jcIpgGlUGx+BjkiL2z9ri+uT7z1yafMRzxcPouxzq/SdFJmGUgyWKm3V
         dsUe2yo2CUkk28klnUOE2Ga9pnTXJgarEIbXN2tKy2HmuiWH8A5Vl+KaorKhbcLzXDB5
         D5GnwQyeaohotBjSVIV0mQPx3bjDtiUS6StOQTytpXMNsOX3rN89hn5g55JxRkwjFzPX
         u3sCWJimskleTBkiaUfSKkYId2kNIWfic+0F3tVIzh9Z53oEIjQlGJHR2EXA8sjLG83g
         eZJQ==
X-Gm-Message-State: APjAAAWzPGJc8ZljZ0xXlmgU9R/kz+vN3ZVqyYy4PjBnLl/OvSXEf/vz
        PRZQ4jX2bTjayIBksNhZIrjLLZnmo+P8eoN+oDY=
X-Google-Smtp-Source: APXvYqzH33iSMEk7XoGRawDI6yY8/C9YzXVKTLKUoEMi306vUDxotxdEUXKsTJYXJyw7+piUB6jQphkEqDEuWAZ6moI=
X-Received: by 2002:a05:6830:232a:: with SMTP id q10mr7756723otg.262.1573206589736;
 Fri, 08 Nov 2019 01:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20191108042225.45391-1-dmitry.torokhov@gmail.com> <20191108042225.45391-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20191108042225.45391-2-dmitry.torokhov@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Nov 2019 10:49:38 +0100
Message-ID: <CAJZ5v0ghf58k_-dVZZGygQRBiVZuFfKUpFUsNK_0D15jvftRMw@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] software node: rename is_array to is_inline
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 8, 2019 at 5:22 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> We do not need a special flag to know if we are dealing with an array,
> as we can get that data from ratio between element length and the data
> size, however we do need a flag to know whether the data is stored
> directly inside property_entry or separately.

So the subject is slightly misleading, because it is not a rename.  I
would say "replace x with y" instead.

[Arguably I can change that when applying the patch, but since we are
going to wait for the dependencies to go in, it should not be a big
deal to send an update of this patch alone?]

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/base/swnode.c    | 12 +++++-------
>  include/linux/property.h | 13 ++++++++-----
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index d8d0dc0ca5acf..18a30fb3cc588 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -108,10 +108,7 @@ static const void *property_get_pointer(const struct property_entry *prop)
>         if (!prop->length)
>                 return NULL;
>
> -       if (prop->is_array)
> -               return prop->pointer;
> -
> -       return &prop->value;
> +       return prop->is_inline ? &prop->value : prop->pointer;
>  }
>
>  static const void *property_entry_find(const struct property_entry *props,
> @@ -205,7 +202,7 @@ static void property_entry_free_data(const struct property_entry *p)
>         const char * const *src_str;
>         size_t i, nval;
>
> -       if (p->is_array) {
> +       if (!p->is_inline) {
>                 if (p->type == DEV_PROP_STRING && p->pointer) {
>                         src_str = p->pointer;
>                         nval = p->length / sizeof(const char *);
> @@ -250,7 +247,7 @@ static int property_entry_copy_data(struct property_entry *dst,
>         const void *pointer = property_get_pointer(src);
>         const void *new;
>
> -       if (src->is_array) {
> +       if (!src->is_inline) {
>                 if (!src->length)
>                         return -ENODATA;
>
> @@ -264,15 +261,16 @@ static int property_entry_copy_data(struct property_entry *dst,
>                                 return -ENOMEM;
>                 }
>
> -               dst->is_array = true;
>                 dst->pointer = new;
>         } else if (src->type == DEV_PROP_STRING) {
>                 new = kstrdup(src->value.str, GFP_KERNEL);
>                 if (!new && src->value.str)
>                         return -ENOMEM;
>
> +               dst->is_inline = true;
>                 dst->value.str = new;
>         } else {
> +               dst->is_inline = true;
>                 dst->value = src->value;
>         }
>
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 48335288c2a96..dad0ad11b55e2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -227,15 +227,17 @@ static inline int fwnode_property_count_u64(const struct fwnode_handle *fwnode,
>   * struct property_entry - "Built-in" device property representation.
>   * @name: Name of the property.
>   * @length: Length of data making up the value.
> - * @is_array: True when the property is an array.
> + * @is_inline: True when the property value is embedded in
> + *     &struct property_entry instance.
>   * @type: Type of the data in unions.
> - * @pointer: Pointer to the property (an array of items of the given type).
> - * @value: Value of the property (when it is a single item of the given type).
> + * @pointer: Pointer to the property when it is stored separately from
> + *     the &struct property_entry instance.
> + * @value: Value of the property when it is stored inline.

And while at it, can you please try to make the comments shorter so
they each take one line?
