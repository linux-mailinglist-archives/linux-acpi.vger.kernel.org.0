Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1F2B6B86
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 18:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgKQRQC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 12:16:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44526 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727641AbgKQRQC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 12:16:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id f16so20120489otl.11
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2020 09:16:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU02iKysb8rL9jD9CUkih37Th/kQmSxXYxpJiBWEGrQ=;
        b=RdWlxqz4hD1FE8BKE0050y4+W+ZR3IasF6n6YWhZJLOlos6RT8FtoGDdiyVnsO2K16
         dK1Gq1rH9SsJyIGq3iGcPDnbyxrPS5oy2PyPGPW03AZyMB+uTLFKFRDHfqqYbXeRVCU0
         pFJ4Ib+VCWPmkh/cvZqC1uQbl9HhIrkCzGLOF4WxfapQdb+ICncrHf0Y8dz8h0jXML65
         Gnagy3F7kDby8tl61YcihwcubboCs5FHH6Ub2AL+s8kmP+Hs9B7MoYrGK3QQdQtLG3A0
         Tk2Lz7Qlknj4P5Cq5KS7fI89l3v6ORjE2T1S2wb1KnelBxIyWm5dGn0zTW34UlfXQHMg
         03fA==
X-Gm-Message-State: AOAM5306dgOhtI5aM4vAVVukMWRsdQv5xGv3tH45mMgQZwV6vIyZU1fV
        Sw16aMrxnGwOHaIwWj5kyZQO/VdYtIFe2UWAZPY=
X-Google-Smtp-Source: ABdhPJz7EBxHuVKAhnJ8OEu/UFqY3O1b8a+5YXwWP3W7MToVbU0vcCL6ff3PhNtPHQy79+i1Dt4RulIS7tdVyX0rRGo=
X-Received: by 2002:a9d:222f:: with SMTP id o44mr3824864ota.321.1605633360044;
 Tue, 17 Nov 2020 09:16:00 -0800 (PST)
MIME-Version: 1.0
References: <1605233324-19524-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1605233324-19524-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 18:15:48 +0100
Message-ID: <CAJZ5v0g1MFkZqFpaFgjH4VzANpdBzMBKxX50RJjjkao2fi=4xw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Remove the duplicated
 ACPI_PROCESSOR_CLASS macro
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 13, 2020 at 3:17 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> The ACPI_PROCESSOR_CLASS macro is defined in <acpi/processor.h>,
> and ACPI drivers for processor already included <acpi/processor.h>,
> so we can remove those duplicated ACPI_PROCESSOR_CLASS macros.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/processor_idle.c       | 1 -
>  drivers/acpi/processor_perflib.c    | 1 -
>  drivers/acpi/processor_thermal.c    | 2 --
>  drivers/acpi/processor_throttling.c | 1 -
>  4 files changed, 5 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index f66236c..d93e400 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -31,7 +31,6 @@
>  #include <asm/apic.h>
>  #endif
>
> -#define ACPI_PROCESSOR_CLASS            "processor"
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_idle");
>
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index b04a689..3b5a964 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -22,7 +22,6 @@
>
>  #define PREFIX "ACPI: "
>
> -#define ACPI_PROCESSOR_CLASS           "processor"
>  #define ACPI_PROCESSOR_FILE_PERFORMANCE        "performance"
>  #define _COMPONENT             ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_perflib");
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index 6c7d05b..677a132 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -19,8 +19,6 @@
>
>  #define PREFIX "ACPI: "
>
> -#define ACPI_PROCESSOR_CLASS            "processor"
> -
>  #ifdef CONFIG_CPU_FREQ
>
>  /* If a passive cooling situation is detected, primarily CPUfreq is used, as it
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index a0bd56e..b187653 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -22,7 +22,6 @@
>
>  #define PREFIX "ACPI: "
>
> -#define ACPI_PROCESSOR_CLASS            "processor"
>  #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_throttling");
>
> --

Applied as 5.11 material along with the other janitorial patches
posted by you last week.

Thanks!
