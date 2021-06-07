Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F347839DEF5
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGOlm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 10:41:42 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43602 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGOlm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 10:41:42 -0400
Received: by mail-oi1-f172.google.com with SMTP id x196so17856133oif.10
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 07:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7a14rpcAIDQKHi45PdwrQP7pOJuz2pmW2YKVutjVaU=;
        b=eK2FDkPlcOiXjKGp0bMugEdHvdKo75RIuJE9Cv6NrmnTS7fm0LG2JJKIhMHLnAsa9m
         L9LmCRXJa6SYw84JqPuhiSEHsRfp5ubclPhOQ1fiwQVdJawH7ydpbtjfgKHPWRPevd6g
         MmFjG9HmAsB74j3WsO0Ta9qBWq0nUffbLkwzGIAJP5ybbd8DhEgRc4N+SAezokEisqFx
         yde1DQUsfRWqMAClpoxIeum9tkCEYBoICTKYKWqDJPy6iUN1HjrLxIahfqnuGigylugw
         2XpquXKJL+w8kOMTzaJHDgJfMWC1Nn6/+o2r8TstmyPEitChkWbmgSOADVZIVpPifpir
         CAcA==
X-Gm-Message-State: AOAM531b0yZMVS6wAmbF/l4ZX5Zg5OmGZ+oi96KEzK6KXcrBzrmEVzN7
        EiC6sG1qZZykzBJ1iEkLGF7LaG0i802AJ7OdcT8=
X-Google-Smtp-Source: ABdhPJy0WC7qMbNYOvNH9vpw+qGf7mgy9n6UTfUfHj8GaZfxHpxb1wUJ0vUU65w2Yx6S2TxGOXLSYNEnLJteCUuYUbA=
X-Received: by 2002:aca:b406:: with SMTP id d6mr11564478oif.71.1623076777341;
 Mon, 07 Jun 2021 07:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210604165403.2317-1-mario.limonciello@amd.com> <20210604165403.2317-2-mario.limonciello@amd.com>
In-Reply-To: <20210604165403.2317-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 16:39:26 +0200
Message-ID: <CAJZ5v0g5KCkE4eRSjKZgX14Nm3FNKQmfzsCYzfigD-M-uT5QJA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] acpi: PM: Add quirks for AMD Renoir/Lucienne CPUs
 to force the D3 hint
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
        Prike Liang <prike.liang@amd.com>,
        Julian Sikorski <belegdol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 4, 2021 at 6:54 PM Mario Limonciello
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
>  drivers/acpi/device_pm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> Changes from v4->v5:
>  * Add this patch back in as it's been made apparent that the
>    system needs to be hardcoded for these.
>    Changes:
>    - Drop Cezanne - it's now covered by StorageD3Enable
>    - Rebase ontop of acpi_storage_d3 outside of NVME
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index 1edb68d00b8e..8fd2a15bf478 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -20,6 +20,10 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/suspend.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/cpu_device_id.h>
> +#endif

This is a generic file, not x86 (or any other arch-specific)
#ifdeffery in it, please.

There is the x86/ subdir under drivers/acpi/ for x86-specific stuff.

> +
>  #include "internal.h"
>
>  /**
> @@ -1341,6 +1345,15 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
>
> +
> +#ifdef CONFIG_X86
> +static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
> +       {}
> +};
> +#endif
> +
>  /**
>   * acpi_storage_d3 - Check if a storage device should use D3.
>   * @dev: Device to check
> @@ -1356,6 +1369,12 @@ bool acpi_storage_d3(struct device *dev)
>         struct acpi_device *adev = ACPI_COMPANION(dev);
>         u8 val;
>
> +#ifdef CONFIG_X86
> +       /* Devices requiring D3, but from before StorageD3Enable was "standardized" */
> +       if (x86_match_cpu(storage_d3_cpu_ids))
> +               return true;
> +#endif
> +
>         if (!adev)
>                 return false;
>         if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
> --
> 2.25.1
>
