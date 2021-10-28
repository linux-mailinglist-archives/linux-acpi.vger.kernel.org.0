Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0910743DE48
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Oct 2021 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhJ1KCD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Oct 2021 06:02:03 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34682 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhJ1KB6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Oct 2021 06:01:58 -0400
Received: by mail-ot1-f47.google.com with SMTP id t17-20020a056830083100b00553ced10177so7617839ots.1;
        Thu, 28 Oct 2021 02:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YApfc+rtORQHprN7aKpnZNhl8TPl/VtOJQI8beQJmCY=;
        b=ZISI/TqYdNfu8bZIXT5RgeyOfBmGr0yaEHq3Lee1O1i0DfKvqoibZzZzq0OWZ6IPNS
         0HRJ9hu5TnXyshbdh4/4P1ZKND3MtQnb2KkOH4irWfXWORRALOa3EIyITdnA/fgQ/fjH
         WCKr/uY1dRce5u5wrJ8U5/I19GIq+hkOo9wzt+0ipl79AOjuKXQuuPkAtn4NhW4riTm0
         yBRqb18GtYUh8SLkJsK4mEJru3Up8assYiSmt/H+I+MO3TfMvAKZgRBVdRZb2d8D7Pr4
         r8OuqYoOuNY1m+DiiJkUUjcx6Bfk6Y3sxnXELU0g1Q9PBaYTYaB5JM+7Eo95TEn4cWXL
         DZvg==
X-Gm-Message-State: AOAM532ufq8H7lkzA/GvA9s/yy+W/QcGd8FcDkkQcGuJoF7g46LIettU
        xbMvrl0BdX9tnptHeAMgRe8wrFp8RgPc3VIeJlk=
X-Google-Smtp-Source: ABdhPJzD4cm7tn60vkyopY5CUMxUc9huwAUhS0IgxTyGcJq7Km0Bm+8fuUNsdZomFIBYzzQsRecVralPmU+TS+34zNY=
X-Received: by 2002:a9d:65c1:: with SMTP id z1mr2427957oth.198.1635415170827;
 Thu, 28 Oct 2021 02:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211027211715.12671-1-digetx@gmail.com> <20211027211715.12671-9-digetx@gmail.com>
In-Reply-To: <20211027211715.12671-9-digetx@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 11:59:18 +0200
Message-ID: <CAJZ5v0gpu2ezMhWr=grg6M8aWAx58DQozbXHoZaiPqUaZxJi4Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/45] kernel: Add combined power-off+restart handler
 call chain API
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 11:18 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> SoC platforms often have multiple options of how to perform system's
> power-off and restart operations. Meanwhile today's kernel is limited to
> a single option. Add combined power-off+restart handler call chain API,
> which is inspired by the restart API. The new API provides both power-off
> and restart functionality.
>
> The old pm_power_off method will be kept around till all users are
> converted to the new API.
>
> Current restart API will be replaced by the new unified API since
> new API is its superset. The restart functionality of the power-handler
> API is built upon the existing restart-notifier APIs.
>
> In order to ease conversion to the new API, convenient helpers are added
> for the common use-cases. They will reduce amount of boilerplate code and
> remove global variables. These helpers preserve old behaviour for cases
> where only one power-off handler is executed, this is what existing
> drivers want, and thus, they could be easily converted to the new API.
> Users of the new API should explicitly enable power-off chaining by
> setting corresponding flag of the power_handler structure.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/reboot.h   | 176 +++++++++++-
>  kernel/power/hibernate.c |   2 +-
>  kernel/reboot.c          | 601 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 768 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index b7fa25726323..0ec835338c27 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -8,10 +8,16 @@
>
>  struct device;
>
> -#define SYS_DOWN       0x0001  /* Notify of system down */
> -#define SYS_RESTART    SYS_DOWN
> -#define SYS_HALT       0x0002  /* Notify of system halt */
> -#define SYS_POWER_OFF  0x0003  /* Notify of system power off */
> +enum reboot_prepare_mode {
> +       SYS_DOWN = 1,           /* Notify of system down */
> +       SYS_RESTART = SYS_DOWN,
> +       SYS_HALT,               /* Notify of system halt */
> +       SYS_POWER_OFF,          /* Notify of system power off */
> +};
> +
> +#define RESTART_PRIO_RESERVED          0
> +#define RESTART_PRIO_DEFAULT           128
> +#define RESTART_PRIO_HIGH              192
>
>  enum reboot_mode {
>         REBOOT_UNDEFINED = -1,
> @@ -49,6 +55,167 @@ int register_restart_handler(struct notifier_block *);
>  int unregister_restart_handler(struct notifier_block *);
>  void do_kernel_restart(char *cmd);
>
> +/*
> + * Unified poweroff + restart API.
> + */
> +
> +#define POWEROFF_PRIO_RESERVED         0
> +#define POWEROFF_PRIO_PLATFORM         1
> +#define POWEROFF_PRIO_DEFAULT          128
> +#define POWEROFF_PRIO_HIGH             192
> +#define POWEROFF_PRIO_FIRMWARE         224

Also I'm wondering why these particular numbers were chosen, here and above?

> +
> +enum poweroff_mode {
> +       POWEROFF_NORMAL = 0,
> +       POWEROFF_PREPARE,
> +};
> +
> +struct power_off_data {
> +       void *cb_data;
> +};
> +
> +struct power_off_prep_data {
> +       void *cb_data;
> +};
> +
> +struct restart_data {
> +       void *cb_data;
> +       const char *cmd;
> +       enum reboot_mode mode;
> +};
> +
> +struct reboot_prep_data {
> +       void *cb_data;
> +       const char *cmd;
> +       enum reboot_prepare_mode mode;
> +};
> +
> +struct power_handler_private_data {
> +       struct notifier_block reboot_prep_nb;
> +       struct notifier_block power_off_nb;
> +       struct notifier_block restart_nb;
> +       void (*trivial_power_off_cb)(void);
> +       void (*simple_power_off_cb)(void *data);
> +       void *simple_power_off_cb_data;
> +       bool registered;
> +};
> +
> +/**
> + * struct power_handler - Machine power-off + restart handler
> + *
> + * Describes power-off and restart handlers which are invoked by kernel
> + * to power off or restart this machine.  Supports prioritized chaining for
> + * both restart and power-off handlers.  Callback's priority must be unique.
> + * Intended to be used by device drivers that are responsible for restarting
> + * and powering off hardware which kernel is running on.
> + *
> + * Struct power_handler can be static.  Members of this structure must not be
> + * altered while handler is registered.
> + *
> + * Fill the structure members and pass it to register_power_handler().
> + */
> +struct power_handler {
> +       /**
> +        * @cb_data:
> +        *
> +        * User data included in callback's argument.
> +        */

And here I would document the structure fields in the main kerneldoc
comment above.

As is, it is a bit hard to grasp the whole definition.

> +       void *cb_data;
> +
> +       /**
> +        * @power_off_cb:
> +        *
> +        * Callback that should turn off machine.  Inactive if NULL.
> +        */
> +       void (*power_off_cb)(struct power_off_data *data);
> +
> +       /**
> +        * @power_off_prepare_cb:
> +        *
> +        * Power-off preparation callback.  All power-off preparation callbacks
> +        * are invoked before @restart_cb.  Inactive if NULL.
> +        */
> +       void (*power_off_prepare_cb)(struct power_off_prep_data *data);
> +
> +       /**
> +        * @power_off_priority:
> +        *
> +        * Power-off callback priority, must be unique.  Zero value is
> +        * reassigned to default priority.  Inactive if @power_off_cb is NULL.
> +        */
> +       int power_off_priority;
> +
> +       /**
> +        * @power_off_chaining_allowed:
> +        *
> +        * False if callbacks execution should stop when @power_off_cb fails
> +        * to power off machine.  True if further lower priority power-off
> +        * callback should be executed.
> +        */
> +       bool power_off_chaining_allowed;
> +
> +       /**
> +        * @restart_cb:
> +        *
> +        * Callback that should reboot machine.  Inactive if NULL.
> +        */
> +       void (*restart_cb)(struct restart_data *data);
> +
> +       /**
> +        * @restart_priority:
> +        *
> +        * Restart callback priority, must be unique.  Zero value is reassigned
> +        * to default priority.  Inactive if @restart_cb is NULL.
> +        */
> +       int restart_priority;
> +
> +       /**
> +        * @reboot_prepare_cb:
> +        *
> +        * Reboot preparation callback.  All reboot preparation callbacks are
> +        * invoked before @restart_cb.  Inactive if NULL.
> +        */
> +       void (*reboot_prepare_cb)(struct reboot_prep_data *data);
> +
> +       /**
> +        * @priv:
> +        *
> +        * Internal data.  Shouldn't be touched.
> +        */
> +       const struct power_handler_private_data priv;
> +};
