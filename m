Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720A73A1507
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhFIND1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 09:03:27 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:40764 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhFINDZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 09:03:25 -0400
Received: by mail-ot1-f51.google.com with SMTP id l13-20020a9d708d0000b02903fca0eacd15so892756otj.7
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 06:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPch2CZp0YDxdhlusMBnDUEUBjoN7mID6s1Wz3gtiAw=;
        b=GLULpUeU1jYFL7R45qSv+R2cVAf1xzv5YoRcopHnAHiF8tGBhiVwZiUC/faMjkL31G
         mwqDVzIfoBEIimDFkv2Jj7IgjL6hM3EF4vq+apPWU2iy0/MNpCFIUPHLp0jhmW0p0u4z
         g7zDKPlrhwTyWhjZyxa9ZF/Wl42uNopFFyI3sutsjDmTnC2tBT4NTONqSrIRY2y1/Qd4
         y8OhIiVm5+gY2vZmMNbeljOXmuQ6oamENV8TFNteBIT/QGJkGdIKyHctqZFYHoGu8wz9
         jiG/CXLYi9oR5YgojzwO70m6w3W2pXFC+O97bpDlVjW4g5Xs0zMRusEaMGSddNH/q9Va
         f0GQ==
X-Gm-Message-State: AOAM532G8LErZ2ne2xxAoeXwDB/DmsyQBl4fX4oLXBH06+vZ6ZgtlB8n
        lCD3wZfMydT/E9Jwae3BhD+3kF5z8+e9owQd0yc=
X-Google-Smtp-Source: ABdhPJzXxpffk7bpfRbobEHMl8RH6HQtZvmiuIU0PKxt/WpfUAZB9KM7fUhP7CpCRy3Uvwh9FggDWVfBX2ur7hIXFAQ=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr22353417otg.260.1623243672804;
 Wed, 09 Jun 2021 06:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210608154255.8693-1-mario.limonciello@amd.com>
In-Reply-To: <20210608154255.8693-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 15:01:01 +0200
Message-ID: <CAJZ5v0ik+kEn9eZ_g4=i=qW_08p2-PekT2tW4AivwUNc-NmHiA@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rrangel@chromium.org, David Box <david.e.box@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal-bakulchandra.Shah@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 5:43 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Suggested-by: Keith Busch <kbusch@kernel.org>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/device_pm.c | 25 +++++++++++++++++++++++++
>  drivers/nvme/host/pci.c  | 28 +---------------------------

This appears to be based on an nvme commit that is not there in the
mainline, so I cannot apply it as is.

If you change the subject to something like

"ACPI: Check StorageD3Enable _DSD property in ACPI code"

and modify the acpi_storage_d3() kerneldoc as per the remark below,
please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it and route it via nvme.

>  include/linux/acpi.h     |  5 +++++
>  3 files changed, 31 insertions(+), 27 deletions(-)
>
> Changes from v4->v5:
>  * Correct extra "Link:" word in commit message
> Changes from v5->v6:
>  * Add in commit message tags from Raul, Rafael and Keith
> Changes from v6->v7:
>  * Update kerneldoc comments per suggestsions.
>  * Drop all Acked/Reviewed tags
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index d260bc1f3e6e..c45f2d76b67e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1340,4 +1340,29 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>         return 1;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
> +
> +/**
> + * acpi_storage_d3 - Check if a storage device should use D3 in the suspend path

Please change this to something like "Check if D3 should be used in
the suspend path" as this generally isn't about storage only.

> + * @dev: Device to check
> + *
> + * Return %true if the platform firmware wants @dev to be programmed
> + * into D3hot or D3cold (if supported) in the suspend path, or %false
> + * when there is no specific preference. On some platforms, if this
> + * hint is ignored, @dev may remain unresponsive after suspending the
> + * platform as a whole.
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
