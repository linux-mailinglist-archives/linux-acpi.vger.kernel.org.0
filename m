Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF1A289006
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 19:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgJIRcE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 13:32:04 -0400
Received: from sonic312-21.consmr.mail.bf2.yahoo.com ([74.6.128.83]:46397 "EHLO
        sonic312-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731996AbgJIRcD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 13:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602264722; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=i4yeVMf1WmzzZ2gNvIXKaGXddbat6nzn+ZsvKRd8ZJfHnUksDGlOOtNXW7RxYs+O2aetC1K9JojQy8eayXuZwtfsAiDX51e1kblPPWDW/1c2ZHYERqKc0eyhOY5p1BorHyx5/U7ekEOnKs0L3FHelY3KgJJgrDA0iqjH82Urne0vQml3XBEyQSn+1Lw4YCqrMyvlrGKZCQt/4CesS0hQu+EstL2rg0LsaE3Wy4nYz9XX5E7uLoAxvhUOEWuIFs+O4ikuXYJso807XWtS81AW9pNGNPEvIQbOdrmsny/gXVd+W4L2+AH4keCBvhyz636G+azc+97+Hj9PCHWqihoqvA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602264722; bh=RYhzEYt6qJdZ7zGcneJUohepkSKimQxPkalnlCDY/ci=; h=Date:From:Subject; b=lwLZ11brptxByuXUNSgg0U8FccqLztm2gaIeu/WWUEbzHpWYP45h/Z0Jg4lGNYbfAjkSuLkDvhPvg3N/iWhlVBAfuNaQeO+AFWZ6H62ZLQzxUpCEPuez8aWuc78tAQ8AbqqBqx5TlZwN+0pTNUZPJeilUKl99w76hRsEGjpIX0Aj8RIjb6z4KHkGQkUPudkmTRROFgUapnAKRmbSlR4n52+4bDxkvEwEg+VPAke+QJoVbzsxYuMzuie7reK/8bgXc7fA63Odu5tPMho1Gj8CxkOo4WnweUpF6iBinH83hLbIP7Xq98R+e7X/Dj/stZwTABKa7LPMdZ0dIpCcXeMFRA==
X-YMail-OSG: QXkto0IVM1ksLG3UQ9KQPAfw3n9W0qoZNAGtiXfYg5lvdmWUY_vV5aTvOFc8OMy
 ejyIt2PoAfxSHpazWNO5nRO40J1vp8HmGAfehAEO0nBkem0aJ.a.GhhA4gHvW1oXNkdUMKigVsaa
 YfE1xYIasd39pmw4MQ7BmUcrtHH02j9oRTXj7q87Hv0XTH2vg_chjbOTk42fHPkOjQmcYaj5GXJK
 mY2.RI55WH4H29BALUInGlp6QCbdWpoDc4JlOnvyp6d9z9fDnny2JtX9rO0NpTJY72.PGYicVBMy
 6EuRjFMrMCEml9HKSo8QBDh548EtkaNjBYWxEDxt_4YWn6567fxVvIvN6.l1TihiOhCRJBZe64hi
 zewXIaJqwaw0RxpQkUSCfjPnluHixpJ8S.s_2kDi0muJJmiVjY_Mjd.pkJXjjHFngRmPS6aNR02G
 hr2UAIg1.jzsokjfdOjFZ9Yy21SkrxwsfNQAu5bZDy7DzyAPhoe94PV5VrduJdvrMgrbwuCa_d4e
 qu2MVwJRey5UUcPTWp8EPfeGR.0dhFAZoXVlCj_FV.mfiWDdnkkdluekA1010s5ocS.uo.4VN4Q2
 OKJp76lUQGFka7lwtAkYh1Ff5gWabgU5AtYcQ72gDFk1VUysTrqXJtwu_NzzabJV.DYzfLGmIH.L
 8x_.mERlyZu7qeezcbQ3LUGlfihdNUfXctWx6KqrkiOF.nPJZzonrdUAKWCv7XhuIjA2PLET3dss
 w4NqAm9Wf7oB3PX8UHQIOBrqb5zjv3WNDc_0e06GHVOTTdF1wp7nXq2.siS60jsvTC0wDGBI.vpv
 UE_w2qgAMUJ3smCYfwub3qblns7p3KNvglfh4UQgjYUKa8XVdughXSIyMY3mCW86k9k4.MUPOPdW
 Brci5etghJNnQAde3ywRA8N0IwYLpF_PfjVPMWi90Fsb8IISYwMQpv4xPR_aXEzqPTIeY4qgZ.2_
 62KwcfSQ5fRCBMTwRmJcGmVr9JysknJjf3CHnyL.VeHdrnVuZLQPYEiaeS_sEj_mm_VEbbAWZWE1
 wN9GGsnEMuTrLgONZ0ijRDb240Oo4B.bWGcXBqN4Um_qAKv5700iQxkp0Q1NekobD6bIDBRneU27
 4RPfR6_rJGyFePxc8lkpYX4_4keULcFaO9EYENGr7RieKhu61olI3qDe8HTSFoD7NEY__EoNPDqJ
 Xyd2k5x3.Qrr1_dOS4ozUu1mU9TOongnD0Xsf5Z8s5fbXSdgyLcx0WGmsdwHAtXyPBm.TLH94KcT
 wWSwh7dcRTtsdTaF3MElT0rE1d5MVtbD8TbWeQEz14hti3nL8A_n9bhgEuT1tb8yfaorO0vscM5B
 Awc.YvDWKllstzj9lIhEYHCWmA9nMHoYjD4Lo6DNivzL_sBScyAmHcrcVIxrqT_7oNx4N3YJpWdA
 uymTMNlmf18Cd5mwzvjVSBO_mEPj1_N8zXemTERO1J3KXqcKc
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 9 Oct 2020 17:32:02 +0000
Date:   Fri, 9 Oct 2020 17:32:00 +0000 (UTC)
From:   Ms lisa Hugh <lisahugh531@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <70189328.794834.1602264720676@mail.yahoo.com>
Subject: BUSINESS CO-OPERATION FROM (Ms Lisa Hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <70189328.794834.1602264720676.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
