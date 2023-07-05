Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFF0748237
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGEKd5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 06:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGEKd4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 06:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B8CDD
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688553192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0pedzrxF76VGYnCdMLq3tBfEt7kLCHpedkXjqiqZXI8=;
        b=cL2myEl6tYvYyMqAMt+aEtyJh6Td0irSWWaZsxtp2qbo8f0Vtf6EHYZFJVKjp0nMB9IedJ
        lYNsy2+oZTG7+XQnfltjRQCC/4pbUv2UK+K0oN/+/KOW7s5jFysA0RZIAwNfoWM11cGnK8
        9Cw7jBZZLq9etJ91yPVTTUM4b4jCB7g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-94L1e6tkMQSvFQF2ao1AsA-1; Wed, 05 Jul 2023 06:33:11 -0400
X-MC-Unique: 94L1e6tkMQSvFQF2ao1AsA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9874fbf5c95so75802766b.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2023 03:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688553190; x=1691145190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pedzrxF76VGYnCdMLq3tBfEt7kLCHpedkXjqiqZXI8=;
        b=Z6ysHVKoF6RDT2eFe1lDQwzZVu8QV5uoLG4Zwb+yEegaKvz4oV7LP53Ch/8l6OhUNh
         W6T0thtbGvc94PdQkngtbhDf/NUAFyuCa3EWwpHlXfZNU9LQ2p4EAOmwkEpCxf8bpxZ+
         PBklgFLvk+wUgMyv8g3X+ML1ZG/hMgDLpNnn6O4YaZDR78JbTf9CZ4lLkEBRm1XeNvYR
         6u5Yv/WpNcC3MoN0tTvRoPjCalopRkr9wPTu+dawk7AqFekpKatIuNLuOM1eINGg7H8w
         XM8PKShT8kcMantGiTyt5vUbpMD8rzZxVpz6pFmhPDP7H5fGKbso4Wu0yC3Qd3JrvQwr
         PKfw==
X-Gm-Message-State: ABy/qLZ0FvG/EVgzkElJwVNhoB2eJXYDTkY/ftHTGodwByrqZYnsemto
        FAghTQiEZa6Qi2LvDEioez+IZGuSvQMVGQyzjdTfvlFai0l4fNuA/a9Qx7Qo8nyv2maM1ed+TgH
        zcF3zGTNdSRQWA59NewQwkl830s6L1A==
X-Received: by 2002:a17:907:2d93:b0:986:38ab:ef99 with SMTP id gt19-20020a1709072d9300b0098638abef99mr1967401ejc.9.1688553189925;
        Wed, 05 Jul 2023 03:33:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGhXqePR6/QEYX86GFSnxBLHxWyQyo9uA2HI7qOIKMEJ/tQuS5Enp3k+Ifdbo8yVpukIpwMvw==
X-Received: by 2002:a17:907:2d93:b0:986:38ab:ef99 with SMTP id gt19-20020a1709072d9300b0098638abef99mr1967382ejc.9.1688553189676;
        Wed, 05 Jul 2023 03:33:09 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id z2-20020a50eb42000000b0051bf17d7710sm12908012edp.57.2023.07.05.03.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:33:09 -0700 (PDT)
Message-ID: <f5a4f802-d6a1-050e-ec70-701048ab1a2f@redhat.com>
Date:   Wed, 5 Jul 2023 12:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
 <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
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

On 7/4/23 18:58, Rafael J. Wysocki wrote:
> On Tue, Jul 4, 2023 at 9:46 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>>
>> Screen brightness can only be changed once on some HP laptops.
>>
>> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
>> for all ACPI devices:
> 
> This part of the changelog is confusing, because the evaluation of
> _PS0 is not a separate operation.  _PS0 gets evaluated when devices
> undergo transitions from low-power states to D0.
> 
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
>> _PS0 doesn't get invoked for all ACPI devices because of commit
>> 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
>> during initialization").

So this _PS0 which seems to be the one which needs to run here,
is not the _PS0 for the GFX0 ACPI device, but rather for a child ACPI device-node which describes the connector (assumed based on the small part of quoted DSDT, the actual definition of the DD1F device-node is missing).

Having a _PS0 method on a connector object is really weird IMHO. But if we need to invoke such a _PS0 method then IMHO that really should be done in the drm/kms driver. E.g. at least the i915 code already contains code to map the ACPI connector objects to the drm_connector objects, so it should be relatively easily to make that try and do a power-transition to D0 when enabling the connector.

Also can you provide some more info on the hw on which this is being seen:

1. What GPU(s) is/are being used
2. If there is a mux for hybrid gfx in which mode is the mux set ?
3. Wjich method is used to control the brightness (which backlight-class-devices show up under /sys/class/backlight) ?

And can you add this info to the commit msg for the next version of the patch ?

Regards,

Hans




> 
> And yes, Linux doesn't put all of the ACPI devices into D0 during
> initialization, but the above commit has a little to do with that.
> 
>> For now explicitly call _PS0 for ACPI video to workaround the issue.
> 
> This is not what the patch is doing.
> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/acpi/acpi_video.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 62f4364e4460..793259bd18c8 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>>         if (error)
>>                 goto err_put_video;
>>
>> +       acpi_device_fix_up_power_extended(device);
>> +
> 
> I would like to know what Hans thinks about this.
> 
>>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>>                video->flags.multihead ? "yes" : "no",
>> --
> 

