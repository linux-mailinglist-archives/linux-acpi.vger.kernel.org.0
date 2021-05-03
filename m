Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8863737174D
	for <lists+linux-acpi@lfdr.de>; Mon,  3 May 2021 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhECO7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 May 2021 10:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbhECO7P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 May 2021 10:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620053901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+1NKjm/wRa1ASFx+bl+rP9pP0wqehVAt5BNtGXbyfdI=;
        b=LNZfqp670VUDD3O9H9E1S7PxY6MtXNWgTWQsqBKnnM9IWcpa0mFI1avPGzD5HcDUVrOGle
        oRGkD0HRa5smdqF0b/rS7z11IPmwK7KvphgfOxKVwzGS7/wk5PvHvsbc2SkUU7R8LBixd/
        PYT+h+XxlzWMfgTO6lP7jZgjyOaMYF8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-4bnmcqavMEmAm6gJl6ZaRQ-1; Mon, 03 May 2021 10:58:20 -0400
X-MC-Unique: 4bnmcqavMEmAm6gJl6ZaRQ-1
Received: by mail-qv1-f71.google.com with SMTP id b1-20020a0c9b010000b02901c4bcfbaa53so5066121qve.19
        for <linux-acpi@vger.kernel.org>; Mon, 03 May 2021 07:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+1NKjm/wRa1ASFx+bl+rP9pP0wqehVAt5BNtGXbyfdI=;
        b=jHIa/rEjA3gH66hXrRl7AgRZANs3P1h19OEdYpGbZLOfIMxetbi5ItV0oIksyXtPe1
         CxNmOWskvr9pWL7fePJ41lnmJIh3lF8FVkjRwZskvJHdSqz7kyTcEnmnZyXKUhKqVsnV
         I0ezU2QjPGIwgAko7JlwjjgN1PrvcKyh5sxEdZRJ53d09fT4cgX+mP4nqniES6JV9tDX
         TNzSQe+TY6nMN+M90TldvVjwOqYS7mf88O4rXrdqFYz9dF4SA/QQGaUwFQRvveARWSFB
         K+8mr0zTH2M3XeoqVVA9IMCUy2sjvMKhzu3Tes/ZZ9RYE65GIFJMJWbydu22yjMMzcJL
         nhow==
X-Gm-Message-State: AOAM5334IE18vitzsQb203+Rq/vVYBigkyK4hXd4YueRef9aAnlnFoZl
        zg+mhVjXRJYKcX9Jot0fdKEnkx3IhMYYxIlPXsI+qOJ5khXYqiWdv1UfRpXce+QeK/QYiW9sPLS
        AdlwLOOJNOXDHWgIVF7ry7kaZJr83uln4UHMFbNSwgaoo8NqqCGCMGJadef+uJk5Ib1AXvZ41cg
        ==
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr19860562qve.27.1620053899464;
        Mon, 03 May 2021 07:58:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxptnzVpU0NBKcMVYpyFa3BHI12ZMtykeAfpqgRtfih1ZQzTuR99a0As0jGFWcC0M56hnJqSQ==
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr19860524qve.27.1620053899192;
        Mon, 03 May 2021 07:58:19 -0700 (PDT)
Received: from redhatnow.users.ipa.redhat.com ([2605:a601:ab5e:300:20c:bff:fe44:d76d])
        by smtp.gmail.com with ESMTPSA id a195sm17437qkg.101.2021.05.03.07.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:58:18 -0700 (PDT)
Subject: Re: [PATCH] Revert "ACPI: custom_method: fix memory leaks"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210502172326.2060025-1-keescook@chromium.org>
 <0fefece0-f8a1-6ee1-114f-0a2bb412b986@redhat.com>
 <YJAN/nwldJKwTV/V@kroah.com>
From:   Mark Langsdorf <mlangsdo@redhat.com>
Message-ID: <99653e1a-97a3-b532-1775-31d8115bfc62@redhat.com>
Date:   Mon, 3 May 2021 09:58:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YJAN/nwldJKwTV/V@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 5/3/21 9:51 AM, Greg Kroah-Hartman wrote:
> On Mon, May 03, 2021 at 08:17:14AM -0500, Mark Langsdorf wrote:
>> In 5/2/21 12:23 PM, Kees Cook wrote:
>>> This reverts commit 03d1571d9513369c17e6848476763ebbd10ec2cb.
>>>
>>> While /sys/kernel/debug/acpi/custom_method is already a privileged-only
>>> API providing proxied arbitrary write access to kernel memory[1][2],
>>> with existing race conditions[3] in buffer allocation and use that could
>>> lead to memory leaks and use-after-free conditions, the above commit
>>> appears to accidentally make the use-after-free conditions even easier
>>> to accomplish. ("buf" is a global variable and prior kfree()s would set
>>> buf back to NULL.)
>>>
>>> This entire interface needs to be reworked (if not entirely removed).
>>>
>>> [1] https://lore.kernel.org/lkml/20110222193250.GA23913@outflux.net/
>>> [2] https://lore.kernel.org/lkml/201906221659.B618D83@keescook/
>>> [3] https://lore.kernel.org/lkml/20170109231323.GA89642@beast/
>>>
>>> Cc: Wenwen Wang <wenwen@cs.uga.edu>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>> ---
>> I have two patches submitted to linux-acpi to fix the most obvious bugs in
>> the current driver.  I don't think that just reverting this patch in its
>> entirety is a good solution: it still leaves the buf allocated in -EINVAL,
>> as well as the weird case where a not fully consumed buffer can be
>> reallocated without being freed on a subsequent call.
>>
>> https://lore.kernel.org/linux-acpi/20210427185434.34885-1-mlangsdo@redhat.com/
>>
>> https://lore.kernel.org/linux-acpi/20210423152818.97077-1-mlangsdo@redhat.com/
>>
>> I support rewriting this driver in its entirety, but reverting one bad patch
>> to leave it in a different buggy state is less than ideal.
> It's buggy now, and root-only, so it's a low bar at the moment :)
>
> Do those commits really fix the issues?  Is this debugfs code even
> needed at all or can it just be dropped?

One of my commits removes the kfree(buf) at the end of the function, 
which is the code that causes the use after free for short writes.  The 
other adds a kfree(buf) before allocating the buffer, to make sure that 
the buffer is free before allocating it.

There are other bugs in the code that neither my patches nor the revert 
address, like the total lack of protection against concurrent writes.

--Mark Langsdorf

