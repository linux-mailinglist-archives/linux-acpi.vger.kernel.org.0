Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3265E45CA5F
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240755AbhKXQvj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 11:51:39 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37561 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349214AbhKXQvi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2021 11:51:38 -0500
Received: by mail-oi1-f180.google.com with SMTP id bj13so6544544oib.4;
        Wed, 24 Nov 2021 08:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euuEacEJrSUtoSC+sETjVEJNFO1Mmm3Iu6XUBUwKAI4=;
        b=hWCdugcsbNCeB9QEDlG//yu8zJyjcvZYkjwxDkBitbhRWPhA167tPZd5YSY6BPVCYK
         Rzqbasdshg+X/2N1hsrDPAfhi8OAt6kZoekvcQkV174Twu0fCeU777xkfzHaeV/mIfaK
         KdmVG65JT89To5M2yDc5+68xZYP38ldTl2a0nw09+2DsMl9i2zr/YC54wsBXLi7vhv/F
         e3Q1gg7fAXhZ5hj4hlQDczYxpSxH/EwQ0QlkZlkab4Mi6jgSU3KR3iTRkuqjtHaxqPM9
         JV9QAndE0R3Fvt/cTciQuhp263RuYUwbjdCQaa0snWGCHA5kbm/V9Ylu0i7LwZVWCgiO
         pkcA==
X-Gm-Message-State: AOAM533+T0CFE2NERPqeSECzqVESb/IuAcD6g/TN8SRbDRxyfHID4nmc
        zvKkO5Ed/QgUnpyQtdJvG6EcnzNC7G2O4hwPf5Q=
X-Google-Smtp-Source: ABdhPJw4/m9JQnKWSpxpnTolMJ2+hQxdeLNaA2tMZl/DdHpHc8jufMTc/MauBVwzNbGx5xKhyS7D4Rpw0b4bVSnYFjU=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr7570513oiw.154.1637772508321;
 Wed, 24 Nov 2021 08:48:28 -0800 (PST)
MIME-Version: 1.0
References: <20211109075051.7890-1-guozhengkui@vivo.com>
In-Reply-To: <20211109075051.7890-1-guozhengkui@vivo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 17:48:17 +0100
Message-ID: <CAJZ5v0hXzkZuA5_V5UdrF9GyR79CN3S8F_rfJX16uumceJH8Hw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor idle: fix swap.cocci warning
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Nov 9, 2021 at 8:51 AM Guo Zhengkui <guozhengkui@vivo.com> wrote:
>
> Fix following coccicheck warning:
> ./drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c:914:40-41:
> WARNING opportunity for swap().
>
> swap() was used instead of the tmp variable to swap values.
>
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/acpi/processor_idle.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 76ef1bcc8848..4b906bb527e8 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -20,6 +20,7 @@
>  #include <linux/tick.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu.h>
> +#include <linux/minmax.h>
>  #include <acpi/processor.h>
>
>  /*
> @@ -400,13 +401,10 @@ static int acpi_cst_latency_cmp(const void *a, const void *b)
>  static void acpi_cst_latency_swap(void *a, void *b, int n)
>  {
>         struct acpi_processor_cx *x = a, *y = b;
> -       u32 tmp;
>
>         if (!(x->valid && y->valid))
>                 return;
> -       tmp = x->latency;
> -       x->latency = y->latency;
> -       y->latency = tmp;
> +       swap(x->latency, y->latency);
>  }
>
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
> --

Applied as 5.17 material with edited subject and changelog, thanks!
