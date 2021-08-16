Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1ED3ED71B
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbhHPN20 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 09:28:26 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44665 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239730AbhHPN0L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 09:26:11 -0400
Received: by mail-oi1-f172.google.com with SMTP id w6so26557669oiv.11;
        Mon, 16 Aug 2021 06:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5c7NrJnc/EOfC/Guj+mn9lM24GWOzDz1YPq6J1jUCs=;
        b=Y7r+ZQASf9h5Ew8yNyyA+AK+g5vclBpx5mYVFcQojFdpyDRLfNpUoDhsEckRSJcwA1
         7NV77qR6iHyYiHZIgwhxM9lv931wcqmRoplkSDJfr6E1SGMc39sJd4ELbvti3Joo1RY4
         JShlLIvdukrSalMpWODcqBBa5nXWa70jSIRkhW4RXJReImxsv+Y8E5efglsjVKkC/zyJ
         MGK8s5PStd/g/RxYCtIQpbq5FS1N8S7b1J1DTabEjE4o3TXgiF6Ok3u4v0+YW6yR+Qvo
         lCcQ7K0oUE7ddunOyJCuSiwzdMRDmDsHYPgTC2HQcplhnbqATibwKdQXd20Jn7ElI2Jj
         f2eQ==
X-Gm-Message-State: AOAM532xVl3u92yAT/lCAjJzlbQCCnDQN1u7peXi3Nmh+z0Hc7iAjZFE
        eIguiKoFPERuoos3pa/nm0R6OsUMhYXZ2WZbgEQ=
X-Google-Smtp-Source: ABdhPJwITzJcjr/JI8T5acwh8HivYH/gUgl1GrR2IdN/wx/R5aFS/0YguIJCb6TZJgEhVcKT7CRhNmpbDfIICZ43feo=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr922398ois.69.1629120339700;
 Mon, 16 Aug 2021 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 15:25:13 +0200
Message-ID: <CAJZ5v0iTNwQfh6ZZxry16hOjokGOOSZthq6C_yed07a2HQ7h2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/platform: Increase maximum GPIO number for X86_64
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Aug 6, 2021 at 4:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> By default the 512 GPIOs is a maximum on any x86 platform.
> With, for example, Intel Tiger Lake-H the SoC based controller
> occupies up to 480 pins. This leaves only 32 available for
> GPIO expanders or other drivers, like PMIC. Hence, bump the
> maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/Kconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 45962aaf2b2c..495ed6229b52 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -340,6 +340,19 @@ config NEED_PER_CPU_PAGE_FIRST_CHUNK
>  config ARCH_HIBERNATION_POSSIBLE
>         def_bool y
>
> +# The GPIO number here must be sorted by descending number. In case of
> +# a multiplatform kernel, we just want the highest value required by the
> +# selected platforms.
> +config ARCH_NR_GPIO
> +       int
> +       default 1024 if X86_64
> +       default 512 if X86_32
> +       default 0

Wouldn't

default 1024 if X86_64
default 512

be sufficient?

It's either X86_64 or X86_32 anyway AFAICS.

> +       help
> +         Maximum number of GPIOs in the system.
> +
> +         If unsure, leave the default value.
> +
>  config ARCH_SUSPEND_POSSIBLE
>         def_bool y
>
> --
