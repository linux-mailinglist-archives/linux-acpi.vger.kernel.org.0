Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338122F7EDA
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 16:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbhAOPCq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 10:02:46 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51721 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbhAOPCp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 10:02:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id BC24AE6D;
        Fri, 15 Jan 2021 10:01:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 15 Jan 2021 10:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DAZvSPO0S+QnpLxAY7yTcaJiZtB
        epR9CLv2uJSu9blc=; b=NLUILfmvRZ4ZCx7GAXZsWdTwHd1Wm0weJvrchGhnpvx
        flIUmK6fxaK5BAGl7srXn2FyG5FGlmVKF7B9vXjJ2CeU/Y/PkocKAdzUfbWwgqWV
        qHjguR8L7ENaj8bQPWp1CFxd81V0hm6ZB2AVzX8Hx2vSl0nHglCShsKLsn//aPBx
        SPF4G7Oernwu3fmMb/L2jGPZ96evDE7DIjTbL75Ck+JbwOwrZ2NqPtO68aog+YGq
        diR2bY7lsBMk6fQ9SZGgoxsPTB1AtU85HEGZovAdUdGK5hVWC0CQ/XGmEpEH+ijD
        bNGmHp4Y2CLgi0RgWXAqFFubFcscwGCqnjJDmhsV5sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DAZvSP
        O0S+QnpLxAY7yTcaJiZtBepR9CLv2uJSu9blc=; b=M1uGAGg0zzuhfj47zxbZwC
        AWV5Ys27vFa1NQ4zZrkmhE2igwkvWtZ46dDAoDbttsEi5Si3oC1rcHWsckVyUDNj
        /mECtA+CvZzy44jiHFi6HvStk8nTYD46tQ1P0re4ijYk629Yo3Ix52vLYh9Xv/fa
        1+uvbiTnFdbJr045f/ccJkgEgEYn1mcd+bqv0H2cYZc5YfSOB9wVcNGWAjKYauXu
        RSNCZ4P7Nor7W2MVSmCOUeLjSVrz017wbKUynVTnwUY6D6W77S2SON5rJgIbMkfa
        UuaEGmoonsi/Qeg2EaQYkvwrqEk1rUQMaIVraTFhO2g5kLXtkX+WGSh4e7svfw9A
        ==
X-ME-Sender: <xms:Uq4BYNBHXiE90xOq2encA-fcONjsryGjjXSR8V4Yi9k7z3_P3aE-7A>
    <xme:Uq4BYLiPX8XmN6XN7WxRCcJWJPDYH6ee_6ysdit6df0iUN1mKIDVxIex_rOHYTJhr
    7ZVLiIBkjH0lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Uq4BYInZz-lmiVjxtnLbdpAZgDlCvO-OAGfBjlP9cwyTvl1-52Zf5A>
    <xmx:Uq4BYHwhIOhsdXbmCfjoztOSm6N0NFeZR8AvOMnTaXsihDizu_iKiA>
    <xmx:Uq4BYCRuV1aA598MzNYSg-DivYUzU3xyszEpamdmlWqm66wmE1FaVg>
    <xmx:U64BYINiggfjagkBKvf9lDSP3p4hPRtqDb_gtM9NDKO0tqe5xbDX1g>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87581240064;
        Fri, 15 Jan 2021 10:01:38 -0500 (EST)
Date:   Fri, 15 Jan 2021 16:01:37 +0100
From:   Greg KH <greg@kroah.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove one more platform_device_add_properties()
 call
Message-ID: <YAGuURTCW/9HAprF@kroah.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <X/2MupFIWVI5DTUe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/2MupFIWVI5DTUe@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 12, 2021 at 12:49:14PM +0100, Greg KH wrote:
> On Mon, Jan 11, 2021 at 05:10:42PM +0300, Heikki Krogerus wrote:
> > Hi Felipe, Rafael,
> > 
> > This is the second version of this series. There are no real changes,
> > but I added the Tiger Lake ID patch to this series in hope that it
> > will make your life a bit easier, assuming that Rafael will still pick
> > these.
> 
> I can take all 3 of these if that makes it easier.  Rafael, let me know
> what you want to do, either is fine with me.

I've added it to my usb-next branch now.

thanks,

greg k-h
