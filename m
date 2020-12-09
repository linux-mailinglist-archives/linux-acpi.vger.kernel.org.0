Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFDC2D3F3F
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 10:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgLIJyy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgLIJyy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 04:54:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02334C0613CF
        for <linux-acpi@vger.kernel.org>; Wed,  9 Dec 2020 01:54:14 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 91so1023131wrj.7
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2020 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZQiVZic6YLCYQy5UVbdxeeoZXTQTlh0f7abRuA0Ltwk=;
        b=M21MIURXmdO5c10bzaugo5ugbi9CfqsOe9wgeU9EF5YqVlucAMm6CAkeFfpkFHKiFt
         OuAyZyqW9BZ+Qb4CVv7pnhs9xJ87sx4EkEQ2es7tTlsdgqtuN59odcv2q3kCN/gXxzLf
         XMm+gBOPxRRM4OjtxuLXM9HORzv/kfCLG9iMBbZDgn/bQ1ghJNcKzuBhii8n+JVBnWgu
         IEAXJrAMNu5+IElhbac8vjAWN7brsJeAasfaEedjlc7rz7K5C643zVTx4RcGXYfy2gKv
         EJBwoT+/CE5jWBdl4CBaQKG1Zkb9xlc5vWfVIahHexCoeH2SVbkZfkvHGAXvZC1tLWKH
         jO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZQiVZic6YLCYQy5UVbdxeeoZXTQTlh0f7abRuA0Ltwk=;
        b=OOhLQnxtthgNo9QilawnwZtDbBzZPqjXdMuX5AJcv/LKwRRPB2uO/jW7k913TAzDPk
         Vhd+NzgmmJ/Ocmw4K0zaSfHnM+UQj1roUQJm2vI82uYatthNEmlwM2IxHKjoqCckk5SX
         gf7jKjK74Nwvcrwtj2dyrV3nMHNM+iKSqomv28zo98uNOgyPYk/F4TeJmr5IBtTA0wul
         kfdqVAxpNyK/+Q1lt4hmsku2/XQ903nlNto5esD1NLOLAEDa8IOs+sY7Bq+gJJXzBNv4
         epzUiUnSqBwYr6/T507P0xZuXA7pLMQnqDju5ZSnEWxYoY1mXJ0B/MzcW9VcdwHU2T1Y
         eCWA==
X-Gm-Message-State: AOAM532GADXyUDjvH3ESvAIzQLSgJHSkEEPXMXeyT5iEFWq98IZctxdv
        dwMW6KNsJBb+Akh00S7FbrMyQ8l4LqRzIQ==
X-Google-Smtp-Source: ABdhPJyNxIxAQyEB8xw4+MEYp9ApqoIN/Afpd8BJf8W1YxdiJNc/FRdcSQmqWLAp58uoLzX/3JbOHQ==
X-Received: by 2002:adf:dd11:: with SMTP id a17mr1736736wrm.360.1607507652758;
        Wed, 09 Dec 2020 01:54:12 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id h13sm2490874wrm.28.2020.12.09.01.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 01:54:12 -0800 (PST)
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
From:   Daniel Scally <djrscally@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
 <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com>
Message-ID: <9a9c176c-8991-cd12-d2da-34114a9d1aca@gmail.com>
Date:   Wed, 9 Dec 2020 09:54:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 08/12/2020 23:48, Daniel Scally wrote:
> Hello again
> 
> On 06/12/2020 00:00, Daniel Scally wrote:
>> INT3472:08 is not an acpi device that seems to be a good candidate for
>> binding to 0000:00:00.0; it just happens to be the first child of
>> PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.
>>
>> The comment within acpi_find_child_device() does imply that there should
>> only ever be a single child device with the same _ADR as the parent, so
>> I suppose this is possibly a case of poor ACPI tables confusing the code
>> a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
>> set to zero (as indeed do the machine's cameras), but I'm not
>> knowledgeable enough on ACPI to know whether that's to spec (or at least
>> accounted for). The INT3472 devices themselves do not actually seem to
>> represent a physical device (atleast, not in this case...sometimes they
>> do...), rather they're a dummy being used to simply group some GPIO
>> lines under a common _CRS. The sensors are called out as dependent on
>> these "devices" in their _DEP method, which is already a horrible way of
>> doing things so more broken ACPI being to blame wouldn't surprise me.
>>
>> The other problem that that raises is that there seems to be _no_ good
>> candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
>> only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
>> entries and the machine's cameras.
> 
> After some more reading, I'm pretty confident that this is the problem
> now - I.E. that those devices having _ADR of 0 is what's causing this
> issue to materialise, and that those values should be set to something
> more appropriate. Still unsure about the best approach to fix it though
> from a kernel point of view; there doesn't seem to be anything out of
> whack in the logic, and I believe (correct me if I'm wrong) there can be
> legitimate instances of child devices sharing _ADR=0 with the parent, so
> the problem becomes how to identify the illegitimate instances so that
> they can be discarded. My experience in this is really limited, so I
> lean towards the conclusion that hard-coding exceptions somewhere might
> be necessary to handle this without resorting to patched ACPI tables.
> Whether that's within acpi_find_child_device() to prevent matching
> occurring there, or else setting the adev->pnp.bus_address to some
> alternate value after creation to compensate.
> 
> I recognise that that's a horrible answer though, so I'm really hoping
> that someone has an idea for how to handle this in a better way.

Oops, missed this crucial line from the spec:

"A device object must contain either an _HID object or an _ADR object,
but should not contain both."

And here's the Device declaration for these objects:

        Device (PMI0)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, "INT3472")  // _HID: Hardware ID
            Name (_CID, "INT3472")  // _CID: Compatible ID
            Name (_DDN, "INCL-CRDD")  // _DDN: DOS Device Name
            Name (_UID, Zero)  // _UID: Unique ID

So that's the broken part rather than the _ADR value of 0 specifically.
That at least gives a jumping off point for some logic to fix rather
than a hardcoded anything, so I'll try to work out a nice way to handle
that (probably ignoring adevs in acpi_find_child_device() with addr=0
and a valid _HID) and submit a patch.

Sorry for the noise, think I'm good now :)

