Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75FE2F7EEA
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jan 2021 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbhAOPGR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jan 2021 10:06:17 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49427 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbhAOPGR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 15 Jan 2021 10:06:17 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 1546ACCF;
        Fri, 15 Jan 2021 10:05:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 15 Jan 2021 10:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=LQrVwo9g/bkxN/JrjYk/uzA9cZ6
        yv5o1mfqNW+Pqmws=; b=aYgoUlV3wVDYATN8VCPiytqqIYdnPnqS7GNhu4cUnT1
        iBOGZv/AzduKLp3+6D+6IJMOh3Z4FWZDTLFjHRKx5hzg0H29fnf1R0D+Gob59+An
        anbTbd2U8eFFtZpWsVnJx373CxxGvfefiK3QgChlv11f3jh4EZ35y/TjX2t7u/z3
        C7SAN2ytRah4RtjrB3gEcVH0JYw6+5YtGwL6YtpUU06anHQSS+0xSvIhPSzXBstY
        b/+mw71ev7Bu+zqor2C7glOtSDzcso5ctYna2/s5f8SbrVVWpuVP3N5jw9Z/Zgwz
        f5vdgg0tHS5Og+aBmDE86iYtCgYRbamiZzTlOC4266Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=LQrVwo
        9g/bkxN/JrjYk/uzA9cZ6yv5o1mfqNW+Pqmws=; b=lmHQDarjO/LldLOJHEHrAR
        iDGTzVJFiN2HNoeXifYkBNvIiQCqgATc/vO+CvlS9k46W5nmxD9YygWxG4LVOYvZ
        lz1GJ51vRu/u4brW+IyU47hT5qXL0v1ik4zrxgsrLXwzdJmWkVGMr3Pl7WteVama
        GTeN3ZQ0BtLE75MVBN4790TG0sYAriFfLE+YeMxnZRFPWRdiK8r8a+DF6b0GJjPa
        utlPWFop+pP//iKfOjcFzrXNFac6LEsU5hPnyeFx19xCBeUhFs+zmHAPsZV64lSJ
        ++3N8u4pZ3ClxpgDo7cVTjqbmnC5LuhdzU2RSkfQx46wMN4RK7RWPfisH5edD7hQ
        ==
X-ME-Sender: <xms:Oa8BYFJ9DNe-O0EbiuW_c_zDcWS0ZJENJSEHiL-QCdbFY8wVAspA1Q>
    <xme:Oa8BYBIkd7TAHCFvDfU2kXvlh0kmdUOESHFhiKWyY4JbdO_E_o_vdY3VZg4cYPgGI
    Ajdgf_nYheClQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Oa8BYNvfGrWBDvl5nIzCLbCvmjd0XajNfaRr4stBsI2tjHQ-9NEZUA>
    <xmx:Oa8BYGZ-V852H6EacENqiCNRlwDajb6-NbUIU9olFUmKYZIvMt7O0Q>
    <xmx:Oa8BYMY5HK3v2OEhcIARmj5MtQzCXpTwp8XLuGLunFHcX8rF9eKtTQ>
    <xmx:Oq8BYDU48TfbDgxJZGySCe8icIyujF47IVHwknwd6TivbkaF9trBBA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id A39EF1080059;
        Fri, 15 Jan 2021 10:05:29 -0500 (EST)
Date:   Fri, 15 Jan 2021 16:05:28 +0100
From:   Greg KH <greg@kroah.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove one more platform_device_add_properties()
 call
Message-ID: <YAGvOFllCbDoD1at@kroah.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
 <X/2MupFIWVI5DTUe@kroah.com>
 <YAGuURTCW/9HAprF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAGuURTCW/9HAprF@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 15, 2021 at 04:01:37PM +0100, Greg KH wrote:
> On Tue, Jan 12, 2021 at 12:49:14PM +0100, Greg KH wrote:
> > On Mon, Jan 11, 2021 at 05:10:42PM +0300, Heikki Krogerus wrote:
> > > Hi Felipe, Rafael,
> > > 
> > > This is the second version of this series. There are no real changes,
> > > but I added the Tiger Lake ID patch to this series in hope that it
> > > will make your life a bit easier, assuming that Rafael will still pick
> > > these.
> > 
> > I can take all 3 of these if that makes it easier.  Rafael, let me know
> > what you want to do, either is fine with me.
> 
> I've added it to my usb-next branch now.

Argh, grabbed the wrong one, will drop this and grab v3...


