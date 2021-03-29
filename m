Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF6E34D2A5
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Mar 2021 16:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhC2OqG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 29 Mar 2021 10:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230167AbhC2OqD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 29 Mar 2021 10:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617029162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmNGUFVGIo44dijjxdXX/7F9eCoyf+ySAc7BS3yv4kA=;
        b=IQs/kkToQGIpMjX5hbFZ/RHLbXrvQliuY2YPvbt7nD1dyF95Y10WPCvEvQTpMyI30mLnhw
        Mynhz2KPt4r8EDcfmV+mfLnf3Xwa3zYri3D9UP3aYFeLYJs2tHylXw1+s0cq0HBA5y3q7L
        4y3XpQhg6gOXP7q4W25mkc6Xu0awqI0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-4XVMHMF3PSi9DZ2UCIEsEA-1; Mon, 29 Mar 2021 10:46:01 -0400
X-MC-Unique: 4XVMHMF3PSi9DZ2UCIEsEA-1
Received: by mail-ej1-f71.google.com with SMTP id v27so5891956ejq.0
        for <linux-acpi@vger.kernel.org>; Mon, 29 Mar 2021 07:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hmNGUFVGIo44dijjxdXX/7F9eCoyf+ySAc7BS3yv4kA=;
        b=fz13kZHFA+FTZLxdIbfyc4uCY8jkqDZHTwrx44Kp6xWZbl/nzvMM/2uWqIuOSOTaZs
         H+TFjLYBUkbgtzy4M1rC3B38+b3dI5QxitxPdzKUHCp/VEq2Aow92kr4YWdQD5Vn7Swx
         4ao6nPfPqgW7cfhupB4m6HST68MDxYjxi2N2zFZ+/N7W0mQQqb6N9OAuN5urgOCCl515
         6YCysiZAWoR3siG7T40DP3fBKOphpj8n1qMLIzSPmyGc/fiLgSMeR6FKqwgu3lx+H3Ln
         sNoDhLm8kBtW8JIqi+ZoeOio18R4KJlbOtkWMUW+pbLG3HkpSj/zoQG+psaN4fGJHsLj
         Inuw==
X-Gm-Message-State: AOAM5336EqwgNFml9gQg4iN6DwyiFFQ3VktT3pKpiuULJUT93r7dZvoD
        afQMu6xrtYz0Yw2MwjWLv3nPL8Rh192+NvKn+TrU+Qx1y8s1w/ouzbMafAEFog51VUwiPaLF8BB
        lnAziy2u4qa09juSKxFawHA==
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr27370485ejn.201.1617029159523;
        Mon, 29 Mar 2021 07:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/j7HVK9QXbY8XEQGE615MR1/22x3g+x11AwYtuUoHe3/nb5+DkcekyOTjME7iZ9gvh3yfEQ==
X-Received: by 2002:a17:906:77c5:: with SMTP id m5mr27370467ejn.201.1617029159292;
        Mon, 29 Mar 2021 07:45:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id k9sm9191119edn.68.2021.03.29.07.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 07:45:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] ACPI: scan: Fix _STA getting called on devices with
 unmet dependencies
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20210328112000.12502-1-hdegoede@redhat.com>
 <20210328112000.12502-2-hdegoede@redhat.com> <11743876.O9o76ZdvQC@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <299640b0-2448-3c46-a7b8-54d11d1d18c7@redhat.com>
Date:   Mon, 29 Mar 2021 16:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <11743876.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/29/21 3:39 PM, Rafael J. Wysocki wrote:
> On Sunday, March 28, 2021 1:20:00 PM CEST Hans de Goede wrote:
>> Commit 71da201f38df ("ACPI: scan: Defer enumeration of devices with
>> _DEP lists") dropped the following 2 lines from acpi_init_device_object():
>>
>> 	/* Assume there are unmet deps until acpi_device_dep_initialize() runs */
>> 	device->dep_unmet = 1;
>>
>> Leaving the initial value of dep_unmet at the 0 from the kzalloc(). This
>> causes the acpi_bus_get_status() call in acpi_add_single_object() to
>> actually call _STA, even though there maybe unmet deps, leading to errors
>> like these:
>>
>> [    0.123579] ACPI Error: No handler for Region [ECRM] (00000000ba9edc4c)
>>                [GenericSerialBus] (20170831/evregion-166)
>> [    0.123601] ACPI Error: Region GenericSerialBus (ID=9) has no handler
>>                (20170831/exfldio-299)
>> [    0.123618] ACPI Error: Method parse/execution failed
>>                \_SB.I2C1.BAT1._STA, AE_NOT_EXIST (20170831/psparse-550)
>>
>> Fix this by moving the acpi_scan_dep_init() call done for devices added
>> during the second pass done by acpi_bus_scan() to inside
>> acpi_add_single_object(), so that dep_unmet is properly initialized
>> before the acpi_bus_get_status() call.
> 
> I wonder why the change below can't be made instead.
> 
> The behavior would be closer to the original then AFAICS.

Right the behavior would be closer to the code before the 2 fase scan
rework. But just actually making sure we have the right value in unmet_dep
a tiny bit earlier seems cleaner to me.

Note that the one acpi_add_single_object() call which actually sets the
new init_dep parameter to true and the previous place of calling
acpi_scan_dep_init() are very close together, here is the code before
this patch:

        acpi_add_single_object(&device, handle, type, sta, !check_dep);
        if (!device)
                return AE_CTRL_DEPTH;

        acpi_scan_init_hotplug(device);
        if (!check_dep)
                acpi_scan_dep_init();

So we are only doing the acpi_scan_dep_init() call a tiny bit earlier
and wrt which locks are being held when it gets called no changes are
made since it is still called as part of the call-graph below
acpi_bus_check_add(), I explicitly checked the locking situation because
that was my one worry with this patch.
		
And this new approach also has the advantage of not setting dep_unmet=1
(and never clearing it) for devices instantiated through:

acpi_bus_register_early_device()
acpi_bus_scan_fixed()
acpi_add_power_resource()

IOW while looking into fixing the regression of the errors being logged
again I tried to do a cleaner fix then last time.

With that said if you prefer the version you suggest let me know and I'll
post a single v2 patch doing things that way.

If you want to go with your suggestion, shall I then add a dep_unmet=0
statement to the 3 mentioned functions which leave it at 1 when going back
to the old way of handling this ?

Regards,

Hans






> 
> ---
>  drivers/acpi/scan.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/scan.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/scan.c
> +++ linux-pm/drivers/acpi/scan.c
> @@ -1647,6 +1647,8 @@ void acpi_init_device_object(struct acpi
>  	device_initialize(&device->dev);
>  	dev_set_uevent_suppress(&device->dev, true);
>  	acpi_init_coherency(device);
> +	/* Assume there are unmet deps to start with. */
> +	device->dep_unmet = 1;
>  }
>  
>  void acpi_device_add_finalize(struct acpi_device *device)
> @@ -1957,7 +1959,13 @@ static acpi_status acpi_bus_check_add(ac
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
> 
> 

