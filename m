Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60374453122
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Nov 2021 12:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhKPLr5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Nov 2021 06:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235213AbhKPLrr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 Nov 2021 06:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637063088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sn/p/hpi6MBsSZpydt8wXcnaOACVPYaQAYfUrhLjl0U=;
        b=OqIdqd8zSiEsI+h2YjxLJerHQe8BQrSsMwh/Ya55bdVO93tDbNfNN94BoJx8XxA4gbsxEm
        ccDpl3sWEB1rAqjtY6fXMNxzD/+oIhop8g/6fpQah0zs/DIMH7dehsb5areB1SGv02Q7Ry
        k5Tms22MAFcXpRupXAzBpKJrUUsXz3c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-rcwoM5avOHu-MdZtyG8nJg-1; Tue, 16 Nov 2021 06:44:47 -0500
X-MC-Unique: rcwoM5avOHu-MdZtyG8nJg-1
Received: by mail-ed1-f72.google.com with SMTP id h18-20020a056402281200b003e2e9ea00edso16891797ede.16
        for <linux-acpi@vger.kernel.org>; Tue, 16 Nov 2021 03:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sn/p/hpi6MBsSZpydt8wXcnaOACVPYaQAYfUrhLjl0U=;
        b=xbkBmDHBacpKt7rnKUU3iJwn48jNeL+ij242qga9fVhfuM3HG35iYElR2cIT3Ykbgg
         7Rds/bS+dKxiH8d19PCyLHo6+ZE3DkeI07Dir0WMUjov/da0BVWZlAg0qPQikbW1dDKO
         +dohtEciXrN0sni6cGfqXkYVSfqps6yNShglIfNfrT49z4G+ueZ6CrckWsnVW9SqhTMG
         TbU39iyqL4ZfN3K6oXKMAnCW7pcBut2PJz1Lz4zi2wcYXVPEIhXxsFby4p12lbQ8YhNn
         8ghrw1DrtOrGj5kTKFYaQsj8cbEC4y1pxWhaD7hGwBTkgCa5aSsnB5oRcyaSaDcmmjka
         SXiA==
X-Gm-Message-State: AOAM5333hNpBTzlg9w5qeTH7nG1JEmDpGGdxreXWxHZWUQrzNSkBZBUt
        DOAZb9zEwyH+iKQidCRXkQm93cxcEuspACLeS9TfR8YdBoENMSTemoFIWKzhnoEg0ruZ4og5KR7
        5sBAXRT+XAZrdD0LsnfABvg==
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr9550772edb.240.1637063086381;
        Tue, 16 Nov 2021 03:44:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl+WYnI6oc2LxPoz+q8exWpOVk572rEKUnSYZcWrd7WcpL0tMOeQOrW251/QM6n9GAYMBdXg==
X-Received: by 2002:a05:6402:2067:: with SMTP id bd7mr9550745edb.240.1637063086237;
        Tue, 16 Nov 2021 03:44:46 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id hv17sm8328203ejc.66.2021.11.16.03.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 03:44:45 -0800 (PST)
Message-ID: <ec96c45c-4715-c605-a5d1-edfa5b498639@redhat.com>
Date:   Tue, 16 Nov 2021 12:44:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 15/20] i2c: cht-wc: Make charger i2c-client
 instantiation board/device-model specific
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20211114170335.66994-1-hdegoede@redhat.com>
 <20211114170335.66994-16-hdegoede@redhat.com>
 <CAHp75VfYGmW6kO18BL39ippuzyzebNXuBn0PkEV8WScB2-bN6A@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfYGmW6kO18BL39ippuzyzebNXuBn0PkEV8WScB2-bN6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/16/21 12:20, Andy Shevchenko wrote:
> On Sun, Nov 14, 2021 at 7:04 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The i2c-controller on the Cherry Trail - Whiskey Cove PMIC is special
>> in that it is always connected to the I2C charger IC of the board on
>> which the PMIC is used; and the charger IC is not described in ACPI,
>> so the i2c-cht-wc code needs to instantiate an i2c-client for it itself.
>>
>> So far this was hardcoded to instantiate an i2c-client for the
>> bq24292i, with all properties, etc. set to match how this charger
>> is used on the GPD win and GPD pcoket devices.
> 
> "pocket" I believe?
> 
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
> 
> ...
> 
>> +/********** Lenovo Yogabook YB1-X90F/-X91F/-X91L charger settings **********/
>> +static const char * const lenovo_yb1_bq25892_suppliers[] = {
>> +       "cht_wcove_pwrsrc" };
> 
> Something went wrong with indentation...
> 
> ...
> 
>> +       /*
>> +        * The firmware sets everything to the defaults, which leads to a
>> +        * somewhat low charge-current of 2048mA and worse to a batter-voltage
> 
> battery?
> 
>> +        * of 4.2V instead of 4.35V (when booted without a charger connected).
>> +        * Use our own values instead of "linux,read-back-settings" to fix this.
>> +        */
> 
> ...

Ack to all of the above remarks.

> 
>> +       switch (intel_cht_wc_get_model()) {
>> +       case INTEL_CHT_WC_GPD_WIN_POCKET:
>> +               board_info = &gpd_win_board_info;
>> +               break;
>> +       case INTEL_CHT_WC_XIAOMI_MIPAD2:
>> +               board_info = &xiaomi_mipad2_board_info;
>> +               break;
>> +       case INTEL_CHT_WC_LENOVO_YOGABOOK1:
>> +               board_info = &lenovo_yogabook1_board_info;
>> +               break;
>> +       default:
>> +               dev_warn(&pdev->dev, "Unknown model, not instantiating charger device\n");
> 
> break;

Why ?  Having a default without a break at the end of a switch-case
is quite a normal thing to do.

> 
>> +       }
> 

Regards,

Hams

