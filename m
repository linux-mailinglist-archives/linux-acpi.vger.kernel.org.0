Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7CE3151C7
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 15:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhBIOgs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Feb 2021 09:36:48 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36454 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhBIOgI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2021 09:36:08 -0500
Received: by mail-ot1-f44.google.com with SMTP id 100so10941782otg.3;
        Tue, 09 Feb 2021 06:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZa1gL5UO1QVOwd/KPeOZtTkGeuyxn69fTmhbjihUsk=;
        b=ikgYG46rDBP07t7hmhV+CogzkVikOmeupgztfCNUGxXbkdELTaA9a1Gd2E5HRL6KHX
         QxyGvh1oOdEpBHMy2X+3HIOezphMsVSHwPLUDxUBUefqmSjjqI9WOXJv7mmAXZu6i+eM
         3m1BIRENkLN2zfKd1vcQi75IXj79ghhbw5NQD9Uud1RX1vxm+Oi29rsw6EJDC1GnLaAo
         IsSlD8TgAkTWRiUUIAgul1ZVVSf9ZEWm7GVb9pcpbIQkwpXcWI1oHHFlhOGcLCBZYKir
         8K3u/F2M5S5GT8z8mbFNttMTf/yWm86vMReuGFoM9N9wGvJjPbFYbnweYmV7xdfAFaqO
         4X4w==
X-Gm-Message-State: AOAM532aDHCC9S4LG+EjCPcaZ26uLCdrbTR7q9T3plIQ8B1F8bBWWT3f
        FHorO8L1eqUm9c+Z19EAJcvU2d84iKtnWSjkyn4=
X-Google-Smtp-Source: ABdhPJw7RYC30OMzcFI0ZQqtGXBLiUxRNCQYDuo2ImGnO4Ce/C1BOgkndTGNVsYWfa83+pNi+h7/aZbkYDEscbISA7s=
X-Received: by 2002:a9d:a2d:: with SMTP id 42mr14909782otg.321.1612881327590;
 Tue, 09 Feb 2021 06:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20210209031744.26474-1-weidongcui@gmail.com>
In-Reply-To: <20210209031744.26474-1-weidongcui@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Feb 2021 15:35:14 +0100
Message-ID: <CAJZ5v0ifzqR90BJY3u6NGvMLuVn8YApLZH=oA5COcmjs_GKFqQ@mail.gmail.com>
Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
 only when ACPI_PCI_CONFIGURED is defined
To:     Weidong Cui <weidongcui@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Xinyang Ge <aegiryy@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 9, 2021 at 4:22 AM Weidong Cui <weidongcui@gmail.com> wrote:
>
> Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> Signed-off-by: Xinyang Ge <aegiryy@gmail.com>

ACPICA material, left to Erik & Bob, thanks!

> ---
>  drivers/acpi/acpica/evhandler.c | 2 ++
>  include/acpi/acconfig.h         | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
> index 5884eba04..4c25ad433 100644
> --- a/drivers/acpi/acpica/evhandler.c
> +++ b/drivers/acpi/acpica/evhandler.c
> @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
>  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
>         ACPI_ADR_SPACE_SYSTEM_MEMORY,
>         ACPI_ADR_SPACE_SYSTEM_IO,
> +#ifdef ACPI_PCI_CONFIGURED
>         ACPI_ADR_SPACE_PCI_CONFIG,
> +#endif
>         ACPI_ADR_SPACE_DATA_TABLE
>  };
>
> diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> index a225eff49..790999028 100644
> --- a/include/acpi/acconfig.h
> +++ b/include/acpi/acconfig.h
> @@ -162,7 +162,11 @@
>  /* Maximum space_ids for Operation Regions */
>
>  #define ACPI_MAX_ADDRESS_SPACE          255
> +#ifdef ACPI_PCI_CONFIGURED
>  #define ACPI_NUM_DEFAULT_SPACES         4
> +#else
> +#define ACPI_NUM_DEFAULT_SPACES         3
> +#endif
>
>  /* Array sizes.  Used for range checking also */
>
> --
> 2.24.3 (Apple Git-128)
>
