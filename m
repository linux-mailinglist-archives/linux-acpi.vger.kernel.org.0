Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F51A66C1
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Apr 2020 15:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgDMNIs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Apr 2020 09:08:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59873 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727954AbgDMNIr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Apr 2020 09:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586783326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9m5bEJM55+CCEjTc3mQmvoxvmzLMIrk5m1SdUE6h/k=;
        b=U+6gUS6hIWLv9RHFJJDnadm5tYxsCebHQOv4wdGHJLHLWU+79iqtBfp2DaUI8b3Vs77Tdc
        1WKB+cHgTMNjrmgQPdsdBtxenyySW5XaUxQ/0tMcsXghOJjXPZi6isSA+f6NE57EM1kTLh
        cnbUCmN2FNR42KepBIMM0FYrQVWq8+Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-BFDoHdsIPM2X8QT4o_ZHXA-1; Mon, 13 Apr 2020 09:08:44 -0400
X-MC-Unique: BFDoHdsIPM2X8QT4o_ZHXA-1
Received: by mail-wm1-f71.google.com with SMTP id t62so2639665wma.0
        for <linux-acpi@vger.kernel.org>; Mon, 13 Apr 2020 06:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s9m5bEJM55+CCEjTc3mQmvoxvmzLMIrk5m1SdUE6h/k=;
        b=NaSoLb9h385K3xJdEC/eAy44l1x4dpTeIGUjkekBHCYes3djZC+eBeJ8o7Q365PG/K
         tMtzb3db7Zo7OAkibPnW5h8cC++FOugEUYWTW0qPYdQQF0RLK9yIfMkgdy4sWadHu2nN
         byQ/ewkBQ+uiJPajqnlI+2cnPVoOl+g8S7VzlEwSEKt6sdF+SeC1OPAVglHutMEEIs1C
         raEplcWl6AP+2lZvhdxyHhJ6FoGgEZflz6P1zEO/k0Wox1QwbGN98p9Lwk23muv1OTqW
         pxrJsKp2ZJ4LGgs1zYLcLfog33chyH8gOjuYCePvTdprcYa5bNucP9bHpBDK/k1/c7kF
         fLEw==
X-Gm-Message-State: AGi0PubBPvTvr0V1W2AjTlwpJule/E324TSEZgGXk5UQIqr5VVOxKHT5
        mh2nJxFTGPOBJUWeTfuS85/k6vuw7gz+X6ebvpPRf9ViphryO0C7ms03HlyclCnJsQE2h1YSBUH
        ZZxCZ4kjYqjmnjHFhsATXCA==
X-Received: by 2002:a5d:522c:: with SMTP id i12mr1051154wra.215.1586783322931;
        Mon, 13 Apr 2020 06:08:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJSH7viqtLUiSYWLMN2+J0c6+yVIDg8r4gEnWrO7CZ/ceQ5+EZ5b1PZUTdcQFfUQRJNgizuQ==
X-Received: by 2002:a5d:522c:: with SMTP id i12mr1051139wra.215.1586783322746;
        Mon, 13 Apr 2020 06:08:42 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id e1sm3845350wrc.12.2020.04.13.06.08.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 06:08:41 -0700 (PDT)
Subject: Re: [PATCH] ACPI/PCI: pci_link: use extended_irq union member when
 setting ext-irq shareable
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20200410194547.GA7293@google.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <abaa91fa-12a4-e273-c983-7d1153dab9a2@redhat.com>
Date:   Mon, 13 Apr 2020 15:08:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410194547.GA7293@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/10/20 9:45 PM, Bjorn Helgaas wrote:
> On Fri, Apr 10, 2020 at 03:14:42PM +0200, Hans de Goede wrote:
>> The case ACPI_RESOURCE_TYPE_EXTENDED_IRQ inside acpi_pci_link_set()
>> is correctly using resource->res.data.extended_irq.foo for most settings,
>> but for the sharable setting it sofar has accidentally been using
>> resource->res.data.irq.shareable instead of
>> resource->res.data.extended_irq.shareable.
>>
>> Note that the old code happens to also work because the sharable field
>> offset is the same for both the acpi_resource_irq and
>> acpi_resource_extended_irq structs.
> 
> s/sharable/shareable/ several times above
> s/sofar/so far/
> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks, I'll send out a v2 with the spelling issues in the commit-msg fixed.

Regards,

Hans



> 
>> ---
>>   drivers/acpi/pci_link.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
>> index 00a6da2121be..ed3d2182cf2c 100644
>> --- a/drivers/acpi/pci_link.c
>> +++ b/drivers/acpi/pci_link.c
>> @@ -322,10 +322,10 @@ static int acpi_pci_link_set(struct acpi_pci_link *link, int irq)
>>   		resource->res.data.extended_irq.polarity =
>>   		    link->irq.polarity;
>>   		if (link->irq.triggering == ACPI_EDGE_SENSITIVE)
>> -			resource->res.data.irq.shareable =
>> +			resource->res.data.extended_irq.shareable =
>>   			    ACPI_EXCLUSIVE;
>>   		else
>> -			resource->res.data.irq.shareable = ACPI_SHARED;
>> +			resource->res.data.extended_irq.shareable = ACPI_SHARED;
> 
> Ouch, looks like that copy/paste error has been there since the
> beginning of git.  Nice catch!
> 
>>   		resource->res.data.extended_irq.interrupt_count = 1;
>>   		resource->res.data.extended_irq.interrupts[0] = irq;
>>   		/* ignore resource_source, it's optional */
>> -- 
>> 2.26.0
>>
> 

