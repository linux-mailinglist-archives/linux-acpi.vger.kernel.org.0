Return-Path: <linux-acpi+bounces-10420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C526EA0491B
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9AA165FA6
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC501DE2CC;
	Tue,  7 Jan 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5KKuXBD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168A45027;
	Tue,  7 Jan 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274075; cv=none; b=R0JibSKfQVtKQ3BkNUgxY2ueyyzw7vud8B0BeFfCXMWCb2kfA8fJh3mAzfyXe02C0BpM/5Hg7mJyQnGoCn5s2EYGwlvqVQ7ZRW68K6bVzHlwRMF7HAg8VixHyRFUH6gwNzXcI/1uulyJMpKjLJ4FjFv9R6t82n4c43IJo4a6zT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274075; c=relaxed/simple;
	bh=laRPj4HM/p0XhfiaoGl7l+z9dop6OKtrUT+Mkuc4Qyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNA53VO/je7+YSmCPUp+O8NTAe5PRziAebv8bJcYgfNj3Y5pHYyYFENvUQ3HreyCB02rtjs1xbOKI08Vl/usHm1w9VsECUlvq9T8J5MVSIZmR6HkAKmelw6pPmMSHjQvXIV7fN49IudErSOwNnlSPUi3YbxTfVOlNin5auBivX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5KKuXBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29D2C4CEDE;
	Tue,  7 Jan 2025 18:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736274074;
	bh=laRPj4HM/p0XhfiaoGl7l+z9dop6OKtrUT+Mkuc4Qyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=T5KKuXBDXX4Een3RezVbaCtGR/dddmAN0v4uCYxt9SLPHaAiOdKmXdg1ey8Nwew6y
	 CszrZbc1an+tuLmHfZZkBfdWymdMzv/phRNzDyXIwNAwDdybZOuceWKO2j3C4je2Uf
	 rhz5QNlrYR1Dwhgz4WK2iAefisPnOQfwGNyAFLudF1s4E4yBzEqB+gLRB5iVU9BsoV
	 mudBvcwuMwY2/9+GusA7+DKUg023FAuq50oowuOu1TylrbBVKE2hyPwUUijcFR4Fxn
	 71a7M1ipSGgEbiveQT/1GqxOharIoVk9+GBPcZtf6WywGul5sx9FrjGEK2DHMTlbBH
	 wOGg7i9reIJWQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ee29277d44so6454061b6e.1;
        Tue, 07 Jan 2025 10:21:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcjbgdCDRJ1UW7jekKs8sQOO48Eag+4QZkIyp5jcGyCI/nadjwOBOOd/jXAoztsHvzd5hWZQBf/hWU@vger.kernel.org, AJvYcCXM9ZTTFzJN+JEexA1l991ZmsnrqiV1/EMp+QVRU+pAYHE7MGNd4pFsW8vz6KTNtXf6t5OmVRkU@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxJoAJjvRP3KtU91lHfNas5Js3TyCPg+4c9ixYeIn1Me+Edd8
	uQaMoHMRjdt7iNvwvVa3l+l9vtNiEp4Dmsx/kNAJrd48Lmqq6dHsYgR1w6rhEYvoMOSSPCC0lme
	9+USpphXwdlbz8xjO/PhvYNCgcLg=
X-Google-Smtp-Source: AGHT+IGegoU5jW7VJIa0VqomoZoGNcruRV8F3AJH9FLGJYQImu8OcfHGmU8N7M4MF05/3Vo2UTl7FzUEFuupNn5Jf88=
X-Received: by 2002:a05:6808:f16:b0:3eb:3b6e:a74b with SMTP id
 5614622812f47-3ef2ec43249mr27575b6e.17.1736274074164; Tue, 07 Jan 2025
 10:21:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220181352.25974-1-hdegoede@redhat.com>
In-Reply-To: <20241220181352.25974-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:21:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hJTOfdGEEW6VH239ZNso=gt5uZscWGx3iYsdSfWFan4w@mail.gmail.com>
X-Gm-Features: AbW1kvbQF2nvgysBuJ8o_B8nExsK1O6bSqtxPsJHztZQ5NK0IdDzg8KVXdnEoMc
Message-ID: <CAJZ5v0hJTOfdGEEW6VH239ZNso=gt5uZscWGx3iYsdSfWFan4w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add Asus Vivobook X1504VAP to irq1_level_low_skip_override[]
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 7:14=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Like the Vivobook X1704VAP the X1504VAP has its keyboard IRQ (1) describe=
d
> as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh which
> breaks the keyboard.
>
> Add the X1504VAP to the irq1_level_low_skip_override[] quirk table to fix
> this.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219224
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 821867de43be..ab4c0e0b6b8e 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -440,6 +440,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook X1504VAP */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "X1504VAP"),
> +               },
> +       },
>         {
>                 /* Asus Vivobook X1704VAP */
>                 .matches =3D {
> --

Applied as 6.13-rc material, thanks!

