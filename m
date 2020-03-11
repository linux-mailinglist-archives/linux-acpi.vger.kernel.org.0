Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1164182437
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Mar 2020 22:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgCKVtY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Mar 2020 17:49:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57394 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbgCKVtX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Mar 2020 17:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583963362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5i8d0/y4R6sMxndZYF3wHrGqGjDf4b+kE4cAWVwa8PA=;
        b=hMJvmgjk5K4fLltP2vmZAWiPiae18ThneeaKiw/FkMJO4gx87ZiT1hqUyiRRARuQ09WMtH
        IlD9+vv8ZlNUXSH/BJ4gXIKGJfEqTd3ukUX0vQYoNesLPvSl13UvUlxPzme50/fnJ1/YFq
        l9zEVB7no3zrqf0jKsHfo5jlUZ57lKg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-tkSs4adfM5qgsWjrqhBpeQ-1; Wed, 11 Mar 2020 17:49:15 -0400
X-MC-Unique: tkSs4adfM5qgsWjrqhBpeQ-1
Received: by mail-wr1-f71.google.com with SMTP id b12so1586007wro.4
        for <linux-acpi@vger.kernel.org>; Wed, 11 Mar 2020 14:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5i8d0/y4R6sMxndZYF3wHrGqGjDf4b+kE4cAWVwa8PA=;
        b=Rc6iKFMO3+9mY0bVB98MtkWlpVSc1h/4T9+gdJobYZRMvfebNZuB+kqqSmrjPgJ4dt
         2wMvvw9fzBw1IBM5r9cydKK9cuiWURQWRBWHonhHp9Hcs1qeY1yZbFsFz6SLVTw7yiYh
         ikTKNdyeSnEU0fB8+lcBlkKim1XnOhmriSyWKU+Na1p7+okZBQ+GdDASbzBJ12zc63lQ
         os54LnZ11N5Palts07D7z81sHjlIYUngODJkOiYeA6LmyJK1pjtvhnrV365wZsd+BLNH
         7CRLGIJDn7BNN4bFFQTcOTdRiDjuupYufjxIr8w2jPwH3J4jCtk73VGk7LzS6r1zbxAl
         dO0Q==
X-Gm-Message-State: ANhLgQ3jhdepxrybLefwafNQIdYBn4fusHSJOALtg0ugK2bpeOrXxoxX
        sFLYAxeM6UttatQNAkLjcypl9O4wR+ZJIEUEYTxEvTS8V3OvvF/GKWlqko0isC46EbyNVmfS453
        802dGxJYGapbAs/FxjTiCuA==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr717088wmi.71.1583963354848;
        Wed, 11 Mar 2020 14:49:14 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvJh7ov//Fnzju2Fjoa56M5YkAUFuQ4/RNkG53NtiQYrS/m7+q0+QRUOVFSof+x/grazcfT+Q==
X-Received: by 2002:a7b:c202:: with SMTP id x2mr717075wmi.71.1583963354591;
        Wed, 11 Mar 2020 14:49:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id r23sm16627136wrr.93.2020.03.11.14.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 14:49:14 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <218eb262-011f-0739-8e74-9ca3ef793bb8@redhat.com>
Date:   Wed, 11 Mar 2020 22:49:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87fteek27x.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/11/20 10:31 PM, Thomas Gleixner wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
>>> I just need to stare at the legacy PIC and the virt stuff.
>>>
>>>> Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
>>>> somewhat a big change for that but it does solve some real issues...
>>>
>>> Yes. Let me stare at the couple of weird irqchips which might get
>>> surprised. I'll teach them not to do that :)
>>
>> I know that you are very busy, still I'm wondering is there any progress
>> on this ?
> 
> Bah. That fell through the cracks, but actually I looked at this due to
> the PCI-E AER wreckage. So yes, this is fine, but we want:
> 
>   https://lkml.kernel.org/r/20200306130623.590923677@linutronix.de
>   https://lkml.kernel.org/r/20200306130623.684591280@linutronix.de
> 
> if we want to backport this to stable.

So far I have seen a few, but not a lot of devices which need this, so
I'm not 100% sure what to do here.

Do you consider this change safe / suitable for stable if those 2 patches
are backported and applied first?

Regards,

Hans

