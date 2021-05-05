Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F032C373C82
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbhEENke (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 09:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhEENkc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2021 09:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620221976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l67yQ7D23SoSqMpof5Io0EzBPNMG7CN0TM51l9dKdKw=;
        b=UWG9gRZ5dsycaSNZecanQoX6G7nJ/lfrCM7x+/G+8YXbYFJ4JhAN5J1dLsqdeikST5eE7Y
        5rQx/8TuwhQpP4ZT/3mhz+BGvGza4FfVwLJztJYIg+HuoLt2nz/mc21MfN5YNpGr+Vnx6Q
        XSDAR52MrJ3iG7J52E9AlQkYnFcOF/k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-WVP8eNXhPZqYxjBUIdkB4A-1; Wed, 05 May 2021 09:39:34 -0400
X-MC-Unique: WVP8eNXhPZqYxjBUIdkB4A-1
Received: by mail-ed1-f69.google.com with SMTP id f8-20020a0564020688b029038840895df2so856434edy.17
        for <linux-acpi@vger.kernel.org>; Wed, 05 May 2021 06:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l67yQ7D23SoSqMpof5Io0EzBPNMG7CN0TM51l9dKdKw=;
        b=gu1JLE0qstBykTksCQgBi6my+3rLqI2ehBNYUdSChqVV4bQalLqFDlsc9y/8mI5J81
         fbjrw4gFxR5EIl+MPXjrRi/IdN9xL83zdUMJ6oDyoUcTN3+znqjoYPbAaZo/gqOziQvq
         +chqwV9J3CsQALuCsBr3hEB1YCxcJvTF6bx8fmEScqsVvUkIhqbhiSQsmMNVsfdLIIxV
         lHDTtI+6vyjDGVH8yEPzOUrRSMHhz0p1q68J8M6SL1s3RylUxqEX2552ShQEXTVKPuGL
         h5i1uZY0uw+Kaeo5aAhd1RLGLiuPgU7T02GfxUH0PLChiwQJodq59NnSXiWujjBL4cms
         qbrg==
X-Gm-Message-State: AOAM531lHRjG5mtzAHn1/Ho7eWZPHM2UERfpkphT6POXXAW4xHu0HQqq
        mUMXhCv3CCvj7nRU8kEJWIrmSHI2phUoSvXXIPRO88liK6ZZ3JjN2I8+kw4EWTHbk3CdWjCu5tR
        UgmIW/gvTfHHxpxFkk7VXrQ==
X-Received: by 2002:a50:bec7:: with SMTP id e7mr33233373edk.295.1620221973370;
        Wed, 05 May 2021 06:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza4Gm7FbthDUjnhtahmmub3WsS4zK9H+kOAAsWWRTmilZmKb9FNNOykdNDGbvRTUWit8TM8Q==
X-Received: by 2002:a50:bec7:: with SMTP id e7mr33233356edk.295.1620221973202;
        Wed, 05 May 2021 06:39:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i19sm2888888ejd.114.2021.05.05.06.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 06:39:32 -0700 (PDT)
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210504174019.2134652-1-linux@roeck-us.net>
 <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
 <20210505093235.00007c38@Huawei.com> <20210505093438.00005238@Huawei.com>
 <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com>
Date:   Wed, 5 May 2021 15:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/5/21 3:22 PM, Andy Shevchenko wrote:
> On Wed, May 5, 2021 at 11:36 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> On Wed, 5 May 2021 09:32:35 +0100
>> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>>> On Tue, 4 May 2021 11:00:52 -0700
>>> Guenter Roeck <linux@roeck-us.net> wrote:
> 
> +Cc: Paul (I hope you are related to coreboot somehow and can
> communicate this further), Pavel and Jacek (LED subsystem suffered
> with this as well), Hans, Rafael and linux-acpi@
> 
>>> Dropping the ones we are fairly sure are spurious is even better!
>>
>> If I get bored I'll just do a scrub of all the instances of this that
>> you haven't already cleaned up.  It's worth noting that we do
>> know some highly suspicious looking entries are out there in the wild.
> 
> I have counted ~60 users of acpi_device_id in IIO. Brief looking at
> the IDs themselves rings an alarm about half of them.
> 
> So, here we may have a chicken and egg problem, i.e. somebody has been
> using (or used) fake IDs from Linux kernel in the real products. What
> I can consider as a course of action is the following:
> 1. Clean up (by removing as quickly as possible) the IDs that have no
> proof to be real from the Linux kernel sources (perhaps marked as
> stable material)
> 2. Notify ASWG / UEFI forum about all IDs that abuse ACPI
> specification and are in Linux kernel, so at least we can keep some
> kind of "reserved/do not use" list on the official level (Rafael?)
> 3. Do not accept any IDs without an evidence provided that they are
> being in use in the real products (this should be done on Linux
> maintainer level in all subsystems that accept drivers

So my 2 cents on this are that we need to be very careful with
removing "bogus" ACPI-ids.

A couple of examples from a quick check under drivers/iio/accel:

drivers/iio/accel/bmc150-accel-i2c.c:

static const struct i2c_device_id bmc150_accel_id[] = {
        {"bmc150_accel",        bmc150},
        {"bmi055_accel",        bmi055},
        {"bma255",              bma255},
        {"bma250e",             bma250e},
        {"bma222",              bma222},
        {"bma222e",             bma222e},
        {"bma280",              bma280},
        {}
};

static const struct acpi_device_id bmc150_accel_acpi_match[] = {
        {"BSBA0150",    bmc150},
        {"BMC150A",     bmc150},
        {"BMI055A",     bmi055},
        {"BMA0255",     bma255},
        {"BMA250E",     bma250e},
        {"BMA222",      bma222},
        {"BMA222E",     bma222e},
        {"BMA0280",     bma280},
        {"BOSC0200"},
        { },
};

With the exception of the  "BSBA0150" and "BOSC0200"
ids, these look like they were invented. But at least the
"BMA250E" one is actually being used! The other BMA###?
ones are probably fake, but given that the "BMA250E"
one is actually real ...

drivers/iio/accel/bmc150-accel-spi.c

This uses the same set of ACPI ids as bmc150-accel-i2c.c
minus the "BOSC0200" one. I'm not aware if these
being used in spi mode on any x86 devices, but again
I'm not 100% sure ...

drivers/iio/accel/da280.c

static const struct acpi_device_id da280_acpi_match[] = {
        {"MIRAACC", da280},
        {},
};
MODULE_DEVICE_TABLE(acpi, da280_acpi_match);

This looks like a fake-id, but it was actually added
in a separate commit adding ACPI support because the
chip is used with this id on a Linx 820 Windows tablet.

So figuring out of any ids are real or not is really tricky
and removing them if they are real will lead to regressions.

So summarizing IMHO we need to be careful and not just
start removing a whole bunch of these...

Regards,

Hans

