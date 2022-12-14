Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C73364D09B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Dec 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiLNUD5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Dec 2022 15:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLNUDR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Dec 2022 15:03:17 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CE52E6BF
        for <linux-acpi@vger.kernel.org>; Wed, 14 Dec 2022 11:58:02 -0800 (PST)
Received: by mail-qk1-f171.google.com with SMTP id pa22so1736102qkn.9
        for <linux-acpi@vger.kernel.org>; Wed, 14 Dec 2022 11:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=newtkcsU2L/mNGxmkIZFRrPuKVEkF/N31MkWuzpD7Cw=;
        b=IQVEXJrQIOllkUylrmHNGdX2By1Dz9qlNc7VpW3to2kTbB97djrG9b3rGHQhU9EgW6
         LKw4mdNtcvjN78CIXbSvJIxIPFHaaUBxvR7Fa8jB4scpqKtWb8FPeL27eWzxE+WpRy3l
         UBhgobI3ytiMoY7WXKKgn31dVF0mpgYYgna2OyGFNqkiK6OFyClhhEneGEKGJgdkGQWX
         eGXYbhUieQVcmcstp464VvT4ajkR18Ygcs4kYmz0e1evCA0oqVX1UOXR7MBTLL89cbIs
         8AIPja6mFFFfxdwAdK3yCW2nndplnwBwnVFIHTnjs8lzBkQFC6ZdpCaGskmqTjnBGhz6
         P8Rw==
X-Gm-Message-State: ANoB5pn7v/CJ7IDL10DjZGBAvrg7wsT3PMZU1MlwlwGEiYnNauU//0sE
        bVMQrN753V1327uWuNNYvVQKgtBQbUoI6Qnypzw=
X-Google-Smtp-Source: AA0mqf54KKy5f6JKYhzIb61gd29PdsSKbtyAHj1UKoFKDJYi/tPlHY6NoqT67dV1wk1ltfzJer8AdQ7k3qsXXfjitis=
X-Received: by 2002:a05:620a:b90:b0:6ff:8f5a:1d37 with SMTP id
 k16-20020a05620a0b9000b006ff8f5a1d37mr729678qkh.501.1671047881095; Wed, 14
 Dec 2022 11:58:01 -0800 (PST)
MIME-Version: 1.0
References: <CAL4jJSh8tKxZc-6qO6oyPm=MrRPwuvkQkQMNmwLbuXX4GAuJ9g@mail.gmail.com>
 <e4df2651-7201-ff43-c3f1-68767f2579cf@intel.com> <CAL4jJShcJB9yHnWL+k4C0cjVW0hFtc=3tx1_0Uz4zbkzaaE_7g@mail.gmail.com>
In-Reply-To: <CAL4jJShcJB9yHnWL+k4C0cjVW0hFtc=3tx1_0Uz4zbkzaaE_7g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 20:57:49 +0100
Message-ID: <CAJZ5v0h-8RR0YLQ3w86JC4DypW-Kcu=snyqtup1wr_-0yzBJKA@mail.gmail.com>
Subject: Re: intel_idle Jasper Lake Support
To:     Maciej Koszanski <maciejkoszanskibusiness@gmail.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 14, 2022 at 8:43 PM Maciej Koszanski
<maciejkoszanskibusiness@gmail.com> wrote:
>
> Hi Rafael,
>
> Thank you kindly for your reply! Very much appreciate your time answering my questions.
>
> Output of /sys/devices/system/cpu/cpu0/cpuidle/state3/desc is ACPI FFH MWAIT 0x60.
> Unsure what depth this attribute denotes, but I assume it's either C6/C7. :)

Probably C7.

> state2/desc is ACPI FFH MWAIT 0x31.

I would say C3.

> Thank you for the clarification above! I was concerned that as powertop was reporting C3_ACPI,
> that the ACPI tables provided C-States with a depth as far as C3, and that Jasper Lake would have
> to have it's own static table added for support of deeper states.

It is clarified in the intel_idle documentation too, please see:

https://www.kernel.org/doc/html/latest/admin-guide/pm/intel_idle.html

> I measured the system that I thrown together based on this CPU to pull about 23W from the wall at idle
> and 45W under load (with an NVME drive that supports APST, ASPM and L1.2, and 2x 3.5inch HDD's.),
> hence the slight obsession to go as low as possible and not be bottlenecked by C-States not going as
> deep as they could. That being said, this is a weird, interesting motherboard I sourced from AliExpres
> s with minimal documentation. :)
>
> Many thanks,

No problem.

Thanks!


> On Wed, 14 Dec 2022 at 18:16, Wysocki, Rafael J <rafael.j.wysocki@intel.com> wrote:
>>
>> +Rui who works on intel_idle
>>
>> Hi,
>>
>> Please see my responses inline.
>>
>> On 12/11/2022 10:53 PM, Maciej Koszanski wrote:
>> > Dear Rafael,
>> >
>> > My name is Maciej, and I'm currently using a Jasper Lake chip (Pentium
>> > Silver N6005) on an install of Debian as a NAS. I'm reaching out as I
>> > believe you're one of the maintainers for the intel_idle kernel, and
>> > you authored the related docs for the module, which I found to be a
>> > nice read. :)
>> >
>> Thanks!
>>
>>
>> > I'm currently running Kernel 6.0.0, and while intel_idle successfully
>> > loads on Debian (cat /sys/devices/system/cpu/cpuidle/current_driver
>> > returns intel_idle), it seems to be defaulting to ACPI c_states
>> > (Powertop is reporting C3_ACPI as lowest C-state).
>>
>> That's correct.
>>
>>
>> > I looked over the source for intel_idle and I don't think there's
>> > mention of Jasper Lake, which leads me to believe that it is not
>> > supported, I hope I'm not mistaken and that I'm not wasting your time!
>> > :) (Tremont-D and Snow Ridge seems to be supported)
>> >
>> This only means that there is no special idle states table for Jasper
>> Lake in intel_idle.  The support is based on the C-state tables returned
>> by the _CST methods in the ACPI tables of the system which is regarded
>> to be sufficient.
>>
>> As a general rule, special idle states tables are only added for
>> processor models where there is a demonstrable advantage from using
>> extra C-states or different MWAIT hints with respect to the C-state
>> tables from ACPI.
>>
>>
>> > Jasper Lake is starting to gain traction now in mini-PC form factors,
>> > and I would greatly appreciate if it was added as a platform in
>> > intel_idle to take advantage of the C-states. I'm sorry if the email
>> > comes off as if I'm begging for a feature to be implemented, and I'm
>> > sure you have other stuff to be busy with, but I greatly appreciate
>> > your time in reading this email to this point. :)
>> >
>> > Attached is an output of my cpuid, from what I gather the chip on the
>> > board that I have is capable of going down to C7?
>> >
>> Yes, it is AFAICS, but the C3_ACPI idle state reported for your platform
>> very well may be C7 (please check the MWAIT hint value in the "desc"
>> sysfs attribute of the C3_ACPI idle state).
>>
>> For the future, I would recommend using my kernel.org address (please
>> see the CC list of this message) for inquiries regarding the Linux
>> kernel and sending CCs of them to linux-acpi@vger.kernel.org .
>>
>> Cheers!
>>
>>
