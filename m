Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6060A724
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 14:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiJXMsF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 08:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbiJXMqg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 08:46:36 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9228E79D
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 05:10:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso69829pjj.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+lNDU/7OVWZdRTzaQ0NNoHLmGlotseKeYdhpqFhZHk=;
        b=ELM7yD3oiyJMNZjuq6+6Ex/rHcrMTY9mQ5tNeBwzHLydPg0gZHlF7XsvW1qorqNXit
         +1clr9lF9YGe2kf2wSGlmcErC4WdUV2mJclhDusQXllPYQIVafBWeC2hY7DTDFJEA/gy
         DHTUn82tj8FzO+vABFXg6YciJQBhFtT4OT6DVBod8WTp9mMJhhSI6vwxWE2MV7uVC1M9
         CWg6mZN5LUXqiYcB5E6m33jGN8tYNt1DVe63+GyxUqJbAScwDkeBxMOxAxBg8Z/D9LBC
         /rqOoSynJrCwt1BDkHRnNol0Ycqz9wssry5CJatx+rOA9oWm9IQ5GyMCZ7LZm+IMtk07
         j8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+lNDU/7OVWZdRTzaQ0NNoHLmGlotseKeYdhpqFhZHk=;
        b=mglgr6uMfPSa9DA+IjDxkrAQsrXZRh0fbc3fKENu4lmdEZpvnlU8KcpsYFEI1/HEIb
         UkugPAertLzPJuVUiP/WHOWCG230+PStjdMEKl7qbriAZPdfankDcefR+gWtMUBaqaLQ
         HLrbLvlLkuQ4z/Tbty/wyJYpkcu1Z1OjeF87ovQZs6ZjTQjCjN/beC2zs34dXMjWIC1l
         XTUoAM2Z69uj5iznrkmX61lIVNbxFDqA4Hc9vyfDg1k8mgsEyLtcGJGP3JgFgxPVuilR
         bWhG3pZA7mIigtlcXpQc/ZHzLthxu8MGztpJuq4Q+A7ikoma7eIdM578SEv/BRLCLKPE
         KxpA==
X-Gm-Message-State: ACrzQf1SX7eIpt+qnHRpEomU5UQ9Y00IuvffHebXIEKTpPFBNqXX97nv
        tswBuKtqTLmdw+1IHJlg82iLbD26buLgtd17
X-Google-Smtp-Source: AMsMyM52yf+fvqYPvZeS1DKLnZf/VX+KNJmRf5dcZ02xlrYFrlYIJNW33UZRrKUu0oE/cElVDg23zg==
X-Received: by 2002:aa7:8011:0:b0:567:70cc:5b78 with SMTP id j17-20020aa78011000000b0056770cc5b78mr29115949pfi.29.1666612581441;
        Mon, 24 Oct 2022 04:56:21 -0700 (PDT)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id on16-20020a17090b1d1000b0020b21019086sm18524378pjb.3.2022.10.24.04.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 04:56:20 -0700 (PDT)
Message-ID: <18478739-625b-0c16-cd5a-e05c5372a74a@daynix.com>
Date:   Mon, 24 Oct 2022 20:56:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/22] Fallback to native backlight
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Jonathan Woithe <jwoithe@just42.net>,
        Ike Panhc <ike.pan@canonical.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Azael Avalos <coproscefalo@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Robert Moore <robert.moore@intel.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net,
        ibm-acpi-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org,
        devel@acpica.org
References: <20221024113513.5205-1-akihiko.odaki@daynix.com>
 <87tu3te92n.fsf@intel.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87tu3te92n.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/10/24 20:48, Jani Nikula wrote:
> On Mon, 24 Oct 2022, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>> Commit 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native()
>> helper") and following commits made native backlight unavailable if
>> CONFIG_ACPI_VIDEO is set and the backlight feature of ACPI video is
>> unavailable, which broke the backlight functionality on Lenovo ThinkPad
>> C13 Yoga Chromebook. Allow to fall back to native backlight in such
>> cases.
> 
> Where's the bug report with relevant logs, kconfigs, etc?

I haven't filed one. Should I? Please tell me where to report and what 
information you would need (to bugzilla.kernel.org with things mentioned 
in Documentation/admin-guide/reporting-issues.rst?)

Regards,
Akihiko Odaki

> 
> BR,
> Jani.
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Akihiko Odaki (22):
>>    drm/i915/opregion: Improve backlight request condition
>>    ACPI: video: Introduce acpi_video_get_backlight_types()
>>    LoongArch: Use acpi_video_get_backlight_types()
>>    platform/x86: acer-wmi: Use acpi_video_get_backlight_types()
>>    platform/x86: asus-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: asus-wmi: Use acpi_video_get_backlight_types()
>>    platform/x86: compal-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: eeepc-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: fujitsu-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: ideapad-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: msi-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: msi-wmi: Use acpi_video_get_backlight_types()
>>    platform/x86: nvidia-wmi-ec-backlight: Use
>>      acpi_video_get_backlight_types()
>>    platform/x86: panasonic-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: sony-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: thinkpad_acpi: Use acpi_video_get_backlight_types()
>>    platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
>>    platform/x86: dell-laptop: Use acpi_video_get_backlight_types()
>>    platform/x86: intel_oaktrail: Use acpi_video_get_backlight_types()
>>    ACPI: video: Remove acpi_video_get_backlight_type()
>>    ACPI: video: Fallback to native backlight
>>
>>   Documentation/gpu/todo.rst                    |  8 +--
>>   drivers/acpi/acpi_video.c                     |  2 +-
>>   drivers/acpi/video_detect.c                   | 54 ++++++++++---------
>>   drivers/gpu/drm/i915/display/intel_opregion.c |  3 +-
>>   drivers/platform/loongarch/loongson-laptop.c  |  4 +-
>>   drivers/platform/x86/acer-wmi.c               |  2 +-
>>   drivers/platform/x86/asus-laptop.c            |  2 +-
>>   drivers/platform/x86/asus-wmi.c               |  4 +-
>>   drivers/platform/x86/compal-laptop.c          |  2 +-
>>   drivers/platform/x86/dell/dell-laptop.c       |  2 +-
>>   drivers/platform/x86/eeepc-laptop.c           |  2 +-
>>   drivers/platform/x86/fujitsu-laptop.c         |  4 +-
>>   drivers/platform/x86/ideapad-laptop.c         |  2 +-
>>   drivers/platform/x86/intel/oaktrail.c         |  2 +-
>>   drivers/platform/x86/msi-laptop.c             |  2 +-
>>   drivers/platform/x86/msi-wmi.c                |  2 +-
>>   .../platform/x86/nvidia-wmi-ec-backlight.c    |  2 +-
>>   drivers/platform/x86/panasonic-laptop.c       |  2 +-
>>   drivers/platform/x86/samsung-laptop.c         |  2 +-
>>   drivers/platform/x86/sony-laptop.c            |  2 +-
>>   drivers/platform/x86/thinkpad_acpi.c          |  4 +-
>>   drivers/platform/x86/toshiba_acpi.c           |  2 +-
>>   drivers/video/backlight/backlight.c           | 18 +++++++
>>   include/acpi/video.h                          | 21 ++++----
>>   include/linux/backlight.h                     |  1 +
>>   25 files changed, 85 insertions(+), 66 deletions(-)
> 
