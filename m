Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B64102862
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfKSPpv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Nov 2019 10:45:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52016 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728380AbfKSPpu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Nov 2019 10:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574178349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbnCMkoiZ5CqdtFgMpOj6wQjaMdUNcc3dycuR9m661I=;
        b=aw74F2QU8Fbxycpb08+EI8gLt+qfq21ukgcnIkku4X2uLKQ8aTfmGnOrrgJBaQnL3mdjPT
        QItUR+JfYm7KARsYvTEsvDmuFTsDrIlJu6/gbmkhOYdZ0uGtS27O7Q8B8FeAUW28e0JbBL
        o5Kyrocjd9E+mDl1u6+hHS8ur4K3Zjg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-IOJVJAqIO36T3iXYuzXFCg-1; Tue, 19 Nov 2019 10:45:48 -0500
Received: by mail-wr1-f72.google.com with SMTP id q12so18591995wrr.3
        for <linux-acpi@vger.kernel.org>; Tue, 19 Nov 2019 07:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8JkyWkzJQJfiHNPGzrnQ6E/SLlDkUPPBDBGlK+/hvWw=;
        b=mY2SIH4NcGzQpoy+uks+7fuPJufHrbU6hRFK4ZtoH8/l3MLJyiy6Bk82X4l5t7ztcY
         eB6f93Dne4xzqiKItsAa/1Ep8KONkyhaPIR0QEtFl3iAxKPcJy4BJsQvgjBFx2602JVe
         TA9TAuezQlizbV+EfJRQuPjnh0w1trYCT7YKy+0RC+g+z9YXKljinXEBD3gqv4oXWpsJ
         gzIcsOeA4tSyyiOlS2pphxJrpAjtrzbT1ZTXu7uwfVj/iVx05bfwF0FpAzzSDe3i238S
         WO/hFDADiu9nj4mkxbygAl3fkUbep+90K+r9E/uR8qrjN+NxT5xmyNxU6Kh3/aAXuXrV
         KaMA==
X-Gm-Message-State: APjAAAXTkgSEPB3ogCY7ffCTNA4rMiewjP1XOqEIfIxePHAa78MVOS81
        0SY7+sIsqpwUwGmIkC9vWmAr7+DvPL4oS9mYLb6SW3zyypgJGmhFZLJEYmTxYFQYgQPnP7jjsj8
        CD53TKxaiM8KrT2HCFBk4Mg==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr6254296wmb.135.1574178346659;
        Tue, 19 Nov 2019 07:45:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqxb+yB42mXYCP/zBNiwRYM+7CZhIJ1zCuaeamCMBkXL7xRhB6O+9M4r+8sJAX1quQMM5dQOXw==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr6254268wmb.135.1574178346422;
        Tue, 19 Nov 2019 07:45:46 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id 5sm3327537wmk.48.2019.11.19.07.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 07:45:45 -0800 (PST)
Subject: Re: [PATCH] pinctrl: baytrail: Really serialize all register accesses
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        stable@vger.kernel.org
References: <20191118142020.22256-1-hdegoede@redhat.com>
 <20191118142020.22256-2-hdegoede@redhat.com>
 <20191119081909.GE11621@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b5ac836b-a805-aae9-24ff-42913b3a585e@redhat.com>
Date:   Tue, 19 Nov 2019 16:45:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191119081909.GE11621@lahna.fi.intel.com>
Content-Language: en-US
X-MC-Unique: IOJVJAqIO36T3iXYuzXFCg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 19-11-2019 09:19, Mika Westerberg wrote:
> On Mon, Nov 18, 2019 at 03:20:20PM +0100, Hans de Goede wrote:
>> Commit 39ce8150a079 ("pinctrl: baytrail: Serialize all register access")
>> added a spinlock around all register accesses because:
>>
>> "There is a hardware issue in Intel Baytrail where concurrent GPIO regis=
ter
>>   access might result reads of 0xffffffff and writes might get dropped
>>   completely."
>>
>> Testing has shown that this does not catch all cases, there are still
>> 2 problems remaining
>>
>> 1) The original fix uses a spinlock per byt_gpio device / struct,
>> additional testing has shown that this is not sufficient concurent
>> accesses to 2 different GPIO banks also suffer from the same problem.
>>
>> This commit fixes this by moving to a single global lock.
>>
>> 2) The original fix did not add a lock around the register accesses in
>> the suspend/resume handling.
>>
>> Since pinctrl-baytrail.c is using normal suspend/resume handlers,
>> interrupts are still enabled during suspend/resume handling. Nothing
>> should be using the GPIOs when they are being taken down, _but_ the
>> GPIOs themselves may still cause interrupts, which are likely to
>> use (read) the triggering GPIO. So we need to protect against
>> concurrent GPIO register accesses in the suspend/resume handlers too.
>>
>> This commit fixes this by adding the missing spin_lock / unlock calls.
>>
>> The 2 fixes together fix the Acer Switch 10 SW5-012 getting completely
>> confused after a suspend resume. The DSDT for this device has a bug
>> in its _LID method which reprograms the home and power button trigger-
>> flags requesting both high and low _level_ interrupts so the IRQs for
>> these 2 GPIOs continuously fire. This combined with the saving of
>> registers during suspend, triggers concurrent GPIO register accesses
>> resulting in saving 0xffffffff as pconf0 value during suspend and then
>> when restoring this on resume the pinmux settings get all messed up,
>> resulting in various I2C busses being stuck, the wifi no longer working
>> and often the tablet simply not coming out of suspend at all.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 39ce8150a079 ("pinctrl: baytrail: Serialize all register access")
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pinctrl/intel/pinctrl-baytrail.c | 81 +++++++++++++-----------
>>   1 file changed, 44 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/=
intel/pinctrl-baytrail.c
>> index b18336d42252..1b289f64c3a2 100644
>> --- a/drivers/pinctrl/intel/pinctrl-baytrail.c
>> +++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
>> @@ -111,7 +111,6 @@ struct byt_gpio {
>>   =09struct platform_device *pdev;
>>   =09struct pinctrl_dev *pctl_dev;
>>   =09struct pinctrl_desc pctl_desc;
>> -=09raw_spinlock_t lock;
>>   =09const struct intel_pinctrl_soc_data *soc_data;
>>   =09struct intel_community *communities_copy;
>>   =09struct byt_gpio_pin_context *saved_context;
>> @@ -550,6 +549,8 @@ static const struct intel_pinctrl_soc_data *byt_soc_=
data[] =3D {
>>   =09NULL
>>   };
>>  =20
>> +static DEFINE_RAW_SPINLOCK(byt_gpio_lock);
>=20
> Can we call it byt_lock instead? Following same convention we use in
> chv.

Ok, v2 with this changed coming up.

> Other than that looks good and definitely right thing to do. Thanks for
> doing this Hans!

You are welcome. I must say that this was an interesting adventure :)
The interrupt storm issue on the Acer SW5-012 really managed to hit this bu=
g
very reliably, resulting in all sorts of fun due to the pinmux settings
getting messed up.

Regards,

Hans

