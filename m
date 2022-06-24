Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3078F55A235
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jun 2022 21:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiFXTtu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jun 2022 15:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiFXTtt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2022 15:49:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF581DAB;
        Fri, 24 Jun 2022 12:49:46 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id q6so6671981eji.13;
        Fri, 24 Jun 2022 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Fq6Y5GABR5Xiv6AZ5DeydR2z/C8G+gw3CTWJuwXVja0=;
        b=THQMBbRBvLooOL2Wg2hnLo9Ris4qYgRBWYe8nNqM6Y4H5Z6sUDenj9BsCz8tGxjbku
         UO0mbToNRKV65y4KKdFzwi9j+HFbqpj60bW+VcDo656jJ27e/kLQ+3QyXIsRkVLXjycE
         UN4Sv9hZsWp3s58YBH+C6uuIOuOVagOoNe42MBKvLMebYeyIjL8Iw6jJgg8grmWKWSZn
         RhMbVL4W863KKcFDOGj7O3bS8tlECFBZOv2MblbgJT0GjAsrMJ8ltsqlsNUDwRd+yWHk
         1desO5xR2znpxUnm5hcjnzgCGaqvZx5Q3BShHcLZNaSZMQ9SmuWC8esJ9knZTRUG4oF2
         wnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fq6Y5GABR5Xiv6AZ5DeydR2z/C8G+gw3CTWJuwXVja0=;
        b=545YVJPBAAZo+ObgwVw4Kbu49o42qL2M8bznhIzyTfuVUHG74sELGVTJcoVlLdAN0p
         hTFVq9gxP85/Nknq4LJYLPJAuFC29GZl+Tt6BxyUQMddFtzMNRbUVv5gyM6lmltV15ED
         BAvmXHh4W+2GUAVkCOtlhVXsNmBx0Wsy+yWAynfKEz5/WLGNB3nJBbBPQeMpHQ8JtuEA
         L62Kd8C+q1wMjN/VJo4tallcS9kaBxe+Ihif0+KlTIVcakH07NOIws5vV5mupoan85rQ
         KOSW+ghO2bievfyW6PM4ey6J6zX0/3GI6sWyiwe2GKGGXHS9ZdZJv5YnP0NkS1WyHSO+
         BRNw==
X-Gm-Message-State: AJIora+g6KAI/vlSnYurlzurvJ2z6WXnk7lgX8lIt4sBx8tZbi5r5Vqi
        3uTsuMCJBJIxyKJSM42W/qw=
X-Google-Smtp-Source: AGRyM1vx9cMxbKmnLPa/JYhC+7pg2Bs8ZuKcROUz2Ig4veSKcf2av7xnTSah+ql1UFZ7RZjSSjHttw==
X-Received: by 2002:a17:906:d7:b0:718:df95:985 with SMTP id 23-20020a17090600d700b00718df950985mr659324eji.582.1656100184793;
        Fri, 24 Jun 2022 12:49:44 -0700 (PDT)
Received: from [192.168.200.12] (p3ee2b637.dip0.t-ipconnect.de. [62.226.182.55])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906c00d00b007262b7afa05sm1576933ejz.213.2022.06.24.12.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 12:49:44 -0700 (PDT)
Message-ID: <df35a580-3e4b-cf45-004f-7c6848a1dfae@message-id.googlemail.com>
Date:   Fri, 24 Jun 2022 21:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/7] ACPI: video / platform/x86: Fix Panasonic laptop
 missing keypresses
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org
References: <20220624112340.10130-1-hdegoede@redhat.com>
From:   Stefan Seyfried <stefan.seyfried@googlemail.com>
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 24.06.22 13:23, Hans de Goede wrote:
> Hi All,
> 
> Here is a series fixing the missing keypresses on some Panasonic Toughbook
> models. These missing keypresses are caused by
> commit ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double
> trigger bug"), which made the panasonic-laptop driver unconditionally drop
> most WMI reported hotkeys.
> 
> This series reverts that commit and then adds some more selective filtering
> to still avoid the double key-presses on some models, while avoiding
> completely missing keypresses on others.
> 
> Rafael, these fixes rely on patch 1/7, which is a tweak to
> the acpi_video_handles_brightness_key_presses() helper. Without this
> tweak this series will cause a regression, so I would like to merge
> the entire series through the pdx86 tree, may I have your ack for this?
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (6):
>    ACPI: video: Change how we determine if brightness key-presses are
>      handled
>    platform/x86: panasonic-laptop: sort includes alphabetically
>    platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger
>      bug"
>    platform/x86: panasonic-laptop: don't report duplicate brightness
>      key-presses
>    platform/x86: panasonic-laptop: filter out duplicate volume
>      up/down/mute keypresses
>    platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()
> 
> Stefan Seyfried (1):
>    platform/x86: panasonic-laptop: de-obfuscate button codes
> 
>   drivers/acpi/acpi_video.c               |  13 ++-
>   drivers/platform/x86/Kconfig            |   2 +
>   drivers/platform/x86/panasonic-laptop.c | 112 ++++++++++++++++++------
>   3 files changed, 91 insertions(+), 36 deletions(-)

The whole series works without any manual setup on my Toughbook CF-51:

Tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>

Thanks again!

Stefan
-- 
Stefan Seyfried

"For a successful technology, reality must take precedence over
  public relations, for nature cannot be fooled." -- Richard Feynman
