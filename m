Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D338122636
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 09:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLQIEZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 03:04:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLQIEZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2019 03:04:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so10227653wrr.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2019 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=59PF/ZoN9PEcljCEfUWq9+2UpqXkI9QJ+WueONJK6vg=;
        b=Js7XkOnqL9mLWXj3Nk1n1z5yiMCUI42W3kT7m2TV5ccCJafOLUBX7CaDR94q2Q+2kU
         wfx2sx5P//G5vMjX6AcOY+L4J1x1l1krGBmLSXWfzp+YbbNePKa73TfPlIVcFQQ8+T/L
         4U0f5EeL/pz8Ho4W2qpaFrF9vQCDgEpKgim/sa6gDxXykJnZxNjHCIGZqjeS30F6+ooO
         I7j7QagAMFjk1RRmCevKKkghR7K1LDon8Ey2npBUAmYCIJGwc05ySrr0OQMcIEggkibP
         KlPulkn7fUh/6WOffxLYx4vwSqOoxxT/poi9eC3OBqAg6umDF4HYj/YgCcpbed927f99
         Ng+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=59PF/ZoN9PEcljCEfUWq9+2UpqXkI9QJ+WueONJK6vg=;
        b=SE31iOaHeFH9Or+apgWyEF6gdevsPCQoZAqbxwsxtBcTQpdTSjXVMHtojKgj9vif0j
         vbRAbk2i7WjBZ5DtJm5KmEd+3BuM8JanWCaap60UtoeoIKTjrrGrz2zNt8MLGJsNDjn0
         T3wKNskZvL1rcmuTYaFYOSlQq9+N6Lpx/gLwiS3Bz3MbV7g8S/cVm+9Jz/HuO7Qkb+Al
         Gd8RHdITlhbUSrxObhpGg5n6OdVtYknNMDNan9bT/ZnFVOqMXc1COyr8TzHFJzlyVhjE
         ut7eAvYkYrIm4IMCFE2wB0Jg5DtioSQoJgjjKd2uWw4a9Jyedg2ApVa1n7gxmOSx7DHL
         mziA==
X-Gm-Message-State: APjAAAU411hEeIqBxlFO9xEjn4C75aqroBFA7HB1Cl0NBrQ4W7OYu7tk
        FeoOQpqWurbPf9R6iUzd745iVdkXJqs=
X-Google-Smtp-Source: APXvYqwunMIpx5LEAro6KhRVI7eLYj5KSjPuseOp44wZBm5HKeXEInlffqYba0rAmNxtSbK1uge9hw==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr36828219wrw.346.1576569862856;
        Tue, 17 Dec 2019 00:04:22 -0800 (PST)
Received: from dell (h185-20-99-142.host.redstation.co.uk. [185.20.99.142])
        by smtp.gmail.com with ESMTPSA id g25sm2358999wmh.3.2019.12.17.00.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 00:04:22 -0800 (PST)
Date:   Tue, 17 Dec 2019 08:04:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [CI 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup to
 pwm_pmic_backlight
Message-ID: <20191217080422.GG18955@dell>
References: <20191216202906.1662893-1-hdegoede@redhat.com>
 <20191216202906.1662893-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191216202906.1662893-3-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 16 Dec 2019, Hans de Goede wrote:

> At least Bay Trail (BYT) and Cherry Trail (CHT) devices can use 1 of 2
> different PWM controllers for controlling the LCD's backlight brightness.
> 
> Either the one integrated into the PMIC or the one integrated into the
> SoC (the 1st LPSS PWM controller).
> 
> So far in the LPSS code on BYT we have skipped registering the LPSS PWM
> controller "pwm_backlight" lookup entry when a Crystal Cove PMIC is
> present, assuming that in this case the PMIC PWM controller will be used.
> 
> On CHT we have been relying on only 1 of the 2 PWM controllers being
> enabled in the DSDT at the same time; and always registered the lookup.
> 
> So far this has been working, but the correct way to determine which PWM
> controller needs to be used is by checking a bit in the VBT table and
> recently I've learned about 2 different BYT devices:
> Point of View MOBII TAB-P800W
> Acer Switch 10 SW5-012
> 
> Which use a Crystal Cove PMIC, yet the LCD is connected to the SoC/LPSS
> PWM controller (and the VBT correctly indicates this), so here our old
> heuristics fail.
> 
> Since only the i915 driver has access to the VBT, this commit renames
> the "pwm_backlight" lookup entries for the Crystal Cove PMIC's PWM
> controller to "pwm_pmic_backlight" so that the i915 driver can do a
> pwm_get() for the right controller depending on the VBT bit, instead of
> the i915 driver relying on a "pwm_backlight" lookup getting registered
> which magically points to the right controller.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
