Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20C1F9D08
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Jun 2020 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgFOQTc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Jun 2020 12:19:32 -0400
Received: from mout.gmx.net ([212.227.15.18]:57969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbgFOQTb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 15 Jun 2020 12:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592237959;
        bh=pT77xwIyg5fdLwWqVyEl7LfKJAAWp7HtQdcGpD4ikuc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=DmL6DsoicACVVLfxurlPPEtO8vK3gkrBkvmX5YPQuLOLwygVgp1i2K4LiAjTuw8ZH
         cx86iGqAWroh63eKU9DlPzY695dijHsj7exC+Gv4RKV5RzIyaipNIsSqKoMx3dyKuf
         8Zz7r3bsVa3KJhRSSeNiL39BTADhDUh7dXAWN5bg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.165.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1jXihL2Ovo-00M2z2; Mon, 15
 Jun 2020 18:19:19 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
        <87imfyh6yx.fsf@gmx.net> <87wo4dligz.fsf@gmx.net>
        <20200612110122.jossn5zrktcvpbpm@linutronix.de>
        <87tuzdrgm5.fsf@gmx.net>
        <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
        <874krcsquv.fsf@gmx.net>
        <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
        <87tuzcqqul.fsf@gmx.net>
        <20200615155846.nd5n32qggusakxl7@linutronix.de>
Date:   Mon, 15 Jun 2020 18:19:18 +0200
In-Reply-To: <20200615155846.nd5n32qggusakxl7@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Mon, 15 Jun 2020 17:58:46 +0200")
Message-ID: <87pna0qp2x.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B6nN4qd35ZcpNV/+g4XvNSLfvahGBT1BOzOpMPdf9LQsSWO99HX
 4oUAVkqdjRIfx8RiDDMhfPQREolVALZz53Bj/L5uu6Ni+nK5zBmd8X/f0Hy6YZK/sDtKfr8
 GF53V056/HklbpdUkHZfUNcKld7+Q/aZU4bo/ULXwNLbluUG6WWFVIcXHcfxRhZ/8PbFrWZ
 wfN6SewVMMdwwkKGJp1vw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y+soa4AeU/w=:C353QW0PCdUx0j024JugMW
 jbkEChrZaAlM4UNcLuY2kfXvwgwqc/YwWVe8LDO1JR0S5DSH/iflGg5BaSiUpZMfZhXk5GYND
 AvuW8FzyCnDoNErYLqmxdZp8EpTWaatcTO2glgF2XoLGxJxgfy4AYgRmwEgRU40OWQj8TdBi7
 DPyZplAj5ejYNTmnhsA3zZ7SqyTu+P25TXDlqqRcjmqSwIE+Uw9h+HX56TbBc1w6nt9/VJyu4
 PiGM+IZduvwCbgapSqveFuZjPFoJwTwvbQ7t79j5d/3xGAZ/7YxekFvxM9X/otY/9NX9cxIA1
 QkR4tkumo3ZG0vhnNuwZZhZYHzaIvu4S6JVzQ2H1odX9iemy+j29nsWXX336xTsp5DYz7pDbt
 6Qos9Rt5oICAxAYUYrW11uFPs5V1v4P3s+46LmWIEtHjHgAa+NEbwkcOLLrB3aHHmfLzTwgei
 FihqkXOFkQ6H5j5pa1Kx/Ew0VH19/QHtKQlfOjKbSGt+sbsA//fp8Le3D44Ge+XXaRoNw7OoI
 G6ZoUdn7mruLrEXHLoTNCApTg4pkDScKxJJXwUwWvUreKTGsjVrBocDESI8EI/FUBvKWA2OBX
 CdvPlgsmVLOQslu+0f94NhuH+VAakxx307c2Wp7XbsTSLrxR/0B4w+MaupzdO2YdAMobsLi2B
 PWVwXkatO6l04SvUbo6nRph9ZW3k2tR5tOJFHD2tgS7Z78eoq63lW1o+Fo1nrgBtJXibq3HpG
 uvPsTeSuWDS9Z56UDCWrB6Wyr2vYQXJMR23r1oNr/FBL+pt/7DnVi6+2YDCzywAeZyoSqBPR+
 hKTXNaSZICYuC6astaFsMJdLu4me5ujuzn6JHGeOd3nccatvfiGSZZUbPWi/giIGzaH1NaTxN
 f4yftTt3oeamDAtwYYgZR6YtShnJw53eqbstPrgU9dXBmlfeRdqXkTETLBaGCiJvNRMso/FgI
 CLQo4MmndNyf4k71NkwgLEB/MSiU844lRXtvYlMxXex+S3FsDy6RaECKNzS5m1jYNtGfxCwmD
 ieNzMrP59o2yLVTBWOclFOgGch9jzww+61We+opGdQYxWmnclhiUCoInPiPPWAxCj41rbjmpN
 1T4jA9bnIDEYHWgZGfdg5ighRBDEOdfceJpBuAozPXqG0vDv8oFGMeKga8LDzOzjC2plkeryU
 PUwp8t5B1X0medU/9oz61lPoQPsXjRlfJuKu4Q9c6H67b0Px40zIoMNXRWwjqnP/sdss+MuR1
 lVjUTBADjqIeF5z+Z
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 15 Jun 2020 17:58:46 +0200 Sebastian Andrzej Siewior <bigeasy@linut=
ronix.de> wrote:

> On 2020-06-15 17:41:06 [+0200], Stephen Berman wrote:
>> > If you do this "t" then there should be a lot of output on your consol=
e.
>> > If you do this from an xterm then you can see the output after typing
>> > "dmesg". The output should appear also in your system log.
>>=20
>> Ah, ok, I do see it in the log, it looks basically the same as the call
>> trace I posted upthread.  I wonder why there was no such output in the
>> console, could there be some setting that suppresses it even though
>> /proc/sys/kernel/sysrq has `1'?
>
> You have ignore_loglevel soo everything should appear on your console.
> The is true for your tty / ctrl+alt+f1 but your xterm shell.

Yet that appears not to be the case here, or I'm still doing something
wrong =F0=9F=A4=B7

>> There were in fact 99 "Start .* acpi_ev_notify_dispatch" messages and 98
>> "End .* acpi_ev_notify_dispatch" messages.  Here's the last of them
>> before I rebooted:
[...]=20
>> acpi_os_execute_deferred_notify(851) Start ffff8d7aa8758a80
>> acpi_ev_notify_dispatch+0x0/0x55(ffff8d7aa84e70a0)
>> Jun 15 08:58:26 strobe-jhalfs kernel: [ 194.339017] acpi_os_execute(1109)
>> Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a6730 <ffff8d7aabb384=
c0>
>> Jun 15 08:58:27 strobe-jhalfs kernel: [ 195.363005] acpi_os_execute(1109)
>> Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa99a6780 <ffff8d7aabb385=
00>
>> Jun 15 08:58:27 strobe-jhalfs kernel: [ 195.367978]
>> acpi_os_execute_deferred_notify(853) End ffff8d7aa8758a80
[...]=20

> Okay. So there is "Adding" of four events/work items in total, each
> almost every second.
> Processing of one work-item took two seconds, the other one took a
> second. These events are "old" so I don't see the "adding" line for the
> Start/End.
> You could look in the log for ffff8d7aa8758a80 to seen when it was
> enqueued but it feels like ACPI enqueues more events then it is capable
> of processing.

It's there, 196 lines above the Start ffff8d7aa8758a80 line:

Jun 15 08:56:58 strobe-jhalfs kernel: [  106.275356] acpi_os_execute(1109) =
Adding acpi_ev_notify_dispatch+0x0/0x55 ffff8d7aa84e70a0 <ffff8d7aa8758a80>

Steve Berman
