Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA4438E8C2
	for <lists+linux-acpi@lfdr.de>; Mon, 24 May 2021 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhEXOdL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 10:33:11 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:36627 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbhEXOdL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 May 2021 10:33:11 -0400
Received: by mail-oi1-f175.google.com with SMTP id t24so11713402oiw.3
        for <linux-acpi@vger.kernel.org>; Mon, 24 May 2021 07:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8CbAkbnaisxEl2ItKyC9H1iiB7pzc1weZHp0esCCiM=;
        b=Ermtug8HIq1q9tZdKjC511QjSd6U920HJmCYRTURX5QZR33oggfMYODrQDLS0tNmVR
         wm/tKT+wIM/sQFeIfz2IV7B3Q9HnnKZ6oV5y/f0hC88sQzAaVCh7JS3kR6X9QtTDRUn2
         nayi4eX12dW5EvPykOROk2VD+t+kti+sBg1DSd+r/pHzwF12w13qtfm3xz4VK1Bq3guc
         rMRozM6DHglnfjNhIDx/Sz17kUCdATTQtxyc0Vg9t+4texVL6Yc5cmthcajGM/Bm/fqT
         j+v+zD267uxc8ZRnFcgASdmgkub4QsSt5TqJIxuwRJ5wkMmhR54cNNw4IbvEek3lDsLp
         B8Bg==
X-Gm-Message-State: AOAM532RTsvrXgCbw+QIAcERn/1/iYy27mlQt7S1iDe6UM3GRjae6KEZ
        J9CzQtnrB6omoQo3e5Ki6imDK7rwsscPN57ONRs=
X-Google-Smtp-Source: ABdhPJwzzAdbYX9+ecGA1pTWR4tpS1S5MUFZEE/VmDA8L6feL1pWeCiRHd8P5FgwbjJ00r8N71h4iHChYo0T7jqg+dk=
X-Received: by 2002:aca:1910:: with SMTP id l16mr10500227oii.69.1621866701595;
 Mon, 24 May 2021 07:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <1621849265-22293-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1621849265-22293-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 May 2021 16:31:26 +0200
Message-ID: <CAJZ5v0gTE-rZiDDbfOH=X_rG_KttvSqz7Tc_SET8fhK4ToQA4w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: configfs: Replace ACPI_INFO() with pr_debug()
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 24, 2021 at 11:51 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> The ACPI_INFO() macro is used for message printing in the ACPICA code.
> ACPI_INFO() will be empty if the ACPICA debug is not enabled, so
> it can be replaced with pr_debug().
>
> Also remove the not needed acpica head file inclusions to decouple
> with ACPICA.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>
> Seems we missed this file for cleaning up the ACPICA message printing,
> do it now.
>
>  drivers/acpi/acpi_configfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
> index 3a14859..76b83b1 100644
> --- a/drivers/acpi/acpi_configfs.c
> +++ b/drivers/acpi/acpi_configfs.c
> @@ -13,9 +13,6 @@
>  #include <linux/acpi.h>
>  #include <linux/security.h>
>
> -#include "acpica/accommon.h"
> -#include "acpica/actables.h"
> -
>  static struct config_group *acpi_table_group;
>
>  struct acpi_table {
> @@ -226,7 +223,7 @@ static void acpi_table_drop_item(struct config_group *group,
>  {
>         struct acpi_table *table = container_of(cfg, struct acpi_table, cfg);
>
> -       ACPI_INFO(("Host-directed Dynamic ACPI Table Unload"));
> +       pr_debug("Host-directed Dynamic ACPI Table Unload\n");
>         acpi_unload_table(table->index);
>         config_item_put(cfg);
>  }
> --

Applied as 5.14 material with some edits in the changelog, thanks!
