Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF074FCECD
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfKNTgn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 14:36:43 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35565 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbfKNTgm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 14:36:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2C89B21BBE;
        Thu, 14 Nov 2019 14:36:41 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Thu, 14 Nov 2019 14:36:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=9aNPYwmN6SvBRl+ctKbDtwGwiBBp03y
        N01eXUYymLqU=; b=oTrR+3sNAlPXsKiYIX2+I1G56J85Euvtgy7u8PYlxXdRuNy
        n5wIgWnBTZayJCt/ZTQCrjaXhthtNzvNtsf4d10NoA687iDeDGBEIyfc8tJQ9T6a
        EMEJRN124YNOKTIooTvoXHeAmekpF5jAWJOicSi2RtmU5wjYPbKiSPs29MOqgzNK
        xUnI5yvsp96aywqgL/xlOazYGLVBwrj2lXjMd5ihcvXBmgbNuT1HZ2acbsKAC3to
        VbZ7M1gJLUFu7bB2laNXuJgbXicrlbWq1ayrgoYkyohvlj7pLXsRP8UP0k8Wuurn
        aDaKhqHB329hH8E6DnrXx5NihRAsPHDXxcvwggQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9aNPYw
        mN6SvBRl+ctKbDtwGwiBBp03yN01eXUYymLqU=; b=JDPiVki3LOCF3kaGdC0WjS
        9TxzMI4Pksu+GGmhi1MdVXf7d4AlpHiO9dnfi1LShzYUGCMoOLLhKu6l8LanCbm3
        cE0G/m8a2aJ0OdO9FrlaYdVrV5hQUXjXyb5AfJRN2xWlciLLC0g3kK0BqCj/5Af8
        wbSuOBBrejZCkhZRTh2kzvbRZn1gggDcfdyL57EKMRifdK5sueCL3RWy5TP8vcJB
        09pGMLMu5pQnGr51VXp0oHvgV2kWg7K4rNvhwPNEOZtI3kqyM8h3aHZPFz+Nn86N
        yBnO2HAh1q/9BpAr5qMaupAWKyr5Bm5i3Oj/bSxlS9VT33MZVeDeDi9XwvOczFmA
        ==
X-ME-Sender: <xms:yazNXVJECVOyz-kpBq3W9GCArwZh85ugJkkGSjYdvl1_chmymn8MUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfuehr
    uhhnohcuffgrnhhtrghsfdcuoehkvghrnhgvlhesuggrnhhtrghsrdgrihhrphhoshhtrd
    hnvghtqeenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsegurghnthgrshdr
    rghirhhpohhsthdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:yazNXbaZg4lO7_-H0yDyfuz4lAx3Q24u5_2NMuH9Gca31b_ED7zU1g>
    <xmx:yazNXXCZK-qA55Gg6_tirjTaAOxsjmoadMoIw_UOwtfcRz2miQzW1g>
    <xmx:yazNXZvipWKHX8XM4LCW3GUiN46RzW2iZISOMR8kSrBuGQB7sU2m1A>
    <xmx:yazNXRnjZm59OmbuqH0nLfWzlLxfEz5W_1XECf9k4OWinIYsTV9Slw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EFE7AE00A3; Thu, 14 Nov 2019 14:36:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <1c8765d1-1209-43b7-97d3-4c454b15852b@www.fastmail.com>
In-Reply-To: <CAJZ5v0hCrNoEA=TKVbsG0TPLLKT1br6N7O+sSm=KDA+QwX6fOg@mail.gmail.com>
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
 <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com>
 <CAJZ5v0hN2PrFUQkWtTB2DfDVtyGubS+iPRU7WA1wM--1R+N7kQ@mail.gmail.com>
 <2a86e8b1-c631-4705-885e-779997589751@www.fastmail.com>
 <CAJZ5v0hzwsuxZUKc-QdxwOnJ6xmVHBccg2ubaOYUmhnPMQKEAQ@mail.gmail.com>
 <b450cff7-f3ef-4523-b86b-d0fd0ea4923e@www.fastmail.com>
 <CAJZ5v0hCrNoEA=TKVbsG0TPLLKT1br6N7O+sSm=KDA+QwX6fOg@mail.gmail.com>
Date:   Thu, 14 Nov 2019 14:36:20 -0500
From:   "Bruno Dantas" <kernel@dantas.airpost.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>
Subject: Re: how to disable the "button" kernel module?
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> As I said, that may be the panel state rather than the lid switch status.
> 
One last question: What keeps tabs on the "panel state"? Is it the kernel, a kernel module, X, or something else? Would you be so kind as to point me in the right direction? I'd like to find what keeps track of the panel state so that I can disable it (or configure it to lie and say that the panel is always open).

Most internet searches for "panel state" lead me right back to the laptop lid switch, which I guess has been a red herring all along.

Many thanks,
Bruno
