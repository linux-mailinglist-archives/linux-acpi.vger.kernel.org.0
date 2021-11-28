Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A284606AD
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Nov 2021 15:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357801AbhK1OJj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 09:09:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357918AbhK1OHi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Nov 2021 09:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638108262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+Jp6usFpaKaaXv9FAmn62UmMCj5S/iWmUh1+bDNphY=;
        b=EaVbYJKyiIwZw706pALgejTA0yEY6q5057TKjF0N9Z5+bXn00dsJTBgV//3Iwn0yWB3GY5
        YV0NyH/HM7/VE+F7sPBV2n1NTcQfWRDg5dNorVyixDa4gA0nVZIJUNdnn0WDmGBrsrVbpE
        /jjbPSXhYFwCWCXmKlg3zbhQP9Bn9/c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-ue3e-aerPU-W0L-p5VvZTw-1; Sun, 28 Nov 2021 09:04:20 -0500
X-MC-Unique: ue3e-aerPU-W0L-p5VvZTw-1
Received: by mail-ed1-f72.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so11444910edq.16
        for <linux-acpi@vger.kernel.org>; Sun, 28 Nov 2021 06:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e+Jp6usFpaKaaXv9FAmn62UmMCj5S/iWmUh1+bDNphY=;
        b=hCbcMSConcz/1lNn5ElpSRzkoEpvUHMkj9LHIfW0gNiV1BjeGooG7Mr0Zz/aTkEPvY
         9ZA+DE/7c4z8hZc/hx3sY9/thfnqu3DIy/06q+0ujtKY+9vSDf6fPnu3DeoG4iCBokEI
         Dvz1Ugz31fvXIzxz9IYvIILZXlIOdSrOPcLqkK3V9HGwD9gfBbuPoFa1Mh3C8z4T/8bX
         RXhmnGLysDIv1F8sjuIaJWSKuA2T2ZH6TkPGt9haNAaJ9czwtCh6veL7Z3FtRc1C+M+g
         6a0/Slh3qIVzFrfdemkQKbXMzBguscVL8oPhLcuwIRj23xNW9hBuEHoCMzEczRnY+1qB
         vlEQ==
X-Gm-Message-State: AOAM533GGRAMrWCttC4XEhTooH096RMF1n6H5N3HOasEyNaVYei8avpX
        /rPTNZutmxxBja9cD4znbrQWRYols1MVnuGKi7sdfaBkgwKNydSmlbTlJbEpPpmr1Facz9VY+TI
        eteIQ5Soh+u6nm3tMBMoijw==
X-Received: by 2002:aa7:c902:: with SMTP id b2mr64149094edt.320.1638108259420;
        Sun, 28 Nov 2021 06:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhrhSzUBXb+AYyMMBNwKamIQdJMxAwciX+H0d0CL9cBVhC0eS1t4VEa6fv8l93EOqDa7U+KA==
X-Received: by 2002:aa7:c902:: with SMTP id b2mr64149027edt.320.1638108259005;
        Sun, 28 Nov 2021 06:04:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q7sm7196971edr.9.2021.11.28.06.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 06:04:18 -0800 (PST)
Message-ID: <af5c448d-0552-abb7-eaf3-8c95116d7733@redhat.com>
Date:   Sun, 28 Nov 2021 15:04:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 15/20] i2c: cht-wc: Make charger i2c-client
 instantiation board/device-model specific
Content-Language: en-US
To:     Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-16-hdegoede@redhat.com> <YZylRkOQsj9LpG5U@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YZylRkOQsj9LpG5U@kunai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/23/21 09:24, Wolfram Sang wrote:
> On Sun, Nov 14, 2021 at 06:03:30PM +0100, Hans de Goede wrote:
>> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
>> in that it is always connected to the I2C charger IC of the board on
>> which the PMIC is used; and the charger IC is not described in ACPI,
>> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>>
>> So far this was hardcoded to instantiate an i2c-client for the
>> bq24292i, with all properties, etc. set to match how this charger
>> is used on the GPD win and GPD pcoket devices.
>>
>> There is a rudimentary check to make sure the ACPI tables are at least
>> somewhat as expected, but this is far from accurate, leading to
>> a wrong i2c-client being instantiated for the charger on some boards.
>>
>> Switch to the new DMI based intel_cht_wc_get_model() helper which is
>> exported by the MFD driver for the CHT Whiskey Cove PMIC to help PMIC
>> cell drivers like the i2c-cht-wc code reliably detect which board
>> they are running on.
>>
>> And add board_info for the charger ICs as found on the other 2 known
>> boards with a Whisky Cove PMIC.
>>
>> This has been tested on all 3 known boards.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Here is my Ack to take this via some other tree:
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>

Great, thank you.

> No need to send further versions of this series to the i2c-list, I'd
> think.

Ok I will drop the i2c-list from the Cc for further versions of this series.

Regards,

Hans

