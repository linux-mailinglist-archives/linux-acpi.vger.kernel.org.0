Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9BC244C1B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 17:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHNP1p (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 11:27:45 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45668 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgHNP1o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2020 11:27:44 -0400
Received: by mail-oi1-f196.google.com with SMTP id o21so8421691oie.12
        for <linux-acpi@vger.kernel.org>; Fri, 14 Aug 2020 08:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2IXuSSnNhV0pFfNe3Ufyzp/VjDbHljBNbRNegiJEDI=;
        b=iM+UA8DAV6iDD5WpUK6u7Z7dzSTrgEBwEut2Xxh8N7MeH5IqdExH2E1bdzgU/lowXK
         CuLHGVwWBhApuUXlr2m/vq/yl0vT81F8zk6UGRBpi7Q7gr+5pxdLY5kgYoCgOcltH+es
         IRbLF8Lhxk/GK6H9yfDSreQvizhIrAZU7M8fZUREL+hUtEa2ylbHJFJ91d8izdCgBUE3
         h0/Dh/PO+xLF5q+iWoyBaRfXZtSc8cSxojwK05ZbFtpMVqMIbiPzTkQkXUyvS3UFWVKV
         RScGMaxdrWHrSIzNYV91zI+HEJxqyWnHafD7S98q6lF2gyXJgWoA1LhAHQAqWGw/qXAc
         HG+g==
X-Gm-Message-State: AOAM533H7bDxK1HsyCVpuIIae6mTXznwldD5a4yc3w/sZmI/0ivqi3ub
        +qXNSB6hdfaOLjnuflN3S0B9dYGCBDfMOqKDne0=
X-Google-Smtp-Source: ABdhPJwP+zhH1hzyvIqkmcOmFXnh7Imdm3lgXjaQLPlQyXP3/6/eTkhgVEkrMikDYsnhP7HNHcoNpwOgPSxdMUTKwR8=
X-Received: by 2002:aca:a88e:: with SMTP id r136mr1942126oie.110.1597418863408;
 Fri, 14 Aug 2020 08:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com> <20200813175729.15088-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-7-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:27:31 +0200
Message-ID: <CAJZ5v0gwJBh3wFg9iKTOxEL-tovEys7QUsM_mvP6+Jkytf4xjQ@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] ACPI: watchdog: Replace open coded variant of resource_union()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Since we have resource_union() helper, let's utilize it here.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_watchdog.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index 5c1e9ea43123..ca28183f4d13 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -151,11 +151,7 @@ void __init acpi_watchdog_init(void)
>                 found = false;
>                 resource_list_for_each_entry(rentry, &resource_list) {
>                         if (rentry->res->flags == res.flags &&
> -                           resource_overlaps(rentry->res, &res)) {
> -                               if (res.start < rentry->res->start)
> -                                       rentry->res->start = res.start;
> -                               if (res.end > rentry->res->end)
> -                                       rentry->res->end = res.end;
> +                           resource_union(rentry->res, &res, rentry->res)) {
>                                 found = true;
>                                 break;
>                         }
> --
> 2.28.0
>
