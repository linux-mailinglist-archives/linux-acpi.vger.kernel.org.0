Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F383EA78B
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Aug 2021 17:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhHLP2A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Aug 2021 11:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238056AbhHLP17 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Aug 2021 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628782053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TA43mTMVbiIVQ6dhmdTyeMp0SQjli5MTAeYmJDtnicw=;
        b=BPrkcfqKeXlyf3EX8nPQ7RolHXPV7j5FAFKiPV0itaEs9NLZkO7RwN6y1j0gAQpA/Z0fiM
        5oO1C53tzuc38UUX+v7syIi5Kkl2wgEXKHhPIZbKWwrJh2P4No8sZckJJM/NTEqSCptfpc
        iaDcztX1nzQINjh4pH8Of5797Fwu9ks=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-A9BntTO_NjqpqhwLiejIqA-1; Thu, 12 Aug 2021 11:27:32 -0400
X-MC-Unique: A9BntTO_NjqpqhwLiejIqA-1
Received: by mail-ed1-f72.google.com with SMTP id j15-20020aa7c40f0000b02903be5fbe68a9so3220344edq.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Aug 2021 08:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TA43mTMVbiIVQ6dhmdTyeMp0SQjli5MTAeYmJDtnicw=;
        b=P7djFG9JcPZlS4+PsQvLOulvXraKlD/0/wCvqXgGhlbTebrdGRqFa2oUX0ku3Kg5o2
         gYjFUGilg15aGYkKBgamO0G47A8GAIZFvYNezPD36Xxg3o9dAmKaleot6gtVtlCkpXUu
         VKYntmPPRq/AykVOJNYWMK2QJo79fnuwyDCVFpma5eyqAb3fiS9Uz19s7M+8reOb308R
         IJwjWf6fSqQahfmPUorUzEM/AgiXKnm0hiOM78NIiS1gWKTr3yQexqB4gINEEBu61Y6j
         5+VXubSpwkYsmjSSMcxtkwP+n5RZmvKkk9IIUTeUvJ4+Tdbycrp09npzCZarAWYJceud
         42JQ==
X-Gm-Message-State: AOAM53317Dd2uVYoStxgMoae1IJ4cmICmBGhughjt4kMUEGWgAvX2iEe
        RT4ABZDqMaTBPOEabTVa+FlBzlOXvXhMT7avymorHjRPN91uU5KxQNn3G7NpdexzfpKikC18lUA
        VccQUSJksXJltAE6X3t+WXHqMKRDX6weoqT4oitdrRzDRIWVY9W/rZJ5w8De13ihYkB4TkBkrVw
        ==
X-Received: by 2002:a17:906:3699:: with SMTP id a25mr4172180ejc.452.1628782050599;
        Thu, 12 Aug 2021 08:27:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpILZdmucUro1fJ64BfQNPV6SuGjTwtVbrBbBvEFyx8GHmFvspoTgFJocAtBVCS59l9cOYWQ==
X-Received: by 2002:a17:906:3699:: with SMTP id a25mr4172160ejc.452.1628782050459;
        Thu, 12 Aug 2021 08:27:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id h8sm1293286edv.30.2021.08.12.08.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:27:30 -0700 (PDT)
Subject: Re: [PATCH 1/4] i2c: acpi: Add an i2c_acpi_client_count() helper
 function
To:     Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20210803160044.158802-1-hdegoede@redhat.com>
 <20210803160044.158802-2-hdegoede@redhat.com> <YQlzzy933V9XMHqt@lahna>
 <9fbf0d6a-2df3-4765-ccf5-788b86994d71@redhat.com> <YRLlNh4MrHyVobvR@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8b624c87-21dd-e051-d3f5-400212ed590c@redhat.com>
Date:   Thu, 12 Aug 2021 17:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRLlNh4MrHyVobvR@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/10/21 10:44 PM, Wolfram Sang wrote:
> 
>>>> We have 3 files now which have the need to count the number of
>>>> I2cSerialBus resources in an ACPI-device's resource-list.
>>>>
>>>> Currently all implement their own helper function for this,
>>>> add a generic helper function to replace the 3 implementations.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Thank you, Wolfram are you also ok with me merging this
>> patch through the pdx86 tree?
> 
> Sure!
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>

Thank you. I've added this series to my review-hans branch now.

I'll push it out to pdx86/for-next after some (build) testing.

Regards,

Hans

