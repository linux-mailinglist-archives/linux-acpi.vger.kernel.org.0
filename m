Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5211CF81E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 May 2020 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgELO5j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 May 2020 10:57:39 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:46165 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730441AbgELO5j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 May 2020 10:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1589295457; bh=KB5k1+sCGpSRd9pTKc0P9/4ZGPy9ZVtmix5g8Hf7Eac=; h=Date:From:Reply-To:Subject:References:From:Subject; b=FT0WlNnNXkt0IqX6UPVz/7iqN4CLw3hgXjPFebC8i/gum420HtavgzRh7JKe9j92iCmsyN2TcjaYqz5Z2xgJX8HZn3y/TSHohxrQMdR0yUhEL16M77oDy3BFHm1M8Ml/+OI+cp1hHG0MbIgPNxNpbV9q2IUAxzAWt24fjZZ3WO7c+RQyy++xhzM48BvzQyv20nDbrVYjx9JxuYxachHdwYg080cM+FQMfFqwrlmA6uGl+98hcfKl55R+bp1YWsrpNeVyAvFUl4boawWFY43+J2PvpDfUjuZ/+VFun0V0t//BXAHuTbY9qCth6tvbggsKK5XRueEqOdiwPRkvtLKRRA==
X-YMail-OSG: XC7dt5MVM1kpMfVoviaDuxET1q5buyQkYmY6L2HleHBzBRw8NThlJ5Rq53XoUYw
 JQZMp6FjZU1YtnxjJHg.61g4Sjhkz26MbNzCJT2g7OLG6xldQcm1FRAVCpfuIB3NU8c8tccTJN3Y
 0sKez6HgzIV36EFA0iMUt0VE5C8jKJaO6p65TQZhIcdcxjlVrd8MTif5aYMJs3phBDpz2gGPtn00
 3z32JxRaOKpyAn04VN337XR4vVQOxDNq_HYW25mEvKyAsqCKraaMQHUOOEEby6.HYrlf3PgY.vfU
 boYsuY5u7KPA5HFWgZLFGYMOZTIsKdJoQisXue9v0IpthSjlf3H2VL3rOAJSQ_ZUlUVaRC8QChtr
 svTikRlCjMy25GQDWa802SzrlbV5goSb1B8PT9LW3omgEYgtog1H7uQihMq1dIBhtE5xvclpx0jT
 VMt6vLFnYpzdgFE8l2e4vEHsZKVQvp49W4YGBwpcAV2.ygUw1bD2m3XpBl_13fIg7WfXpmnf.XHG
 xLQ3Q5DL5zcbJsIAgewE6L5jJ0bKccG5d5BY1TeqM5lHK3Pey4cSeCukcgGIB8DWXJMTR11rcQWl
 eihXCyBnWXfVLmFFDxadMmrFN0xfXBsMjJLH0jC616k7h5PygjyLKF3BPyRPQ3z6COyCHvYOyBSs
 ugXsfWKNt9EzsfwZIoC5U0dMY6_apRGl42Wx8IVlYnsuPqNhToT6Qt16ZiHzfNMkgy6li1yVT8wH
 s3UuTcwxpAZmwnxS0nMUGRbPakJy91OVRLyVA4pJtascgICuuf_LjX3clQ4.WJy3pVltjzE_Bw6n
 zqXp_GwSvEgUDmnOS03nBc1evtDf3EgcQqbVESbnFElMXOC2XMMAfo6ANQSLFRYavHVHakfRBV7M
 k0.Di9_ersmOz11fzBD__R0vHtLqqF2cba9Hg.7n2NmxiAxJ1Go3InVV0paDmIjuW2QfToAp8fiw
 aGGHOqZJwgb3w9yqe6XYFXXchOi0pnCL8zzvHM0sV9IpBz1WvKWk1NjU_CiMwVmHSorVDQRjKsdK
 e.EkI._6nQmOceZZM_uuFUs6OXIBwbdhRC6fla4QOf7dQD726q7fC61Y4.4uf5Kwn0B4vCkckGDs
 zYHi1rYZUg3XOp67rtzv6s.4n6a_fTv624qcBW2sSIj3CXD0LAcaGOJWkjGvw1dJW2.g28ydUMyS
 kY0.cM_7BY9zLXlaA8WNRdfG04aOfp78A2qdPGBDCz9d4UpYUYOIz5WjUgDTHirSGFFoRhHS9rca
 uYBwZxm1m06RZst8tkxOiakUoGupNI31BnYFqOeyUg.FOU_rIt883pAxmFMH4mFLKuB8X2n.b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Tue, 12 May 2020 14:57:37 +0000
Date:   Tue, 12 May 2020 14:57:36 +0000 (UTC)
From:   jerom Njitap <jerome.njitap@aol.com>
Reply-To: jeromenjitap100@gmail.com
Message-ID: <1246117271.1049125.1589295456036@mail.yahoo.com>
Subject: SESAME SEED SUPPLY BURKINA FASO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1246117271.1049125.1589295456036.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15904 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dear Sir,

This is to bring to your notice that we can supply your needs for
quality Sesame seeds and other products listed below :


Cashew nut
Raw cotton
Sesame seed
Copper cathode
Copper wire scraps
Mazut 100 oil,D6
Used rails
HMS 1/2


We offer the best quality at reasonable prices both on CIF and FOB,
depending on the nature of your offer. Our company has been in this
line of business for over a decade so you you can expect nothing but a
top-notch professional touch and guarantee when you deal or trade with
us.all communication should be through this email address for
confidencial purpose(jeromenjitap100@gmail.com)and your whatsaap number.

Look forward to your response.

Regards
Mr Jerome
