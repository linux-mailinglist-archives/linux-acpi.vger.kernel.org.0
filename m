Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3863A150F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 15:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhFINEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 09:04:20 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38814 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbhFINER (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 09:04:17 -0400
Received: by mail-ot1-f47.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10214294otk.5
        for <linux-acpi@vger.kernel.org>; Wed, 09 Jun 2021 06:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOMB9VcGIsLxTCSfGIXF8Bd/z/LUoxmBOfes4pXl5ik=;
        b=WTfIxT9AzxocLb16Jrs+4mphtgdWHICpoS9Cd1zW5IyW+vYRiImhMqRroBsQNvy4nz
         CObG4FiyWFVzQCHej1FMsaJasG9dQeDV/SVTlw+75IlaLBhJcJVWI9oWI2ZL6zjbbz+K
         lBtkGzAYhquW+LkHEzEx1dTBqxTH2WhLHSBUFa3s4S9bue44PT8ipbD7BLYCYEQbv+TA
         axsMZizv5qP/J4ovuzpNgXDYEXnd8nl3fuhWQ1TG7geoJmIyhjkE0ZoWeKTYwvZTPXiR
         V63hpzlivhMbYIZ85dEl8dSbNADJE8G0DAvq2QYZs9Z3SwBHI93Y/VLuEygcHP00oEg6
         vwgg==
X-Gm-Message-State: AOAM532Zw8P7EbKcJ/fbqpUSZMfnJkR8/JwDFBDXYXPja8DpC3ZxCoWQ
        0rLdzXiHeOlguw2pGPcowMLc13xHfl00ZKmWvxIfMncdcz8=
X-Google-Smtp-Source: ABdhPJzYF4hwT3T/mkrdk5cXrMRLhDinMJMWwR8kLjRKgxS+dV2BrU48zWwMSl6ELMOu1+KCJU3Bb2xmfkzjqbRbv+A=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr22358365otg.260.1623243730796;
 Wed, 09 Jun 2021 06:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210608154255.8693-1-mario.limonciello@amd.com> <20210608154255.8693-2-mario.limonciello@amd.com>
In-Reply-To: <20210608154255.8693-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 15:01:59 +0200
Message-ID: <CAJZ5v0hOgQCyEaRWEM=wELSYKJyuvCi8r4EnaAFQv+5EQRcOJg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
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
        Prike Liang <prike.liang@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 5:43 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> AMD systems from Renoir and Lucienne require that the NVME controller
> is put into D3 over a Modern Standby / suspend-to-idle
> cycle.  This is "typically" accomplished using the `StorageD3Enable`
> property in the _DSD, but this property was introduced after many
> of these systems launched and most OEM systems don't have it in
> their BIOS.
>
> On AMD Renoir without these drives going into D3 over suspend-to-idle
> the resume will fail with the NVME controller being reset and a trace
> like this in the kernel logs:
> ```
> [   83.556118] nvme nvme0: I/O 161 QID 2 timeout, aborting
> [   83.556178] nvme nvme0: I/O 162 QID 2 timeout, aborting
> [   83.556187] nvme nvme0: I/O 163 QID 2 timeout, aborting
> [   83.556196] nvme nvme0: I/O 164 QID 2 timeout, aborting
> [   95.332114] nvme nvme0: I/O 25 QID 0 timeout, reset controller
> [   95.332843] nvme nvme0: Abort status: 0x371
> [   95.332852] nvme nvme0: Abort status: 0x371
> [   95.332856] nvme nvme0: Abort status: 0x371
> [   95.332859] nvme nvme0: Abort status: 0x371
> [   95.332909] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -16
> [   95.332936] nvme 0000:03:00.0: PM: failed to resume async: error -16
> ```
>
> The Microsoft documentation for StorageD3Enable mentioned that Windows has
> a hardcoded allowlist for D3 support, which was used for these platforms.
> Introduce quirks to hardcode them for Linux as well.
>
> As this property is now "standardized", OEM systems using AMD Cezanne and
> newer APU's have adopted this property, and quirks like this should not be
> necessary.
>
> CC: Julian Sikorski <belegdol@gmail.com>
> CC: Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Prike Liang <prike.liang@amd.com>
> Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/device_pm.c |  3 +++
>  drivers/acpi/internal.h  |  9 +++++++++
>  drivers/acpi/x86/utils.c | 25 +++++++++++++++++++++++++
>  3 files changed, 37 insertions(+)
>
> Changes from v4->v5:
>  * Add this patch back in as it's been made apparent that the
>    system needs to be hardcoded for these.
>    Changes:
>    - Drop Cezanne - it's now covered by StorageD3Enable
>    - Rebase ontop of acpi_storage_d3 outside of NVME
> Changes from v5->v6:
>  * Move the quirk check into drivers/acpi/x86/ as suggested by
>    Rafael.
> Changes from v6->v7:
>  * Move header location
>  * Optimization of force function
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index c45f2d76b67e..31e0025a913e 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1356,6 +1356,9 @@ bool acpi_storage_d3(struct device *dev)
>         struct acpi_device *adev = ACPI_COMPANION(dev);
>         u8 val;
>
> +       if (force_storage_d3())
> +               return true;
> +
>         if (!adev)
>                 return false;
>         if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index f973bbe90e5e..e29ec463bb07 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -236,6 +236,15 @@ static inline int suspend_nvs_save(void) { return 0; }
>  static inline void suspend_nvs_restore(void) {}
>  #endif
>
> +#ifdef CONFIG_X86
> +bool force_storage_d3(void);
> +#else
> +static inline bool force_storage_d3(void)
> +{
> +       return false;
> +}
> +#endif
> +
>  /*--------------------------------------------------------------------------
>                                 Device properties
>    -------------------------------------------------------------------------- */
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index bdc1ba00aee9..5298bb4d81fe 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -135,3 +135,28 @@ bool acpi_device_always_present(struct acpi_device *adev)
>
>         return ret;
>  }
> +
> +/*
> + * AMD systems from Renoir and Lucienne *require* that the NVME controller
> + * is put into D3 over a Modern Standby / suspend-to-idle cycle.
> + *
> + * This is "typically" accomplished using the `StorageD3Enable`
> + * property in the _DSD that is checked via the `acpi_storage_d3` function
> + * but this property was introduced after many of these systems launched
> + * and most OEM systems don't have it in their BIOS.
> + *
> + * The Microsoft documentation for StorageD3Enable mentioned that Windows has
> + * a hardcoded allowlist for D3 support, which was used for these platforms.
> + *
> + * This allows quirking on Linux in a similar fashion.
> + */
> +const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> +       {}
> +};
> +
> +bool force_storage_d3(void)
> +{
> +       return x86_match_cpu(storage_d3_cpu_ids);
> +}
> --
> 2.25.1
>
