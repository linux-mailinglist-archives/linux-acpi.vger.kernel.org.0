Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0538F3AF028
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jun 2021 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhFUQqw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Jun 2021 12:46:52 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44925 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbhFUQox (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jun 2021 12:44:53 -0400
Received: by mail-oi1-f170.google.com with SMTP id s17so11776953oij.11
        for <linux-acpi@vger.kernel.org>; Mon, 21 Jun 2021 09:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2GYRtFk0bbtFpFQw719irCqNl+rLMegoFBICY0Yko7Q=;
        b=rTbKpiwcTo7hRaq9P1TRg1XKE3yCfLNQdZBwBfzX2wTDzy/N8Yw6rvzzDxFQSGV/Hb
         gp5dSnij+t7cGSKhqAWIWJcp9W2yHq90Esn4v7gBZEf+rIAZl6ikNleK9sp3Ic9E/QEH
         L/0HEw7Mk8JDjLUTe2iK3BG4RHPO/HcEnZqstY85CA0kSdnoc9HbZsqW2WorFkztA94Z
         6XnjTsgFhoPIhHnUlRcBLKeCuArz5jeqAIEwWAosEMuJU8Cqd48DkBaN1OLHjM3R5upB
         +kj2qUN0Rgg6QQTz4eXnYSJUenGDqOtxB25Q/tCvc6RSbK22hED7NtgxOhQyDCzEyJsH
         fQ+A==
X-Gm-Message-State: AOAM531579X4GZ4LUe+S+gucaoFrG8J4nuCCN0jHqftfXyW4YxJIQBwz
        EO+rveFvoaONGitWfmxKs9ufGbYB3ObU6Jitmek=
X-Google-Smtp-Source: ABdhPJzKCCYKIzK6JowSoVtNbgOWpGFNLJRtLVvJ309eqEPF6En6JEz5EPTbhLVwRnkbIPHoNDkr8BBR+BCOrS/MT/E=
X-Received: by 2002:aca:f0d5:: with SMTP id o204mr15747788oih.71.1624293757027;
 Mon, 21 Jun 2021 09:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210621012806.30300-1-rui.zhang@intel.com>
In-Reply-To: <20210621012806.30300-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Jun 2021 18:42:25 +0200
Message-ID: <CAJZ5v0iCMqicqh5ikf+sp0BZJVOy0U6buPx5SeJ7v1ezqVj0Qg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: trust DSDT GPE for certain HP laptop
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, gleo881003@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 21, 2021 at 3:18 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On HP Pavilion Gaming Laptop 15-cx0xxx, the ECDT EC and DSDT EC share
> the same port addresses but different GPEs. And the DSDT GPE is the
> right one to use.
>
> The current code duplicates DSDT EC with ECDT EC if the port addresses
> are the same, and uses ECDT GPE as a result, which breaks this machine.
>
> Introduce a new quirk for the HP laptop to trust the DSDT GPE,
> and avoid duplicating even if the port addresses are the same.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=209989
> Reported-and-tested-by: Shao Fu, Chen <leo881003@gmail.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/ec.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 9555c65f2f94..8d8abd0c6cfb 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -183,6 +183,7 @@ static struct workqueue_struct *ec_query_wq;
>
>  static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port address correction */
>  static int EC_FLAGS_IGNORE_DSDT_GPE; /* Needs ECDT GPE as correction setting */
> +static int EC_FLAGS_TRUST_DSDT_GPE; /* Needs DSDT GPE as correction setting */
>  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
>  static int EC_FLAGS_FORCE_EC_REG; /* Needs EC _REG evaluated explicitly */
>
> @@ -1601,7 +1602,8 @@ static int acpi_ec_add(struct acpi_device *device)
>                 }
>
>                 if (boot_ec && ec->command_addr == boot_ec->command_addr &&
> -                   ec->data_addr == boot_ec->data_addr) {
> +                   ec->data_addr == boot_ec->data_addr &&
> +                   !EC_FLAGS_TRUST_DSDT_GPE) {
>                         /*
>                          * Trust PNP0C09 namespace location rather than
>                          * ECDT ID. But trust ECDT GPE rather than _GPE
> @@ -1836,6 +1838,18 @@ static int ec_honor_ecdt_gpe(const struct dmi_system_id *id)
>         return 0;
>  }
>
> +/*
> + * Some ECDTs contain wrong GPE setting, but they share the same port addresses
> + * with DSDT EC, don't duplicate the DSDT EC with ECDT EC in this case.
> + * https://bugzilla.kernel.org/show_bug.cgi?id=209989
> + */
> +static int ec_honor_dsdt_gpe(const struct dmi_system_id *id)
> +{
> +       pr_debug("Detected system needing DSDT GPE setting.\n");
> +       EC_FLAGS_TRUST_DSDT_GPE = 1;
> +       return 0;
> +}
> +
>  /*
>   * Some buggy BIOS does not have EC OperationRegion, this results in the
>   * EC._REG fails to be evaluated when installing the EC address space handler.
> @@ -1876,6 +1890,11 @@ static const struct dmi_system_id ec_dmi_table[] __initconst = {
>         DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>         DMI_MATCH(DMI_PRODUCT_NAME, "X580VD"),}, NULL},
>         {
> +       /* https://bugzilla.kernel.org/show_bug.cgi?id=209989 */
> +       ec_honor_dsdt_gpe, "HP Pavilion Gaming Laptop 15-cx0xxx", {
> +       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +       DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Gaming Laptop 15-cx0xxx"),}, NULL},
> +       {
>         ec_clear_on_resume, "Samsung hardware", {
>         DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD.")}, NULL},
>         {
> --

Applied as 5.14 material, thanks!
