Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F047039F4EE
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 13:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhFHLaD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 07:30:03 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39614 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhFHLaC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 07:30:02 -0400
Received: by mail-ot1-f44.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so18880120otu.6
        for <linux-acpi@vger.kernel.org>; Tue, 08 Jun 2021 04:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDQ2BSSl67ck1vvYJoFh/3g0MHC3Vf+JuWnQHiL10v0=;
        b=rYSrI1kJ6bXsSFU4ODIxt/qT85ksOSsbjGSBidFaxkqRovD1UTe3C6Y3o+8iBHaO1I
         X2FaJ4UK9dH5d6YI9gIYjbMYIRjoKSAinnCMxHAmynM+CTtLtKywl23ldV+f/yAm94Ra
         x8CYNz0TPEEVmrTL/IZu5jMO2dsroLKZXubu2gfWLQSuDr+zkETKk+b9sesCPl1AQdol
         vif0/8P9ODBBp5Lax+jvohsqy8R/PIivJ+JIh/giZhR74KEgvM7wN2SJoGve2aQg/kTr
         buv2f7N5ceqXphlabPwNbJutIWqOblct05Wbr2ZtClmRrkgKbGES20mmmn1YXbBPLuwm
         4Bpw==
X-Gm-Message-State: AOAM531FI9DSZYurKltLoLGz25EJhSDA7kyMVmGTqfoCdghcqfGPqh/i
        a0N+mOgDOm9fGA1IH9v3XKyagC2RJG4UapelKHw=
X-Google-Smtp-Source: ABdhPJyJL1GNbZ9W6xaADH/uQ7Km9hFPsTEVOT9RuVOEnq6m8rIEqK2Sfeme2svgp3BjgLELVBJa2VxBtHgknPPzIpI=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr14527986otq.321.1623151689185;
 Tue, 08 Jun 2021 04:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210607173156.5548-1-mario.limonciello@amd.com> <20210607173156.5548-2-mario.limonciello@amd.com>
In-Reply-To: <20210607173156.5548-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Jun 2021 13:27:58 +0200
Message-ID: <CAJZ5v0jFop-M6dT18+eDDgUepFY=CxjHWjfYf6nxrk5B64=vwQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
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

On Mon, Jun 7, 2021 at 7:32 PM Mario Limonciello
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
> ---
>  drivers/acpi/device_pm.c |  3 +++
>  drivers/acpi/x86/utils.c | 27 +++++++++++++++++++++++++++
>  include/acpi/acpi_bus.h  |  5 +++++
>  3 files changed, 35 insertions(+)
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
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 1edb68d00b8e..985c17384192 100644
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
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index bdc1ba00aee9..2b8d5b3c876f 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -135,3 +135,30 @@ bool acpi_device_always_present(struct acpi_device *adev)
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
> +       if (x86_match_cpu(storage_d3_cpu_ids))
> +               return true;
> +       return false;

Well, what about doing

  return x86_match_cpu(storage_d3_cpu_ids);

instead?

> +}
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 3a82faac5767..9b0ddbae5617 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -607,11 +607,16 @@ int acpi_disable_wakeup_device_power(struct acpi_device *dev);
>
>  #ifdef CONFIG_X86
>  bool acpi_device_always_present(struct acpi_device *adev);
> +bool force_storage_d3(void);

This doesn't need to go into acpi_bus.h, because it will only be used
in device_pm.c.

You may as well put it into drivers/acpi/internal.h.

>  #else
>  static inline bool acpi_device_always_present(struct acpi_device *adev)
>  {
>         return false;
>  }
> +static inline bool force_storage_d3(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #ifdef CONFIG_PM
> --
