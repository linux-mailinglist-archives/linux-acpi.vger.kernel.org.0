Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17977436F
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Aug 2023 20:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHHSEU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Aug 2023 14:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbjHHSDz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2023 14:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC743CD2B
        for <linux-acpi@vger.kernel.org>; Tue,  8 Aug 2023 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691512885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J3K9oRRrQN7gSBge+DC1FxLTSD0L1mUpAjCJB98O/e4=;
        b=dfK05h9Rk42H+lRQ0bp7Bj5pZr6KFszaO/mIGV/+YtLY993citrySzNFAF/9vFrUPYU+ig
        gxbB5hmpWlwvnduAB6BHV+tl23xoJkbva0/4euCzx3ItO6RF7r4WZ/grGpS1BNWdlWrgb7
        dvbfh2pvWBR8+bkw2c/tnur9GekrJzU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-DruDBQY5NtmkMdfjVRIWsQ-1; Tue, 08 Aug 2023 04:36:43 -0400
X-MC-Unique: DruDBQY5NtmkMdfjVRIWsQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99c01c680beso370754166b.2
        for <linux-acpi@vger.kernel.org>; Tue, 08 Aug 2023 01:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691483802; x=1692088602;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3K9oRRrQN7gSBge+DC1FxLTSD0L1mUpAjCJB98O/e4=;
        b=JzPCkpDYlEFVI1yy/ESu6HpWcAMYO2qVFKuMK16sJotTNti7LkUUqk8XKa45XcnQla
         M2HRjfYMNlfa2YRPOWGhQkIM9ZbvCOpXmilB/H6E3Om/YmZovxgCO7Rb3LYebXkG/rMr
         yy5v3ZfzbXsjMaQxcrkQkQVjDYIpmpG7pH1F1iEGf+NlA5pVp4Zv7ncBTWDVMQQ/Xs/8
         0UqSuzdbdzwWK18Fj0JHH8jAjOtbPbaN4dwJdwGVt0BKM/lntwPAg+N3TlKgpKvGtLHk
         Z4a/JyCeQqSu0NJWsnpbpRF8LsA9hbxDVHEFxvSsARntKfyHIBMnpO0J+oxxMjOHwlV+
         0Ulw==
X-Gm-Message-State: AOJu0YydCPBU3ZUAmTsFrN2U3tv/XVdGvrJDsMy1qcWROtmc35ZWOc1r
        ld3h8a36E6agaQysYR2jeHItya6Jpf6pPkPx+wINQAD4CdZiOBVt8fmzxhwOJ2dDpIEtPnK3aZi
        K8ksuLD2hNu7xgNktk0K28g==
X-Received: by 2002:a17:907:763b:b0:99a:7ff1:9b5a with SMTP id jy27-20020a170907763b00b0099a7ff19b5amr9144725ejc.4.1691483802112;
        Tue, 08 Aug 2023 01:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcrXtc+wpksGkm6mY9AaRaOybT335ZUOHV9ljXSTTEGNdFjtq8IAqhiedpSReqD7ayF7Ac1g==
X-Received: by 2002:a17:907:763b:b0:99a:7ff1:9b5a with SMTP id jy27-20020a170907763b00b0099a7ff19b5amr9144712ejc.4.1691483801836;
        Tue, 08 Aug 2023 01:36:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bm6-20020a170906c04600b0098e2969ed44sm6283841ejb.45.2023.08.08.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:36:41 -0700 (PDT)
Message-ID: <de2864f9-1b70-0e35-b22a-875eb857d274@redhat.com>
Date:   Tue, 8 Aug 2023 10:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ACPI: resource: revert "Remove "Zen" specific match and
 quirks"
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-acpi@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <20230806151453.10690-1-hdegoede@redhat.com>
 <3cdde518-1c0c-24dc-1ffb-90ae34c23296@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <3cdde518-1c0c-24dc-1ffb-90ae34c23296@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/7/23 17:19, Hans de Goede wrote:
> Hi All,
> 
> On 8/6/23 17:14, Hans de Goede wrote:
>> Commit a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and
>> quirks") is causing keyboard problems for quite a log of AMD based
>> laptop users, leading to many bug reports.
>>
>> Revert this change for now, until we can come up with
>> a better fix for the PS/2 IRQ trigger-type/polarity problems
>> on some x86 laptops.
>>
>> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229165
>> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2229317
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217726
>> Cc: Mario Limonciello <mario.limonciello@amd.com>
>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> I've spend most of today analysing the situation / this problem :
> 
> 213031 - MEDION notebook internal keyboard not recognized / not working correctly
> https://bugzilla.kernel.org/show_bug.cgi?id=213031
> 
> This is the bug that started it all, the issue here was overriding
> a level low DSDT entry:
> 
>                 IRQ (Level, ActiveLow, Exclusive, )
>                     {1}
> 
> With an edge high entry from the MADT, note that edge high is the default
> mp_irqs[idx].irqflags value for legacy/ISA IRQs. The dmesg for the Ice Lake
> Medion M15T this bug is about shows no INT_SRC_OVR entry for IRQ 1
> in the MADT, it does show INT_SRC_OVR entries for IRQ 0 and 9.
> 
> At first a fix was attempted to not use the MADT override unless
> the DSDT entry was edge high. But that caused regressions, so a switch
> to a DMI based approach was used instead. Noteworthy is that some of
> the regressions benefitted from a MADT override to high edge for
> IRQ 3 and 4 (UART IRQs) even though there are no INT_SRC_OVR messages
> in the dmesg of the machine with the regression.
> 
> *** fast forward to today ***
> 
> The DMI quirk based approach seems to have worked well for the Ice Lake
> era problems from approx. 3 years ago. But on AMD Zen based systems
> the situation seems to be more complex. Not using the MADT override
> is a problem for quite a few models. But using the MADT override
> is a problem on quite a few other models ...
> 
> Looking at the status quo for v6.4 where MADT overriding by default
> is not used, 3 bugs have been filed where the override is actually
> necessary (note dmesg snippets with patched kernel to enable
> MADT override):
> 
> 217394 - IRQ override skipping breaks the Aya Neo Air Plus 6800U keyboard buttons 
> https://bugzilla.kernel.org/show_bug.cgi?id=217394
> 
> Aya Neo Air Plus - AMD Ryzen 7 6800U
> 
> [    0.003333] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.003333] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
> [    0.003333] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.410670] ACPI: IRQ 1 override to edge, low(!)
> 
> 217406 - very slow keyboard typing without IRQ override with new AMD Ryzen CPUs
> https://bugzilla.kernel.org/show_bug.cgi?id=217406
> 
> HP Pavilion Aero 13 - AMD Ryzen 7735U 
> 
> [    0.026135] ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
> [    0.026136] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.026137] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> 
> [    0.361640] ACPI: IRQ 1 override to edge, low(!)
> 
> 217336 - keyboard not working Asus TUF FA617NS 
> https://bugzilla.kernel.org/show_bug.cgi?id=217336
> 
> Asus TUF FA617NS - AMD Ryzen 7 7735HS
> 
> Noteworthy DSTD keyboard resource:
> 
>                 IRQNoFlags ()
>                     {1}
> 
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 1 global_irq 1 low edge)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> ACPI: IRQ 1 override to edge, low(!)
> 
> So for all 3 do use MADT override on Zen bugs we have an INT_SRC_OVR dmesg entry
> for IRQ 1.
> 
> Unfortunately the "MAINGEAR Vector Pro 2 17" / "MG-VCP2-17A3070T" for
> which a quirk was added in commit 9946e39fe8d0 to force the override
> even though it it Zen based breaks this pattern:
> 
> [    0.073733] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.073734] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.341347] ACPI: IRQ 1 override to edge, high(!)
> 
> Still the presence of an INT_SRC_OVR for a specific legacy IRQ seems
> to be a strong indicator that MADT overriding should be used in that
> case and can be used to at least reduce the amount of DMI quirks.
> 
> Another interesting data point is that all the devices for which
> DMI quirks are present for which MADT overriding should not be used
> for IRQ 1 all have a DSDT entry with the IRQ configured as level low
> and exclusive.
> 
> I think that the best thing to do might be to go back to
> the original approach from:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=0ec4e55e9f571f08970ed115ec0addc691eda613
> 
> and then limit this to IRQ1. Also maybe inverting the check to:
> 
> static bool irq_is_legacy(struct acpi_resource_irq *irq)
> {
> 	return !(irq->triggering == ACPI_LEVEL_SENSITIVE &&
> 		 irq->polarity == ACPI_ACTIVE_LOW &&
> 		 irq->shareable == ACPI_EXCLUSIVE);
> }
> 
> But I need to check if this will work for all the new Zen models
> for which we got bug reports after the recent dropping of
> 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")

So today I have started with continueing the investigation looking
at laptop models where we used to not override because of:

        if (boot_cpu_has(X86_FEATURE_ZEN))
                return false;

And where removing this and thus using the override has led to a
regression.

Looking at the acpidump-s from the following bugs:

https://bugzilla.redhat.com/show_bug.cgi?id=2229165
https://bugzilla.redhat.com/show_bug.cgi?id=2229317
https://bugzilla.kernel.org/show_bug.cgi?id=217726

All of these use the following settings for the kbd in the DSDT:

         IRQ (Edge, ActiveLow, Shared, )
             {1}

So we know these are at least 3 models with "Edge, ActiveLow, Shared" IRQ 1 settings which must not use the override. But the existing quirks before a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks") contain:

        { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
        { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },

IOW models with "Edge, ActiveLow, Shared" IRQ 1 settings which OTOH must use the override, so as I was already afraid there is no easy for these DSDT IRQ 1 settings skip the override solution :|

So I have 2 plans to move forward with this:

Plan 1. Short them for 6.5 and backporting to 6.4.y (and other stable series):

1. Revert a9c4a912b7dc
2. Limit the acpi_dev_irq_override() check to only ever skip the IRQ override
   (return false) for GSI 1.
3. Add a check if there is a INT_SRC_OVR MADT entry for GSI 1 and in that case
   use the override even on ZEN, fixing:

217394 - IRQ override skipping breaks the Aya Neo Air Plus 6800U keyboard buttons 
 https://bugzilla.kernel.org/show_bug.cgi?id=217394
217406 - very slow keyboard typing without IRQ override with new AMD Ryzen CPUs
 https://bugzilla.kernel.org/show_bug.cgi?id=217406
217336 - keyboard not working Asus TUF FA617NS 
 https://bugzilla.kernel.org/show_bug.cgi?id=217336

Which are known AMD ZEN based laptops which do need the override for IRQ 1.

This short term plan is not ideal, but it does fix all currently known issues / models and does so in a way which will hopefully not cause regressions on any other models.


Plan 2. Long term, see if I can come up with a way to read back the actual trigger type set in the IOAPIC for IRQ 1 at boot (in drivers/acpi/resource.c) and use that.


Regards,

Hans


