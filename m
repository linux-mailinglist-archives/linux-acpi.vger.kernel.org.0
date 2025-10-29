Return-Path: <linux-acpi+bounces-18337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD023C1A8D6
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 14:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93BB8581C35
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Oct 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E82C08AC;
	Wed, 29 Oct 2025 12:51:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB12BD5AD
	for <linux-acpi@vger.kernel.org>; Wed, 29 Oct 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742301; cv=none; b=p3CLc+uHkW3qCTv5R0zfjkaG6XXf/X77z/YFn+KpPIAbUB69hLZcj8qXi2twHwZ5gZNDey3vpt1TOKyq8/5/myPQ4YvOhYINASpLwC09OrMeJ4Y7hZT77cV1V84tan6YhuO5AqWN5N/yB5WO88rsFFPb//aDU0/6XKFt2C5Zv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742301; c=relaxed/simple;
	bh=APfDTeJ3GfMW/qDOyoRWE6xVpfg/wTcIb4VWWvexGKU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnZQU15T6iIUCeuEZAxDkb0V/K+wGZTYNkbQFHwbBSNl7GFc7fzSd/9LAU3IcpCxK49/zDsYCtngjdetuMAOVBzA8G1rF1knMfNtjc5WVj+tHnWwquxnm8Ihl7OEJHgG+lxjj0FN1omNeabcgTv94ONfzgxmi9vra1Q6ppZtB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE5dr-0005sp-IP; Wed, 29 Oct 2025 13:51:07 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE5dq-0062hO-0I;
	Wed, 29 Oct 2025 13:51:06 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vE5dq-000000007zg-02zh;
	Wed, 29 Oct 2025 13:51:06 +0100
Message-ID: <06c7a64647ac78cfc5366a073ec12ccddda49572.camel@pengutronix.de>
Subject: Re: [PATCH v3 03/10] software node: allow referencing firmware nodes
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij	
 <linus.walleij@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus	
 <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Krzysztof Kozlowski	 <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Wed, 29 Oct 2025 13:51:05 +0100
In-Reply-To: <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
	 <20251029-reset-gpios-swnodes-v3-3-638a4cb33201@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

On Mi, 2025-10-29 at 13:28 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>=20
> At the moment software nodes can only reference other software nodes.
> This is a limitation for devices created, for instance, on the auxiliary
> bus with a dynamic software node attached which cannot reference devices
> the firmware node of which is "real" (as an OF node or otherwise).
>=20
> Make it possible for a software node to reference all firmware nodes in
> addition to static software nodes. To that end: add a second pointer to
> struct software_node_ref_args of type struct fwnode_handle. The core
> swnode code will first check the swnode pointer and if it's NULL, it
> will assume the fwnode pointer should be set. Rework the helper macros
> and deprecate the existing ones whose names don't indicate the reference
> type.
>=20
> Software node graphs remain the same, as in: the remote endpoints still
> have to be software nodes.
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/base/swnode.c    | 13 +++++++++++--
>  include/linux/property.h | 38 +++++++++++++++++++++++++++++++-------
>  2 files changed, 42 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b7c3926b67be72671ba4e4c442b3acca80688cf7..8601d1612be31febb6abbbe1f=
b35228499480c56 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -535,7 +535,13 @@ software_node_get_reference_args(const struct fwnode=
_handle *fwnode,
>  	ref_array =3D prop->pointer;
>  	ref =3D &ref_array[index];
> =20
> -	refnode =3D software_node_fwnode(ref->node);
> +	if (ref->swnode)
> +		refnode =3D software_node_fwnode(ref->swnode);

software_node_fwnode(ref->swnode) never returns NULL if given a non-
NULL parameter.

> +	else if (ref->fwnode)
> +		refnode =3D ref->fwnode;
> +	else
> +		return -EINVAL;
> +
>  	if (!refnode)
>  		return -ENOENT;

So this check is not needed anymore.

regards
Philipp

