Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEACD3835AD
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbhEQPYC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 11:24:02 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:37887 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244770AbhEQPV7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 11:21:59 -0400
Received: by mail-oi1-f178.google.com with SMTP id h9so6823951oih.4;
        Mon, 17 May 2021 08:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsCh9hnGFpI5LULisI061lzPq1P28S3OVYboXFBHqPs=;
        b=lmPo5cNbBWLfvqI08nRboImYLOPH1/QVRXfVhObxO6kPA5iHPLsV3mCbUTTz7k89mC
         uSScpg+IsMAwdWBmv8qG3++GG5mEhFnqh+FqlYV0727e3mBbhZmsnxxFR1kdksV2exmR
         57EQFquiCgE10Zn12UeDrlhVp4YGe1FeYP8PPgwEAXtJDqiU7U9b5Xuqi7irbLWcpqZU
         lSHf2IBVetNmIGdqP4M+fp8b6CdETQTqJMjI9vkBz29XCMLXYbgzDyFA3aurA7R5eiq+
         thmqakSHfwu7/gd9A1p+h/qfEGby0gX/qNWI5V3v3dkg/CThgEVPapIh3InDA2Gxhx5y
         P8Lg==
X-Gm-Message-State: AOAM5314c30HG4ojf+oioj/VEB84NuRYKfcIxbzKw+T5xeMo2WIXzj3r
        1Q4sQCWYBeE9YCkKlEhJRA87WnWZbFlfZ2aD+nI=
X-Google-Smtp-Source: ABdhPJx95ZuEX1MSiENWvUc/Jrupe4j2786iPzP4lH2YXFh/IIaSqTWwfdKFvJL97MGlKzk/m/iA2Bq2Ygu5xexgAa0=
X-Received: by 2002:aca:4ec5:: with SMTP id c188mr218963oib.69.1621264842520;
 Mon, 17 May 2021 08:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210517055356.1918418-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210517055356.1918418-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 17:20:31 +0200
Message-ID: <CAJZ5v0gqW6Gn4CN7-V_F_yE+k9qBgEgBhAHSHrWF5p1ZAHbS7A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Add new PCH FIVR methods
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 17, 2021 at 7:54 AM Srinivas Pandruvada
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

I was about to apply this, but one question.

AFAICS the "show" function will simply evaluate GFCS and preset the
returned value to the reader of the attribute, but the documentation
says that this is the switching control frequency in MHz which doesn't
seem to be consistent with the above information.

Is the reader of the attribute required to know the XTAL frequency and
apply the above formula to the value read from it?  If so, the
documentation should be clear about this.

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
>  Documentation/ABI/testing/sysfs-platform-dptf | 40 +++++++++++++++++++
>  drivers/acpi/dptf/dptf_pch_fivr.c             |  9 +++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> index 141834342a4d..f0c43711ad4f 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -111,3 +111,43 @@ Contact:   linux-acpi@vger.kernel.org
>  Description:
>                 (RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
>                 when FIVR clock is 38.4MHz.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_freq_mhz
> +Date:          June, 2021
> +KernelVersion: v5.14
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Get the FIVR switching control frequency in MHz.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_fault_status
> +Date:          June, 2021
> +KernelVersion: v5.14
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Read the FIVR switching frequency control fault status.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/ssc_clock_info
> +Date:          June, 2021
> +KernelVersion: v5.14
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
> index 5fca18296bf6..22c4ae0401ef 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -55,15 +55,24 @@ static ssize_t name##_store(struct device *dev,\
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
> 2.27.0
>
