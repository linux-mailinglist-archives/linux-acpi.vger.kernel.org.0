Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8F3AB29D
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhFQLd5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 07:33:57 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33319 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbhFQLd5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 07:33:57 -0400
Received: by mail-ot1-f42.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5839712otl.0;
        Thu, 17 Jun 2021 04:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZHgz9IMrpOx0nKkCe7ZpuGho0X1kRLWuMLpWJvltF4=;
        b=aEC/STHflbRdvyKrmvuP6LCBZU+wLveCPV6hwMN8zrJ+VQIGGGsZ+TVtEjr66WD4P8
         oMXnSl5Vi9S+qzE+5oRRtitnvrmD4Y28e6c49maL3W5OhMvd7F6Y019ECp1hLxuLbSae
         lpVTltQwIrxAut9gnOf8YLvj51cpO+P1Di1OjnOyC6TiXVoJkj0Ynt/suEEGImUg4GQW
         FMC5RaGxrN3xJpLD9BRFir6qgm4D8/oTNydCIHnCBFYIB0yt1RPz5h850mW+465a32Lg
         hWoq62tyQBkoKG9cJXR8VXfZvFt2NPXHPJxaMRRzy4QCFZ7N3fIhGGH0+elGn+OsKPw5
         2MEQ==
X-Gm-Message-State: AOAM531vENSAwvyzTCDPHOLMuDzHG/0t3kB3k8A/guUVdS2dUHs9rOuv
        wd8pyZS8Uis1gK7HweYs44TKSnqVwDwgCNsgr28=
X-Google-Smtp-Source: ABdhPJwTfCN5ISSxBFZxnhO9LJcdrU6FacDkqlcIyE9q/LixdZJpZH8o9y4Mwpf7qBpcw9m0DuGwR0Z7WLEK0rOH9SI=
X-Received: by 2002:a05:6830:1bf7:: with SMTP id k23mr4312197otb.206.1623929509428;
 Thu, 17 Jun 2021 04:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210616195239.1627552-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210616195239.1627552-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 13:31:38 +0200
Message-ID: <CAJZ5v0h2kG5QAbDDkpypiznNYsb3GwdH3NMn12=7PCiiJEfdVg@mail.gmail.com>
Subject: Re: [PATCH -next] Revert "ACPI: DPTF: Add new PCH FIVR methods"
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 16, 2021 at 9:52 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> This reverts commit bab858b30cbe5619038dd68ab89be469fff9861e.
>
> Some user reported issues with this change. Will resubmit for 5.15 cycle.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

I've dropped this commit completely, as it was the top-most one in the
DPTF branch.

Thanks!

> ---
>  Documentation/ABI/testing/sysfs-platform-dptf | 42 -------------------
>  drivers/acpi/dptf/dptf_pch_fivr.c             |  9 ----
>  2 files changed, 51 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> index bce1b745fc56..141834342a4d 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -111,45 +111,3 @@ Contact:   linux-acpi@vger.kernel.org
>  Description:
>                 (RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
>                 when FIVR clock is 38.4MHz.
> -
> -What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_freq_mhz
> -Date:          June, 2021
> -KernelVersion: v5.14
> -Contact:       linux-acpi@vger.kernel.org
> -Description:
> -               (RO) PCH FIVR switching control frequency in the units of
> -               XTAL_FREQ / 128, where XTAL_FREQ is the (product specific)
> -               Crystal Oscillator frequency.
> -
> -What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_fault_status
> -Date:          June, 2021
> -KernelVersion: v5.14
> -Contact:       linux-acpi@vger.kernel.org
> -Description:
> -               (RO) Read the FIVR switching frequency control fault status.
> -
> -What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/ssc_clock_info
> -Date:          June, 2021
> -KernelVersion: v5.14
> -Contact:       linux-acpi@vger.kernel.org
> -Description:
> -               (RO) Presents SSC (spread spectrum clock) information for EMI
> -               (Electro magnetic interference) control. This is a bit mask.
> -               Bits    Description
> -               [7:0]   Sets clock spectrum spread percentage:
> -                       0x00=0.2% , 0x3F=10%
> -                       1 LSB = 0.1% increase in spread (for
> -                       settings 0x01 thru 0x1C)
> -                       1 LSB = 0.2% increase in spread (for
> -                       settings 0x1E thru 0x3F)
> -               [8]     When set to 1, enables spread
> -                       spectrum clock
> -               [9]     0: Triangle mode. FFC frequency
> -                       walks around the Fcenter in a linear
> -                       fashion
> -                       1: Random walk mode. FFC frequency
> -                       changes randomly within the SSC
> -                       (Spread spectrum clock) range
> -               [10]    0: No white noise. 1: Add white noise
> -                       to spread waveform
> -               [11]    When 1, future writes are ignored.
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
> index 22c4ae0401ef..5fca18296bf6 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -55,24 +55,15 @@ static ssize_t name##_store(struct device *dev,\
>
>  PCH_FIVR_SHOW(freq_mhz_low_clock, GFC0)
>  PCH_FIVR_SHOW(freq_mhz_high_clock, GFC1)
> -PCH_FIVR_SHOW(ssc_clock_info, GEMI)
> -PCH_FIVR_SHOW(fivr_switching_freq_mhz, GFCS)
> -PCH_FIVR_SHOW(fivr_switching_fault_status, GFFS)
>  PCH_FIVR_STORE(freq_mhz_low_clock, RFC0)
>  PCH_FIVR_STORE(freq_mhz_high_clock, RFC1)
>
>  static DEVICE_ATTR_RW(freq_mhz_low_clock);
>  static DEVICE_ATTR_RW(freq_mhz_high_clock);
> -static DEVICE_ATTR_RO(ssc_clock_info);
> -static DEVICE_ATTR_RO(fivr_switching_freq_mhz);
> -static DEVICE_ATTR_RO(fivr_switching_fault_status);
>
>  static struct attribute *fivr_attrs[] = {
>         &dev_attr_freq_mhz_low_clock.attr,
>         &dev_attr_freq_mhz_high_clock.attr,
> -       &dev_attr_ssc_clock_info.attr,
> -       &dev_attr_fivr_switching_freq_mhz.attr,
> -       &dev_attr_fivr_switching_fault_status.attr,
>         NULL
>  };
>
> --
> 2.30.2
>
