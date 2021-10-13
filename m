Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046E242C84D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 20:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhJMSGZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 14:06:25 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37660 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhJMSGY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Oct 2021 14:06:24 -0400
Received: by mail-oi1-f178.google.com with SMTP id o83so4972417oif.4;
        Wed, 13 Oct 2021 11:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmvaKZ3JNlPqgI+FpNO1pWiUoIUTD5mfBXxqCsyQVd4=;
        b=yRT01rUsMfH4ISAFvQGHqxFTWMi3PDCD5BxeAQXYuAivEn1g6RouSFln78azewefXs
         IoxZ5Ojfr6xkYsMnYAUHGFyNgJs4hYmazgZnXhI2nMJHGfCB2Rw9HC2NdmIcSL8WZM0t
         ddTpJefL27kUPvHjftt5Y1Gjb4AYgnFfOuYIwLboVeYPUExlxhMuUOgi8gmJnyxKaoek
         2Tg1wkHNOUFh6WoVF02UneonBdQ4pXOgFlcBuqoiOZUHx6m5xnpEXO1m2wsILpeVouWQ
         QjSBT9/CdGj1WZcSGR8yf3wbv1erhIfdDPqN+U1PgRNHmO/0OAC++z+2HoPp3xBcLIf2
         Ml9w==
X-Gm-Message-State: AOAM531Y7rD8ZSYFHNFpK0iLiBh+cKqD2HjV4bi+Z2IKn+Wil1lFu3MX
        gUKcTWdmH3eG2q9hvZtsfa8UlZPeSY6W8kCiN6s=
X-Google-Smtp-Source: ABdhPJwjUGZQz+P/+UB42OUr4UBDYvA6hm08h/w3EZHQT1aJLfFk2sq1OwDDsKHASzDel4InVeHw5l0OMPFAAHHHFTs=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr9511001oif.51.1634148261086;
 Wed, 13 Oct 2021 11:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <1634095490-3799-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1634095490-3799-1-git-send-email-wangqing@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Oct 2021 20:04:10 +0200
Message-ID: <CAJZ5v0jkQyj2+M0FeQTAczycc2NzOa+VJD5N3QMkmE8hCT0SWg@mail.gmail.com>
Subject: Re: [PATCH] acpi: replace snprintf in show functions with sysfs_emit
To:     Qing Wang <wangqing@vivo.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 13, 2021 at 5:25 AM Qing Wang <wangqing@vivo.com> wrote:
>
> coccicheck complains about the use of snprintf() in sysfs show functions.
>
> Fix the coccicheck warning:
> WARNING: use scnprintf or sprintf.
>
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
>
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/acpi/acpi_lpss.c | 2 +-
>  drivers/acpi/dock.c      | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 894b7e6..9c437d4 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -748,7 +748,7 @@ static ssize_t lpss_ltr_show(struct device *dev, struct device_attribute *attr,
>         if (ret)
>                 return ret;
>
> -       return snprintf(buf, PAGE_SIZE, "%08x\n", ltr_value);
> +       return sysfs_emit(buf, "%08x\n", ltr_value);
>  }
>
>  static ssize_t lpss_ltr_mode_show(struct device *dev,
> diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
> index 7cf9215..c8e9b96 100644
> --- a/drivers/acpi/dock.c
> +++ b/drivers/acpi/dock.c
> @@ -492,7 +492,7 @@ static ssize_t docked_show(struct device *dev,
>         struct acpi_device *adev = NULL;
>
>         acpi_bus_get_device(dock_station->handle, &adev);
> -       return snprintf(buf, PAGE_SIZE, "%u\n", acpi_device_enumerated(adev));
> +       return sysfs_emit(buf, "%u\n", acpi_device_enumerated(adev));
>  }
>  static DEVICE_ATTR_RO(docked);
>
> @@ -504,7 +504,7 @@ static ssize_t flags_show(struct device *dev,
>  {
>         struct dock_station *dock_station = dev->platform_data;
>
> -       return snprintf(buf, PAGE_SIZE, "%d\n", dock_station->flags);
> +       return sysfs_emit(buf, "%d\n", dock_station->flags);
>
>  }
>  static DEVICE_ATTR_RO(flags);
> @@ -543,7 +543,7 @@ static ssize_t uid_show(struct device *dev,
>         if (ACPI_FAILURE(status))
>                 return 0;
>
> -       return snprintf(buf, PAGE_SIZE, "%llx\n", lbuf);
> +       return sysfs_emit(buf, "%llx\n", lbuf);
>  }
>  static DEVICE_ATTR_RO(uid);
>
> @@ -562,7 +562,7 @@ static ssize_t type_show(struct device *dev,
>         else
>                 type = "unknown";
>
> -       return snprintf(buf, PAGE_SIZE, "%s\n", type);
> +       return sysfs_emit(buf, "%s\n", type);
>  }
>  static DEVICE_ATTR_RO(type);
>
> --

Applied as 5.16 material with some edits in the subject and changelog, thanks!
