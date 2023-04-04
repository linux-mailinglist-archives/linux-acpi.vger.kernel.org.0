Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87AE6D5E3C
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 12:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjDDKyl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjDDKxw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 06:53:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D6A3A8B
        for <linux-acpi@vger.kernel.org>; Tue,  4 Apr 2023 03:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680605580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugpo7GFITevY2amrXRUhUmMW0Uvhr70TQRjlCEyAeMc=;
        b=DDioQ4APS32d59CR8VRvvvUaEG3GAqzQz4gcCqA1JwwHBq2gQuvFdiUCaHfejMZjr0vepu
        byZJ37hBqTBMR88ASQT50g72hPmDxUKT9Jo/L7EmymXv0w6/ZGANBmB1rs7KQaIEBkON1g
        lVmn1hCG70xUjs+jKSFPITy3k+0DfaU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-lLrrIkM-OjSs2e0LM_wfsg-1; Tue, 04 Apr 2023 06:52:59 -0400
X-MC-Unique: lLrrIkM-OjSs2e0LM_wfsg-1
Received: by mail-ed1-f71.google.com with SMTP id k14-20020a508ace000000b005024a8cef5cso34696732edk.22
        for <linux-acpi@vger.kernel.org>; Tue, 04 Apr 2023 03:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680605577;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugpo7GFITevY2amrXRUhUmMW0Uvhr70TQRjlCEyAeMc=;
        b=Nxmtk8LZzOdUZ4Y55n7JrPAuzaJEyoVWZXexRNQS7zwObqR7kod4GWGdUapjG09k+8
         sYHwWOtep5qJ27ihwiSSEF+UKVK1EEwtjt22Tb11KbjHa5orRhP6VWr+ueWyu+siEGd5
         TVsPf3IRuDWje0iP3sett9JSG9wtqaG3XxuFz3U6KRn6E8EA2U3LQkMIslk97mpG7JeZ
         JUdJ19cfWts7xv8+RZEXszM/esAO5HCZ4V0r5y2bhBJ8ELqA/WnEvFKlgW3Rh7DeHEVG
         6tAXjkYVL4ZyIKApsHKl7ZZX6Q5xAA41pcJRuAIYsDlVZMeM+wNXO3ioRjIh0IORLj2f
         wioA==
X-Gm-Message-State: AAQBX9eUOcn2VRwhXURRsiEGSVdIgpdodTgFY1ep2yr0hBL08ySOA4sI
        NoDZaMQPAelCSWZY4ICRIcwqwC7CiC9MZrShDV2QChnVlbl4m9iV9f6Cb4Dz5/1dS2vzI1pS3c7
        gj7IhxYONRWKvOXws5/O5i4iE9j3m6w==
X-Received: by 2002:a17:906:3449:b0:930:9197:24d1 with SMTP id d9-20020a170906344900b00930919724d1mr20868630ejb.6.1680605577261;
        Tue, 04 Apr 2023 03:52:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350alILQcxMLBknOwU7kFDHqBBwGuRveErtqvCWxi1iNecOd2nYnbepzttTxRiQVDoJIVNRkL/Q==
X-Received: by 2002:a17:906:3449:b0:930:9197:24d1 with SMTP id d9-20020a170906344900b00930919724d1mr20868622ejb.6.1680605577023;
        Tue, 04 Apr 2023 03:52:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402518600b005028c376d50sm4496801edd.71.2023.04.04.03.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:52:55 -0700 (PDT)
Message-ID: <1c1468c1-6208-492b-ec32-43cf0d69032d@redhat.com>
Date:   Tue, 4 Apr 2023 12:52:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/6] ACPI: video: Fix missing acpi_video# devices on some
 systems
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20230403160329.707176-1-hdegoede@redhat.com>
 <25d3331e-a72f-2a92-2a1f-8ea189f1ac7e@amd.com>
 <87b34b72-b16d-9022-7bbe-0c770c4123b0@redhat.com>
In-Reply-To: <87b34b72-b16d-9022-7bbe-0c770c4123b0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 4/4/23 11:52, Hans de Goede wrote:
> Hi,
> 
> On 4/3/23 18:41, Limonciello, Mario wrote:
>> On 4/3/2023 11:03, Hans de Goede wrote:
>>> Hi Rafael,
>>>
>>> This patch series consists of 2 parts:
>>>
>>> 1. Fix missing acpi_video# devices on some systems, currently in kernels
>>>     >= 6.1.5 and >= 6.2.0 acpi_video# backlight class devices will only
>>>     get registered (by default) when a GPU driver asks for this by calling
>>>     acpi_video_register_backlight(). This is causing backlight control to
>>>     be missing on some systems.
>>>
>>>     Patches 1-4 fix this and ideally these should be send to Linus for
>>>     an upcoming 6.3-rc# release.
>>>
>>> 2. Now that the dust has settled a bit on the backlight refactor we can
>>>     do some further cleanups. This is done in patches 5 + 6. Note that
>>>     patch 5 depends on patch 2.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>> Hans de Goede (6):
>>>    ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()
>>>    ACPI: video: Make acpi_backlight=video work independent from GPU
>>>      driver
>>>    ACPI: video: Add acpi_backlight=video quirk for Apple iMac14,1 and
>>>      iMac14,2
>>>    ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530
>>>    ACPI: video: Remove register_backlight_delay module option and code
>>>    ACPI: video: Remove desktops without backlight DMI quirks
>>>
>>>   drivers/acpi/acpi_video.c                     | 53 +++--------
>>>   drivers/acpi/video_detect.c                   | 87 ++++++++++---------
>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 -
>>>   include/acpi/video.h                          | 17 +++-
>>>   4 files changed, 71 insertions(+), 90 deletions(-)
>>>
>>
>> One minor nit on a patch, otherwise:
>>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Thank you.
> 
> Rafael, can you fix up the typo in the commit msg of 5/6
> while merging or do you want a new version ?

I just noticed this caused by 6/6, which I somehow missed before:

  CC [M]  drivers/acpi/video_detect.o
drivers/acpi/video_detect.c:133:12: warning: ‘video_detect_force_none’ defined but not used [-Wunused-function]
  133 | static int video_detect_force_none(const struct dmi_system_id *d)
      |            ^~~~~~~~~~~~~~~~~~~~~~~


So I need to prepare a new version to fix this. I'll also take
care of fixing the commit msg of 5/6 in v2.

Regards,

Hans


