Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1926D863B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Apr 2023 20:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjDESrO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Apr 2023 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbjDESrO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Apr 2023 14:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EB1B1
        for <linux-acpi@vger.kernel.org>; Wed,  5 Apr 2023 11:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680720387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lpEtsmuQMoNLAOkH1WmlpqkaQbYklvZVRp/WaxOPMlk=;
        b=OKZ5K7l6/W7DUrMYTtc4sSci6RJljTou0VzM/DzTqMfBUJVnLR6/qfdQv10W8S23N6g6ly
        PRHwhm3xVHzKOSMQFFiKFEYvD/rjXuLBmVJ1x/UFL9LHXeZ3z/8SLUDLhvmZF6KXoXcbU3
        9+f7CCLVIy15rFUxYbnMWsThFy/+oro=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-zTwT4wlFOfiIQ13lGvYR8w-1; Wed, 05 Apr 2023 14:46:26 -0400
X-MC-Unique: zTwT4wlFOfiIQ13lGvYR8w-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-501d484e26aso2244673a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Apr 2023 11:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpEtsmuQMoNLAOkH1WmlpqkaQbYklvZVRp/WaxOPMlk=;
        b=NzemZg56hKAgkGn/luKOSwOFmnU23gzihKqqCJHCiAb1v5LB7eV2lh076h+7tRn85I
         ggXaNx7S5ZekV/tpArTzmC2vopEOAowO+a6ltDKHh7YeB4ShvCp1X4rqteGKrOCua6Ky
         A3XEJUF94P6ojfZyT5YV8Lr1dAEhU+BCq+Qlta7QiCt33djjOz86hYGUHviayESiS+gf
         iww4TphI1c3BwMWcMTxaFBMVGrVS7YE0maKEnFIqOEL/nerAMmsrEQ+s7MD7Fix9RBXR
         C6fz4C48Fym9ely6SnS4fURPF7HkoYu0vSqfTq587DbVd2gDJFR34HVRkTTfdWpA3UJD
         In+Q==
X-Gm-Message-State: AAQBX9dvjYSU5W50ZUzQxT4q3l3b30zQ1ZNTVp6ukBXmmJGVzUxBGCZ/
        fkgA7mpVT3DcTR5sJAMYTzbGNTMDqIg+VEirRHrk7M+bl5ze/II/mA+P2TLWyAvLE+LduljHE4d
        7XNHuR9TTiKg8bNLk+bP9Cg==
X-Received: by 2002:a05:6402:35d2:b0:4fd:21a6:832d with SMTP id z18-20020a05640235d200b004fd21a6832dmr2721987edc.11.1680720385607;
        Wed, 05 Apr 2023 11:46:25 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z7iIzXV2aIUykyJ3n8+u6KsqseD3eGsKrgE2xrfeprRQhYr/6fs1A5fZauwIdAMKs4CjDQPw==
X-Received: by 2002:a05:6402:35d2:b0:4fd:21a6:832d with SMTP id z18-20020a05640235d200b004fd21a6832dmr2721973edc.11.1680720385364;
        Wed, 05 Apr 2023 11:46:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e9-20020a50a689000000b004fd2a7aa1ecsm7662258edc.32.2023.04.05.11.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 11:46:22 -0700 (PDT)
Message-ID: <a2ebf2a1-af88-8b6b-3496-00075f1a4534@redhat.com>
Date:   Wed, 5 Apr 2023 20:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/6] ACPI: video: Fix missing acpi_video# devices on
 some systems
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
References: <20230404110251.42449-1-hdegoede@redhat.com>
 <CAJZ5v0jNjj2RhJo59hc+u7LOksq5kNPvYurnPnHF_OR_0zy18A@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jNjj2RhJo59hc+u7LOksq5kNPvYurnPnHF_OR_0zy18A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On 4/5/23 20:27, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Tue, Apr 4, 2023 at 1:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> Here is my v2 of this series, changes in v2:
>>
>> - Add Mario's Reviewed-by to the series
>> - Fix typo in commit-message for 5/6
>> - Drop no longer used video_detect_force_none() in 6/6
>>
>> This patch series consists of 2 parts:
>>
>> 1. Fix missing acpi_video# devices on some systems, currently in kernels
>>    >= 6.1.5 and >= 6.2.0 acpi_video# backlight class devices will only
>>    get registered (by default) when a GPU driver asks for this by calling
>>    acpi_video_register_backlight(). This is causing backlight control to
>>    be missing on some systems.
>>
>>    Patches 1-4 fix this and ideally these should be send to Linus for
>>    an upcoming 6.3-rc# release.
> 
> So I've applied these for now.
> 
> Note that I generally hate to do things like this so late in the
> cycle, so this generally is an exception AFAIAC.

Ok, thank you for taking them now.

>> 2. Now that the dust has settled a bit on the backlight refactor we can
>>    do some further cleanups. This is done in patches 5 + 6. Note that
>>    patch 5 depends on patch 2.
> 
> And I will queue up these 2 for 6.4 later.

Regards,

Hans

