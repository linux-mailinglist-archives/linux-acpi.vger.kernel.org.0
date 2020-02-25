Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF4516BEBC
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Feb 2020 11:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgBYK26 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Feb 2020 05:28:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47809 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730258AbgBYK26 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Feb 2020 05:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582626537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SeNohtJk8Z/lFihZ8cJtOY6qMddS7ksum/5KVbX7TlY=;
        b=clJBab7swrOaNif1NzGEbkDYerDrLMeilSV+hi6XXExzDI1ZdbscgtTtSQ1+4NleKVtg6C
        K8SdY4OeN/HpN1Z8Em09vKWLiiOt9LTS741fDonz1U3AMIdol7JkNUF7yEjtUpXfAq5ykW
        PY6HNJ2t7vkRIRpiEDCBs+BMwOw+lpU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-ucgCQiKcM7aVJgmIaVQu0Q-1; Tue, 25 Feb 2020 05:28:56 -0500
X-MC-Unique: ucgCQiKcM7aVJgmIaVQu0Q-1
Received: by mail-wr1-f70.google.com with SMTP id t6so7111978wru.3
        for <linux-acpi@vger.kernel.org>; Tue, 25 Feb 2020 02:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SeNohtJk8Z/lFihZ8cJtOY6qMddS7ksum/5KVbX7TlY=;
        b=Q2Z6Hq/mRHoLHTsVbnCD5kbTZ/wtFWgmP12JZjoT5zM3wdCXyaR1jwQCSvQVvBVcJC
         6DWYD/HSOWAeXRHUs9RRFVWN3g+okAIHOerUdjnE5I2XXZwTWck/mD78zDlWsWbKHNDK
         NuYQ5z3s9jd2Rqq9L7Pv9RGNLHQvt7a4hezu0nOegKfgQpfpOeM70hxhKZhlv7g+bkJN
         E+XjgbvmHqWhb2FjNnRSyHAqkn2SESc/tFbjmsrluaGd1uHp4fUBGLBddBTVOqDERMAd
         XacEQIBB5Hxm5QloWSlIQXQqoGP/igfLMAS692Oag7hCyQsuTo+GMHFFjshdtO/Yy5kz
         uabg==
X-Gm-Message-State: APjAAAVZZuJagSa+dV116emp159/8XX1cRGMNpHthFYjQOUZaIT68hiS
        /vtXmFHpLHUxRW4yLBfGjd8Fi0TtlvKxOBhqi+Lwiwgm6mBZbHqYICIEcEoyBp7NcC0/9REDAo1
        VE2hQu5CXBkM7C/iF5TjNDA==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr48305966wrm.302.1582626534479;
        Tue, 25 Feb 2020 02:28:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUscyA7I0+uTWo7Hd9qm3yS7VxPP4Gj/WGFZhw0+PVnDOrDbCsGzgzsvPU7pbvjZoFdZGMTw==
X-Received: by 2002:adf:e3cd:: with SMTP id k13mr48305936wrm.302.1582626534306;
        Tue, 25 Feb 2020 02:28:54 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-7a91-34f6-66f7-d87c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7a91:34f6:66f7:d87c])
        by smtp.gmail.com with ESMTPSA id b10sm3413635wmj.48.2020.02.25.02.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 02:28:53 -0800 (PST)
Subject: Re: [PATCH resend 1/3] gpiolib: acpi: ignore-wakeup handling rework
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marc Lehmann <schmorp@schmorp.de>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20200225102753.8351-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3810da1d-e5c1-a117-9f05-2cd6d86e0bd1@redhat.com>
Date:   Tue, 25 Feb 2020 11:28:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225102753.8351-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Subject for this one should be:

"[PATCH resend 0/3] gpiolib: acpi: ignore-wakeup handling rework"

As it is the cover letter, sorry about that.




On 2/25/20 11:27 AM, Hans de Goede wrote:
> Hi All,
> 
> The first patch just updates the comment describing why we are ignoring
> GPIO ACPI event wakeups on HP x2 10 models.
> 
> The second patch is more interesting, in the mean time I've learned their
> are actually at least 3 variants of the HP x2 10, and the original quirk
> only applies to the Cherry Trail with TI PMIC variant (and the original
> DMI match only matches that model). We need a similar quirk for the
> Bay Trail with AXP288 model, but there we only want to ignore the wakeups
> for the GPIO ACPI event which is (ab)used for embedded-controller events
> on this model while still honoring the wakeup flags on other pins.
> 
> I'm not 100% happy with the solution I've come up with to allow ignoring
> events on a single pin. But this was the best KISS thing I could come up
> with. Alternatives would involve string parsing (*), which I would rather
> avoid. I'm very much open to alternatives for the current approach in the
> second patch.
> 
> Since sending out the first 2 patches of this series I've received
> positive testing feedback for the quirk for the HP X2 10 Cherry Trail +
> AXP288 PMIC variant, so here is a resend of the first 2 patches with
> a third patch adding a quirk for the third variant of HP X2 10 added.
> 
> Regards,
> 
> Hans
> 
> 
> *) And more complex DMI quirk handling since now we would need to store
> a string + some other flags in the DMI driver_data
> 
> 

