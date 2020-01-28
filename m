Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF62E14C32A
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 23:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1Wwx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 17:52:53 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40394 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgA1Www (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jan 2020 17:52:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so10492963oii.7
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jan 2020 14:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxVHgOSnmMGgW8uL1BJ/P+dMNaJRboMeN5GXKdzVv4A=;
        b=cmLNBjkqeBt+iRZP7QjTip3DF30zlEoUfw2pheGk/vyDnXH0zWlT4paoQdhdA7Zh4i
         281Nh2A3KludfoSASxcyEVUB2dknGIUS0A/IlAluWTKThzFnTIpfpy3pcxB5oHZFprnq
         ZiNPorHzSy7YJxufMIjA1tGkmSkfhxzvU9ZdGBfsMFRzedTRMKtBstd00MQhUE8XpzIh
         jqi0QHXspEqgrAeabZcoRgPqzwi8eMLmwFtZGZ6QODamfD66R3CFDiiVfk4JaywrDQsV
         8PdVlvE4kCMcxqI9BhC+IVwyVlcAfuUWsLJ4/YlrClyBdXm7sR0I9Ss1wpPvLNdeLQwx
         sqeg==
X-Gm-Message-State: APjAAAWGDlhUXQ2ArBqaETy2iW1tPiwG8M1dHw0iBtWMJfO8ZcCbWLvW
        b2aSE5dPAxurRVGQgSJr0+EWFPTYH4hJzncu/T9upw==
X-Google-Smtp-Source: APXvYqxvYXO/MZWUvnoFelQ+P71/MsLvtZ+lzK9EeHZb8e2OB6U7pxyShvpwtJvZAznv06UDGKIZ1P7Rt02PWU+Nu3U=
X-Received: by 2002:a05:6808:1c5:: with SMTP id x5mr4628604oic.57.1580251971923;
 Tue, 28 Jan 2020 14:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20200128151641.37132-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200128151641.37132-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Jan 2020 23:52:40 +0100
Message-ID: <CAJZ5v0jVrJeMPUG3m_uk3ey4JYysw9RvXDRLx4J+TwpGa5Y4nA@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: Sort entries in database for ACPI
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 28, 2020 at 4:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Run parse-maintainers.pl and choose ACPI records. Fix them accordingly.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  MAINTAINERS | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f04b1c6508fe..ddfbddd95744 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -317,30 +317,30 @@ ACPI
>  M:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:     Len Brown <lenb@kernel.org>
>  L:     linux-acpi@vger.kernel.org
> +S:     Supported
>  W:     https://01.org/linux-acpi
> -Q:     https://patchwork.kernel.org/project/linux-acpi/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> +Q:     https://patchwork.kernel.org/project/linux-acpi/list/
>  B:     https://bugzilla.kernel.org
> -S:     Supported
> +F:     Documentation/ABI/testing/configfs-acpi
> +F:     Documentation/ABI/testing/sysfs-bus-acpi
> +F:     Documentation/firmware-guide/acpi/
>  F:     drivers/acpi/
> +F:     drivers/pci/*/*acpi*
> +F:     drivers/pci/*acpi*
>  F:     drivers/pnp/pnpacpi/
> +F:     include/acpi/
>  F:     include/linux/acpi.h
>  F:     include/linux/fwnode.h
> -F:     include/acpi/
> -F:     Documentation/firmware-guide/acpi/
> -F:     Documentation/ABI/testing/sysfs-bus-acpi
> -F:     Documentation/ABI/testing/configfs-acpi
> -F:     drivers/pci/*acpi*
> -F:     drivers/pci/*/*acpi*
>  F:     tools/power/acpi/
>
>  ACPI APEI
>  M:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
>  M:     Len Brown <lenb@kernel.org>
> -L:     linux-acpi@vger.kernel.org
>  R:     James Morse <james.morse@arm.com>
>  R:     Tony Luck <tony.luck@intel.com>
>  R:     Borislav Petkov <bp@alien8.de>
> +L:     linux-acpi@vger.kernel.org
>  F:     drivers/acpi/apei/
>
>  ACPI COMPONENT ARCHITECTURE (ACPICA)
> @@ -363,9 +363,9 @@ F:  tools/power/acpi/
>  ACPI FAN DRIVER
>  M:     Zhang Rui <rui.zhang@intel.com>
>  L:     linux-acpi@vger.kernel.org
> +S:     Supported
>  W:     https://01.org/linux-acpi
>  B:     https://bugzilla.kernel.org
> -S:     Supported
>  F:     drivers/acpi/fan.c
>
>  ACPI FOR ARM64 (ACPI/arm64)
> @@ -389,26 +389,26 @@ M:        Len Brown <lenb@kernel.org>
>  R:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>  R:     Mika Westerberg <mika.westerberg@linux.intel.com>
>  L:     linux-acpi@vger.kernel.org
> -Q:     https://patchwork.kernel.org/project/linux-acpi/list/
> +S:     Supported
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> +Q:     https://patchwork.kernel.org/project/linux-acpi/list/
>  B:     https://bugzilla.kernel.org
> -S:     Supported
>  F:     drivers/acpi/pmic/
>
>  ACPI THERMAL DRIVER
>  M:     Zhang Rui <rui.zhang@intel.com>
>  L:     linux-acpi@vger.kernel.org
> +S:     Supported
>  W:     https://01.org/linux-acpi
>  B:     https://bugzilla.kernel.org
> -S:     Supported
>  F:     drivers/acpi/*thermal*
>
>  ACPI VIDEO DRIVER
>  M:     Zhang Rui <rui.zhang@intel.com>
>  L:     linux-acpi@vger.kernel.org
> +S:     Supported
>  W:     https://01.org/linux-acpi
>  B:     https://bugzilla.kernel.org
> -S:     Supported
>  F:     drivers/acpi/acpi_video.c
>
>  ACPI WMI DRIVER
> @@ -13353,11 +13353,6 @@ T:     git git://github.com/intel/pm-graph
>  S:     Supported
>  F:     tools/power/pm-graph
>
> -PNP SUPPORT
> -M:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> -S:     Maintained
> -F:     drivers/pnp/
> -
>  PNI RM3100 IIO DRIVER
>  M:     Song Qiang <songqiang1304521@gmail.com>
>  L:     linux-iio@vger.kernel.org
> @@ -13365,6 +13360,11 @@ S:     Maintained
>  F:     drivers/iio/magnetometer/rm3100*
>  F:     Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
>
> +PNP SUPPORT
> +M:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> +S:     Maintained
> +F:     drivers/pnp/
> +
>  POSIX CLOCKS and TIMERS
>  M:     Thomas Gleixner <tglx@linutronix.de>
>  L:     linux-kernel@vger.kernel.org
> --

Applied as 5.6 material along with the other 2 ACPI-related
MAINTAINERS updates, thanks!

But in the future please send such things in a series for easier handling.
