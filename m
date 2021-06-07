Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAF39DDD1
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGNkm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 09:40:42 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:46676 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhFGNkl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 09:40:41 -0400
Received: by mail-oo1-f50.google.com with SMTP id x22-20020a4a62160000b0290245cf6b7feeso4124857ooc.13
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 06:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rtf5a3m3DqjSP8tE8wnOI8xpyZU8RQ9zVh+Pu3w+6zE=;
        b=ZdDKgAdGOJ+uX4DKG57eWEU6VXlmwHFtsvf/wcHeoxr4Ayyr+KoMjcu08go0YR2o2K
         w6GVSwr0xUlkA4vO3ckpr/L+kuxJnk5NexeYzT2B788fcsHrlYao/vuzyGzlht/5jMnK
         GFRXuBntkAgPJpZ4YglDVuu8sphpk3nMH6o3amUJs9OoT5rQ7dc/R7tfd/a1XVYifL/a
         cq/oRKkIilUF3BkYmU+U0AU+Nv/bPUv6Cnrvoy+f3n2LbaPInHFh/RxS3Uo6LNhJVWUV
         Ux/wB4OJrnfPeaCt32Ae9Mxul2OU6RJwxrduKJNdqqmBfnSbQd0iPCT6h4HCLWyqQ5A1
         nOjg==
X-Gm-Message-State: AOAM530zLhDjZ+XhlKeWrJZndzVDVRs6YMJHzYrNIDUWBW1s4NQ76wwD
        /Jk6bS6og7nFROIxFxLScRGA+bVHuwdPua5oMyf4i43B
X-Google-Smtp-Source: ABdhPJyMhBWu/Y0lbAQzo9RW33T/33owd+7OS2E9DzBeHCdcfdvyAg331cbqCVr4JvOWYDPOnw5OrMB1OzNMn7PEHp4=
X-Received: by 2002:a4a:9bcb:: with SMTP id b11mr13392034ook.44.1623073130394;
 Mon, 07 Jun 2021 06:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1622624080-56025-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 15:38:39 +0200
Message-ID: <CAJZ5v0h2_iObnzxWUqgobK6OSOzQF6bo-Ypd5Gw8SWBsVsQuhw@mail.gmail.com>
Subject: Re: [PATCH 00/18] ACPI: Further cleanups for message printing
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 2, 2021 at 11:06 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> After the message printing cleanups to decouple with ACPICA, the message
> printing in ACPI subsystem still have the room for improvement. For now
> we use both PREFIX "ACPI: " and pr_*() macros for message print in ACPI
> subsystem, they are misused in follwing ways:
>
>  - Duplicated prefix. For example in sysfs.c we have pr_fmt() but we
>    still use pr_err(PREFIX ...), which is worng;
>
>  - Using pr_*() macros without pr_fmt(), but some pr_*() calls added
>    the PREFIX and some didn't in the same file;
>
>  - Mixed use of printk(PREFIX) and pr_*() macros in one driver but
>    don't have the same prefix for message printing.
>
> All the above will confuse people, sometimes leads to write some wrong
> message printing code, so just use pr_fmt() and pr_*() macros to generate
> a unified format string, and remove the using of PREFIX "ACPI: " in ACPI
> drivers, finally remove PREFIX "ACPI: " definition in the internal.h,
> which prevent further misuse of the PREFIX.
>
> Also remove some in-house DBG code which is not useful, replace with
> pr_debug() instead.
>
> Hanjun Guo (18):
>   ACPI: cmos_rtc: Using pr_fmt() and remove PREFIX
>   ACPI: blacklist: Unify the message printing
>   ACPI: bus: Use pr_*() macros to replace printk()
>   ACPI: event: Use pr_*() macros to replace printk()
>   ACPI: glue: Clean up the printing messages
>   ACPI: nvs: Unify the message printing
>   ACPI: osl: Remove the duplicated PREFIX for message printing
>   ACPI: pci_root: Unify the message printing
>   ACPI: processor_thermal: Remove unused PREFIX for printing
>   ACPI: processor_perflib: Cleanup print messages
>   ACPI: processor_throttling: Cleanup the printing messages
>   ACPI: reboot: Unify the message printing
>   ACPI: sysfs: Cleanup message printing
>   ACPI: sbshc: Unify the message printing
>   ACPI: scan: Unify the log message printing
>   ACPI: sbs: Unify the message printing
>   ACPI: sleep: Unify the message printing
>   ACPI: Remove the macro PREFIX "ACPI: "

Whole series applied as 5.14 material, thanks!
