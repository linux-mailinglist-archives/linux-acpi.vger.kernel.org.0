Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D76C1DED0D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgEVQR0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 May 2020 12:17:26 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:37547 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729040AbgEVQRZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 May 2020 12:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590164243; bh=1/BDsh6x7VnGRY/cGKnyW3SXr5+dXdNv0lc5Ea4Rcx8=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject; b=qHeVAp9uy/J/tt/hyEfUlzgefCDz4SSZpAtzXerheV9P6E4WDTkDPVxTcRUI+LNHM3TFHD6EFLcXKGPJoTY4CPYW0oZT8H8oUWhNGBiauB8sQW0odyzbYNlbB489gFXW0Os0xdzCaPxAoH/WC+kAnByEqE9RoYssxYItRSVbZtfoZbreyIn2P4E4w8e7VbPWX6xock4Sap4RdPUleDQETJtccsq7wiPV/XJHYJnuwxzGqkTloHrgfWVLFPGk6VXqBGJxtOwpjKjn+yraPvMN+f+2tBiLC2W6cd9mYrMPleM2Eh/Gk68Wf8VG/Y1SdK8fS80WHB/b3Aw+o0raTph3ZA==
X-YMail-OSG: 2CxJEw8VM1mhutOL1YI3xSnN4dIo0djoBFfV7cpsvqp_itjpdl03xx1c_FoJA0k
 KO8gikd_5bxG8JJlJF6NtYpM1QPBnfpeEyWXlSWizX0xPyTq45cv0l9r5YZE6Josjg2i80KEnFys
 HBX.iirdbAsneOhI05.RG9uGMOPWLwEFje04tdM9MC08KrtBbYIb6EpAoegVzfnyXsgC5fA2iffN
 2doS9wWeQP34w5FVEDXwGABn4c4sTdXsy6RML4wk08D0oKI8A5DH.n3j4aOn49thIs4PGhqUbioJ
 Bq4_fO6BdpEO5FMVvWd8Ax0wjNgFCfE9m9D5CfKjyzQ94xYFSBDV77zE2h.pEW9wvzSdm08c98CK
 DvN0Kw2tdN8T0aS.L3vgPe10viv_U2WIYWCAnFAFLNMzNaZ8DtorCrPbxIC3wmPANPGNcmTz_VgV
 IoRDjv2zE7Et.XkMtwCHZm52YlxFhBGJ_lymJZjAQum.E1ERFvdw53thxjS1I9zbCyvBHqVXV9b2
 Ol3dJ3QbQuevMlUPug5RFg9rPi_fRd1NCX_DewhTkQmKIuGQIyV5S5Kc.W2uuU5vCv20wPyoXiRd
 1uu9CoUboPK4lMncRN1uqhtOKxtY9Q.CrYpLHhyQhZ2WBH52fZ_4tiyG_Q_Kc5resuDOGb7tRKL2
 .qiqOCDKZhcu0KiY8Kv46x1vmnIBm3LJAuku0rtS1vQNTbcbuJI1Dc5JkLq.nEGd_ZpSfA_3Ah73
 7AmnVZkparFBaGt2lg73e_hEW7Z3.aeBTH.NDXBQRYFC61ozEKE8_Tnaql332j7_I6LzImXyYuhV
 o7l.naiBiV28Lh.a0ELkMEXhc8o8TBH4ptS4BmFst1uN31QNfSiLqf1X0wwDFOk3EMrZWQH.uBWh
 X3N7txztCYQ81CLWKiGX9j2RqWGiVELwJIZWbMzFC5cBKl2hZRVMAllRskr_U_jVe.ZktgU_vJvn
 a4NSq9M__lV2ODyZgJmQqXxcQqN7jfVHAECAxYDpIMrczwpXn_tWdjUPj3bJaFyhTvxZUe3bXlKD
 7Y0OfdwsNskZZukj4GaIjY5XAODBVHS9E_9Wtp07CI0yHdCi_VqENF5oOY_uL408WNSNBuSIsg66
 j4TlhCJhjko8MNebORWGUDT4J5ihn0m1jws1jHcD7Ybz19lcOQt1mYxY9zJuZU0QQJcrzp9Ueq2X
 U7P6jDuzzT_2vBTI4kqCl3WUG4h3SQ0_jAn.jTlP6exL00mEPVsmcUud6n.sopAqhhrI23mpr5G5
 dokOyW9xC3pvWZHPXLPOeuAALJ.hrxzWM8o.PEqthPTzGSDoyDhpDcHd_ReMQnearNcyWWITJIVD
 CMXHoHD7FxGfT_1.vxUF3T4HKUquCFE2Km7o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Fri, 22 May 2020 16:17:23 +0000
Date:   Fri, 22 May 2020 16:16:35 +0000 (UTC)
From:   "larsh@apache.org" <larsh@apache.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Message-ID: <1499931432.2309073.1590164195855@mail.yahoo.com>
In-Reply-To: <CAHp75VcQSECZeK-5OhJqXaZdW0r8gnvt_PBSKGK4+BKpa9D9KQ@mail.gmail.com>
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com> <1505028180.591737.1589564161284@mail.yahoo.com> <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com> <2952287.p5mUHPKNZq@kreacher> <d0022af356cf9bd5b544187d9a396734d85a76b3.camel@linux.intel.com> <193598853.2172716.1590128099214@mail.yahoo.com> <CAHp75VcQSECZeK-5OhJqXaZdW0r8gnvt_PBSKGK4+BKpa9D9KQ@mail.gmail.com>
Subject: Re: Low Latency Tolerance preventing Intel Package from entering
 deep sleep states
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.15960 YMailNorrin Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:76.0) Gecko/20100101 Firefox/76.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Relevant logs:

May 21 23:05:31 host kernel: sdhci-pci 0000:53:00.0: SDHCI controller found=
 [17a0:9755] (rev 0)
May 21 23:05:31 host kernel: sdhci-pci 0000:53:00.0: enabling device (0000 =
-> 0002)
May 21 23:05:31 host kernel: mmc0: SDHCI controller on PCI [0000:53:00.0] u=
sing ADMA 64-bit



On Friday, May 22, 2020, 1:59:08 AM PDT, Andy Shevchenko <andy.shevchenko@g=
mail.com> wrote:=20





+Cc: Adrian

On Fri, May 22, 2020 at 9:15 AM larsh@apache.org <larsh@apache.org> wrote:
>
> Thanks David!
>
> With this I tracked down the SD Card Reader (Genesys Logic, Inc Device 97=
55) as the culprit.
> These are standard in many ThinkPads.
> The curious part is that resume from suspend (S3 or S0iX) also fixes the =
problem.
> Looks like the driver is not initializing correctly at boot time.
>
> Transcript:
>
> $ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
> SOUTHPORT_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x88018c01=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 1024=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Snoop(ns): 32768
> SOUTHPORT_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
> SOUTHPORT_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x9f409f4=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
> SOUTHPORT_D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x88aa88aa=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 174080=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Snoop(ns): 174080
> SOUTHPORT_E=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
>
> $ lspci -t
> -[0000:00]-+-00.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-01.0-[01]--+-00.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \-00.1
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-02.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-04.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-08.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-12.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-14.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-14.2
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-15.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-16.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1c.0-[53]----00.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1d.0-[02]----00.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1d.6-[52]----00.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1e.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1f.0
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1f.3
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1f.4
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 +-1f.5
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \-1f.6
>
> $ lspci | grep 53
> 53:00.0 SD Host controller: Genesys Logic, Inc Device 9755
>
> $ cat /sys/bus/pci/devices/0000\:53\:00.0/power/control
> auto
>
> $ echo 1 > /sys/bus/pci/devices/0000\:53\:00.0/remove
> 1
>
> $ cat /sys/kernel/debug/pmc_core/ltr_show | grep SOUTHPORT
> SOUTHPORT_A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x8010c01=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
> SOUTHPORT_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
> SOUTHPORT_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x9f409f4=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
> SOUTHPORT_D=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x8c548c54=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 2752512=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Snoop(ns): 2752512
> SOUTHPORT_E=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LTR: RAW: 0x0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Non-Snoop(ns): 0=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Snoop(ns): 0
>
> Cheers.
>
> -- Lars
>
>
>
>
>
>
>
>
> On Tuesday, May 19, 2020, 9:03:53 AM PDT, David E. Box <david.e.box@linux=
.intel.com> wrote:
>
>
>
>
>
> > > > Does anybody know what's going on or how to debug this further?
> > > > As stated above, I was able to work around this problem by
> > > > ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
> > > > There has to be a better way, and I'm sure I'm not the only one
> > > > running into this.
>
> ltr_show shows the PMC's (Power Management Controller) view of SoC
> devices and busses. The SOUTHPORTs are the PCIe root ports on your
> system. When you run lspci they are the PCI bridges. Generally, the
> bridges are enumerated in the same order as the SOUTHPORTs, so
> SOUTHPORT_A is your first bridge and the device attached to it (shown
> in lspci -t) is the device that was blocking deeper PC states according
> to your debug.
>
> Determine what this device is on your system. If the ltr was low it's
> because that is what the device requested. You should first check that
> runtime pm is enabled for the device. To do this, check the control
> file in /sys/bus/pci/devices/<SSSS:BB:DD.F>/power, where SSSS:BB:DD.F
> is the enumeration of your device as shown in lspci. If it is 'on' then
> runtime pm is disabled. To enable it echo 'auto' into the file with
> root privileges. Enabling runtime pm should allow the driver to reduce
> functionality of the device when idle. This should lead to a larger
> latency request on the PCI bus which should be reflected in ltr_show.
> You can see if the device is actually runtime suspended and how much
> time it's been suspended (or active) by reading the associated files in
> the power folder.
>
> If this doesn't work, then it's possible that your device doesn't
> support runtime pm. This may be purposely for reliability reasons or
> the driver may just lack support. Check forums discussing issues with
> the device and look for possible options in the driver to force pm
> support (generally this will be centered around enabling ASPM).
>
> You can also download powertop to see the package c-state residencies
> more clearly as percentages of time. powertop also has a tunables tab
> that will show the status of runtime pm on all devices on the system
> and allow you to enable them individually.
>
>
> David

>


--=20
With Best Regards,
Andy Shevchenko

