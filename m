Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA312F2E5A
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 12:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbhALLsw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Jan 2021 06:48:52 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59943 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730298AbhALLsw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Jan 2021 06:48:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4DAD81B95;
        Tue, 12 Jan 2021 06:48:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Jan 2021 06:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=+0raSlTIzNkLMCFR2yLILgKMSCS
        KbehTs+cuZNkVTrY=; b=EXg3Za3twIMX3AwbWEsCzx/xfUIOfZTR9DLCU4izfOt
        lX/fZn8hKQQvh2os+uEIzTJg7Y2Go87bB3gqW+sRINKDFgTLcjXvDaAFSPQuFGLQ
        u2zKTv5ttk0IhG7zZWanzl0XjxN7kHJtY2JVVfZSeNPff4EpETGYdu+ZqfrZ6WW/
        Ev4/bAffXd3YKjQ3hbTvqiHpN1sHAPmSQkUgan7bu92s8sbBRgb1o06zwWtpXbnS
        TlLFIB9DJFrsN0XqIfic66UhjEclApTdiDtKsQhg+0ZD1GYs0RfOdTRccmIGYoU4
        mUzmKcIBwkT+tdRI1Ox34UuPimBYDl6jLPAf6JbtYuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+0raSl
        TIzNkLMCFR2yLILgKMSCSKbehTs+cuZNkVTrY=; b=lhsJEGxLA2b5i+S8d5B60F
        Kqk9z6DORyiiRf7CIttiz+z9JxO3Au97YGSHfsx8r1faa6rr96polJ5DJJfDaYLM
        Wq22Qfe1+1zELh4cMTD2qGoQQ4FRMqGxNk2MH7b1PebahoH59wT3GqUnOAQtke9k
        3Fy0N7Q06JvbWugZErryt2Fb1Jh3ZFmMYqo5HF3VZHiBJvjyLxF49+2wUZFTnk1W
        fHDjHUIanbhiamvXY4ChQ6fAK26uNnyz2z3p6DBCXiowkuZQ8dgT292BEDZNlv6Y
        3uCJVfa3Mb70e40u1PqPbAIlCgJuCZlrprAVbQx3DyQ6KAMekD4zBRta/Yq+bMwA
        ==
X-ME-Sender: <xms:dYz9XzuQb34-H43YxRCMT7xeRM6Q-o2PKEfwvKbiKMoyiQeBxxl_Qg>
    <xme:dYz9X0eHb3lYHuy1N-kKNjAWO1Z1C923od2FxRo_ge1WGCsfFEEetJm9cmq2ibSO2
    wTzU180rW8mwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffjuceo
    ghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehjefgfffgie
    dvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeefrdekiedr
    jeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:dYz9X2y72iaDCn0QicxgDETWNbb-4tadmZLbX77voI2ecN2G9iKljQ>
    <xmx:dYz9XyNB-MPQ7OzZNsZ-D-ICT5Mq76fP6xCBiwdixDGcTke3-6yNuw>
    <xmx:dYz9Xz_ywB21mAf9YbAou0r_JerzBOOcsbt2Ue1FlY7uJB_TXgK4Lw>
    <xmx:dYz9X_YOyJ_SH3EzyZNU7jXzTnWUcjqisuNysXwaUm-5EUEwH-uCtA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3FC2A24005C;
        Tue, 12 Jan 2021 06:48:05 -0500 (EST)
Date:   Tue, 12 Jan 2021 12:49:14 +0100
From:   Greg KH <greg@kroah.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Remove one more platform_device_add_properties()
 call
Message-ID: <X/2MupFIWVI5DTUe@kroah.com>
References: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111141045.14027-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 11, 2021 at 05:10:42PM +0300, Heikki Krogerus wrote:
> Hi Felipe, Rafael,
> 
> This is the second version of this series. There are no real changes,
> but I added the Tiger Lake ID patch to this series in hope that it
> will make your life a bit easier, assuming that Rafael will still pick
> these.

I can take all 3 of these if that makes it easier.  Rafael, let me know
what you want to do, either is fine with me.

thanks,

greg k-h
