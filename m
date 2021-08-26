Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216A33F8C8B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 18:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbhHZQ5R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 12:57:17 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34488 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhHZQ5Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2021 12:57:16 -0400
Received: by mail-oi1-f172.google.com with SMTP id p2so5815608oif.1;
        Thu, 26 Aug 2021 09:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEqFS/K0D6MKonUszeXgYkQW/P+ojBg3zSOvFVqTnVQ=;
        b=WqYGdIvGqxGy9QOekRxxlB5XPEADkM1SPP/qCGTZ1dTT+X7+X0zVNlKAqeQSHulOwO
         QWBBEuCSYNpxlhh9aR5uING6FA1S0cPLP/f3FflnlPfhDEeyTmv5Wh+kkLuxP4i5GL4n
         k3GtmVGQT1BUbv0ei1e305asyr+eebzzLOzuRe+kGVmUJRZtYU3PSXP7fS/Mvdrpqf8X
         eSpV+AB/4wwtmbsWYsMaJLKpbFGfBK6DPVLOhCRGG92bRFicUiTyGgnYxT9zkQqSpOu/
         3RFlv+fa9VyUoR13U2rXy2LTW2FS6EcqHMZ5kpi4lhQt/MArgXdxdlDb5ixqFJHYImqM
         /WXw==
X-Gm-Message-State: AOAM531tnL++cC2udeWtVMSoW6p1/olo1+mnKRNBJpFDAQm/FCCoK5h/
        6H+Bnh4NZqoTDXnJx9GIzgfOt8AMOgrc+0NZWAI=
X-Google-Smtp-Source: ABdhPJwRJe/paZN6NxlyGl18naa21mDoNn5kPgiY+5253spUxOlG+BuxUwTtUlcEOZo1La9gwdN4ZOKAoo78rWLDg9k=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr3197870oie.71.1629996988999;
 Thu, 26 Aug 2021 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210826105324.36853-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210826105324.36853-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Aug 2021 18:56:18 +0200
Message-ID: <CAJZ5v0iBaCtm7Mm_y0T-MJCTsPbBUUMRa1O=1c6hNt4ohaWkjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] media: ipu3-cio2: Drop reference on error path in cio2_bridge_connect_sensor()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 26, 2021 at 12:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The commit 71f642833284 ("ACPI: utils: Fix reference counting in
> for_each_acpi_dev_match()") moved adev assignment outside of error
> path and hence made acpi_dev_put(sensor->adev) a no-op. We still
> need to drop reference count on error path, and to achieve that,
> replace sensor->adev by locally assigned adev.
>
> Fixes: 71f642833284 ("ACPI: utils: Fix reference counting in for_each_acpi_dev_match()")
> Depends-on: fc68f42aa737 ("ACPI: fix NULL pointer dereference")
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> v2: added tag (Sakari), Cc'ed to Rafael to pick up (would be nice to push it to v5.14)
>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> index 59a36f922675..30d29b96a339 100644
> --- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
> +++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
> @@ -226,7 +226,7 @@ static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
>  err_free_swnodes:
>         software_node_unregister_nodes(sensor->swnodes);
>  err_put_adev:
> -       acpi_dev_put(sensor->adev);
> +       acpi_dev_put(adev);
>         return ret;
>  }
>
> --

Applied as 5.14-rc material, thanks!
