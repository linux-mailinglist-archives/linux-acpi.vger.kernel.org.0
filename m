Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A4F72D9
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2019 12:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfKKLNr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Nov 2019 06:13:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726843AbfKKLNr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Nov 2019 06:13:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573470826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v43gOt+Ld22Ntu2zxfIp5/xCGraGSgFRChV+dHYHki4=;
        b=ONF+csgHqn7ZLqAt34hcROyyNWld6O3k6H1XxtQy+7/WPw0Cdifob4MULyorbpdHr2e1wk
        Gs4IIJyd1zIiJvKcBkYxO1c5UNrV0cVPH40BjaMrPlJzer3ZBMIc9wSIqUdEvcAYkxBR3m
        xoQsF6iIM/ciWKv/DvjESg/ypGPMtTI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-AaBsoNqmN_yXaQxnhqJGCA-1; Mon, 11 Nov 2019 06:13:45 -0500
Received: by mail-wm1-f69.google.com with SMTP id f16so6646209wmb.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Nov 2019 03:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bwjhg5HlbRjy6MbaUFOaFFWoL/yYXcbP/BYRsChJNjM=;
        b=QI+H/LwQ/vnOKxW3GknKmuuNnVH9V77rcOiwsWFLLLDjXVE4/rwbTbwdZXLyriLUg9
         Y0EAf1553so42M0tIhFEMoRW/VjVDUUdRCsGCfRG2uJ4YflFbD9/jMS+vGkp7+GTn/GA
         TtpomEpbLf4ExZaK4eFMgUUcKXGTNcstgCevApsvLKCfHaXDIkx5zzDtcKRQpVhC7TNw
         fYWNpYri3qHJKzZinyCZlzRbgSa6JrIxguCprYjQIWINhfVh9SYZY1geHfl5BQAzqlJ/
         6zjXcr8pv+WZCGbUBQPB8Ot/lKcjdqluVWfzBtwHWMjZf6n3mLvbs6hV+bcQjIiO08j3
         ulWA==
X-Gm-Message-State: APjAAAVLkG1koTozfaEqPMt+T8oL878+4s8N6O0F66jTJtzGuMib5JXb
        hzgJCHjOQIP/fzeudSPTOVPEy3IHB6fbO4miWdfJavrj+Ih6TycWO8GpbuxANsl3WZHgmIVhHoV
        XacVlOixbzY2D5bmZ+On/lw==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr20891603wme.77.1573470823560;
        Mon, 11 Nov 2019 03:13:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPEZum+Z5KctoSEQOBPpq0h5TWph3D/irBX6rOuwvqYY9UWmvOGBrQi5hmFK5rrE2lCghqGA==
X-Received: by 2002:a1c:9e58:: with SMTP id h85mr20891584wme.77.1573470823309;
        Mon, 11 Nov 2019 03:13:43 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b3sm14424223wmj.44.2019.11.11.03.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 03:13:42 -0800 (PST)
Subject: Re: [PATCH] i2c: acpi: Force bus speed to 400KHz if a Silead
 touchscreen is present
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, youling 257 <youling257@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
References: <20191111104827.3713-1-hdegoede@redhat.com>
 <20191111110653.GG2552@lahna.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ea07da81-5458-22f6-7bd3-ee86300bfaef@redhat.com>
Date:   Mon, 11 Nov 2019 12:13:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191111110653.GG2552@lahna.fi.intel.com>
Content-Language: en-US
X-MC-Unique: AaBsoNqmN_yXaQxnhqJGCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

Thank you for the quick reply.

On 11-11-2019 12:06, Mika Westerberg wrote:
> +Jarkko
>=20
> On Mon, Nov 11, 2019 at 11:48:27AM +0100, Hans de Goede wrote:
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
>> ---
>>   drivers/i2c/i2c-core-acpi.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
>> index 9cb2aa1e20ef..420c356eba06 100644
>> --- a/drivers/i2c/i2c-core-acpi.c
>> +++ b/drivers/i2c/i2c-core-acpi.c
>> @@ -39,6 +39,7 @@ struct i2c_acpi_lookup {
>>   =09int index;
>>   =09u32 speed;
>>   =09u32 min_speed;
>> +=09u32 force_speed;
>>   };
>>  =20
>>   /**
>> @@ -285,6 +286,19 @@ i2c_acpi_match_device(const struct acpi_device_id *=
matches,
>>   =09return acpi_match_device(matches, &client->dev);
>>   }
>>  =20
>> +static const struct acpi_device_id i2c_acpi_force_400khz_device_ids[] =
=3D {
>> +=09/*
>> +=09 * These Silead touchscreen controllers only work at 400KHz, for
>> +=09 * some reason they do not work at 100KHz. On some devices the ACPI
>> +=09 * tables list another device at their bus as only being capable
>> +=09 * of 100KHz, testing has shown that these other devices work fine
>> +=09 * at 400KHz (as can be expected of any recent i2c hw) so we force
>> +=09 * the speed of the bus to 400 KHz if a Silead device is present.
>> +=09 */
>> +=09{ "MSSL1680", 0 },
>> +=09{}
>> +};
>> +
>>   static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level=
,
>>   =09=09=09=09=09   void *data, void **return_value)
>>   {
>> @@ -303,6 +317,9 @@ static acpi_status i2c_acpi_lookup_speed(acpi_handle=
 handle, u32 level,
>>   =09if (lookup->speed <=3D lookup->min_speed)
>>   =09=09lookup->min_speed =3D lookup->speed;
>>  =20
>> +=09if (acpi_match_device_ids(adev, i2c_acpi_force_400khz_device_ids) =
=3D=3D 0)
>> +=09=09lookup->force_speed =3D 400000;
>=20
> I wonder if it makes sense to log a warning about this? So when
> debugging it can be clearly seen from the logs that the device is
> quirked.

Yes and no, yes a warning is a good idea, but not here, since there are a
ton of devices with a Silead touchscreen and only few have this problem.

>=20
>> +
>>   =09return AE_OK;
>>   }
>>  =20
>> @@ -340,7 +357,12 @@ u32 i2c_acpi_find_bus_speed(struct device *dev)
>>   =09=09return 0;
>>   =09}
>>  =20
>> -=09return lookup.min_speed !=3D UINT_MAX ? lookup.min_speed : 0;
>> +=09if (lookup.force_speed) {

So the warning should go here then, like this:

=09if (lookup.force_speed > lookup.min_speed)
=09=09pr_warn(FW_BUG "Some decent text Hans has to come-up with");


I'll wait a bit for other remarks before posting a v2 with this added.

Regards,

Hans


>> +=09=09return lookup.force_speed;
>> +=09} else if (lookup.min_speed !=3D UINT_MAX)
>> +=09=09return lookup.min_speed;
>> +=09else
>> +=09=09return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(i2c_acpi_find_bus_speed);
>>  =20
>> --=20
>> 2.23.0
>=20

