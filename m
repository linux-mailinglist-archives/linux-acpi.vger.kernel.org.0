Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7301D751E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 May 2020 12:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgERK0j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 May 2020 06:26:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57178 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERK0i (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 May 2020 06:26:38 -0400
Received: from 89-64-86-21.dynamic.chello.pl (89.64.86.21) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 3ef8d7e6de62ea20; Mon, 18 May 2020 12:26:35 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "larsh@apache.org" <larsh@apache.org>,
        "ibm-acpi-devel@lists.sourceforge.net" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
Subject: Re: Low Latency Tolerance preventing Intel Package from entering deep sleep states
Date:   Mon, 18 May 2020 12:26:34 +0200
Message-ID: <2952287.p5mUHPKNZq@kreacher>
In-Reply-To: <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com>
References: <1505028180.591737.1589564161284.ref@mail.yahoo.com> <1505028180.591737.1589564161284@mail.yahoo.com> <CAHp75VfC0NdyyR1zXbk47G_9y5ResrpV+w3cOntDqP_naocuvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 15, 2020 11:41:16 PM CEST Andy Shevchenko wrote:
> +Cc: ACPI ML and Rafael

+Cc: David Box

> On Fri, May 15, 2020 at 8:36 PM larsh@apache.org <larsh@apache.org> wrote:
> >
> > Hi. I hope this is the right forum to raise this...
> >
> > For a while I have noticed that my CPU (i9-9880H in a Lenovo X1 Extreme Gen2) never enters any sleep mode below pc2.
> > (Confirmed with powertop and /sys/kernel/debug/pmc_core/package_cstate_show)
> >
> > Interestingly the CPU *can* reachers deeper C states *after* a resume from sleep (either S0ix or S3, i.e. freeze or mem).
> >
> > This article finally pointed me in the right direction: https://01.org/blogs/qwang59/2020/linux-s0ix-troubleshooting
> >
> > Somehow SOUTHPORT_A is requesting a max latency of 1 us.
> > There are no external devices attached.
> >
> > This is before a resume:
> >
> > $ cat /sys/kernel/debug/pmc_core/ltr_show
> > SOUTHPORT_A                             LTR: RAW: 0x88018c01            Non-Snoop(ns): 1024             Snoop(ns): 32768           <-------
> > SOUTHPORT_B                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SATA                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > GIGABIT_ETHERNET                        LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > XHCI                                    LTR: RAW: 0x13ff                Non-Snoop(ns): 0                Snoop(ns): 0
> > Reserved                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > ME                                      LTR: RAW: 0x8000800             Non-Snoop(ns): 0                Snoop(ns): 0
> > EVA                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SOUTHPORT_C                             LTR: RAW: 0x9f409f4             Non-Snoop(ns): 0                Snoop(ns): 0
> > HD_AUDIO                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > CNV                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > LPSS                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SOUTHPORT_D                             LTR: RAW: 0x8c548c54            Non-Snoop(ns): 2752512          Snoop(ns): 2752512
> > SOUTHPORT_E                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > CAMERA                                  LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > ESPI                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SCC                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > ISH                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > UFSX2                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > EMMC                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > WIGIG                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > CURRENT_PLATFORM                        LTR: RAW: 0x40201               Non-Snoop(ns): 0                Snoop(ns): 0
> > AGGREGATED_SYSTEM                       LTR: RAW: 0x7fbfdfe             Non-Snoop(ns): 0                Snoop(ns): 0
> >
> > Notice the 1000ns max latency requirement for SOUTHPORT_A.
> >
> > Ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore subsequently allows the CPU to reach deep sleep states.
> >
> > After a resume it looks like suddenly SOUTHPORT_C is active and with a less tight latency requirement:
> >
> > $ cat /sys/kernel/debug/pmc_core/ltr_show
> > SOUTHPORT_A                             LTR: RAW: 0x8010c01             Non-Snoop(ns): 0                Snoop(ns): 0               <--------
> > SOUTHPORT_B                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SATA                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > GIGABIT_ETHERNET                        LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > XHCI                                    LTR: RAW: 0x13ff                Non-Snoop(ns): 0                Snoop(ns): 0
> > Reserved                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > ME                                      LTR: RAW: 0x8000800             Non-Snoop(ns): 0                Snoop(ns): 0
> > EVA                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SOUTHPORT_C                             LTR: RAW: 0x88468846            Non-Snoop(ns): 71680            Snoop(ns): 71680           <---------
> > HD_AUDIO                                LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > CNV                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > LPSS                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SOUTHPORT_D                             LTR: RAW: 0x8c548c54            Non-Snoop(ns): 2752512          Snoop(ns): 2752512
> > SOUTHPORT_E                             LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > CAMERA                                  LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > ESPI                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > SCC                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > ISH                                     LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > UFSX2                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > EMMC                                    LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > WIGIG                                   LTR: RAW: 0x0                   Non-Snoop(ns): 0                Snoop(ns): 0
> > CURRENT_PLATFORM                        LTR: RAW: 0x40201               Non-Snoop(ns): 0                Snoop(ns): 0
> > AGGREGATED_SYSTEM                       LTR: RAW: 0x904824              Non-Snoop(ns): 0                Snoop(ns): 0
> >
> > Does anybody know what's going on or how to debug this further?
> >
> > As stated above, I was able to work around this problem by ignoring SOUTHPORT_A via /sys/kernel/debug/pmc_core/ltr_ignore.
> > There has to be a better way, and I'm sure I'm not the only one running into this.
> >
> > Thanks.
> >
> > -- Lars
> 
> 
> 
> 




