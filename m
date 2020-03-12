Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9282A182FDB
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Mar 2020 13:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgCLMGP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Mar 2020 08:06:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57640 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726254AbgCLMGP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Mar 2020 08:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584014774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xSNpSvUKNp6/83m+odfBvo9SeOnVj+MqMyFuwojaVPk=;
        b=WGIlFxQgatTpPnXZbL+a/VJX7zhLF2vTe9cBsFK5jY6t2cHUNAo+7SXkgpcDYIwnycFnvg
        9S26I8Z2CWUSj7r49L/6GxGDx6GJqwtip6ULaU/eDgp1tnV/dhdDxkUgL3uJ3dSaEmj963
        sO8F/4beRmwyeAevn64TSIFoOSqy8ZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-jqPQfRGhNJi5sigpmv1Raw-1; Thu, 12 Mar 2020 08:06:13 -0400
X-MC-Unique: jqPQfRGhNJi5sigpmv1Raw-1
Received: by mail-wr1-f71.google.com with SMTP id i7so2529734wru.3
        for <linux-acpi@vger.kernel.org>; Thu, 12 Mar 2020 05:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xSNpSvUKNp6/83m+odfBvo9SeOnVj+MqMyFuwojaVPk=;
        b=ohIX/wUwwkCtezFgYiyxWKQHeY3ZEly1CdErpa9DzbolQHEsRB11CbqV0teGR4nZH5
         5o5Jp3PwxNwyrO0nVLMfqhN63gL27wWhxbgasjx195osjQI4dNVzbGScgGO/qsb7GnJF
         d3Do7kOOAWYFzc6PSgpCYoYqwluE65nXcvTWuhLA6S87nt6ATHopW/bXQfZH+pP42Gyn
         XHONhagghb2oPtyW+kfhjPR9Qal2SDezR8XnSSaKCFhBeKiyODgzOEtmt6SI3buCHaIH
         B4brxixdC8FDXidYRS0UfGoJ5rDy2LTHnwITdnnAHVuWFj5ZSg4lfmWBEYlbtdMUmRHo
         HmQQ==
X-Gm-Message-State: ANhLgQ3z/816v4nhZ0dFCvssSD8Sdotwif/5XQDozXe57SIR7ki2ymqP
        NV0LDXAfPDfrbeWg26z+8KpNC0RJDMiQgFDWLN5MK0lctpa5ksBQL5Q/8gigMFOg9EhQR+pVL7E
        o8/w/DEuuI4/Y5Lw9ZKQRCQ==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr4517476wmt.60.1584014772243;
        Thu, 12 Mar 2020 05:06:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt+HRWOgRlV2pNiPqlueoA4u8RAn38ejkM1ffrZr8wxJmwV3UnkER85ZZH0WJCOEzq7uqjitA==
X-Received: by 2002:a1c:2d4f:: with SMTP id t76mr4516835wmt.60.1584014764673;
        Thu, 12 Mar 2020 05:06:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w4sm23445550wrl.12.2020.03.12.05.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 05:06:03 -0700 (PDT)
Subject: Re: [RFC v2] x86: Select HARDIRQS_SW_RESEND on x86
To:     Thomas Gleixner <tglx@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <87sgk4naqh.fsf@nanos.tec.linutronix.de>
 <0e5b484d-89f5-c018-328a-fb4a04c6cd91@redhat.com>
 <87fteek27x.fsf@nanos.tec.linutronix.de>
 <218eb262-011f-0739-8e74-9ca3ef793bb8@redhat.com>
 <87a74mk0gm.fsf@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9a7ebae2-fa65-4a85-5951-120f3543e5fb@redhat.com>
Date:   Thu, 12 Mar 2020 13:06:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a74mk0gm.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/11/20 11:09 PM, Thomas Gleixner wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>> On 3/11/20 10:31 PM, Thomas Gleixner wrote:
>>> Hans de Goede <hdegoede@redhat.com> writes:
>>>>> I just need to stare at the legacy PIC and the virt stuff.
>>>>>
>>>>>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>>>>>> somewhat a big change for that but it does solve some real issues...
>>>>>
>>>>> Yes. Let me stare at the couple of weird irqchips which might get
>>>>> surprised. I'll teach them not to do that :)
>>>>
>>>> I know that you are very busy, still I'm wondering is there any progress
>>>> on this ?
>>>
>>> Bah. That fell through the cracks, but actually I looked at this due to
>>> the PCI-E AER wreckage. So yes, this is fine, but we want:
>>>
>>>    https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de
>>>    https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de
>>>
>>> if we want to backport this to stable.
>>
>> So far I have seen a few, but not a lot of devices which need this, so
>> I'm not 100% sure what to do here.
>>
>> Do you consider this change safe / suitable for stable if those 2 patches
>> are backported and applied first?
> 
> I think so. The two patches are on my list for backports anyway, but I
> wanted to give them some time to simmer.

OK, I'll submit this patch for stable then once your backports have landed.

Regards,

Hans

