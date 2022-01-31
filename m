Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9026A4A3E40
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Jan 2022 08:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbiAaHgw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Jan 2022 02:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347972AbiAaHgv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Jan 2022 02:36:51 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6233C061714;
        Sun, 30 Jan 2022 23:36:50 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nERF0-0003mt-Ng; Mon, 31 Jan 2022 08:36:47 +0100
Message-ID: <95bf594b-250c-5a6d-aa3b-d428dbf9c203@leemhuis.info>
Date:   Mon, 31 Jan 2022 08:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-BS
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
References: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: 100 ms boot time increase regression in
 acpi_init()/acpi_scan_bus()
In-Reply-To: <b177cb21-aa01-2408-9b26-164c028b6593@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1643614610;7995cc82;
X-HE-SMSGID: 1nERF0-0003mt-Ng
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 10.01.22 12:29, Paul Menzel wrote:
> #regzbot introduced: v5.13..v5.14-rc1
> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215419

Thx for getting regzbot involved!

Nothing happened since you reported the issue three weeks ago; sure,
it's not a pressing issue, but I wonder what the status is.

@pm people: isn't this at least worth a reply?
@paul: did you perform any additional checks?

Or did anything happen somewhere else and I just missed it?

#regzbot poke

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

> On the Intel T4500 laptop Acer TravelMate 5735Z with Debian
> sid/unstable, there is a 100 ms introduced between Linux 5.10.46 and
> 5.13.9, and is still present in Linux 5.15.5.
> 
>     [    0.000000] microcode: microcode updated early to revision 0xa0b,
> date = 2010-09-28
>     [    0.000000] Linux version 5.15.0-2-amd64
> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.2.0-13) 11.2.0, GNU
> ld (GNU Binutils for Debian) 2.37) #1 SMP Debian 5.15.5-2 (2021-12-18)
>     [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.15.0-2-amd64
> root=UUID=e17cec4f-d2b8-4cc3-bd39-39a10ed422f4 ro quiet noisapnp
> cryptomgr.notests random.trust_cpu=on initcall_debug log_buf_len=4M
>     […]
>     [    0.262243] calling  acpi_init+0x0/0x487 @ 1
>     […]
>     [    0.281655] ACPI: Enabled 15 GPEs in block 00 to 3F
>     [    0.394855] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>     […]
>     [    0.570908] initcall acpi_init+0x0/0x487 returned 0 after 300781
> usecs
> 
> I attached all the log files to the Kernel.org Bugzilla bug report
> #215419 [1].
> 
> Unfortunately, I am unable to bisect the issue, as it’s not my machine,
> and I do not have a lot of access to it.
> 
> Using ftrace, unfortunately, I didn’t save all of them, I think the path is
> 
>     acpi_init() → acpi_scan_init() → acpi_bus_scan(ACPI_ROOT_OBJECT)
> 
> But this path hasn’t changed as far as I can see. Anyway, from that
> path, somehow
> 
>     acpi_bus_check_add_1() → acpi_bus_check_add() → … →
> acpi_bus_check_add() → acpi_add_single_object() → acpi_bus_get_status()
> 
> is called, and the `acpi_bus_get_status()` call takes 100 ms on the
> system – also the cause for bug #208705 [2] –, but that code path wasn’t
> taken before.
> 
> Do you know from the top of your head, what changed? I am going to have
> short access to the system every two weeks or so, so debugging is
> unfortunately quite hard.
> 
> What is already on my to-do list:
> 
> 1.  Use dynamic debug `drivers/acpi/scan.c`
> 2.  Trace older Linux kernel (5.10.46) to see the differences
> 3.  Booting some GNU/Linux system to test 5.11 (Ubuntu 20.10) and 5.12
> 4.  Unrelated to the regression, but trace `acpi_bus_get_status()` to
> understand the 100 ms delay to solve bug #208705 [2]
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: Do you know of GNU/Linux live systems that are available for all
> Linux kernel releases and have an initrd, that just stores/uploads the
> output of `dmesg`?
> 
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=215419
>      "100 ms regression in boottime before `ACPI: PCI Root Bridge [PCI0]"
> [2]: https://bugzilla.kernel.org/show_bug.cgi?id=208705
>      "boot performance: 100 ms delay in PCI initialization - Acer
> TravelMate 5735Z"
> 

