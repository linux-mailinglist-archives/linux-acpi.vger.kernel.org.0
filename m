Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD864F755
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Dec 2022 04:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiLQDXP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Dec 2022 22:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLQDXO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Dec 2022 22:23:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3239468
        for <linux-acpi@vger.kernel.org>; Fri, 16 Dec 2022 19:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671247393; x=1702783393;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y4XX/5K04kOaBdD/+zUSyEG/gL3R+VMZvMhK3iTxNAI=;
  b=K/zHyCtYh8jAos7AZ8LfP3uhWnehx+P/uhqfq6IPR+3oME45xSGeG6ex
   jlJNya2N2tAFGnYIPuFps7R6w3KYhIZwyAipMMVDIBr1sdbJNUPYoZJ1z
   +oUJuE4z7Y44ise3RJEqt5oKXFKXDE/5DKf2hauZG1sKNWL1QAi+MTPCE
   EKf29gJy/YO0T2oXEh2Upfr8o4hVL/n50Toul3YjXO4+Zjq8wxTeu54Ud
   b86I/ct6yb7vg+G8an7Auo+zCEVF9kD1kZ6UgF9Oe6wNKrLgh1QE2YWkg
   2UYx3dNAmw89zSna5xR+NYh0/6yPrRhnywsjydXIQ5Yf4thhUmw3nRVKI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="316735737"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="316735737"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 19:23:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="643464847"
X-IronPort-AV: E=Sophos;i="5.96,252,1665471600"; 
   d="scan'208";a="643464847"
Received: from yingpinx-mobl3.ccr.corp.intel.com ([10.254.211.169])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 19:23:10 -0800
Message-ID: <0ed28936706e508cb66f85fb8d5ce80e32c8d180.camel@intel.com>
Subject: Re: intel_idle Jasper Lake Support
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Maciej Koszanski <maciejkoszanskibusiness@gmail.com>
Cc:     linux-acpi@vger.kernel.org
Date:   Sat, 17 Dec 2022 11:23:00 +0800
In-Reply-To: <CAJZ5v0h-8RR0YLQ3w86JC4DypW-Kcu=snyqtup1wr_-0yzBJKA@mail.gmail.com>
References: <CAL4jJSh8tKxZc-6qO6oyPm=MrRPwuvkQkQMNmwLbuXX4GAuJ9g@mail.gmail.com>
         <e4df2651-7201-ff43-c3f1-68767f2579cf@intel.com>
         <CAL4jJShcJB9yHnWL+k4C0cjVW0hFtc=3tx1_0Uz4zbkzaaE_7g@mail.gmail.com>
         <CAJZ5v0h-8RR0YLQ3w86JC4DypW-Kcu=snyqtup1wr_-0yzBJKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 2022-12-14 at 20:57 +0100, Rafael J. Wysocki wrote:
> On Wed, Dec 14, 2022 at 8:43 PM Maciej Koszanski
> <maciejkoszanskibusiness@gmail.com> wrote:
> >=20
> > Hi Rafael,
> >=20
> > Thank you kindly for your reply! Very much appreciate your time
> > answering my questions.
> >=20
> > Output of /sys/devices/system/cpu/cpu0/cpuidle/state3/desc is ACPI
> > FFH MWAIT 0x60.
> > Unsure what depth this attribute denotes, but I assume it's either
> > C6/C7. :)
>=20
> Probably C7.
>=20
> > state2/desc is ACPI FFH MWAIT 0x31.
>=20
> I would say C3.

Jasperlake supports C10 and S0ix, so I guess these are C10 and C7
respectively.

>=20
> > Thank you for the clarification above! I was concerned that as
> > powertop was reporting C3_ACPI,
> > that the ACPI tables provided C-States with a depth as far as C3,
> > and that Jasper Lake would have
> > to have it's own static table added for support of deeper states.
>=20
> It is clarified in the intel_idle documentation too, please see:
>=20
> https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_idle.html
>=20
> > I measured the system that I thrown together based on this CPU to
> > pull about 23W from the wall at idle

how did you get this power number? external power meter?
23W seems too high for idle power, it would be interesting to see the
CPU power from RAPL.
can you do "turbostat -o ts.out sleep 10" when the system is idle and
attach the ts.out here?

thanks,
rui

> > and 45W under load (with an NVME drive that supports APST, ASPM and
> > L1.2, and 2x 3.5inch HDD's.),
> > hence the slight obsession to go as low as possible and not be
> > bottlenecked by C-States not going as
> > deep as they could. That being said, this is a weird, interesting
> > motherboard I sourced from AliExpres
> > s with minimal documentation. :)
> >=20
> > Many thanks,
>=20
> No problem.
>=20
> Thanks!
>=20
>=20
> > On Wed, 14 Dec 2022 at 18:16, Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com> wrote:
> > >=20
> > > +Rui who works on intel_idle
> > >=20
> > > Hi,
> > >=20
> > > Please see my responses inline.
> > >=20
> > > On 12/11/2022 10:53 PM, Maciej Koszanski wrote:
> > > > Dear Rafael,
> > > >=20
> > > > My name is Maciej, and I'm currently using a Jasper Lake chip
> > > > (Pentium
> > > > Silver N6005) on an install of Debian as a NAS. I'm reaching
> > > > out as I
> > > > believe you're one of the maintainers for the intel_idle
> > > > kernel, and
> > > > you authored the related docs for the module, which I found to
> > > > be a
> > > > nice read. :)
> > > >=20
> > > Thanks!
> > >=20
> > >=20
> > > > I'm currently running Kernel 6.0.0, and while intel_idle
> > > > successfully
> > > > loads on Debian (cat
> > > > /sys/devices/system/cpu/cpuidle/current_driver
> > > > returns intel_idle), it seems to be defaulting to ACPI c_states
> > > > (Powertop is reporting C3_ACPI as lowest C-state).
> > >=20
> > > That's correct.
> > >=20
> > >=20
> > > > I looked over the source for intel_idle and I don't think
> > > > there's
> > > > mention of Jasper Lake, which leads me to believe that it is
> > > > not
> > > > supported, I hope I'm not mistaken and that I'm not wasting
> > > > your time!
> > > > :) (Tremont-D and Snow Ridge seems to be supported)
> > > >=20
> > > This only means that there is no special idle states table for
> > > Jasper
> > > Lake in intel_idle.=C2=A0 The support is based on the C-state tables
> > > returned
> > > by the _CST methods in the ACPI tables of the system which is
> > > regarded
> > > to be sufficient.
> > >=20
> > > As a general rule, special idle states tables are only added for
> > > processor models where there is a demonstrable advantage from
> > > using
> > > extra C-states or different MWAIT hints with respect to the C-
> > > state
> > > tables from ACPI.
> > >=20
> > >=20
> > > > Jasper Lake is starting to gain traction now in mini-PC form
> > > > factors,
> > > > and I would greatly appreciate if it was added as a platform in
> > > > intel_idle to take advantage of the C-states. I'm sorry if the
> > > > email
> > > > comes off as if I'm begging for a feature to be implemented,
> > > > and I'm
> > > > sure you have other stuff to be busy with, but I greatly
> > > > appreciate
> > > > your time in reading this email to this point. :)
> > > >=20
> > > > Attached is an output of my cpuid, from what I gather the chip
> > > > on the
> > > > board that I have is capable of going down to C7?
> > > >=20
> > > Yes, it is AFAICS, but the C3_ACPI idle state reported for your
> > > platform
> > > very well may be C7 (please check the MWAIT hint value in the
> > > "desc"
> > > sysfs attribute of the C3_ACPI idle state).
> > >=20
> > > For the future, I would recommend using my kernel.org address
> > > (please
> > > see the CC list of this message) for inquiries regarding the
> > > Linux
> > > kernel and sending CCs of them to linux-acpi@vger.kernel.org=C2=A0.
> > >=20
> > > Cheers!
> > >=20
> > >=20


