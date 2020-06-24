Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A553207EDE
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jun 2020 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405030AbgFXVuI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Jun 2020 17:50:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:43013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404965AbgFXVuH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jun 2020 17:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593035393;
        bh=7wXSmny72DDzlFBHOzJHsQYTs3h/eNqrWzfQuIxdLrY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=WYxDfXe4FIN+7frzPKZmhUHly8tAiGM1fQMwy1gVqGiZD0hb10T+hP5DFk9lk6DjE
         av8aV8hqwVel0fC/xJudmIyhsP+b91c7DxWsjODYMSooZ1dw3vWNJyyDWJxwY8zu37
         xV//QaiYHlYvtYAUp+jFcd60U9o+7gYO4iyWfHto=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([188.109.192.212]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRTRH-1jSzfY08Pd-00NROb; Wed, 24
 Jun 2020 23:49:53 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <20200614171005.3zy673p6bpwoqnmq@linutronix.de>
        <874krcsquv.fsf@gmx.net>
        <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
        <87tuzbh482.fsf@gmx.net>
        <20200616073827.vysntufld3ves666@linutronix.de>
        <87o8pjh1i0.fsf@gmx.net>
        <20200616155501.psduxnisltitodme@linutronix.de>
        <871rmesqkk.fsf@gmx.net>
        <20200617142734.mxwfoblufmo6li5e@linutronix.de>
        <87ftatqu07.fsf@gmx.net>
        <20200624201156.xu6hel3drnhno6c3@linutronix.de>
Date:   Wed, 24 Jun 2020 23:49:52 +0200
In-Reply-To: <20200624201156.xu6hel3drnhno6c3@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Wed, 24 Jun 2020 22:11:56 +0200")
Message-ID: <87ftak2kxr.fsf@rub.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:EQTpHc2li/LqHMtC18QbFJaB46bEXzXpn5dYcVYsMWC0FiQRK1I
 04gMBRTb3OTGem3//R6UxLn59WRF1g6aaajqg/bqHnraAQqc1uJaVbOTdwaNXpsFVgLILY1
 BDy4Ozih4d0XoViS/wEhLck08dulUffbmZMjJLd1dAzJRDjLcoR5IOH7vfoBA1UbP1r/iS/
 CSgQ/SjdVFu1ROrGhGY8A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ad+DnhoBNF4=:Vv6rZi3leN3Sq7XT30V1DX
 8HH20t6JLp6VycVsrO3Ik2XP0TN3kQD6nYzS/JYlQDqC1ADzzrdE9iaAfQjx3CfwVHAJfE0Bj
 3Ul6lZJQmmPfaBIhwJVgqhgP/jnpGNlBOGNe8p1XrH1K7VtcSSsUcC+X63UNWxV3s81TRq27g
 3xQP42Ig5uz8IL89uJ4DkHCiw/n7KE9AO2KwAY8RBuDhYcy3rlBVlhZRQL6GjqJ4bIiIAknJo
 LWpxK+MlknbD4r9SRHrgxlFb4DT0b+Slby988Fo6vLhkMLIi89l5RX5CE+nd/HNot8YgVF0Gd
 KKddaDiHUJRD5BPPArbo9xFsUf0LORSOFh8Ppud3l+2992DCuEzFTnsZBT7f23wNmLPzrFv2Q
 u9fNyjT6v/0Zit3/4m5wEV5CsKne3RYEqhlVGlUy4zS0mZPJHqEax6F8hLNaJGjDeqz/19Zo7
 oLsIZoy8JNq5cpBvD3g0eEBORpZ3nNq+Nqzj1eHQ93g/U0gSsvcPOPGFp3TXpw82tfctz17ta
 e7TNVsU5jaak9cR/at4coSEbEPvBUdRSvz7cirN8STdBm1Jmupw+zdNiK6qXK4Mhy8FzgSMMs
 ddlt/sh+jkQVVwPmUeZGas6P1PFge4kyXoQjvXYbzmnmIcFZk30A4OzzI6473wLayBpEYC7XA
 tQh2UD43kxu/X1t3Zyo0coPmGwB0E0IiV16bEs/3AxIiq5z+hQrfu7eBt/DwqqOIVfuHAWmB+
 UrSVKesGEm8zx1xkxUcmJa+2AzhdVBfyjxny2zU4D/oc6+YAc4rXOvWvybwmlrVi4Si9qcOMv
 MEGYiJjdvd87Xds7aY2DcwHTVri5f+Sivco4IMX1iwMk9wjybXET33fEq88FJ8KMNdGOS8Sb6
 ccTta9YggHxQ2m1zbXtXlGA3yx9yFVaaO7jKa+yBtDTZBeFmNfsHPE3NhQ+PUQGiFkt0wiTgJ
 SxuCVRIAjJAo8meh3AcNM/OeevW3AntK7LTQdGS5SbmhHrZCKRMHciN3fQdTXM1AfN5wM8pVm
 rAHFZgCTA2GBiuvh5uKTy0gkDSaJn/4K3Q5ccgH0PK19Rss9x4+JuDRVm6XbcmhnZa7drw68p
 MOfpp4qzCdlRg167cILUjqvEbs4v/nhI2YfHQfd/JqFsVuY14xM2kRGOzZLXLgOt5DaTzibjz
 a3PPbUG9nM/6P72EJ6j8X/JRAAVyGWhPE8HyyVNR1uRyAFa8KuFjj18hS6mjZvO/KKAWJs7EU
 dqSMVHY0uLiZlnbZwza7gv3Nz5eF5bnp696sevQ==
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 24 Jun 2020 22:11:56 +0200 Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:

> On 2020-06-17 23:09:44 [+0200], Stephen Berman wrote:
>>
>> Attached.
>
> I did not forget about this but had recently little time to look into
> this.

No problem!

Steve Berman
