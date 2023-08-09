Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E2776898
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Aug 2023 21:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjHITWp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Aug 2023 15:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjHITWU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Aug 2023 15:22:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB303C34
        for <linux-acpi@vger.kernel.org>; Wed,  9 Aug 2023 12:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691608825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYJARn+Tr8oo6UNssY2uogwaQ1veOX4LdfLq6I1sIi0=;
        b=GpFWoA4noun05sXXu7hal0LWdvtPYTYKjCQvsgXd5UwjHnPqCWUnQ45tsc81SAouVkAcG4
        r8zXt3KElfCvuCLW1rBSLrcGzfK1y4btTVGJosgEHCwu58+xc1icIIXzDJiKTQFV3TsU9o
        eJIZeRCfEb3KzhyKeDZM5NoZbRKQ5tY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-BKRzEhU0PL-Wm04u55nHng-1; Wed, 09 Aug 2023 15:20:23 -0400
X-MC-Unique: BKRzEhU0PL-Wm04u55nHng-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9bf49342dso1577001fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Aug 2023 12:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691608822; x=1692213622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYJARn+Tr8oo6UNssY2uogwaQ1veOX4LdfLq6I1sIi0=;
        b=V4yy6eQEKGpVWScmRy1rqYD+casnJmCu8ZJnDOfhTvReeOjdmIRWe47GKvA0DZzBI3
         Mg2Dw/vkVNos5gzSNLr3WkTQzTkwBIQkatt+2N0fp2/jb1L0W4CpGl4UC7pdGqGFIRNk
         7KDnByEdwgwinDu7lFwXsdEIBMV5AWRwtu4FhjdK1krNuEvqSqjZ2zVfrR+rZUx2sOg+
         fK9rZrx1S9siuJywZI3LVhaA59Wk77htkIPd5ztMFObVOWQeu8kv6o3eDZUJm+m1Z4T8
         UymcuaxN2PdhIGgo7hd/5JkT7fV09Or2Xp0FFSWqokKDZh7wtRup70ukh+iSfjNPCtH6
         yzow==
X-Gm-Message-State: AOJu0YxTs7GPxBZ2l+fp2kOFODZv2+h/zTkLC+0bmRMaGDRxC46AUZFu
        CKZSbAB+SoLFcvLQw94ifWed534N5lRKKlDaYL5QdEQOXEDhA3XXAlgE5inG/ryYM+YUHuF6071
        Lh6kKsP+zdfPOuP7DbLVRYg==
X-Received: by 2002:a05:6512:6d5:b0:4fe:825:a081 with SMTP id u21-20020a05651206d500b004fe0825a081mr44160lff.45.1691608822370;
        Wed, 09 Aug 2023 12:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtu6F06SjXUXLKVgFHropPatS+pATl3bG4JmLunyJmmo8QQwzISppJhRNnKn08hjruOqg3Cg==
X-Received: by 2002:a05:6512:6d5:b0:4fe:825:a081 with SMTP id u21-20020a05651206d500b004fe0825a081mr44145lff.45.1691608822042;
        Wed, 09 Aug 2023 12:20:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p17-20020a1709066a9100b009887f4e0291sm8302774ejr.27.2023.08.09.12.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 12:20:20 -0700 (PDT)
Message-ID: <c3684f00-27bd-d4dd-93dd-18936c006de9@redhat.com>
Date:   Wed, 9 Aug 2023 21:20:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/3] ACPI: resource: Honor MADT INT_SRC_OVR settings
 for IRQ1 on AMD Zen
Content-Language: en-US, nl
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
References: <20230809085526.84913-1-hdegoede@redhat.com>
 <20230809085526.84913-4-hdegoede@redhat.com>
 <6a6fa2ba-c07d-45b2-96c5-b0f44f5f288b@augustwikerfors.se>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6a6fa2ba-c07d-45b2-96c5-b0f44f5f288b@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/9/23 17:58, August Wikerfors wrote:
> On 2023-08-09 10:55, Hans de Goede wrote:
>> On AMD Zen acpi_dev_irq_override() by default prefers the DSDT IRQ 1
>> settings over the MADT settings.
>>
>> This causes the keyboard to malfunction on some laptop models
>> (see Links), all models from the Links have an INT_SRC_OVR MADT entry
>> for IRQ 1.
>>
>> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217336
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217406
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> One of the laptops fixed by a9c4a912b7dc, PCSpecialist Elimina Pro 16 M [1], seems to have no INT_SRC_OVR entry for IRQ 1 [2]:
> 
>> [    0.084265] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
>> [    0.084266] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> 
> I'm not sure if it was IRQ 1 that needed to be overridden for that model though, so it may work anyway with patch 2 of this series.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
> [2] https://bugzilla.kernel.org/attachment.cgi?id=304338

Good catch, thanks. So it looks like this one needs a DMI quirk (until we have a better generic solution.

I'll reach out to the reporter and ask for dmidecode output and prepare a follow-up patch. Still I think that we should move forward with this series to fix the 6 bugs which are linked to from PAtch 1's commitmsg and those are likely just the top of the iceberg.

Regards,

Hans

