Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8DFCFE9
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2019 21:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKNUxD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Nov 2019 15:53:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726592AbfKNUxD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Nov 2019 15:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573764783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CScKEe1TEY767P+hh/mCK7kRjgGxxA9Zrcr33WBLEPQ=;
        b=X5pKkUXoBcUR16nUfagXWAgCvxWaQHOWUIXqgO0sKo89ydE0Z4Waf+JOaVYD1PWIhhZaW2
        +Wp9KsRe/1fp4SM7iPJ4iVJ6mKUETF3t036EoBeEX2Dvh2y4YL2cQXqskhToSMmNkvbKdi
        NTOCjkh/0TTzcmZjApoAzC+b+HDfKJ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-0HwL-EQ3PD2RYmArFVyIew-1; Thu, 14 Nov 2019 15:52:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id f14so4251368wmc.0
        for <linux-acpi@vger.kernel.org>; Thu, 14 Nov 2019 12:52:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zu4Wi7fLQTena2bXHjoJvigeBbGnfq4Dz3SNG9FnYCY=;
        b=Nto4C9DxGGW9t5d12WtLJRPMJk0NUHFEWBijFEn8Qg8/nHdtYHfXYW+I1DIdjy25oj
         akFLVC7pPT8i48FTomZP5R4o3o5lkYQ0Xhlf/mGC3p3egFXOQhPUP7eE9A9/NiRkvT1I
         cR+abvubCVSHn1F8SBQ0Q6P4BR22aq0hjumdbwEKiOxTFRv11NYl4wVzOrIdZp033ZaZ
         pNXftDA6e5PrW7h0r0ETlQPqKEo7eKUWVHWXv9gPB1OvbnAirrMAqkrZ54kRHD10ync6
         CEAyoGQSleBZEyR+yGPzYRvIwuXem3WnHf0SZXt6oQjIqTsKoEs7Iw/sPZFx9fuwMEOo
         PgQQ==
X-Gm-Message-State: APjAAAV5g+OXcVRXKsgoJa57wAGEjsx0upFXZSHGTwS+LhJfdAP2EBv2
        60Y3x+TEWQHYF5lzDakY0zxuAd2DJitII25srfTsUQpBYW7/12NITRoRbTgQbueuCrh26z71xuG
        M0jw11lZiIUsv6oaGXnrRPw==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr9962905wmb.135.1573764778861;
        Thu, 14 Nov 2019 12:52:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqx5ZWI+0VoZ6geHdginsZ8+fU74exKPa7bNIYnkuQcNEhxBhyIDTDrO7B2k9aGS83rrC9rfew==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr9962880wmb.135.1573764778639;
        Thu, 14 Nov 2019 12:52:58 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id v81sm7897310wmg.4.2019.11.14.12.52.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2019 12:52:58 -0800 (PST)
Subject: Re: [PATCH v2] i2c: acpi: Force bus speed to 400KHz if a Silead
 touchscreen is present
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling 257 <youling257@gmail.com>
References: <20191113182938.279299-1-hdegoede@redhat.com>
 <20191114204815.GC7213@kunai>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c67a085b-8013-ef03-b5b2-431ea64ca97a@redhat.com>
Date:   Thu, 14 Nov 2019 21:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191114204815.GC7213@kunai>
Content-Language: en-US
X-MC-Unique: 0HwL-EQ3PD2RYmArFVyIew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 14-11-2019 21:48, Wolfram Sang wrote:
> On Wed, Nov 13, 2019 at 07:29:38PM +0100, Hans de Goede wrote:
>> Many cheap devices use Silead touchscreen controllers. Testing has shown
>> repeatedly that these touchscreen controllers work fine at 400KHz, but f=
or
>> unknown reasons do not work properly at 100KHz. This has been seen on
>> both ARM and x86 devices using totally different i2c controllers.
>>
>> On some devices the ACPI tables list another device at the same I2C-bus
>> as only being capable of 100KHz, testing has shown that these other
>> devices work fine at 400KHz (as can be expected of any recent I2C hw).
>>
>> This commit makes i2c_acpi_find_bus_speed() always return 400KHz if a
>> Silead touchscreen controller is present, fixing the touchscreen not
>> working on devices which ACPI tables' wrongly list another device on the
>> same bus as only being capable of 100KHz.
>>
>> Specifically this fixes the touchscreen on the Jumper EZpad 6 m4 not
>> working.
>>
>> Reported-and-tested-by: youling 257 <youling257@gmail.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Stable material, I'd say?

Yes adding this to stable would be good, thanks.

>=20
>> +=09=09=09dev_warn(dev, FW_BUG "DSDT wrongly sets I2C bus speed to %d, f=
orcing it to %d\n",
>> +=09=09=09=09 lookup.min_speed, lookup.force_speed);
>=20
> I have not a strong opinion here. However, does the DSDT really wrongly
> set a bus speed when it is the touchscreen controller which cannot
> handle lower speeds and other devies are specified to run at 100kHz?

Well it is configuring the bus at a speed where not all devices
can work, where as there is another speed where all devices do work.
With that said I'm open to a different wording for the warning. Feel
free to modify this before you add it to your tree.

I do wonder what Windows does here, changing the bus speed when going
from one device to another makes no sense since the non addressed device
still needs to be able to handle the address part of the transaction,
so the whole ACPI model where a speed is assigned to an i2c_client rather
then to the bus is weird here, anyways...

Regards,

Hans

