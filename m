Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4160278568
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Sep 2020 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIYKx4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Sep 2020 06:53:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33670 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYKx4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Sep 2020 06:53:56 -0400
Received: by mail-oi1-f195.google.com with SMTP id m7so2369269oie.0
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2020 03:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKBa+ey7uoeFf6jsh7JHf0wfIHmbcQaUCnWhXCU9ISs=;
        b=XEEYa7nDbwk4sr2JzJwJos7yhEVzY1ZYz4HSLTpJzAP49razG7TQYGCKo4PuHdhtxn
         VzToD/30gTBDoQoxK/jixM0tslaH1g5sv7TxWx8GwQlkuk/FsDlyfzc9erbDbrqs8L0m
         aoL8+QtSuLd1EklBFyLi02Wjs1spM4UZupdws2LPTNnK2votQ/+O8ZjbToC+R0/XdBLL
         oAwE5xr8vJEXp57BfRfosH7KQgrftQuGV2JXyt3YMaV7G8MQu/TXsFZ/7KxJ2X1luR64
         MbLLi/W7FoV2tr9OShYTFg9UenKTW6TDi+4ChjoP9MXXto0k0Z9gsQ8S1/kvHZW+WTc8
         lavQ==
X-Gm-Message-State: AOAM532LVvGG+uSGs3ucnLhBGFbt8sG/FpxgPyWK8T+Tv95pZO50E37N
        xl8AASYf21iOJKMJi3FT9YckL6cXDOrUTcgT8wL147by
X-Google-Smtp-Source: ABdhPJya/uu1z6NPpLYm2pNRaVtDqPr1Ce5xfa4gSmC6y7QteAOc4sJrAkcM43Jv8IW1jIcAevaYwAiceo+RIpejtSE=
X-Received: by 2002:aca:df84:: with SMTP id w126mr1202916oig.103.1601031236034;
 Fri, 25 Sep 2020 03:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200911164613.4928-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200911164613.4928-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Sep 2020 12:53:45 +0200
Message-ID: <CAJZ5v0jMHUXWjH7nNcyfo5SDjw5c51kKWAcXgV10Kdbc7gsCHA@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: Use my kernel.org address for Intel PMIC work
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 11, 2020 at 6:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Use my kernel.org address for Intel PMIC work. While here,
> upgrade status to maintainer of PMIC MFD devices.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied as 5.10 material, thanks!

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26af84f97353..f0be706caba3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -405,7 +405,7 @@ F:  drivers/platform/x86/i2c-multi-instantiate.c
>  ACPI PMIC DRIVERS
>  M:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:     Len Brown <lenb@kernel.org>
> -R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +R:     Andy Shevchenko <andy@kernel.org>
>  R:     Mika Westerberg <mika.westerberg@linux.intel.com>
>  L:     linux-acpi@vger.kernel.org
>  S:     Supported
> @@ -9000,7 +9000,7 @@ F:        drivers/gpio/gpio-*cove.c
>  F:     drivers/gpio/gpio-msic.c
>
>  INTEL PMIC MULTIFUNCTION DEVICE DRIVERS
> -R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> +M:     Andy Shevchenko <andy@kernel.org>
>  S:     Maintained
>  F:     drivers/mfd/intel_msic.c
>  F:     drivers/mfd/intel_soc_pmic*
> --
> 2.28.0
>
