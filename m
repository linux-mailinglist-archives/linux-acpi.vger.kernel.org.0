Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E411182CF
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2019 09:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfLJIvV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Dec 2019 03:51:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34126 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfLJIvT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Dec 2019 03:51:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id f4so1758991wmj.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Dec 2019 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2OStWiZ8mR/ZrbDoNbmkGBDlxNc16VgMrjrIx0/2wQ0=;
        b=AO6Z+SWE/wvktK+t5nl2eh8WclDR+xWSngx/QrzYjqLJER/L50nJAcGGJR4+Cj96yY
         wiO8rRU3JRYY2Ru+FHvRQscPNsk0j2BPCB0CcAjnoHu0+cSVts8aw4eKSW8Z8s8qBx6J
         ZTPPdgdPqkV4CEUfxMtT549C6Is7PdPrnSuHIglFlo2aZBK7KBlEmASJXczdr/NIlFvV
         +5KP5XWTCFrA/YyHfdaDtyddRxyFU1DBQmo/zo4JOknFQYos7bWoQFPROnfwBXv4mHeQ
         +912ddeZT55/L4itwCNWVpMW8pWeG++M1Kgz3pKZAcS7fNK4di4vqyAywZNVGjUAEC5T
         4WMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2OStWiZ8mR/ZrbDoNbmkGBDlxNc16VgMrjrIx0/2wQ0=;
        b=sT/qQpj8l/HmXar34FF/459MkLgxegYHZB8tFKdM8MwP7JjAj5KInxku6yzVDnd34j
         BXnkPLmiXJ7k8wXr00i9qHUYr6XOFYG62USkxrqNbwFyjTxGe1Xa7woGceKvr6NYVW1h
         xDptpsMJkn9JbyJSbOPcW+Bt7jOEo2bYYN1Zta0VAU8Jt8goEDR0ltWvcv90Mtz2VI/0
         nLwBz9Zhs/eHzbDC8hQBKourXApEQLg5EVF/kXKXGcHIA6OKEBb8oQJFGO6hAi8oUToG
         zlNsemMq5cPm5XR/J/lOjuKVtlFOhb0Sc8FvMKZZDO+DNyd9YA82ipypSe2+gmt2VulV
         F6jQ==
X-Gm-Message-State: APjAAAVwKUzcWAe5lXu6JDlPFP5c1Nd70ZlTaPeY85wCaM4WDqttjgJq
        Jeg+G3B3It2Vc9r3Q+3PrTJNlQ==
X-Google-Smtp-Source: APXvYqymznI8bXpwxJJKQCCpWC4oVPhj0hEsP762lFzOO7HarA6IWezEh7ZXOL05OBPRL642lpSf1g==
X-Received: by 2002:a05:600c:2383:: with SMTP id m3mr4012089wma.32.1575967877437;
        Tue, 10 Dec 2019 00:51:17 -0800 (PST)
Received: from dell (h185-20-99-176.host.redstation.co.uk. [185.20.99.176])
        by smtp.gmail.com with ESMTPSA id h8sm2585037wrx.63.2019.12.10.00.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 00:51:16 -0800 (PST)
Date:   Tue, 10 Dec 2019 08:51:11 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: intel_soc_pmic: Rename pwm_backlight pwm-lookup
 to pwm_pmic_backlight
Message-ID: <20191210085111.GQ3468@dell>
References: <20191119151818.67531-1-hdegoede@redhat.com>
 <20191119151818.67531-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191119151818.67531-3-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 19 Nov 2019, Hans de Goede wrote:

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
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/intel_soc_pmic_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
