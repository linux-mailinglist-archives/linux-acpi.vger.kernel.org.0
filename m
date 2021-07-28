Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9FE3D935F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jul 2021 18:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhG1Qmx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Jul 2021 12:42:53 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:37591 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhG1Qmx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Jul 2021 12:42:53 -0400
Received: by mail-oi1-f174.google.com with SMTP id u10so4476242oiw.4;
        Wed, 28 Jul 2021 09:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoahdUoTJmgO90Id083vGi+pQt/fW1gbAbXkiapC8Gg=;
        b=oXdi/seVs4NEdkpOLj92I07GeM/4MkItYmLl6E1ZCl1Z3tq4ZgIwbs66kiF/IScMl7
         jIv4BY0l81IbyYmgqi3MnZnm1WFxRDzc0ar6oBGQpzR6HqoVg/DPy8jjsqtn3yMM+UuV
         I+DHNwdOs6conHQnX1q+Z8/UIV80/btldXLnVRrkYnzUuEHRYKhrj7qWXeOXGyERoXz1
         kHsGhZbomjKaliqW1lnHz4TLbMVNpolrxj3VIadFDqFLa9X1rp24KEeWXNq6/9Zok6oR
         PPjuppwWpYofms82v1ZeBhusZJbKtaKWpKLGURrdRwSna56U4mVE5lgjuvnWG1yVUr+s
         OcEg==
X-Gm-Message-State: AOAM533+yWzvqgHAxrbTpia/aGVd2Kn+An/UoO9Bgn+XzBm/Mkas5zKq
        lvE3GJLczlACfwvE65S+RxEHljbyXZyoPyEXFw4=
X-Google-Smtp-Source: ABdhPJwma7J+ihIe5z42Hi+xHSqTodcKxI1fqLDMHRGUvD99vtD/3Roejnt3z6RuFovlJ5Tmt1wT5C/xFjzJyyuist0=
X-Received: by 2002:aca:3502:: with SMTP id c2mr7368957oia.157.1627490570388;
 Wed, 28 Jul 2021 09:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210727161824.425564-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210727161824.425564-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 28 Jul 2021 18:42:39 +0200
Message-ID: <CAJZ5v0hBFOY2md2iB8TN7KGPBPZF4=vKdfwX0uN7DwLuhccf-w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Fix reading of attributes
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 27, 2021 at 6:18 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> The current assumption that methods to read PCH FIVR attributes will
> return integer, is not correct. There is no good way to return integer
> as negative numbers are also valid.
>
> These read methods return a package of integers. The first integer returns
> status, which is 0 on success and any other value for failure. When the
> returned status is zero, then the second integer returns the actual value.
>
> This change fixes this issue by replacing acpi_evaluate_integer() with
> acpi_evaluate_object() and use acpi_extract_package() to extract results.
>
> Fixes: 2ce6324eadb01 ("ACPI: DPTF: Add PCH FIVR participant driver")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org # 5.10+

Applied as 5.14-rc material.

I'll apply the [2/2[ when this one is merged.

> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c | 51 ++++++++++++++++++++++++++-----
>  1 file changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
> index 5fca18296bf6..550b9081fcbc 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -9,6 +9,42 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>
> +struct pch_fivr_resp {
> +       u64 status;
> +       u64 result;
> +};
> +
> +static int pch_fivr_read(acpi_handle handle, char *method, struct pch_fivr_resp *fivr_resp)
> +{
> +       struct acpi_buffer resp = { sizeof(struct pch_fivr_resp), fivr_resp};
> +       struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +       struct acpi_buffer format = { sizeof("NN"), "NN" };
> +       union acpi_object *obj;
> +       acpi_status status;
> +       int ret = -EFAULT;
> +
> +       status = acpi_evaluate_object(handle, method, NULL, &buffer);
> +       if (ACPI_FAILURE(status))
> +               return ret;
> +
> +       obj = buffer.pointer;
> +       if (!obj || obj->type != ACPI_TYPE_PACKAGE)
> +               goto release_buffer;
> +
> +       status = acpi_extract_package(obj, &format, &resp);
> +       if (ACPI_FAILURE(status))
> +               goto release_buffer;
> +
> +       if (fivr_resp->status)
> +               goto release_buffer;
> +
> +       ret = 0;
> +
> +release_buffer:
> +       kfree(buffer.pointer);
> +       return ret;
> +}
> +
>  /*
>   * Presentation of attributes which are defined for INT1045
>   * They are:
> @@ -23,15 +59,14 @@ static ssize_t name##_show(struct device *dev,\
>                            char *buf)\
>  {\
>         struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
> -       unsigned long long val;\
> -       acpi_status status;\
> +       struct pch_fivr_resp fivr_resp;\
> +       int status;\
>  \
> -       status = acpi_evaluate_integer(acpi_dev->handle, #method,\
> -                                      NULL, &val);\
> -       if (ACPI_SUCCESS(status))\
> -               return sprintf(buf, "%d\n", (int)val);\
> -       else\
> -               return -EINVAL;\
> +       status = pch_fivr_read(acpi_dev->handle, #method, &fivr_resp);\
> +       if (status)\
> +               return status;\
> +\
> +       return sprintf(buf, "%llu\n", fivr_resp.result);\
>  }
>
>  #define PCH_FIVR_STORE(name, method) \
> --
> 2.31.1
>
