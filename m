Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A913939E18A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFGQNy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 12:13:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:24031 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGQNy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 7 Jun 2021 12:13:54 -0400
IronPort-SDR: qrVmHJwJ/2jn3S8B31A5iIAutjzi6f7w0sq8wUJwPP16EnoVO5q4+Ux02ig8n0S51+n7DgvYK+
 8LC97gr9mZTw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="204675316"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="204675316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:08:51 -0700
IronPort-SDR: QFemcTnPTk+x29b4CHZMQJn+657De+HGQZLQHERzeNvJrjZtQhKZ/0pGkV05kNeECSm/lbmLo8
 NDPAZU4PajsA==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="447536315"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 09:08:47 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 07 Jun 2021 19:08:45 +0300
Date:   Mon, 7 Jun 2021 19:08:45 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@outlook.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
Message-ID: <YL5EjVDYLPhRKMIA@lahna.fi.intel.com>
References: <f634a05a-e3a9-93ab-4b87-d41f5ee083a5@redhat.com>
 <93d783c4-4468-023b-193e-3fc6eca35445@redhat.com>
 <a3c05e2f-af1c-ef19-4c9a-6b5b82d2da6d@redhat.com>
 <CAJZ5v0hYnEes7SDqwSqTGKQf4Qebr=gmj_qSQOPWKQzPdpAwrw@mail.gmail.com>
 <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR1PR80MB5051E91269FD36681BB357A7E1389@FR1PR80MB5051.lamprd80.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Tried now on ADL-P and TGL systems and the _OSC still works properly.

Thanks Hans for fixing!

Feel free to add my Tested-by.

On Mon, Jun 07, 2021 at 01:01:59PM +0000, Mario Limonciello wrote:
>    Mika,
> 
>    Can you have a try and make sure this modification still works properly
>    on the series in the hardware we originally did it for?
>      __________________________________________________________________
> 
>    From: Rafael J. Wysocki <rafael@kernel.org>
>    Sent: Monday, June 7, 2021 6:13:21 AM
>    To: Hans de Goede <hdegoede@redhat.com>
>    Cc: Rafael J . Wysocki <rjw@rjwysocki.net>; Mario Limonciello
>    <mario.limonciello@outlook.com>; linux-acpi
>    <linux-acpi@vger.kernel.org>
>    Subject: Re: Some SSDT tables are not loading with kernel >= 5.12
> 
>    On Mon, Jun 7, 2021 at 12:05 PM Hans de Goede <hdegoede@redhat.com>
>    wrote:
>    >
>    > HI,
>    >
>    > On 6/7/21 11:43 AM, Hans de Goede wrote:
>    > > Hi,
>    > >
>    > > On 6/3/21 7:26 PM, Hans de Goede wrote:
>    > >> Hi Rafael,
>    > >>
>    > >> I've been helping some users with trying to get to the bottom of
>    some
>    > >> new ACPI errors with kernel 5.12, see:
>    > >>
>    > >> [1]https://bugzilla.kernel.org/show_bug.cgi?id=213023
>    > >>
>    > >> After looking at dmesg output; and after editing the dmesg output
>    > >> a bit so that I could do diff -u on it, the following stands out:
>    > >>
>    > >> --- dmesg_5.10.38-1-lts      2021-06-03 16:29:41.372922210 +0200
>    > >> +++ dmesg_linux-5.12.5-arch1-1       2021-06-03 16:30:01.013031634
>    +0200
>    > >> @@ -92,7 +92,7 @@
>    > >>  ACPI: IRQ9 used by override.
>    > >>  Using ACPI (MADT) for SMP configuration information
>    > >>  ACPI: HPET id: 0x8086a201 base: 0xfed00000
>    > >> -ACPI: Core revision 20200925
>    > >> +ACPI: Core revision 20210105
>    > >>  PM: Registering ACPI NVS region [mem 0x7156c000-0x7156cfff] (4096
>    bytes)
>    > >>  PM: Registering ACPI NVS region [mem 0x8a88f000-0x8af7efff]
>    (7274496 bytes)
>    > >>  ACPI FADT declares the system doesn't support PCIe ASPM, so
>    disable it
>    > >> @@ -113,10 +113,6 @@
>    > >>  ACPI: Dynamic OEM Table Load:
>    > >>  ACPI: SSDT 0xFFFF... 0003FF (v02 PmRef  Cpu0Cst  00003001 INTL
>    20160527)
>    > >>  ACPI: Dynamic OEM Table Load:
>    > >> -ACPI: SSDT 0xFFFF... 0000BA (v02 PmRef  Cpu0Hwp  00003000 INTL
>    20160527)
>    > >> -ACPI: Dynamic OEM Table Load:
>    > >> -ACPI: SSDT 0xFFFF... 000628 (v02 PmRef  HwpLvt   00003000 INTL
>    20160527)
>    > >> -ACPI: Dynamic OEM Table Load:
>    > >>  ACPI: SSDT 0xFFFF... 000D14 (v02 PmRef  ApIst    00003000 INTL
>    20160527)
>    > >>  ACPI: Dynamic OEM Table Load:
>    > >>  ACPI: SSDT 0xFFFF... 000317 (v02 PmRef  ApHwp    00003000 INTL
>    20160527)
>    > >>
>    > >> Note how for some reason the kernel is no longer loading the
>    Cpu0Hwp and
>    > >> HwpLvt SSDT-s ?
>    > >>
>    > >> Do you have any ideas what might be causing this ?
>    > >
>    > > Good news, a very similar bug is being tracked here:
>    > >
>    > > [2]https://bugzilla.redhat.com/show_bug.cgi?id=1963717
>    > >
>    > > And one of the reporters there has done a git bisect and has found
>    the commit which is causing the problem for them:
>    > >
>    > > """
>    > > git-bisect points to 719e1f561afbe020ed175825a9bd25ed62ed1697 :
>    > > "ACPI: Execute platform _OSC also with query bit clear".
>    > >
>    > > Tested 5.12.9 kernel with the commit reverted, and confirmed that
>    the error
>    > > messages are gone. (I had to revert
>    > > 5a6a2c0f0f43676df27632d657a3f18b151a7ef8 for dependency too.)
>    > >
>    > > It also brings back the /sys/devices/system/cpu/cpu0/acpi_cppc
>    which is absent
>    > > in the stable 5.12.x
>    > >
>    > > Hope this helps
>    > > """
>    >
>    > I've taken a quick look at commit 719e1f561afb ("ACPI: Execute
>    platform _OSC also with query bit clear") and I think I may have found
>    the problem.
>    >
>    > I've attached a patch which I think may fix this (and I've asked the
>    reporters of the bugs to test this).
>    Thank you, the patch looks reasonable to me.
>    It looks like commit 719e1f561afb went a bit too far.
> 
> References
> 
>    1. https://bugzilla.kernel.org/show_bug.cgi?id=213023
>    2. https://bugzilla.redhat.com/show_bug.cgi?id=1963717
