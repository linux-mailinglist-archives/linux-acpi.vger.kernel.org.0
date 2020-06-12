Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164241F7DDF
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jun 2020 22:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLUB2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Jun 2020 16:01:28 -0400
Received: from sonic303-3.consmr.mail.bf2.yahoo.com ([74.6.131.42]:46147 "EHLO
        sonic303-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgFLUB2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 Jun 2020 16:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591992086; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=q+znbJK1eSXC89TjW4vze6yMkD4TmtgXNY3JPQZwyrzduMH9B12FXuy8C4enxt/vl/6VRHQ6d1OjqjDJ1ahRoK3VRSCkkoSMDAKwJY3zzziNSxgcSTo8M3xfgQFCR1Kv7fymyKzXEBBvESwZGrTRuY91ymsNOXhEUV84jTI4DU0UxLRESI5Enn0ONGEJ9qR6SFCwCvhsIBJRvqv93kS3a1Addm2C74m+4tV9RHt/puyV9mZGX1zJniyuH6fLCw9zxXHmQgzPnAtwaFE2CJ9iZvu2ufqsBiR2FrakTD3TNWLpF+/8Q2L5354Nz/s7NkqYlzZaJxAVpArJYq5NNRhLXg==
X-YMail-OSG: nak9_PMVM1mydD3CQ727VQTAjSvhAKaBitm.EZlksSeIiOchakzKxXoc_.20l6g
 epmjlvWIGEQUdLbswW7LuKMc8xoale5vDMrNX8Y0cfW6wq5ihfEkUSo0V_5L0mKfiKkk_ZdVTHw2
 2IRNFd0L3OoqiCfWSsgElTWFlGp5j70C4mmZi70KCWkyexfBBMEaw2PhRL4npZandLa9MJ7Gd01G
 Y53cs_NBr4P7AAkd75DsoDbO9H7q0lblkM9kMir6FIatWR9sdgDMyLiAZVm2ysxj2IvVhUsH.9w5
 EGP27XRGybwmfiGivSEleQTQl0WWIxObnq7CB2MaMJtmoRXe9Qf0kk7_Nj0y5OMcQDvJ.9ONzxg0
 bPBuQnDEwMGwkEQ4q.GxtBy.i.EMN8tAikWL3DJJRHXxbsx2riApN83jqI2JbPd0QYfNLrqDleWB
 PN93WMk1zNEKKW3gGLL9MKzMyU_G1CYF0iG6T44dWP0XFaKHZAuYSlBK1xkw59ZKfxgrt0igzKVt
 w6olxQuEJZ8gYoXCysjBFdUPspHUKoN3pGOpE0XZANhzcbrOKx1g70wkoH91Zg8xYh9ETI2UferD
 TJZjUT7Yh124TLDSrWEcrEr1K12tv.ZgM1D_hhIUVzUVcIPGsIyg9cVxKCi.yv0gWg0C08bAtKV2
 3yikT5vt2oz6MiXO4n5xJ6j96xH1c2vzX95v4b5TQmrbtZuk1EG6AIj5kdn89tziM0i0HSjt8JI5
 bYiBrZt5Z12.vphAwq01bRYgdAcvMGo0cKkK55rpTXkuPihw19y0QL9NCj8Rp1b4TCDG_7oPSvm2
 RvEJYAogwq82Ld7gFwveueYtK7KyA85nhnj3H16GyA5rVLjhoPovTOWLWruXNUZQubgARbbGtxqa
 G9Mez6D086ue4yY7_qydQDA.l_D9yZJ7HKtYjBMuXxCNzKspEiKrSkPNpCBOckQSxOlZ9q7YPqYG
 bqmGoChqX6MB8Ddvy9U9lXRFoBBfKUzm0MvzhPFqnUfvjY4JgrPK5gibS0O8u7ogeQRONaTCKR9W
 P7LgWsX7UcZxnNCKJgKpST6l2p2nZ86jjitVE7zEkhfyBWOsNhu6gYeK3u1y6YkNOHB.VqpuDo9M
 56ClA4ZG3aiTcGWEW3FZ7WqNN_2O55cIs_P8Qk9PSvE3.7q696KLE2OK4UGCW4fmJ0MEA5uRXZOc
 G9cn15asgUlUSJU63G4BxAWhg0NcsarmAFuFeKRfsi1eikv1CQxFHU_lv4PqfMUdE5MLgPTzpDs3
 iICpfqNyRppJuOBd08x5X9d.8WQMKRSmahXvu8HT4gGedzEVR63e8m7wm0a1t3bam.uyOMgNFQBQ
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Fri, 12 Jun 2020 20:01:26 +0000
Date:   Fri, 12 Jun 2020 20:01:23 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <brunelminaa@gmail.com>
Reply-To: mrsminaabrunel63@gmail.com
Message-ID: <1724622544.36850.1591992083216@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1724622544.36850.1591992083216.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
