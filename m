Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B3C494C5
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2019 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfFQWI6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Jun 2019 18:08:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37982 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfFQWI6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jun 2019 18:08:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id d17so11424336oth.5;
        Mon, 17 Jun 2019 15:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVGovsCu3s9xFzYqs76/OOxU3RO0LqN3L2Me3A6QEbQ=;
        b=Iez6Cho4OX3qJVGIHaiLwlHikZE+OBfgxoH3Aj+AeLQWuF5AvCL5ly9Hr3jDgAEJ9y
         6j7/gN1qyHDmxKD0CJFwWfkqo/obn03ZiTTTQ+dqxOxG9Ir8h7oYQcXXOKDz6u/Xj7nv
         zGOzTPHlHN/3R3s+e7pN4yKNGiBVdrFdwuJDMEDQnZ8widg6lAzaxcy9G4pVZ/xD/QPj
         GtVpkoV2jozVvhyfJh020vj1J2HAnCvpAZxqHh7J/TRKlsCxVEhEJe66QTrK7f47o9Nw
         0P0pU9RSJkaoUh111pRp8bZ/U+Bz5MO94hMCk8G7gyR7dmO0VZ5yXJE5MhlvzDtm4BV2
         2xDw==
X-Gm-Message-State: APjAAAX9D9qq/jJFCF1i7WsG4uhLa2jUvDq1fsndIZvACpys4RfcBNEM
        q1RmTKHAeOvz4j1XhyO3zMG1SEhRIlMKBwDk5RNOvw==
X-Google-Smtp-Source: APXvYqyUG5kdCBMqwHnpebHjBONA84oIsXKvQ35/wbQ7U81k8BKi3Bow7ZGeutN6gWFecLhz9R7A8bl/Ab+v1fA46Ls=
X-Received: by 2002:a9d:5e99:: with SMTP id f25mr32700216otl.262.1560809337167;
 Mon, 17 Jun 2019 15:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <1560534863-15115-1-git-send-email-suzuki.poulose@arm.com> <1560534863-15115-4-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1560534863-15115-4-git-send-email-suzuki.poulose@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Jun 2019 00:08:45 +0200
Message-ID: <CAJZ5v0j-AwFkeK35xG-WnDq8_wrzfH-0jqv6hVW+7uZD3R2k8Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/28] acpi: utils: Cleanup acpi_dev_match_cb
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 14, 2019 at 7:54 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> The prototype of bus_find_device() will be unified with that of
> class_find_device() subsequently, but for this purpose the callback
> functions passed to it need to take (const void *) as the second
> argument.  Consequently, they cannot modify the memory pointed to by
> that argument which currently is not the case for acpi_dev_match_cb().
> However, acpi_dev_match_cb() really need not modify the "match" object
> passed to it, because acpi_dev_get_first_match_dev() which uses it via
> bus_find_device() can easily convert the result of bus_find_device()
> into the pointer to return.
>
> For this reason, update acpi_dev_match_cb() to avoid the redundant
> memory updates.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Or if you want me to take this patch, please let me know.

> ---
>  drivers/acpi/utils.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index 7def63a..1391b63 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -725,8 +725,6 @@ bool acpi_dev_found(const char *hid)
>  EXPORT_SYMBOL(acpi_dev_found);
>
>  struct acpi_dev_match_info {
> -       const char *dev_name;
> -       struct acpi_device *adev;
>         struct acpi_device_id hid[2];
>         const char *uid;
>         s64 hrv;
> @@ -746,9 +744,6 @@ static int acpi_dev_match_cb(struct device *dev, void *data)
>             strcmp(adev->pnp.unique_id, match->uid)))
>                 return 0;
>
> -       match->dev_name = acpi_dev_name(adev);
> -       match->adev = adev;
> -
>         if (match->hrv == -1)
>                 return 1;
>
> @@ -818,7 +813,7 @@ acpi_dev_get_first_match_dev(const char *hid, const char *uid, s64 hrv)
>         match.hrv = hrv;
>
>         dev = bus_find_device(&acpi_bus_type, NULL, &match, acpi_dev_match_cb);
> -       return dev ? match.adev : NULL;
> +       return dev ? to_acpi_device(dev) : NULL;
>  }
>  EXPORT_SYMBOL(acpi_dev_get_first_match_dev);
>
> --
> 2.7.4
>
