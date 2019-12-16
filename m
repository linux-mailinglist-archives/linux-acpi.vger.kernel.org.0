Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC712006E
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2019 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfLPI6j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Dec 2019 03:58:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35409 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfLPI6j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Dec 2019 03:58:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id o9so8288599ote.2;
        Mon, 16 Dec 2019 00:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFJZor1biFEHIwwZ0BclodlIuoSH1GnzGtcFATNXh5w=;
        b=kOhETbg38DJObu/oUCSafgukO19vRQvfKsu++dqX/FwXe+kb6+mhddkgIBP4UMdfMI
         nu5ItM6dRIfyNP+ACpFsmygWzySvudgTEUh29gZYPOwOZN2kBEBdWe7lRi8xvMhXyst1
         PfVvzGnHBo3obCv2ieXHiKPiLC/3Bwjm7DMdF6K1aixYQ8nNsom3qlu9P/CRxNJINoif
         PzJQK8pB/KBeDOgPSsPkVGex4ZzrPE0P/SrHZXgLT2M+QnGiqOXXmZh3O4LbRryLruy0
         Z8zzpBDRXwpa8V7pt7URJea/w0iCSSkBYXhcSFHSiIzTuAnna/uGLSXCh4qRp6JH6+Nf
         1lyQ==
X-Gm-Message-State: APjAAAVsYG76JjaTI8pASwmshryLvc3ouBtNGK5hVchN+62/Jm2QsP++
        VBHnCrTmEBi1Bznykn4Rq/IXucp3bKa54yw4aoU=
X-Google-Smtp-Source: APXvYqwIHgcR8X1x79aA30CcO7mb98RgFmcgRiLRKFjpih9hvfMnINWSwB/MEDD2rGBZXliIDZOM7hfyst4lsWb5jXw=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr29766196ote.118.1576486718384;
 Mon, 16 Dec 2019 00:58:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576260216.git.gayatri.kammela@intel.com> <3c1ed2c9964c63fc956ec249d7bfce8d49f53fee.1576260216.git.gayatri.kammela@intel.com>
In-Reply-To: <3c1ed2c9964c63fc956ec249d7bfce8d49f53fee.1576260216.git.gayatri.kammela@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Dec 2019 09:58:27 +0100
Message-ID: <CAJZ5v0hysFS+tVKz3fJ0yoOTqaGpx+4oD2Nh98HCzT86=hXawA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] acpi: fan: Add new Tiger Lake hardware ID to
 support fan driver in acpi
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Alex Hung <alex.hung@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 13, 2019 at 9:40 PM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> Tiger Lake has a new unique hardware ID to support fan driver. Hence,
> add it.
>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> ---
>  drivers/acpi/fan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> index 816b0803f7fb..13708fb48038 100644
> --- a/drivers/acpi/fan.c
> +++ b/drivers/acpi/fan.c
> @@ -25,6 +25,7 @@ static int acpi_fan_remove(struct platform_device *pdev);
>
>  static const struct acpi_device_id fan_device_ids[] = {
>         {"PNP0C0B", 0},
> +       {"INT1044", 0},

This has to go into device_pm.c:acpi_dev_pm_attach() too, see commit

b9ea0bae260f ACPI: PM: Avoid attaching ACPI PM domain to certain devices

>         {"INT3404", 0},
>         {"", 0},
>  };
> --
