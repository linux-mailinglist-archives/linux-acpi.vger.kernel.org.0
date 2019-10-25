Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E168E4677
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408135AbfJYI7M (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 04:59:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405717AbfJYI7M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Oct 2019 04:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571993950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEfAMrGGJdre6q5960sJV82kiqLRtWiqhggy8x2XByk=;
        b=ScivPiE21sJsFKGQ3A7tkw5Jo9Rm01WZXWqt4d9NSpUkPWSFf2gA2wOSmA4PI7bvZKAsv7
        KpB+E7sLDxlvkzN+QX3ltR7uNh3X86b7E1ZPulhFD37b1LUaQPamzSwVwBU3gFMXSG2o06
        +l3JqXbx+QVgWCGCdBruP9i659r9E3c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-p18YH2jfO_SyNyj4GKubxw-1; Fri, 25 Oct 2019 04:59:09 -0400
Received: by mail-wm1-f69.google.com with SMTP id o188so750916wmo.5
        for <linux-acpi@vger.kernel.org>; Fri, 25 Oct 2019 01:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rw+NkxbACn9hciv6WEMv7l0zZ0kLC27u/GkuGUvdJJs=;
        b=GaZeqmn78eihYlB8EQGCt2LAx6hHLZi+xBkqNbFiQSbyDm4guUeepKX7J7NJi1Uc4N
         l3/fZOW/SOUkNcZzEtQtn5Em9yB4eXn+efEf3cJiBAqfNT2fDyXUj+6dLHx5esnk72jk
         382IynzBLydELsYshxB5R0ZlM2z2GJYjb9mzyd3NMgUN5PgcSNF7YGF/t271H13NrGxh
         wDq94ZOOyMhFQ5qRWJalKuBoHHF8lb5eOJ296NvaS8Q2ImYRmc3hjMyucrSyRGASs5YG
         ls+JcX8G341SwizD3lFZLUHHeKf2a5XIPkqTlbyovsYmldwwWrFHH8sVMxbAzyed3+XQ
         X/ew==
X-Gm-Message-State: APjAAAVOz6Wdw+G8FIAOuataqJnNFuJJuyck2skgzV4wxGat7nDxgapY
        Xx7gee26YXcb5STuRUAnQIGqT7fcTfqCZHK1C7PNJqgLfHZ4Xe0eylJVY/2QZYn/EvzDLpZQGlq
        i5DHXNvOQoZfK1nS657l8fA==
X-Received: by 2002:adf:e805:: with SMTP id o5mr2008917wrm.223.1571993948471;
        Fri, 25 Oct 2019 01:59:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx2KbwzkROwYeADYLzyzJJATVkZ+ZEbGR5TPyEOXAq9XM/sAeNbXmJtO++ErjZ+kJbNgSDC5Q==
X-Received: by 2002:adf:e805:: with SMTP id o5mr2008895wrm.223.1571993948246;
        Fri, 25 Oct 2019 01:59:08 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id r2sm1837777wma.1.2019.10.25.01.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 01:59:07 -0700 (PDT)
Subject: Re: [PATCH 2/4] ACPI / PMIC: Add byt prefix to Crystal Cove PMIC
 OpRegion driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-3-hdegoede@redhat.com>
 <20191025074154.GX32742@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <49aa39b7-d457-1140-afdb-2a154278b29f@redhat.com>
Date:   Fri, 25 Oct 2019 10:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025074154.GX32742@smile.fi.intel.com>
Content-Language: en-US
X-MC-Unique: p18YH2jfO_SyNyj4GKubxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 25-10-2019 09:41, Andy Shevchenko wrote:
> On Thu, Oct 24, 2019 at 11:38:25PM +0200, Hans de Goede wrote:
>> Our current Crystal Cove OpRegion driver is only valid for the
>> Crystal Cove PMIC variant found on Bay Trail (BYT) boards,
>> Cherry Trail (CHT) based boards use another variant.
>>
>> At least the regulator registers are different on CHT and these register=
s
>> are one of the things controlled by the custom PMIC OpRegion.
>>
>> Commit 4d9ed62ab142 ("mfd: intel_soc_pmic: Export separate mfd-cell
>> configs for BYT and CHT") has disabled the intel_pmic_crc.c code for CHT
>> devices by removing the "crystal_cove_pmic" MFD cell on CHT devices.
>>
>> This commit renames the intel_pmic_crc.c driver and the cell to be
>> prefixed with "byt" to indicate that this code is for BYT devices only.
>>
>> This is a preparation patch for adding a separate PMIC OpRegion
>> driver for the CHT variant of the Crystal Cove PMIC (sometimes called
>> Crystal Cove Plus in Android kernel sources).
>=20
>>   .../acpi/pmic/{intel_pmic_crc.c =3D> intel_pmic_bytcrc.c}    | 4 ++--
>>   drivers/mfd/intel_soc_pmic_crc.c                           | 2 +-
>=20
> I would go with previously established pattern, i.e. intel_pmic_bytcc.c.

Well that would be consistent with the chtwc for the Whiskey Cove, but
Crystal Cove related files are shortened to crc in many places already:

Filenames before this patch:
drivers/acpi/pmic/intel_pmic_crc.c
drivers/pwm/pwm-crc.c
drivers/mfd/intel_soc_pmic_crc.c

And to me "cc" stands for the Type-C cc lines, or for Cc: from email,
so IMHO it is best to stick with crc here.

>> +++ b/drivers/mfd/intel_soc_pmic_crc.c
>> @@ -75,7 +75,7 @@ static struct mfd_cell crystal_cove_byt_dev[] =3D {
>>   =09=09.resources =3D gpio_resources,
>>   =09},
>>   =09{
>> -=09=09.name =3D "crystal_cove_pmic",
>> +=09=09.name =3D "byt_crystal_cove_pmic",
>>   =09},
>>   =09{
>>   =09=09.name =3D "crystal_cove_pwm",
>=20
> I'm wondering shouldn't we rename the PWM and GPIO for the sake of consis=
tency?
> Yes, if a driver is used on both CHT and BYT, let it provide two names.

I believe it is fine to keep the blocks which are identical between
the 2 versions as just "crystal_cove_foo", but renaming them is fine with m=
e
too, but that follows outside the scope of this series and should be
done in a follow-up series IMHO.

Regards,

Hans

