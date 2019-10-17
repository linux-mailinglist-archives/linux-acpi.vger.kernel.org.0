Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B41DB960
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 23:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbfJQV5i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 17 Oct 2019 17:57:38 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33574 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733238AbfJQV5i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Oct 2019 17:57:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id a15so3545928oic.0
        for <linux-acpi@vger.kernel.org>; Thu, 17 Oct 2019 14:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7ow/KCMnejJ3Alv6EyqtdELKXD5cEkId/E4pUKclPlw=;
        b=HT1IWna2hZ6KH+Y4ULcQzYKe9s58DwXFaxJOpBMwuMFusMPHAGA/Fi/0t7laTO7xSb
         h/MMIalXdMubfodHvP8qHxaZonvsKyaAIqQ4KXjMdMp0JbBJlKh5ejD+uj5Tzdv4ZnmC
         H7QmUHHkaySYZxNvvqWYT3pA4KPtFLL6WS9xKBdZUmZK5p2tKdMg4iD+kZDJ9X2W/VcJ
         s9yJpb/Q6hPc3QPo3mFKboHOTN1QZbwe7xxwM62bxK2HnUNUeGRKKXukVCNYa5OCuX4T
         FbgQGQOcI4ePVlhE2yAG5+59eM53pD5surOP02dP6dvCLcEO3xHRwvizsHAax10Zu0zR
         cJQg==
X-Gm-Message-State: APjAAAXyH2jTT1teQOHL++3xKo58ZlSvpNgymfrpViUaTEfNlOSfpj60
        ArrXA25OcOAt+GBkD2Inty8N8mH3NIAzXcnifGI=
X-Google-Smtp-Source: APXvYqx7JYcKNYhiy5ikwajutD40IY4uktLO81oKhgX6TG7vXCIAqMget6A5fsR3ZRaKFyPXD08xArabjfYyTpKsGjU=
X-Received: by 2002:aca:5885:: with SMTP id m127mr5326845oib.110.1571349457061;
 Thu, 17 Oct 2019 14:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190830143432.21695-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Oct 2019 23:57:25 +0200
Message-ID: <CAJZ5v0gzMfXk7sx41mvMN3UEoctgb+yjs8GX9DR90ZVSUvK-mA@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI / platform: Unregister stale platform devices
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ferry Toth <fntoth@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 30, 2019 at 4:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When the commit 68bdb6773289
>
>   ("ACPI: add support for ACPI reconfiguration notifiers")
>
> introduced reconfiguration notifiers it misses the point that the ACPI table,
> which may be loaded and then unloaded via ConfigFS, can contain devices that are
> not enumerated by their parents.
>
> In such case the stale platform device is dangling in the system while the rest
> of the devices from the same table are already gone.
>
> Introduce acpi_platform_device_remove_notify() notifier that, in similar way to
> I²C or SPI buses, unregisters the platform devices on table removal event.
>
> Depends-on: 00500147cbd3 ("drivers: Introduce device lookup variants by ACPI_COMPANION device")
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_platform.c | 43 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/scan.c          |  1 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 00ec4f2bf015..dfcd6210828e 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -31,6 +31,44 @@ static const struct acpi_device_id forbidden_id_list[] = {
>         {"", 0},
>  };
>
> +static struct platform_device *acpi_platform_device_find_by_adev(struct acpi_device *adev)
> +{
> +       struct device *dev;
> +
> +       dev = bus_find_device_by_acpi_dev(&platform_bus_type, adev);
> +       return dev ? to_platform_device(dev) : NULL;
> +}
> +
> +static int acpi_platform_device_remove_notify(struct notifier_block *nb,
> +                                             unsigned long value, void *arg)
> +{
> +       struct acpi_device *adev = arg;
> +       struct platform_device *pdev;
> +
> +       switch (value) {
> +       case ACPI_RECONFIG_DEVICE_ADD:
> +               /* Nothing to do here */
> +               break;
> +       case ACPI_RECONFIG_DEVICE_REMOVE:
> +               if (!acpi_device_enumerated(adev))
> +                       break;
> +
> +               pdev = acpi_platform_device_find_by_adev(adev);
> +               if (!pdev)
> +                       break;
> +
> +               platform_device_unregister(pdev);
> +               put_device(&pdev->dev);
> +               break;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block acpi_platform_notifier = {
> +       .notifier_call = acpi_platform_device_remove_notify,
> +};
> +
>  static void acpi_platform_fill_resource(struct acpi_device *adev,
>         const struct resource *src, struct resource *dest)
>  {
> @@ -130,3 +168,8 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>         return pdev;
>  }
>  EXPORT_SYMBOL_GPL(acpi_create_platform_device);
> +
> +void __init acpi_platform_init(void)
> +{
> +       acpi_reconfig_notifier_register(&acpi_platform_notifier);
> +}
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index aad6be5c0af0..915650bf519f 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2174,6 +2174,7 @@ int __init acpi_scan_init(void)
>         acpi_pci_root_init();
>         acpi_pci_link_init();
>         acpi_processor_init();
> +       acpi_platform_init();
>         acpi_lpss_init();
>         acpi_apd_init();
>         acpi_cmos_rtc_init();
> --

Applying (with minor modifications) as 5.5 material, thanks!
