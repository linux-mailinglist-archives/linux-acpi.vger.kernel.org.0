Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5778A56CFC0
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Jul 2022 17:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiGJPYp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jul 2022 11:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGJPYo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jul 2022 11:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9E41DFF2
        for <linux-acpi@vger.kernel.org>; Sun, 10 Jul 2022 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657466680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhwQDFPNGXkKMP43FBbH/URrviZilI4PJK8EbA8uiTQ=;
        b=N9oTcurnj0i/pHchoE9ZrcbFzkUMA0wtZsd2OZk1EwA38e0oUMEwWJz5QL9lyyEKtzKf5m
        vdRydp4rELzrZyJiJUNHGIJJxeb+x93uADpeyH0YcVBdXBV3y0Hhf63dZ3mphO3G2bft4T
        ItjzHerNE7O1F5oFOyxCGF7UlLBlQ1I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-d1CX0Lt4P3GP6-9Y6liwkA-1; Sun, 10 Jul 2022 11:24:39 -0400
X-MC-Unique: d1CX0Lt4P3GP6-9Y6liwkA-1
Received: by mail-ed1-f70.google.com with SMTP id x21-20020a05640226d500b0043abb7ac086so2677196edd.14
        for <linux-acpi@vger.kernel.org>; Sun, 10 Jul 2022 08:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fhwQDFPNGXkKMP43FBbH/URrviZilI4PJK8EbA8uiTQ=;
        b=0M+aWi1Clw4mdJVBhWEryZfCMcsD/utmcK4CO9rN+DnOZ/VgQVzH1l08vZCl9p+B1R
         /BPIXq1SSp2kuULBBagDA4z3mz21ynNePOP4rsMMw3sMkxX4L2bEmK87m4i4WaJQJU75
         J5b6+7nzs6HO2XsG/TX+Uex9y0Fwcqof81GDNby/rh0GbbL6ym8bP801shVYPAhygTqA
         NWAdSNBl0pgcH5sS//+yoj5LJgQKLHeHGyoyE1K4wqcV/wn2HfusghqmToin7/YKJGWu
         uEjBmO9ZAmH3lKe3pkVzvgWkRj8EvKbADgP0imJFmd0FZ0EMeKYMKo3ijXdtPgflttN0
         VJ1w==
X-Gm-Message-State: AJIora+HwbnRqlNP7CSS8teJEGKi2pSO5txiAFcPMtdvo6nFN1nk6Bx0
        1aYc11kwDkI+DEBUMwdixTGCXpRBQ/tgT8K2PmJ95nRx4ew3vyX+BXGr6/n2poRQVme+dBtF21p
        f4DT+nT3dZ2iD9EyJl3O5EQ==
X-Received: by 2002:a05:6402:26ca:b0:43a:c743:7c with SMTP id x10-20020a05640226ca00b0043ac743007cmr6653765edd.227.1657466678378;
        Sun, 10 Jul 2022 08:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVS0RLr7ja+b+bMEy7f6bAHlD+bRCxD+TKlOiWNgAgQkATKaHb+nqTyuoOFb8uD4sVGFThWw==
X-Received: by 2002:a05:6402:26ca:b0:43a:c743:7c with SMTP id x10-20020a05640226ca00b0043ac743007cmr6653722edd.227.1657466678030;
        Sun, 10 Jul 2022 08:24:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0071c6dc728b2sm406655ejf.86.2022.07.10.08.24.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jul 2022 08:24:37 -0700 (PDT)
Message-ID: <eb19505d-da6a-cdd0-46be-88865617ddbb@redhat.com>
Date:   Sun, 10 Jul 2022 17:24:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] efi: Fix efi_power_off() not being run before
 acpi_power_off() when necessary
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, X86 ML <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <20220708131412.81078-1-hdegoede@redhat.com>
 <20220708131412.81078-3-hdegoede@redhat.com>
 <CAMj1kXH8sck_WMQObNVuT0RkoRFpdZ-V7A4wNW2Mj9CmwdSmZw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAMj1kXH8sck_WMQObNVuT0RkoRFpdZ-V7A4wNW2Mj9CmwdSmZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/8/22 18:37, Ard Biesheuvel wrote:
> On Fri, 8 Jul 2022 at 15:14, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Commit 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
>> switched the ACPI sleep code from directly setting the old global
>> pm_power_off handler to using the new register_sys_off_handler()
>> mechanism with a priority of SYS_OFF_PRIO_FIRMWARE.
>>
>> This is a problem when the old global pm_power_off handler would later
>> be overwritten, such as done by the late_initcall(efi_shutdown_init):
>>
>>         if (efi_poweroff_required())
>>                 pm_power_off = efi_power_off;
>>
>> The old global pm_power_off handler gets run with a priority of
>> SYS_OFF_PRIO_DEFAULT which is lower then SYS_OFF_PRIO_FIRMWARE, causing
>> acpi_power_off() to run first, changing the behavior from before
>> the ACPI sleep code switched to the new register_sys_off_handler().
>>
>> Switch the registering of efi_power_off over to register_sys_off_handler()
>> with a priority of SYS_OFF_PRIO_FIRMWARE + 1 so that it will run before
>> acpi_power_off() as before.
>>
>> Note since the new sys-off-handler code will try all handlers in
>> priority order, there is no more need for the EFI code to store and
>> call the original pm_power_off handler.
>>
>> Fixes: 98f30d0ecf79 ("ACPI: power: Switch to sys-off handler API")
>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Ard Biesheuvel <ardb@kernel.org>

Thanks, I'll include this in my next fixes pull-req for 5.19.

Regards,

Hans


> 
> Note that, as far as I know, this should only affect x86 even though
> this is generic EFI code, and arm64 also supports ACPI boot, but it
> doesn't use ACPI for poweroff/reboot etc
> 
>> ---
>>  drivers/firmware/efi/reboot.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/reboot.c b/drivers/firmware/efi/reboot.c
>> index 73089a24f04b..ceae84c19d22 100644
>> --- a/drivers/firmware/efi/reboot.c
>> +++ b/drivers/firmware/efi/reboot.c
>> @@ -6,7 +6,7 @@
>>  #include <linux/efi.h>
>>  #include <linux/reboot.h>
>>
>> -static void (*orig_pm_power_off)(void);
>> +static struct sys_off_handler *efi_sys_off_handler;
>>
>>  int efi_reboot_quirk_mode = -1;
>>
>> @@ -51,15 +51,11 @@ bool __weak efi_poweroff_required(void)
>>         return false;
>>  }
>>
>> -static void efi_power_off(void)
>> +static int efi_power_off(struct sys_off_data *data)
>>  {
>>         efi.reset_system(EFI_RESET_SHUTDOWN, EFI_SUCCESS, 0, NULL);
>> -       /*
>> -        * The above call should not return, if it does fall back to
>> -        * the original power off method (typically ACPI poweroff).
>> -        */
>> -       if (orig_pm_power_off)
>> -               orig_pm_power_off();
>> +
>> +       return NOTIFY_DONE;
>>  }
>>
>>  static int __init efi_shutdown_init(void)
>> @@ -68,8 +64,13 @@ static int __init efi_shutdown_init(void)
>>                 return -ENODEV;
>>
>>         if (efi_poweroff_required()) {
>> -               orig_pm_power_off = pm_power_off;
>> -               pm_power_off = efi_power_off;
>> +               /* SYS_OFF_PRIO_FIRMWARE + 1 so that it runs before acpi_power_off */
>> +               efi_sys_off_handler =
>> +                       register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
>> +                                                SYS_OFF_PRIO_FIRMWARE + 1,
>> +                                                efi_power_off, NULL);
>> +               if (IS_ERR(efi_sys_off_handler))
>> +                       return PTR_ERR(efi_sys_off_handler);
>>         }
>>
>>         return 0;
>> --
>> 2.36.0
>>
> 

