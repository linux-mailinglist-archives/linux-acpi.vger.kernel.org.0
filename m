Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A44C1F1B16
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Jun 2020 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbgFHOfG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Jun 2020 10:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729938AbgFHOfG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jun 2020 10:35:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B462BC08C5C2
        for <linux-acpi@vger.kernel.org>; Mon,  8 Jun 2020 07:35:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u13so15581030wml.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 Jun 2020 07:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ThWG7PLkTZsxbTGQI2QqS4ypuKcTM21qeWcb7Pqf2u0=;
        b=Wtu/IESN641sfnMFWfEgg6CJ6ybv0wkD6kDu6juOnd3HKmOlTwyYjpki6wx8lMkCZr
         II15j+zzfLYA2plLL6z1MfJ+VuPSoediq9yVINYJr3B9b++h/3U8OGqCoLCdI+I4QWXF
         DbwpgHLw1JchAiihgET+gCGvuI5T/DtkVVb2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ThWG7PLkTZsxbTGQI2QqS4ypuKcTM21qeWcb7Pqf2u0=;
        b=MkVwxZn53wcdTbt4OrcQT3LIwNoN2qFxip2uL3gNqaRMcLhoU9XTqbI3lLWXiAiCs8
         PmX0SSpnJtiZN/1s0SvdBOiA9dgYfCeb14hyz7fYLtqRo23oTBRMuIWjNlhoUTVsHjtb
         bAGHZh8BC+mg58SM8T6qmQrRyu3la99emZhpuc0cR9e8Gib1wwRGYHMK480+Xl5PfsVj
         CPvDN0M0Aa4WMc2dGFGT6Lb6H8UPI9QhpRvr8sCKYEgDQIgUA6eSVz8GHXUZd1suNfsf
         gD4uo7Xyp5qmqyxzeKTiKr4tTnkvOq++a6Wl/zh69AeVOufDV1c9qH9kRm0c8ERetf/w
         Qxmg==
X-Gm-Message-State: AOAM532hKocMxjO9TkxuGwEqfje6iPQSiKg+D5dCcvchAtuYysptWnhV
        Fg3gysDyjIDf15sJkTpLUlcVGg==
X-Google-Smtp-Source: ABdhPJyXoO9cmG2YWT7CRaiLUKnDXmJGp9wEivXhk6yC+ifOrjoJSPuglGOvD7hufAunPazgABGmJg==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr16847442wme.172.1591626904265;
        Mon, 08 Jun 2020 07:35:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b8sm23308626wrm.35.2020.06.08.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 07:35:03 -0700 (PDT)
Date:   Mon, 8 Jun 2020 16:35:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the
 atomic PWM API
Message-ID: <20200608143500.GX20149@phenom.ffwll.local>
References: <20200606202601.48410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 06, 2020 at 10:25:45PM +0200, Hans de Goede wrote:
> Hi All,
> 
> This patch series converts the i915 driver's cpde for controlling the
> panel's backlight with an external PWM controller to use the atomic PWM API.
> 
> Initially the plan was for this series to consist of 2 parts:
> 1. convert the pwm-crc driver to support the atomic PWM API and
> 2. convert the i915 driver's PWM code to use the atomic PWM API.
> 
> But during testing I've found a number of bugs in the pwm-lpss and I
> found that the acpi_lpss code needs some special handling because of
> some ugliness found in most Cherry Trail DSDTs.
> 
> So now this series has grown somewhat large and consists of 4 parts:
> 
> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
> 2. various fixes to the pwm-lpss driver
> 3. convert the pwm-crc driver to support the atomic PWM API and
> 4. convert the i915 driver's PWM code to use the atomic PWM API
> 
> So we need to discuss how to merge this (once it passes review).
> Although the inter-dependencies are only runtime I still think we should
> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
> merging the i915 changes. Both to make sure that the intel-gfx CI system
> does not become unhappy and for bisecting reasons.

Simplest is if acpi acks the acpi patches for merging through
drm-intel.git. Second simplest is topic branch (drm-intel maintainers can
do that) with the entire pile, which then acpi and drm-intel can both pull
in.

Up to the two maintainer teams to figure this one out.

/me out

Cheers, Daniel

> 
> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
> so we could just merge everything through dinq, or we could use immutable
> branch and merge those into dinq.
> 
> So Rafael and Thierry, can I either get your Acked-by for directly merging
> this into dinq, or can you provide an immutable branch with these patches?
> 
> This series has been tested (and re-tested after adding various bug-fixes)
> extensively. It has been tested on the following devices:
> 
> -Asus T100TA		BYT + CRC-PMIC PWM
> -Toshiba WT8-A		BYT + CRC-PMIC PWM
> -Thundersoft TS178	BYT + CRC-PMIC PWM, inverse PWM
> -Asus T100HA		CHT + CRC-PMIC PWM
> -Terra Pad 1061		BYT + LPSS PWM
> -Trekstor Twin 10.1	BYT + LPSS PWM
> -Asus T101HA		CHT + CRC-PMIC PWM
> -GPD Pocket		CHT + CRC-PMIC PWM
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
