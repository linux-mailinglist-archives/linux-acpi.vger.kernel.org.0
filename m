Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C1D39DD07
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 14:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFGMz1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 08:55:27 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39629 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGMz0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 08:55:26 -0400
Received: by mail-oi1-f173.google.com with SMTP id m137so14021231oig.6
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 05:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UJbb0wgONzKu6GOCNY92/rs+FfpsCbB7IddM4Al1SgU=;
        b=UCwZMFZ4qcCsCglbBp0xk4I9jhNEeKNHZPRnoVjjDg3+vruAKEE0euK3dIhnotgJMg
         yjGp/e018+koKvtFlk+j8rk2BC/OBHdpjpOcKbdBbwpUoozscwTeFDSjlK65UfMwAK9y
         3d1qbSZ+tU18JTS+2lNnNwLzT5QBh+HGnykKa+C1gbBiENC3QQ7eYFwamU+9ll9pPJWZ
         Sbb02VwWGgAt2uQIegk4YEIQtKBnntVDgC652yecqZcty/QEQeN/8uPI5fEMyzzkyu63
         Nf6ubyN1cluKiOVm3wszcfJTv9C32DSIuoeM/plDOOX8rEDQT+om396y6zKFwyJflOPy
         vmWw==
X-Gm-Message-State: AOAM530jU5zHdpD9OE5o4VbBJlzzxtlXEtM7o5e/1/XRfWslFwlCzLL7
        DgKzwm8/7t77NV2YMjOh37QnVA6e28b/WWM0KLo=
X-Google-Smtp-Source: ABdhPJywaXK6YUCVA3bLWmnpzW2BajWBXA2vWUnK0Z5R0D7fqxT9XN/AkxnBQ4DBNS61nhJar33gtOu6WmCUTqZU71M=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3080478oim.157.1623070415240;
 Mon, 07 Jun 2021 05:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210603190753.5084-1-mario.limonciello@amd.com>
In-Reply-To: <20210603190753.5084-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:53:24 +0200
Message-ID: <CAJZ5v0hH_XuMucyYef=Cq-WNWt2aiVWmV5v-tm77AZ+R7HZFxg@mail.gmail.com>
Subject: Re: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to acpi
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rrangel@chromium.org, David Box <david.e.box@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 3, 2021 at 9:08 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.

Please spell ACPI in capitals in the subject.

Otherwise

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

or please let me know if you want me to take this patch (in which case
I'll need ACKs from the PCI and NVMe side).

> Link: Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: rrangel@chromium.org
> CC: david.e.box@linux.intel.com
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------
>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> Changes from v3->v4
>  * Rebase on nvme-5.14 (w/ patch 1/2 from v3 of series accepted)
>  * Adjust commit message per Christoph's suggestions
>  * Adjust documentation per Christoph's suggestions
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d260bc1f3e6e..1edb68d00b8e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>         return 1;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3.
> + * @dev: Device to check
> + *
> + * Returns %true if @dev should be put into D3 when the ->suspend method is
> + * called, else %false.  The name of this function is somewhat misleading
> + * as it has nothing to do with storage except for the name of the ACPI
> + * property.  On some platforms resume will not work if this hint is ignored.
> + *
> + */
> +bool acpi_storage_d3(struct device *dev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> +       u8 val;
> +
> +       if (!adev)
> +               return false;
> +       if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> +                       &val))
> +               return false;
> +       return val == 1;
> +}
> +EXPORT_SYMBOL_GPL(acpi_storage_d3);
> +
>  #endif /* CONFIG_PM */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aa7245a505f..8fbc4c87a0d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_ACPI
> -static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -       struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -       u8 val;
> -
> -       /*
> -        * Look for _DSD property specifying that the storage device on the port
> -        * must use D3 to support deep platform power savings during
> -        * suspend-to-idle.
> -        */
> -
> -       if (!adev)
> -               return false;
> -       if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> -                       &val))
> -               return false;
> -       return val == 1;
> -}
> -#else
> -static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -       return false;
> -}
> -#endif /* CONFIG_ACPI */
> -
>  static void nvme_async_probe(void *data, async_cookie_t cookie)
>  {
>         struct nvme_dev *dev = data;
> @@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>         quirks |= check_vendor_combination_bug(pdev);
>
> -       if (!noacpi && nvme_acpi_storage_d3(pdev)) {
> +       if (!noacpi && acpi_storage_d3(&pdev->dev)) {
>                 /*
>                  * Some systems use a bios work around to ask for D3 on
>                  * platforms that support kernel managed suspend.
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index c60745f657e9..dd0dafd21e33 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
>  int acpi_subsys_runtime_suspend(struct device *dev);
>  int acpi_subsys_runtime_resume(struct device *dev);
>  int acpi_dev_pm_attach(struct device *dev, bool power_on);
> +bool acpi_storage_d3(struct device *dev);
>  #else
>  static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
>  static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
> @@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  {
>         return 0;
>  }
> +static inline bool acpi_storage_d3(struct device *dev)
> +{
> +       return false;
> +}
>  #endif
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
> --
> 2.25.1
>
