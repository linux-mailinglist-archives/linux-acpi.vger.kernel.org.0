Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B234D976D
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Mar 2022 10:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiCOJSQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Mar 2022 05:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbiCOJRy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Mar 2022 05:17:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71B5D4E382
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 02:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647335801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0B1oK7Y6TPvG7zAZhjELzTA7yBvJZn6FNRyXd99mRMY=;
        b=eEIe8rDHAeQZUIs2stM/1KfnLvT/+TqSCOIQEtbdSHDToBSp2P4z+Na9a50EU3cimNyPwo
        1MUZdwCKQQ6GP7C8Oo8bp2TVASNjZLyv8TyLX/F6PfvYvr3idHXIeMu647aeNWOdF1EPhS
        v7S918Ekx+Xs4b94c2qlCohbqRZBi80=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-r27OVda4N2CthoT3mrCQow-1; Tue, 15 Mar 2022 05:16:39 -0400
X-MC-Unique: r27OVda4N2CthoT3mrCQow-1
Received: by mail-ej1-f71.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so9327402ejk.16
        for <linux-acpi@vger.kernel.org>; Tue, 15 Mar 2022 02:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=0B1oK7Y6TPvG7zAZhjELzTA7yBvJZn6FNRyXd99mRMY=;
        b=eyg+jlhv444L/9exmL135vZrxmuO82IsCAQes3BMfMpB2sf+g2QK4RIO6uyvX74ZVm
         bmFPOtkDTYZ1Zy/IR8ZhstMHApNecBmx0KVFfcaWbS8okQCGcnM7yxYXuo+B0GLsKLid
         vX4O/utGHx0goREB9nHpu9wWis/ti8xq+1d0eFpj/+2yTjB1a3yp/v+2MG659DCsk5vA
         mdlqTaIvUFC1Y09FlgVYfBHnVW+7ajC4kNpAUra/jqu3qF9huDP411MRsde6dN5+NZ+z
         zlnUs/8LJQ/gK3x5xIb4eECkhn+DAkQAWl4lqPlXW/hsvcK2EIE2jMbz8V72EeJnOInS
         0b0A==
X-Gm-Message-State: AOAM530qgLaAMMv6zmzniwCgJi8fE1UZVRspvUx9qYIj1yXG/DTpkKDP
        ZwjY3tQWA2Sw/JTG/vUaYxRAqSDkIepd6CcftySa1TTvX356IobkvI1a5fJI7zHjT3815bRxTdz
        Ev8hjnfEyY3NDziXmGbLlFw==
X-Received: by 2002:a17:907:6daa:b0:6d7:27b2:409 with SMTP id sb42-20020a1709076daa00b006d727b20409mr21745576ejc.409.1647335798609;
        Tue, 15 Mar 2022 02:16:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxbCUYuGgPpzuD7z5QyZ/Ck26bsrYBabxgdm25czevlgNVKiVh/R1vp23kSXFuwavPg32vcg==
X-Received: by 2002:a17:907:6daa:b0:6d7:27b2:409 with SMTP id sb42-20020a1709076daa00b006d727b20409mr21745559ejc.409.1647335798364;
        Tue, 15 Mar 2022 02:16:38 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id z9-20020a05640235c900b00416c894bd41sm7439690edc.16.2022.03.15.02.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 02:16:37 -0700 (PDT)
Message-ID: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
Date:   Tue, 15 Mar 2022 10:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Pearson <markpearson@lenovo.com>,
        Mark Pearson <markpearson@lenovo.com>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [discuss] Split /sys/firmware/acpi/platform_profile into ac and
 battery profiles?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

AMD based ThinkPads (1) have separate ac (connected to an external
powersource) and on battery tuned versions of the low-power, balanced and
performance profiles. So in essence they have six profiles: low-power-ac,
low-power-battery, balanced-ac, balanced-battery, performance-ac and
performance-battery.

The question is how to deal with this. There is a previous discussion
about this here:
https://lore.kernel.org/platform-driver-x86/20220301201554.4417-1-markpearson@lenovo.com/

From that previous discussions 3 possible solutions come to mind:

1. Simply treat this as 6 different profiles, maybe with documenting
   -ac/-battery postfixes for the profile-names and let userspace
   sort it out.

Pro:    -Simple from the kernel side
Contra: -Does not work with existing userspace code
        -This is quite ugly IMHO / does not feel right

2. Only export three profiles to userspace, while going "all in" on this
   concept and change drivers/acpi/platform_profile.c to add new:
   /sys/firmware/acpi/platform_profile_ac
   /sys/firmware/acpi/platform_profile_battery
   files which can contain different desired settings for the ac/battery
   case and have the kernel automatically switch between the two and
   also have it pass the ac/battery state to
   platform_profile_handler.profile_set so that for hw which has
   different ac/battery flavors of the profile the driver knows which
   one to select (without needing to detect this itself)

Pro:    -This matches well with the behavior which we want for the user
         (which is for the system to save the profile as 2 separate settings
          for ac/battery and switch the profile to the last selected setting
          for ac/battery when the state changes)
        -Solve the ac/battery state listening/notification only once
         instead of having all platform_profile drivers DIY
Contra: -This means deprecating /sys/firmware/acpi/platform_profile and
         defining how it maps to the 2 new files, e.g. if it is written
         does that only set the current active profile, or both ?
        -Userspace needs to be adjusted to use the new uapi and once it
         has been adjusted it also still needs to work on the older
         kernels which will be tricky/nasty to implement and also is
         a problem from CI / testing pov.

3. Only export three profiles to userspace and have the
   drivers/acpi/platform_profile.c "core" code pass the ac/battery state
   to platform_profile_handler.profile_set so that for hw which has
   different ac/battery flavors of the profile the driver knows which
   one to select (without needing to detect this itself)

Pro:    -Solve the ac/battery state listening/notification only once
         instead of having all platform_profile drivers DIY
        -Leaves the existing userspace API 100% unchanged and leaves
         existing userspace code working without it requiring any
         changes
Contra: -As part of the discussion on this the RFE to "have separate
         "last selected" ac/battery profile settings and automatically
         switch when the state changes" has surfaced; and that is
         not solved


Writing it down like this, to me 3. is the clear winner. The only
downside of 3. I can come up with arguably is better solved in
userspace (2), esp. since this will likely also require some UI design
work to somehow make it clear to the user that there are two different
settings (3).

Also even if no UI changes are deemed necessary this will still require
userspace changes to save+restore the two separate "last selected"
profile settings over reboots.

Please let me know what you think of this, and of course another
completely different approach is welcome too.

Regards,

Hans


1) Although AMD based ThinkPads are the trigger for this discussion,
   this applies to more new AMD based laptops, so this is not ThinkPad
   specific

2) IMHO it would be good to file a RFE issue for this against p-p-d:
   https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/new

3) AFAICT Windows does the 2 separate "last selected" ac/battery profile
   settings thing while just showing a single slider in its UI, but that
   really is a whole other discussion which the userspace/UI folks can have.

