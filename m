Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20C390C30
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 00:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhEYWbA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 May 2021 18:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhEYWa7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 May 2021 18:30:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526FAC061574;
        Tue, 25 May 2021 15:29:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n2so33904808wrm.0;
        Tue, 25 May 2021 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yHrYHt9lX7EfFlqtvt9zE3RQPwkkMllvHJPqz5tzqnk=;
        b=KctzmADNy8hq3ORFwjPbcZ+2ne8jXz8auizHW+olGT9VbwbfXURRKo6gAoz7Yd7nDz
         +ey86WUfYFxD8kwRjjgM7wswcu6Apk5IdABUP7bj/JrLcV/iKdtks4KRFmwZo5vBBQ/s
         IDRTQrhG+XQWJyf3tZTgqmpi9sEg/ym4yZGqv8aD96NkwZPD4g6sApuvPkfLf0ENLVKB
         zatR1xvt/cxG3wNMEaYKuj8mkODtMRNP7wLka+zzBZerrs2xMHNbH+hQIUGMndbMdQl4
         ohpHKVz+LgGj92Z8Vs/hf6YRnQhMs15WYeZemIHTm2n3/OQ18l3kkWVHDK7Uuu+8pWyS
         SlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yHrYHt9lX7EfFlqtvt9zE3RQPwkkMllvHJPqz5tzqnk=;
        b=gE8nLTyxcE43Pbr3tCB0UKIlU8nbsXvxcfAmKgt3HTl9ndKll1cX++XPzaJ5tLRH10
         K28X5eY4TftM92in0SGm8SUoDfRew7CPNW4NjyI3PTrMvtKchCNBGjVNcWeCyOkCmgiL
         HoSdao9y0Rw3tQJ8iYpMzhAnWe4lWhLUGw0CdPKfMhQtBQzO5vDaFzV1ayFscXm111+6
         sX6BxA3IfeVxufjlX2dp2eCMp6Nvv1d3RAGm0nvSDT7cSg/QcUpeprGIVHdhjqJQsEXP
         kxFepXiGoa3ug2TmGB8BtO/RdOnFaqRY/OsTDfOBQ0RWRSgsBIYeJcOk29poJKO6na9D
         Kdog==
X-Gm-Message-State: AOAM530lvRvznpXm66qnmSEElRut9bwvMfFGTxJ5iLtP2vdrOARHZU4o
        pS1IzQGSuAzxnkAP0pvODcY=
X-Google-Smtp-Source: ABdhPJwghEMpeIbiYervpgptKtIrJHjTkEsbsLRwUHSE49JK3LGObn65hnvWlPB00tWyLKZ8nEKFOw==
X-Received: by 2002:a05:6000:12cc:: with SMTP id l12mr29161723wrx.91.1621981766965;
        Tue, 25 May 2021 15:29:26 -0700 (PDT)
Received: from [192.168.1.211] ([91.110.20.117])
        by smtp.gmail.com with ESMTPSA id i11sm17883091wrq.26.2021.05.25.15.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 15:29:26 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] ACPI: utils: Fix reference counting in
 for_each_acpi_dev_match()
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
References: <20210519210253.3578025-1-andy.shevchenko@gmail.com>
 <CAJZ5v0in=qEtVULLF=RwBTiFqiRK-DyPfD4F6uUAqeUfPFB8QQ@mail.gmail.com>
 <CAJZ5v0hsDpGtLHPQvcnof3c1LBnhoZSwWyHJdj1mOov9gV_W8A@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <50903d09-96f8-0dc9-a1f7-21bf1543b15a@gmail.com>
Date:   Tue, 25 May 2021 23:29:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hsDpGtLHPQvcnof3c1LBnhoZSwWyHJdj1mOov9gV_W8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Andy

On 20/05/2021 20:40, Rafael J. Wysocki wrote:
> On Thu, May 20, 2021 at 9:13 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, May 19, 2021 at 11:19 PM Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> Currently it's possible to iterate over the dangling pointer in case the device
>>> suddenly disappears. This may happen becase callers put it at the end of a loop.
>>>
>>> Instead, let's move that call inside acpi_dev_get_next_match_dev().
>> Not really.
> OK, I see what you want to achieve and the macro is actually buggy,
> because it leaves unbalanced references behind.


Yeah; I guess the originally intended use (which was "get all these
devices") doesn't really tally with the naming or with the operation of
similar functions in the kernel like the fwnode_handle ops; sorry about
that. Anyway; I think Andy's fix is the right way to do it, so the
calling code's responsible for holding onto a reference if it wants to
keep it.

>
>>> Fixes: 803abec64ef9 ("media: ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver")
>>> Fixes: bf263f64e804 ("media: ACPI / bus: Add acpi_dev_get_next_match_dev() and helper macro")
>>> Cc: Daniel Scally <djrscally@gmail.com>
>>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>>> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> ---
>>>  drivers/acpi/utils.c                       | 5 +----
>>>  drivers/media/pci/intel/ipu3/cio2-bridge.c | 8 +++-----
>>>  include/acpi/acpi_bus.h                    | 5 -----
>>>  3 files changed, 4 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
>>> index 3b54b8fd7396..ccfc484dbffd 100644
>>> --- a/drivers/acpi/utils.c
>>> +++ b/drivers/acpi/utils.c
>>> @@ -846,10 +846,6 @@ EXPORT_SYMBOL(acpi_dev_present);
>>>   * Return the next match of ACPI device if another matching device was present
>>>   * at the moment of invocation, or NULL otherwise.
>>>   *
>>> - * FIXME: The function does not tolerate the sudden disappearance of @adev, e.g.
>>> - * in the case of a hotplug event. That said, the caller should ensure that
>>> - * this will never happen.
>>> - *
>>>   * The caller is responsible for invoking acpi_dev_put() on the returned device.
>>>   *
>>>   * See additional information in acpi_dev_present() as well.
> But the kerneldoc really needs to say that the caller is required to
> obtain a reference on adev before passing it here, because that
> reference will be dropped and the object pointed to by adev may not be
> present any more after this returns.
>
>>> @@ -866,6 +862,7 @@ acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const cha
>>>         match.hrv = hrv;
>>>
>>>         dev = bus_find_device(&acpi_bus_type, start, &match, acpi_dev_match_cb);
>>> +       acpi_dev_put(adev);
