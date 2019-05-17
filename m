Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B962181F
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2019 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfEQMZw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 17 May 2019 08:25:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfEQMZw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 17 May 2019 08:25:52 -0400
Received: from [192.168.178.167] ([109.104.37.130]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N4i3d-1gi8y90Jhn-011mLu; Fri, 17 May 2019 14:25:26 +0200
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.2-rc1
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190516044313.GA17751@localhost.localdomain>
 <CAHk-=wiaO_8SiEB9QM3vOTniiT67K6CBH0uHJ82-Dp_+6kxH3g@mail.gmail.com>
 <4803994d-f519-a6b6-f5bb-a2f50d91ecd7@i2se.com>
Message-ID: <d6da5203-c113-5cec-c12e-9af91a9ff716@i2se.com>
Date:   Fri, 17 May 2019 14:25:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4803994d-f519-a6b6-f5bb-a2f50d91ecd7@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:f5a1GGMzwh+OJVKp3JEevbnxv4E4pHWmhaLPs4AP+6XsV4DhPVI
 1ZC4jRQoyl9v8RmeHk35a2Z+mETuGNKmnSalWnfyWN3xuqgq6wyyj4zMJ93nflBbzD2KQ7J
 oMteAHY2B07z65HLNdvYftDwhmb/ZxofvDOW3t2+5JEY2bdPOp8msDZztRhVgGLCcMIeVfy
 oJWxd9caAfRPHR+p9dlxA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cqbDtugd1ew=:CgicXDFd3qtxngcDKrjVr7
 ZgnuByVbxmgO8qKH+zqNdqbbY3dELmRo8Nwy3YDhZziw+/XvQ/0WVGdjFg5GFBA8bVXlvZ1pA
 dNDb0F4M1keUPQebLWqwHOkHVr/MuC+OsddbxUVmFCzJyHQ/6P3AWHU0wb1hY6tLGgLXkUotw
 k8af0d8TYRgtOcPgS0diKDE588GiOdHIiOysfAxoTN+SzB+H2U1DZWYT7AOYhPbVCIvYD8h6W
 GsZUe5gvOwlMmpJe1mdprG2GCUSciJd5xxN1eeYoaWrNaNtdELWKFscw0Q2kWJ0Z4OrnqptSr
 2k3r1ocNiS1qliMQpWNj7QxilEhVpbRnbC9YrxwD/U0sDaER9DPbKf4L7iw1z0R16oRXk5g2F
 llntN61/SMKG55Cj+a2zEhdnYqRJ/3VTsuoJK5zP4A5ABIkcmzPcq/o/1PZn+5yBdK7lEmuS3
 UyI4VXxkuRyyLjSx1NR/Ay0mMgFRHzekggtHklBX5kCyKcYjukstTulL1xFbLud1sitW73BQk
 qhhcYEOyRaX6spwBvvOEDxAH/vHXqyKsTfLtI93oWKeNuvJG/U14vxq4yPQtF+uz4jnA9x5y1
 XrNysL4X8nbh4uedlbyuq4Adm/OuMhJgIKlMF7DB8FUVPd/B4IjxS9tlQhEx8DvDEVQfrzU9D
 MsnIJo/zVc9b8BICMBNOQmx8sAFTbOxsq2koIJnRNb/8gNYU8FeJaeRAU/B4t1ic+40an2YT2
 30KSelRlJ/5YC9mDdaL4w8Qqbb9nhNI/ZbD3bB4lhmqJ9EQvOSObiLt5npE=
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16.05.19 18:11, Stefan Wahren wrote:
> Hi Linus,
>
> On 16.05.19 17:07, Linus Torvalds wrote:
>> On Wed, May 15, 2019 at 9:43 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>>> - thermal core has a new devm_* API for registering cooling devices, thanks to Guenter R.
>>>   I took the entire series, that is why you see changes on drivers/hwmon in this pull.
>> This clashed badly with commit 6b1ec4789fb1 ("hwmon: (pwm-fan) Add RPM
>> support via external interrupt"), which added a timer to the pwm-fan
>> handling.
>>
>> In particular, that timer now needed the same kind of cleanup changes,
>> and I'd like you guys (particularly Guenther, who was involved on both
>> sides) to double-check my merge.
>>
>> The way I solved it was to just make the pwm_fan_pwm_disable()
>> callback do both the pwm_diable() _and_ the del_timer_sync() on the
>> new timer. That seemed to be the simplest solution that meshed with
>> the new devm cleanup model, but while I build-tested the result, I
>> obviously did no actual use testing. And maybe there's some reason why
>> that approach is flawed.
> i will try to test on our custom i.MX6 board. Unfortunately this take
> some time since it isn't mainline yet (at least until tomorrow).

Okay, today's test based on your tree ( a6a4b66bd8f ) were successful.

Thanks
Stefan

>
> Stefan
>
>> Guenther?
>>
>>                     Linus
