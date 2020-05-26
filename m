Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087DC1E27A9
	for <lists+linux-acpi@lfdr.de>; Tue, 26 May 2020 18:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbgEZQsR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 May 2020 12:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731487AbgEZQsP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 May 2020 12:48:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48450C03E96E
        for <linux-acpi@vger.kernel.org>; Tue, 26 May 2020 09:48:15 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so22709539iog.13
        for <linux-acpi@vger.kernel.org>; Tue, 26 May 2020 09:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CDy85Gj7MYd1kNtILJcUzn7KVIhIM0XshsVeAc/i0tA=;
        b=dCxwuhqpPbwbXsS8D4GR15Oi/vkWvJ2t6JE5jqhDuEYRBCxiAwo9cWnqARqt/pZ9N3
         vSDlZ8wDeZydMMsvQgllY5SFL21AkwmUO/yVMpJRwkWuLZ+okFm2plV7st5ZUHxgg7+n
         nw9y2DMW7Y1odFWc8D0ovkNrkmBQTlf+wVi0icllMuisiL6LQjhD1eU0HTahi0uvVson
         7H1igoRa7sC3VzH0k6kw37/8QsEYXM6RYbG1TkZAtikaoCp3wlyHVEwAfTjAFYYV3q4L
         NgflHMgnD8hmupC7gXChsbUVMFzyhgq3aBSV9WdpBp5mfIm6+JpoU8GgF7qXRXSqT3gV
         qZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CDy85Gj7MYd1kNtILJcUzn7KVIhIM0XshsVeAc/i0tA=;
        b=RM3QofaarhmzZg8T7dat3HkDLdaLjQKKtO9LSLYtR6ZocS8L+t6qTM/iEY5p1Pl/4S
         gn3YCcJIZSjOyBtNAiHl/X3g1p9Szh37yWbYIdQStUsZiLHOhEFksEj7p6KKcQIye1Wt
         kt/RnD8y40G7LHj7u9c8kXOtmWJ/Hs9jtwBy58Iy8cTYMGlAn9aT6OAcYU/89cR/1KM3
         Bnc2nF6YQBFUDHhIxw/2aEx1hGs7DhLmc0XOWL0Q6czOp7qxHuK6wtwFXPvIBAF4Wu4K
         xjyRQhIAC6md0YETayIp4CxfChyIIKXNuMooBqsmylA3x7Df1ScijUCls+MdayIj/OuO
         3cCw==
X-Gm-Message-State: AOAM53095GsOVBwjj1jRaK2jKnQVtXrw+3AxKVthqksij6dKMESein5m
        BDp9LlKVdl1O8dIvcAcSCtq3ow==
X-Google-Smtp-Source: ABdhPJwt8EDbE+Md3qNwECgPyEhh34GzLnn6Kwx5Q+Egs2R3PU4UAkkaFOOCDwhKuojJpS4rMr4mTQ==
X-Received: by 2002:a02:2708:: with SMTP id g8mr1921759jaa.52.1590511694529;
        Tue, 26 May 2020 09:48:14 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d29sm250489ild.42.2020.05.26.09.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 09:48:13 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 8/8] net/iucv: Use the new device_to_pm()
 helper to access struct dev_pm_ops
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pci@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        John Stultz <john.stultz@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Felipe Balbi <balbi@kernel.org>, Alex Elder <elder@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-9-kw@linux.com> <20200526063521.GC2578492@kroah.com>
 <20200526150744.GC75990@rocinante>
From:   Alex Elder <elder@linaro.org>
Message-ID: <acb9415a-d0d0-3ebc-b5ae-c26a7dc2114a@linaro.org>
Date:   Tue, 26 May 2020 11:48:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200526150744.GC75990@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/26/20 10:07 AM, Krzysztof Wilczyński wrote:
> Hello Greg,
> 
> [...]
>> It's "interesting" how using your new helper doesn't actually make the
>> code smaller.  Perhaps it isn't a good helper function?

Helper functions often improve code readability, which is
beneficial even if it doesn't reduce code size or efficiency.

But I won't argue for or against this particular change.
It's OK with me either way.

					-Alex

> The idea for the helper was inspired by the comment Dan made to Bjorn
> about Bjorn's change, as per:
> 
>    https://lore.kernel.org/driverdev-devel/20191016135002.GA24678@kadam/
> 
> It looked like a good idea to try to reduce the following:
> 
>    dev->driver && dev->driver->pm && dev->driver->pm->prepare
> 
> Into something more succinct.  Albeit, given the feedback from yourself
> and Rafael, I gather that this helper is not really a good addition.
> 
> Thank you everyone and sorry for the commotion!
> 
> Krzysztof
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev
> 

