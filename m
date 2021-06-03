Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47BE39AE01
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 00:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFCWav (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Jun 2021 18:30:51 -0400
Received: from mail-il1-f182.google.com ([209.85.166.182]:42856 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFCWav (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Jun 2021 18:30:51 -0400
Received: by mail-il1-f182.google.com with SMTP id a8so5906802ilv.9
        for <linux-acpi@vger.kernel.org>; Thu, 03 Jun 2021 15:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYQbcvibiQg/DnUam+wLaSOQ2UV3ZafOtj4rPommSME=;
        b=eONCVyJG8reQysQ4HqQPn9JbnCwm9R7Mi3NhkPGLL6ItUR1Ov5MqfX4dG4+ncwb8Ge
         rzh7THXy3i1zBca3kiJxC2exppTDkk5034+bLFlDBTTqi4Dr/kCD/WQ9/GnUKKipi9af
         9nqMvBaMbcjx1O+Q2okxWyQdYxHvmNj5NSfGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYQbcvibiQg/DnUam+wLaSOQ2UV3ZafOtj4rPommSME=;
        b=WSILIiTf8ctoPtPBszXPEoTWAFHXRtXwiVoX8tPbGGKoGhpDgHG/MRxv2YsRyr1/3A
         N+3zTnIRsa3FOrRk5mht+LKgkNatSG/pCwJPDanX26YU+F53bgUcB2Gc7emxgwnCXIUI
         2D4HvhhOQvHp6lZ/LrSZtcTNnJuuIRaU12K1faHNonMEdGMuH+qRkA2HZgFQeMYi3jFw
         sxVvkCEO0BI9qqFCDWprgfk0uvZuQ39LzjByYxJohu3O6DxZsxNaI7UaZckmoHK3RL74
         YCzMapKhtr5Av6NX0jW/65Qnhf3E957MZz05d2CCTAOm2bJbE+ifn5qNNqKFmUa7y2vL
         +3OA==
X-Gm-Message-State: AOAM533hrbt9/qcDpBizVIXX8MhM207ZYVdDqWiDH8DCYIpG/Q0oDTcL
        DJcJBjWDa/58CimrIkfijKoxiA==
X-Google-Smtp-Source: ABdhPJy2cCbn6S+OVOgxep7zZ4X+W9504GaOSMvrUiXR2300RkJaKnIP7U+IUGkRNuwwA7/yX/MVCA==
X-Received: by 2002:a92:2a0a:: with SMTP id r10mr1317896ile.274.1622759271677;
        Thu, 03 Jun 2021 15:27:51 -0700 (PDT)
Received: from google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id z14sm2492618ilb.48.2021.06.03.15.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 15:27:51 -0700 (PDT)
Date:   Thu, 3 Jun 2021 16:27:49 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-acpi@vger.kernel.org, david.e.box@linux.intel.com,
        Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com,
        prike.liang@amd.com
Subject: Re: [PATCH v4] acpi: Move check for _DSD StorageD3Enable property to
 acpi
Message-ID: <YLlXZcp6ne7hcXNM@google.com>
References: <20210603190753.5084-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603190753.5084-1-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 03, 2021 at 02:07:53PM -0500, Mario Limonciello wrote:
> Although first implemented for NVME, this check may be usable by
> other drivers as well. Microsoft's specification explicitly mentions
> that is may be usable by SATA and AHCI devices.  Google also indicates
> that they have used this with SDHCI in a downstream kernel tree that
> a user can plug a storage device into.
> 
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
>  	return 1;
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
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	u8 val;
> +
> +	if (!adev)
> +		return false;
> +	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> +			&val))
> +		return false;
> +	return val == 1;
> +}
> +EXPORT_SYMBOL_GPL(acpi_storage_d3);
> +
>  #endif /* CONFIG_PM */
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3aa7245a505f..8fbc4c87a0d8 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2828,32 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_ACPI
> -static bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -	u8 val;
> -
> -	/*
> -	 * Look for _DSD property specifying that the storage device on the port
> -	 * must use D3 to support deep platform power savings during
> -	 * suspend-to-idle.
> -	 */
> -
> -	if (!adev)
> -		return false;
> -	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> -			&val))
> -		return false;
> -	return val == 1;
> -}
> -#else
> -static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_ACPI */
> -
>  static void nvme_async_probe(void *data, async_cookie_t cookie)
>  {
>  	struct nvme_dev *dev = data;
> @@ -2903,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	quirks |= check_vendor_combination_bug(pdev);
>  
> -	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
> +	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
>  		/*
>  		 * Some systems use a bios work around to ask for D3 on
>  		 * platforms that support kernel managed suspend.
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
>  	return 0;
>  }
> +static inline bool acpi_storage_d3(struct device *dev)
> +{
> +	return false;
> +}
>  #endif
>  
>  #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)

Tested on an AMD Chromebook and it still works.

Reviewed-by: Raul E Rangel <rrangel@chromium.org>
