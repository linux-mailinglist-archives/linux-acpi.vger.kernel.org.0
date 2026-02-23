Return-Path: <linux-acpi+bounces-21080-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEryK02unGmSJwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21080-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:45:17 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1717C7E4
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:45:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE30B300D54C
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 19:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF31374188;
	Mon, 23 Feb 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2BUD0J9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AA372B56;
	Mon, 23 Feb 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875912; cv=none; b=M0CV78zYWLP1Oz4RmARngRqh24/NSizaZtEuMDMZK5NQWXMzdVGAahAqbukkN2mk1IksHkAKUFa2z1RbeeysdcTOLahbraj9+Kth+psyNSB4LiKlAbX2B5j0aFWz7zRnEkXcd1x9WW2hZpu6z+eaRFeBongjCuhlGn2bmmurl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875912; c=relaxed/simple;
	bh=lSHR9V2NyMeM1FanmNiiT0YLh55F5VGzVDb1MSPHtgw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=ek/uh1vFhTBX6jde6z1gXPXNAzcmXpWiq0ujJK4urzm38fC3IrnWBympP5zEfr9ha7GT1o9VcIFcmltMQ5McS1+Dbzwtqcyr5a9mG0pwBXorsI7Zx+jdGuRQNkJ+IhvKwq+mfXp+YdaIYx/cO27/hMf6Bmecrbwod/5/lorkqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2BUD0J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27321C116C6;
	Mon, 23 Feb 2026 19:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771875912;
	bh=lSHR9V2NyMeM1FanmNiiT0YLh55F5VGzVDb1MSPHtgw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=P2BUD0J9IXiooe36ZcXve7/NOguoeKZL08WtmqDzYMlCELjqT1NgQY8cZp4sJVni6
	 t+kLCwDTnH+X0O9CO5ij6gC6Ii7hqkbF8rFRefdIddO94GlMT2JRhsfYih3Q8x3ADf
	 vCBntvphhLoNPDVX5HiLOahG6tuV34J1d6kxrHkeZt9y7stcYdbakDE8pHsxvVXF7j
	 zulfsXvzM8rXknM/ib9TFZMrD4jNfGO0YC8ZnFUiICiWTAwUc5Olo9U4Xiam42JiT8
	 EU5M7haHqA3+1ZtU3vSsSU0F4yJlfveLGkikonQ8aYu2JGCcDRQU+pU9Dxe/HKIVN4
	 9rlZWkXH2VIOA==
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Feb 2026 20:45:07 +0100
Message-Id: <DGMLL6SYIK5C.DJ8U368VN9CG@kernel.org>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in
 gpio_device_find_by_fwnode()
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Daniel Scally" <djrscally@gmail.com>,
 "Heikki Krogerus" <heikki.krogerus@linux.intel.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Len Brown" <lenb@kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com> <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
In-Reply-To: <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21080-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C5A1717C7E4
X-Rspamd-Action: no action

On Mon Feb 23, 2026 at 4:40 PM CET, Bartosz Golaszewski wrote:
>  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *f=
wnode)
>  {
> -	return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> +	struct device *dev =3D &gc->gpiodev->dev;
> +	struct fwnode_handle *node =3D dev_fwnode(dev);
> +
> +	if (IS_ERR(fwnode))
> +		return 0;
> +
> +	if (device_match_fwnode(dev, fwnode))
> +		return 1;
> +
> +	return fwnode_is_primary(node) && node->secondary =3D=3D fwnode;
>  }

Rafael, I understand [1] as you agree with my point, but object to introduc=
e
device_match_fwnode_ext() (or whatever name we would pick eventually :)
regardless because only the GPIO code would need it as by now.

IIUC, I wonder if exposing fwnode_is_primary() instead is a good trade.

[1] https://lore.kernel.org/driver-core/CAJZ5v0jUCtKTW-g-C0pKu0DQqOkyfSz=3D=
upXwbtYeV_=3DrMBUMyg@mail.gmail.com/

