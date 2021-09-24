Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBA41797C
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Sep 2021 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbhIXRNc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Sep 2021 13:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50374 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235141AbhIXRN3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Sep 2021 13:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VATruCpRyhSoESqa+WnHwPOTrfgkHS0aUWS5P7pA2NI=;
        b=ELZJXqqtP7Snr+Vj0GWobFwdCwKkxkXaw/ZVkwJdJ52eiljbUSswU3yFo7+UzOUneo5wVm
        pITqnEaLpVU61Mq0N0U+OS7mUM0b0RNb0AjMMVHVqkfHGI3oKHS74oeSFnh7VFPNfUPUpw
        6/EGcuiKIJDJhnPHiS0OsNqtMNCNUO4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-Ufmyr1rKNtKWxgGgQ1ye-w-1; Fri, 24 Sep 2021 13:11:46 -0400
X-MC-Unique: Ufmyr1rKNtKWxgGgQ1ye-w-1
Received: by mail-oi1-f198.google.com with SMTP id m84-20020acabc57000000b00275c1cf95d4so7071368oif.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Sep 2021 10:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VATruCpRyhSoESqa+WnHwPOTrfgkHS0aUWS5P7pA2NI=;
        b=u/w7nu8fxLHbkMKKQf1Jf8onq8X5GN9N1XHFCw/UApwN5YdX/R452nVKWKgmqOrttW
         1ONulSeyCIdlSPyGF87c7DbOaNWyGXMRxbI3WcQb59UL8QBYpYy+WYajvjKbBj1NUMnp
         f/GgU3inR7121mRPpFQDLq/H2oKrXQqKhaplwwHylFkdYBe+ozveiVyncEx5/DJlfwK5
         n2kfEuBAMpHq48DeeIrr2E0Kt4cwR5+AlueMzDu1FzpaHZ1rEuMbP/CVprHiaccURvXg
         En7Z9BzWugjpGHJ1a3pFOq1zqV5S9sHVNpZwdqS8V3DbS50WTptE8bSlZOV/qK3OWXbV
         V1JA==
X-Gm-Message-State: AOAM532BE9jZjadJnhI03Pc6CQs5fX7E3H4QcNGJdbjgKVxSmkzUvTav
        WtNCRq7n0qLKGO+efA5b24pr4xre7zw7xjZOyw2l8suTJvVmky1pRnHJC7931Oln0Z99rJ5Iv8K
        4aHB0vChcARuNHm2c7g9s0Q==
X-Received: by 2002:aca:a984:: with SMTP id s126mr2355532oie.150.1632503505795;
        Fri, 24 Sep 2021 10:11:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUqtIzF7ReLSo/TGg59vEm4kaRtQ4rR3KALyDQLN6C8R1NrDrJukCeIC1syZq/wskQ/Ada4g==
X-Received: by 2002:aca:a984:: with SMTP id s126mr2355523oie.150.1632503505651;
        Fri, 24 Sep 2021 10:11:45 -0700 (PDT)
Received: from redhatnow.users.ipa.redhat.com ([2605:a601:ab5e:300:20c:bff:fe44:d76d])
        by smtp.gmail.com with ESMTPSA id u2sm439767otg.51.2021.09.24.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:11:45 -0700 (PDT)
Subject: Re: [PATCH] ACPI: SPCR: check if table->serial_port.access_width is
 too wide
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Robert Moore <robert.moore@intel.com>
References: <20210916194957.197119-1-mlangsdo@redhat.com>
 <CAJZ5v0gGena0k1ne265-+iSDRB9di24ASLuvxHHYk1R3qyz2_A@mail.gmail.com>
From:   Mark Langsdorf <mlangsdo@redhat.com>
Message-ID: <04187ea4-ed00-f477-f6f6-c00f9303c52d@redhat.com>
Date:   Fri, 24 Sep 2021 12:11:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gGena0k1ne265-+iSDRB9di24ASLuvxHHYk1R3qyz2_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 9/24/21 11:10 AM, Rafael J. Wysocki wrote:
> On Thu, Sep 16, 2021 at 9:50 PM Mark Langsdorf <mlangsdo@redhat.com> wrote:
>> If table->serial_port.access_width is more than 29, it causes
>> undefined behavior when ACPI_ACCESS_BIT_WIDTH shifts it to
>> (1 << ((size) + 2)):
>>
>> [    0.000000] UBSAN: Undefined behaviour in drivers/acpi/spcr.c:114:11
>> [    0.000000] shift exponent 102 is too large for 32-bit type 'int'
>>
>> Test that serial_port.access_width is less than 30 and set it to 6
>> if it is not.
>>
>> This consists of a Linux part and an ACPICA part (the changes in
>> actypes.h).  The ACPICA part needs to be submitted to the upstream
>> project before applying this.

Thanks, I wasn't sure of the procedure. I'll get the ACPICA part 
accepted and come back with the rest.

--Mark Langsdorf

