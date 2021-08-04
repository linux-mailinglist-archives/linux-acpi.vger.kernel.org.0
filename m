Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7CC3E058A
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Aug 2021 18:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhHDQNA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Aug 2021 12:13:00 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41595 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbhHDQLB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2021 12:11:01 -0400
Received: by mail-ot1-f52.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so2091482otu.8;
        Wed, 04 Aug 2021 09:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7AhsKkNeKlxrKLwf2lu2/fTBaaXeyW71BjLC2HOaC0=;
        b=alAtC4M+Z52chE45rzgGlO/bcoAKwybF12SsbvKCMEQ3RMZBESP1VYLgiS2IAwvfIc
         DvxizqfgEq+5+onlmsHfycwJfRyUAgOXFnF/V/Qi43PfLJHCt53xx0wM7rv/uA/aWUXC
         jvqhfK3pnzvKcP+sYxHwH0MnEtUL8M+heu+W8tc6fiY3N3roaDuIDy/WOD65nXcvkcA2
         3eBvIvc7MWkL2SxMwHXp5fwRtuMX5VwL8kpM6eH245wOots9wbOye8EI+yY0zYJwyTqK
         Zf/kNfQbDLTSe0RFZWxcWH/DkpWGwMsm2mXFExFctf6cyz03uyeC3uYGQSGdqnGy1ber
         28lA==
X-Gm-Message-State: AOAM533CmDhdD+LvUY5YI6LGfUL5eR9C7/rmn+jOtgcjEPV08RbyjG2i
        +DhjecJcAy5Icnzx4xc5yiiaNv2c1aSc8DPHTho=
X-Google-Smtp-Source: ABdhPJzDztXuMiJLwFF+T1k/SeyM/HS9BfZy3kmkWHSLJgoCZpcTxciDIGVe3smRjud0UOpDf1J30ojxeA2yxG1G+Ww=
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr373353oto.260.1628093447493;
 Wed, 04 Aug 2021 09:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210727162240.425773-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210727162240.425773-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 18:10:36 +0200
Message-ID: <CAJZ5v0gPwEdJt1xjePg97eAxYpb8j5yTGUBNvQyJcHoqHK-MpA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Add new PCH FIVR methods
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 27, 2021 at 6:22 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Some additional information is required for updating PCH FIVR values
> upon WiFi channel changes.
>
> New attributes added to the existing sysfs:
> fivr_switching_freq_mhz : Get the FIVR switching control frequency.
>                           Uses ACPI method GFCS
> fivr_switching_fault_status: Read the FIVR switching frequency control
>                         fault status. Uses ACPI method GFFS
>
> ssc_clock_info : Presents SSC (spread spectrum clock) information for EMI
> (Electro magnetic interference) control. Use ACPI method GEMI. Refer
> to the description of GEMI method below.
>
> GFFS
> This ACPI method is used to read the FIVR switching frequency control
> fault status.
> Bits    Description
> [0:0]   Fault status when set to 1
> [31:1]  Reserved
>
> GFCS
> This ACPI method is used to read the FIVR switching control
> frequency.
> Bits    Description
> [11:0]  Actual Frequency = value * XTAL_FREQ / 128
> [31:12] Reserved
>
> GEMI
> This ACPI method is used to read the programmed register value for EMI
> (Electro magnetic interference) control.
>
> Bits    Description
> [7:0]   Sets clock spectrum spread percentage:
>         0x00=0.2% , 0x3F=10%
>         1 LSB = 0.1% increase in spread (for
>         settings 0x01 thru 0x1C)
>         1 LSB = 0.2% increase in spread (for
>         settings 0x1E thru 0x3F)
> [8]     When set to 1, enables spread
>         spectrum clock
> [9]     0: Triangle mode. FFC frequency
>         walks around the Fcenter in a linear
>         fashion
>         1: Random walk mode. FFC frequency
>         changes randomly within the SSC
>         (Spread spectrum clock) range
> [10]    0: No white noise. 1: Add white noise
>         to spread waveform
> [11]    When 1, future writes are ignored.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> This commit was merged to 5.14 next tree, but later reverted. The
> problem was not in this commit but reading attributes in general. This
> is fixed by prior patch "ACPI: DPTF: Fix reading of attributes"

Now applied as 5.15 material, thanks!

>  Documentation/ABI/testing/sysfs-platform-dptf | 40 +++++++++++++++++++
>  drivers/acpi/dptf/dptf_pch_fivr.c             |  9 +++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> index 141834342a4d..53c6b1000320 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -111,3 +111,43 @@ Contact:   linux-acpi@vger.kernel.org
>  Description:
>                 (RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
>                 when FIVR clock is 38.4MHz.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_freq_mhz
> +Date:          September, 2021
> +KernelVersion: v5.15
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Get the FIVR switching control frequency in MHz.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_fault_status
> +Date:          September, 2021
> +KernelVersion: v5.15
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Read the FIVR switching frequency control fault status.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/ssc_clock_info
> +Date:          September, 2021
> +KernelVersion: v5.15
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Presents SSC (spread spectrum clock) information for EMI
> +               (Electro magnetic interference) control. This is a bit mask.
> +               Bits    Description
> +               [7:0]   Sets clock spectrum spread percentage:
> +                       0x00=0.2% , 0x3F=10%
> +                       1 LSB = 0.1% increase in spread (for
> +                       settings 0x01 thru 0x1C)
> +                       1 LSB = 0.2% increase in spread (for
> +                       settings 0x1E thru 0x3F)
> +               [8]     When set to 1, enables spread
> +                       spectrum clock
> +               [9]     0: Triangle mode. FFC frequency
> +                       walks around the Fcenter in a linear
> +                       fashion
> +                       1: Random walk mode. FFC frequency
> +                       changes randomly within the SSC
> +                       (Spread spectrum clock) range
> +               [10]    0: No white noise. 1: Add white noise
> +                       to spread waveform
> +               [11]    When 1, future writes are ignored.
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
> index 550b9081fcbc..f4e9c2ef2f88 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -90,15 +90,24 @@ static ssize_t name##_store(struct device *dev,\
>
>  PCH_FIVR_SHOW(freq_mhz_low_clock, GFC0)
>  PCH_FIVR_SHOW(freq_mhz_high_clock, GFC1)
> +PCH_FIVR_SHOW(ssc_clock_info, GEMI)
> +PCH_FIVR_SHOW(fivr_switching_freq_mhz, GFCS)
> +PCH_FIVR_SHOW(fivr_switching_fault_status, GFFS)
>  PCH_FIVR_STORE(freq_mhz_low_clock, RFC0)
>  PCH_FIVR_STORE(freq_mhz_high_clock, RFC1)
>
>  static DEVICE_ATTR_RW(freq_mhz_low_clock);
>  static DEVICE_ATTR_RW(freq_mhz_high_clock);
> +static DEVICE_ATTR_RO(ssc_clock_info);
> +static DEVICE_ATTR_RO(fivr_switching_freq_mhz);
> +static DEVICE_ATTR_RO(fivr_switching_fault_status);
>
>  static struct attribute *fivr_attrs[] = {
>         &dev_attr_freq_mhz_low_clock.attr,
>         &dev_attr_freq_mhz_high_clock.attr,
> +       &dev_attr_ssc_clock_info.attr,
> +       &dev_attr_fivr_switching_freq_mhz.attr,
> +       &dev_attr_fivr_switching_fault_status.attr,
>         NULL
>  };
>
> --
> 2.31.1
>
