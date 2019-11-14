Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0576AFC8E9
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfKNOd1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 09:33:27 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40717 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfKNOd1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 09:33:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8681B21AFB
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 09:33:26 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Thu, 14 Nov 2019 09:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=GOZReEkeExrtnuZLmIYyqCr9fPSWeUppUxOPFIkWJS8=; b=suu0SK5v
        BPL/J9xmvaywKbRcTQ8d90s7TwLK4Bqermcw/ZfyvwQnOw9BAebpa/gznI5WB1uN
        ZrcI/X0q+mNhP0LrWclAv0E6LGY4d5DPbjqkFhv6278BzKbacB15wPCHEO4jp61p
        WKVUxGraRAKJr2FNn52RpCe8BwD6XzebIp2YbJzDVCwI2+M6LvsFZZ2dVVhR8vmA
        M5qcbrZUrJVtbaadZKvMgk7xF0BbWx9+pnvG2lU6Q/r6mzSdA1FQC3xkH86WuzaH
        Lub3qKq+kPkGDw8at6p2nNjQIH7aC9Qb5rbUXJk+FF8xZHJNbn+buOboGB1/kjnI
        9XgUhQOgMNkMrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=GOZReEkeExrtnuZLmIYyqCr9fPSWe
        UppUxOPFIkWJS8=; b=tTfvTh6sOSxI2GpVK6qi/pTzFzHXRD5zMc8/fhbvIko53
        /gb7U4nj16/Cd3HJnLOce3oCUP94t5m7zwm6FemlTSiD4MU+Sbtf147dvDgwFcbL
        OpBnphfl/DK0WXp49iH273dnms3ggk0IkZy5G/LvFMUlXgV+mg8MdBz3lR8s89IX
        IoA9Y/6Oo3/4ZohPHwR7e9Ysgq05af4/Zh7VHg22CwnvSIdODoKKH8N9jMK2l1xz
        diAbmkijM7m1asEUrl8xA7AfVJ7Hj06bFXPxM7NIRfmnFN4ZMT+wN7rY31U+WD7T
        U4Dn6CkqDqXfR90gFbCXGaT2KlLBykcuzo1ADZIKA==
X-ME-Sender: <xms:tmXNXf9ADfH6JXtDh8uA78bbv4eSoChJfLlvg5EGiP0ylvBsjq3GXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfuehruhhnohcuffgrnhhtrghsfdcuoehkvghrnhgvlhesuggr
    nhhtrghsrdgrihhrphhoshhtrdhnvghtqeenucfrrghrrghmpehmrghilhhfrhhomhepkh
    gvrhhnvghlsegurghnthgrshdrrghirhhpohhsthdrnhgvthenucevlhhushhtvghrufhi
    iigvpedt
X-ME-Proxy: <xmx:tmXNXf-7QjnVGuipNb3q_ehUY62RSODd1uRC08A8uqqpQLnjQRABdw>
    <xmx:tmXNXYASEIlmzPal1xd7xkyRrzpuLCkMR8-OFrA4GJdf0OF-qV9Hvg>
    <xmx:tmXNXfzpdenD_wFE0hWW62pv-y5RsLFAoEXZ0EdgnMB7mHJ6ri2Daw>
    <xmx:tmXNXTl-P6OouvQ6OJMsNK7wkvzw9LVSkRaxxazWHl700lR2eWN3yA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 581DAE00AA; Thu, 14 Nov 2019 09:33:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
Date:   Thu, 14 Nov 2019 09:33:06 -0500
From:   "Bruno Dantas" <kernel@dantas.airpost.net>
To:     linux-acpi@vger.kernel.org
Subject: how to disable the "button" kernel module?
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I realize that "button" is a kernel built-in and therefore cannot be disabled via "blacklist=button" boot parameter. So I thought I'd try initcall_blacklist=<function> but I cannot find an obvious module initialization function in button.c 

Please, how would one disable the button module? I'm looking for a method that would not involve recompiling the kernel. 

Thanks, 
Bruno GNUser
