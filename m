Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0B29094D
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 18:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407671AbgJPQHE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 12:07:04 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35775 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405432AbgJPQHE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 12:07:04 -0400
Received: by mail-oi1-f196.google.com with SMTP id w141so2997569oia.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 09:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1qy5oPyoVq7h0x2Z3uvVJR+ossU1sjrH93maJuefGI=;
        b=ZRpdpyG6Ndxv+wPg6GWbtXx4HCdEHmlJE+AtzCtaEpCAW3ZNjyf66oIaSNsAhszu/8
         thhyetqnCh1VJzb0aXc9tTOocm5ZPryAcIk/56fhQbSbklBpmGtdYAQMCsLP0N4CEsPp
         Icrkn2XpYE9U+bvzrmDYW+sGAacKWRhE7CYVfmFlZaImaQfi5WJSRxPzhvq6EddLMyaV
         fPMFWuph8pmK7oEIYpsJHFwmL2he5EAwv5xQQY7jMWjIuXsYk+3TM4tWj4jmpDfY/uN9
         RN4+GweBLq3PhoRtrxtwFzd/OUzzX6MAlbJZC73eqHR1+i2D8K1gVneEHaQLeik6Lnz9
         wezw==
X-Gm-Message-State: AOAM531XvdAi+AEBItshjeRMXiIa74mSoDbecv1noQHE3siSHvZ7QtCH
        DGl9jLlkOlTfY8SWmawij7kClGDtMi0EXv6DO4A=
X-Google-Smtp-Source: ABdhPJy/VSmMLODjLJmOj/YBFSE/mlslVX1E1Yq1BzssOP7/yorZ94DE0pmGMNSVSX8CoKnHW0XKWEHrtJUBQMgEQcE=
X-Received: by 2002:aca:fd52:: with SMTP id b79mr2978752oii.69.1602864423516;
 Fri, 16 Oct 2020 09:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201013073557.4580-1-rui.zhang@intel.com>
In-Reply-To: <20201013073557.4580-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 18:06:52 +0200
Message-ID: <CAJZ5v0i1hn5BiAHTq5TkaekgEkmjzP=7_M7srn-zPR-xsfhT2A@mail.gmail.com>
Subject: Re: [PATCH V2] acpi: reboot: fix racing after writing to ACPI RESET_REG
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, sukumar.ghorai@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 13, 2020 at 9:36 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> According to the ACPI spec, "The system must reset immediately following
> the write to the ACPI RESET_REG register.", but there are cases that the
> system does not follow this and results in racing with the subsequetial
> reboot mechanism, which brings unexpected behavior.
>
> Fix this by adding a 15ms delay after writing to the ACPI RESET_REG.
>
> Reported-by: Ghorai, Sukumar <sukumar.ghorai@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/reboot.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/reboot.c b/drivers/acpi/reboot.c
> index ca707f5b521d..0e357cb5612f 100644
> --- a/drivers/acpi/reboot.c
> +++ b/drivers/acpi/reboot.c
> @@ -3,6 +3,7 @@
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <acpi/reboot.h>
> +#include <linux/delay.h>
>
>  #ifdef CONFIG_PCI
>  static void acpi_pci_reboot(struct acpi_generic_address *rr, u8 reset_value)
> @@ -66,4 +67,13 @@ void acpi_reboot(void)
>                 acpi_reset();
>                 break;
>         }
> +
> +       /*
> +        * Some platforms do not shutdown immediately after writing to the
> +        * ACPI reset register, and this results in racing with the
> +        * subsequetial reboot mechanism.
> +        * Delay for 15ms has been proved to be long enough for the system
> +        * to reboot, for these platforms.
> +        */
> +       mdelay(15);
>  }
> --

Applied as 5.10-rc material with some edits in the comment above and subject.

Thanks!
