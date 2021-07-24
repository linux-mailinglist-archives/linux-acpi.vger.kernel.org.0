Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F423D473D
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jul 2021 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhGXKKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Jul 2021 06:10:48 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34476 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhGXKKr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Jul 2021 06:10:47 -0400
Received: by mail-oi1-f182.google.com with SMTP id t128so4905082oig.1;
        Sat, 24 Jul 2021 03:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSxrZ2sI39q3l0xRzXWO3p3dMvgYkGBFTEKMFJRrnjE=;
        b=q82tDnXAcNrxHponB1D9dP+cVXOMWOzlg1DiVqK7GH2RSTW2NZVFVuyp8rWElDskk4
         ALRNkqVkvhi3PCcSbhQVnj6d4Um7DAyXTTzSL+dXu3hM2fzRAv/Rfm8Tp991JfcFlBZ3
         t07tBl52MFAv8amgjylMSW+U8OSWYRO86+dC78Zo45PBoEG4wsGAZ8rnU9HY6ws5dhvh
         lhmDrVJ/cdmTKkkS3ZxrCaPDUCeIhliAGCXzGHhRun1PBHPAlE3YvZuQF/j9vp2qP9FM
         Ioi+KF2xmgz+/Op4nqmDG33M+PShNyiaLADdSzZeJZoRFxtLNKo96f5hva+SgnyFbnq0
         0GRQ==
X-Gm-Message-State: AOAM530bmYcn0+y1chHHCD/9bRLsco5QYJRPgJnsNWY4IKVnFDLSCqLx
        mwJ+aWlzLfXN/STm9F7XzeOBy/bq8SZu/V/dExE=
X-Google-Smtp-Source: ABdhPJz8M0HErmLuiXME8b8E+N6J50TDx2ECiaChe6wY2+mtgKNSAUJdkchiuPsP3nrLFylQZe6ALDCUN+WNXQokO6g=
X-Received: by 2002:aca:4f57:: with SMTP id d84mr5768536oib.71.1627123879586;
 Sat, 24 Jul 2021 03:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
In-Reply-To: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Jul 2021 12:51:07 +0200
Message-ID: <CAJZ5v0jVA6_A+8xJPqPG1KyE8GP_ge9Angf-uCkHRSeaW3LnFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: Add acpi_init_properties to ACPI driver code
To:     Michael Bottini <michael.a.bottini@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, irenic.rajneesh@gmail.com,
        David Box <david.e.box@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 23, 2021 at 10:25 PM Michael Bottini
<michael.a.bottini@linux.intel.com> wrote:
>
> Some products in the field, like Intel Rocket Lake systems, contain
> AML code that can modify _DSD properties after they have been
> evaluated by ACPI init code.

That is directly against the spec.

> Therefore, there is a need for drivers
> to be able to reevaluate _DSDs so that the updated property values can
> be read. Export acpi_init_properties() for this purpose.

I'm not sure.  By the spec, the OS need not evaluate _DSD for a given
device more than once.

> Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
> ---
>  drivers/acpi/property.c | 1 +
>  include/linux/acpi.h    | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e312ebaed8db..2c1f8cf1a8f0 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -432,6 +432,7 @@ void acpi_init_properties(struct acpi_device *adev)
>         if (!adev->data.pointer)
>                 acpi_extract_apple_properties(adev);
>  }
> +EXPORT_SYMBOL(acpi_init_properties);

EXPORT_SyMBOL_GPL(), please.

>  static void acpi_destroy_nondev_subnodes(struct list_head *list)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 72e4f7fd268c..57defc3bc9b9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -716,6 +716,8 @@ static inline u64 acpi_arch_get_root_pointer(void)
>
>  int acpi_get_local_address(acpi_handle handle, u32 *addr);
>
> +void acpi_init_properties(struct acpi_device *adev);
> +
>  #else  /* !CONFIG_ACPI */
>
>  #define acpi_disabled 1
> @@ -976,6 +978,10 @@ static inline int acpi_get_local_address(acpi_handle handle, u32 *addr)
>         return -ENODEV;
>  }
>
> +static inline void acpi_init_properties(struct acpi_device *adev)
> +{
> +}
> +
>  #endif /* !CONFIG_ACPI */
>
>  #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
> --
> 2.25.1
>
