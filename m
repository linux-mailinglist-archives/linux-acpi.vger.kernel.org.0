Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C32A407D2F
	for <lists+linux-acpi@lfdr.de>; Sun, 12 Sep 2021 14:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhILMR1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 12 Sep 2021 08:17:27 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59969 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhILMRZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 12 Sep 2021 08:17:25 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id BC59D5C00D5
        for <linux-acpi@vger.kernel.org>; Sun, 12 Sep 2021 08:16:09 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute2.internal (MEProxy); Sun, 12 Sep 2021 08:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=fm3; bh=x302/8b6FT33u9kZZBPNW3Xr4h
        XqFVrgGnOo63F+c1E=; b=JeItasiqpTXwvonB/mgnM7W7gTrht3LBTUmxV5jAmi
        rMnYqaR6SspvSymnd6Gk59lQAaub9sm5NYhd0JCNWwrNznoKMpm9t6+mMf7hn4mF
        V+r8ZmmKvnVLFH02SrG9NbNRVocUIjz3HKZWVcJ5eIIsYgVUHk8lKGPMeNK/eVBN
        uC5tXYbVrN3KfLbQwpNDwzAhS9Ex/Q1u9BPNKeCupjf26wB/ttr0A5NVd5yRe4L0
        o6+3z497KjYNU2zNPC6574+pdPrY4BtS/HH6qGu9WAPyQYR1NWQhGxKdjpvYgJMi
        mrYm3DmWi1SfpwH0PJsEsjAbQE/yxg6JWiZ0k0XMVJWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=x302/8
        b6FT33u9kZZBPNW3Xr4hXqFVrgGnOo63F+c1E=; b=DsvqPWmzOPqLS7Ahyqd0Zm
        b3FOcFf84U5y0qXRSZQ051sXLSpl1qx8eUIZYUnaZDBtnA1X+NZlSCoGUt1dnl12
        kIy1ybI2grsv2we79PCKcmp0ZJFf7InWaoLdIi9kjkdF9kMPvIPHw/p5C9HmR0Pr
        ID7lcOTg6bOUCxtVhw6n0gHYAxxe8YujPAQiv3M/hT/N2U9TWxofOofOSl97M+pL
        Q2pvfd/0mbpwJc+aSTsFrzhNqkNN+4dpcwcFn7WrnJ+5KsQ/lcfEBx2CySQdTi9h
        C/hHXqXbVUTsfRA9ba7+lDTBY9mMhPrNUbVQLccquFaABdbJizvxhvJtUfcLZ9/A
        ==
X-ME-Sender: <xms:ie89Ye7ZVM-y94bZhl9L_KBZDsacqladDwE-frbgoTbtz1XGPRUewQ>
    <xme:ie89YX66Shbd7txx-ZQlSmqxEmbvQu70Hxpfh0l1IZJJGvu9euToj9JqgUh8UcHTG
    12HrP0Lh4C1A_cl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeghedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdfpihhkohhlrghushcutfgrthhhfdcuoehnihhkohhlrghu
    shesrhgrthhhrdhorhhgqeenucggtffrrghtthgvrhhnpeektdejgfeufefgtdetgeeuhf
    etleehhedujeffvefgvdetleejgfffvefhheefheenucffohhmrghinheprhgrthhhrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnh
    hikhholhgruhhssehrrghthhdrohhrgh
X-ME-Proxy: <xmx:ie89Ydfz5shQEY-d3I427plLDVQsBO_mabOW0uAifbpFM2VqNYiuww>
    <xmx:ie89YbJogIqL4vXc-mxrfPY3akCBpMY6naJjTOf1LZolZ4NWeh3CEg>
    <xmx:ie89YSJEGHOGVHtOTOFqvQJSJGqPi8cRfZ-XOHngN8pxmUCj6o5nlA>
    <xmx:ie89YUgYpWZ_lbO_xD2Khh7Fr3ifNcajoSo4aDJJjeVSMaGkXo7uYQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 39F3824A0064; Sun, 12 Sep 2021 08:16:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1229-g7ca81dfce5-fm-20210908.005-g7ca81dfc
Mime-Version: 1.0
Message-Id: <aaba8b55-daf8-4e0c-ac13-a6f3b6f851db@www.fastmail.com>
Date:   Sun, 12 Sep 2021 13:15:28 +0100
From:   "Nikolaus Rath" <nikolaus@rath.org>
To:     linux-acpi@vger.kernel.org
Subject: The DSDT has been corrupted or replaced
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I found this in my kernel logs - reporting it as instructed :-).

Sep 11 15:28:59 vostro.rath.org kernel: smpboot: Booting Node 0 Processo=
r 7 APIC 0x7
Sep 11 15:28:59 vostro.rath.org kernel: CPU7 is up
Sep 11 15:28:59 vostro.rath.org kernel: ACPI: Waking up from system slee=
p state S4
Sep 11 15:28:59 vostro.rath.org kernel: ACPI BIOS Error (bug): The DSDT =
has been corrupted or replaced - old, new headers below (20200925/tbutil=
s-87)
Sep 11 15:28:59 vostro.rath.org kernel: ACPI: DSDT 0x0000000000000000 02=
BF99 (v02 LENOVO CML      20170001 INTL 20160422)
Sep 11 15:28:59 vostro.rath.org kernel: ACPI: DSDT 0x0000000000000000 02=
BF99 (v02 LENOVO CML      20170001 INTL 20160422)
Sep 11 15:28:59 vostro.rath.org kernel: ACPI Error: Please send DMI info=
 to linux-acpi@vger.kernel.org
                                        If system does not work as expec=
ted, please boot with acpi=3Dcopy_dsdt (20200925/tbutils-94)
Sep 11 15:28:59 vostro.rath.org kernel: ACPI: EC: interrupt unblocked
Sep 11 15:28:59 vostro.rath.org kernel: ACPI: EC: event unblocked
Sep 11 15:28:59 vostro.rath.org kernel: usb usb1: root hub lost power or=
 was reset
Sep 11 15:28:59 vostro.rath.org kernel: usb usb2: root hub lost power or=
 was reset
Sep 11 15:28:59 vostro.rath.org kernel: usb usb3: root hub lost power or=
 was reset
Sep 11 15:28:59 vostro.rath.org kernel: usb usb4: root hub lost power or=
 was reset
Sep 11 15:28:59 vostro.rath.org kernel: nvme nvme0: 8/0/0 default/read/p=
oll queues


Best,
-Nikolaus

--
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=AB

