Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7FC2ED4C4
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbhAGQvv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Jan 2021 11:51:51 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:41195 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbhAGQvv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 11:51:51 -0500
Received: by mail-oi1-f178.google.com with SMTP id 15so8047101oix.8;
        Thu, 07 Jan 2021 08:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QRY+oCUw7AZGdFQ4cs7QiDXR0ZT6ctIGkSGF1RXO+kE=;
        b=Q/aNxtwM87K3fVcnE4x4Ilco6FDDbqn7hgb9HW7WIF66tkueA8GZI2MxNd9LyKapaD
         98t8vynWOakTOXKi8pD8weAFWVT5hDUCFF5ZwV7yw6i0uTZ6mjz3WX9GbcLy+RGqw7d3
         FPkrQreLeEXXWrZdkEvlu+myXGod2y3e+G7p8smYhXO0Wi2YcOvw+QL18hIRbLgUG+le
         PauMK6pRrYsGhpVCSqny4VQVZXYKgYnfG3tKOTyfXjavQiNQcMKJQP508Nrmq6MQvF1l
         QxGzoi019HEqc6iXV2O4yFBD0oIX7QBMeHDoePb4sZxSI0ezu7IqnYaPV2Kz3baItSS/
         uiWA==
X-Gm-Message-State: AOAM530tSjB5V8bs1gBLKHZHLY2LUn5p5N3EVnyMY2SwEl7Kgt4ipcii
        mbWb7H/zYW3nuHETwmYZd0tu2Q4fEzvx3oxaqPJaNDhT
X-Google-Smtp-Source: ABdhPJzc1zvGCFdycyKQ4s3da/G/8VntC06Ff9g6YI5/v8JFOOo6IXLnUwSz4SV+L/QInyI5z3bs9hmnMkHpFP5gkuQ=
X-Received: by 2002:aca:4892:: with SMTP id v140mr1917599oia.71.1610038270432;
 Thu, 07 Jan 2021 08:51:10 -0800 (PST)
MIME-Version: 1.0
References: <20201229111759.1207387-1-pbrobinson@gmail.com>
In-Reply-To: <20201229111759.1207387-1-pbrobinson@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 17:50:59 +0100
Message-ID: <CAJZ5v0jFUtBMJNA7a4_NnR16q5=bwQ=v+dJ0tiEGGhVZ9TqWPA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Update Kconfig help text for items that are no
 longer modular
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Dec 29, 2020 at 12:19 PM Peter Robinson <pbrobinson@gmail.com> wrote:
>
> The CONTAINER and HOTPLUG_MEMORY memory options mention modules
> but are bool only options so if selected are alway built in. Drop
> the help text about modules.
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  drivers/acpi/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index edf1558c1105..ebcf534514be 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -395,9 +395,6 @@ config ACPI_CONTAINER
>
>           This helps support hotplug of nodes, CPUs, and memory.
>
> -         To compile this driver as a module, choose M here:
> -         the module will be called container.
> -
>  config ACPI_HOTPLUG_MEMORY
>         bool "Memory Hotplug"
>         depends on MEMORY_HOTPLUG
> @@ -411,9 +408,6 @@ config ACPI_HOTPLUG_MEMORY
>           removing memory devices at runtime, you need not enable
>           this driver.
>
> -         To compile this driver as a module, choose M here:
> -         the module will be called acpi_memhotplug.
> -
>  config ACPI_HOTPLUG_IOAPIC
>         bool
>         depends on PCI
> --

Applied as 5.11-rc material, thanks!
