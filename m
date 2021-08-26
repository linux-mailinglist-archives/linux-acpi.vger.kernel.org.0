Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83EA3F8C7D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbhHZQwE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 12:52:04 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:33709 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhHZQwD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2021 12:52:03 -0400
Received: by mail-oo1-f41.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so1161613ooe.0;
        Thu, 26 Aug 2021 09:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0RS9BtmuQKC66rh7NIJggtjqQi+Y2U2nIIX3anWZFw=;
        b=QDzxqd61yhfkQ0nFS/4uyTVVcSBmUB145qnquLR168rsnyblNf0oxPeyNxsvB3OaxG
         MrSDuQ3q4V9ThFgLz2kdvz4QbueG/JEbo+6mkxuAeCHlqZwqji5WhKzraC5ixmv6P6I+
         6ProOdW/jAk/+wzIT7IWvym3GuN2i1gqgIGtF0/kwe99Q/kPitPO5D4wzSZdl8VLuvSY
         RJ7Oi/pGKx3/u+zr1MpUQJqO1vd/CGBUlZgvxCVg4yr2yqkVbIkQPQNTl422QwMKPPrb
         BExNooHI88KBlD0m74oVdKAyHfy3mpPHGkRcpZfQ8Gqy7KispKNterN+1sjy+qHRn/eT
         ZBtw==
X-Gm-Message-State: AOAM532h1Hl5LYq7OL0WBnjY5jQbrACcZgms8LaVA1OIFlshbEaEzia/
        6QqTpbwawTYD+j/5S5pZVZZnOMncrE3c2kF6vss=
X-Google-Smtp-Source: ABdhPJwDK1TQo42dcIDi/B0EM/wdubvHTgOceWwZz7PiZIYGR2iSc53SREsnzAN5Ogu7OcPc+cD/wg7hIKLa3OIOwj4=
X-Received: by 2002:a4a:ca83:: with SMTP id x3mr4032922ooq.2.1629996676042;
 Thu, 26 Aug 2021 09:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210826150317.29435-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210826150317.29435-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Aug 2021 18:51:05 +0200
Message-ID: <CAJZ5v0it9vB1s2HxMtTnS8Gv=EFZq6ykoV7Z3npoh4raXLJOuQ@mail.gmail.com>
Subject: Re: [resend, PATCH v2 1/1] x86/platform: Increase maximum GPIO number
 for X86_64
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 26, 2021 at 5:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> By default the 512 GPIOs is the maximum on any x86 platform.
> With, for example, Intel Tiger Lake-H the SoC based controller
> occupies up to 480 pins. This leaves only 32 available for
> GPIO expanders or other drivers, like PMIC. Hence, bump the
> maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2 resend: actually added Rafael and linux-acpi@ to Cc list
> v2: dropped confusing comment and help, simplified defaults (Rafael)
>     added Rb tag (Linus)
>  arch/x86/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 858ce2736bd6..25960fe242bd 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -338,6 +338,11 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
>  config ARCH_HIBERNATION_POSSIBLE
>         def_bool y
>
> +config ARCH_NR_GPIO
> +       int
> +       default 1024 if X86_64
> +       default 512
> +
>  config ARCH_SUSPEND_POSSIBLE
>         def_bool y
>
> --
> 2.32.0
>
