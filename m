Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBA6E9BC4
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Apr 2023 20:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjDTShI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Apr 2023 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjDTShH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 14:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51F4692
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2023 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682015725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2wRdZ+8GU0h9nhejVFwROoPzrvBAI9DH4/tBbL3MBw=;
        b=PiDGqOI72fmIDQp+KLqpYt/hwGR70MLmmype0fXn/Yz19YUJO5ZuPtYdFtjW1i5kCs3Tm2
        xmRFDfilLlKq9Ne2Ru5XLo5Y1xGXA2E6GtNvkvEVVq3VeUllBcUwbsuVOoSeL5oocUrxtJ
        4dHVoiJhs6hEhnQ7biffDAAjQt6sNR4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-MBt1CU5QN9mHEeIbdHpjkA-1; Thu, 20 Apr 2023 14:35:23 -0400
X-MC-Unique: MBt1CU5QN9mHEeIbdHpjkA-1
Received: by mail-ej1-f72.google.com with SMTP id jj28-20020a170907985c00b0094f5d1baecbso1662759ejc.4
        for <linux-acpi@vger.kernel.org>; Thu, 20 Apr 2023 11:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682015722; x=1684607722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2wRdZ+8GU0h9nhejVFwROoPzrvBAI9DH4/tBbL3MBw=;
        b=WNkLHHjaHyMIWMFV6ny5oQu0zPOWl42I/K9A4i6AXSErOGGZSyLbthhm6C1nDRcu58
         WliS9KB+fy7pSgVMZVi1K7eewhEoJhvMv5dfk+fvWhA6Nz0lC5n+YWKgND84U8zy8InE
         AhsrYykAQw1WCrzqNAjlEW0XeG+x90+6FYqCjytWXclK5JJBrRRVesZqzQU9Vde5tPPF
         z+Ix/M80mUL8aXHMG+Rsh4p32SOkD2BRDewJy3DC0+Z65DxoP3rr92ADp3zwTnvqdeDC
         8utZqcmPGRmnVf9AeyvVGW3RopViExWSV2XKUlMmG78decLiscEjMFxDtJ9g225cuAhO
         ka0g==
X-Gm-Message-State: AAQBX9dJniAak0+djIUTyA8nFCV6bUC1KCswEdBG7NEqFshcqSbd3uvI
        W5t6iWLiXZV66ovwzL+/sNnxouWNxrZ0hgBAeb0mSRsLU5CSy3Z7iPvCl4Tl4Q8gSvF2e8/oiaX
        ah0NuUVhp7tjAvCNzmZkqjg==
X-Received: by 2002:a17:906:4bd4:b0:94f:8118:d74b with SMTP id x20-20020a1709064bd400b0094f8118d74bmr2493053ejv.40.1682015722630;
        Thu, 20 Apr 2023 11:35:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yz3lXIye/bwYWyg0ojtNrbS7wvGGhxIJNtgOt6szZpNtb1wZy8XJVvzzZZXy/1SiQyGj3VgA==
X-Received: by 2002:a17:906:4bd4:b0:94f:8118:d74b with SMTP id x20-20020a1709064bd400b0094f8118d74bmr2493037ejv.40.1682015722307;
        Thu, 20 Apr 2023 11:35:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b0094f7acbafe0sm1017911ejk.177.2023.04.20.11.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 11:35:21 -0700 (PDT)
Message-ID: <a3b89478-2d37-1b25-94e0-0e12396f6fd4@redhat.com>
Date:   Thu, 20 Apr 2023 20:35:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: REGRESSION: ThinkPad W530 dim backlight with recent changes
 introduced in Linux 6.1.24
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?0KDRg9GB0LXQsiDQn9GD0YLQuNC9?= 
        <rockeraliexpress@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org
References: <CAK4BXn0ngZRmzx1bodAF8nmYj0PWdUXzPGHofRrsyZj8MBpcVA@mail.gmail.com>
 <2023041711-overcoat-fantastic-c817@gregkh>
 <CAK4BXn30dd3oCwcF2yVb5nNnjR21=8J2_po-gSUuArd5y=f9Ww@mail.gmail.com>
 <CAJZ5v0g+PAOZs47LCrxRswZoCmHbGfBg3_cr13Y8zWPXDjgm3A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0g+PAOZs47LCrxRswZoCmHbGfBg3_cr13Y8zWPXDjgm3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Русев Путин,

On 4/20/23 19:02, Rafael J. Wysocki wrote:
> CC: Hans
> 
> On Thu, Apr 20, 2023 at 6:38 PM Русев Путин <rockeraliexpress@gmail.com> wrote:
>>
>>> Any reason why you didn't cc: the developers of that commit?
>> Sorry I did not realise I should have done that.
>>
>>> Do you also have this issue on the latest 6.3-rc release?
>> Yes I have tested it recently by installing the latest 6.3-rc7 kernel
>> , and I do encounter the same issue there. I have linked the
>> screenshots below referring the same.
>> Kernel 6.3.0-rc7 with 43% brightness - https://i.imgur.com/5LqsEJb.jpg
>>
>>> That's what this commit does, right?
>> According to the commit , it was pushed to fix backlight controls
>> which were broken on Lenovo Thinkpad W530 while using NVIDIA. It was
>> not intended to reduce the backlight intensity on W530. Backlight is
>> dimmer than before even when using the laptop in Intel iGPU mode.

This patch should not change the maximum brightness. But you may need
to adjust the brightness once after changing to a new kernel with
the patch because the range / brightness-curve may be different.

On the imgur URL your display brightness shows as being at 43%,
what happens if you use e.g. Fn + F9 to increase the brightness ?

I would expect you to be able to get back your old brightness level
then and this should persist over reboots after you have adjusted
it once.

If adjusting it does not help / work then we will need to revert
the patch causing this.

Regards,

Hans


