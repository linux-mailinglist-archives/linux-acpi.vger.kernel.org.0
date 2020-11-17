Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416492B5988
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Nov 2020 07:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgKQGFT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Nov 2020 01:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKQGFT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2020 01:05:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF26C0613CF;
        Mon, 16 Nov 2020 22:05:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m16so6328220edr.3;
        Mon, 16 Nov 2020 22:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1D5+sHmUNH52Iu2Qtq6250gD2qVYhSdcv/pbrGTVi20=;
        b=CZkdAzkhNLmk2mkDWDyVYvfv47dMHpHsSwz4EfaRRvflDn8i7a8r8JsbWvCuNhOVb8
         ShCOmMErN3gntS65gOsz1U6GziWtybq51kDmjZAltHfSY6elL//Flv3t9iXYjXJpcnDK
         Bp8acYTmYoWk/TF1zh9cIvI2u6yMoG2y/XAgcWl/TaFqQd6tOhcPAJ4u3cUlIWAoxKZh
         EphfZz6F20+Pz5mDccWpIRdJKK5RldaD2qxeTh22inRZtsUGraMUXoNRu+iwxLnKeDQP
         ++phiQQvEgWkcH+NtoRosZXZETCciOGnR/d3oYg5L3W3TiR4gJWX3fU6StR8TJxGQo9R
         4uNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1D5+sHmUNH52Iu2Qtq6250gD2qVYhSdcv/pbrGTVi20=;
        b=KX4PV72qrxwLZqFUdQjMBsbJEdFyEo6wjSINgx/Bqi3U+J1ZN+CaIQ3UNp7ozvMvFC
         eEKj/OVF3J6qmqnVqGizAfZJ0dR9wFP9U3evhTRKhC7ZLWtE22OPnAjzy8yOUeSYVxHe
         qVDjuE8aKMBnAr/XjDZY+QYTPay2epOL0+W0rLSbmphREnr33LXVkKotDxiV7gz1N1J7
         cXIYOmwKS4OLuEV5TE64OflF3u13gPfxovK3fah3RZ1u3ZGXSFKmWbb301nkOMYxjdVK
         5ocK7VJlbXNFbkeQJ8HNBScYYBx1/U+v57WZnBCB9V8Vij12qrOL5NNQEgyfajrzsj5s
         C2vg==
X-Gm-Message-State: AOAM533B6Z8OTc3svU8mjuU4hT3BVPSx9utaJGHWWOVq7bIMR6/f+FcQ
        eqHe2BbG9s87Ra65xCs3H5V7SFWDAF4=
X-Google-Smtp-Source: ABdhPJxnxnaQSEoQtNlRof1LxQkkQ/p6a3aUL7/oSgCOboVrz7x+zyq3MnwOVSQi3/vZhkFSya8DsQ==
X-Received: by 2002:aa7:c3c3:: with SMTP id l3mr19371737edr.118.1605593115571;
        Mon, 16 Nov 2020 22:05:15 -0800 (PST)
Received: from [192.168.2.202] (pd9e5afac.dip0.t-ipconnect.de. [217.229.175.172])
        by smtp.gmail.com with ESMTPSA id f7sm11282315ejz.23.2020.11.16.22.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 22:05:14 -0800 (PST)
Subject: Re: [PATCH 1/9] platform/surface: Add Surface Aggregator subsystem
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
 <20201115192143.21571-2-luzmaximilian@gmail.com>
 <CAHp75VdOnUW6kftkD1zGR345fJUPPv9zfi0YitYJOb1BPxQcPw@mail.gmail.com>
 <8768d422-15f1-9fa3-481f-53be8549c395@gmail.com>
Message-ID: <596dd647-b874-29f5-5bbf-a02f9d6ac587@gmail.com>
Date:   Tue, 17 Nov 2020 07:05:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8768d422-15f1-9fa3-481f-53be8549c395@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/16/20 6:03 PM, Maximilian Luz wrote:
> On 11/16/20 2:33 PM, Andy Shevchenko wrote:
>> On Sun, Nov 15, 2020 at 9:25 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:

[...]

> READ_ONCE and WRITE_ONCE are used to ensure proper access to state that
> can be changed outside of the queue/pending locks (or under any one of
> them). In general, I have tried to document all critical access of such
> state with an explanation of why it is safe to do so.

I've looked at this again and noticed that I can guard the packet
timestamp by the pending lock and the packet priority by the queue lock
(after first submission). This makes reasoning about access to them
significantly easier and removes the need for WRITE_ONCE / READ_ONCE.

After that, READ_ONCE is used

- to access the controller state for smoke-testing to (hopefully) detect
   invalid request function usage (note that all other access to this
   state happens under the controller state lock)

- for the "safe counters", where access to the shared value is, after
   initialization, restricted to the increment function

- to update the timeout reaper, where access to the shared value
   (rtx_timeout.expires) is, after initialization, restricted to its
   modification function (ssh_ptl_timeout_reaper_mod() /
   ssh_rtl_timeout_reaper_mod()) and the timer function

- to access the request timestamp, which is, after initialization, only
   set once in the lifetime of a request (all other access is read-only)

- to access the 'ptl' reference of the packet, which, after
   initialization, is only set once, either at packet or request
   submission (all other access is read-only). Note due to this,
   READ_ONCE is only required for functions that can run concurrently
   with ssh_ptl_submit() and ssh_rtl_submit(), i.e. ssh_ptl_cancel() and
   ssh_rtl_cancel().

- to access request state outside of bit-ops when canceling

I'd argue that all of these cases can be checked and verified with a
reasonable amount of effort. Cancellation (last two points) is probably
the most complex one. Unfortunately, I don't see any way to simplify
that part without disallowing cancellation to run concurrently to
submission, which is something I'd like to support as this makes
implementing asynchronous requests in the future easier.

Regards,
Max
