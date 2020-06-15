Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673EA1F90C1
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgFOH6Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 03:58:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:59861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgFOH6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Jun 2020 03:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592207882;
        bh=U8IPqJVxL9sihunBAz/g/f+mmoRQ44LPopwZv+2y8OY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date;
        b=aKNNV9gW89LG+xNJ3s7dOo1YAdXwBTxt7CeGlGQZxs9aFAZL/yJRTuk71qkweU6Fs
         pt0hBBiPXIn2lTcwzq7nYgADbZ5gvfXBvcm+q62waGk3WiXEo0tzvuUKRb3lzVc9/s
         Bgs2rdjUke+ZX+kZZWciGk7Iv3hiHZ0cyct1TsUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.165.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYPY-1jII0g0Xw8-00g0yF; Mon, 15
 Jun 2020 09:58:02 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87mu6aurfn.fsf@gmx.net>
        <20200522164012.ynyvrjompv42jtmx@linutronix.de>
        <87y2owwo2o.fsf@rub.de>
        <20200609202339.cgy57twm2zdtjhje@linutronix.de>
        <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
        <87imfyh6yx.fsf@gmx.net> <87wo4dligz.fsf@gmx.net>
        <20200612110122.jossn5zrktcvpbpm@linutronix.de>
        <87tuzdrgm5.fsf@gmx.net>
        <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
Date:   Mon, 15 Jun 2020 09:58:00 +0200
Message-ID: <874krcsquv.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+odMrTtZ2fTVQjvQB8+YNCxbfgXDqZyiMSFFeoPDbjahRl/8cC6
 CvRCyumWQP5hIaD4iKplD/I9DNwgVGD/qeV7qeUeKQBRrr2D45R9dG4e+2a+3M7wv/NpaoB
 lHqwu8Xz5b5L1k+V6cDsRDyQZpqDlsPTjVerNR8iMIPijsdImWOBDVGanyYAChhi5cEC3XQ
 Th0CwJQNDeE83wZnETyPQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZ4++9cPohs=:9LFRibNLA4Lv0PfSTQZdgZ
 2rahvvgBALQWIC0QpdTdqVnznpJfvLVfahC2HhdtD8C2CvtJkwcLgp/otzkEIic0kd02Lgus6
 AhtFvpFYStO+2LtVM44ZlsMXvPbC5PFR6QBGVId3jdmJr61uDstwrpxrPof5IjJCKw9/t5PnJ
 8A5AEBHcUFjuCgHHK5FWPZYEDnMzU8JcegE262C3tW/H69nXpX6nVcBwcRIAQrufEXe9gadTU
 R/e53MXGJ+2txoQRzWLIfChNNYiivjN4SDMCEd6GUwDGKTsG/UxdKFL90J6D4XV9BKTcbGphE
 TBvkQFtjLghEP9fQq5KtNsdDu3AM0ZwoIQ0p8RrmC/GyShb25l//F15mr24ZUiyXQNJcrp0c+
 yHTg4SQWhxN80xf4RuWZm6jqnTDkznEAKl2HNZ7vm4vIEkS/iilZop2T87CsqxivFXw0LkCwD
 gz88qmiMldFu8HdcZPGhL5XYpk+UYjsv65Gw0jLBLEu5F4EhKGHhlqPJiqTS7Fhrn+bH5UrDb
 iWe0pUTYS+d++XCtFOtH/AMMv90Ot8JTp8ziJNMzohcDAAH6FcQpA1FN2dxPkw2tlyfBHsoVq
 zI3hIcLVHCQ5okIL3q8pKi3XKcpGKh4OY+48Pv+HZIxXeZiNyj5bteDyutrCn2BnMlSLW6reR
 qUehP6bfJWeNHRt5XCUlMudmOD9l7uTHEIBIl48ViUqWCUCnulaQJoIGZtIELDTrLGv7rk1KR
 Q0JeMTfXqclLZ2aQrSbdv2thnY8ozME8C+DNhUHYRBi5Xt2ArnnlEoNaF8OPTGGzBzXfat2RO
 mjHEVkoRVQh3UbiOTfYjd0wBSarU4xQXewb0XjtJ3HtyjdmZgFQ1mO5l+Jlw1jIQ5rX+JI2QG
 J5QAFVUTY/MtmuLQ+UyLUUCfh+SWPAmh6++6SEffJJFram7wxvp1/95DrvBFoy1dwfbRLvKSn
 rKmlwBg6pBMk6OyBmP/ssR4lNT9XtrWMGEJzqyUJzdin3lwOg0tnyakBsDC/Asg6sBQtXZxrT
 h0FhdHldtVOLMrkSfhoA6jhNNaH9UJCOj6wTzlcDbeHj8P41iP0nM1vJ1HHfXtGVGD94qG6zt
 /cc5fD6JrH7GzwTf671vuAlul/LSrRlN0vBO5bsbo7OSU/9+eznHuh8lrFnb+Rk6ROGLAVjxd
 mqOT6QuFIu0yH8RUnfudaWdtlWEZ4VaXNYJ+hyCNiG5bkQKhJpXrQCC/g7kzW8Rlmokjga44H
 KtR3LYgAkrvGCgtCl
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, 14 Jun 2020 19:10:05 +0200 Sebastian Andrzej Siewior <bigeasy@linut=
ronix.de> wrote:

> On 2020-06-14 14:12:18 [+0200], Stephen Berman wrote:
[...]
>> What am I supposed to do after "echo t > /proc/sysrq-trigger"?  Both
>> before and after doing that I get an error trying to open the file:
>>=20
>> root [ ~ ]# cat /proc/sysrq-trigger
>> cat: /proc/sysrq-trigger: Input/output error
>
>  echo "t > /proc/sysrq-trigger"
>
> not cat.

Ok, sorry, I had misunderstood, but now I've looked at the
documentation.  I had in fact already done `echo t >
/proc/sysrq-trigger' in an xterm (as root) and there was no output.
Later, after booting kernel 5.1.0 because of the message flooding with
5.6.4, I did `echo t > /proc/sysrq-trigger' in a virtual tty (also as
root) and the only output was: `[ <timestamp>] sysrq: Show State'.  Is
this expected?  (In /proc/sys/kernel/sysrq there is `1'.)  I couldn't
try it in a 5.6.4 virtual tty because of the message flooding (see
below).

[...]
>> I applied this patch to 5.6.4 and recompiled, and on the next boot with
>> that kernel, the kernel buffer (and kernel and system logs) began to get
>> flooded with these messages:
>>=20
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.943987]
>> acpi_os_execute_deferred(843) Start ffff8fb82c7b6500
>> 000000003edf1e05(ffff8fb82c492990)
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.944102] acpi_os_execute(1101)
>> Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8fb82c492990
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.944104]
>> acpi_os_execute_deferred(845) End ffff8fb82c7b6500
>> 000000003edf1e05(ffff8fb82c492990)
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.944105]
>> acpi_os_execute_deferred(843) Start ffff8fb82b844800
>> 000000002ba560ea(ffff8fb82c492990)
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.944124]
>> acpi_os_execute_deferred(845) End ffff8fb82b844800
>> 000000002ba560ea(ffff8fb82c492990)
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.944288]
>> acpi_os_execute_deferred(843) Start ffff8fb82c7b6540
>> 000000003edf1e05(ffff8fb82c492990)
>> Jun 14 10:37:13 strobe-jhalfs kernel: [ 5.944387] acpi_os_execute(1101)
>> Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8fb82c492990
>>=20
>> and so on without stopping.  I could start X and avoid seeing the
>> messages, but was afraid the logs would fill up the root partition if I
>> let it keep going, so I rebooted with another kernel.
>>=20
>> Was this message flood because I booted with "ignore_loglevel
>> initcall_debug"?  In the logs there are also lots of messages like this:
>
> Is there a acpi_os_execute_* flood? The *few* at what appears to system
> startup and might be normal. If there appear *many* more and are
> constantly printing (check with dmesg) then we might be to something.

The kernel log shows 305 of these messages in the 4 minutes and 17
seconds between the start of klogd and when I rebooted.

[...]
> I attached the updated acpi patch. It limits the prints to the
> kacpi_notify_wq queue which appears to stuck at shutdown.

I applied this patch and rebuilt the kernel.  After booting 5.6.4 this
morning there was again message flooding and this time I was unable to
log in because of it, so had to do a hard reboot and booted with 5.1.0.
The kernel log shows 207 acpi_os_execute_deferred_notify messages in 3
minutes and 6 seconds; here are the first:

Jun 15 08:55:22 strobe-jhalfs kernel: [    5.943848] acpi_os_execute(1109) =
Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8d7aaba18990 <ffff8d7aab157fc=
0>
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.943851] acpi_os_execute_deferr=
ed_notify(851) Start ffff8d7aab157fc0 acpi_ev_asynch_enable_gpe+0x0/0x2f(ff=
ff8d7aaba18990)
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.943865] acpi_os_execute_deferr=
ed_notify(853) End   ffff8d7aab157fc0 acpi_ev_asynch_enable_gpe+0x0/0x2f(ff=
ff8d7aaba18990)
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.944104] acpi_os_execute(1109) =
Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8d7aaba18990 <ffff8d7aab157fc=
0>
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.944106] acpi_os_execute_deferr=
ed_notify(851) Start ffff8d7aab157fc0 acpi_ev_asynch_enable_gpe+0x0/0x2f(ff=
ff8d7aaba18990)
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.944115] acpi_os_execute_deferr=
ed_notify(853) End   ffff8d7aab157fc0 acpi_ev_asynch_enable_gpe+0x0/0x2f(ff=
ff8d7aaba18990)
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.944406] acpi_os_execute(1109) =
Adding acpi_ev_asynch_enable_gpe+0x0/0x2f ffff8d7aaba18990 <ffff8d7aab157fc=
0>
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.944408] acpi_os_execute_deferr=
ed_notify(851) Start ffff8d7aab157fc0 acpi_ev_asynch_enable_gpe+0x0/0x2f(ff=
ff8d7aaba18990)
Jun 15 08:55:22 strobe-jhalfs kernel: [    5.944417] acpi_os_execute_deferr=
ed_notify(853) End   ffff8d7aab157fc0 acpi_ev_asynch_enable_gpe+0x0/0x2f(ff=
ff8d7aaba18990)

> The interesting part is to see if there is a acpi_os_execute() adding a
> specific event multiple times which does not complete. Maybe at runtime,
> maybe at shutdown time. If that is the case then ignoring this specific
> event might fix the shutdown problem. With all this information so far,
> I don't see a relation with this problem and the commit=E2=80=A6

In those 3 minutes and 8 seconds there were 5 "Adding
acpi_ev_asynch_enable_gpe" messages at the beginning, then 185 "Adding
acpi_ev_notify_dispatch" messages, which kept coming until I rebooted.

Steve Berman
