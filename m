Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6FB34F131
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhC3SrI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 14:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232833AbhC3Sq7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Mar 2021 14:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617130018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dd+NH6XoCe8f6Y3SHS+9Svib5nLjFTSlcTDbRi+JJAc=;
        b=W7iULPqN5YueOkNZDtWLCv4Ekinynl0ik1+w3vC7XvHDgsK97Vhr4rcLPpYU70Rli1kMSh
        mXQR81gn8cfj6vEKhumnEAXSAClfQRlDS5q3KoODuArQqmi+ulVA4XBMzAyYalGhpg1cDF
        //A7Uj+omQ7CUYguvwxkUSSDa7tM2bA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-kSNHCAfiOTmoVNfesZgiRA-1; Tue, 30 Mar 2021 14:46:57 -0400
X-MC-Unique: kSNHCAfiOTmoVNfesZgiRA-1
Received: by mail-ej1-f71.google.com with SMTP id h14so7548806ejg.7
        for <linux-acpi@vger.kernel.org>; Tue, 30 Mar 2021 11:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dd+NH6XoCe8f6Y3SHS+9Svib5nLjFTSlcTDbRi+JJAc=;
        b=lHFjyVjV7vUfk/HQsKJS5NLrv5brSKjWKvRk9tu14Wz5eD19TAES5IQxCNa8FpMh98
         r3QIvZHNPL3jWZN8Il58sOP69DTsyI0o8X2Uhzy+wjSJjIYl1HfZkNqFzpG2jSzcWbgp
         SxBHcmFy57P4mTU9v5QuwcYklVK6GyjmkbYC6WLp9hlMr8Hw0oZhQ2osNAlSmytWNz4S
         3MoMXchxIcyZJ8gFo+9QlEOv/dOCNfn7NnJDynyNSA0kno8wi0gXDOJFT5+dvP4t7dOZ
         BMgBDk5YktxsxtW5lLZTihB+3ImrLDcCpwdmeDhuWcvBzxl5JtTyCVE6q+RKDrVnqOa/
         YnEw==
X-Gm-Message-State: AOAM530m2JeD1fWs0T95EnYeQ9XWhWOCtWdYLGs5chlXYWpM553QdCSG
        u2cfKYVuetZzOugSe8Ep9iksZ1JumHQnX+UCuqQvC05XQSbhFQmnG88A+w6BAzX+P/LPNoRMH0h
        wsJAHLMaVtiVw5bku+gHuHk7RL/16wurt0W4pWNr07hr7I/go+SrqpG+41c0pDBXYshBJ6ZiZgw
        ==
X-Received: by 2002:a17:906:3e89:: with SMTP id a9mr33446053ejj.405.1617130012746;
        Tue, 30 Mar 2021 11:46:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqvXkz37G+wsDT1sitTTMxpjxlbuDnbFrDsc9GhwCLTjXtJI4lf58Lvt9hmQ3+6DQr8tt02A==
X-Received: by 2002:a17:906:3e89:: with SMTP id a9mr33446036ejj.405.1617130012505;
        Tue, 30 Mar 2021 11:46:52 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id r25sm11899609edv.78.2021.03.30.11.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 11:46:52 -0700 (PDT)
Subject: Re: [PATCH v2] ACPI: scan: Fix _STA getting called on devices with
 unmet dependencies
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org
References: <20210329154649.16056-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <5d87fe5b-c88f-e774-f60b-9cb3752092f6@redhat.com>
Date:   Tue, 30 Mar 2021 20:46:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210329154649.16056-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 3/29/21 5:46 PM, Hans de Goede wrote:
> Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
> _DEP lists") dropped the following 2 lines from acpi_init_device_object():
> 
> 	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
> 	device->dep_unmet = 1;
> 
> Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
> causes the acpi_bus_get_status() call in acpi_add_single_object() to
> actually call _STA, even though there maybe unmet deps, leading to errors
> like these:
> 
> [    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
>                [GenericSerialBus] (20170831/evregion-166)
> [    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
>                (20170831/exfldio-299)
> [    0.123618] ACPI Error: Method parse/execution failed
>                \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)
> 
> Fix this by re-adding the dep_unmet = 1 initialization to
> acpi_init_device_object() and modifying acpi_bus_check_add() to make sure
> that dep_unmet always gets setup there, overriding the initial 1 value.
> 
> This re-fixes the issue initially fixed by
> commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to initialize
> ACPI_TYPE_DEVICE devs"), which introduced the removed
> "device->dep_unmet = 1;" statement.
> 
> This issue was noticed; and the fix tested on a Dell Venue 10 Pro 5055.
> 
> Fixes: 71da201f38df ("ACPI: scan: Defer enumeration of devices with _DEP lists")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Self-nack, sorry, I know you already merged this, but I hope you can still replace
it, as this is broken. It causes dep_unmet to never reach 0 for devices with deps
because it is missing this:

--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1910,6 +1910,8 @@ static void acpi_scan_dep_init(struct acpi_device *adev)
 {
 	struct acpi_dep_data *dep;
 
+	adev->dep_unmet = 0;
+
 	mutex_lock(&acpi_dep_list_lock);
 
 	list_for_each_entry(dep, &acpi_dep_list, node) {

So now acpi_scan_dep_init() starts with 1 dep and then adds the actual
number of deps on top.

I'll send a v3 fixing this as soon as I've tested it.

(I should have noticed the battery reporting was gone with v2, but
I only checked that the errors were gone from dmesg...)

Let me know if you want a follow-up patch fixing this instead.

Regards,

Hans







> ---
>  drivers/acpi/scan.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1584c9e463bd..aca4edc8fe6b 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1647,6 +1647,8 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
>  	device_initialize(&device->dev);
>  	dev_set_uevent_suppress(&device->dev, true);
>  	acpi_init_coherency(device);
> +	/* Assume there are unmet deps to start with. */
> +	device->dep_unmet = 1;
>  }
>  
>  void acpi_device_add_finalize(struct acpi_device *device)
> @@ -1957,7 +1959,13 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, bool check_dep,
>  		return AE_CTRL_DEPTH;
>  
>  	acpi_scan_init_hotplug(device);
> -	if (!check_dep)
> +	/*
> +	 * If check_dep is true at this point, the device has no dependencies,
> +	 * or the creation of the device object would have been postponed above.
> +	 */
> +	if (check_dep)
> +		device->dep_unmet = 0;
> +	else
>  		acpi_scan_dep_init(device);
>  
>  out:
> 

