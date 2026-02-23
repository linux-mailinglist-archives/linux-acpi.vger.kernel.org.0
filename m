Return-Path: <linux-acpi+bounces-21072-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKigNGiTnGnRJQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21072-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:50:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FC17B13D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D97D330C03D0
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 17:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E61338905;
	Mon, 23 Feb 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV1a1J+3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B2338599
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868813; cv=none; b=UPytBrabqgQYOh9AFIC4Kxene0aYPwmLND409Lfz4FzKENLXpBToT+hifVPFqIjNvH1Ho8YQfDpwGp3TjIYYqwepUxgDiuCECvMtoD75uVdeZVutrj7H8XgAS32qHHZ+mDRpAahsINn3fdKGCbVpAVsjy9GOloptzZiSiav4wiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868813; c=relaxed/simple;
	bh=Xs/2dCF6dfNmiAQ9dUHgxwVqt3IYoGpB9IhENpi8NeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yxk8tuncJxcvr7NU9E+F3FsPSmDtu5be+VhapU+JvkcTPZDI5SRWHYHKOOxu77p8hd7BxwNITDlo5Ur0b8El5zaaKmQrnUa0BNjuzxVgOueHZmKpHudLgXXlOvlD14AVnSVa0HX46qhFI+tlh9/3YIJkW/RKVhYTc4vk5AaTK1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV1a1J+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13647C2BCB3
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771868813;
	bh=Xs/2dCF6dfNmiAQ9dUHgxwVqt3IYoGpB9IhENpi8NeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rV1a1J+3SktxDZmsdkrfZMalH1UDeMzsyhdLvBldoCfiKWasZMFlbAqzPObyNPhiU
	 UBoQjqdNSnEk3lpCd5+3L57siC3e0dyEnIOPP3X6cA6ntdCK3KAK0BbrnRJTWb10iI
	 mD0xugZW8c00VWxLbkubefqVnSDdVw6ZgZp+7dK2YiCZSlh3jXqb35AbBDLerazyLb
	 1VAMlSnJ/bTdUA1XKhJzT7xBhn3ET5alt4ICwwDvMHttlLGz6JIb+o3G39Zc1Gmuh9
	 HfbXLRK536sCd6T+MTpto9KnFBzOSZtu7jEiIpfFmb/tRh5uAbS8ET1A9X2QKlvEI8
	 fGY0Bk2ddaASg==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4c3484268so3295997a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 09:46:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU56gWKdYMh7afOJ/oK38kHYYJVHA7yGZ6Vdaf6ujSiiBZwlRmHkj5vJsyrsDEuST+rEDEKJcTA/ydY@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4csxBFEa18JGjMxqmH0CGodUg9Dm4/XPq5UNCt1K3GSOxP1z
	fMHurEy4Ot5JX57wJmlhbmkKx+GmowgzUEIpM+L9JabIRWqRH86B/y6xQUn0QVqH2F/eJYKyVoh
	gPfFunEkxJQoK+d066yKAuBxVI0oBRC0=
X-Received: by 2002:a05:6830:81ec:b0:7c7:69d9:d8d3 with SMTP id
 46e09a7af769-7d52be3dd2dmr6849786a34.12.1771868811975; Mon, 23 Feb 2026
 09:46:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com> <aZyNErXB_acR3yYq@kekkonen.localdomain>
In-Reply-To: <aZyNErXB_acR3yYq@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 18:46:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
X-Gm-Features: AaiRm52BHYNejRlIW4MdwAWerx8BNv8zmwaIDweVIu1LcRtEBbkHGLfTRmgAa2A
Message-ID: <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21072-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 272FC17B13D
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 6:23=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Bartosz,
>
> Thanks for the patch.
>
> On Mon, Feb 23, 2026 at 04:40:53PM +0100, Bartosz Golaszewski wrote:
> > In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> > reference to a specific fwnode, we only match it against the primary
> > node of the controllers. Let's extend that to also the secondary node b=
y
> > reworking gpio_chip_match_by_fwnode()
> >
> > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
> >  drivers/gpio/gpiolib.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..7fe1d9ab1281d6c5022b9bd=
d8909fef2cb74122e 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/fwnode.h>
> >  #include <linux/idr.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > @@ -1395,7 +1396,16 @@ EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
> >
> >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void =
*fwnode)
> >  {
> > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > +     struct device *dev =3D &gc->gpiodev->dev;
> > +     struct fwnode_handle *node =3D dev_fwnode(dev);
> > +
> > +     if (IS_ERR(fwnode))
> > +             return 0;
> > +
> > +     if (device_match_fwnode(dev, fwnode))
>
> Could device_match_fwnode() match secondary fwnode as well?

In the previous discussion on this, Andy was against doing that due to
the concern that it might introduce subtle bugs, which I agree with.

