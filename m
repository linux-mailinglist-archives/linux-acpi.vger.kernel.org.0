Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0645FC1DC
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 09:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKNIuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 03:50:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34698 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfKNIuL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 03:50:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id 5so4221554otk.1;
        Thu, 14 Nov 2019 00:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bWhLkNhHl9VIbHrV6dW8/E/cVRdOoF8TYXGOFy/2rM=;
        b=SQ5sULUQq6HHiDqWjqWObNq+OaApC7GYWWzV0SPE1no9AM44eHaVV/8EuJBKZnLBzV
         YVhV83mhhX8SmJf6iLS7MSZvPReRef8N8yWIGof//BCyfW3Q0/lEURLkAMoBkgWV9kgF
         sTDZfjngp3ZBf5xtIC313lw4EfQIP5DQ7QrIDFJh+buES00KUYAQN1w18Ecj3Ajvraiu
         1ZxKe5eFE6B4ja3bzXPP7Ixw91NB1oHd63/XJoP1zcQgCuuu/it4G+8YGKwF297XmMR4
         zad4XqY6K5fHIfhvbohZL8YJhqiOjeaqHVYgOFNLEIk/vFK4dfAX8jUqAWY04fPTyey4
         94bQ==
X-Gm-Message-State: APjAAAWQIrDcmTdHGlztDoegqKRcEC+cDrZL8R2WOZkE0LhCW6oXcwxZ
        d/iegD+5IX3bwSXVLiAU1lY/zurnbUHTtO7ODV8=
X-Google-Smtp-Source: APXvYqxemxsnrvy+ic5ui5311TWGh+PLygVk5OF67FrT8flj6s/P4SOHtOLrIzHdBVxiJatAC6C9Ibom47ovFyQT6WQ=
X-Received: by 2002:a9d:6b91:: with SMTP id b17mr6158857otq.189.1573721410165;
 Thu, 14 Nov 2019 00:50:10 -0800 (PST)
MIME-Version: 1.0
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
In-Reply-To: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Nov 2019 09:49:59 +0100
Message-ID: <CAJZ5v0j4c8o9Tnex0fcnkmTMazSGPmVPiQf1C4kqE_yLUyMz9A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 14, 2019 at 8:16 AM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>
> The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
> parameter cover all GPEs") says:
>   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
>    GPEs can be masked"
>
> But the masking of GPE 0xFF it not supported and the check condition
> "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
> u8.
>
> So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
> ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
> acpi_mask_gpe parameter.
>
> Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Applying as 5.5 material, thanks!

> ---
> v1 -> v2:
>  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
>  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
>  - update the commit comment
>
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/acpi/sysfs.c                            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a84a83f8881e..87e27186dc69 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -113,7 +113,7 @@
>                         the GPE dispatcher.
>                         This facility can be used to prevent such uncontrolled
>                         GPE floodings.
> -                       Format: <int>
> +                       Format: <byte>
>
>         acpi_no_auto_serialize  [HW,ACPI]
>                         Disable auto-serialization of AML methods
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 75948a3f1a20..0a83ce186bc4 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -819,14 +819,14 @@ static ssize_t counter_set(struct kobject *kobj,
>   * interface:
>   *   echo unmask > /sys/firmware/acpi/interrupts/gpe00
>   */
> -#define ACPI_MASKABLE_GPE_MAX  0xFF
> +#define ACPI_MASKABLE_GPE_MAX  0x100
>  static DECLARE_BITMAP(acpi_masked_gpes_map, ACPI_MASKABLE_GPE_MAX) __initdata;
>
>  static int __init acpi_gpe_set_masked_gpes(char *val)
>  {
>         u8 gpe;
>
> -       if (kstrtou8(val, 0, &gpe) || gpe > ACPI_MASKABLE_GPE_MAX)
> +       if (kstrtou8(val, 0, &gpe))
>                 return -EINVAL;
>         set_bit(gpe, acpi_masked_gpes_map);
>
> --
> 2.7.4
>
