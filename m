Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75F119250F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Mar 2020 11:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgCYKFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Mar 2020 06:05:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33690 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgCYKFt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Mar 2020 06:05:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id m14so1585797oic.0;
        Wed, 25 Mar 2020 03:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kx6zWzWlFb2q6tLbIGNUJ4/Vt+PrSLq5ud8xhYBRhgA=;
        b=EuHEDyB57eZf3L3yGmVihgmC3bhHNHnRnNVZvLjoQWe+u8StLC1YQIfPwyJrM4tWK0
         yFlceBXYHUKEa/KBzJ/eR+vW5M+lc1Q+Wm5EqcvNCz1o8USb85MrN14AJyHXwR9EF0O3
         qPV0FPAKsI2yT+YzwQdvsJC5ha9Xl2MRRZamrCD1Zew7nf2HPfjAhoKVh1n1oMpvbx6Q
         2ojqVAi1H2qEk16yKT1UjI8h5FOrY6SEmY//sXONb4uGsbAjFMs56kVeJr0oPuUtLLjm
         rDEbds3LcqdM0mC2VS6uAs5P/42aniJOahc6Pz7YUa34TyYjJW8mqWzZOr9T5RdwYIRS
         0Fbw==
X-Gm-Message-State: ANhLgQ1bdoWfe8PqPeFJ7/DaVz34mpkj0q6cyMtV5m+nlEoTfqcQTP8j
        JtJ93tKFt99v/VFHFzoRg4JfBYodIRgBStumKfk=
X-Google-Smtp-Source: ADFU+vtOyDIGXvu5ZBYH6gJK0sVQRrbQ385r2m1A6DOdRsKzFm55S1la0Vnjw3U5JFdGNrLljxf66cKaHUbGIpXYluQ=
X-Received: by 2002:aca:f07:: with SMTP id 7mr215666oip.68.1585130747875; Wed,
 25 Mar 2020 03:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319195046.GA452@embeddedor.com>
In-Reply-To: <20200319195046.GA452@embeddedor.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Mar 2020 11:05:36 +0100
Message-ID: <CAJZ5v0iDVL1WWTmmQX+2JDmyAfu2e8nSdLSmCqA-WZV+7pBHvw@mail.gmail.com>
Subject: Re: [PATCH][next] acpi: nfit.h: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 19, 2020 at 9:15 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Dan,

I'm assuming that you will take care of this one or please let me know
otherwise.

Cheers!

> ---
>  drivers/acpi/nfit/nfit.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 24241941181c..af09143ce403 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -144,32 +144,32 @@ struct nfit_spa {
>         unsigned long ars_state;
>         u32 clear_err_unit;
>         u32 max_ars;
> -       struct acpi_nfit_system_address spa[0];
> +       struct acpi_nfit_system_address spa[];
>  };
>
>  struct nfit_dcr {
>         struct list_head list;
> -       struct acpi_nfit_control_region dcr[0];
> +       struct acpi_nfit_control_region dcr[];
>  };
>
>  struct nfit_bdw {
>         struct list_head list;
> -       struct acpi_nfit_data_region bdw[0];
> +       struct acpi_nfit_data_region bdw[];
>  };
>
>  struct nfit_idt {
>         struct list_head list;
> -       struct acpi_nfit_interleave idt[0];
> +       struct acpi_nfit_interleave idt[];
>  };
>
>  struct nfit_flush {
>         struct list_head list;
> -       struct acpi_nfit_flush_address flush[0];
> +       struct acpi_nfit_flush_address flush[];
>  };
>
>  struct nfit_memdev {
>         struct list_head list;
> -       struct acpi_nfit_memory_map memdev[0];
> +       struct acpi_nfit_memory_map memdev[];
>  };
>
>  enum nfit_mem_flags {
> --
> 2.23.0
>
