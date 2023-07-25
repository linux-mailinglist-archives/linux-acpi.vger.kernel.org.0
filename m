Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B76760D53
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jul 2023 10:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGYIlr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jul 2023 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjGYIlO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Jul 2023 04:41:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA8F2114
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jul 2023 01:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690274373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZTfmAZsQ/NnqLOUF4IWJ+3YxypRaxP2eX5BLrKeFJrg=;
        b=D8wgND/j8qom2ydymPccu6DsNRC2vChzm371A1T3rszJSXffgf/m98H7wGha1nv/WL0uET
        uPrgkWemSCLa5UBdUHxdFUX/G7xauxNrH0TMVAKdi1yXe6MvbU+lAkz34SdZE6GCStiNia
        R+aoeI03eOnzDuCg95B7aHFAd94/5UU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-TfFdC1NiMUWRcfzOM_2NIw-1; Tue, 25 Jul 2023 04:39:31 -0400
X-MC-Unique: TfFdC1NiMUWRcfzOM_2NIw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-98e1085308eso258674666b.0
        for <linux-acpi@vger.kernel.org>; Tue, 25 Jul 2023 01:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690274370; x=1690879170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTfmAZsQ/NnqLOUF4IWJ+3YxypRaxP2eX5BLrKeFJrg=;
        b=C5+BWX+ndLusyre+9hWelAsVZv/4/kp6ViZOivggg3z1NV3fl+ZIvmZT+S0PtQWLP4
         YL1AVirqFhMVfLswZT24t201gs58aMgElZ1TjL/ZDiBGWV1jWgC7aSU9GxAr9eySH/Ei
         ZBXUF8KwEIT6F8ryJF86+Dq3aD3fhZnxhELpFQTxgr86lf+OmTCuhGsZuhecpVZMJXxQ
         k728+ygOGBiWXrNCisACojC+i6QlvXeTXj3I1qcCQsPCXtYDuZq/BWLXCc9lzuw4n8jW
         uF/+TE6R+UrzPVOsvQPWkJbsyKXIu0gtge5QIE3Mvx6kMJJyTJq2bP/JupkLI916Iffp
         5H5A==
X-Gm-Message-State: ABy/qLYKu4d8shXz8F0n8KuGOnjaUe9YX7fRafM2OaYsF7B8ftebKRou
        b+SEdlWkXfgTETwoBFUqNse92io7QHHFxP/xro9fXgbVJmq3ohFYME9rvBWGF9RKO0mYNOD/xOH
        IfHJgVMb1+e6nHAEG7Cs5pA==
X-Received: by 2002:a17:907:1c1b:b0:992:103c:43fa with SMTP id nc27-20020a1709071c1b00b00992103c43famr1863883ejc.30.1690274370766;
        Tue, 25 Jul 2023 01:39:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8G/tLCCCzWAtLMTNoroAGafDKsLbutAv++TWKrwjITCW7OC4J5vf9m86fcaxqaJymzd/Meg==
X-Received: by 2002:a17:907:1c1b:b0:992:103c:43fa with SMTP id nc27-20020a1709071c1b00b00992103c43famr1863868ejc.30.1690274370497;
        Tue, 25 Jul 2023 01:39:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709062b0f00b0098ce63e36e9sm7949608ejg.16.2023.07.25.01.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 01:39:29 -0700 (PDT)
Message-ID: <8d71e258-0bfd-a0d0-868f-a3299864de5b@redhat.com>
Date:   Tue, 25 Jul 2023 10:39:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] ACPI: video: Put ACPI video and its child devices to
 D0 at boot
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230721152143.3108017-1-kai.heng.feng@canonical.com>
 <CAJZ5v0j=ohJ_oUpCY-F_joty9qq3Mz2Bigqa3dHaFaWP2k6ONQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0j=ohJ_oUpCY-F_joty9qq3Mz2Bigqa3dHaFaWP2k6ONQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/21/23 17:45, Rafael J. Wysocki wrote:
> Thanks for the update!
> 
> On Fri, Jul 21, 2023 at 5:22 PM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> Screen brightness can only be changed once on HP ZBook Fury 16 G10.
>>
>> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
>> for all ACPI devices:
>>
>>     Scope (\_SB.PC00.GFX0)
>>     {
>>         Scope (DD1F)
>>         {
>>             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
>>             {
>>                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
>>                 {
>>                     \_SB.PC00.LPCB.EC0.SSBC ()
>>                 }
>>             }
>>             ...
>>         }
>>         ...
>>     }
>>
>> The \_SB.PC00.GFX0.DD1F is the panel device, and its _PS0 needs to be
>> executed to make the brightness control work properly.
>>
>> _PS0 doesn't get invoked for this device because _PSC is missing,
>> which violates ACPI spec 6.3, section 7.3.6. Commit 7cd8407d53ef
>> ("ACPI / PM: Do not execute _PS0 for devices without _PSC during
>> initialization") tried to workaround missing _PSC on defective
>> firmwares, but got reverted because of regression.
>>
>> So the safest approach is to use acpi_device_fix_up_power_extended() to
>> put ACPI video and its child devices to D0 to workaround the issue.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217683
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Hans, what do you think?

I believe most (almost all?) child devices of the GFX0 (and other
acpi-video) ACPI device will not have a _PS0. So wrt child-devices
this should mostly be a no-op.

However the GFX0 ACPI device is the ACPI companion for the PCI
device for the GPU, so this will also execute _PS0 on the GPU,
we do that every suspend/resume cycle so this should be fine.

But if we do see regressions then we may need to rework this
to skip the _PS0 on the GPU itself.

With that caveat this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
>> ---
>> v3:
>>  - Wording change to make it clear it's a firmware issue.
>>  - Specify the device name in comment.
>>
>> v2:
>>  - Wording
>>  - Bugzilla
>>  - Add comment
>>
>>  drivers/acpi/acpi_video.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 62f4364e4460..1732780a672b 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -2027,6 +2027,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
>>         if (error)
>>                 goto err_put_video;
>>
>> +       /*
>> +        * HP ZBook Fury 16 G10 requires ACPI video's child devices have _PS0
>> +        * evaluated to have functional panel brightness control.
>> +        */
>> +       acpi_device_fix_up_power_extended(device);
>> +
>>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>>                video->flags.multihead ? "yes" : "no",
>> --
>> 2.34.1
>>
> 

