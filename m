Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB160B615
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Oct 2022 20:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiJXSrp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Oct 2022 14:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiJXSrZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Oct 2022 14:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D184714707D
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666632441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBddTd2aL3cpMShQLUMXQ70zqgPBnwYQKQRFaU3QDlI=;
        b=ZdgX7vsyzm786Q9FXqpQTLi0pp6kks2yvYpk1Ik8AeFjjwO5Hgcs8IfBxDaCtvMJh5OrCh
        ++suxNMvYddSUl5zK0mCG+4CHRqr0DJXi/Nbjl7zPWoErgZGSI7mNZi4VpXIxWJRPA6hNA
        GCNfFpoZJOXthWpEbS/suasjLyhG5Fo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-48-YbCqgs5zM9iBnRq7GWOj3g-1; Mon, 24 Oct 2022 08:00:19 -0400
X-MC-Unique: YbCqgs5zM9iBnRq7GWOj3g-1
Received: by mail-ed1-f70.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso9383960edd.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Oct 2022 05:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBddTd2aL3cpMShQLUMXQ70zqgPBnwYQKQRFaU3QDlI=;
        b=ZUQisS3gyn9CPN43+eie1FRwyp7So9JTSrdgmzZ0iFxiq1/a3Po9NuyCUC/5iBxSNz
         7R+ZmMSQBcEY1/YZp14nkx5VdMkyD0fo3BxCyzth+LbUwm4h3jPC3OyIUQQXFUFEAFEF
         31JUCb7BEyGx8Bz57zPHO3kFPMGDUDpIUCV/9JOgdqAAf8WcJ2dqGjLy/KUAMJbHGFiu
         XNpi7qXKBFawuATkWwSnVzt2mKbK2QWmOtwM9kUxojSE0lqDf/SBSeCLtrWKVUr7JCv/
         Ojy3EU7ceuzF+4OOqKEOYPOuvYLblxVmCt/0WqkgOIVD2H2yodUPPB0oME0Pjvenilsp
         HF1w==
X-Gm-Message-State: ACrzQf2453WsR847F4Ozf6Dc+x166hT0neA+uB4RcpS74aIaWRnOcQp1
        jeDMg1w2kAn5czNMqnWD623BbWj4aNyDXcygZQ5XiC8Amh/M+txjcYVnf9fdTv1AekE7BK2kXkS
        47tq6REYDBTOSF65izrQuWw==
X-Received: by 2002:a17:907:d02:b0:7a3:de36:b67 with SMTP id gn2-20020a1709070d0200b007a3de360b67mr7263999ejc.451.1666612817075;
        Mon, 24 Oct 2022 05:00:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4tdZDsl2pNG3Zoy+jU7SoBTHTkz51iCC/iggC9kztg6HWE+mkD8tnuNENa1Jj/GJlMZnu9qg==
X-Received: by 2002:a17:907:6e24:b0:791:905f:7881 with SMTP id sd36-20020a1709076e2400b00791905f7881mr27267484ejc.120.1666612806299;
        Mon, 24 Oct 2022 05:00:06 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id u20-20020a17090626d400b0078907275a44sm15446126ejc.42.2022.10.24.05.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:00:05 -0700 (PDT)
Message-ID: <bec2bb19-392d-0a69-f8f7-66bb1f8d9495@redhat.com>
Date:   Mon, 24 Oct 2022 14:00:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 00/22] Fallback to native backlight
Content-Language: en-US
To:     Akihiko Odaki <akihiko.odaki@daynix.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
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
        "Lee, Chun-Yi" <jlee@suse.com>, Mark Gross <markgross@kernel.org>,
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
 <87tu3te92n.fsf@intel.com> <18478739-625b-0c16-cd5a-e05c5372a74a@daynix.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <18478739-625b-0c16-cd5a-e05c5372a74a@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/24/22 13:56, Akihiko Odaki wrote:
> On 2022/10/24 20:48, Jani Nikula wrote:
>> On Mon, 24 Oct 2022, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>> Commit 2600bfa3df99 ("ACPI: video: Add acpi_video_backlight_use_native()
>>> helper") and following commits made native backlight unavailable if
>>> CONFIG_ACPI_VIDEO is set and the backlight feature of ACPI video is
>>> unavailable, which broke the backlight functionality on Lenovo ThinkPad
>>> C13 Yoga Chromebook. Allow to fall back to native backlight in such
>>> cases.
>>
>> Where's the bug report with relevant logs, kconfigs, etc?
> 
> I haven't filed one. Should I? Please tell me where to report and what information you would need (to bugzilla.kernel.org with things mentioned in Documentation/admin-guide/reporting-issues.rst?)

As mentioned in my other email this is a known issue, and your effort
to fix this is appreciated very much, but I don't believe your solution
to be the right one.

See: https://lore.kernel.org/linux-acpi/42a5f2c9-a1dc-8fc0-7334-fe6c390ecfbb@redhat.com/
for more details and possible solutions. Please try implementing one of
those solutions for your Chromebook. I unfortunately do not have hw to
test this myself.

Regards,

Hans



> 
> Regards,
> Akihiko Odaki
> 
>>
>> BR,
>> Jani.
>>
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>
>>> Akihiko Odaki (22):
>>>    drm/i915/opregion: Improve backlight request condition
>>>    ACPI: video: Introduce acpi_video_get_backlight_types()
>>>    LoongArch: Use acpi_video_get_backlight_types()
>>>    platform/x86: acer-wmi: Use acpi_video_get_backlight_types()
>>>    platform/x86: asus-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: asus-wmi: Use acpi_video_get_backlight_types()
>>>    platform/x86: compal-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: eeepc-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: fujitsu-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: ideapad-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: msi-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: msi-wmi: Use acpi_video_get_backlight_types()
>>>    platform/x86: nvidia-wmi-ec-backlight: Use
>>>      acpi_video_get_backlight_types()
>>>    platform/x86: panasonic-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: samsung-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: sony-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: thinkpad_acpi: Use acpi_video_get_backlight_types()
>>>    platform/x86: toshiba_acpi: Use acpi_video_get_backlight_types()
>>>    platform/x86: dell-laptop: Use acpi_video_get_backlight_types()
>>>    platform/x86: intel_oaktrail: Use acpi_video_get_backlight_types()
>>>    ACPI: video: Remove acpi_video_get_backlight_type()
>>>    ACPI: video: Fallback to native backlight
>>>
>>>   Documentation/gpu/todo.rst                    |  8 +--
>>>   drivers/acpi/acpi_video.c                     |  2 +-
>>>   drivers/acpi/video_detect.c                   | 54 ++++++++++---------
>>>   drivers/gpu/drm/i915/display/intel_opregion.c |  3 +-
>>>   drivers/platform/loongarch/loongson-laptop.c  |  4 +-
>>>   drivers/platform/x86/acer-wmi.c               |  2 +-
>>>   drivers/platform/x86/asus-laptop.c            |  2 +-
>>>   drivers/platform/x86/asus-wmi.c               |  4 +-
>>>   drivers/platform/x86/compal-laptop.c          |  2 +-
>>>   drivers/platform/x86/dell/dell-laptop.c       |  2 +-
>>>   drivers/platform/x86/eeepc-laptop.c           |  2 +-
>>>   drivers/platform/x86/fujitsu-laptop.c         |  4 +-
>>>   drivers/platform/x86/ideapad-laptop.c         |  2 +-
>>>   drivers/platform/x86/intel/oaktrail.c         |  2 +-
>>>   drivers/platform/x86/msi-laptop.c             |  2 +-
>>>   drivers/platform/x86/msi-wmi.c                |  2 +-
>>>   .../platform/x86/nvidia-wmi-ec-backlight.c    |  2 +-
>>>   drivers/platform/x86/panasonic-laptop.c       |  2 +-
>>>   drivers/platform/x86/samsung-laptop.c         |  2 +-
>>>   drivers/platform/x86/sony-laptop.c            |  2 +-
>>>   drivers/platform/x86/thinkpad_acpi.c          |  4 +-
>>>   drivers/platform/x86/toshiba_acpi.c           |  2 +-
>>>   drivers/video/backlight/backlight.c           | 18 +++++++
>>>   include/acpi/video.h                          | 21 ++++----
>>>   include/linux/backlight.h                     |  1 +
>>>   25 files changed, 85 insertions(+), 66 deletions(-)
>>
> 

