Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FCD1FBFFF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jun 2020 22:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgFPU3C (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Jun 2020 16:29:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:41521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgFPU3B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Jun 2020 16:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592339324;
        bh=2pcxNtxOxco1guBLo7NG7YQuecY/6crnNcCqmrQnqaA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=is2mj2dKu2pRc4DqNsDqgneXvL121xcu8x0wDhL7ns2TsnwhEixZ6yx3i1SnndQU3
         SCWe2KKK+9UCHY2p/v9fYgf5yqEZaykYPF8vQOPNGu2AvWJ2AyIAXjAz35M2SrrYu5
         Z8CXllhNz/AvXvy0i6zEvqmMPKb2cOUlwM2uLsJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([92.73.64.60]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1jYB9o2TSa-00M33E; Tue, 16
 Jun 2020 22:28:44 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87imfyh6yx.fsf@gmx.net> <87wo4dligz.fsf@gmx.net>
        <20200612110122.jossn5zrktcvpbpm@linutronix.de>
        <87tuzdrgm5.fsf@gmx.net>
        <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
        <874krcsquv.fsf@gmx.net>
        <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
        <87tuzbh482.fsf@gmx.net>
        <20200616073827.vysntufld3ves666@linutronix.de>
        <87o8pjh1i0.fsf@gmx.net>
        <20200616155501.psduxnisltitodme@linutronix.de>
Date:   Tue, 16 Jun 2020 22:28:43 +0200
In-Reply-To: <20200616155501.psduxnisltitodme@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Tue, 16 Jun 2020 17:55:01 +0200")
Message-ID: <871rmesqkk.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v6O2Oj6vpVD5HT5VMTCK58R+4ZYiC3+dCwrh+F5Wwhd8XCqu3ju
 sqArwwZb/HmbbXxk71EPzIX1DEtN0O4GEKux7YstO9rlXITe/SI+Ap1XBveZEMuRsFrvZkE
 0tjUWXgudC+UBletGoJZhfZlkYuT0K8ZtIl6qycWHN7YcT4wTLN0OniUOsIZitUHoPPzwiU
 /XI4EM0HhdEwURd21ZUow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lldolxazXTI=:j4Kripz+Awwf6u29+QdgeD
 emPZjh1Sn8vzKc0hoz6qnl6Jkra9bxcPc0AA27HGdSIL1IP6Er2MM/mERKm9EJxP6W4f6E4A5
 aZbPc1SaXDU9hZE2SeRcs9F8SK7gQlPOxoR1u82DE9dKWtpfKko7iASksExpQF8ASiQXTBIRr
 v2ISZa+AuOPYGI4eNEid3rGn/XtTsNr/nxJrgAE9lCpI6wsCjCK+XEQyvghNcmuLawvWZfvVP
 D5dnrUsaa2Bemv3kUgdW/9+8I06aK8uHVCr1H4lC0BO5dfpzEmx/XLMfn851zuDC/YTLV41fb
 4Ksk6hNnOxpJy56X3D71rkJrBwOsYrTJPR5L+woBQyP+ZdhdDY23gHSS/xREVjrT6ggCrzlMq
 dz4upZFQPtFyog0nsc2GMZxBVjGE2BkhZnQdSXr05ul94AfdE+B0S9kvsq3y0gMF6v99E5DXX
 nwhdlSLdgcMLXl80s+VSQtOKkbxVqItKqX30IP1reTIbKljj3RZru/BltXZ9LdeZH1M9+Lk5o
 1WxgSperTRx5jIlljIZxPeC7bAXE0V0iWmcHOrobs3kk+SZa3QZq8uUvaDgcidNbFjqlwL7fw
 DKxn6RSXgfMgvAHaNC87XjD9iv2BvqNgfhZMOO7Z0ovqQ1iRXN+hqYcyqomELhtB/NnIsCU6u
 voYXNxti2W/WJY914T32bv2yVqh1qhJ2I3RJLwdiY7tdiT7GQy/UfC9DFXmzaFkxm+VThvGii
 zMGyoZRdak9VJQD3POW/u/4RwB6GNorKIOXL6mpq4uZsw6LiM/ZJ/Ap5tRVvFHm9HD+RrQkqG
 gfEsVc6oR+thjMbHoefiCMPHoVJFZU4I//WCHV1LIK3aQHgpCCSIkbcACNd2w4hqqpTcF8JV2
 5EheD7hi4dOpx6J6LSFfC6a+sAkalUbt5LkawYzLBdIxn9ln6p8nP3+Yw4z/BgyO8KXeG9u5R
 ETHAHUTt8Rk5NpuXmOCieSFmk81GoKUrPaXTEa2OFL4j8eNo05RNBplILjCLuc7fZFscjQJMO
 6HCP/vhycrmUaRb31aQyjGXta5ErMmiVVQ7cL6ys3WJFsqrwccAoopTrY1YohwTsWUvGROKdC
 VRwLpSoUCgUS+E8jbwNTCkvdPv5ZqLeExlGSPIQxuBnWNenfR9texwUcZfz6fOzCNdVDQkZjc
 Uf9irkcs5RU8Tpy31x12oMRGZevzAefnu7NHDO0AQSMtzKsefDrU3le0HM00Sm0VJir5tcJpd
 HGcJp3csuQPSkllPi
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 16 Jun 2020 17:55:01 +0200 Sebastian Andrzej Siewior <bigeasy@linut=
ronix.de> wrote:

> On 2020-06-16 10:13:27 [+0200], Stephen Berman wrote:
>> Yes, thanks, that did it.  Trace attached.
>
> So TZ10 is a temperature sensor of some kind on your motherboard. In
> your v5.6 dmesg there is:
> | thermal LNXTHERM:00: registered as thermal_zone0
> | ACPI: Thermal Zone [TZ10] (17 C)
>
> So. In /sys/class/thermal/thermal_zone0/device/path you should also see
> TZ10. And /sys/class/thermal/thermal_zone0/temp should show the actual
> value.
> This comes from the "thermal" module.

Yes, TZ10 was in the thermal_zone0/device/path and the value in
thermal_zone0/temp was 16800.

> Looking at the trace, might query the temperature every second which
> somehow results in "Dispatching Notify on". I don't understand how it
> gets from reading of the temperature to the notify part, maybe it is
> part of the ACPI=E2=80=A6
>
> However. Could you please make sure that the thermal module is not
> loaded at system startup? Adding
>     thermal.off=3D1
>
> to the kernel commandline should do the trick. And you should see
>    thermal control disabled
>
> in dmesg.=20

Confirmed.  And the value in thermal_zone0/temp was now 33000.

>           That means your thermal_zone0 with TZ10 does not show up in
> /sys and nothing should schedule the work-items. This in turn should
> allow you to shutdown your system without the delay.

It did!

> If this works, could you please try to load the module with tzp=3D300?
> If you add this
>  	thermal.tzp=3D300
>=20=20=20
> to the kernel commandline then it should do the trick. You can verify it
> by
>    cat /sys/module/thermal/parameters/tzp=20
>
> This should change the polling interval from what ACPI says to 30secs.
> This should ensure that you don't have so many worker waiting. So you
> should also be able to shutdown the system.

Your assessment and predictions are right on the mark!

I'm fine with the thermal.tzp=3D300 workaround, but it would be good to
find out why this problem started with commit 6d25be57, if my git
bisection was correct, or if it wasn't, then at least somewhere between
5.1.0 and 5.2.0.  Or can you already deduce why?  If not, I'd be more
than happy to continue applying any patches or trying any suggestions
you have, if you want to continue debugging this issue.  In any case,
thanks for pursuing it to this point.

Steve Berman
