Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC97FCA67
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKNP6w (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 10:58:52 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60765 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726214AbfKNP6v (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 10:58:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5732E218BB;
        Thu, 14 Nov 2019 10:58:50 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Thu, 14 Nov 2019 10:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Hbk262asKi6wNpS1+5RA8Pv7sowpYUW
        24ilyiIIGDo4=; b=Bf87GDyindq0oSOSIFr3A3uBK9dyC7mGXsanad5p3WegDvX
        kjAmCqI/lpLOZA8vbs++6DivC6DgrAtDolyxMkhDBD2DoK9MsL5gbtYgoopN7kyL
        m2uAD33IMGDWCpvOIyVBMBG6qrRh1v4IiQ7Qg1+3r/zlCSw/VjjPIvw3j6tYFBzU
        TH4QoufEmFbwTyBFcr6SqPNSOjKDO5JL9Ep5tp2hN15wg8t/bvZk7buteaYOOJck
        QnD2zO4GMNlY28jHRRJbRZ4PY3iLItRs442b/VCmDUZ8HY611tuO8z6Pmrr91N8p
        fBllCt/Uw+71vn1yNkro3CKbaQTq0omT0f9BDFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Hbk262
        asKi6wNpS1+5RA8Pv7sowpYUW24ilyiIIGDo4=; b=ggOHHTkA9zcEXYZXMq98tU
        OcLD/v4akOldXRalRlMpgT7jduofKLUOhAhrRgZYGogolrY7W3FByLCuYZ2E5h0u
        zRbAKM/a8RkwvvX4yDu+iJlvQubuxh1rtebYFQxdt5FhNHCqe4geq7yjh5oafM8K
        RqGJdYAsdyt3RjLUGmjFWxsL6hy3f3RXwQapFdFteelAD07/5z19rwHrglVSpvum
        lxWIQWI0koDKfkBUdBPmAcdcNGWDFeem5dqFwXDvs7+xjQhAr02rHqeEbpPpQO2v
        WEzsH2QeNP5ULnF272rfMCjhanrCrVfbg9FgeHOCADHFqYlCs4b1n5XZ9JtrjyLQ
        ==
X-ME-Sender: <xms:unnNXT2WAvuscSZs2V_pam0g0PiKSD1cALwouNu-FkStH6LSvVeY5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdeurhhu
    nhhoucffrghnthgrshdfuceokhgvrhhnvghlsegurghnthgrshdrrghirhhpohhsthdrnh
    gvtheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkvghrnhgvlhesuggrnhhtrghsrdgr
    ihhrphhoshhtrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:unnNXWqnhaaMlpsWNVETTHK2_j392_m-OXX9ffD1PiYKGimhAjyPRQ>
    <xmx:unnNXfx08LPJz5tnnpZL7HRTsWBaIiCvhyMezCTpmaeGsQ9wz9ujKQ>
    <xmx:unnNXVhnQN6J4pR5NlsH-iyAZlXDsmeis3a0qB6I4vRHNY9TLSHmaA>
    <xmx:unnNXaOisZGecYCFDnkweYPOMhSr4Hb-FJQWa8pPg7evWFavP8dm1A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0AA7EE00A3; Thu, 14 Nov 2019 10:58:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com>
In-Reply-To: <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
 <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com>
 <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
Date:   Thu, 14 Nov 2019 10:58:29 -0500
From:   "Bruno Dantas" <kernel@dantas.airpost.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>
Subject: Re: how to disable the "button" kernel module?
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Anyway, you can try to echo the lid device name to
> /sys/bus/acpi/drivers/button/unbind to unbind the button driver from
> the lid device.
> 
> That name should be something like PNP0C0D:00 (note that you need to
> escape the colon when in a shell).

Thank you, Rafael. I've tried that, but some applications (e.g., xscreensaver) are still somehow able to detect the lid switch state. In the case of xscreensaver, it still refuses to start playing the video animations if the lid is closed.

> I wonder why?
> 
If the driver is unbinded, how can an application possibly know the lid switch state? I asked the xscreensaver developer how his application queries the lid switch state and he said that it doesn't. So there you have it--there's some voodoo going on.

I have two toddlers and a baby that crawl around, so I often have to close the laptop lid during long-running commands to keep the kids from pressing random keys and wreaking havoc. If I can't predict the effect that closing the lid will have on applications, I would like to completely disable it.

(I'd disable the lid switch at the level of the BIOS if I could, but I use Libreboot and this is not an option AFAIK.)

