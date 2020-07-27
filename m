Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74822EBCF
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jul 2020 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgG0MNk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jul 2020 08:13:40 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33767 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgG0MNk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2020 08:13:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id h13so12158814otr.0;
        Mon, 27 Jul 2020 05:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hya4kAak3vFpvKCmV5SC8CvzY7BVaQgU/URNmp9BcZ4=;
        b=agyhTbqbD+9UsE2Pu5yqvuJFxgtsgAol0B7zz+fP+pskeI6PBsvWrWkqt+SL786snp
         nCs3pREkeg7xSVDrMbGtQMVeJYjgiYUTVv9CxPrZjJTw3SXDY04kIbLMKRC4YVTM3VrN
         n8oF3KvKxehB2sc564NCCg+jy4kG0rzM8/LSmLkpc3ubfz5JvgGLcyo1/QGDYDBNQtCY
         +eabp9XAnz+gHEceH7s4GwFfRjHGBNNKSnHCZOIjWRphMXrvDnlfxOSuwqHM3ZeRRt2n
         YSkXXLvFttU98TBUXiOkdgwdUK3W2KKlUmroacmILkVrgm8fq/1a6kBtwpmoLYeIx+jf
         8CLA==
X-Gm-Message-State: AOAM531d+k9e0E3ro12JjnGqh/5zALldDWOZ7lFkHO50PtDtohtOZnvW
        szvt5eJOrbTQAg/OH22LG1kYiMHb0s4KVD3s3HQ=
X-Google-Smtp-Source: ABdhPJzWgH9YnsibmP7ohIsPdvbdnPiVh5mOEocRs7asL1OJ+94TWqFP8dqKQVa7Ps7h8bt7rVUk3udHV1/hD+86g5o=
X-Received: by 2002:a9d:306:: with SMTP id 6mr10255308otv.167.1595852019197;
 Mon, 27 Jul 2020 05:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <1595842178-20351-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1595842178-20351-1-git-send-email-yangtiezhu@loongson.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 14:13:10 +0200
Message-ID: <CAJZ5v0iJM_Q0D2Um7upMzkww0kL0FjH3udZPXaORY-dv5MDpLQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Use valid link of ACPI specification
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Ning Sun <ning.sun@intel.com>,
        Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>, linux-hwmon@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        tboot-devel@lists.sourceforge.net,
        Linux PM <linux-pm@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 27, 2020 at 11:30 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> Currently, acpi.info is an invalid link to access ACPI specification,
> the new valid link is https://uefi.org/specifications.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  Documentation/hwmon/acpi_power_meter.rst      | 2 +-
>  drivers/acpi/Kconfig                          | 3 +--
>  include/linux/tboot.h                         | 2 +-
>  tools/power/cpupower/man/cpupower-idle-info.1 | 2 +-
>  4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/hwmon/acpi_power_meter.rst b/Documentation/hwmon/acpi_power_meter.rst
> index 4a0941a..8628c11 100644
> --- a/Documentation/hwmon/acpi_power_meter.rst
> +++ b/Documentation/hwmon/acpi_power_meter.rst
> @@ -9,7 +9,7 @@ Supported systems:
>
>      Prefix: 'power_meter'
>
> -    Datasheet: http://acpi.info/, section 10.4.
> +    Datasheet: https://uefi.org/specifications, section 10.4.
>
>  Author: Darrick J. Wong
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ce2730d..7428cd2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -40,8 +40,7 @@ menuconfig ACPI
>           the UEFI Forum and any UEFI member can join the ASWG and contribute
>           to the ACPI specification.
>           The specification is available at:
> -         <http://www.acpi.info>
> -         <http://www.uefi.org/acpi/specs>
> +         <https://uefi.org/specifications>
>
>  if ACPI
>
> diff --git a/include/linux/tboot.h b/include/linux/tboot.h
> index c7e4247..5146d25 100644
> --- a/include/linux/tboot.h
> +++ b/include/linux/tboot.h
> @@ -44,7 +44,7 @@ struct tboot_acpi_generic_address {
>
>  /*
>   * combines Sx info from FADT and FACS tables per ACPI 2.0+ spec
> - * (http://www.acpi.info/)
> + * (https://uefi.org/specifications)
>   */
>  struct tboot_acpi_sleep_info {
>         struct tboot_acpi_generic_address pm1a_cnt_blk;
> diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
> index 80a1311..20b6345 100644
> --- a/tools/power/cpupower/man/cpupower-idle-info.1
> +++ b/tools/power/cpupower/man/cpupower-idle-info.1
> @@ -75,7 +75,7 @@ By default only values of core zero are displayed. How to display settings of
>  other cores is described in the cpupower(1) manpage in the \-\-cpu option
>  section.
>  .SH REFERENCES
> -http://www.acpi.info/spec.htm
> +https://uefi.org/specifications
>  .SH "FILES"
>  .nf
>  \fI/sys/devices/system/cpu/cpu*/cpuidle/state*\fP
> --

Applied as 5.9 material with a minor edit in the subject.

However, in the future please always CC ACPI-related patches to the
linux-acpi mailing list.

Thanks!
