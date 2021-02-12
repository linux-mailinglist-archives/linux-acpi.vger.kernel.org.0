Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDF31A0BE
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 15:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhBLOiB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 09:38:01 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40747 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhBLOhk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 09:37:40 -0500
Received: by mail-oi1-f180.google.com with SMTP id 18so10153127oiz.7;
        Fri, 12 Feb 2021 06:37:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eidZG+I3Er5dt5H72FEzd2tmVBif8YR3658fF+5wafQ=;
        b=PVrNTr+nT6+SHbO45LQdNW1WBUI25D106AoZGb0nWrS8M1DJcu/paX/0HZ4DsEswYs
         pOzVyCOR924GTeVOw6wE4TikzewhAavTc0hy4lemJae5PaWywCYvoi4stmwyyKltGZW4
         CWvLNdUW/l+ajlkoo8t4WidufdnRNEEr7/I/XmuCkwFdU8/+X3FaFokB9Oyr987SgGtm
         U7wAkgZXTNuuX/veNwI21rb06OUVzAL1/BfzzyhKK3/XEg2ON7ivSwP15HGbE68gbXaR
         WfWvc74p7Z8KwUWkQ6xMwEhhBTdRB/Fh9gg0mgyazEpIwLP7P3aylJxc5298/Si1SNrB
         mMmw==
X-Gm-Message-State: AOAM531usFDK+Egez66fOu1eH7XMyUbZjSuF89+FIv0N6MBKuNoM29Zk
        KniFE9IdsbA8loDj8Ggvw9epmgoSTd3bJqif35M=
X-Google-Smtp-Source: ABdhPJzr3qg/PJ3Q7Bn4we8RXLAGDjnxwBiKNtRbp9C7s1FQH8WlkJy6oY3XNw8X76IM8tqVELRXBkcF+Q0cdQdxYe4=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr2018082oia.157.1613140618202;
 Fri, 12 Feb 2021 06:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210212141121.62115-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Feb 2021 15:36:47 +0100
Message-ID: <CAJZ5v0iE2yU9Dptwkyz8PgoGzdSk_8vS69Y+=hE2_o_R=+rbNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ACPI: property: Remove dead code
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 12, 2021 at 3:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> After the commit 3a7a2ab839ad couple of functions became a dead code.
> Moreover, for all these years nobody used them. Remove.
>
> Fixes: 3a7a2ab839ad ("ACPI / property: Extend fwnode_property_* to data-only subnodes")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patches [1-4/5] from this series applied as 5.12 material and please
see my comments for the last one sent separately.

Thanks!

> ---
>  drivers/acpi/property.c | 20 --------------------
>  include/linux/acpi.h    | 21 ---------------------
>  2 files changed, 41 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 16b28084c1ca..22ccab4e7c6d 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -841,20 +841,6 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
>         return ret;
>  }
>
> -int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
> -                             enum dev_prop_type proptype, void *val)
> -{
> -       int ret;
> -
> -       if (!adev || !val)
> -               return -EINVAL;
> -
> -       ret = acpi_data_prop_read_single(&adev->data, propname, proptype, val);
> -       if (ret < 0 || proptype != ACPI_TYPE_STRING)
> -               return ret;
> -       return 0;
> -}
> -
>  static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
>                                        size_t nval)
>  {
> @@ -995,12 +981,6 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
>         return ret;
>  }
>
> -int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
> -                      enum dev_prop_type proptype, void *val, size_t nval)
> -{
> -       return adev ? acpi_data_prop_read(&adev->data, propname, proptype, val, nval) : -EINVAL;
> -}
> -
>  /**
>   * acpi_node_prop_read - retrieve the value of an ACPI property with given name.
>   * @fwnode: Firmware node to get the property from.
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ea296289a94c..14ac25165ae1 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1121,14 +1121,9 @@ acpi_data_add_props(struct acpi_device_data *data, const guid_t *guid,
>
>  int acpi_node_prop_get(const struct fwnode_handle *fwnode, const char *propname,
>                        void **valptr);
> -int acpi_dev_prop_read_single(struct acpi_device *adev,
> -                             const char *propname, enum dev_prop_type proptype,
> -                             void *val);
>  int acpi_node_prop_read(const struct fwnode_handle *fwnode,
>                         const char *propname, enum dev_prop_type proptype,
>                         void *val, size_t nval);
> -int acpi_dev_prop_read(const struct acpi_device *adev, const char *propname,
> -                      enum dev_prop_type proptype, void *val, size_t nval);
>
>  struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>                                             struct fwnode_handle *child);
> @@ -1230,14 +1225,6 @@ static inline int acpi_node_prop_get(const struct fwnode_handle *fwnode,
>         return -ENXIO;
>  }
>
> -static inline int acpi_dev_prop_read_single(const struct acpi_device *adev,
> -                                           const char *propname,
> -                                           enum dev_prop_type proptype,
> -                                           void *val)
> -{
> -       return -ENXIO;
> -}
> -
>  static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
>                                       const char *propname,
>                                       enum dev_prop_type proptype,
> @@ -1246,14 +1233,6 @@ static inline int acpi_node_prop_read(const struct fwnode_handle *fwnode,
>         return -ENXIO;
>  }
>
> -static inline int acpi_dev_prop_read(const struct acpi_device *adev,
> -                                    const char *propname,
> -                                    enum dev_prop_type proptype,
> -                                    void *val, size_t nval)
> -{
> -       return -ENXIO;
> -}
> -
>  static inline struct fwnode_handle *
>  acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>                       struct fwnode_handle *child)
> --
> 2.30.0
>
