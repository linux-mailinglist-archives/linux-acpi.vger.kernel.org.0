Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB43D9FCA
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jul 2021 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhG2IpB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jul 2021 04:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234949AbhG2IpB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Jul 2021 04:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627548298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5r328cWz2cgQ4yqfVV8Q/57dzR+cdbYLWjoOK8d95Xw=;
        b=fprm2DcScjR3kUqvyjRxh3LtKp3R1XzD67RNFmgmY4Q9Zww/8exOGALl6ZmuJpLr1P/P/x
        55yZ4ZyS8RUdKQ4ftYMU4gpC0+t6DjtBQZCRgqxo900QDx0r5WRE1awA8FXv49KXwMYO4x
        4e27ttZJTiPaZ7+4Zdg3RNTzubf3Akc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-qZ1Bd23TNE-RS1chl7gVwg-1; Thu, 29 Jul 2021 04:44:56 -0400
X-MC-Unique: qZ1Bd23TNE-RS1chl7gVwg-1
Received: by mail-ed1-f70.google.com with SMTP id l10-20020aa7caca0000b02903b874f26036so2580256edt.20
        for <linux-acpi@vger.kernel.org>; Thu, 29 Jul 2021 01:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5r328cWz2cgQ4yqfVV8Q/57dzR+cdbYLWjoOK8d95Xw=;
        b=TcXw/6S7GMSxAulz2klnFOP68zEdZIYCCvh12rFvw4b9yuLl4GxfL1h7GMf9+6GsOc
         fAweC7Q1w21PLLTl3SkomNvLuonH3ye6K/Eftbr9pgLgsQ6/4ER2IlRxjCFAUw0O2TXe
         yWPa9hxvYd8WMlxgHxFShSlUzeI7Jep90E5GNn3mrdvxSw8Ib5hbjjdMniWdLJtgyICz
         hhCL6EcSx5+NPFCKxSVOhkSsAR+vNU8fXncB2GzS7K8S2V+bjARL71Pq7igNRD1rBQ9f
         uR1lqTm2DzUWMOoTV4SUU+CKrLycpu7GxdF5KBjQ6OCGsr52j1MtSbLcQRiwTOU93k6o
         3b8A==
X-Gm-Message-State: AOAM531Yi4abWK2T86oBD+qDLRkawaiQyeq9mU46oBbBoKV+si2vgOSC
        7l0e9iPbQ7JvOfWkGY7qH4sJmaIi/mArMCP40Eokj4vl+H+wyZWAdyTefErm87OR8PYecRMb4At
        l7DnI9okCMMU3VsKkvOBscA==
X-Received: by 2002:a17:906:c013:: with SMTP id e19mr3603128ejz.389.1627548295647;
        Thu, 29 Jul 2021 01:44:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzevJ6+rCuc7gLI5eij4Ytdva/IZszYx0skO6mSfEHi66+rH8Nijeh0cNoU6OwF7TDdWtDJPA==
X-Received: by 2002:a17:906:c013:: with SMTP id e19mr3603111ejz.389.1627548295443;
        Thu, 29 Jul 2021 01:44:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a22sm733039ejk.35.2021.07.29.01.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 01:44:55 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add and use a dual_accel_detect() helper
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Pearson <markpearson@lenovo.com>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Julius Lehmann <julius@devpi.de>
References: <20210729082134.6683-1-hdegoede@redhat.com>
 <CAHp75VepyNqwLSDaDmc+XCk+_gC5+zGUQ51DOo7KUt2-Gaty-Q@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7e6402dd-ec83-5014-8165-95e45cd3169f@redhat.com>
Date:   Thu, 29 Jul 2021 10:44:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VepyNqwLSDaDmc+XCk+_gC5+zGUQ51DOo7KUt2-Gaty-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/29/21 10:37 AM, Andy Shevchenko wrote:
> On Thu, Jul 29, 2021 at 11:21 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Various 360 degree hinges (yoga) style 2-in-1 devices use 2 accelerometers
>> to allow the OS to determine the angle between the display and the base of
>> the device.
>>
>> On Windows these are read by a special HingeAngleService process which
>> calls undocumented ACPI methods, to let the firmware know if the 2-in-1 is
>> in tablet- or laptop-mode. The firmware may use this to disable the kbd and
>> touchpad to avoid spurious input in tablet-mode as well as to report
>> SW_TABLET_MODE info to the OS.
>>
>> Since Linux does not call these undocumented methods, the SW_TABLET_MODE
>> info reported by various pdx86 drivers is incorrect on these devices.
>>
>> Before this commit the intel-hid and thinkpad_acpi code already had 2
>> hardcoded checks for ACPI hardware-ids of dual-accel sensors to avoid
>> reporting broken info.
>>
>> And now we also have a bug-report about the same problem in the intel-vbtn
>> code. Since there are at least 3 different ACPI hardware-ids in play, add
>> a new dual_accel_detect() helper which checks for all 3, rather then
>> adding different hardware-ids to the drivers as bug-reports trickle in.
>> Having shared code which checks all known hardware-ids is esp. important
>> for the intel-hid and intel-vbtn drivers as these are generic drivers
>> which are used on a lot of devices.
>>
>> The BOSC0200 hardware-id requires special handling, because often it is
>> used for a single-accelerometer setup. Only in a few cases it refers to
>> a dual-accel setup, in which case there will be 2 I2cSerialBus resources
>> in the device's resource-list, so the helper checks for this.
> 
> ...
> 
>> +static int dual_accel_i2c_resource_count(struct acpi_resource *ares, void *data)
>> +{
>> +       struct acpi_resource_i2c_serialbus *sb;
>> +       int *count = data;
>> +
>> +       if (i2c_acpi_get_i2c_resource(ares, &sb))
>> +               *count = *count + 1;
>> +
>> +       return 1;
>> +}
> 
> It will be a third copy of this in the kernel.
> Let's put it to i2c.h or somewhere available for all these users.
> 
>> +
>> +static int dual_accel_i2c_client_count(struct acpi_device *adev)
>> +{
>> +       int ret, count = 0;
>> +       LIST_HEAD(r);
>> +
>> +       ret = acpi_dev_get_resources(adev, &r, dual_accel_i2c_resource_count, &count);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       acpi_dev_free_resource_list(&r);
>> +       return count;
>> +}
> 
> So does this.
> 
> Taking into account that this is a bug fix, I'm okay if you do above
> as an additional patch (or patches) on top of this.

Right, I had a note about this behind the cut (---) line, but I dropped
the patch and git-am-ed it while reworking my tree for some other issue
dropping the note (sorry), the note was:

"""
---
Note the counting of the number of I2cSerialBus resources in an
ACPI-device's resource-list is becoming a common pattern. I plan
to add a new shared helper for this in a follow-up patch-set.
I've deliberately not made use of such a new helper in this patch
for easier backporting to the stable series.
"""

In other words, I fully agree. I've already added an item to my
TODO list about doing a followup series to replace the 3 copies in:

 drivers/platform/x86/dual_accel_detect.h
 drivers/platform/x86/i2c-multi-instantiate.c
 drivers/platform/x86/intel/int33fe/intel_cht_int33fe_common.c

With a new helper in drivers/i2c/i2c-core-acpi.c, like the
i2c_acpi_get_i2c_resource() helper which was recently added.

Regards,

Hans

