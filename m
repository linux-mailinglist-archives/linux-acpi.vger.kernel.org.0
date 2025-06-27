Return-Path: <linux-acpi+bounces-14792-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C7CAEBFA0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303C41C4646A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 19:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31F202C3A;
	Fri, 27 Jun 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSYGMoSx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAD91F3FED;
	Fri, 27 Jun 2025 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051927; cv=none; b=DUOKGYIzAMLkFFsPomIEFjXQGVl0lQc/KBTcT59zLt9W2bNFmMpux1xFBijwtVjxpstB5C3ND/gO1unSoe592fjpCysxyb590hsF6pahwH4KNXrX7IBB8bnVZoqkpb5yZiqqaEDyeo6MJmN+DMk5ZEVXA06/goUMMmg0rTsvKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051927; c=relaxed/simple;
	bh=QG/ZJnQsijuz1qj6xMLY39ghXIjNmxMa07OJWY23Tcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uACxotE77Q4dv/WV52cqbbqXxO50c+vNdByIoT2ezn7fAxFCNTc/MEY0x+/MJf4mJfgVW7jZR03HMbKeQNsf4Rrj5E4D5o30oH0l4KjS/06Jg2XpuL9UgW7E/XZ40TSwADr7SRpsINmRmUwKV+yFw6VrLqZusUAQt2W997yxyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSYGMoSx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748d982e97cso353140b3a.1;
        Fri, 27 Jun 2025 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751051925; x=1751656725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl1bZeaKAel4vJ0Jypkmyrk8ZrocaoAqPfxCMeVNaTM=;
        b=kSYGMoSxOhAWpK+XPfg3tbaOQexlMNOwOanZSWIuPtbcgj9a8lJAHtucyIGnsMGL9P
         uxPQWD28Amr8Ut8WfTAwIwspUDkrTdPhpNMyJH6BC7j8sAaExSkux0Mqa+uRyK1XZIjN
         vSXEWROAyOGcEfMoTDbDHstgrwMZPwZCL4yy6C1a0fD2jQ0NVAa3aJXlGj3hVt6vkNsl
         jakQvzmsACRRKCrla/1lp19GBhf7EYcrQC1AWXUFAgOPYSEUJu/0x5HSlHcQtosdjF+8
         e1Zut6+14Bjcd7xASihuJpUVu3JoxL6G0TazDB/x7zeOmuj/2/pU2ADk3OZ8Ju2RExBN
         Fo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751051925; x=1751656725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rl1bZeaKAel4vJ0Jypkmyrk8ZrocaoAqPfxCMeVNaTM=;
        b=GwfPcTRpX1eewtlhtMiLPgrUUXsUAmzHPqdKELqMRrL0FyLQySdLWQCVo9v5Ag7r52
         fWaLakfKmcbhS1SzM3Brxtiaq6vGQBtIZugOLUHhoTRPoWl5avo3TB3UBdhIY/7X79ja
         c9Sk7xlL0KuMVYnfsJrp0EWhXZrKpBVuQ1Uy9lJxlheggVZrqrOXp3uMwO+/mcrt/+UM
         dnDaByVL4O4fmJyCNxFzF6JlzeDbJZ+zvAU4fq8Uf0+siNKwikpzLzSxIjS3ugYBJ4ZW
         b31DZ+rmB0BLSKKM0x9NkuYXO6EWRoOyB+4OrKkfkqFLaIsShFlIY1Ryo47sGbGDcLQn
         wrcw==
X-Forwarded-Encrypted: i=1; AJvYcCUTSMphCue4uDxt06owY1gplqTsltGohyi14dzQEgwdUttZW9jm0iRcvQJBcLZ6c/yL6vt81MpMr2GKUuA=@vger.kernel.org, AJvYcCUqOnHm1Jwav57DUX/hO6z9ln/k9TM48oKclc6R/v8KG5KO3aOtyjojl8zUoYjEw3OcdqIQOSRJA9J++XnV@vger.kernel.org, AJvYcCVYsvU8jyQFnhSBsv9aoniF+ugbhsQKyj9D8cVZmbmX/JhvrTRAmp0My1qccJcSuE/XhLGuUKPy3L/TJg==@vger.kernel.org, AJvYcCXsO2ZNQyzXRCh1beuhXarH5/yZk5vJO2j12yqQa+ZV3+wz052GbCP8/f6RL8IYXYoxyZXgqQzurIj1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9wZP7p3KBMbUhzJqjt6u/776lWYk/ImvPxh+fb526TlTr3zBd
	vE84LdcACEIrobYXBiazXJlOnBk/GdGkRfzTpy/wPJEIlQ1aOTrXmjRF
X-Gm-Gg: ASbGnctzuT08f/gyWZ4lu1XTUjqtuUBwewmaEKmRslOnpYft9oQ/kvrS5QGygNVHf5n
	PkWiHuBDKX4KycidWV8PsQE2eIBqXN/sa0zEbKkanUfSX1DX+PySZpgxZprTUZU7cWMrI1Wuve2
	dqIFkqNyvYQIrWAc/pS8bNa/9Sftu77G+nHRFYcbOerxi0Wt9iMAs0XABfxmSPCtFhNtZZ6i0KR
	1lqP8tyPXfr3EJA1NhOIe1F/eVjgEraClWofXsuM75+2CZ4H3aQDOU6EiYDiZC6ynH+CnStgjMN
	bQU64KaO94YovqJS7SpuIU1Ci/f2NnqY8hVcuUFb/2QRTE7Q6zmAssmHAKlgwg==
X-Google-Smtp-Source: AGHT+IEHoSjyu/PsbXM8b723Z9LDDY+YcLgnYsBPgCDGNL/jl8ME3FpZgblnhLA1Y1P88anS+TKUUQ==
X-Received: by 2002:a05:6a20:a10a:b0:210:4397:82a5 with SMTP id adf61e73a8af0-220a1583b68mr6269885637.21.1751051924958;
        Fri, 27 Jun 2025 12:18:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d0c7:d92:6a17:eb62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56d91d7sm2710939b3a.141.2025.06.27.12.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 12:18:44 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:18:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>, 
	"open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
Message-ID: <ly3mww7nq7uuqvdx7p2uzcrphhboeuep3yuwbaxwfimesitjaa@hf72i4vu5quo>
References: <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
 <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
 <eaf7bva2skjz6oo2s2f4agooplthvuztyr6tssa7rux764qw35@kscd3rtejfvn>
 <9f5e0c21-bc25-44d0-a4d4-6fd6e58a9f2e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5e0c21-bc25-44d0-a4d4-6fd6e58a9f2e@kernel.org>

On Fri, Jun 27, 2025 at 01:56:53PM -0500, Mario Limonciello wrote:
> On 6/27/2025 1:36 PM, Dmitry Torokhov wrote:
> > On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:

[ ... trim ... ]

> > 
> > 2. There is a patch from Mario (a8605b0ed187) suppressing sending
> > KEY_POWER as part of "normal" wakeup handling, pretty much the same as
> > what he and you are proposing to do in gpio-keys (and eventually in
> > every driver keyboard or button driver in the kernel). This means we no
> > longer can tell if wakeup is done by power button or sleep button (on
> > systems with dual-button models, see ACPI 4.8.3.1).
> 
> Actually a8605b0ed187 was about a runtime regression not a suspend
> regression.  I didn't change anything with sending KEY_POWER during wakeup
> handling.

Ah, right, ignorng events for "suspended" buttons was done in
e71eeb2a6bcc ("ACPI / button: Do not propagate wakeup-from-suspend
events"). Again trying to add heuristic to the kernel instead of
enlightening userspace.

I am curious why the system is sending "Notify Wake" events when not
sleeping though?

[ .. skip .. ]

> 
> FTR I did test Hans suggestion and it does work effectively (code below).
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c
> b/drivers/input/keyboard/gpio_keys.c
> index f9db86da0818b..3bc8c95e9943b 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -425,7 +425,8 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
> *dev_id)
>                          * already released by the time we got interrupt
>                          * handler to run.
>                          */
> -                       input_report_key(bdata->input, button->code, 1);
> +                       input_report_key(bdata->input, *bdata->code, 1);
> +                       input_sync(bdata->input);

I start wondering if we should keep the fake press given that we do not
know for sure if wakeup truly happened because of this button press...

Can we track back to the wakeup source and determine this? It will not
help your problem, but I still believe userspace is where policy should
live.

Thanks.

-- 
Dmitry

