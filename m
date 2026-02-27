Return-Path: <linux-acpi+bounces-21236-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAxIJvjMoWn3wQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21236-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 17:57:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2D1BB164
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CA9D300D0F5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717123563C2;
	Fri, 27 Feb 2026 16:57:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BE348452
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211441; cv=none; b=WdpaHLCEg/3/bQqpvGlg8fcct/KjcYw4NCDDjS51WMb2xohu150f2rB1dA8sKC4aB6udIg3M9bnJUPqCbQRR6pJ8FmlyiViKdOTA/kKvpKBy9u3A1W9PlJyvzINpHtTslgXX/w50DeIx0hW1CYNw90bvJ7i6ZsK9FqELtAaYIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211441; c=relaxed/simple;
	bh=8QooufOo4pPMQ94Tm+1S+IKUXQJzBKWDChzX4qil09A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwA0rLHkBoISTCvJNRPcWnTRVH1d+tpoxEd2sw9gHj8dyaVFCqTHmTUowFMTcsTzMFbfXUOvrieVvo9W32TIBag/UBf6JXGbjLlIV01jEI/LxzxnrveW44N8s/mU0HoaRozHxuOurxgZRJRGl7LMgN49ZeUoynWzMqpzXAzF3Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adbd435864so8971035ad.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 08:57:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772211439; x=1772816239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AIGPgG8NajjCLfKfqfkEsLDhUiGu4xrfbhUgqAmvE/8=;
        b=PvDXLiHQuA83wmCYWHDvSzs6F3ZmS52dnBmak7+pg1P2xrpD8VkBCMH8aU47OYnz0d
         ykkNCYtsSYAQS9SB0kekQDXsNNZmpOGu74CkoHXtIKQ9wOAWH3qPI9wEYm4B3c2BSLo4
         JPaTTUPzrQvboVViYc0l1VqDIZ2xaR5DdG3TP2bTeKT4MM/mWcvYawlFFXWTHDXa6uee
         Uq/tO9g1k+6T09q4tQs70xpAbM12jUzYO+gou8wDnPGnHzOglm+oHVBUMW289A73W2Us
         YkE74KU1Yp6QkwWn8Tcl0LZgHd9nt0NcBxcWlzi7ZuabTxzE3uSStuPC/R2EDM8RUL6e
         q3/w==
X-Forwarded-Encrypted: i=1; AJvYcCUBseAvU8S+2rIMqzBvkIlzqngmfSxhMs8cgZKBHrCPyaSVKrYHLl8jwe6yBqhlGP7SaAXOhODuwOYG@vger.kernel.org
X-Gm-Message-State: AOJu0YzvU4HceE3n1TnFjzdi3A5kKrIbYK/FWy9PPvdkrVBbXzf8E0sK
	QVq6zVrl+UqcVkcdqQOmT1bSyUuQPpPZNAtWQEWdkiDGTx2rbzlRMYqouj8TpD2Wkaw=
X-Gm-Gg: ATEYQzyBOD2zSlChTZuMY6AxJx8WO2J21HVdpaLZuvIQkAwjj5DUUCoSE1NUaomBznV
	G/3De6XPVcrJY1IklZhzgE2AreyvOPvUId7lGwY/zw8BNFY6nFIV2rBZ4e39KevViH/WmsOByHH
	K58AVUArL6/Dcjwz1J51hwSuvrBJwXs/490vwYzYlckzZ+HynJQ+rFG+IMGh3AKyD9QOGKoGkoC
	2yWISjbQfPYxPhvKy0GVXhDoG4iTNBr4HDHlWPnPc/qZn2n9EB+IOXAkEkDOrezD0FinjzzR0qk
	v5WOWB4czYRVyG9Ar0QjoR3i7CmRCgqLhnnhlva7cgpC1q/UVi+FPe0jiGGw4Z9aZ+rWMIfyN0t
	9BZAcZiVOefjc/yKvxUIXUp/iAYQ/2ZCnDNZGkMvif59JcB5dvB/DsG4949I9b+zZMwOK4FhqFB
	XUJVfIqNf/UfmqRVStI1EUdB943jma20Cd01aYPOI3QUE3szNj3alsKYHQOypimMk=
X-Received: by 2002:a17:903:2f0f:b0:2aa:e3ba:d045 with SMTP id d9443c01a7336-2ae2e3ede7fmr24730375ad.8.1772211439443;
        Fri, 27 Feb 2026 08:57:19 -0800 (PST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com. [74.125.82.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b1035sm89461855ad.7.2026.02.27.08.57.18
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 08:57:18 -0800 (PST)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdcd7f0222so3142831eec.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 08:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcq7DMliV81Fox6MCEPzv1qmJRyqWIkgtQwBjTlonp427aA6ZutdYcb+bMFUuvVgyg9Yd1z8zvdVKh@vger.kernel.org
X-Received: by 2002:a05:6102:c01:b0:5f5:33c9:c9b3 with SMTP id
 ada2fe7eead31-5ff32536408mr1676835137.29.1772211026292; Fri, 27 Feb 2026
 08:50:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-4-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-4-herve.codina@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2026 17:50:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUAHXNbGfJFcUMQbzPqRS0S_RErU8u7t=AdmX0ZFQMjhQ@mail.gmail.com>
X-Gm-Features: AaiRm53ZqgozcqNHytSHwR_CUbVuY8sQSeRMANHqThlNEOeyZsxQir9SPbAYLBo
Message-ID: <CAMuHMdUAHXNbGfJFcUMQbzPqRS0S_RErU8u7t=AdmX0ZFQMjhQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/28] of: dynamic: Fix overlayed devices not probing
 because of fw_devlink
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Niemi <kaleposti@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linusw@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,microchip.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-21236-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[63];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-m68k.org:email,mail.gmail.com:mid,glider.be:email,bootlin.com:email]
X-Rspamd-Queue-Id: C4A2D1BB164
X-Rspamd-Action: no action

Hi Herv=C3=A9,

On Fri, 27 Feb 2026 at 14:56, Herve Codina <herve.codina@bootlin.com> wrote=
:
> From: Saravana Kannan <saravanak@google.com>
>
> When an overlay is applied, if the target device has already probed
> successfully and bound to a device, then some of the fw_devlink logic
> that ran when the device was probed needs to be rerun. This allows newly
> created dangling consumers of the overlayed device tree nodes to be
> moved to become consumers of the target device.
>
> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays")
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJgyo8=
x6=3D9F9rZ+-KzjOg@mail.gmail.com/
> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.com/
> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Link: https://lore.kernel.org/lkml/20240411235623.1260061-3-saravanak@goo=
gle.com/
> [Herve: Rebase on top of recent kernel and use get_device_from_fwnode()]
> [Herve: Add the call to driver_deferred_probe_trigger()]

Thanks, that last change did the trick, finally!

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -235,6 +235,79 @@ static void __fw_devlink_pickup_dangling_consumers(s=
truct fwnode_handle *fwnode,
>                 __fw_devlink_pickup_dangling_consumers(child, new_sup);
>  }
>
> +static void fw_devlink_pickup_dangling_consumers(struct device *dev)
> +{
> +       struct fwnode_handle *child;
> +
> +       guard(mutex)(&fwnode_link_lock);
> +
> +       fwnode_for_each_available_child_node(dev->fwnode, child)
> +               __fw_devlink_pickup_dangling_consumers(child, dev->fwnode=
);
> +       __fw_devlink_link_to_consumers(dev);
> +}
> +
> +/**
> + * fw_devlink_refresh_fwnode - Recheck the tree under this firmware node
> + * @fwnode: The fwnode under which the fwnode tree has changed
> + *
> + * This function is mainly meant to adjust the supplier/consumer depende=
ncies
> + * after a fwnode tree overlay has occurred.
> + */
> +void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode)
> +{
> +       struct device *dev;
> +
> +       /*
> +        * Find the closest ancestor fwnode that has been converted to a =
device
> +        * that can bind to a driver (bus device).
> +        */
> +       fwnode_handle_get(fwnode);
> +       do {
> +               if (fwnode->flags & FWNODE_FLAG_NOT_DEVICE)
> +                       continue;
> +
> +               dev =3D get_device_from_fwnode(fwnode);
> +               if (!dev)
> +                       continue;
> +
> +               if (dev->bus)
> +                       break;
> +
> +               put_device(dev);
> +       } while ((fwnode =3D fwnode_get_next_parent(fwnode)));
> +
> +       /*
> +        * If none of the ancestor fwnodes have (yet) been converted to a=
 device
> +        * that can bind to a driver, there's nothing to fix up.
> +        */
> +       if (!fwnode)
> +               return;
> +
> +       WARN(device_is_bound(dev) && dev->links.status !=3D DL_DEV_DRIVER=
_BOUND,
> +            "Don't multithread overlaying and probing the same device!\n=
");
> +
> +       /*
> +        * If the device has already bound to a driver, then we need to r=
edo
> +        * some of the work that was done after the device was bound to a
> +        * driver. If the device hasn't bound to a driver, running thing =
too

things

> +        * soon would incorrectly pick up consumers that it shouldn't.
> +        */
> +       if (dev->links.status =3D=3D DL_DEV_DRIVER_BOUND) {
> +               fw_devlink_pickup_dangling_consumers(dev);
> +               /*
> +                * Some of dangling consumers could have been put previou=
sly in
> +                * the deferred probe list due to the unavailability of t=
heir
> +                * suppliers. Those consumers have been picked up and som=
e of
> +                * their suppliers links have been update. Time to re-try=
 their

updated

> +                * probe sequence.
> +                */
> +               driver_deferred_probe_trigger();
> +       }
> +
> +       put_device(dev);
> +       fwnode_handle_put(fwnode);
> +}
> +
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

