Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E24357F6F
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2019 11:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfF0JjW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Jun 2019 05:39:22 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33426 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JjW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Jun 2019 05:39:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so1630227otl.0
        for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2019 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2ekETM4fKeRevTrixLm0mXW0oYRCPcem5D5CxK1aEY=;
        b=I9N7+A+QsVKVJt5gFtY5EsgT3GLtKMr3VEUUiWaz3Tj/EQqW8LcVoSJmpt5s/XRedi
         9Cpf5DOxgYlseVI3r6jsPjBP4Ig3rQ9NyiPkMB/e8mOpdm7lpvCHdPYSQ1PrM+0/onRb
         8bY5JmXshs5+kseRxh8fYg+vs5jFNOwNpGTtGweW1EuyLpcfzvgzsU+RhLAx6QGLsEFk
         ZOme2qC59jyHkjvG34FGdqP3YzvVHzV0ChbCzs9jjKeNfzCe5JJrUX/40lOiJXolKjSV
         V9RG4GhxoPxcz0IzqfGPzf2cYBbHxoj8DsaJL7WvRFTDbXjjwzYOQw/5ygEtxrFnSCVu
         +ZrQ==
X-Gm-Message-State: APjAAAUfq4r5GPyICqqT7/eDrnpGBRwBFlUDvrbrmbLJBE4oWEiAgqgI
        Myrmnygedm0mdsd9Jd8WmXjkXWbaxOgtP3673tA=
X-Google-Smtp-Source: APXvYqx1vC+G2STtO3Oiq49V6CCXxRaqEQC67XDLklK1lL7gL6P31xV2IO7NENn/6uSCBQwk1NUjtJrCr+mUAv9hZJI=
X-Received: by 2002:a9d:5d15:: with SMTP id b21mr2648855oti.262.1561628361346;
 Thu, 27 Jun 2019 02:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
In-Reply-To: <20190626153611.10170-1-ckeepax@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Jun 2019 11:39:10 +0200
Message-ID: <CAJZ5v0hvN=8YmF+v6wKx9mQ=DRosAtK7QU=EWYf5PXEDsn4FEQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] device property: Add new array helper
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 26, 2019 at 5:36 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> It is fairly common to want to read an integer array property
> that is composed of an unknown number of fixed size integer
> groups. For example, say each group consists of three values
> which correspond to the settings for one input on the device
> and the driver supports several chips with different numbers
> of inputs.
>
> Add a new helper function to provide this functionality, it
> differs for the existing helpers in that it allows reading a
> smaller number of values than the full array size and checks
> that the number of values read is a multiple of the group size.

I'm not convinced.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/base/property.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 50 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 348b37e64944c..656d21e01a648 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -133,6 +133,54 @@ int device_property_read_u32_array(struct device *dev, const char *propname,
>  EXPORT_SYMBOL_GPL(device_property_read_u32_array);
>
>  /**
> + * device_property_read_u32_2darray - return a 2d u32 array property of a device
> + * @dev: Device to get the property of
> + * @propname: Name of the property
> + * @val: The values are stored here or %NULL to return the number of values
> + * @nval: Size of the @val array
> + * @multiple: Number of entries in each block of data
> + *
> + * Function reads an array of u32 properties split up into fixed size
> + * sub-groups, with @propname from the device firmware description and
> + * stores them to @val if found.
> + *
> + * Return: Number of values read
> + *        %0 if the property was not found,
> + *        %-EINVAL if given arguments are not valid,
> + *        %-ENODATA if the property does not have a value,
> + *        %-EPROTO if the property is not an array of numbers,
> + *        %-EOVERFLOW if the size of the property is not as expected.
> + *        %-ENXIO if no suitable firmware interface is present.
> + */
> +int device_property_read_u32_2darray(struct device *dev, const char *propname,
> +                                    u32 *val, size_t nval, int multiple)
> +{
> +       int n, ret;
> +
> +       n = device_property_read_u32_array(dev, propname, NULL, 0);
> +       if (n == -EINVAL) {
> +               return 0;       /* missing, ignore */

Why can't the caller use the (scheduled for merging in the 5.3 cycle)
new device_property_count_u32() to get the size of the array?

> +       } else if (n < 0) {
> +               dev_warn(dev, "%s malformed (%d)\n", propname, n);

Why dev_warn()?  Is there any reason real for anything higher-level
that dev_dbg() here?

> +               return n;
> +       } else if ((n % multiple) != 0) {

I guess the reason why this matters is that the caller expects a
certain number of full "rows" and n values are read.  Why not to
discard the extra values instead of returning an error here?

> +               dev_warn(dev, "%s not a multiple of %d entries\n",
> +                        propname, multiple);
> +               return -EOVERFLOW;

Why this error code?

> +       }
> +
> +       if (n > nval)
> +               n = nval;
> +
> +       ret = device_property_read_u32_array(dev, propname, val, n);

So this reads "copy at most nval values from the array property".

If that's really what you need, it can be done in two lines of code in
prospective callers of this wrapper.

> +       if (ret < 0)
> +               return ret;
> +       else
> +               return n;
> +}
> +EXPORT_SYMBOL_GPL(device_property_read_u32_2darray);
> +
> +/**
>   * device_property_read_u64_array - return a u64 array property of a device
>   * @dev: Device to get the property of
>   * @propname: Name of the property
> diff --git a/include/linux/property.h b/include/linux/property.h
> index e9caa290cda52..5ab0b4a7d34a2 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -40,6 +40,8 @@ int device_property_read_u16_array(struct device *dev, const char *propname,
>                                    u16 *val, size_t nval);
>  int device_property_read_u32_array(struct device *dev, const char *propname,
>                                    u32 *val, size_t nval);
> +int device_property_read_u32_2darray(struct device *dev, const char *propname,
> +                                    u32 *val, size_t nval, int multiple);
>  int device_property_read_u64_array(struct device *dev, const char *propname,
>                                    u64 *val, size_t nval);
>  int device_property_read_string_array(struct device *dev, const char *propname,
> --

I don't see much value in this change, sorry.
