Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E9339DD41
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFGNEq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 09:04:46 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34527 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGNEq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 09:04:46 -0400
Received: by mail-ot1-f53.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so13520465ott.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 06:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2LkOFh0NYFTWf48EskxVUzCNHUSV+WWTwemPr5U1hWo=;
        b=ijITa7Tg7v8hkKDBG3Fn/mZQIzuY7FHLKqynZOcIXaXHf7EqmuJTxb94TjnDhWotpI
         w+MG8dyq1jiGOAftjDg4qX9Wvyg+A+aqoiQI+1ovNB8P41RA6g2Z0imdB+zT/BXe0AJ0
         qSO4R9I2fpbfJnHuHhcQi0xZUPsOWA6Qs5NmIupsrjdhM7jV92zLat7dcAYBPuWsSksG
         ArgSOo4uXz3Q54Ic3A90z3zJ7ccuD0bt2fIda0Sx2v0DJ05KrKMCQPh7g7A4UHJRonIl
         3Qxdtfs14gJyQbSN7mJsw35GlAIz32pI0TwXyhaLvcLGqQ0kxAsLld1IXmFl8T4rbuKC
         1SBg==
X-Gm-Message-State: AOAM533vkK3F8z+VeNad/RIEvYqHw1kKsNNVRxeF3zZAWwiPQ7JMCiOs
        Un9XvsHmEOQumk7ywI2atXbVt4A2evU8EKH7xDY=
X-Google-Smtp-Source: ABdhPJyQljXNGt+jk9j+PUO2T254Mq8d3l4kl63LC1MofS/VYQSpOsdOC0nVfORdcHh4AEH/ggAs/L+LzZtiUmuRy6w=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr13508602otg.260.1623070974820;
 Mon, 07 Jun 2021 06:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210603023414.2389-1-rui.zhang@intel.com>
In-Reply-To: <20210603023414.2389-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 15:02:43 +0200
Message-ID: <CAJZ5v0g=S8su+sEqWwQqViyB9ppngWJDn6f=-ONH6bgz6sOYQA@mail.gmail.com>
Subject: Re: [PATCH] Revert "ACPI: sleep: Put the FACS table after using it"
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 3, 2021 at 4:24 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Commit 95722237cb2a ("ACPI: sleep: Put the FACS table after using it")
> puts the FACS table during initialization.
> But the hardware signature bits in the FACS table need to be accessed,
> after every hibernation, to compare with the original hardware signature.
>
> So there is no reason to release the FACS table mapping after
> initialization.
>
> This reverts commit 95722237cb2ae4f7b73471058cdb19e8f4057c93.
>
> An alternative solution is to use acpi_gbl_FACS variable instead, which
> is mapped by the ACPICA core and never released.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=212277
> Reported-by: Stephan Hohe <sth.dev@tejp.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/sleep.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index df386571da98..3bb2adef8490 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -1009,10 +1009,8 @@ static void acpi_sleep_hibernate_setup(void)
>                 return;
>
>         acpi_get_table(ACPI_SIG_FACS, 1, (struct acpi_table_header **)&facs);
> -       if (facs) {
> +       if (facs)
>                 s4_hardware_signature = facs->hardware_signature;
> -               acpi_put_table((struct acpi_table_header *)facs);
> -       }
>  }
>  #else /* !CONFIG_HIBERNATION */
>  static inline void acpi_sleep_hibernate_setup(void) {}
> --

Applied as 5.13-rc material (with CC-stable), thanks!
