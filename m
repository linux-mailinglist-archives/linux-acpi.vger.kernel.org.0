Return-Path: <linux-acpi+bounces-21154-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J+TBpPtnmk/XwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21154-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 13:39:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 921951977BA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 13:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F92330156F6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Feb 2026 12:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB213AEF31;
	Wed, 25 Feb 2026 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPj70cE8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87E0314B82
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023016; cv=none; b=ovuCB3wzvrUoIxrXlKem+SLDAT8T81zAK+KhCV7S/XjuNPTBmKInCNFPJJ7H1DH/aQRePUv6IgfOZpZKVMrDCXzJxcvHLGfRcL5kRZaqdIIpENC+9QRQuO772h51z62809Zr3IuIAtorMwHnoAFkXm/IXF+qzI8D8ZB6MAOKY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023016; c=relaxed/simple;
	bh=ys+lM9za/S8tV1qWNG+rgOUZ/znrJDuCZYoVDFKdLEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9DikwHxbWNfUOUPQkgmv+WjHwWZurYgNT46Bqlg0uHwkC/U0AQLA4aVFguzJXB7fIZ9z5iNscZkdq5tP1e9R5zG43f2dXHzE6UhAgTpVgN+J47gqEoSNXtLD+2QOJfv0ZHpdIloSg78mKOZzPkdZagWzLdvPHm44DSIb3FRPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPj70cE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F754C2BCB6
	for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772023016;
	bh=ys+lM9za/S8tV1qWNG+rgOUZ/znrJDuCZYoVDFKdLEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cPj70cE8b+Mx7Qd9X2ePqctdQ80/Y3CnXgU9jC20YT+7DDLI7xsFb/z2nsn354dyh
	 2UqGEYwC66y8SPBfVej+S5+D95CqRkiE7o2Sa6AEYJ9HOlHpF7MV8ZE1t9Vm8zkXHl
	 ujJDxtVgpkmkPrZHoUqyZwnQha2sCeH7V7pUpRXetNeZPsDQsCpWqXZeCJSQZh5Tv/
	 Q/QcOpJyvCm2JWIonW89S3dAbsQS6MHAjShLQMDCEB1JTD6g3W5fs60o7SYuXt8wNk
	 w05J/cp/luCpnEZ0m9HnjwOgtdDmJ735IQqEL3FlLTRJUF2HT30g4MEACUaSCMlxCL
	 qF8qQxDMCcG9Q==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d55b97f358so2018822a34.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Feb 2026 04:36:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW87AOAWG6hsC3VV7h7nmEaDnfWK0sB4uAcLX/FNwq8t6SGn7FGYCYqfz9ALj1S8yAMwFJk6C7vcb9f@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlVW4wvrys8zZd0g7QNW2DlD0ZGoxRxqTEuPb47tyjBBoUBuV
	UqLZqMLBq+tvqm/JncLbw6OP9hE3VTIQt5hAANrL1mdDlExV5w1p1MDFnb/5Iczx34fEkmQOjzb
	tAes4uJIXJClTzGpzkv7eepD+2uM9494=
X-Received: by 2002:a9d:674f:0:b0:7d1:4e51:e45 with SMTP id
 46e09a7af769-7d52bf21af6mr6867368a34.17.1772023015158; Wed, 25 Feb 2026
 04:36:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
In-Reply-To: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Feb 2026 13:36:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j0-7WPVY_YYHyjNZenBAaXD1awLHq-cKmLKce4hw-7Uw@mail.gmail.com>
X-Gm-Features: AaiRm520JHKw59KokRQvousTGYEMytk7jYZmYqpbefE5Ka3VQglTfNfF40UHlyI
Message-ID: <CAJZ5v0j0-7WPVY_YYHyjNZenBAaXD1awLHq-cKmLKce4hw-7Uw@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21154-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 921951977BA
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 11:12=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> reworking gpio_chip_match_by_fwnode()
>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Link: https://lore.kernel.org/all/aZUIFiOYt6GOlDQx@google.com/
> ---
> Changes in v3:
> - Remove the controversial patch 1/2 in favor of hand-coding its
>   functionality in patch 2/2
> - Link to v2: https://patch.msgid.link/20260223-device-match-secondary-fw=
node-v2-0-966c00c9eeeb@oss.qualcomm.com
>
> Changes in v2:
> - Fold the code initially put into driver code into GPIOLIB as advised
>   by Rafael
> - Rework the logic as suggested by Andy
> - To that end: make fwnode_is_primary() public
> - Link to v1: https://patch.msgid.link/20260219-device-match-secondary-fw=
node-v1-0-a64e8d4754bc@oss.qualcomm.com
> ---
>  drivers/gpio/gpiolib.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..0182603de368f2125baf174fc=
f5f1e893917c154 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -11,6 +11,7 @@
>  #include <linux/errno.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/fwnode.h>
>  #include <linux/idr.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -1395,7 +1396,16 @@ EXPORT_SYMBOL_GPL(gpio_device_find_by_label);
>
>  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *f=
wnode)
>  {
> -       return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> +       struct device *dev =3D &gc->gpiodev->dev;
> +       struct fwnode_handle *node =3D dev_fwnode(dev);
> +
> +       if (IS_ERR(fwnode))
> +               return 0;
> +
> +       if (device_match_fwnode(dev, fwnode))
> +               return 1;
> +
> +       return node && !IS_ERR(node->secondary) && node->secondary =3D=3D=
 fwnode;

The second check is redundant because fwnode cannot be an error
pointer (it has been checked against that already above) and so if
node->secondary =3D=3D fwnode, then node->secondary is not an error
pointer.

I'm not sure if fwnode can be NULL here, but if it can, it should be
checked against NULL.  Alternatively, node->secondary can be checked
against NULL and compared to fwnode.

So, if fwnode !=3D NULL cannot be guaranteed,

        return fwnode && node && node->secondary =3D=3D fwnode;

or

        return node && node->secondary && node->secondary =3D=3D fwnode;

The overhead of the former may be a bit lower because it avoids
dereferencing node when fwnode is NULL, but the compiler should be
able to optimize this anyway.

>  }
>
>  /**
>
> ---

