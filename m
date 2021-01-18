Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783492FA5B0
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406434AbhARQKk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 11:10:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406344AbhARQKd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 11:10:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610986145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MNZ/9b0H5mb1+bqSi5FpUvJFA2keS1nNwamitM6HMs=;
        b=ECBGnp6GbEcMYJncCymTxE3HGCiElTqZBS08GBdtnYCwkH9PACX+N9MZqbTZXxauo+KQjx
        hGLbcSKiyi99cTS39f+YQpv2Lo2lFcN/izbEakGV6kPmdBYl/d4GojsTglKMpRH9x1YY2y
        ILyxaIhlr7uMwCbol+j0BFDeleVeLDI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-L6HNFmo-MzCzrIwKN1Q9sQ-1; Mon, 18 Jan 2021 11:08:21 -0500
X-MC-Unique: L6HNFmo-MzCzrIwKN1Q9sQ-1
Received: by mail-ej1-f69.google.com with SMTP id b18so3331350ejz.6
        for <linux-acpi@vger.kernel.org>; Mon, 18 Jan 2021 08:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7MNZ/9b0H5mb1+bqSi5FpUvJFA2keS1nNwamitM6HMs=;
        b=gQozp8ykH++ke09msdpsuRFJ+jPXA7c3NaZ9blUs6YGQdC7nVwE+Lz2qwnSDwZ4fDg
         WzJ6N7yAPTl8S2yDSfiwnWA/MDiX8wL97h08f7CLB5z/Uzeu1gLu0SU69M+BiZ2wbKxh
         26C6MMCpTk8Pq1DtP98A6vogvoblBFosJ3antI6zzqX6AVFlHQptr3MDXeX7XRZYfAlf
         +LsBvYjV14L8w50lXaiw0RVEsciw+T9nFlcWIyX3IvdfDeB0WUfClIGKuFPUsM6MukNv
         t/biEKU6B8qnbFYgsFAe+2Sa1yWjeGzvsKcfoI4hfZBoVlnY5Nowut21Ka47v9TwuZBe
         Dnaw==
X-Gm-Message-State: AOAM531Pldcd5A5SZygQz7/kngrp9T8HVfvXeFcOjR5xVPBRl9tKsQQx
        7ncvNfM1zIVcn9AJZu+cYtgiJIajnBJ9yV+Y+aF3CyDhM3DARgRpNrO6ou1/xwIuQ4uRgLdsVKg
        0ftF7+EVlweaDfqEGmPpx0e+GYYAvlQ0b+GUjdyX/GmcTRZXvidgPuYql/vV1Mfua73+5qWEZ7g
        ==
X-Received: by 2002:a05:6402:1452:: with SMTP id d18mr142353edx.11.1610986099697;
        Mon, 18 Jan 2021 08:08:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAVXz+Suxjhgg7mubf2Hp3o0Kq8voO/aVOoK3HclEMlLPXP+Vt7liSkbbrqKkdYJBXeinmyw==
X-Received: by 2002:a05:6402:1452:: with SMTP id d18mr142331edx.11.1610986099450;
        Mon, 18 Jan 2021 08:08:19 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id j5sm11130992edl.42.2021.01.18.08.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:08:18 -0800 (PST)
Subject: Re: [PATCH] ACPI: scan: Make acpi_bus_get_device() clear the adev ptr
 on error
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20210115215752.389656-1-hdegoede@redhat.com>
 <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9e548c41-fdb0-4b4b-ccc3-81dba39d4904@redhat.com>
Date:   Mon, 18 Jan 2021 17:08:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gk0ninRntm508SAgzSrRe5gjZ+-e5ac1h-Cx2reVOSfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 1/18/21 2:58 PM, Rafael J. Wysocki wrote:
> On Fri, Jan 15, 2021 at 10:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Set the acpi_device pointer which acpi_bus_get_device()
>> returns-by-reference to NULL on error.
>>
>> We've recently had 2 cases where callers of acpi_bus_get_device()
>> did not properly error check the return value, using the
>> returned-by-reference acpi_device pointer blindly, set it to NULL
>> so that this will lead to an immediate oops, rather then following
>> a pointer to who knows what.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> This should fix the crash reported by Pierre-Louis,

Ack, sounds good.

> so let me apply it
> instead of the two debug changes posted by me
> (https://lore.kernel.org/linux-acpi/98e6ed8e-884e-adb4-a146-a66daefa94a7@redhat.com/T/#md5add2fe554a30e3a929d87a66b435f4cc8bf628).

Note we should still fix the USB case, my patch will make failure
there more obvious, but the code can theoretically still dereference
a NULL pointer in drivers/usb/core/usb-acpi.c.

And we probably also want this change:

--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -1867,7 +1867,8 @@ static u32 acpi_scan_check_dep(acpi_hand
 	 * 2. ACPI nodes describing USB ports.
 	 * Still, checking for _HID catches more then just these cases ...
 	 */
-	if (!acpi_has_method(handle, "_DEP") || !acpi_has_method(handle, "_HID"))
+	if (!acpi_has_method(handle, "_DEP") || acpi_has_method(handle, "_ADR")
+	    || !acpi_has_method(handle, "_HID"))
 		return 0;
 
 	status = acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices);

To reduce the amount of work we do checking _DEP-s.

If you want I can submit patches for both ?

Regards,

Hans




> 
> Pierre-Louis, can you please double check that the issue goes away
> with this patch applied?
> 
>> ---
>>  drivers/acpi/scan.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index c575c9b67f76..c53e88deee1d 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -585,6 +585,8 @@ static int acpi_get_device_data(acpi_handle handle, struct acpi_device **device,
>>         if (!device)
>>                 return -EINVAL;
>>
>> +       *device = NULL;
>> +
>>         status = acpi_get_data_full(handle, acpi_scan_drop_device,
>>                                     (void **)device, callback);
>>         if (ACPI_FAILURE(status) || !*device) {
>> --
>> 2.28.0
>>
> 

