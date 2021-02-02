Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388B830C22B
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 15:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbhBBOma (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 09:42:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234695AbhBBOhX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 09:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612276557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yuioLk+QBKsBksw92DnH4UnwQxafZS+S4qY6HXlBF3g=;
        b=a+2Uhu9fQAHaRQOo9pvpQdqkKW/OnC2yTkWy2Cq6mIe8ONvz8ogPSZLkfZCfeZd4/d5YSG
        uh120LQgHNgO1g0aAOXCpmbYgZWNEOiQInPZKNbt4oSbRApxnSolKUcpAMQd0SOGhmhnxn
        TK15vIPR8pxqMhcccn8lL8Xl+Vhsaj0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-5f30lGN0MNeejRSNZ5HOiA-1; Tue, 02 Feb 2021 09:35:55 -0500
X-MC-Unique: 5f30lGN0MNeejRSNZ5HOiA-1
Received: by mail-ej1-f72.google.com with SMTP id k3so10023060ejr.16
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 06:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yuioLk+QBKsBksw92DnH4UnwQxafZS+S4qY6HXlBF3g=;
        b=iqPJpTRjlwL6hT9iNtLSYLWSZfiz3wmd96mU82iTS3QfHuWRF/f+fumI8yDo3O/Jkf
         2B4nrmR/2bblDt1+1uejK+OA7+yghKli8+AOcK+edVb9l06bmRmelfbnOyCDLbAIeZhG
         xWq+mnuJ1HGOE4a64kuiBN3jCcSLvmAIGEE/TmWh5KR3cU0bAajwYDXoAAzQxbgmuIrY
         prXemgPiIqUlK/+LHaMXq0dtSB4gs2+z1pGLDYNQpTWPoGCNHuvRDhT719rG5IBpj2MA
         qxKH4AxC1Ui4YZd7rayxK1gfybbjgUmTJ++oCbSALNz63uutSjmpiaxdZEtypJjW4rm8
         V7+Q==
X-Gm-Message-State: AOAM531IOAllkKS7hpzW7tnqZOoHgE6d7DtsK17efnFxAdRvMCCv5XEz
        IuR0Ej/40Hs2VHXxQeB6mTj3zY+yDwBqhVMLpWOauumC/Q+aWlBTyyJ8D5F0R7byMcITt11I/nc
        K638BKB1ez4uwbI9Sr4VabA==
X-Received: by 2002:a17:906:8555:: with SMTP id h21mr13769671ejy.403.1612276553516;
        Tue, 02 Feb 2021 06:35:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzX376850pRzW8rhJndm8qGoRK4hnvatMT4A3h6h/V51T3FYCBdyNuksIIYpZES05LFx/deHQ==
X-Received: by 2002:a17:906:8555:: with SMTP id h21mr13769660ejy.403.1612276553364;
        Tue, 02 Feb 2021 06:35:53 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id dm6sm9232402ejc.32.2021.02.02.06.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Feb 2021 06:35:52 -0800 (PST)
Subject: Re: How to detect Cherry Trail vs Brasswell inside the kernel ?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Shevchenko <andy@infradead.org>, linux-acpi@vger.kernel.org,
        x86@kernel.org,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <37906985-e026-48d3-cda8-6e63696e72aa@redhat.com>
 <X/XQak3+YtbyeAqM@hirez.programming.kicks-ass.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2d5b3911-b4b0-70bd-6ac0-c418fef0c682@redhat.com>
Date:   Tue, 2 Feb 2021 15:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <X/XQak3+YtbyeAqM@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/6/21 3:59 PM, Peter Zijlstra wrote:
> On Wed, Jan 06, 2021 at 01:31:46PM +0100, Hans de Goede wrote:
>> Hi All,
>>
>> I've 2 different kernel bugs where the fix requires differentiating between
>> Cherry Trail vs Brasswell, just checking the CPU model does not allow to
>> differentiate between these 2 since they are both using Airmont cores.
>>
>> I have the same issue with the Bay Trail laptop SoCs vs the
>> Bay Trail-T tablet SoCs, but for now lets focus on
>> Cherry Trail vs Brasswell since that is less confusing:
>>
>> https://ark.intel.com/content/www/us/en/ark/products/codename/46629/cherry-trail.html
>> https://ark.intel.com/content/www/us/en/ark/products/codename/66094/braswell.html
>>
>> So I see a number of possible solutions here:
>>
>> 1) Do a (substring) check on the CPU model-name checking for "x5-Z8" and "x7-Z8"
>> 2) Check for presence of some embedded peripheral which is present on one but not the
>> other. E.g. The Braswell devices have HDA audio where as the Cherry Trail devices
>> use the "Low Power Engine (LPE) Audio Controller"
>> 3) Check for acpi_gbl_reduced_hardware, but I'm not sure if that is a reliable
>> indicator of running on the tablet versions of the SoCs.
>>
>> 1 and 2 will work but neither is very pretty, I guess I could try to spend some
>> more time investigating 3. But I only have limited access to the non tablet versions
>> of the Bay Trail and I'm not sure if I have any Braswell devices at all. 
>>
>> So I was wondering if anyone else has any better ideas here?
> 
> Does MSR_PLATFORM_ID (0x17) bits 50-52 work to differentiate these?

Thank you, that is (was) a good idea.

So since you send this email I've added a debug print to the kernel for these
bits and collected the output of that debug print on various devices.

Unfortunately these bits always read 0 on all Bay Trail / Bay Trail-T /
Cherry Trail devices which I've tested, so these bits do not help.

Regards,

Hans

