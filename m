Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AFE301C4A
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Jan 2021 14:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAXNmJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Jan 2021 08:42:09 -0500
Received: from mout.gmx.net ([212.227.17.21]:39869 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbhAXNmH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 24 Jan 2021 08:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611495617;
        bh=7wAgiPv/ohlfCwMg9tisuTy2ke21tmeR7vAqXMCF//k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=SChrum711pKVBIjmSlABNs+x2hOuQJFGu990dPVjstBuVa3XJhnZgdXnFJJwOJsKR
         48xVIWtv1ypWU1OBVXDCPMcKBXxtZplzkjN+b4QaZOPIZ/1oL5o+krXFmxaQ9k3Xeu
         ewIYOY1aBDHuH1Y9/wfX43rujVJE4Ibn9ISsDr+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([178.6.215.244]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhQC-1lp3bx2ZLY-00nimQ; Sun, 24
 Jan 2021 14:40:17 +0100
From:   Stephen Berman <stephen.berman@gmx.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] ACPI: thermal: Do not call acpi_thermal_check() directly
References: <3391226.KRKnzuvfpg@kreacher>
        <CAJZ5v0gB4B_Os0VQv-F2SdVcJ8_rUdjic6rOEjOd=ZWhGzdLdQ@mail.gmail.com>
        <87tur9vscw.fsf@rub.de>
        <CAJZ5v0gQCxcxiFTtZ3Ea6gbY=WFt5oD4fq7vpQqvkJKqbg1=rA@mail.gmail.com>
Date:   Sun, 24 Jan 2021 14:40:15 +0100
In-Reply-To: <CAJZ5v0gQCxcxiFTtZ3Ea6gbY=WFt5oD4fq7vpQqvkJKqbg1=rA@mail.gmail.com>
        (Rafael J. Wysocki's message of "Fri, 22 Jan 2021 17:42:59 +0100")
Message-ID: <87y2gi78sg.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:buJeilmTKkwZrrO4ttbUapuQh6eQwztsRUMLtUVAxpJ7r+EanX0
 1ie17qHLsRcTkwBCrP13Eh6MOH1zr3/Uguc1MpV3S6hICB7bc6/4N5G/3qFYACstrDJM4ak
 nQguyIggxCv3X5OyZbDM1SdgbcORYjRLQnLb1fGPjVlilR/otie3ILtrYM/TDbOXxIpiZfZ
 214V32hsDkjFqiiQZltOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TE7LdZBVTR8=:W4v244fL6cpGzG85dTMdb4
 st5RoCG0bXU+eovNx0TvvZX9s6F3sqrTReeqh//bwz0MVf7MyqPKMyknW4c4agFRZVzEvqux/
 dP8tFfBCFaVwFppRRxlH28Euqkj1BBRU4BHSs7J2aY8YcBm/FQDauQDvPFoh/G40LwctyHK/1
 KsX/ndF0MenmY0EDolzH2UIwSuFfCCx7ERiUCl02rk2R2YTh/TVRNTah7RC5TBtNOhU3K3atP
 KLZXlVsSKc+nPeG9jyAsjZFuiMpixz6ncsv3etY2csflm6jJY0Ux7XYOWlFmvEb4XfxoSHpKu
 ygvKRnu2msIKZtC8yUPkCtQVCze3WTokN8QWVGjWzMI0I+UU5QasN7kCk7l/xETzFaRqwQyPC
 vKdVuZeB9NemYlXYVHPn15s+9+aprFW6K5aVCdUA06tyug4WtNv7F26+nrkFehZjw4eATUqVd
 giKD3YlThrU8uxADkg/1lZs71Co49zfk3BET7mLnXTCSuwg75oQV7DkswWLn5PxzHP9e7ozca
 w4hUxEuKCIc00qHhpUofa4xr44mqjUQ1friZbF2lQJGOiyqY8HfOkp6V0iTpiX828GYmVQe+i
 XNHuxyuaoL3hDrTH/YERlNYc0wUUsXNB5HfqKtJ7C6L5+XlFNaMfkUb8J5W4zNe/a8nVB3Nz8
 dE2h9CaBFdhbBmZ7hkFjIVXSHPapo5jcJEkcnrGSisbKOKAItsRHMqU0eCyVZe2eK9ne1DcZU
 h9Lux2CnPyNod/fbTwUWJPpy94a2oqwcbR9BcfJlOUlh0wsL5x4RS1q6jNHkyBm/1hhpwAIGt
 BKmay67h2LkGU55CuDc/ZuFCNH3MFftqKWtNTgNpCZMSQd3B8a2Km+y4yCNv8Pc6gaodfzh4o
 nZqyyAvAgO2XaadH/qWg==
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 22 Jan 2021 17:42:59 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Fri, Jan 22, 2021 at 5:39 PM Stephen Berman <stephen.berman@gmx.net> wrote:
>>
>> On Fri, 22 Jan 2021 17:23:36 +0100 "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>
>> > On Thu, Jan 14, 2021 at 7:35 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >>
>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >>
>> >> Calling acpi_thermal_check() from acpi_thermal_notify() directly
>> >> is problematic if _TMP triggers Notify () on the thermal zone for
>> >> which it has been evaluated (which happens on some systems), because
>> >> it causes a new acpi_thermal_notify() invocation to be queued up
>> >> every time and if that takes place too often, an indefinite number of
>> >> pending work items may accumulate in kacpi_notify_wq over time.
>> >>
>> >> Besides, it is not really useful to queue up a new invocation of
>> >> acpi_thermal_check() if one of them is pending already.
>> >>
>> >> For these reasons, rework acpi_thermal_notify() to queue up a thermal
>> >> check instead of calling acpi_thermal_check() directly and only allow
>> >> one thermal check to be pending at a time.  Moreover, only allow one
>> >> acpi_thermal_check_fn() instance at a time to run
>> >> thermal_zone_device_update() for one thermal zone and make it return
>> >> early if it sees other instances running for the same thermal zone.
>> >>
>> >> While at it, fold acpi_thermal_check() into acpi_thermal_check_fn(),
>> >> as it is only called from there after the other changes made here.
>> >>
>> >> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208877
>> >> Reported-by: Stephen Berman <stephen.berman@gmx.net>
>> >> Diagnosed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >
>> > Well, it's been over a week since this was posted.
>> >
>> > Does anyone have any comments?
>>
>> Sorry, I haven't been able to make time to test the patch yet, but I'll
>> try to do so this weekend.  Is it just the patch below that I should
>> apply, ignoring the previous patches you sent?
>
> Yes.
>
>> And can I apply it to the current mainline kernel?
>
> Yes, it should be applicable to the current mainline (at least as of 5.11-rc4).
>
> Thanks!

I've now updated my local repo to 5.11.0-rc4+, installed your patch,
rebuilt and installed the kernel, rebooted (without adding
'thermal.tzp=300' to the kernel command line), did some normal activity,
then ran 'shutdown -h now', and the machine did just that.  So your
patch seems to have fixed the problem I reported.  Many thanks!

Steve Berman
