Return-Path: <linux-acpi+bounces-21155-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPW2OrHunmk/XwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21155-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 13:44:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BDE197871
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 13:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B8D443025E19
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 12:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B683B8BBB;
	Wed, 25 Feb 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juljAskH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1D3B8BB4
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023464; cv=none; b=Eu+9XAyr9xKirKXsUkVOlx0hw45fNDzke93akW0S/SH3fNAg/yNRhbWhieZzbeGsDvmJK43qMitcqSmr/hHaL5Tqwf1f+aaoSmu3nn7k/dXPtU0YZVw32aqqJfPijmCl/gVPdUXfPTdQEfd8zf3caQc182LpOXYZffcAIw01MVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023464; c=relaxed/simple;
	bh=0c26n0WNIysPuIx6eQZ1sQxY8cPMIhbeuo2iuZHdRd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nl+yyck6csbVAUjuiasmRcSWXRufTySNNvVmqKUvR/Knd+OWqRjWf+KbWMudDCrlDZOgabo2reUcGdOS0SpnRFt3yMC8cSW6BxdbOFi7I/f7ZA6yIm1qSh3CHKoAjTR0DBFtvlgkoxDRSvQXVV4H/YYQqr+93/ytR0iia5X7340=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juljAskH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1FFC2BCB2
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772023463;
	bh=0c26n0WNIysPuIx6eQZ1sQxY8cPMIhbeuo2iuZHdRd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=juljAskHr3ty9TGTKUzzURf5muokH5kXH1l7Wo7BlzUS4y2zA7Bl9Qyp+qWxcjfl+
	 62wf67MUPGdtNHKfEIN8Pz9eUbB1ZzWJ8iD4C5l1ZOP1HijG6vVBdgi1f8Zx8XIrrI
	 wOorW3Cx1h/d7W+9amN9ZvsELzRRxgqL5cC3tOAzbtFtKbKR3ei1z7cvic/qwAVsI8
	 /mm4qA4AYE0a5NYU7ri+611KyxPSP5NXoBE3rvc077zZKS5sDKHa+aGJg7jPQIIK9H
	 Mj/GOFZo6PoRqPFBu7B5GiyHrocuiDcwk8AdrxCvWnJJSpRgWK5A18hkYAsp3R5aL3
	 v5TuBpNbMaz8A==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f09874c4cso4121734b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 04:44:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5T0Iyme2PjgTXv+911Dory757up0Y+dj/Q8rsTsAXOXAngrN9QYpBKsi1mvUdd9grreQ83tOEJmKR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3b4YTcI+qxNM9TIsyn2Kzqu/uzPnCn+5ig6O//oDLTJbHSJjG
	p9n3TIeYDVOLRPSp3tnv5Pm3LCOm6yRZQoFJy3r4svhz1a6EeKzIrEu6Oqql5BdtMkaOykybVoa
	K/va0wmu9tH/H5fbJ2uXbRQ6xYnXz3DE=
X-Received: by 2002:a05:6871:378b:b0:40e:dadc:49f5 with SMTP id
 586e51a60fabf-4157b20bc21mr9023562fac.51.1772023462839; Wed, 25 Feb 2026
 04:44:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
 <CAJZ5v0j0-7WPVY_YYHyjNZenBAaXD1awLHq-cKmLKce4hw-7Uw@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0-7WPVY_YYHyjNZenBAaXD1awLHq-cKmLKce4hw-7Uw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 13:44:10 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jf-S-=H7Dyan0aBhOX5jeg-UNgg_P-Lh46SWHH+Z2fDQ@mail.gmail.com>
X-Gm-Features: AaiRm51tLDyRlI4KH_mdkjIcxnVZmFU3vH8x5MnqtIIsDiZDmKGhfdt63ODV6wY
Message-ID: <CAJZ5v0jf-S-=H7Dyan0aBhOX5jeg-UNgg_P-Lh46SWHH+Z2fDQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21155-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
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
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 97BDE197871
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Feb 25, 2026 at 11:12=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@oss.qualcomm.com> wrote:
> >
> > In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> > reference to a specific fwnode, we only match it against the primary
> > node of the controllers. Let's extend that to also the secondary node b=
y
> > reworking gpio_chip_match_by_fwnode()
> >
> > Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> > Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.co=
m>
> > ---
> > Link: https://lore.kernel.org/all/aZUIFiOYt6GOlDQx@google.com/
> > ---
> > Changes in v3:
> > - Remove the controversial patch 1/2 in favor of hand-coding its
> >   functionality in patch 2/2
> > - Link to v2: https://patch.msgid.link/20260223-device-match-secondary-=
fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com
> >
> > Changes in v2:
> > - Fold the code initially put into driver code into GPIOLIB as advised
> >   by Rafael
> > - Rework the logic as suggested by Andy
> > - To that end: make fwnode_is_primary() public
> > - Link to v1: https://patch.msgid.link/20260219-device-match-secondary-=
fwnode-v1-0-a64e8d4754bc@oss.qualcomm.com
> > ---
> >  drivers/gpio/gpiolib.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..0182603de368f2125baf174=
fcf5f1e893917c154 100644
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
> > -       return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > +       struct device *dev =3D &gc->gpiodev->dev;
> > +       struct fwnode_handle *node =3D dev_fwnode(dev);
> > +
> > +       if (IS_ERR(fwnode))
> > +               return 0;
> > +
> > +       if (device_match_fwnode(dev, fwnode))
> > +               return 1;
> > +
> > +       return node && !IS_ERR(node->secondary) && node->secondary =3D=
=3D fwnode;
>
> The second check is redundant because fwnode cannot be an error
> pointer (it has been checked against that already above) and so if
> node->secondary =3D=3D fwnode, then node->secondary is not an error
> pointer.
>
> I'm not sure if fwnode can be NULL here, but if it can, it should be
> checked against NULL.  Alternatively, node->secondary can be checked
> against NULL and compared to fwnode.
>
> So, if fwnode !=3D NULL cannot be guaranteed,
>
>         return fwnode && node && node->secondary =3D=3D fwnode;
>
> or
>
>         return node && node->secondary && node->secondary =3D=3D fwnode;
>
> The overhead of the former may be a bit lower because it avoids
> dereferencing node when fwnode is NULL, but the compiler should be
> able to optimize this anyway.

Or even the device_match_fwnode() check can be folded into the last line:

static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fwno=
de)
 {
-       return device_match_fwnode(&gc->gpiodev->dev, fwnode);
+       struct device *dev =3D &gc->gpiodev->dev;
+       struct fwnode_handle *node =3D dev_fwnode(dev);
+
+       if (IS_ERR_OR_NULL(fwnode))
+               return 0;
+
+       return node =3D=3D fwnode || (node && node->secondary =3D=3D fwnode=
);
 }

