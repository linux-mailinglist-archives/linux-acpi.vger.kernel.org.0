Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35ABC387543
	for <lists+linux-acpi@lfdr.de>; Tue, 18 May 2021 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhERJiN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 May 2021 05:38:13 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40656 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbhERJiN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2021 05:38:13 -0400
Received: by mail-ot1-f47.google.com with SMTP id s5-20020a05683004c5b029032307304915so824739otd.7;
        Tue, 18 May 2021 02:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wiSdxiIHc/KDsEYwF5pXotRSQUfD4ZGdNaPicsgTKMU=;
        b=hxWdH+7iEHi1IGysDBv1d7hVWsml/KpWAHuwTsc3syJM73jE0Vg94VYq03ywJCdMvp
         g7Q/8ZpgBnVWY39S+aTVyBHR7prbRRaxylfKw+3iKaOiiuNPXmS2ekkG8nxXul19wfIQ
         abxXf0AHjT0B5uxbzcgoMN/GVTmM0xMNIUmCBVJgx49Ui5ejnwev/0MKJstmnwXjMmXF
         6b+mUtUxtN0AkA1b5dYwCdvw8lbLhlw3sm4wXjdtyI8o8RZ2cvR11gOVH6mGvxak5ZMi
         VPb0Rul/ysFpKmNQYHNgrvDvTRazyY8vX0HimUFxoeRtD4VJvGERffIwG3ip6Aqkf8CK
         m/Vg==
X-Gm-Message-State: AOAM531uV95H0n+BBKz4ql5bq+YaL3tR0HLwmih99tX5v7xjGmL4cbtd
        HPxSkOROt4+XIrFDgBoypP2V04yPgHQeeG+qVcs=
X-Google-Smtp-Source: ABdhPJwsaI+dWDUzbN7bYVAavvxBEqOU3b77j27rmXFBZTLX2a2oEespYLMhLV+qYSB8IfI1MAGjtApa7v4X4StQAec=
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr3655017otc.206.1621330614331;
 Tue, 18 May 2021 02:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210518034119.2116555-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20210518034119.2116555-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 May 2021 11:36:42 +0200
Message-ID: <CAJZ5v0ivv9ouf065aYyLqN_JtjR5vomUumAQtGHPunze0BdUmQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: DPTF: Add new PCH FIVR methods
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 18, 2021 at 5:42 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Some additional information is required for updating PCH FIVR values
> upon WiFi channel changes.
>
> New attributes added to the existing sysfs:
> fivr_switching_freq_mhz : Get the FIVR switching control frequency
>                           using ACPI method GFCS. Refer to the
>                           documentation for the equation.
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
> v2
>         Update documentation for fivr_switching_freq_mhz
>
>  Documentation/ABI/testing/sysfs-platform-dptf | 42 +++++++++++++++++++
>  drivers/acpi/dptf/dptf_pch_fivr.c             |  9 ++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-platform-dptf b/Documentation/ABI/testing/sysfs-platform-dptf
> index 141834342a4d..fe62f024eb93 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dptf
> +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> @@ -111,3 +111,45 @@ Contact:   linux-acpi@vger.kernel.org
>  Description:
>                 (RW) The PCH FIVR (Fully Integrated Voltage Regulator) switching frequency in MHz,
>                 when FIVR clock is 38.4MHz.
> +
> +What:          /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fivr_switching_freq_mhz
> +Date:          June, 2021
> +KernelVersion: v5.14
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               (RO) Get the FIVR switching control frequency in MHz after applying equation
> +               "fivr_switching_freq_mhz * XTAL_FREQ / 128". Here XTAL_FREQ is Crystal Oscillator frequency
> +               in MHz, which is product specific.

IMO it would be sufficient to say the following here:

+               (RO) PCH FIVR switching control frequency in the units
of XTAL_FREQ / 128,
+               where XTAL_FREQ is the Crystal Oscillator frequency
(product specific).

This means that it needs to be multiplied by XTAL_FREQ / 128 to get
the frequency in the whatever units XTAL_FREQ is expressed.

I can make this change when applying the patch.

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
