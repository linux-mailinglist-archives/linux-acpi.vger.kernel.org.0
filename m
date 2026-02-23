Return-Path: <linux-acpi+bounces-21065-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMlMEXh2nGmwHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21065-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:47:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90931179000
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081B03043030
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910312FF144;
	Mon, 23 Feb 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjAJuDvk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3722FDC3D
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771861439; cv=none; b=SraSGUyLBXlaGUwsl+pnKOCzRxaMPXV+AHRTGNrYN5YUpvl7/6JFAvWI4MV06J1lkmEVY5H9VyURI20d6OYNa3vNOk4N/YavsPWbmz7zaE+4SUHTKyHxfN90U9Qfn3ZSmRYBx+eWdeC3TpCMFcQ79u02NNsZLv2k4t7htinNP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771861439; c=relaxed/simple;
	bh=8czFU0PFFNeLe2IHOwuuzhSptFPBTzYTIl1RudgyFRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJoreu6xJEv/ah4eyOQvpPwXmwfCMFp7WLamN2ZusQQNH7ncgsT3cXKbqY6P0rKVA7Gq/s1oPWxOj4+8s6SFxpyCaDTtyhiH6SpUZWqFH498ewDhQmWl9TQWXhfJGLYskplS0deteml+MO7XsBLQxDBtFCtsVJgD8K6MjDLWe88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjAJuDvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232D1C116D0
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771861439;
	bh=8czFU0PFFNeLe2IHOwuuzhSptFPBTzYTIl1RudgyFRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DjAJuDvkqNHSjOn5nNkghdD/i+xpyzQbKfobxta1Fspj06QC/r6NIotfXTWpbbtqf
	 KB85X4UvjVt0ntKC0R22jsyPGQQqsEe3bmgkcb32zWvz0Kwy64k80lBGiH9KCZWwFV
	 IoRWQmrFnM/RJLP27o97AXtky0yJtT7UoRI1dcvjDFC/9Ee92Ff9EWt0iOWoMpyP+p
	 lypThoJ9dw6pay2gOWC8w1eEZoY9JVAp8B8kDRAgJ/Ml43yu9GfUw9MAjtehvKvrGU
	 evKbrXtANRF1LsElAEE8WicMIrpgjjVfoLLZfbR7ykjzePK6QtzdSXMwrGKbbRqqbx
	 q0+EwA4fxBNRg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6786b13984fso2906128eaf.2
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 07:43:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHffsqm39fAwGwkfDSeVU0gmSPhugmpxxPYh2PCQTbDSD8BiYLKa7yD0g5HVTGCk9MOXoXfpg8pOCa@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf3SxTeqMevmPRFOgjtdWdxybIV8+BmK8DeEu44xGLpiPo1plb
	o20J7YAQOPQ8hu5aYICNN+/gUNjExkR+ljvxpBe5QAiUICwwATq3es7KqZksmlB4X2IEkJBWSk/
	ypGmOujHlQghAxLxDMvKoKKD+U6RoNtU=
X-Received: by 2002:a05:6820:2229:b0:668:d715:109c with SMTP id
 006d021491bc7-679c47082fcmr5113172eaf.65.1771861438273; Mon, 23 Feb 2026
 07:43:58 -0800 (PST)
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
Date: Mon, 23 Feb 2026 16:43:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hS2g5fBUs3_fnwCMahureKbUz0dvjF=ceqmWo1deSzTg@mail.gmail.com>
X-Gm-Features: AaiRm526O19x_rkXpkbBT67XI2NrKB_3flBkNcd2XNq78uzF7DQrf0MxaeBiifY
Message-ID: <CAJZ5v0hS2g5fBUs3_fnwCMahureKbUz0dvjF=ceqmWo1deSzTg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21065-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 90931179000
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

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

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
>  }
>
>  /**
>
> --
> 2.47.3
>
>

