Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C334FC93E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfKNOuI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 09:50:08 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34435 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbfKNOuH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 14 Nov 2019 09:50:07 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4C00321CBA;
        Thu, 14 Nov 2019 09:50:07 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute5.internal (MEProxy); Thu, 14 Nov 2019 09:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Fr498jAwuhCFDshl+yHP6q34OMawxBO
        ikAHoTWWFMyo=; b=nzDD6p8n2cph8GQt61hlFokFFUBPSUIXeMyoN+HiBSkxLzF
        sl1giCyNHTwPICrIFrk3udntdxzPx7/uFI+d3tc0bbvnV+aY2S2fw/5s3Tg+NZO8
        0Kt2DZodHv7KRSvsgFH5QQhi1Tnika3aat42f0oxvxO0FJB52/n2FQ05tw+1lDoa
        6mzQ29ZGa2ZoXZc4/a0HA+lmYKGnfaYy7wlID67uFRNmwddKi+FWYhnLoLQ5dDOl
        P3pvkwcaSn7lXtiG6dRBB3mBpLNHglYPkFVAjiZ0Ry5DH5/b25FzY+U14gB6Ee07
        tFl+9sh0mIDTZJokreV+awp76AQPG0HQTYcSqNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Fr498j
        AwuhCFDshl+yHP6q34OMawxBOikAHoTWWFMyo=; b=PLwma+t1p32Wb+7zcZKmLA
        UusIPfwwRhZPp+YfpRKZWCOHEhvsjlmkBRrknJe+JPvQXMmMVu8n6UBC1dNjIOEi
        qo3ffAqNz6E/nGP4cQwi4Z1b/n13tMsKzaqLkB7mBLhumgsWO0eUo1PwBVEvmNvh
        bxCZJZD+Kl1JUoswozrIN2uONCEzorwcdiv62FPK6x3YLC2N4zUk2gIsRxZ1sPgB
        3KC7ROPuLvALeqef5MaUBNMP6YKRBBg+nskBsqMBfgB0C7HMKhNhEvc4v/JkwKmI
        9Kf8evDlYDhMU6zZyzEGQ5ojo/EG5kXvsqJ9sNl1+8Np2bJdgLqziAdSpO2c25rw
        ==
X-ME-Sender: <xms:n2nNXf7cQoNaG0U1Pjo25-jVdX0OkOieLKBfFZe63YJJE6zxsA8W9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeffedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdeurhhu
    nhhoucffrghnthgrshdfuceokhgvrhhnvghlsegurghnthgrshdrrghirhhpohhsthdrnh
    gvtheqnecuffhomhgrihhnpehtihhnhigtohhrvghlihhnuhigrdhnvghtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkvghrnhgvlhesuggrnhhtrghsrdgrihhrphhoshhtrdhnvg
    htnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:n2nNXdKWqWJ5Yttsm-htlpTWMDqAUd_fMOdNeTI15nxobzpb4ZN01w>
    <xmx:n2nNXcUzK4OIIQQz3r-S6_hzMGwn-3yLH8HTIqqNBxJO-eLWxHfFgQ>
    <xmx:n2nNXR0l3rSIqyBcb7vJuSdfB4lbCjRXAfIlM3ja6XmjDRzZlf90eA>
    <xmx:n2nNXedixygxwLFTr6v6U65A2U5h29fCm4IEwbAWcIOY-LjTzLOOuw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 26636E00A3; Thu, 14 Nov 2019 09:50:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-562-gfd0633a-fmstable-20191114v1
Mime-Version: 1.0
Message-Id: <cd3bd414-50c8-4751-8370-6a17b3b338f6@www.fastmail.com>
In-Reply-To: <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
References: <b509514b-f831-4288-9852-25385da45c9c@www.fastmail.com>
 <CAJZ5v0iZ9pR8ou95q2kQnawWWmuOqpnEivRVx4H12sa4FGveSg@mail.gmail.com>
Date:   Thu, 14 Nov 2019 09:49:46 -0500
From:   "Bruno Dantas" <kernel@dantas.airpost.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>
Subject: Re: how to disable the "button" kernel module?
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Why exactly do you want to disable it?
>

I'd like to disable it because I want my laptop's lid switch state to be 100% invisible to userland--as if the lid switch were broken and always in the "open" state. All the less drastic attempts I've made at achieving this have failed: 
http://forum.tinycorelinux.net/index.php/topic,23326.0.html

I realize that disabling the "button" module would likely make my laptop's power button inoperable, but that's okay because I only use the button to power up the laptop, never to power it down.
