Return-Path: <linux-acpi+bounces-17163-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420B9B8E39C
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 21:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6163B7DDF
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A21F181F;
	Sun, 21 Sep 2025 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIMP4rPw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEB8EEDE
	for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758481454; cv=none; b=te+aNVgNnLFeKfm5qHV41hjO9Kjhzm5y3J59wHRSJHZhw73wsBLe1CRlAmzsMHuvWnGgB3tZUAq0I0JJj72qO1/jGZe9TALvopNiHzOmVNqtZcJAj+C2oYRHwDDmzbRael6U+VVj4EqrsYFPf58fABP/7YRsIwKzyFmD1tn1viI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758481454; c=relaxed/simple;
	bh=BJPFF72dsCJl//Va5XHokThLKW/b3to+vIBA6ac9V2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWCnRtHxf/PIdOjL3v0Riv1Rl42BENIm9rjsq26gMMgtoemzpvVvAmfzzDtl6DndLb60ZG3u/9Qc1ymShbwiKCyQidCRHk5jcsE9NzzB3eb8ZkCH3YVU6fMXvR/bhiDzFtV8tdTX/zMNk44Xyyr0y95nNhfhcdKJJq8KKOU32kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIMP4rPw; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042eb09948so633154566b.3
        for <linux-acpi@vger.kernel.org>; Sun, 21 Sep 2025 12:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758481451; x=1759086251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HTjUfL5kki5kMB1zvXr2jB2trY+d+4aKWapJKFWTs0=;
        b=RIMP4rPwyFlireRoboG79/sRAvOil2ckCejtv1XrYW6gqA+AoXfAxHjXQUfV6UuSHN
         AfGyeomhHGQQmKSxYhOZaIKc40KkAzNXBteWAcxQ/f3djJPkXLNidgTAv7tC/QR5bIYg
         o7qLwizrMOTEtJaLf+zthVGbmPwyZLK6q+2aapMAOGqMVt7kUlQ4W31K1DQCM0M67Gct
         tQt8tyEpbs4zzFVQisAiQPrHCOrNZAWJcNSIz36kfFmjk0FsfLFSlCM0EfafGjR2Fy0d
         WbwC6M7ZA9ysB+5ilpZjbwYR82VTAx+u6ANfddfa7rsOmQiKz4EFjVrf0fgUGn5ABn4j
         oGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758481451; x=1759086251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HTjUfL5kki5kMB1zvXr2jB2trY+d+4aKWapJKFWTs0=;
        b=bSzNAsmxjk3FAg2aghIfqj5s1EyUvaQIrbLXwt7flppuBb5zIemdQTOU6FWXMIUI2T
         RZkJXoDXK2FmjB1OXbf45CWHuXRXGNtg5oPqY4NkvH7Anmi4lzrOt9Iubpr1gKJZlf8Y
         dV3SWaAx5G8/4lUhVkJVGztvCwuURYpkJ0rVAzEori7Ss6RG6yNtm/eStRQWimVk3cWa
         OO9eU3442ent4u7cMh2xWQ8ZNN6260D8LZM8iuHnwPYGj7LEiaM0GY8/m2DtMzyZQ63U
         bM5RHEKilSSkhlJ3cTkEoUNaxX/n1f7nLe33/ypks3eV1GZ8E7v+rRK9g4fUhKrPAK9i
         Nm8w==
X-Forwarded-Encrypted: i=1; AJvYcCVHtoIgnGrTK7TdHaVe9lHa1XNWom9dIbpaf4gbBVoi+eSOjl+auEsW7E6pyExLiyWpMp52VwhDE1wh@vger.kernel.org
X-Gm-Message-State: AOJu0YzXj20Mhn0XL/Z+d6NzAxdrlvYq5DGa3t7N6waibX4OLdVGeXbp
	m5X6StVGOh42Ww66Enpvy3B8GM6X43iqJ1fIR11MIHdVUOV5D9ZRZA+VRmR1uf2nCCK4qQ3ZOJm
	C9vj0kUp0SSBqBaP55XBA9iQmNYNyj6o=
X-Gm-Gg: ASbGncu/E1u9YCfZ6x1Yw0DrQPj1KTyKnZjCdnJbEmnnEOnjC0Qr3QBXlK5JPLvPBl5
	j367ZeD2QFKvfGFqlTsbWxOI4p3qb3ga100G8uJJHIfyLykAtlrlKoVC4x/vTMlkItl4jXDudsC
	MtuN54zZUGoXzFFgf8xb96w6MNveUEt6UIpM60hv2jqRyRp79cqZCmi06yz7jLpke81IdSs9B5V
	5FKlV4Vu3nmZZXkMg==
X-Google-Smtp-Source: AGHT+IHBSnpMJcWk6XkKtG6y4uHFbhdXqxkzUnTU5yVuXt4gqaAGYKj+uH6Cnq8v6c/a2ZttHmoR79jp+2R7muQ2PIc=
X-Received: by 2002:a17:907:3c8a:b0:b0b:f228:25a with SMTP id
 a640c23a62f3a-b24f7f1a36amr1039680266b.64.1758481451396; Sun, 21 Sep 2025
 12:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920201200.20611-1-hansg@kernel.org> <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
In-Reply-To: <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 21 Sep 2025 22:03:35 +0300
X-Gm-Features: AS18NWCBhiEjsWPWd83UV9lSxsFOVR7Ya2wWnCbsBeeXYvaqpUaLo0Egqw1SSbE
Message-ID: <CAHp75Vf-MMcVGDt5xAMB94N866jZROQPKpvu5dZ-nCEPA9j-pg@mail.gmail.com>
Subject: Re: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce
 errors non fatal
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 9:09=E2=80=AFPM Mario Limonciello (AMD) (kernel.org=
)
<superm1@kernel.org> wrote:
> On 9/20/2025 3:12 PM, Hans de Goede wrote:

...

> Looks pretty much identical now to what I sent in my v3 and that Andy
> had requested we change to make it fatal [1].
>
> Where is this bad GPIO value coming from?  It's in the GpioInt()
> declaration?  If so, should the driver actually be supporting this?

Since it's in acpi_find_gpio() it's about any GPIO resource type.
Sorry, it seems I missed this fact. I was under the impression that v4
was done only for the GpioInt() case. With this being said, the
GpioIo() should not be fatal (it's already proven by cases in the wild
that sometimes given values there are unsupported by HW), but
GpioInt() in my opinion needs a justification to become non-fatal.
OTOH, for the first case we can actually run SW debounce. But it might
be quite an intrusive change to call it "a fix".

So, taking the above into account I suggest that the helper should
return int and check the info.gpioint flag and in case of being set,
return an error, otherwise ignore wrong settings. Or something like
this. In such a case we may also use it in the
acpi_dev_gpio_irq_wake_get_by().

> https://lore.kernel.org/linux-gpio/20250811164356.613840-1-superm1@kernel=
.org/
> [1]


--=20
With Best Regards,
Andy Shevchenko

