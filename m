Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172A25E255
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Sep 2020 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIDUEQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Sep 2020 16:04:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59317 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726621AbgIDUEO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2020 16:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599249853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CgznJs0Qby8+sI5KnI0eV1DtqEdlLbN41LSpCpHs+ec=;
        b=Q/xc2Z+zuBjpvVDWWjWcjOSZoxYe05+dXR9WGna4z4sz9epP+V3g1GGwzA5gaDQpjnS8kd
        KxohbRqZ4KwXllN8ccCpOEX3roQdNKDEDqtlIMqX9qHNOUEekbn2H435zxMUTmYv+gaja5
        cWEV1/qoOVU+DuSlK2tvtopOH09WHAs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-xxuhvhxqN06bo6H6OKU_gw-1; Fri, 04 Sep 2020 16:04:09 -0400
X-MC-Unique: xxuhvhxqN06bo6H6OKU_gw-1
Received: by mail-ed1-f70.google.com with SMTP id bm14so3148477edb.2
        for <linux-acpi@vger.kernel.org>; Fri, 04 Sep 2020 13:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CgznJs0Qby8+sI5KnI0eV1DtqEdlLbN41LSpCpHs+ec=;
        b=Nwl5Juz3P8P8r0O1lpax2C8N0sjqPMWbgqXL5HgLUC1sxN49VwMcszmTM8yF3Npjkv
         RvNpim4SIxyd7l+eLunNBaLvIwKhCSw1T2zccvw4rzczp0c0cwaZgdBLizBNII9a0FEF
         3g6cHR5WxkY7Wj75UwDym4k+I7QjQyadFMpTNY1XfWy98f7EHmKxCKwILoXiTvqula+h
         GWon6LMemHz5NIfnJWC95yQt0SeEOGQqCOmsrNGSrB5276E+jr8fBllYV9ucT2LyAr0u
         Q/6kQzfElmGgWp0EHYlHNPYrxO3LbpLtx3fQhB1r8q+cVYb0QRZk5qne2qZHWZsJKb54
         e5bA==
X-Gm-Message-State: AOAM533ZzZwrn979G1tXjKQEihDbwlNhVtCSK0ZK/16BpLcFcOFI3lKH
        +FJml8SB9SUVfXoBCLUzKejBFA+Ysjxl8xBTr9fUrpEBuALzFvENoCraJuf6My9utUJh9dETSdT
        KYRjpv7iYHovsoCKUYUrMcw==
X-Received: by 2002:a50:d2d1:: with SMTP id q17mr10495106edg.167.1599249847335;
        Fri, 04 Sep 2020 13:04:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUIJr9j6hz+PES3hiBLIFfKppiV4/oNxwLPhrQKb09FUTb0+87gsGihtfj2p06lD/AgAfHFw==
X-Received: by 2002:a50:d2d1:: with SMTP id q17mr10495081edg.167.1599249847034;
        Fri, 04 Sep 2020 13:04:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v5sm7020051ejv.114.2020.09.04.13.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 13:04:06 -0700 (PDT)
Subject: Re: [PATCH] pinctrl: cherryview: Preserve CHV_PADCTRL1_INVRXTX_TXDATA
 flag on GPIOs
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20200904172141.180363-1-hdegoede@redhat.com>
 <20200904180947.GL1891694@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <993251db-acac-65f3-56fb-c35044ab8080@redhat.com>
Date:   Fri, 4 Sep 2020 22:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904180947.GL1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 9/4/20 8:09 PM, Andy Shevchenko wrote:
> On Fri, Sep 04, 2020 at 07:21:41PM +0200, Hans de Goede wrote:
>> One some devices the GPIO should output the inverted value from what
> 
>> Fixes: a7d4b171660c ("Input: goodix - add support for getting IRQ + reset GPIOs on Cherry Trail devices")
> 
> Hans, a side note. Can you clean up that driver using ACPI GPIO quirks and the
> idea that IRQ line will be retrieved in client->irq?

Nope, the chip uses the IRQ line in a bi-directional manner,
when the chip is reset (by us) the IRQ line is a bootstrap pin
and we need to drive it either high or low to make sure the chip
re-appears on the same i2c-address as it had before. So we need
the get gpiod and then call gpiod_to_irq abstraction so that
we also have the gpiod to call allow calling
gpiod_direction_input() and gpiod_direction_output() on the
irq pin.

And to make things more interesting on some generations x86 hw
(apollo lake) the IRQ is actually listed as an Interrupt resource
in the ACPI device resources (_CRS) and there are GDIX specific
ACPI methods on the ACPI device which directly poke the GPIO
chip to allow setting it high/low (for during reset) or config
it as input. So the goodix.c has its own internal abstraction
around gpiod_direction_input(() and gpiod_direction_output() for
controlling the IRQ pin which does different things on different
x86 hw generations (while also maintaining device-tree compat).

So all in all I'm happy that we have this all working atm
(and it also is reasonably clean already IMHO) and I would
rather not muck with this.

Regards,

Hans

