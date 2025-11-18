Return-Path: <linux-acpi+bounces-19029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75157C6AB61
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEA1E4F26FF
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F3179A3;
	Tue, 18 Nov 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7NwkNBM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656B26F285
	for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483851; cv=none; b=PyUZ8QGHFJzv4y2sFlLHEUYQ3u4hFXhGXW+85eDVfETlTLckHch+zEMt0dk+3hYuoN9WwdGNu3bflQE2VtCK23hEHUMb8UJadylAU/1EDXf7/5+rj5Jh7KjGFT8JjPLlYfYFq0xAHyVyX71yciHjCoEjqMiY3XJs/0OponctTok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483851; c=relaxed/simple;
	bh=5LN5KVyaBuWH4vKcRRrwi3y3+sSjXaDLW7XeDCxvg/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xa0xSYl9KVeqmP9XJ/YuzbQVtFaz5+4rZ9cVD9Y7Gy5TC9/G+HKua16FpDZ15xkoGGoJYFTXHh9onqU38h4fkYI2ZRILkUmJBmCmzIeO3XBAKXEBDDIstSkR1Tb8Y6D2rex2R0fLXWD5tvqY3+viVhrKmyAwGFKy1HfCQ1RvMr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7NwkNBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA35C2BCB0
	for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763483850;
	bh=5LN5KVyaBuWH4vKcRRrwi3y3+sSjXaDLW7XeDCxvg/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b7NwkNBMioxz5dR2pVRTRXQNqdrtwH7O4EL8iI9WW9F5IBKZNs88VHvRODulZU06p
	 EUUQUOmL7RA6dn3S8yaiQYIuiAtsjgT1j6rgw87t6/3eqks0Li+6QoUzgg8lRkiwxT
	 BNWYjM0qquQ7vC2X3+6f88TI9dg6yirQZVcOFSicGrtVgaZNV8pL/rEWrQJOFgViXe
	 rUxBojnXQwfW4JBQT5i0yscAkhoOV6Q1NS52OZ9MnQEYyHEZfFeyIJbG/95ZVmPS5E
	 Faof+DAQGlYvgB+CZxXupRiilts5ziPbaR/nIDyolph/qJg+DvEEG3cOKLNJwyWgvr
	 JgPZfROyNm/HA==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6574de1cda1so1236429eaf.3
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 08:37:30 -0800 (PST)
X-Gm-Message-State: AOJu0YwvGrz0YtLOmeC7szoHZGgk/subKHQSpqPtO3B51cFzZRYMuVwW
	l1443JzS3pNDvFJVy0e6W/cVy6z9sQTYZyb3BF77L1kUyiDawKdhW2cDlj+0ESryscqibtcjE3r
	/iWpBBGQiaiX/DNp2taSH83bf0wsFiWc=
X-Google-Smtp-Source: AGHT+IGRdHRfOBqF68wGNpCdbY57+Et1uig4AtfsE2R+6r7YVlp7kVvozhiOzKYCK5GaeeoF7QORl5Ok19qICcC1lzg=
X-Received: by 2002:a05:6820:6acf:b0:657:5723:76ce with SMTP id
 006d021491bc7-657572378e1mr3304690eaf.5.1763483848668; Tue, 18 Nov 2025
 08:37:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118.145942.1445519082574147037.rene@exactco.de>
In-Reply-To: <20251118.145942.1445519082574147037.rene@exactco.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 17:37:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h4sEBugBYe5G==pZc7ECkfEenD0v3SwkVFsst7mKLzxQ@mail.gmail.com>
X-Gm-Features: AWmQ_blyACvm2Dow1c5FWslEsu-p53vfzZoiMJ2LuCzLaleJGWEPk8rYNFujRFU
Message-ID: <CAJZ5v0h4sEBugBYe5G==pZc7ECkfEenD0v3SwkVFsst7mKLzxQ@mail.gmail.com>
Subject: Re: [PATCH] PNP: Fix ISAPNP to generetae uevent to auto-load modules
To: =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactco.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:59=E2=80=AFPM Ren=C3=A9 Rebe <rene@exactco.de> wr=
ote:
>
> Currently ISAPNP devices do not generate an uevent for udev to
> auto-load the driver modules for Creative SoundBlaster or Gravis
> UltraSound to just work.
>
> Signed-off-by: Ren=C3=A9 Rebe <rene@exactco.de>
> ---
> Tested for a while in T2/Linux already.
> ---
>  drivers/pnp/driver.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index 7de7aabb275e..05e9840bc3d4 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -150,6 +150,24 @@ static void pnp_device_shutdown(struct device *dev)
>                 drv->shutdown(pnp_dev);
>  }
>
> +static int pnp_uevent(const struct device *dev, struct kobj_uevent_env *=
env)
> +{
> +       struct pnp_id *pos;
> +       const struct pnp_dev *pnp_dev =3D to_pnp_dev(dev);
> +
> +       if (!dev)
> +               return -ENODEV;
> +
> +       pos =3D pnp_dev->id;
> +       while (pos) {
> +               if (add_uevent_var(env, "MODALIAS=3Dpnp:d%s", pos->id))
> +                       return -ENOMEM;
> +               pos =3D pos->next;
> +       }
> +
> +       return 0;
> +}
> +
>  static int pnp_bus_match(struct device *dev, const struct device_driver =
*drv)
>  {
>         struct pnp_dev *pnp_dev =3D to_pnp_dev(dev);
> @@ -259,6 +277,7 @@ static const struct dev_pm_ops pnp_bus_dev_pm_ops =3D=
 {
>  const struct bus_type pnp_bus_type =3D {
>         .name    =3D "pnp",
>         .match   =3D pnp_bus_match,
> +       .uevent  =3D pnp_uevent,
>         .probe   =3D pnp_device_probe,
>         .remove  =3D pnp_device_remove,
>         .shutdown =3D pnp_device_shutdown,
> --

Applied as 6.19 material with minor edits in the subject, thanks!

