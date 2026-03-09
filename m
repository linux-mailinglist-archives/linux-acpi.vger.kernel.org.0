Return-Path: <linux-acpi+bounces-21548-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOs0Mp3UrmlhJAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21548-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:09:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A123A489
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 15:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171993020D69
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 14:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662283A6EE9;
	Mon,  9 Mar 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJMs3SJb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0132A39B493;
	Mon,  9 Mar 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065307; cv=none; b=UzzYUwhCAN0MGpUKrxmwKxavtlcw5afdz1EeHuvyZRNuDThnGYqZqp1HXfUYM6Q094nFXkZophjG12x050UiMvyfKuDSLVJxAt0lpMagG3p+iTXXZzbEGLAUTKePPmT0XP+xL+tdVKwwCK2QsqtaipUGbVHRTwh3auuBiSx63+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065307; c=relaxed/simple;
	bh=nYdlEN0aZwgU87+oBfMS2KH+DLGSurHoixFQS6FgX4Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Isv9VMlXxWpqqHfH7dMm2N66h74zK4EA0pCXg3DXci8tRZwAfHXeu1kwgf2unVGXvqKsl7Ov4ggx1TXlKd+GjZ/O7iZF75yL+tQZlRBPq4+vVPJ3UoP16FPWJ4N3SdjIWqvqSKLtGvQCrys3VVdBuRcZTDVT+q/6AejVHuYYmps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJMs3SJb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773065306; x=1804601306;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nYdlEN0aZwgU87+oBfMS2KH+DLGSurHoixFQS6FgX4Y=;
  b=lJMs3SJbDigX3SoWNE/eb75+4tUmpyuDgO3z/wmL+lycZBDzC2xzKyzm
   paf15Yr276nluJnWottZK4vtdWAj66CMfevJ38EEAXpaqme5mZUU1byqx
   ZI85HA5PMi4sf/WC2k6YEPEFi6QFPAbJybssVfl8y9DJIHAFCp5D+MjZE
   lm4s755GrxhxdD88xc0DmH+eOlUF7biaPqey3XjaNNPZbvyo8dbNHmukn
   dN6IKEoQnMVKhX4ixeA24szHj6ZX9Jyu0GAfrwUM/5KF1W9fIgwQDJcjJ
   t82eMF7ggnn3ZRFTza++YHpwNs1RfBEGhm+/QXHJ8LWVM68aayKDeO3Qg
   A==;
X-CSE-ConnectionGUID: UlztN9jRR1qcCDTBq6qkuw==
X-CSE-MsgGUID: Q6o4tdgZTVCnpfuhj43fIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74057937"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="74057937"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:08:26 -0700
X-CSE-ConnectionGUID: Uf0dm8BFTLmL4tDCoLQsJA==
X-CSE-MsgGUID: AyoCQ/1NT3WDUumDzMKN1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="218970569"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 07:08:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 16:08:19 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, 
    platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1 2/3] platform/surface: surfacepro3_button: Register
 ACPI notify handler
In-Reply-To: <461da326-7a86-552e-4d2e-9b7730bc1699@linux.intel.com>
Message-ID: <25a550e1-bbe9-00b6-a2c6-836d96a9bdc7@linux.intel.com>
References: <2909929.BEx9A2HvPv@rafael.j.wysocki> <1881356.TLkxdtWsSY@rafael.j.wysocki> <461da326-7a86-552e-4d2e-9b7730bc1699@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1401112567-1773065299=:971"
X-Rspamd-Queue-Id: AA8A123A489
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-21548-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1401112567-1773065299=:971
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Mar 2026, Ilpo J=E4rvinen wrote:

> On Wed, 4 Mar 2026, Rafael J. Wysocki wrote:
>=20
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >=20
> > To facilitate subsequent conversion of the driver to a platform one,
> > make it install an ACPI notify handler directly instead of using
> > a .notify() callback in struct acpi_driver.
> >=20
> > No intentional functional impact.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/platform/surface/surfacepro3_button.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/pl=
atform/surface/surfacepro3_button.c
> > index a6c9d4d370be..6d394daf5bc4 100644
> > --- a/drivers/platform/surface/surfacepro3_button.c
> > +++ b/drivers/platform/surface/surfacepro3_button.c
> > @@ -72,8 +72,9 @@ struct surface_button {
> >  =09bool suspended;
> >  };
> > =20
> > -static void surface_button_notify(struct acpi_device *device, u32 even=
t)
> > +static void surface_button_notify(acpi_handle handle, u32 event, void =
*data)
> >  {
> > +=09struct acpi_device *device =3D data;
> >  =09struct surface_button *button =3D acpi_driver_data(device);
> >  =09struct input_dev *input;
> >  =09int key_code =3D KEY_RESERVED;
> > @@ -227,6 +228,15 @@ static int surface_button_add(struct acpi_device *=
device)
> >  =09=09goto err_free_input;
> > =20
> >  =09device_init_wakeup(&device->dev, true);
> > +
> > +=09error =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIF=
Y,
> > +=09=09=09=09=09=09surface_button_notify, device);
> > +=09if (error) {
> > +=09=09device_init_wakeup(&device->dev, false);
> > +=09=09input_unregister_device(input);
>=20
> Add a new label to rollback path instead.

Nevermind.

--=20
 i.

> > +=09=09goto err_free_button;
> > +=09}
> > +
> >  =09dev_info(&device->dev, "%s [%s]\n", acpi_device_name(device),
> >  =09=09 acpi_device_bid(device));
> >  =09return 0;
> > @@ -242,6 +252,8 @@ static void surface_button_remove(struct acpi_devic=
e *device)
> >  {
> >  =09struct surface_button *button =3D acpi_driver_data(device);
> > =20
> > +=09acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +=09=09=09=09       surface_button_notify);
> >  =09device_init_wakeup(&device->dev, false);
> >  =09input_unregister_device(button->input);
> >  =09kfree(button);
> > @@ -257,7 +269,6 @@ static struct acpi_driver surface_button_driver =3D=
 {
> >  =09.ops =3D {
> >  =09=09.add =3D surface_button_add,
> >  =09=09.remove =3D surface_button_remove,
> > -=09=09.notify =3D surface_button_notify,
> >  =09},
> >  =09.drv.pm =3D &surface_button_pm,
> >  };
> >=20
>=20
>=20
--8323328-1401112567-1773065299=:971--

