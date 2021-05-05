Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772733736AD
	for <lists+linux-acpi@lfdr.de>; Wed,  5 May 2021 11:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhEEJBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 May 2021 05:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhEEJBI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 May 2021 05:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620205212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOOxG8KwNMz1eFISDrmtfXXoZ2NzbYcR1eDNGbXkN5M=;
        b=eLL2XgAceM03gQjkcQBYjlix/K1USSfWxAeNXDzUbMAK2b7Sx9ZpQP0qAc0K+BP8o8MCmc
        iRh0pPI1ltorMr2bzLLjpNN75LE0LQWtDheZAB8qt8cHVJAftIpDSjX4osqFrs35McjGp8
        ZRxuvJgiL361WbPehr9wostKDJS2giA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-iKTng4y3N8uc2Kcgis6Niw-1; Wed, 05 May 2021 05:00:09 -0400
X-MC-Unique: iKTng4y3N8uc2Kcgis6Niw-1
Received: by mail-ed1-f72.google.com with SMTP id z12-20020aa7d40c0000b0290388179cc8bfso502803edq.21
        for <linux-acpi@vger.kernel.org>; Wed, 05 May 2021 02:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nOOxG8KwNMz1eFISDrmtfXXoZ2NzbYcR1eDNGbXkN5M=;
        b=jGSVck1BjNztFJh/PdZJpE8kiQ8iTMlChveh8uGsxuBnaN9V9CbB7446qRcZBB96xO
         IKJneGryrSxyVqBfwnlrrkRn6f9ygkq+lOLAcSuqT6jj+3n23en1gLLICxzeDtK80Y4D
         N3qwV6zBlwz/0Nt44dfIM6S3BdHFmnmm/O1YdsRnAfjCeZ/+nlIymVqRAe+KJ+1qrDj3
         dwptTTxU8hT20j28EE4IsGBje/rg+F/zwMBwLvq0BDcS4hKkex8LCysOsK5w7z7VJNUQ
         0lbGcIwMotkTHPeDXNSPgZK8yDXGI9jdb3KMf+vPuAma72547UsfPOAu7xOdKnnKhlbv
         ZSlQ==
X-Gm-Message-State: AOAM531HR/x5/kyi9E1tPTtT5fluLdf/aDU+nDSC9kPQZtL6/EFUDL89
        GJztyvOmrVYjEkx63v2ffH3kB/XnT8pO8lfsxHn6k4BDtHxvl9QOi9KL4rS3ECns2HBe9pWcxCz
        PK9FHZ/6BWbfdQRXTqvnbiA==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr25443079ejf.31.1620205207994;
        Wed, 05 May 2021 02:00:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJTLyyjLte+decu+WLdsqi+cR0B42grizYAH0vUZ74jz9Rb2rhoCs6M4/f1HwDK9+GA0/7wQ==
X-Received: by 2002:a17:906:e88:: with SMTP id p8mr25443055ejf.31.1620205207823;
        Wed, 05 May 2021 02:00:07 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id a22sm15599349edu.14.2021.05.05.02.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 02:00:07 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add missing LPS0 functions for AMD
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Cc:     "Liang, Prike" <Prike.Liang@amd.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Marcin Bachry <hegel666@gmail.com>
References: <20210504221140.593002-1-alexander.deucher@amd.com>
 <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <22c1b9a9-8167-5e4f-6ff7-278c386cc423@redhat.com>
Date:   Wed, 5 May 2021 11:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB2693F7109BC8E7EF9F672A16E25A9@BYAPR12MB2693.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 5/5/21 12:33 AM, Limonciello, Mario wrote:
> [AMD Public Use]
> 
>> Subject: [PATCH] platform/x86: Add missing LPS0 functions for AMD
> 
> Rafael might be willing to fix it up on commit, but if you end up needing to re-spin
> I think technically this subsystem prefix to match other stuff committed to this file
> should be:
> 
> "ACPI: PM: s2idle:"

Ack, please get the subject next right time. I was about the put this in a folder
with patches to apply to the pdx86 kernel tree once 5.13-rc1 is out, but this
should not go upstream through the pdx86 tree at all.

Regards,

Hans



> 
>>
>> These are supposedly not required for AMD platforms,
>> but at least some HP laptops seem to require it to
>> properly turn off the keyboard backlight.
>>
>> Based on a patch from Marcin Bachry <hegel666@gmail.com>.
>>
>> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Marcin Bachry <hegel666@gmail.com>
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>
>> Dropping patch 2/2 for now.  This patch fixes several
>> systems and doesn't appear to cause any issues.
>>
>>  drivers/acpi/x86/s2idle.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> index 2b69536cdccb..2d7ddb8a8cb6 100644
>> --- a/drivers/acpi/x86/s2idle.c
>> +++ b/drivers/acpi/x86/s2idle.c
>> @@ -42,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
>>
>>  /* AMD */
>>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-
>> 932122d37721"
>> +#define ACPI_LPS0_ENTRY_AMD         2
>> +#define ACPI_LPS0_EXIT_AMD          3
>>  #define ACPI_LPS0_SCREEN_OFF_AMD    4
>>  #define ACPI_LPS0_SCREEN_ON_AMD     5
>>
>> @@ -408,6 +410,7 @@ int acpi_s2idle_prepare_late(void)
>>
>>  	if (acpi_s2idle_vendor_amd()) {
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
>> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD);
>>  	} else {
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
>> @@ -422,6 +425,7 @@ void acpi_s2idle_restore_early(void)
>>  		return;
>>
>>  	if (acpi_s2idle_vendor_amd()) {
>> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD);
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
>>  	} else {
>>  		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
>> --
>> 2.30.2
> 

