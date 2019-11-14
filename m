Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A239FCE1B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 19:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfKNSqs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 13:46:48 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58057 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726592AbfKNSqs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 13:46:48 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B2DF221C08;
        Thu, 14 Nov 2019 13:46:47 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Thu, 14 Nov 2019 13:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=a2Yrq4v/jkZiv7XCjw1aj3qO8ZySqZK
        l+TSPg1upECY=; b=hE3M7ECkt2sZSPf5r8GDQt67jz/Zcdu3bHf2V9WxmSEJiNG
        f91SKfTaniHoSx07SAXcgd3t7pzhO93frZNadkSjRO60U5spAH/4hU8GLxdJyc6E
        vQPo2eSfHZiapeV7wC61Qtryam+ZYXNfq6TYBZTG043qwHi4kuouUL/D+0nlEIVi
        kHIVsqoTBDuo7WmDXaQqrEQXUap+Y7XU21HBMTk5dUya5YF1tZJNUPLisJamU7lG
        WifXqHvUZwthycsUUumq7fda23rVH5THSnmpvdG6bN0tdLNffbmsXLCWIuBe27JF
        0biFzS8Zp4j553ZK3GEcWnGT1eiD0sapd7TGfUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=a2Yrq4
        v/jkZiv7XCjw1aj3qO8ZySqZKl+TSPg1upECY=; b=kChHMyvJGSpqasAbKyD4PH
        JeQhYiqv3SKi+7yKRZLEH5+8LfCI3m2haNBaPSsTKx/uXE983G9Tfbrde4SiIV9Y
        rNtnshSu6s5biobnB91S2VyFG4Z4AsHHfj/mwJ9FwveXRlTV0kExphCb2d0yguC9
        s4uhCQJnNhAcrc/J2PZG3YKgQuyYr6J7Y56YZ6dwASF0BT4dCAmWugDtGR1aXDKy
        hWiW46oYD1sjI8BMt/BpipgB8pvDPQOHFSL5dNSK3C4RhsSe6Y3PS5DeAgA+o+Gf
        nnrpmuY+jcTuJHcmeOJ8I3J4AbWs9LSvkhi5Rtpz+eWiSMsNNcog9jdjGvaavXfQ
        ==
X-ME-Sender: <xms:F6HNXWnLqt5s-hTeTEOccO6kpEz366MkAD3s69wwqzMqxRnuQGlFeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfuehr
    uhhnohcuffgrnhhtrghsfdcuoehkvghrnhgvlhesuggrnhhtrghsrdgrihhrphhoshhtrd
    hnvghtqeenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsegurghnthgrshdr
    rghirhhpohhsthdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:F6HNXWmNbXHIjfF6UDdxBsREN4Se61aaseqdtWqV4OJLNbzaKPseOA>
    <xmx:F6HNXTWrHG5ZxYDsaVvfL8o5w6RGIApege_nflYHcooWCrxf_Imjxg>
    <xmx:F6HNXc8a_dD3bwrjbU6yWZvTkC_X8eSiV-EIAtKRyO9ArbL7r4L_-Q>
    <xmx:F6HNXUD-TYOpvf0PHhx-IqVQ52QCQ7g30jhkYwAiYXNLFvtfzv5hDA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F874E00A3; Thu, 14 Nov 2019 13:46:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <b450cff7-f3ef-4523-b86b-d0fd0ea4923e@www.fastmail.com>
In-Reply-To: <CAJZ5v0hzwsuxZUKc-QdxwOnJ6xmVHBccg2ubaOYUmhnPMQKEAQ@mail.gmail.com>
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
 <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com>
 <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
 <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com>
 <CAJZ5v0hzwsuxZUKc-QdxwOnJ6xmVHBccg2ubaOYUmhnPMQKEAQ@mail.gmail.com>
Date:   Thu, 14 Nov 2019 13:46:26 -0500
From:   "Bruno Dantas" <kernel@dantas.airpost.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>
Subject: Re: how to disable the "button" kernel module?
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> You can try to unbind all devices handled by the button driver and see
> if that makes any difference.  That would be as good as unloading it.
> 
Good idea, Rafael. I gave it a try:

bruno@box:~$ ls /sys/bus/acpi/drivers/button
LNXPWRBN:00  PNP0C0D:00   PNP0C0E:00   bind         uevent       unbind
bruno@box:~$ echo "PNP0C0D:00" | sudo tee /sys/bus/acpi/drivers/button/unbind
PNP0C0D:00
bruno@box:~$ echo "PNP0C0E:00" | sudo tee /sys/bus/acpi/drivers/button/unbind
PNP0C0E:00
bruno@box:~$ echo "LNXPWRBN:00" | sudo tee /sys/bus/acpi/drivers/button/unbind
LNXPWRBN:00
bruno@box:~$ ls /sys/bus/acpi/drivers/button
bind    uevent  unbind

Still, xscreensaver animations refuse to kick in while laptop lid is closed. Very mysterious, indeed...

Would it be correct to say that I've excluded the button driver's devices as "culprits" in telling xscreensaver about my lid state?

Even though this issue is somewhat trivial, I feel compelled to keep digging because of how mysterious it is to me. *Something* is obviously aware of the lid switch. Maybe it's my video module (i915)? Maybe it's X? Would either of these be able to assess the lid switch's status if all the button driver's devices are all unbound?

Thanks a lot for your help!
