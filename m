Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2E20FAA4
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jun 2020 19:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387803AbgF3Rek (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jun 2020 13:34:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45497 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgF3Rej (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2020 13:34:39 -0400
Received: by mail-ot1-f67.google.com with SMTP id m2so19063116otr.12;
        Tue, 30 Jun 2020 10:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHbMaf3MhGCn830JpN+2/XraG8hdOCn+GvQfr38ofJs=;
        b=aVGGWQmoN89FW/qfk3rjMGRV5qod9EuholEGHqRD32yN2tZQajUrbSZDLp6AOfaXE4
         SoorAyHMdVHwxipHZJqe4JcMV3JEzr96Wm+dkRnelg2BODTFxD5lKXhDM5rT8OxNmXRk
         OcGcDfV6LsvqkqwLG4m90hU+JMatr9GRIpftYT7qoHYwTtlk6Rj4mnW6OA5tOpRZizS4
         9bPO0NsPfXVe01M+tizcJeelK6pQa07tpqDqrMGijJLmpScrKarIhHD/ekbLCA0gvndZ
         AXfJz9pf7GZ7JhVc2eZUniuOvpiJ2cQqwKqWN2upNrl4oSV8HaQGoEu8Ka5/UvFqF372
         a9uQ==
X-Gm-Message-State: AOAM5304U+g5rey7N9mdRe/hC55Ovebyl85dVwBhQ4ywZauN0hCGIDs7
        239dXFbP69yXsAx2UhkdOPuYCbrjFsGxoOG8ledW0A==
X-Google-Smtp-Source: ABdhPJyFPGm4R7qPa9G9T+kW+CgurZWItaas1Fk14ATRaDh/a1cCwIRPWysA2S4F/mBsr4h4Ml+WnZvmNV04xPJvhG8=
X-Received: by 2002:a9d:7d15:: with SMTP id v21mr18319330otn.118.1593538478366;
 Tue, 30 Jun 2020 10:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <1593531709-21749-1-git-send-email-sumeet.r.pawnikar@intel.com>
In-Reply-To: <1593531709-21749-1-git-send-email-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jun 2020 19:34:27 +0200
Message-ID: <CAJZ5v0hkdDoed7ALMK+DR6h+qxnG3WXFsGMse5z+GcVpws8HPQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fan: fix: Update Tiger Lake ACPI device ID
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Cc linux-acpi]

On Tue, Jun 30, 2020 at 5:35 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Tiger Lake's new unique ACPI device ID for Fan is not valid
> because of missing 'C' in the ID. Fix this Fan ID by updating it.
>
> Fixes: c248dfe7e0ca ("ACPI: fan: Add Tiger Lake ACPI device ID")
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/fan.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 873e039ad4b7..62873388b24f 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -25,8 +25,8 @@
>
>  static const struct acpi_device_id fan_device_ids[] = {
>         {"PNP0C0B", 0},
> -       {"INT1044", 0},
>         {"INT3404", 0},
> +       {"INTC1044", 0},
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, fan_device_ids);
> --

Applied as 5.8-rc material with some changelog and subject edits, thanks!
