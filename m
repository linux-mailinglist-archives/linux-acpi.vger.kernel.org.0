Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8721639CE
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2020 03:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBSCHi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Feb 2020 21:07:38 -0500
Received: from sonic316-21.consmr.mail.ne1.yahoo.com ([66.163.187.147]:43501
        "EHLO sonic316-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbgBSCHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Feb 2020 21:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1582078056; bh=uKvLrfbQW5ttrC8kUeRbvaFFRymjnt/GX57x38e+rD0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=GyeJSwYDv0Ko34otgr8I8bwsMh3Vzrpn67ZBVyLrJwIheqcguTh/Gu0lWsUcAn57hvpwnu8S1U7QbEqoYIQtV4WZt+mlJwjr1L9Zd6QQBqP2d1s2x8JN0mNIsLIN+/zu7BIuDIr3Nohma63MWpiEh9ij52h3Unw3z2PtwT9hrN7xhGIF6y2KhHKzjqwUyvr4vrG+ZZ1PrNl7IUASgPhHvdqNf9vB+2Kk59rWsgnScc2VT+s4DR6FlqWQ8pDyyXc8c/uHRyCXzq2GEkrYZ4PKzRSBQ2kIhz1eX8q/io4zQie9Yivt9QDOhxaaix8xQzgxbfmgi+vWflyhIOh0U1j38w==
X-YMail-OSG: ZXjadygVM1lPS_O2xiiAlup9NkRPrPXV_YXH6MyABx.tWsHV7b8X1sMTnMuXEqX
 wPJ_fvQFxrFC_0XBz64ClfAkUBBDYGh75DEfUkkaix9dubuhpArtJhkt2WSOSRtFvEreaByIAlvh
 WwGVSZNaGd5X313iORH3Ivuf0woWcvR.uoSo5AEXQr.Skz854eroAZ66_gKii2uYtR4QApVHIk0V
 fxqBKHZJfoWpdaurUYYxDJUKwd1ZtNInt3YYfifw86Rkmy.gpJ2vtj5GhMGF076gnvI8c3KdxH81
 HQfUtOt8AjMEAr.vi7XaC_CwUsQYOJjUtGwCeqcFtmx_5UDNB7uT3lVLlDrqKXvSDScy1oZRTlaW
 v71httOm4Ma2GRp3krG9D5GTibKJdi4WbF8VptyopLh71zJqzFGdDWRLL65Pw9Q2dWiSrJtt.Anx
 18wg4m_un8sMakZQRIZbnpU5sVVJkT1UvyWWuCyujjSqaOHKTJWsXcUsgOUTWUDmUR8UjhRyWrZ2
 3kFw.XZ26QhXeSCX72M3EMshx3kdL1SDd893bfCo3TJv_PaaScoihlvLgr8xact0idBtiwtlI3YT
 u7syeOCOmX6EP3aGGMAvYYRhpJMc012Pqi7DageJ5DlP218mOrYfKX72dLUAiOcyDfkgmRcvnxQU
 KeHVEYddKKC5J16WNBqCnZ81GeCInMlM2Ubiqs5NDc9Jeqj9WpfG4aXReH6bdFXRkrBUTfhien8s
 tsvQdPykwtXboG50CQD6ZsluduR4fTNeGy_y8h8jtLuPymi7KaN0tIEFNVKEX2JcGnYmaO6TFnvJ
 d5fz72Ev7hwLXVDOuMJjr.xDGez31VKPtA.7FRmTMhFbXa6nCQ0T_5qEUK_daBljwJDIjcUKDUXS
 96oTmlBbsq2FCkOpzJYZRSIm3943CdMVlbiK772YKsMjSa6g2Zaf9drUF6714P0w4Txd7EJ9LC0V
 kjF_5z0BTIkfDCQ3aV2EXfXZWrbNHSXqTPzU7euwtxfG32mB0RvFwCs28TAQbUDvJ3gN249j_Ipf
 JipYx1rGFWBGVmofK4JgOH2QT5GAnL21L9Qa3TAyRGKjkRo04m.mOBDIlyJgen3XaY1QUimRmewb
 kz6InLzLtW5ThjLOJU45m9raopMU1zpkvSsTOmOY2y97YmZurDnl4XqIxP6r8CSXmWhOvLBLDhgc
 2mmxsxGC9lMRKh7f.aE715V9EhqKXYDRgaVX.oDCFBTyHmAL9Dx8kVnml4etZh7s2YQUjcGoaFVw
 TF7jOOSKUycRVF20KozlLsgn.UBUmzTtvQnjymKp4yAD2yZid_pNt2QQb9O3XDs1aXImsx5NeQui
 6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 19 Feb 2020 02:07:36 +0000
Date:   Wed, 19 Feb 2020 02:07:33 +0000 (UTC)
From:   Salif Yoda <salifyoda34@gmail.com>
Reply-To: salifyoda34@gmail.com
Message-ID: <203525642.4923966.1582078053325@mail.yahoo.com>
Subject: Good News
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <203525642.4923966.1582078053325.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15199 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org




Dear Friend,

 I am Mr. Salif Yoda, work with the department of Audit and accounting manager here in the Bank of Africa, There is this fund that was keep in my custody years ago, please I need your assistance for the transferring of this fund to your bank account for both of us benefit for life time investment and the amount is (US$18 MILLION DOLLARS).

I have every inquiry details to make the bank believe you and release the fund to your bank account in within 7 banking working days with your full co-operation with me after success Note / 45% for you while 55% for me after success of the transfer of the funds to your bank account.

Below information is what I need from you so will can be reaching each other,

1) Full name ...
2) Private telephone number...
3) Ages...
4) Nationalities...
5) Occupations ...

Thanks.
Mr. Salif Yoda,
