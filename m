Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B7B3838C2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 18:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbhEQQAe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 12:00:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:40796 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346138AbhEQP6K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 May 2021 11:58:10 -0400
IronPort-SDR: BMA++xii8SwWkuPQgi3E2LmxOrBecr3H3QEcY3tnSY2syTEhgWwDedY4c6yahQ4O1snsmPqNoY
 2Hqg77LZJh5w==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="264409952"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="264409952"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 08:51:30 -0700
IronPort-SDR: dq2q+9+jFCNc1GGOtlyxbC0N52q2GurHuwma66S/ls+dO1hgr45Vtd0OpX9s29l7lPKBuXJZdO
 vIGrK/k76raA==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="410875570"
Received: from btamaklo-mobl.amr.corp.intel.com ([10.209.149.190])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 08:51:27 -0700
Message-ID: <fb8c82441abfbd0e1b8a1a1bff34be362f9b0ee9.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: DPTF: Add new PCH FIVR methods
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Date:   Mon, 17 May 2021 08:51:23 -0700
In-Reply-To: <CAJZ5v0gqW6Gn4CN7-V_F_yE+k9qBgEgBhAHSHrWF5p1ZAHbS7A@mail.gmail.com>
References: <20210517055356.1918418-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0gqW6Gn4CN7-V_F_yE+k9qBgEgBhAHSHrWF5p1ZAHbS7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-05-17 at 17:20 +0200, Rafael J. Wysocki wrote:
> On Mon, May 17, 2021 at 7:54 AM Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> > 
> > Some additional information is required for updating PCH FIVR
> > values
> > upon WiFi channel changes.
> > 
> > New attributes added to the existing sysfs:
> > fivr_switching_freq_mhz : Get the FIVR switching control frequency.
> >                           Uses ACPI method GFCS
> > fivr_switching_fault_status: Read the FIVR switching frequency
> > control
> >                         fault status. Uses ACPI method GFFS
> > 
> > ssc_clock_info : Presents SSC (spread spectrum clock) information
> > for EMI
> > (Electro magnetic interference) control. Use ACPI method GEMI.
> > Refer
> > to the description of GEMI method below.
> > 
> > GFFS
> > This ACPI method is used to read the FIVR switching frequency
> > control
> > fault status.
> > Bits    Description
> > [0:0]   Fault status when set to 1
> > [31:1]  Reserved
> > 
> > GFCS
> > This ACPI method is used to read the FIVR switching control
> > frequency.
> > Bits    Description
> > [11:0]  Actual Frequency = value * XTAL_FREQ / 128
> 
> I was about to apply this, but one question.
> 
> AFAICS the "show" function will simply evaluate GFCS and preset the
> returned value to the reader of the attribute, but the documentation
> says that this is the switching control frequency in MHz which
> doesn't
> seem to be consistent with the above information.
> 
> Is the reader of the attribute required to know the XTAL frequency
> and
> apply the above formula to the value read from it?  If so, the
> documentation should be clear about this.
> 
Since XTAL_FREQ can be different on designs, user of the interface is
supposed to know that.
I will update the documentation and resend.

Thanks,
Srinivas

> > [31:12] Reserved
> > 
> > GEMI
> > This ACPI method is used to read the programmed register value for
> > EMI
> > (Electro magnetic interference) control.
> > 
> > Bits    Description
> > [7:0]   Sets clock spectrum spread percentage:
> >         0x00=0.2% , 0x3F=10%
> >         1 LSB = 0.1% increase in spread (for
> >         settings 0x01 thru 0x1C)
> >         1 LSB = 0.2% increase in spread (for
> >         settings 0x1E thru 0x3F)
> > [8]     When set to 1, enables spread
> >         spectrum clock
> > [9]     0: Triangle mode. FFC frequency
> >         walks around the Fcenter in a linear
> >         fashion
> >         1: Random walk mode. FFC frequency
> >         changes randomly within the SSC
> >         (Spread spectrum clock) range
> > [10]    0: No white noise. 1: Add white noise
> >         to spread waveform
> > [11]    When 1, future writes are ignored.
> > 
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-platform-dptf | 40
> > +++++++++++++++++++
> >  drivers/acpi/dptf/dptf_pch_fivr.c             |  9 +++++
> >  2 files changed, 49 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf
> > b/Documentation/ABI/testing/sysfs-platform-dptf
> > index 141834342a4d..f0c43711ad4f 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-dptf
> > +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> > @@ -111,3 +111,43 @@ Contact:   linux-acpi@vger.kernel.org
> >  Description:
> >                 (RW) The PCH FIVR (Fully Integrated Voltage
> > Regulator) switching frequency in MHz,
> >                 when FIVR clock is 38.4MHz.
> > +
> > +What:         
> > /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fiv
> > r_switching_freq_mhz
> > +Date:          June, 2021
> > +KernelVersion: v5.14
> > +Contact:       linux-acpi@vger.kernel.org
> > +Description:
> > +               (RO) Get the FIVR switching control frequency in
> > MHz.
> > +
> > +What:         
> > /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fiv
> > r_switching_fault_status
> > +Date:          June, 2021
> > +KernelVersion: v5.14
> > +Contact:       linux-acpi@vger.kernel.org
> > +Description:
> > +               (RO) Read the FIVR switching frequency control
> > fault status.
> > +
> > +What:         
> > /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/ssc
> > _clock_info
> > +Date:          June, 2021
> > +KernelVersion: v5.14
> > +Contact:       linux-acpi@vger.kernel.org
> > +Description:
> > +               (RO) Presents SSC (spread spectrum clock)
> > information for EMI
> > +               (Electro magnetic interference) control. This is a
> > bit mask.
> > +               Bits    Description
> > +               [7:0]   Sets clock spectrum spread percentage:
> > +                       0x00=0.2% , 0x3F=10%
> > +                       1 LSB = 0.1% increase in spread (for
> > +                       settings 0x01 thru 0x1C)
> > +                       1 LSB = 0.2% increase in spread (for
> > +                       settings 0x1E thru 0x3F)
> > +               [8]     When set to 1, enables spread
> > +                       spectrum clock
> > +               [9]     0: Triangle mode. FFC frequency
> > +                       walks around the Fcenter in a linear
> > +                       fashion
> > +                       1: Random walk mode. FFC frequency
> > +                       changes randomly within the SSC
> > +                       (Spread spectrum clock) range
> > +               [10]    0: No white noise. 1: Add white noise
> > +                       to spread waveform
> > +               [11]    When 1, future writes are ignored.
> > diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c
> > b/drivers/acpi/dptf/dptf_pch_fivr.c
> > index 5fca18296bf6..22c4ae0401ef 100644
> > --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> > +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> > @@ -55,15 +55,24 @@ static ssize_t name##_store(struct device
> > *dev,\
> > 
> >  PCH_FIVR_SHOW(freq_mhz_low_clock, GFC0)
> >  PCH_FIVR_SHOW(freq_mhz_high_clock, GFC1)
> > +PCH_FIVR_SHOW(ssc_clock_info, GEMI)
> > +PCH_FIVR_SHOW(fivr_switching_freq_mhz, GFCS)
> > +PCH_FIVR_SHOW(fivr_switching_fault_status, GFFS)
> >  PCH_FIVR_STORE(freq_mhz_low_clock, RFC0)
> >  PCH_FIVR_STORE(freq_mhz_high_clock, RFC1)
> > 
> >  static DEVICE_ATTR_RW(freq_mhz_low_clock);
> >  static DEVICE_ATTR_RW(freq_mhz_high_clock);
> > +static DEVICE_ATTR_RO(ssc_clock_info);
> > +static DEVICE_ATTR_RO(fivr_switching_freq_mhz);
> > +static DEVICE_ATTR_RO(fivr_switching_fault_status);
> > 
> >  static struct attribute *fivr_attrs[] = {
> >         &dev_attr_freq_mhz_low_clock.attr,
> >         &dev_attr_freq_mhz_high_clock.attr,
> > +       &dev_attr_ssc_clock_info.attr,
> > +       &dev_attr_fivr_switching_freq_mhz.attr,
> > +       &dev_attr_fivr_switching_fault_status.attr,
> >         NULL
> >  };
> > 
> > --
> > 2.27.0
> > 


