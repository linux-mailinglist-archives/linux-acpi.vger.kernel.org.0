Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1C3CBB2C
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 19:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGPRb6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 13:31:58 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:46733 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGPRb6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jul 2021 13:31:58 -0400
Received: by mail-oi1-f181.google.com with SMTP id t25so11682056oiw.13;
        Fri, 16 Jul 2021 10:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6mBSGEQ2PUgYALYpaho9euhH7yHslY6CwXaUaYLnKQ=;
        b=iLBDOrZDGSAFheUcs25D2QA/YEMekSjdhQiJpbhGX7PD86aZvJLqeR+ZLgayOZ3yHD
         YWZzcJXDly2PSb8xEoMb7/qQCyHId06iEjvWWgRTwZ+lbVGTNB9G8sWqfyRUvsALtVcw
         0R4y5VJOJHJyXxre9CNFT7eRSuyQ6ACSYxPmb0IseoIg9fObXEUcqJ8Q73SOy552rZNR
         MUeT3TfuHlNrXwQuq/RvIZ3gkNIHxo+BWIhjXS9HRBSuQDjPKWE9KdmS90Z+hmkymjN1
         IyKf7BK8uodLnygmeOQwGFBZw9fdnaSRISRrPsYk00DOq1j8uDYMlPIlK/OwqVIVIhDK
         bktQ==
X-Gm-Message-State: AOAM533fRtcFsbPmS69ZbprU50ASY4+mEpRp16dzPFArB/aifWrgTKAn
        Bk/2vk5LEfaCpyVGzWVNY3bSfxUf2frZRytxNt0=
X-Google-Smtp-Source: ABdhPJwSbkfOdjeei8TwHmwUrgoW1akU7sF/SvpcPNEtQH6hwggXdya/fzJBDHqzePBcQVXwN8amUixZpVSoYtHmX+I=
X-Received: by 2002:aca:4f57:: with SMTP id d84mr8863695oib.71.1626456541912;
 Fri, 16 Jul 2021 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141651.82325-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210715141651.82325-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jul 2021 19:28:51 +0200
Message-ID: <CAJZ5v0h=70mAb5y_bfJ1tS8nhoBU+KFwkZ_t5g49UA=4EMFcFw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: configfs: Use sysfs_emit() in "show" functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 15, 2021 at 4:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The sysfs_emit() function was introduced to make it less ambiguous
> which function is preferred when writing to the output buffer in
> a "show" callback [1].
>
> Convert the GPIO library sysfs interface from sprintf() to sysfs_emit()
> accordingly, as the latter is aware of the PAGE_SIZE buffer and correctly
> returns the number of bytes written into the buffer.
>
> No functional change intended.
>
> [1] Documentation/filesystems/sysfs.rst
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_configfs.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 76b83b181356..6e6ef8a1f447 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -103,7 +103,7 @@ static ssize_t acpi_table_signature_show(struct config_item *cfg, char *str)
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->signature);
> +       return sysfs_emit(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->signature);
>  }
>
>  static ssize_t acpi_table_length_show(struct config_item *cfg, char *str)
> @@ -113,7 +113,7 @@ static ssize_t acpi_table_length_show(struct config_item *cfg, char *str)
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%d\n", h->length);
> +       return sysfs_emit(str, "%d\n", h->length);
>  }
>
>  static ssize_t acpi_table_revision_show(struct config_item *cfg, char *str)
> @@ -123,7 +123,7 @@ static ssize_t acpi_table_revision_show(struct config_item *cfg, char *str)
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%d\n", h->revision);
> +       return sysfs_emit(str, "%d\n", h->revision);
>  }
>
>  static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char *str)
> @@ -133,7 +133,7 @@ static ssize_t acpi_table_oem_id_show(struct config_item *cfg, char *str)
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
> +       return sysfs_emit(str, "%.*s\n", ACPI_OEM_ID_SIZE, h->oem_id);
>  }
>
>  static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg, char *str)
> @@ -143,7 +143,7 @@ static ssize_t acpi_table_oem_table_id_show(struct config_item *cfg, char *str)
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h->oem_table_id);
> +       return sysfs_emit(str, "%.*s\n", ACPI_OEM_TABLE_ID_SIZE, h->oem_table_id);
>  }
>
>  static ssize_t acpi_table_oem_revision_show(struct config_item *cfg, char *str)
> @@ -153,7 +153,7 @@ static ssize_t acpi_table_oem_revision_show(struct config_item *cfg, char *str)
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%d\n", h->oem_revision);
> +       return sysfs_emit(str, "%d\n", h->oem_revision);
>  }
>
>  static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
> @@ -164,7 +164,7 @@ static ssize_t acpi_table_asl_compiler_id_show(struct config_item *cfg,
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->asl_compiler_id);
> +       return sysfs_emit(str, "%.*s\n", ACPI_NAMESEG_SIZE, h->asl_compiler_id);
>  }
>
>  static ssize_t acpi_table_asl_compiler_revision_show(struct config_item *cfg,
> @@ -175,7 +175,7 @@ static ssize_t acpi_table_asl_compiler_revision_show(struct config_item *cfg,
>         if (!h)
>                 return -EINVAL;
>
> -       return sprintf(str, "%d\n", h->asl_compiler_revision);
> +       return sysfs_emit(str, "%d\n", h->asl_compiler_revision);
>  }
>
>  CONFIGFS_ATTR_RO(acpi_table_, signature);
> --

Applied along with the [2/2[ as 5.15 material, thanks!
