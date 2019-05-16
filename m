Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A220CA4
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfEPQL7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 May 2019 12:11:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:51275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfEPQL6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 May 2019 12:11:58 -0400
Received: from [192.168.178.167] ([109.104.36.193]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MiJhW-1gn2TT1ffC-00fP2t; Thu, 16 May 2019 18:11:33 +0200
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <4803994d-f519-a6b6-f5bb-a2f50d91ecd7@i2se.com>
Date:   Thu, 16 May 2019 18:11:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:HfXg+VerHg3XpZ/wJRmyjEJyPoEOVangfVhRYd6re0+8tLoYnmn
 oW1tto1qS1QQOe7GOCE7EoevUdRqBEDQ///1l974DU6oDx8+IabIbaeHwU/cfjP4DjKA6Br
 iX868FUXz7c1nOxAIHoyQKpsGy9mRzS1My2eaC6up74sSVDaK/QmuAXrROr7bb8NTBl3wqX
 WwVEm4CNLpPMKwjYQor6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xkwv5xkBN+U=:bwfz0IV+WlLUs6KTbOUP5F
 m86RxkHI2Kj0QzfcXKAjfZ5U5Tv7ptnKNtgLYdvqIaRk+mynEvOkxWqy/MzaMhk2DxJ8qmr1i
 FBBq9iBvmcz6A0jmH8HHgyLkeFMI4b1ivawHRk9zA+MuopGSHO7SdkTaytpD95zlyhTHG7ZDQ
 ucuLHN5pnxVV68A4Nmp9c0lUFiAVLgEK+i/F2C3PPpQ0XCvarGXzmUjPrxOHJqU2QX6PvWsGX
 7Q9b4MC3s9hQr7h6v0tAOK3o6Rmu+Uhgbp2eEQrGQ8hdzl6K99Bznt7mBbvxE1z2aXy5hPFUb
 OV9sLFfI8Kx69V1noe0ltzTDcdPaH2a+ggeMHMgiSZZ9xquruK+FaGafE4VQTIudsJH48+EIl
 rSt1kfKbUf/shkzxbsBa/sbVRmRUl1D+AK66qqyVbU/BiLoaN6Qynfy/xLAcuVSILSJOY4dbR
 7JdgG3YikQQCtVEL1l6/s9BDOO7LESCW0XUCY5LGG+iLrAm3N4R0kYfYfuwW78nhncv8jtp0m
 sr0lIxldMQxoJvNbROex1vVUYSmoQEQq79zvls/eFyz56tPHv1DY/EovlT4wMNQR251Wjy0dG
 T1UGNyfAZBE26//8UjJj16wsHH76ZeD17CE+X5ynrrYrtdL0Z6By2LMrwezH072eTf80EEZWU
 rBOygeHEXUARE33jk7VUERqnLNl4Jm54LKIwbG4Djr1MUF7bzT0Q+/QXFtbrCrW1zLGjwZy74
 f9Pte2LM5Iz96JyVVZepWzFQnZb4JJPFlHnxWCJVjG0cTnXW3KZNh+p2ZO8=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

On 16.05.19 17:07, Linus Torvalds wrote:
> On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.
> This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
> support via external interrupt"), which added a timer to the pwm-fan
> handling.
>
> In particular, that timer now needed the same kind of cleanup changes,
> and I'd like you guys (particularly Guenther, who was involved on both
> sides) to double-check my merge.
>
> The way I solved it was to just make the pwm_fan_pwm_disable()
> callback do both the pwm_diable() _and_ the del_timer_sync() on the
> new timer. That seemed to be the simplest solution that meshed with
> the new devm cleanup model, but while I build-tested the result, I
> obviously did no actual use testing. And maybe there's some reason why
> that approach is flawed.

i will try to test on our custom i.MX6 board. Unfortunately this take
some time since it isn't mainline yet (at least until tomorrow).

Stefan

>
> Guenther?
>
>                     Linus
