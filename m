Return-Path: <linux-acpi+bounces-17165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9583FB8E53A
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 22:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD9B166E1F
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED9F28C860;
	Sun, 21 Sep 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4eB9xT7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066E21883E
	for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486392; cv=none; b=C31seYGE0tKwuq/VPHUhHZdtFo2H+gcDyBeCeYuwXr7Keed3qgVlck1ig8SBcpOPi6clRfCFjD5FdTzjQwvTqhZg48aDpT2W361LKlOG8cow/MG6h4we3BMCNAHJC/pGQrkHKwsfoh+/mKJeHWlOYvyG25PTG/lY+bedqmo+QQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486392; c=relaxed/simple;
	bh=gka5bKFW2cHv0ZLSZ7B/QH8eA3YDoxbmOhwKKVhGU40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhGPpH9tW03UWgfiHtnLz1Y0fLK961RKLmmKPgIRGHTG3ZS/yYMBalFL+SDwdHRLbHBX+wdkZaOyaf1KsGox9ALb1j4NkLg3DWndC5m5cit0t8MGt4yj9KgHVRpe33XrKWN6VtMw+C2DaZt9RR9AsCagnpjGkWMox54WrVU7UNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4eB9xT7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0e7bc49263so607438566b.1
        for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758486389; x=1759091189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w1uUC+fzd5RSRP1ifN1bHpVu6vu0MYSCszxUPTV56A=;
        b=c4eB9xT7FVW3MmNDaExO5Zn7IcBZiagj3xMoby9q9msP1t7RoxWNR8q51VuR3SvEVq
         PM9G6qxxc7BK+EGwwPtts9aSr5Ft6ZlpXjpyA0WI02xBhMwIsM/Un+uTtBGZZsMzJzZ6
         +m0q+L7Ezbv7X2FGNd51E1w5Kt1S7aLXsxeuurceh5LNZlWEo0p14kJp4X2Bk+bMfq35
         sc9W95XF+ugnu7+SoWpnT1t96cBNniv54nOMXQg8RWuR2FCrOfah+oLYBTswcPFgMWZc
         U6pKunY/LtfY3EKx9MCEanadjBlOZEq5wUWj8NJTppvUJknyTcDaGkI7EGe0GtBEx+1q
         jISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758486389; x=1759091189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w1uUC+fzd5RSRP1ifN1bHpVu6vu0MYSCszxUPTV56A=;
        b=w0pg5XNSJpMXNpe7svHAAr04yCAX+xLF87ZRckxVrpMoxfErIGmFp7ZuO72f8ZbXBc
         MuN5EoODenYGMULzk7YFIIsy4VwwmD5uU+Wy5MwYsZ6WtzXV00DYgH7xC3PYflMxCRrn
         FADNmWdSi8Opyk/pAGKauFZ6tADUpZYMdBDh7Shpcon8UJ/YoBaStOQTjV2pOcSneckb
         zdj0lMtRJzAIN9bya976VCZOruBzUAupKWslRBKAgLQqg5XPxL/anxN0uh1fRdgBBKe5
         ipA0EMpvlbP+AyZbPIu28aEr18atE1jV7ngOzHgqoOHTnVdn/VbkXPr/j3a15DYjHi3j
         sjCg==
X-Forwarded-Encrypted: i=1; AJvYcCXM7FTOvXcDrS6F4lti7VOan/NQGU2WuWwSOEHbLOLnlN0xADk0RmLmUIO4EgFlbBUf5MZHRHYchlwb@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg05f5KZA7QSNtNnqTQTUQG5Yn03LdgQvLoZdGdVL137IxmE8i
	3Ipozv4NUqeaDKgIoZq50QeoPrPY68CqE3T6MYps0r6UM0YtJBSpNSs3kJ+lLkQMsq2476l0wMb
	d6mC1T5fSuGPK3a+tjBFk/GyjzILE/9A=
X-Gm-Gg: ASbGncs+jREbULDXBjvGwwCQe9FS+0RYdF3Y2aT3mpItrlhBNzkR1VQoYpOWXOW4dsP
	O+OUizfPT8FBFNb6khOfxdRnTMC5fVGyXBvT+2izlhO6mRFx2EJN+TH/c9ZJ3qfNXPzqGobXpoy
	ifCMrCboNoZpHmDD/QMCII1iGkLrwUBeWGero/Z8JKCZsUJsgl1hgEt4HDAPjKKPLnFkTnXIfOl
	YCVQKw=
X-Google-Smtp-Source: AGHT+IF+x1qG5m/7YpKbUllg6jANfb1pA8Bj2oy/e8nNAFxVGPMtNlfo7K0pnij41IW9pVmeCBnwxf9u27zs5M2RfwE=
X-Received: by 2002:a17:907:741:b0:b0e:cb5a:3dc9 with SMTP id
 a640c23a62f3a-b24ed97e846mr936786966b.8.1758486388984; Sun, 21 Sep 2025
 13:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920201200.20611-1-hansg@kernel.org> <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
 <CAHp75Vf-MMcVGDt5xAMB94N866jZROQPKpvu5dZ-nCEPA9j-pg@mail.gmail.com> <f40ab4a5-1b17-4022-9539-37e470b7a175@kernel.org>
In-Reply-To: <f40ab4a5-1b17-4022-9539-37e470b7a175@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 23:25:52 +0300
X-Gm-Features: AS18NWCHxLhQYf5FvuBq3VuISPNUQRlCd8-oqVvlkccsxjdBicCTMbzlcdEWgvE
Message-ID: <CAHp75VfaRcQOLjrd_pVK4XYPRN_4yM=acyVsOKThV3oMw1fB0g@mail.gmail.com>
Subject: Re: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce
 errors non fatal
To: Hans de Goede <hansg@kernel.org>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 11:11=E2=80=AFPM Hans de Goede <hansg@kernel.org> w=
rote:
> On 21-Sep-25 9:03 PM, Andy Shevchenko wrote:
> > On Sun, Sep 21, 2025 at 9:09=E2=80=AFPM Mario Limonciello (AMD) (kernel=
.org)
> > <superm1@kernel.org> wrote:
> >> On 9/20/2025 3:12 PM, Hans de Goede wrote:

...

> >> Looks pretty much identical now to what I sent in my v3 and that Andy
> >> had requested we change to make it fatal [1].
> >>
> >> Where is this bad GPIO value coming from?  It's in the GpioInt()
> >> declaration?  If so, should the driver actually be supporting this?
> >
> > Since it's in acpi_find_gpio() it's about any GPIO resource type.
> > Sorry, it seems I missed this fact. I was under the impression that v4
> > was done only for the GpioInt() case. With this being said, the
> > GpioIo() should not be fatal (it's already proven by cases in the wild
> > that sometimes given values there are unsupported by HW), but
> > GpioInt() in my opinion needs a justification to become non-fatal.
>
> GpioInt() debounce setting not succeeding already is non fatal in
> the acpi_request_own_gpiod() case, which is used for ACPI events
> (_AEI resources) and that exact use-case is why it was made non-fatal,
> so no this is not only about GpioIo() resources. See commit
> cef0d022f553 ("gpiolib: acpi: Make set-debounce-timeout failures non
> fatal")
>
> IOW we need set debounce failures to be non-fatal for both the GpioIo
> and GpioInt cases and this fix is correct as is.

Okay, since it doesn't change the state of affairs with for
acpi_dev_gpio_irq_wake_get_by(), it's fair enough to get it as is.
Mario, do you agree with Hans' explanations?

> It is very likely too late to fix this *regression* for 6.17.0, please
> queue this up for merging ASAP so that we can get a fix added to 6.17.1


--=20
With Best Regards,
Andy Shevchenko

