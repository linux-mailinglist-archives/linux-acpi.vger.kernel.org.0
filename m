Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40C301C58
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Jan 2021 14:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbhAXNvN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Jan 2021 08:51:13 -0500
Received: from mout.gmx.net ([212.227.15.18]:48353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAXNvM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 24 Jan 2021 08:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611496145;
        bh=6t7p+ubzc5ExiKD2mjKWy9T6CP2oz+YI1Q65Xx9AiE0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=LbZwrivibf2XpxS9H0Qj1EWuLOchFXHID1nPVmnCZwd8HKpBIOQRX7c/2JKFe4c8c
         ToQb6yYqhlLuDnjqyCK9IIGbAV18Ue63X2EQl7w+D4jGOM4GxCIY25NF4Cl63a+KP9
         V04Q3gC5Sl3ileqvsmgBBQeuLk9l4cR+kZVkaYFY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([178.6.215.244]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3se2-1m3Io537r6-00zldX; Sun, 24
 Jan 2021 14:49:05 +0100
From:   Stephen Berman <stephen.berman@gmx.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87blkbx1gt.fsf@gmx.net>
        <CAJZ5v0j86pX_a4bSLP=sobLoYhfQYV9dWL8HHf2941kXgND79g@mail.gmail.com>
        <CAJZ5v0j7i86twMS+csYMaetUkvqjof4FD2GRNoZ_AN=SBF7F1w@mail.gmail.com>
        <9709109.MH8tSaV5v9@kreacher> <87eej0iuf0.fsf@gmx.net>
Date:   Sun, 24 Jan 2021 14:49:03 +0100
In-Reply-To: <87eej0iuf0.fsf@gmx.net> (Stephen Berman's message of "Mon, 04
        Jan 2021 16:38:43 +0100")
Message-ID: <87wnw278ds.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:HsDFDuOCrFpRPPB3FO8bsMlhjSF8RI1vpxKBCbQVRxaDTdJgnIe
 aUCmUJZC220eCjuCXd6UdqNjohxt8HEgEcQwZKLoDiyhupDvf5a8QTkRUj3pM6zo7F2VIYf
 q+hDfmjNXm4lo1mPFSoQ0G/1hzx8hxbuuIRJlbT78My2rfn/EDJR+q/PJzLUWFVwARKaVEx
 mLxjbsHZMhnwikI1RhzxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:O4rYxoG+tuA=:0JeGgwsbdOi6LrpMd+rXHR
 oTpKK68bQ9snN2UBSBRh7oR91AV7If+XuNCJWMSLwZp1gPq1phdN73Vi17x0tegPK0iF/QvpJ
 Ov66YVqBreWz9vk22HhD/g57Yx6123yqsDtWOJ/uG21PKf9Q3Fwc95/AxyOBlVer6XJzB6XUn
 7KhWx6/ewk5G2Ok7XL4q5WZpODg7HREHabs7V8KpuVDKONaYUOaPuF7zEW4iQvK9PD/3H4BZ6
 SFSIwwRifMFMHGF7zEiVkXHbN7LL4uqBYxPltZjPtYKk6WfCl4iuOlz9rKLKdHpn2iNMyqJNt
 q2hB3chXgh0W5y1tDu6MM+2Yo2M8GLl8LIYJ/2TNwwoDRrDwNm8JjJdxGroDy+SlEbPmvnWf6
 +t3BsaU9FmTUK/+YwNu1N7sosGpW7JUQkk/b6fGxyWmbR+yjBKS8sxdT4lJYCawuzrJ3D14zR
 MIlP9h5z6kln5v0rd6FC0H634k8GfXDuhrQE7jHsg43EZGKOVv55aO9Kd5fsy1OvJ6xnEI/9g
 Ok686Y+aKI4CMC8GLXhhaOoQw6n17imx9ZY1WxoMVOm7+LK8bxC6KHGy6+pe4UC+aJRnDA0Wu
 aoJ+IKYNb9f2apgGcPUxgSkAFYNxZrtfkHP58dWTVI6+ej4BwvNKLIyQ8w91ij43qPJV7IoBT
 +ynF1DxhDBi7ueAQGdFt6loNES0jB202IbZaDxX74X8Et/bMpcjO3/RaK+JgreCH0w0gp7ydR
 AfWkxDpzXYW8oA3ksTnJdWUfKHGclyv2aBEHgeO4y7+gWS5EqV/bXUL6DUZMoEIqaRhW7NslS
 YqUKL8+IyqWiiIz4ubu7JXj8/w8ygBqiBwQWXn1ua0POM7gqdFaEM2cjBgodvCAfCwG8OsgAt
 BcXkMDGQIzO3KtVYIMaQ==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 04 Jan 2021 16:38:43 +0100 Stephen Berman <stephen.berman@gmx.net> wrote:

> On Thu, 31 Dec 2020 21:46:11 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
>> ATM, I'm tempted to do something like the patch below (with the rationale
>> that it shouldn't be necessary to read the temperature right after updating
>> the trip points if polling is in use, because the next update through polling
>> will cause it to be read anyway and it will trigger trip point actions as
>> needed).
>>
>> Stephen, can you give it a go, please?
>
> On Sat, 02 Jan 2021 12:03:17 +0100 "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>
>> There is one more way to address this, probably better: instead of checking the
>> temperature right away in acpi_thermal_notify(), queue that on
>> acpi_thermal_pm_queue
>> and so only if another thermal check is not pending.
>>
>> This way there will be at most one temperature check coming from
>> acpi_thermal_notify() queued up at any time which should prevent the
>> build-up of work items from taking place.
>>
>> So something like this:
>
> Thanks for the patches.  I'll try them as soon as I can.

FTR, since this is the thread I started for this bug, I've confirmed in
https://lore.kernel.org/lkml/87y2gi78sg.fsf@gmx.net/T/#t that the latest
patch fixes the bug.

Steve Berman
