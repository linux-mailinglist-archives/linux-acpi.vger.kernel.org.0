Return-Path: <linux-acpi+bounces-12834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C83A7F07D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 00:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AC91896BEA
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 22:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36A922E41B;
	Mon,  7 Apr 2025 22:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRWrO/4Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB422D7BB
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066321; cv=none; b=D7EZc1PEhEvdJRD0i6btdGC3U9gKapZdX6mIMEjsZ/j2T7XX1iLwYsfkwn4GWF4jkZmZm6oFWeuj5EJmhtRr8/L1q74/AhqjM0EsJBAx4vWBQVTXOcf7cQkIeFmK1FW6U3bjlLG8gg5hvOU7LymrCY5g44DkK9GtmSZ3NtBoTkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066321; c=relaxed/simple;
	bh=xk6+GuIlJyPcOF97rvioGdrmfsj08TuNFKPTnNBPVcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1w1LTK1o3OhxXhhxAe3u3HewR22bS9l2AH3ydXVH/SHItrRn/O4v38LY0yT37N3h7Nkr9HMzN/dvNVlRXMamjjEIjb7Tf+4oUXq6LuBAVx2jtfTBVENm38CxhAt263uGMMTRm2yuMoDcWlUGMbEUCgdoRPc7mlzwAGgCGkq1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aRWrO/4Q; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54ac9b3ddf6so4599553e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 07 Apr 2025 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744066317; x=1744671117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T1LuFxtlhisA25vk0GSN9ZyiZy+KSvd4XC01LmHfFI=;
        b=aRWrO/4Q9E4B0MNV+tJKgfo9c9heW7lRog8Dc85lAt5PytYH9yVgaLSJ+2qDRt4KGm
         8OHXremBWnjJ1+157nNns7Ss+EVGQWY51xx6+cpN3mmrrsyi4Wa8zRov9sMH2Hf0aAFh
         VOFxk+MX7NWBjG7VjxFwyY1CbBAN/ECmx48JoYc24LvN+FKVg0Z3fg9NGh2pa69rTMd7
         2YYWAzjIZTEHwxkaGfYgYKO0KMoS6els9B8aI8cNAIutbOs+/ki5kbnZ+TWununInGzP
         TPQ67+bHOaw5ApwHDMSxJ39IfblFdPzcpcjbfEOQNwpYYDeIYJCv57ss741AaAU+XHF2
         3RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744066317; x=1744671117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9T1LuFxtlhisA25vk0GSN9ZyiZy+KSvd4XC01LmHfFI=;
        b=Nhy7UPOMRVmUjEtoY8Gul4S1UC3x6g/xSUk+9JvEkjuzW2KYsUxGdf4sTkFJJT++Ut
         Xh08IZvUFn3LJKshOmUVsLJeEAaB/R0sMeyC/h92ccAIe1f4j3vlUEI47BFolukpsrEe
         qg7krbLVULeBG/mWOTfGf+TsP1DLvfU/zfA7QCvBq/8F8oK3IbiqHtteqRxMifD6aYeN
         CBDchGd5eGK2h6FWb7bO3UE20SJl5vrX/P4GSozLi/Ial9fDHnbY6wqsAtmtu1PExHhR
         crQEWcff34NmNzkZYbCatCW/tXvMB1IzxRrOuDG/+NVN2lLCmq/t6fGIz5HUJ7e3OtSC
         CZbg==
X-Forwarded-Encrypted: i=1; AJvYcCXVtpo44oUAmDcdiEvKv7WZ7c6PvLlmnzOqCIhoxw01GUXuFc3APgb/bMrCxsVkuTu5IR0Sc1YogA3+@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjIR8DjemD2+BT0e/L1x902YNBJTkB+KFuCFXf9UssoI/RoOL
	0vCSYoz/hy+ZI4r0t/SAjGeixDhcST5Uhhgg8eobUltFMJex5TeQIpiZmcV2oSelE/9uSBi5swM
	e0Uy97M3WQF4o1v8Z/qJFZQQmVHYHtMO9WrTs
X-Gm-Gg: ASbGncsmCEc1fsa0D4TzR8esi0j+UaDnGM/9k+C9+qZ79FCGYsDoKIujG07/pem4/z7
	H+Z26aG0HSzf0YP0yq90fJxBVl3gGIT0WmbQU/Ehbe+qnXic1PwbvFWmGf+Blg4UqJ1/GTn+RPW
	5xvBMsB9L+UmiFZQ9QzekvQWJG8sBk6KkiJ+0=
X-Google-Smtp-Source: AGHT+IGZy1cH5XFvxf4qYN6nMiZKkGDS0+s79ElF1xv6IXDDdsnr740VlwJkyiHI3RPM0cEI5hC/q03/uRkTb7Y8OD0=
X-Received: by 2002:a05:6512:2341:b0:549:86c8:113a with SMTP id
 2adb3069b0e04-54c297d0929mr2593762e87.15.1744066316436; Mon, 07 Apr 2025
 15:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407145546.270683-1-herve.codina@bootlin.com> <20250407145546.270683-3-herve.codina@bootlin.com>
In-Reply-To: <20250407145546.270683-3-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 7 Apr 2025 15:51:20 -0700
X-Gm-Features: ATxdqUHzf_3trxjbd35DyDptpEJ-bBNCqGhzKGi2OGpUI_J2cUir_Gap-o-BFA4
Message-ID: <CAGETcx81G7Bk3AswqGu1hoybuGL1znN7gvX5+baJurfWFx+xuA@mail.gmail.com>
Subject: Re: [PATCH 02/16] driver core: Rename get_dev_from_fwnode() wrapper
 to get_device_from_fwnode()
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Wolfram Sang <wsa@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:56=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:
>
> get_dev_from_fwnode() calls get_device() and so it acquires a reference
> on the device returned.
>
> In order to be more obvious that this wrapper is a get_device() variant,
> rename it to get_device_from_fwnode().
>
> Suggested-by: Mark Brown <broonie@kernel.org>
> Link: https://lore.kernel.org/lkml/CAGETcx97QjnjVR8Z5g0ndLHpK96hLd4aYSV=
=3DiEkKPNbNOccYmA@mail.gmail.com/
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thank you!

Reviewed-by: Saravana Kannan <saravanak@google.com>

> ---
>  drivers/base/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d2f9d3a59d6b..f30260fd3031 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1881,7 +1881,7 @@ static void fw_devlink_unblock_consumers(struct dev=
ice *dev)
>         device_links_write_unlock();
>  }
>
> -#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
> +#define get_device_from_fwnode(fwnode) get_device((fwnode)->dev)
>
>  static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
>  {
> @@ -1891,7 +1891,7 @@ static bool fwnode_init_without_drv(struct fwnode_h=
andle *fwnode)
>         if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
>                 return false;
>
> -       dev =3D get_dev_from_fwnode(fwnode);
> +       dev =3D get_device_from_fwnode(fwnode);
>         ret =3D !dev || dev->links.status =3D=3D DL_DEV_NO_DRIVER;
>         put_device(dev);
>
> @@ -1960,7 +1960,7 @@ static struct device *fwnode_get_next_parent_dev(co=
nst struct fwnode_handle *fwn
>         struct device *dev;
>
>         fwnode_for_each_parent_node(fwnode, parent) {
> -               dev =3D get_dev_from_fwnode(parent);
> +               dev =3D get_device_from_fwnode(parent);
>                 if (dev) {
>                         fwnode_handle_put(parent);
>                         return dev;
> @@ -2016,8 +2016,8 @@ static bool __fw_devlink_relax_cycles(struct fwnode=
_handle *con_handle,
>                 goto out;
>         }
>
> -       sup_dev =3D get_dev_from_fwnode(sup_handle);
> -       con_dev =3D get_dev_from_fwnode(con_handle);
> +       sup_dev =3D get_device_from_fwnode(sup_handle);
> +       con_dev =3D get_device_from_fwnode(con_handle);
>         /*
>          * If sup_dev is bound to a driver and @con hasn't started bindin=
g to a
>          * driver, sup_dev can't be a consumer of @con. So, no need to ch=
eck
> @@ -2156,7 +2156,7 @@ static int fw_devlink_create_devlink(struct device =
*con,
>         if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
>                 sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
>         else
> -               sup_dev =3D get_dev_from_fwnode(sup_handle);
> +               sup_dev =3D get_device_from_fwnode(sup_handle);
>
>         if (sup_dev) {
>                 /*
> @@ -2225,7 +2225,7 @@ static void __fw_devlink_link_to_consumers(struct d=
evice *dev)
>                 bool own_link =3D true;
>                 int ret;
>
> -               con_dev =3D get_dev_from_fwnode(link->consumer);
> +               con_dev =3D get_device_from_fwnode(link->consumer);
>                 /*
>                  * If consumer device is not available yet, make a "proxy=
"
>                  * SYNC_STATE_ONLY link from the consumer's parent device=
 to
> --
> 2.49.0
>

