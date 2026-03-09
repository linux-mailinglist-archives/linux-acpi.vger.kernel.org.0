Return-Path: <linux-acpi+bounces-21556-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJTQEP/zrmnZKgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21556-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:23:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C9323CA71
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 384B230137A4
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C403E7149;
	Mon,  9 Mar 2026 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9qGOKr8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5BA3A7F4F;
	Mon,  9 Mar 2026 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073077; cv=none; b=DnhgZ6rtcZAyWEQecggKIjZ/Gu1tmqk8UpHsHPZIcOOWtv9sMW11oGuGj+rE8gySQ97VFBg2WNL1Yk8uT88pu4UJaAw6VEfow9z7cysMfslGkYVmMcFPPW65QPFifyWH7snLHrtqcJ5OIBqRm4HwsY96aZu8+7KuObQLMijlbbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073077; c=relaxed/simple;
	bh=+Fsmka4qNKQMeH949E0/14GoG2P3q1ncKyK6HeL8xac=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kt96500pQtM+sUbnBgWlt4gF/0aeW1/k4fb7p5/0DZCthpkaAfKY/xdmG4mRRsJCG8u5nKvRPxLX2bTUQ6jNNsJqOZJgMWoxe2Pxm0Bi+6GVWZQf5OiLL53+4gYfomBoL9RLGTnbLkLfA2lo+9w44Oe0XeHgwi8cV0O4wFKTvHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9qGOKr8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773073075; x=1804609075;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+Fsmka4qNKQMeH949E0/14GoG2P3q1ncKyK6HeL8xac=;
  b=c9qGOKr8IwCSWhpkFPU3/FfHi9mbeysvo92vDJfFf9iF1XVU87bAGBGk
   VVrBtdKF7IsRUvU3I4KCEg2++2srVHTCCfhDozIrgdq3JNyMzbmdbFtln
   efc8iOKHubB5jr0RLIkuff38hA2HLXU3eX1mxn20+j2kGBYYI8wgUC252
   dVC7zEpDoqNclTVWl4UGGRehmrhAVctYp5fPMMYwK7v3rSIpdSscuhJFh
   YW4j8St1eFLfPGNTIIKBbS96wQjaKU/fFutuT4/+yHuWkWDNhIcXUNm7W
   iWVHh9Wfbl0ONd+JXKaH1Ds8JXU3jzVfAOpCFC7SSaWA334C9WNIN2dsh
   A==;
X-CSE-ConnectionGUID: CpMqYM/fQ5+8xB5McscwdQ==
X-CSE-MsgGUID: q7HLynQHS9+FWBaZpnt5ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73981032"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73981032"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:17:54 -0700
X-CSE-ConnectionGUID: F/s77YfQSKWvbqm6MB3VlA==
X-CSE-MsgGUID: YjV9/TB6TBiOfpKWeO5q6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219942758"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.153])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 09:17:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Mar 2026 18:17:46 +0200 (EET)
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, 
    Linux ACPI <linux-acpi@vger.kernel.org>, 
    platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH v1 3/5] platform/x86: fujitsu: Register ACPI notify
 handlers directly
In-Reply-To: <6255907.lOV4Wx5bFT@rafael.j.wysocki>
Message-ID: <f82b9099-2920-6947-d5dd-b56b0d0d02f3@linux.intel.com>
References: <1968442.tdWV9SEqCh@rafael.j.wysocki> <10828467.nUPlyArG6x@rafael.j.wysocki> <b645ebf3-6389-7255-db1c-a0322546b6dd@linux.intel.com> <6255907.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1562367324-1773073066=:971"
X-Rspamd-Queue-Id: 96C9323CA71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21556-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1562367324-1773073066=:971
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 9 Mar 2026, Rafael J. Wysocki wrote:
> On Monday, March 9, 2026 2:00:31 PM CET Ilpo J=C3=A4rvinen wrote:
> > On Wed, 25 Feb 2026, Rafael J. Wysocki wrote:
> >=20
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >=20
> > > To facilitate subsequent conversion of the driver to using struct
> > > platform_driver instead of struct acpi_driver, make it install its AC=
PI
> > > notify handlers directly instead of using struct acpi_driver .notify(=
)
> > > callbacks.
> > >=20
> > > No intentional functional impact.
> > >=20
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/platform/x86/fujitsu-laptop.c | 30 ++++++++++++++++++++++---=
--
> > >  1 file changed, 25 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform=
/x86/fujitsu-laptop.c
> > > index 1adce90ae3e6..cb13c06b8f35 100644
> > > --- a/drivers/platform/x86/fujitsu-laptop.c
> > > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > > @@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct acpi=
_device *device)
> > > =20
> > >  /* Brightness notify */
> > > =20
> > > -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32 e=
vent)
> > > +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, vo=
id *data)
> > >  {
> > > +=09struct acpi_device *device =3D data;
> > >  =09struct fujitsu_bl *priv =3D acpi_driver_data(device);
> > >  =09int oldb, newb;
> > > =20
> > > @@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_devic=
e *device)
> > >  =09if (ret)
> > >  =09=09return ret;
> > > =20
> > > -=09return fujitsu_backlight_register(device);
> > > +=09ret =3D fujitsu_backlight_register(device);
> > > +=09if (ret)
> > > +=09=09return ret;
> > > +
> > > +=09return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY=
,
> > > +=09=09=09=09=09       acpi_fujitsu_bl_notify, device);
> > > +}
> > > +
> > > +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> > > +{
> > > +=09acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > > +=09=09=09=09       acpi_fujitsu_bl_notify);
> > >  }
> > > =20
> > >  /* ACPI device for hotkey handling */
> > > @@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct ac=
pi_device *device)
> > >  =09}
> > >  }
> > > =20
> > > -static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u=
32 event)
> > > +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event=
, void *data)
> > >  {
> > > +=09struct acpi_device *device =3D data;
> > >  =09struct fujitsu_laptop *priv =3D acpi_driver_data(device);
> > >  =09unsigned long flags;
> > >  =09int scancode, i =3D 0;
> > > @@ -1056,6 +1069,11 @@ static int acpi_fujitsu_laptop_add(struct acpi=
_device *device)
> > >  =09if (ret)
> > >  =09=09goto err_free_fifo;
> > > =20
> > > +=09ret =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIF=
Y,
> > > +=09=09=09=09=09      acpi_fujitsu_laptop_notify, device);
> > > +=09if (ret)
> > > +=09=09goto err_free_fifo;
> >=20
> > Hi Rafael,
> >=20
> > Is the rollback path still correct after adding this here?
>=20
> Why wouldn't it be?  There's only kfifo_free() in it.

So it's intentional to not add fujitsu_laptop_platform_remove() there?

> > > +
> > >  =09ret =3D fujitsu_battery_charge_control_add(device);
> > >  =09if (ret < 0)
> > >  =09=09pr_warn("Unable to register battery charge control: %d\n", ret=
);
> > > @@ -1074,6 +1092,9 @@ static void acpi_fujitsu_laptop_remove(struct a=
cpi_device *device)
> > > =20
> > >  =09fujitsu_battery_charge_control_remove(device);
> > > =20
> > > +=09acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > > +=09=09=09=09       acpi_fujitsu_laptop_notify);
> > > +
> > >  =09fujitsu_laptop_platform_remove(device);
> > > =20
> > >  =09kfifo_free(&priv->fifo);
> > > @@ -1092,7 +1113,7 @@ static struct acpi_driver acpi_fujitsu_bl_drive=
r =3D {
> > >  =09.ids =3D fujitsu_bl_device_ids,
> > >  =09.ops =3D {
> > >  =09=09.add =3D acpi_fujitsu_bl_add,
> > > -=09=09.notify =3D acpi_fujitsu_bl_notify,
> > > +=09=09.remove =3D acpi_fujitsu_bl_remove,
> > >  =09=09},
> > >  };
> > > =20
> > > @@ -1108,7 +1129,6 @@ static struct acpi_driver acpi_fujitsu_laptop_d=
river =3D {
> > >  =09.ops =3D {
> > >  =09=09.add =3D acpi_fujitsu_laptop_add,
> > >  =09=09.remove =3D acpi_fujitsu_laptop_remove,
> > > -=09=09.notify =3D acpi_fujitsu_laptop_notify,
> > >  =09=09},
> > >  };
> > > =20
> > >=20
> >=20
> >=20
>=20
>=20
>=20
>=20

--=20
 i.

--8323328-1562367324-1773073066=:971--

