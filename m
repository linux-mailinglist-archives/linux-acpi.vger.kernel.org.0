Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E77839DE38
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFGOBi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 10:01:38 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:38716 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGOBh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 10:01:37 -0400
Received: by mail-oi1-f172.google.com with SMTP id z3so18117860oib.5;
        Mon, 07 Jun 2021 06:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+uI8v6TgyaDRAyaByB3PO1eB0jYuXCz1UUA6CHTHYo=;
        b=RpTWvA0Zdpry51YGZbBrlQN2nZ4I5m8GNZYKTIF2RPQm2Fsic9N04EQmt+DlKZOD4y
         ZZMO2BqDyjlHnPVBQgRQTFs1HoO3h4oFam+S15pf8jMclbAlL0NerE/ZYE55vNVL9K5G
         Olkrvtlpczx4TKpuIHqRSu/efoa1oBUpaJsDStizdQM8S5/ggb8UvOT7633YGKxl36sc
         0sNMdRtIgN2tpivykdVb0BfA25GBqC+Z2FCMcggTVuRg7Z+OAs0vcQ0AcDKWjEdFf+q1
         SKqRA2ASrLoMJj5VejVH0TRm43xy3G28JMKxUG70g3yvvvcCLLCjhWS1t6SyRyjn9CUw
         0Ejg==
X-Gm-Message-State: AOAM533P0WHuk275ebtiorxzA7sxgDG34frOVnVHUagCjhrEo7zOqx6c
        Gj1YxfhYRKHTL0tJygJyyz6ZCPNW1z3NzEmlLCE=
X-Google-Smtp-Source: ABdhPJyYG0QeGVV/1+HEbLBWgrR5xnDa9VeHxx2UTpsWxMGL/7bxtUFBMzNjM2xC2dgqcSdncOeinCwNdexnrApzSJc=
X-Received: by 2002:aca:1910:: with SMTP id l16mr10834366oii.69.1623074373748;
 Mon, 07 Jun 2021 06:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210602115812.109900-1-jingxiangfeng@huawei.com>
In-Reply-To: <20210602115812.109900-1-jingxiangfeng@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 15:59:22 +0200
Message-ID: <CAJZ5v0hDaDUy68OqTvD4vQix0cWw4KA9Nn3c6pVia2LgnVnUOw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: FPDT: Add the missed acpi_put_table() in acpi_init_fpdt()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 2, 2021 at 1:44 PM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> acpi_init_fpdt() misses to call acpi_put_table() in an error path. Add
> the missed function call to fix it.
>
> Fixes: d1eb86e59be0 ("ACPI: tables: introduce support for FPDT table")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
> v1 -> v2:
> - Collect Acked-by tag by Zhang Rui.
> - retitle the subject as suggested by Hanjun Guo.
> ---
>  drivers/acpi/acpi_fpdt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_fpdt.c b/drivers/acpi/acpi_fpdt.c
> index a89a806a7a2a..4ee2ad234e3d 100644
> --- a/drivers/acpi/acpi_fpdt.c
> +++ b/drivers/acpi/acpi_fpdt.c
> @@ -240,8 +240,10 @@ static int __init acpi_init_fpdt(void)
>                 return 0;
>
>         fpdt_kobj = kobject_create_and_add("fpdt", acpi_kobj);
> -       if (!fpdt_kobj)
> +       if (!fpdt_kobj) {
> +               acpi_put_table(header);
>                 return -ENOMEM;
> +       }
>
>         while (offset < header->length) {
>                 subtable = (void *)header + offset;
> --

Applied as 5.14 material with some edits in the subject and changelog, thanks!
