Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3102A44F47D
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Nov 2021 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhKMSTx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 13 Nov 2021 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhKMSTx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Nov 2021 13:19:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2ECC061766
        for <linux-acpi@vger.kernel.org>; Sat, 13 Nov 2021 10:17:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu18so31218183lfb.0
        for <linux-acpi@vger.kernel.org>; Sat, 13 Nov 2021 10:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mrn1NIftn+/y3p04+oXFM5Qn8D5ewdrKB9+IXlb70gU=;
        b=lywvIywKxFlHdXidQtLU2+u0Kz0P/6jbCcTXwr6JrTG1J1VaK2Mszl2tJdWyP+J7nF
         1PaBi57WPUYC7tgPcIvZXR/N88Q30phP30Mlfq1R6+fn7/ieyAtTLG2JGG1OA9IyI2m/
         VBYzucN4EE+bTyszSc3LgYNBpRMQ7KrBsuiae+sqJzweyy6N5JgrO/5t1ToUo+ISh5O/
         oDPRv01L37VyCxPQtiWFWTcT1J6na6CVYMgAgDbaZvHpab7JT94Q2OC7VSOfHbbyXgca
         drAH+tvDFdLqPh7VgKLksAsU27BitOBsA8Qqo0S++D/LEkLlc6McIkuHIUC1mKCuUjZQ
         HA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mrn1NIftn+/y3p04+oXFM5Qn8D5ewdrKB9+IXlb70gU=;
        b=PsUJVY5c+M7AWmZa1KJ8Rs4RFAoWb3uxbVQM/XWZZYsnJzgzT+qjIUXP2sA7EjgiV/
         EwFIQp/v1vkhJfxXKCAfZenR7ArNhqUFhUBNpxV/bnHog91KBeFAquji8iW4TzUVXsUz
         LumoeJsQfS/mt1li7tY0x595VOxWMFY0KTqp0NNt5NJhexZQoCPpNJxmVYHXVE1EY22z
         /0xwtdQ2GelIey294NpfWfNoESfZe0BbaKgxVbli9gt7MY/iwrPDstuY4tKJxNdH+vK0
         4p8uia4gKLFyEj+XF3p9S23TVcMqJNbSmi6vZDWFHlrr+0IHPsO8Dqu96oXSGBSm1Zx4
         zR/Q==
X-Gm-Message-State: AOAM532keZ20k5VlWnl6jtDOroyVXkN1tFyZn0Oz4DHIry7q3oEQIKbk
        ZAFfv4cgaeKH9UIfnYeu13Gq1RBkamfuCTGI
X-Google-Smtp-Source: ABdhPJx7vtKszr6zsEcRb1fYDb+Mthh3Wo3OmqwifnMx3zsK/Ja1JoEYXYWs4Kh/iA1yxIhyxNEVbA==
X-Received: by 2002:ac2:430d:: with SMTP id l13mr22848869lfh.656.1636827418961;
        Sat, 13 Nov 2021 10:16:58 -0800 (PST)
Received: from localhost.localdomain ([178.127.153.223])
        by smtp.gmail.com with ESMTPSA id m9sm918244ljg.80.2021.11.13.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 10:16:58 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.95)
        (envelope-from <jekhor@gmail.com>)
        id 1mlxaD-000rS3-5U;
        Sat, 13 Nov 2021 21:16:57 +0300
Date:   Sat, 13 Nov 2021 21:16:57 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / x86: Revert: Make PWM2 device always present at
 Lenovo Yoga Book
Message-ID: <YZABGfarFQoxpf1R@jeknote.loshitsa1.net>
References: <20211113135206.5384-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113135206.5384-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Nov 13, 2021 at 02:52:06PM +0100, Hans de Goede wrote:
> It turns out that there is a WMI object which controls the PWM2 device
> used for the keyboard backlight and that WMI object also provides some
> other useful functionality.
> 
> The upcoming lenovo-yogabook-wmi driver will offer both backlight
> control and the other functionality, so there no longer is a need
> to have the lpss-pwm driver binding to PWM2 for backlight control;
> and this is now actually undesirable because this will cause both
> the WMI code and the lpss-pwm driver to poke at the same PWM
> controller.

Acked-by: Yauhen Kharuzhy <jekhor@gmail.com>

> 
> Revert commit ff6cdfd71495 ("ACPI / x86: Make PWM2 device always present
> at Lenovo Yoga Book"), removing the always-present quirk for the PWM2
> ACPI-device, so that the lpss-pwm controller will no longer bind to it.
> 
> Cc: Yauhen Kharuzhy <jekhor@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index cb988f9b23a1..bfcb76888ca7 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -54,10 +54,6 @@ static const struct always_present_id always_present_ids[] = {
>  	ENTRY("80860F09", "1", X86_MATCH(ATOM_SILVERMONT), {}),
>  	ENTRY("80862288", "1", X86_MATCH(ATOM_AIRMONT), {}),
>  
> -	/* Lenovo Yoga Book uses PWM2 for keyboard backlight control */
> -	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Lenovo YB1-X9"),
> -		}),
>  	/* The Xiaomi Mi Pad 2 uses PWM2 for touchkeys backlight control */
>  	ENTRY("80862289", "2", X86_MATCH(ATOM_AIRMONT), {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Xiaomi Inc"),
> -- 
> 2.31.1
> 

-- 
Yauhen Kharuzhy
