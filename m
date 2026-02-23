Return-Path: <linux-acpi+bounces-21092-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPHoJOW9nGlSKAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21092-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:51:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D017D362
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1222B301877D
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D2C36BCD6;
	Mon, 23 Feb 2026 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j42MD0k3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE5F31690A
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879876; cv=none; b=i/WHbP6KCK9GDGVhsuz2JOA7XYHKNrpT9h4qfmyHL0nvtZWLf5jsnqYMsIdacpxjkSzfQqkBvZfPlcTJw73lI0GAjQQcnEeoiEgDXJSlqQbB8GHCDe6lhoQgwcIwuzp0HpPvudA0+HpyJWCHUMyCVz8NTb5NbWnade50sOtnL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879876; c=relaxed/simple;
	bh=O4MPolK4vKNvn2aEyULiFnrflj5nw9ZU33O+z3/6hjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xh9PcYMylZCGj6n/S/n5UFZb5IcEK77Vg4JRayZjHiMJnLeOT0DbiJstji4hOEaOymJjCVM2thSjS2R0uruCiVEvvTknvTMKB7fF72bQJ2q/s3GqpgMGvvIUCxGH7kDKkZlbrCkbSDmRm3uqb47dHNO7FiQFdexghgYsfbqzkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j42MD0k3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E463C2BC87
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771879876;
	bh=O4MPolK4vKNvn2aEyULiFnrflj5nw9ZU33O+z3/6hjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j42MD0k3GBDtJb5JnWTYbmGv1Wj2vE7blMKwrOdGzlbVQKTw/tEJwjyACMG8pwLrd
	 2PImupdiGx4t89rx/4H8sMC5P1r1Kpwiu67OEi3sjH1XmZbqFkaeqbWL4n+o6dU4lU
	 Ey8iikRuA+B8JzZ3F8pkGuX81/phRhVWv4ry54lhyz7eFP73MgCc6lP8RjxmG2xRa7
	 7wrtNju2q894tgcFA4TYqGaoGNfxXaqufqZCYixBKUIHDkbXQGZSczN5tItwarQTFQ
	 mvPmEKOTTdRp8WvtS7wt/km7odOF17049gqjgoJ2SSyjyz+K/lQmgN7nBiiFtVU3RG
	 /etK3aCK453bQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d4bd4db87aso3093061a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 12:51:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkOjJYaYlOl4NdxlF8qvwTvMR6F/m7Fta62bQyiJtzESGvQz715mzewGb1xDjRc3JPv3pJjoxD5N/z@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqVPiB0DcPTVhIEhcxAUBBN4JHTTEabBstNMxV5GNbcRLKYFm
	WVvVb86nlrQaPhp4AhWj3JSBCDDMgOQz4kcbwMIsMqDtHgF4cJdUbslpHkjrS8P6nrxvBuXxmhj
	mkmO+XXp417vQnCcscinT7gEF0uHLcnI=
X-Received: by 2002:a05:6820:1792:b0:676:e8d1:bb57 with SMTP id
 006d021491bc7-679c44ebd39mr5867783eaf.58.1771879875150; Mon, 23 Feb 2026
 12:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223204412.3298508-1-andriy.shevchenko@linux.intel.com> <20260223204412.3298508-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260223204412.3298508-4-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 21:51:03 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hF=Mk25csPR9nkLVm4i_f9QrcOn_aU-RHVx9ow676fbg@mail.gmail.com>
X-Gm-Features: AaiRm52Y4Rk-MeIB82T7rQUey8wR_pi6WPfESPE3Kl06AnDnckRAZBp3gaCe-K4
Message-ID: <CAJZ5v0hF=Mk25csPR9nkLVm4i_f9QrcOn_aU-RHVx9ow676fbg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] driver core: Split device related fwnode API to device/fwnode.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21092-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,lists.linux.dev,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 0E2D017D362
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 9:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting device related fwnode API
> to device/fwnode.h.
>
> In particular this helps to speedup the build of the code that includes
> device.h solely for a device related fwnode API.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/device.h        | 17 +----------------
>  include/linux/device/fwnode.h | 28 ++++++++++++++++++++++++++++

I would call this node.h, so it is less easily confused with
include/linux/fwnode.h and also because it is not just about
fwnode_handle.

>  2 files changed, 29 insertions(+), 16 deletions(-)
>  create mode 100644 include/linux/device/fwnode.h
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4ba6ae72ddf6..d2e2745243ea 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -31,6 +31,7 @@
>  #include <linux/device/devlink.h>
>  #include <linux/device/devres.h>
>  #include <linux/device/driver.h>
> +#include <linux/device/fwnode.h>
>  #include <linux/device/types.h>
>  #include <linux/cleanup.h>
>
> @@ -38,8 +39,6 @@ struct device_driver;
>  struct module;
>  struct class;
>  struct subsys_private;
> -struct device_node;
> -struct fwnode_handle;
>
>  /**
>   * struct subsys_interface - interfaces to device functions
> @@ -603,20 +602,6 @@ int lock_device_hotplug_sysfs(void);
>  int device_offline(struct device *dev);
>  int device_online(struct device *dev);
>
> -void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode=
);
> -void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwno=
de);
> -void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
> -int device_add_of_node(struct device *dev, struct device_node *of_node);
> -void device_remove_of_node(struct device *dev);
> -void device_set_of_node_from_dev(struct device *dev, const struct device=
 *dev2);
> -
> -static inline struct device_node *dev_of_node(struct device *dev)
> -{
> -       if (!IS_ENABLED(CONFIG_OF) || !dev)
> -               return NULL;
> -       return dev->of_node;
> -}
> -
>  static inline int dev_num_vf(struct device *dev)
>  {
>         if (dev->bus && dev->bus->num_vf)
> diff --git a/include/linux/device/fwnode.h b/include/linux/device/fwnode.=
h
> new file mode 100644
> index 000000000000..4fe6107191a6
> --- /dev/null
> +++ b/include/linux/device/fwnode.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _DEVICE_FWNODE_H_
> +#define _DEVICE_FWNODE_H_
> +
> +#include <linux/stddef.h>
> +
> +#include "types.h"
> +
> +struct device_node;
> +struct fwnode_handle;
> +
> +void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode=
);
> +void set_secondary_fwnode(struct device *dev, struct fwnode_handle *fwno=
de);
> +
> +void device_set_node(struct device *dev, struct fwnode_handle *fwnode);
> +
> +int device_add_of_node(struct device *dev, struct device_node *of_node);
> +void device_remove_of_node(struct device *dev);
> +void device_set_of_node_from_dev(struct device *dev, const struct device=
 *dev2);
> +
> +static inline struct device_node *dev_of_node(struct device *dev)
> +{
> +       if (!IS_ENABLED(CONFIG_OF) || !dev)
> +               return NULL;
> +       return dev->of_node;
> +}
> +
> +#endif /* _DEVICE_FWNODE_H_ */
> --
> 2.50.1
>

