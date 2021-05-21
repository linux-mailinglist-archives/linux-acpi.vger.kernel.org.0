Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E2638CBA5
	for <lists+linux-acpi@lfdr.de>; Fri, 21 May 2021 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhEUROM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 May 2021 13:14:12 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:41941 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhEUROM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 May 2021 13:14:12 -0400
Received: by mail-ot1-f51.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so18626366oth.8;
        Fri, 21 May 2021 10:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=obHOlKZL09uU+qPoBP6006mkXZuAoZ/LaIj7RYAF8cQ=;
        b=kX4XNFKRgzU4fC3tmU+pOpIf/YsDKq/t46cRcLoKin86fdj/NWdRn/EUHp4z9AG8Wr
         VF2NFe0NhLWuG9VZAhg1PlEROqchCPLoQI/AnSmcEsS3+9M55gHrYFlTtBoCNsy09/yU
         a1uIpNr4U/V3I6ZwMysFHuYJgZI82Qfth2ugGjTLiWewKrE80f9Kg5TGRBBu12QrKosc
         2Fr+Fe5+6WxRNFL7FglxY85GA1UNe4ZVTxkx9GUi0phJsATj9A9diQ7/fB+6HzMHC2dp
         scRF7GP5F0mWRfNFlZG4JL0exfByQktgCVf+MHversq0w2sUnI2cZki+hNRa2PM5Y8UC
         x/QA==
X-Gm-Message-State: AOAM531M39NcV9jzYi3WUHNzeg6uC9DWuIOXxEU2o21H8gol21oRSM41
        HXtxqo8AZOuEmuchKMukykckQGuZfvimQnIrlNQ=
X-Google-Smtp-Source: ABdhPJzk0YM9gb8r+sadtgHjxe9CQw9ZN+/5upwi7PF+TNQGfJaoALaBY9S5Qb5kXQryBJLPlEXppwZL9i6gw9Y6b6M=
X-Received: by 2002:a05:6830:164c:: with SMTP id h12mr1756059otr.321.1621617167705;
 Fri, 21 May 2021 10:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210518034119.2116555-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0ivv9ouf065aYyLqN_JtjR5vomUumAQtGHPunze0BdUmQ@mail.gmail.com> <025db5b34f40d250331184daee38a0acf8f765b4.camel@linux.intel.com>
In-Reply-To: <025db5b34f40d250331184daee38a0acf8f765b4.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 May 2021 19:12:36 +0200
Message-ID: <CAJZ5v0iBNyi6kCw11Vj2YAJeCQHajf0ubRf+hOFjPfViMdJDsQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: DPTF: Add new PCH FIVR methods
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 18, 2021 at 12:27 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Tue, 2021-05-18 at 11:36 +0200, Rafael J. Wysocki wrote:
> > On Tue, May 18, 2021 at 5:42 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > Some additional information is required for updating PCH FIVR
> > > values
> > > upon WiFi channel changes.
> > >
> > > New attributes added to the existing sysfs:
> > > fivr_switching_freq_mhz : Get the FIVR switching control frequency
> > >                           using ACPI method GFCS. Refer to the
> > >                           documentation for the equation.
> > > fivr_switching_fault_status: Read the FIVR switching frequency
> > > control
> > >                         fault status. Uses ACPI method GFFS
> > >
> > > ssc_clock_info : Presents SSC (spread spectrum clock) information
> > > for EMI
> > > (Electro magnetic interference) control. Use ACPI method GEMI.
> > > Refer
> > > to the description of GEMI method below.
> > >
> > > GFFS
> > > This ACPI method is used to read the FIVR switching frequency
> > > control
> > > fault status.
> > > Bits    Description
> > > [0:0]   Fault status when set to 1
> > > [31:1]  Reserved
> > >
> > > GFCS
> > > This ACPI method is used to read the FIVR switching control
> > > frequency.
> > > Bits    Description
> > > [11:0]  Actual Frequency = value * XTAL_FREQ / 128
> > > [31:12] Reserved
> > >
> > > GEMI
> > > This ACPI method is used to read the programmed register value for
> > > EMI
> > > (Electro magnetic interference) control.
> > >
> > > Bits    Description
> > > [7:0]   Sets clock spectrum spread percentage:
> > >         0x00=0.2% , 0x3F=10%
> > >         1 LSB = 0.1% increase in spread (for
> > >         settings 0x01 thru 0x1C)
> > >         1 LSB = 0.2% increase in spread (for
> > >         settings 0x1E thru 0x3F)
> > > [8]     When set to 1, enables spread
> > >         spectrum clock
> > > [9]     0: Triangle mode. FFC frequency
> > >         walks around the Fcenter in a linear
> > >         fashion
> > >         1: Random walk mode. FFC frequency
> > >         changes randomly within the SSC
> > >         (Spread spectrum clock) range
> > > [10]    0: No white noise. 1: Add white noise
> > >         to spread waveform
> > > [11]    When 1, future writes are ignored.
> > >
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > > ---
> > > v2
> > >         Update documentation for fivr_switching_freq_mhz
> > >
> > >  Documentation/ABI/testing/sysfs-platform-dptf | 42
> > > +++++++++++++++++++
> > >  drivers/acpi/dptf/dptf_pch_fivr.c             |  9 ++++
> > >  2 files changed, 51 insertions(+)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-dptf
> > > b/Documentation/ABI/testing/sysfs-platform-dptf
> > > index 141834342a4d..fe62f024eb93 100644
> > > --- a/Documentation/ABI/testing/sysfs-platform-dptf
> > > +++ b/Documentation/ABI/testing/sysfs-platform-dptf
> > > @@ -111,3 +111,45 @@ Contact:   linux-acpi@vger.kernel.org
> > >  Description:
> > >                 (RW) The PCH FIVR (Fully Integrated Voltage
> > > Regulator) switching frequency in MHz,
> > >                 when FIVR clock is 38.4MHz.
> > > +
> > > +What:
> > > /sys/bus/platform/devices/INTC1045:00/pch_fivr_switch_frequency/fiv
> > > r_switching_freq_mhz
> > > +Date:          June, 2021
> > > +KernelVersion: v5.14
> > > +Contact:       linux-acpi@vger.kernel.org
> > > +Description:
> > > +               (RO) Get the FIVR switching control frequency in
> > > MHz after applying equation
> > > +               "fivr_switching_freq_mhz * XTAL_FREQ / 128". Here
> > > XTAL_FREQ is Crystal Oscillator frequency
> > > +               in MHz, which is product specific.
> >
> > IMO it would be sufficient to say the following here:
> >
> > +               (RO) PCH FIVR switching control frequency in the
> > units
> > of XTAL_FREQ / 128,
> > +               where XTAL_FREQ is the Crystal Oscillator frequency
> > (product specific).
> >
> > This means that it needs to be multiplied by XTAL_FREQ / 128 to get
> > the frequency in the whatever units XTAL_FREQ is expressed.
> >
> Looks good.

So applied as 5.14 material, thanks!
