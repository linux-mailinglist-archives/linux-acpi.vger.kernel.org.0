Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1F01F9C19
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgFOPl0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 11:41:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:47219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgFOPlY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Jun 2020 11:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592235668;
        bh=fHo5pNOwAc3R7Gu1OYjStGQg97puTIW4tt/Eb3clUGI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=Yr1a3/eeaT6DCl6KVwlM2KQh8rr6sGrGNKgL74lzcPcSCu04msni5A6SbdJcDKBX6
         uIwt4n+SLIX4+7EfOIc0eD8muuhcqF3sFleM/6Kq5oL6Q8KkBSqj6H9NOu0scxbuA1
         TSPPShedYF/U7WhVpD0c4L4fi7Dd5mZ+2gWCpWoM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.165.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1jaA8B028l-00Ajng; Mon, 15
 Jun 2020 17:41:08 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87y2owwo2o.fsf@rub.de>
        <20200609202339.cgy57twm2zdtjhje@linutronix.de>
        <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
        <87imfyh6yx.fsf@gmx.net> <87wo4dligz.fsf@gmx.net>
        <20200612110122.jossn5zrktcvpbpm@linutronix.de>
        <87tuzdrgm5.fsf@gmx.net>
        <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
        <874krcsquv.fsf@gmx.net>
        <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
Date:   Mon, 15 Jun 2020 17:41:06 +0200
In-Reply-To: <20200615145130.bcdidqkp6w23xb6c@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Mon, 15 Jun 2020 16:51:30 +0200")
Message-ID: <87tuzcqqul.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v18ZwHmkixYTPbvcHmh0GFPGw/VHii7vezbZKoQiQgH4+r7YXi4
 YC32ogQK/W0nTuNVg9fvhe/AyrxlK7KpXN3HS3RRqA/1vYfEHuNi33pVoBCnn/14w2fUcEZ
 w4zCCyUfCusjLLNBmh6A3uc1wY0PYoWEcs0rBaCuv2JpvCnzZu5U5Y1s31XP7jCsb56+bcz
 SBCpmHM6+fQudzZVylk2g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5zK1/ln5gwA=:5XC6Gv9nMRKgGhmzaaJ4lY
 T+fHdZH3Snjvq/q1sisDpXKEwXvkf9aAe72tEJm4dcmDqkLXzSgcqHeXEg3kxhjChNlSnvYTN
 E6+QUcpNDCLpIPIQhXAXknZKdyge/uTg2rGU51diQRCnsGZc4UwhwLWmJ2IJYFrbgaFf0m+Pa
 N7twbz/1tikWLQ26Up2ZR6+rQNoc6YHz1xiCVioDmQ31E2wgKeFUqIC+gLB9qxL5689HboQQX
 Y8b6qTrM/BoUFBTbgc/5RjQq58Vg0HuBepLFU4hrpGjkuC9D270BTRvllTjMe8RWP/qxPLtWz
 1STMivSHqN25ADLOGVsUewdGgVgU7odZNxNeWAzR0/U8lIOL83BZFe5N8rxmS2149+PpahMvn
 kNk7NXlYJ+rrb4LIV8X1RpSF6e0FRoqJ0hlMsejsxqwWC396I0WgL0pyexaDZhHM6F0bZGKaQ
 55iv+UqOr11FsiOmK2TYr9CL/UaFodlnPGEZVVLDoFTKEVTdF2b6Swd9SOw7UnB6xQRNjRQYP
 pxW/x2/OFXuXrtxfbmsotQROsqfDmo6mwaSiSaxsiZpooc5WsJJaLBkkb5w2ie1/wuCSHg9h8
 HhaUJu9hWrZ0FY2pooz16egXR7Dj1aTrQT472y/iJG811qHTvIwl9PKTgxf7INrL/Pab0PGTl
 AO79eg+fBZ6EyTRAWzA7X51hWHYGNxcShkip/bDNUzxA3XMa1RCV1LnUKL8oMf3zfcZQeBVC5
 MlvNLnkyk8zd3jeEcEliULdIuKeZh8G58rswqaHLdUgYS7omwO8farQo4KoQuJ4psFlUpeQK+
 IRdZ2EyHkcEw1YvlHSZFB8rssjpi/r+twtwozxgx5Ru2peK0tRcbhjPfLzTtEKfgooxTnKIfK
 zj0NkeH09kgRvXhrdFu1ZsyGRf9osaEyrEAdUW1Dw/8oG4VB1AZHbdsXIAurgEx7dzmwrLQlB
 SgX11M29cOtUyxzPAm+0GV+FQsucC5HteQYoSHpIyBtkGvkPJ1z58EUBNLXo46l6Sg+TLqBKi
 3NoP/jY4sSXi45heJ9//NPbsRYGsFyYMH+5qmVPs3PxeTi+vw2RcSMsEeESYUdsTAHIurPjMK
 ZQlaaznxoi+FI/8kvD8TDvvQGGuDRsJCGThbjjkhj1OQ32/7XAgH6hF9eMQtfVrGTy3jRvPBI
 8lKeAymrz15rL4hZuQK7MvhXj/6jLBWUm8UGNWMICvE6cWMBi5tq0DmCrRNNPZEpRSuuuElXQ
 iuE348482oB1ku88H
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 15 Jun 2020 16:51:30 +0200 Sebastian Andrzej Siewior <bigeasy@linut=
ronix.de> wrote:

> On 2020-06-15 09:58:00 [+0200], Stephen Berman wrote:
>> Ok, sorry, I had misunderstood, but now I've looked at the
>> documentation.  I had in fact already done `echo t >
>> /proc/sysrq-trigger' in an xterm (as root) and there was no output.
>> Later, after booting kernel 5.1.0 because of the message flooding with
>> 5.6.4, I did `echo t > /proc/sysrq-trigger' in a virtual tty (also as
>> root) and the only output was: `[ <timestamp>] sysrq: Show State'.  Is
>> this expected?  (In /proc/sys/kernel/sysrq there is `1'.)  I couldn't
>> try it in a 5.6.4 virtual tty because of the message flooding (see
>> below).
>
> If you do this "t" then there should be a lot of output on your console.
> If you do this from an xterm then you can see the output after typing
> "dmesg". The output should appear also in your system log.

Ah, ok, I do see it in the log, it looks basically the same as the call
trace I posted upthread.  I wonder why there was no such output in the
console, could there be some setting that suppresses it even though
/proc/sys/kernel/sysrq has `1'?

>> The kernel log shows 305 of these messages in the 4 minutes and 17
>> seconds between the start of klogd and when I rebooted.
>
> Okay, this is a lot.
>
>> > The interesting part is to see if there is a acpi_os_execute() adding a
>> > specific event multiple times which does not complete. Maybe at runtim=
e,
>> > maybe at shutdown time. If that is the case then ignoring this specific
>> > event might fix the shutdown problem. With all this information so far,
>> > I don't see a relation with this problem and the commit=E2=80=A6
>>=20
>> In those 3 minutes and 8 seconds there were 5 "Adding
>> acpi_ev_asynch_enable_gpe" messages at the beginning, then 185 "Adding
>> acpi_ev_notify_dispatch" messages, which kept coming until I rebooted.
>
> 5 acpi_ev_asynch_enable_gpe() in three minutes since boot isn't much.
> 185 of "Adding acpi_ev_notify_dispatch" is a lot.
>
> But to be clear, only=20
>   acpi_os_execute(1109) Adding acpi_ev_notify_dispatch" messages?
> No
>   "acpi_os_execute_deferred_notify() Start/End acpi_ev_notify_dispatch"?=
=20
>
> The syslog should have captured the log on disk.

There were in fact 99 "Start .* acpi_ev_notify_dispatch" messages and 98
"End .* acpi_ev_notify_dispatch" messages.  Here's the last of them
before I rebooted:

Jun 15 08:58:25 strobe-jhalfs kernel: [  193.315014] acpi_os_execute(1109) =
Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a66e0 <ffff8d7aabb38480>
Jun 15 08:58:25 strobe-jhalfs kernel: [  193.319929] acpi_os_execute_deferr=
ed_notify(853) End   ffff8d7aa8758d00 acpi_ev_notify_dispatch+0x0/0x55(ffff=
8d7aa84e7eb0)
Jun 15 08:58:25 strobe-jhalfs kernel: [  193.321242] acpi_os_execute_deferr=
ed_notify(851) Start ffff8d7aa8758a80 acpi_ev_notify_dispatch+0x0/0x55(ffff=
8d7aa84e70a0)
Jun 15 08:58:26 strobe-jhalfs kernel: [  194.339017] acpi_os_execute(1109) =
Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a6730 <ffff8d7aabb384c0>
Jun 15 08:58:27 strobe-jhalfs kernel: [  195.363005] acpi_os_execute(1109) =
Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a6780 <ffff8d7aabb38500>
Jun 15 08:58:27 strobe-jhalfs kernel: [  195.367978] acpi_os_execute_deferr=
ed_notify(853) End   ffff8d7aa8758a80 acpi_ev_notify_dispatch+0x0/0x55(ffff=
8d7aa84e70a0)
Jun 15 08:58:27 strobe-jhalfs kernel: [  195.369234] acpi_os_execute_deferr=
ed_notify(851) Start ffff8d7aa8758240 acpi_ev_notify_dispatch+0x0/0x55(ffff=
8d7aa84e7a00)
Jun 15 08:58:28 strobe-jhalfs kernel: [  196.387017] acpi_os_execute(1109) =
Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a68c0 <ffff8d7aabb38540>
Jun 15 08:58:28 strobe-jhalfs kernel: [  196.388508] acpi_os_execute_deferr=
ed_notify(853) End   ffff8d7aa8758240 acpi_ev_notify_dispatch+0x0/0x55(ffff=
8d7aa84e7a00)
Jun 15 08:58:28 strobe-jhalfs kernel: [  196.390128] acpi_os_execute_deferr=
ed_notify(851) Start ffff8d7aa8758b80 acpi_ev_notify_dispatch+0x0/0x55(ffff=
8d7aa84e7460)
Jun 15 08:58:29 strobe-jhalfs kernel: [  197.208714] wlan1: deauthenticatin=
g from 7c:ff:4d:08:df:22 by local choice (Reason: 3=3DDEAUTH_LEAVING)
Jun 15 08:58:29 strobe-jhalfs kernel: [  197.232214] ip (4614) used greates=
t stack depth: 11272 bytes left
Jun 15 08:58:29 strobe-jhalfs kernel: Kernel logging (proc) stopped.
Jun 15 08:58:29 strobe-jhalfs kernel: Kernel log daemon terminating.

> I attached a modified acpi_dbg.patch. Please enable:
> - CONFIG_ACPI_DEBUG=3Dy
>
> Looking at your 5.1 you have tracing enabled (hope it still is).
>
> The attached patch will dump the date into the tracing buffer, so you
> console should remain "clean". Once it records 300 of those "requests
> for acpi_ev_notify_dispatch" it will stop recording.
> After 4-5 minutes please do
> 	cat /sys/kernel/debug/tracing/trace > file.txt
>
> compress it and send it.

Will do as soon as I can, hopefully later today or tomorrow.  Thanks.

Steve Berman
