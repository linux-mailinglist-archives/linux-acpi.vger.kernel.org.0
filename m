Return-Path: <linux-acpi+bounces-21091-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DyENm++nGlSKAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21091-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:54:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4B17D3E6
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AB1C30EA2A1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E518537880A;
	Mon, 23 Feb 2026 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhoaT+ij"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E8D378802
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879588; cv=none; b=ugCguSwlVv2EwHve4AJghcGS+/tCfU6gqk9pLi8SgRW/xhi6fLZJLebPgfon1pfbIL7YucYeaExqJoZyf6j4Vh/jRESOuHvrNZQcY2rsfMpFDzuKCmgfOSvrRkwTcoUT9sLojHzlsf9GORDuI7Zl+LvSR0qptV0P3zRKZ+7EzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879588; c=relaxed/simple;
	bh=jBLcyP02/sek7zk4NqxV5S1bZCQap/LZYHzTBfHrwTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjLAIG3k4tl/T5ol+NmZ2wLz2t43OFNe3CXu/AGAVXvUaAQs+HYgIopyorgqSV05MWZX2hoHZsHF/hBEs8jWhNvxf98pl9UDmxyRsmHOdC+LlCkbfLyMB95fMB8Fsv420lIFFfjLGhjofqUjnIL0WuqYfro04A/rvOFZ/wrDdFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhoaT+ij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ACDC4AF09
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771879588;
	bh=jBLcyP02/sek7zk4NqxV5S1bZCQap/LZYHzTBfHrwTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fhoaT+ij5oMRcYXaq+w8wFWGRoQwgDZeg5WYEVYFm995Dz5HH5fJI5bK+H2hK7N0O
	 P1rQhoYJqKAy0ya+CvvGpiSiqh+f91Yu1pZARCV5EHpmZDiOvpA7Xt3imYEeOSNbbL
	 sOiggXe7+97uwPLnyAxVmncmWLNGL5g6zdk/5FdU6027it/YLoSIOi3j0vSf3YsHr4
	 yJgTJuRCEJPUxBMBKINkpGpXAXN9B/2TNYLjji+JHPDA+l3ds0a+l5+AWwfNowMvCE
	 EtPEeM3jsaKisuJHd1LTeDs6KQDjTQEWC90jTQ4K3NP419zYGPe2z0++ZhN8lI9aBw
	 W3GiKZb3KsFNw==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-66ee7b9af94so1850251eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 12:46:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkWGL6u8D0R7AMipm7f8HwcLyjxbAwdowzOa8vgm7lWALiEw1sc3I4DufHR2+4zK0njp8JHTNC1we9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ExG2AyEJS81QalCdTHiVHKIyAu9SJMnjksXSMxR27Zkq/tSx
	EP2rke/HTwfe94ajKaLCaUn9gjd4VTpzUbzRKdW4Dpr3qC69IRtMQEAdT2Nwhtgy/ZuhmLsFdhu
	qQHWPPNYL7NAnwaUHOiPj9SWCIchTet4=
X-Received: by 2002:a05:6820:460a:b0:679:8b1d:ba00 with SMTP id
 006d021491bc7-679c470f3f0mr3886821eaf.55.1771879587668; Mon, 23 Feb 2026
 12:46:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 21:46:16 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hgjGinrM_SMTAv27No=b__HUQ-9W18rHzNNiM-TnpQmA@mail.gmail.com>
X-Gm-Features: AaiRm51MQYy4860EILV63_T3N_-5AgKrlcj9pG9QN8uuwuEr3GzncbmkDDBN4X0
Message-ID: <CAJZ5v0hgjGinrM_SMTAv27No=b__HUQ-9W18rHzNNiM-TnpQmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21091-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Queue-Id: 88A4B17D3E6
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 4:41=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> In GPIOLIB, during fwnode lookup, after having resolved the consumer's
> reference to a specific fwnode, we only match it against the primary
> node of the controllers. Let's extend that to also the secondary node by
> reworking gpio_chip_match_by_fwnode()
>
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/gpio/gpiolib.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index c52200eaaaff82b12f22dd1ee8459bdd8ec10d81..7fe1d9ab1281d6c5022b9bdd8=
909fef2cb74122e 100644
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
> +       return fwnode_is_primary(node) && node->secondary =3D=3D fwnode;

Actually, you can replace the above statement with

      return node && node->secondary =3D=3D fwnode;

because fwnode_is_primary(node) expands to (node &&
!IS_ERR(node->secondary)), but since you compare node->secondary to
fwnode, the IS_ERR() check on it is redundant (fwnode is known to be
non-error already at this point).

That would allow you to avoid exporting fwnode_is_primary() (which is
kind of useful given the review comments).

>  }
>
>  /**
>
> --

