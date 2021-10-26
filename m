Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376C543B33E
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 15:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhJZNis (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 09:38:48 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]:46767 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236158AbhJZNis (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 09:38:48 -0400
Received: by mail-oo1-f44.google.com with SMTP id d144-20020a4a5296000000b002b6cf3f9aceso3741436oob.13;
        Tue, 26 Oct 2021 06:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ca40SsNZgq2MNL2RplDe1lsTRzhybyd8pfJtb7MPycY=;
        b=rbi8xB7omVJWqSBTpbhfhvb1BWd63a5SZ6Jn6izvh8Ew1XtnI3NGqwV2SpqD8Ut4Xi
         u03LnozTzM/OD1pE2Wdocwq4FK+1UiwKzLACH97iOxd1l7dVZt9l+n4IoNb4qQAenR7L
         aO6yh3nZhmj80znkxrxtvD/9QJd4FSvD9oy85vbH4WCQisOdLGhvz6Ls7/Tird5YoMHq
         H91LihfQjmdu0RCbajuz/1BO5SF/EBVDI5LwYF2TxQ0kYbphnrXJwN2OWIzYPkh0bhXR
         4eCIZov16RkPdCOZ3iIFXpy0ohupa39ZeJHbiyxuMuPQR103mI2jFr/wG+Fyer6HSjMX
         rymA==
X-Gm-Message-State: AOAM531ctv0OZXnrG2WTU58saR0DfRYvyujeQizJ0CksuDDHbZAgxXRN
        5biEiziGkaa4os51YNKhibOZQPiMSFhlNJe+a4CMx9WJ
X-Google-Smtp-Source: ABdhPJxgRlcRrxwRxFHsS3HjPVZ7Q5QUlDuaiIbpBrLiU2JeN7EXxV03GxNN3o7tNnCS1qxeSUZur9DEBNFBtAOO3FM=
X-Received: by 2002:a4a:eb12:: with SMTP id f18mr17138964ooj.91.1635255384230;
 Tue, 26 Oct 2021 06:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211024220446.2873-1-schaecsn@gmx.net>
In-Reply-To: <20211024220446.2873-1-schaecsn@gmx.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:36:08 +0200
Message-ID: <CAJZ5v0jxg_075-Jgbj+ubRk2b7u36OjiMpfnHgavgKg=sF33zQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: AC: Quirk GK45 to skip reading _PSR
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 12:07 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> Let GK45 not go into BIOS for determining the AC power state. BIOS wrongly
> returns 0. Hardcode the power state to 1.
>
> The mini PC GK45 by Besstar Tech Lld. (aka Kodlix) just runs off AC. It
> does not include any batteries. Nevertheless BIOS reports AC off:
>
> root@kodlix:/usr/src/linux# cat /sys/class/power_supply/ADP1/online
> 0
>
> root@kodlix:/usr/src/linux# modprobe acpi_dbg
> root@kodlix:/usr/src/linux# tools/power/acpi/acpidbg
>
> - find _PSR
>    \_SB.PCI0.SBRG.H_EC.ADP1._PSR Method       000000009283cee8 001 Args 0 Len 001C Aml 00000000f54e5f67
>
> - execute \_SB.PCI0.SBRG.H_EC.ADP1._PSR
> Evaluating \_SB.PCI0.SBRG.H_EC.ADP1._PSR
> Evaluation of \_SB.PCI0.SBRG.H_EC.ADP1._PSR returned object 00000000dc08c187, external buffer length 18
>  [Integer] = 0000000000000000
>
> that should be
>
>  [Integer] = 0000000000000001
>
> Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>
> ---
>  drivers/acpi/ac.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index b0cb662233f1..81aff651a0d4 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -61,6 +61,7 @@ static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
>
>  static int ac_sleep_before_get_state_ms;
>  static int ac_check_pmic = 1;
> +static int ac_only;
>
>  static struct acpi_driver acpi_ac_driver = {
>         .name = "ac",
> @@ -93,6 +94,11 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
>         if (!ac)
>                 return -EINVAL;
>
> +       if (ac_only) {
> +               ac->state = 1;
> +               return 0;
> +       }
> +
>         status = acpi_evaluate_integer(ac->device->handle, "_PSR", NULL,
>                                        &ac->state);
>         if (ACPI_FAILURE(status)) {
> @@ -200,6 +206,12 @@ static int __init ac_do_not_check_pmic_quirk(const struct dmi_system_id *d)
>         return 0;
>  }
>
> +static int __init ac_only_quirk(const struct dmi_system_id *d)
> +{
> +       ac_only = 1;
> +       return 0;
> +}
> +
>  /* Please keep this list alphabetically sorted */
>  static const struct dmi_system_id ac_dmi_table[]  __initconst = {
>         {
> @@ -209,6 +221,13 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
>                 },
>         },
> +       {
> +               /* Kodlix GK45 returning incorrect state */
> +               .callback = ac_only_quirk,
> +               .matches = {
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "GK45"),
> +               },
> +       },
>         {
>                 /* Lenovo Ideapad Miix 320, AXP288 PMIC, separate fuel-gauge */
>                 .callback = ac_do_not_check_pmic_quirk,
> --

Applied as 5.16 material with minor edits in the changelog, thanks!
