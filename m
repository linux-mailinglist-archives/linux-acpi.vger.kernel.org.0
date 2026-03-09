Return-Path: <linux-acpi+bounces-21555-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKIfDWfxrmkWKQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21555-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:12:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF023C849
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E697300D36A
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 16:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543EB3E5ED8;
	Mon,  9 Mar 2026 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2t4nBJ+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465E3C1983;
	Mon,  9 Mar 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072727; cv=none; b=uNsNBEc/gpKxP+Mhz4I7iU9Q8qbuubEdF3SshX41wLoal6mXLYJrcsxcl/yeC+e0X/5lkmGwtCTcyWIqDL2p4stc88MH7NjIbt6KyKRyCtQcNP4mBj9XoaNQmIkr4eDdY3ivF5VhvpP3IZz7+dcpPN1mx2CkhZ8llFGZRN64YYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072727; c=relaxed/simple;
	bh=/gL69/4fEotDSxCvXgFLOeq7+HfhWetfDiY5b0xW8ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRcZEyYxIEKsymDwx7zBS6VGeCL5R1LGsuhW/Tfv8p5FSsWFW4wruIRXy2UPVr1zLhw9PcihQyvfoYsz1L7/Naa74AWwg9RJu1Arx7YmdC68xT0V+decGvAvMgsaTCh8OJGUUNhO62m1URSDLxatdD8FlBGK/yZAeU6qytjXNOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2t4nBJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8B1C4CEF7;
	Mon,  9 Mar 2026 16:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773072727;
	bh=/gL69/4fEotDSxCvXgFLOeq7+HfhWetfDiY5b0xW8ZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2t4nBJ+ZgOgOXfIH2/7Mgg3FA/eVOXRkN8ve176y+52bYzr0efuS4bypzw9V/C4E
	 bJxnU3EISKoHbtKY7jkUdR8i6Y8TZvyYHXkEDTj50sHT1Ioyx6zoZ15hBqQA1jgvmn
	 EVChhmIR0+k4dCik44gIb2l7+fA1o8S7QhkmVFH6G/ZmwrVJWU2/4Kx6UX5B2nu4b6
	 4Oxp/w3shwKueOO8pphcwsymyqkaDRuqj2SYCchFtR9qPLEA5cNNsyh8GEydbVW9iY
	 YflDgyVhF3JVATrmW/Un+vWpSODJUvNJNGnEUY9ttDYJo+cVUFOz28Hq6Py9MmlJxj
	 qajb4ER1KqgnQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 Re: [PATCH v1 3/5] platform/x86: fujitsu: Register ACPI notify handlers
 directly
Date: Mon, 09 Mar 2026 17:12:03 +0100
Message-ID: <6255907.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <b645ebf3-6389-7255-db1c-a0322546b6dd@linux.intel.com>
References:
 <1968442.tdWV9SEqCh@rafael.j.wysocki> <10828467.nUPlyArG6x@rafael.j.wysocki>
 <b645ebf3-6389-7255-db1c-a0322546b6dd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E5CF023C849
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21555-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

On Monday, March 9, 2026 2:00:31 PM CET Ilpo J=C3=A4rvinen wrote:
> On Wed, 25 Feb 2026, Rafael J. Wysocki wrote:
>=20
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >=20
> > To facilitate subsequent conversion of the driver to using struct
> > platform_driver instead of struct acpi_driver, make it install its ACPI
> > notify handlers directly instead of using struct acpi_driver .notify()
> > callbacks.
> >=20
> > No intentional functional impact.
> >=20
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/platform/x86/fujitsu-laptop.c | 30 ++++++++++++++++++++++-----
> >  1 file changed, 25 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x=
86/fujitsu-laptop.c
> > index 1adce90ae3e6..cb13c06b8f35 100644
> > --- a/drivers/platform/x86/fujitsu-laptop.c
> > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > @@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi_d=
evice *device)
> > =20
> >  /* Brightness notify */
> > =20
> > -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 eve=
nt)
> > +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void=
 *data)
> >  {
> > +	struct acpi_device *device =3D data;
> >  	struct fujitsu_bl *priv =3D acpi_driver_data(device);
> >  	int oldb, newb;
> > =20
> > @@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_device =
*device)
> >  	if (ret)
> >  		return ret;
> > =20
> > -	return fujitsu_backlight_register(device);
> > +	ret =3D fujitsu_backlight_register(device);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +					       acpi_fujitsu_bl_notify, device);
> > +}
> > +
> > +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> > +{
> > +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +				       acpi_fujitsu_bl_notify);
> >  }
> > =20
> >  /* ACPI device for hotkey handling */
> > @@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct acpi=
_device *device)
> >  	}
> >  }
> > =20
> > -static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32=
 event)
> > +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, =
void *data)
> >  {
> > +	struct acpi_device *device =3D data;
> >  	struct fujitsu_laptop *priv =3D acpi_driver_data(device);
> >  	unsigned long flags;
> >  	int scancode, i =3D 0;
> > @@ -1056,6 +1069,11 @@ static int acpi_fujitsu_laptop_add(struct acpi_d=
evice *device)
> >  	if (ret)
> >  		goto err_free_fifo;
> > =20
> > +	ret =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +					      acpi_fujitsu_laptop_notify, device);
> > +	if (ret)
> > +		goto err_free_fifo;
>=20
> Hi Rafael,
>=20
> Is the rollback path still correct after adding this here?

Why wouldn't it be?  There's only kfifo_free() in it.

> > +
> >  	ret =3D fujitsu_battery_charge_control_add(device);
> >  	if (ret < 0)
> >  		pr_warn("Unable to register battery charge control: %d\n", ret);
> > @@ -1074,6 +1092,9 @@ static void acpi_fujitsu_laptop_remove(struct acp=
i_device *device)
> > =20
> >  	fujitsu_battery_charge_control_remove(device);
> > =20
> > +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > +				       acpi_fujitsu_laptop_notify);
> > +
> >  	fujitsu_laptop_platform_remove(device);
> > =20
> >  	kfifo_free(&priv->fifo);
> > @@ -1092,7 +1113,7 @@ static struct acpi_driver acpi_fujitsu_bl_driver =
=3D {
> >  	.ids =3D fujitsu_bl_device_ids,
> >  	.ops =3D {
> >  		.add =3D acpi_fujitsu_bl_add,
> > -		.notify =3D acpi_fujitsu_bl_notify,
> > +		.remove =3D acpi_fujitsu_bl_remove,
> >  		},
> >  };
> > =20
> > @@ -1108,7 +1129,6 @@ static struct acpi_driver acpi_fujitsu_laptop_dri=
ver =3D {
> >  	.ops =3D {
> >  		.add =3D acpi_fujitsu_laptop_add,
> >  		.remove =3D acpi_fujitsu_laptop_remove,
> > -		.notify =3D acpi_fujitsu_laptop_notify,
> >  		},
> >  };
> > =20
> >=20
>=20
>=20





