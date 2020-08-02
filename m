Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3192235A41
	for <lists+linux-acpi@lfdr.de>; Sun,  2 Aug 2020 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgHBTnJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Aug 2020 15:43:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56744 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726325AbgHBTnJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2020 15:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596397387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U4/Mw3KkAAcPCK4zYXwpvO5LLtv+hmKDZL07Q/dYPuw=;
        b=gs24Kwr2cuXfGZopPInP9zPTHjYq5/zYWU8aonpwh4ZzUR/Cjg5eq0/5w47rvFymoebUyD
        bTvZ+4lTODe3FcX+iLGEGlL/wSzOAvjxCAJcaRqHNVaGdjwl4fn/yFbpexvv58XPNhHMc0
        7X5WPRemuBYq7WtOsB+9hZpagSAIcFc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-ykUIsz4xM4yEV9_adXQnDg-1; Sun, 02 Aug 2020 15:43:05 -0400
X-MC-Unique: ykUIsz4xM4yEV9_adXQnDg-1
Received: by mail-ed1-f69.google.com with SMTP id co15so1224979edb.23
        for <linux-acpi@vger.kernel.org>; Sun, 02 Aug 2020 12:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U4/Mw3KkAAcPCK4zYXwpvO5LLtv+hmKDZL07Q/dYPuw=;
        b=dXdGcEMllszaU6M4gCcqG3q8LewE8SDRCW+uKFQii3GWhMy3zvDvctANDUlKCbquUk
         j98bEWKeu4Z9TgV5qZezVKLAXkjFHq0krbChK1O+bK59LYqeJ0dH3cq5hMEofnCcj5wB
         M5pXWa1lFRhrg/fKkr9izSYC+FFbxpLvVt6EU99fPbDcIYKtWgbSkxPHsVUXwQMOlB+3
         nNQ609WZgGiRxBJMaYrDcIvhYu1k+K0dIq0pl4G5czewlGunWt5xe5t8t7zRnDTsOmnI
         nB7W1cS0tB2NWQId3hK3ffGUV6WtNaL8dG4WihXzi4DNnzH5Ae/d4yPkIohBpv7sCUiO
         hGgQ==
X-Gm-Message-State: AOAM5330ckKCCQLJe9FFi7fdAXPwK0qVSjXhT4yNwUcxmMqrVVHrqe/Q
        fYlXxaSy45SJUFp4OX9P4vIoDxI2YVQcsi89PKisPYw8RMj55LYSZY3eB0ESkxGkTCMFHsEHedY
        C1zAF3ykVFHQ+H3KhjxLp4g==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr13098223eds.226.1596397384488;
        Sun, 02 Aug 2020 12:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynUhl0t0uuVDdTx6s58FiK7ReUpSYAlLkZ1s/9i/K4l82iijURkAOZIpAIJo7qPwgJDtnWkQ==
X-Received: by 2002:a50:ef0a:: with SMTP id m10mr13098209eds.226.1596397384275;
        Sun, 02 Aug 2020 12:43:04 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id ay5sm14253189edb.2.2020.08.02.12.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 12:43:03 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200729105436.GT3703480@smile.fi.intel.com>
 <e8f93474-1775-b20c-f9f2-e33592a02028@redhat.com>
 <20200802112524.GS3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3d66505a-3550-e81f-d6dc-250dba87e820@redhat.com>
Date:   Sun, 2 Aug 2020 21:43:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802112524.GS3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 8/2/20 1:25 PM, Andy Shevchenko wrote:
> On Sat, Aug 01, 2020 at 04:38:16PM +0200, Hans de Goede wrote:
>> On 7/29/20 12:54 PM, Andy Shevchenko wrote:
>>> On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
> 
> ...
> 
>>> One comment to consider, though. There are three channels in that PWM AFAIU.
>>> One of them is backlight control, another one can be attached to haptics. The
>>> concern is how this series may (or may not?) affect haptics behaviour.
>>
>> When you say "in that PWM" do you mean the LPSS one or the CRC one ?
> 
> CRC one. I have read it from PMIC spec, that's why the question.

Ah I see, well the kernel driver only implements support for 1 PWM output,
the one which is used for the backlight brighness control.

So this series should not affect haptics behavior, since it looks like
the haptic functionality is not supported in the mainline kernel at all.

And I'm also not aware of any tablets with a CRC PMIC which have
(non working) haptic support.

Regards,

Hans

