Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56126D5C67
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjDDJxc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjDDJxb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 05:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CE71BCD
        for <linux-acpi@vger.kernel.org>; Tue,  4 Apr 2023 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680601968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YU3baiE5jcJFcyPRqyfuyxlUNYCzOJHeOLyaegE3FyY=;
        b=PyZvHKNwBEB5w6NInvfmS6/E7upiQsn/UuDhwMK0j+O6v7ORElMwz6l87m+uJ4yF5Ww5D8
        g8fzi0i6p2h8JWhoxSyLsB9xqHYge0AMx8uSwLLjZeSRdKNn/98Oy4Gmb2dhn0Vb62QjBh
        DtuUhx63x2+imXvBbGxOdui2J+d6DWE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-w1uz7uCxPo6HAZhP11qRfg-1; Tue, 04 Apr 2023 05:52:45 -0400
X-MC-Unique: w1uz7uCxPo6HAZhP11qRfg-1
Received: by mail-ed1-f69.google.com with SMTP id b6-20020a509f06000000b005029d95390aso8789819edf.2
        for <linux-acpi@vger.kernel.org>; Tue, 04 Apr 2023 02:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU3baiE5jcJFcyPRqyfuyxlUNYCzOJHeOLyaegE3FyY=;
        b=A/Jy6VMZiTa1xFpUlm1bPp+de3/c7+AbASeMeFy/kklO2FkLGzMWsESuZSfhRYqt2o
         CeujbUnLpZTOdNhtCT9AAYgJmU86z5H1GhZj4gBfbvp0e/PozveJVT4od4SNbX+6SWwC
         cST17nPEszg/mkm7+egNbw3GfYz1o2Ex3C5xN6yqsSDbSNlF2Z1uQ3s7HsM5c3NV0ceg
         m7qdcj4WgmgEn6ClJzA5tLqWAwxOgsJsIYKefy/GLFH9xwFCz7K8JKVF1QiNLtJtw/jC
         q248vPXxWLv1jyvY5J+DAr5/BcQR4MDG/7X4lrpwuGqejIeKCbKF04NLFWwA3COrls55
         2ulg==
X-Gm-Message-State: AAQBX9d4RTQIqfJaweCIBNfavSx3FWn1oRPhDXpsByG2nzF9ly4hDlN2
        vBDjGBEx/kOfAgUe1Oe4UvxhSTgCVqPl/vMycFSGXWahoSti8PkYyPqqEWijrQXgaIJjpE+mgNV
        QKlNjWqEs7kdoAHO1sVWpdw==
X-Received: by 2002:a17:906:b84d:b0:932:4cbf:5bbb with SMTP id ga13-20020a170906b84d00b009324cbf5bbbmr1574045ejb.19.1680601963878;
        Tue, 04 Apr 2023 02:52:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZDtfS/EOI5kpIf3b36bmMHk9C1WX7VRZ9pUW5bYMULneMFDCsgGGT7A1TOQ5dv3UXyLjR79Q==
X-Received: by 2002:a17:906:b84d:b0:932:4cbf:5bbb with SMTP id ga13-20020a170906b84d00b009324cbf5bbbmr1574032ejb.19.1680601963573;
        Tue, 04 Apr 2023 02:52:43 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gh5-20020a170906e08500b009475bf82935sm5703155ejb.31.2023.04.04.02.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 02:52:43 -0700 (PDT)
Message-ID: <87b34b72-b16d-9022-7bbe-0c770c4123b0@redhat.com>
Date:   Tue, 4 Apr 2023 11:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/6] ACPI: video: Fix missing acpi_video# devices on some
 systems
Content-Language: en-US, nl
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20230403160329.707176-1-hdegoede@redhat.com>
 <25d3331e-a72f-2a92-2a1f-8ea189f1ac7e@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <25d3331e-a72f-2a92-2a1f-8ea189f1ac7e@amd.com>
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

On 4/3/23 18:41, Limonciello, Mario wrote:
> On 4/3/2023 11:03, Hans de Goede wrote:
>> Hi Rafael,
>>
>> This patch series consists of 2 parts:
>>
>> 1. Fix missing acpi_video# devices on some systems, currently in kernels
>>     >= 6.1.5 and >= 6.2.0 acpi_video# backlight class devices will only
>>     get registered (by default) when a GPU driver asks for this by calling
>>     acpi_video_register_backlight(). This is causing backlight control to
>>     be missing on some systems.
>>
>>     Patches 1-4 fix this and ideally these should be send to Linus for
>>     an upcoming 6.3-rc# release.
>>
>> 2. Now that the dust has settled a bit on the backlight refactor we can
>>     do some further cleanups. This is done in patches 5 + 6. Note that
>>     patch 5 depends on patch 2.
>>
>> Regards,
>>
>> Hans
>>
>>
>> Hans de Goede (6):
>>    ACPI: video: Add auto_detect arg to __acpi_video_get_backlight_type()
>>    ACPI: video: Make acpi_backlight=video work independent from GPU
>>      driver
>>    ACPI: video: Add acpi_backlight=video quirk for Apple iMac14,1 and
>>      iMac14,2
>>    ACPI: video: Add acpi_backlight=video quirk for Lenovo ThinkPad W530
>>    ACPI: video: Remove register_backlight_delay module option and code
>>    ACPI: video: Remove desktops without backlight DMI quirks
>>
>>   drivers/acpi/acpi_video.c                     | 53 +++--------
>>   drivers/acpi/video_detect.c                   | 87 ++++++++++---------
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 -
>>   include/acpi/video.h                          | 17 +++-
>>   4 files changed, 71 insertions(+), 90 deletions(-)
>>
> 
> One minor nit on a patch, otherwise:
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Thank you.

Rafael, can you fix up the typo in the commit msg of 5/6
while merging or do you want a new version ?

Regards,

Hans



