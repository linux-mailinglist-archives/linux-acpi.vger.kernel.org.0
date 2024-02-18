Return-Path: <linux-acpi+bounces-3668-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1585989C
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 19:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92A028107B
	for <lists+linux-acpi@lfdr.de>; Sun, 18 Feb 2024 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F036F081;
	Sun, 18 Feb 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsM4EXwQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5A2FC29
	for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281605; cv=none; b=mkz8JU/z6DA7HYcTl2pr0KDWNBIH/hn2zxbD8rHAF8LpXDw4P8CT3W6flRESFR33gUrnOX6woC2HnvNLcHd+cMruhaDOzyy35h7yDtj1m2FkPKWd0ygTqO4xY1nDnO6hKajpIJOtqIBSL2cVjxkXLpP/Wyz6KZcVTmyfSX2MOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281605; c=relaxed/simple;
	bh=sf4/d0ybzoBbuEy9of/GVPz9grv9+sZnw+0n24l2WXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kArwjQDuo8+4ZEOr74C4niewOk2FYDXSlX9BSmEdfJgOnZXaCpGzihG03DbzLnfxMAwWjhv8soX8XJp6O36noxupqiaEZ410zMraQ/md8WAUELZxPDLlp0sn0HDv3HxJ0x4Zn8TAHwOq3GMq6R88e3AEfEthV0a5RG5pnbXcJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsM4EXwQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a34c5ca2537so452643666b.0
        for <linux-acpi@vger.kernel.org>; Sun, 18 Feb 2024 10:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708281602; x=1708886402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PJFkaYuItggSIIKWCb0ID9Nlc++2M+Rk+UPIQcaoqY=;
        b=DsM4EXwQ0LKNlEstMweMbubB69UQ8kGN2n7j578B12tlQL7Ly4uRZn8nYWVEiTC+2O
         ZZbaCvna8NNzAm+7AFTnHfJUcSUpiypQSYmsBmu/9t1c+xvY19upDvl9svBV4+k3ZUbd
         RniGUKyWifW6QWQjlxv6wErWAXs3VyK06dMKwLchy6oj9ulQhwsKoSJQA2ReDP4fQ2J9
         IwHCvAOV/fgxOAeR6yw7hYjKnqzRrnnZb7nXC94k+hqiqllbx5bk9ruDv2GHpiNTPECR
         VfHIMaHPOOh6jhSZ79ZBst0QNWcyN+r1UsDHQ8ByjCSLx6kXREJu1n1gQxQQ8psHQDKr
         lBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708281602; x=1708886402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PJFkaYuItggSIIKWCb0ID9Nlc++2M+Rk+UPIQcaoqY=;
        b=n/yfEpv+pAiJsyE/WXT19ftVMAB7DGShCgKFDBxzNGmQTW5khAfm43Zjj8Gt0m35q8
         KaK7hjKaXHbgFqnftIcWFdBT8SOVRqBM5uEv1HAySLj6Dd6i79dxblIslHBoI1tYt153
         lolY8u8UbLzwp+Q8gCUKEOS6wk+UQlZI3uUXp2f9RY6WcF0xkwarYq2bdXzqb1l4wFgC
         V3ozIPVPw79oUCal6CddpUL61ewbXD4cPMYRIwzPWPrjRl6zmDxOjXMVFraIZx6QOEzd
         ABLm+gOXsLhh7EOf1dUyQUmjaHimUIhLNc/n8nfvW4hOuX+L9WkeSI4XH5b9mpjesCoJ
         9f/g==
X-Forwarded-Encrypted: i=1; AJvYcCUlskBBdEVfsstJzpQbJbA1W0UX/rRMkThKXei3HnffzjnqUEV5OVHPLIZWk6xAOiEd4LjssznzHg/8i/LLPRLn/OfkaxBfNBkDKQ==
X-Gm-Message-State: AOJu0Yw3pnTQC1ZJ5JRYhvGKMqXBfKzNixKa/iHAZ0iFK5p/42ItFJ4F
	aHW8CmUhVKrHGVcSB550LmgBadSgbAGtfs9HFIqaHgrqI+6EuXLpSmCHW+krqieMflmFoCOd/vU
	B6TNSrMg23KI1RncfNdzgHQM7hbma+z4jnbE=
X-Google-Smtp-Source: AGHT+IH5goi+bd1rWKnMMvSItIAe0EhU2uQLx8gt/Iej7M+Uv9/wzdsQvOwJtK/wiKrKCFgriq/4hT4uP5aCNO/pZG4=
X-Received: by 2002:a17:906:af09:b0:a3d:2af0:f59 with SMTP id
 lx9-20020a170906af0900b00a3d2af00f59mr7346585ejb.47.1708281601782; Sun, 18
 Feb 2024 10:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218151533.5720-1-hdegoede@redhat.com> <20240218151533.5720-2-hdegoede@redhat.com>
In-Reply-To: <20240218151533.5720-2-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 18 Feb 2024 20:39:25 +0200
Message-ID: <CAHp75VeSHZ3xMr7uD1H+hQgd0RAqE5uSw8M=b46q_Y7NEAGQuA@mail.gmail.com>
Subject: Re: [RFC 1/2] ACPI: x86: Move acpi_quirk_skip_serdev_enumeration()
 out of CONFIG_X86_ANDROID_TABLETS
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 5:15=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Some recent(ish) Dell AIO devices have a backlight controller board
> connected to an UART.
>
> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI devi=
ce
> with an UartSerialBusV2() resource to model the backlight-controller.
>
> The next patch in this series will use acpi_quirk_skip_serdev_enumeration=
()
> to still create a serdev for this for a backlight driver to bind to
> instead of creating a /dev/ttyS0.
>
> This new acpi_quirk_skip_serdev_enumeration() use is not limited to Andro=
id
> X86 tablets, so move it out of the ifdef CONFIG_X86_ANDROID_TABLETS block=
.

...

> +#else
> +static int acpi_dmi_skip_serdev_enumeration(struct device *controller_pa=
rent, bool *skip)
> +{
> +       return 0;
> +}
>  #endif

...

>  static inline int
>  acpi_quirk_skip_serdev_enumeration(struct device *controller_parent, boo=
l *skip)
>  {
>         *skip =3D false;
>         return 0;
>  }
> +#endif

Now you have basically two identical blocks in two files. I believe
you may reorganize the code to have only one of these.

--=20
With Best Regards,
Andy Shevchenko

