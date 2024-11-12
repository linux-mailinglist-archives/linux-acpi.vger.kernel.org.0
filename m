Return-Path: <linux-acpi+bounces-9507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B879C64A7
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A72ABC6512
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE9F219E21;
	Tue, 12 Nov 2024 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNwUgGZC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E4219CB2
	for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443238; cv=none; b=bwKpkLSamtinIPFxul3AR0vjU0Iia/oQOpnbywS0v3lOaF9QGrz3BZQ58kho/GfHzMoAX4N6Uj7sEbviDLlxNGJSZJox5zTYcCuIgyGF6HxacKtvfAEYWpx7asa7CdYWGVw6V327Rr8jnvoeGssZ+UJasO7YTntxJyGiPMW1EH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443238; c=relaxed/simple;
	bh=w30QUynLmnUTQJ5zUR/4dh5FEnUhgLtNqtFEDMeX9mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5zgjgsxNVBD0l/cWl7EjBKfRL1m2O68vfqvm+3am081FKROvIwx0UftBQgjFEfcXsd0JO96WMlhQSPRVHGvt/ZY6coOxa5T9kBfQ7EPSUXWNLY3xwK014G4r8dg1/4ipZZPANWQtqA5Qeey8gMnxOjCbt8MzdIkSl9AQGKLkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNwUgGZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B10C4CECD
	for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443238;
	bh=w30QUynLmnUTQJ5zUR/4dh5FEnUhgLtNqtFEDMeX9mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BNwUgGZClRxb1WwXpWb9VXjqe/UFTwR79E95+ggcdpEUeFHLDoM8nj5PdEii2tflh
	 f8v5HOWQ0TTTLUNl9GwgaPdvJkQmdUhYs+5EGkHf8acUjzyc65R6g4iGBROGfeifRH
	 1ZEQO+tJo5/v9bKKTmLmrzs+oGNXQlTrs5QgjaM85thB5kz4qF7CcjDtBkNUPPZaK8
	 Nv99zRE7hZ9Ejd9Pf/GPfNK169OyZ0JDk1oghNa1nMbuQ8zpm8RG1Ffam1VxxDbNaT
	 8nRCLDlfOi/vhpMfsvPFlfQ2rxWLwxTkf4wbjIFpuFvCBNC6mBEwVRo+iKGQQBQknv
	 RtyF3X4JXBL0g==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5ebc9bda8c8so2681772eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 12:27:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyTNEFZ4ifDEl1lTQ1nKTR4RcYUOq1jq2PvUJZF40lwNfwgnjpNeW61V5mm/IgVbsoRK9bzXQfQdmy@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKzmOF9y7L8H9qmfMP5tF07GQAWIpJ+I5ggb7WrMO76egiDn3
	ra3GKvbXps4WK+cLMZ5YyI2SALYbDoFsNEhpegH8AsE4H6SVSa8vzREiI9repqv6aH4us/Qpr4B
	o0mUrWaKW4T6ubZ1/oQGA817T2pU=
X-Google-Smtp-Source: AGHT+IFaFxPvbkgKVRq7Edfyo5as7tesVq+uSUGZSg0QfCj0Ka+qQO73UXUl7Zh1YdS5ICbXeGY2VZa+f4S5rK5LmHs=
X-Received: by 2002:a05:6820:f04:b0:5ee:ff:2b05 with SMTP id
 006d021491bc7-5ee57c4c270mr13016896eaf.4.1731443237658; Tue, 12 Nov 2024
 12:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109220028.83047-1-hdegoede@redhat.com>
In-Reply-To: <20241109220028.83047-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:27:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jEY-PcQCnD7kPhLDt0yeqwoL_-=1+kcpHye3qggG1ygA@mail.gmail.com>
Message-ID: <CAJZ5v0jEY-PcQCnD7kPhLDt0yeqwoL_-=1+kcpHye3qggG1ygA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Add adev NULL check to acpi_quirk_skip_serdev_enumeration()
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 11:00=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> acpi_dev_hid_match() does not check for adev =3D=3D NULL, dereferencing
> it unconditional.
>
> Add a check for adev being NULL before calling acpi_dev_hid_match().
>
> At the moment acpi_quirk_skip_serdev_enumeration() is never called with
> a controller_parent without an ACPI companion, but better safe than sorry=
.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 3eec889d4f5f..423565c31d5e 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -536,7 +536,7 @@ int acpi_quirk_skip_serdev_enumeration(struct device =
*controller_parent, bool *s
>          * Set skip to true so that the tty core creates a serdev ctrl de=
vice.
>          * The backlight driver will manually create the serdev client de=
vice.
>          */
> -       if (acpi_dev_hid_match(adev, "DELL0501")) {
> +       if (adev && acpi_dev_hid_match(adev, "DELL0501")) {
>                 *skip =3D true;
>                 /*
>                  * Create a platform dev for dell-uart-backlight to bind =
to.
> --

Applied as 6.13 material, thanks!

