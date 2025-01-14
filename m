Return-Path: <linux-acpi+bounces-10639-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B89A10E81
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621993AC7FA
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684A1FCCE3;
	Tue, 14 Jan 2025 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bd4E7pWm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BB31E3DCC;
	Tue, 14 Jan 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877385; cv=none; b=fNiCNb1PyeP5OKyLNASoXl3i1Q+o0/NmdNSX8iHmHmfPmd6SNR+TjvPrKgMCHm8qvB4qE4KdFCvAcdwEZAtISxCpBYkHnN6s5Mu58klogVw0SjV/txgbir+Qg5zTeud2vaXG/+cG+h/HTfKcSRxJ49U2NvQErSbfOwYClxsHs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877385; c=relaxed/simple;
	bh=0Q5aeHTRXxrQOMPk/oFwWZAR5dycdE99CYbMLBRZnZI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WvrMR/qOMFaNasS9zlqOy0p5EM8PVrrK5MLOJVI/Xo0zvUDJ5gzjhJWCYYgksHOS+0cd0/zUUIpcwKjvb/pPbJU5rl1Ms9THEgcX4w6R6Eluuq8+v09MOunUc1bi+7MK5aPceIXFE2O1P1VlRk80egnuGuHQMG2MaAmmAcjV530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bd4E7pWm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736877384; x=1768413384;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=0Q5aeHTRXxrQOMPk/oFwWZAR5dycdE99CYbMLBRZnZI=;
  b=bd4E7pWm/RLGLBe8pGUAxeQyhdtUkJpvOFn498NcHxwLZJ+ft+oAUb2z
   fY3qYCFT9CXMSNbBuW9JwiMaKajrRKxs8A/AS6oe7DqFwEYVX6xHyBMOX
   GUOKt0q5hQgMqMThWLQArspAAx0ayONg4mdfe1w9BFqMdC7ER9LnmgA/0
   0MKZs1uS5vJwWOlPONNFW8w2rNyyW9sf85t2tsZbbN+In/AvjaEhhLMI2
   n2qMqLoc3twuq8EE+gx04mbYE2k0iToZPKWjdQ2CsLh9Us59DUz3YLKzz
   uR8fi29QyrlsRFYxviW29ZG8vUBq2f6aB71YmWgdavDqQXrDF2W5DSgkV
   w==;
X-CSE-ConnectionGUID: J5WhBWb4Qk+poodcAOvIYg==
X-CSE-MsgGUID: dzFTmlg4She9oBmSGGDbLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="37213637"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="37213637"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:56:09 -0800
X-CSE-ConnectionGUID: DdqJv9MBReCMIJbPjmY+ew==
X-CSE-MsgGUID: sgVIqjSHSI6JeM8cEdi6Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135740384"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:56:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 14 Jan 2025 19:55:53 +0200 (EET)
To: Kurt Borja <kuurtb@gmail.com>
cc: platform-driver-x86@vger.kernel.org, 
    "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>, 
    Joshua Grisham <josh@joshuagrisham.com>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Maximilian Luz <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D. Jones" <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>, 
    Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>, 
    Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com, 
    ibm-acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 15/18] ACPI: platform_profile: Remove platform_profile_handler
 from exported symbols
In-Reply-To: <i6wubniwg77joijwqo7jg3q4tv3oit7tehv5uxhgkcnwqukuom@ethn7feuyrah>
Message-ID: <6a132155-b6a4-b326-5d5e-c9fcc6670265@linux.intel.com>
References: <20250114153726.11802-1-kuurtb@gmail.com> <20250114153726.11802-16-kuurtb@gmail.com> <b271023f-8a84-a48d-2d59-f0815014687b@linux.intel.com> <i6wubniwg77joijwqo7jg3q4tv3oit7tehv5uxhgkcnwqukuom@ethn7feuyrah>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1510476100-1736875724=:1077"
Content-ID: <80583a76-0039-be6b-4ce0-c002847329e1@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1510476100-1736875724=:1077
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d1f2de97-5ae0-fc88-e041-be20d06b3751@linux.intel.com>

On Tue, 14 Jan 2025, Kurt Borja wrote:
> On Tue, Jan 14, 2025 at 06:55:34PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 14 Jan 2025, Kurt Borja wrote:
> >=20
> > > In order to protect the platform_profile_handler from API consumers,
> > > allocate it in platform_profile_register() and modify it's signature
> > > accordingly.
> > >=20
> > > Remove the platform_profile_handler from all consumer drivers and
> > > replace them with a pointer to the class device, which is
> > > now returned from platform_profile_register().
> > >=20
> > > Replace *pprof with a pointer to the class device in the rest of
> > > exported symbols.
> > >=20
> > > Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> > > ---

> > > -int platform_profile_register(struct platform_profile_handler *pprof=
, void *drvdata)
> > > +struct device *platform_profile_register(struct device *dev, const c=
har *name,
> > > +=09=09=09=09=09 void *drvdata,
> > > +=09=09=09=09=09 const struct platform_profile_ops *ops)
> > >  {
> > > +=09int minor;
> > >  =09int err;
> > > =20
> > > -=09/* Sanity check the profile handler */
> > > -=09if (!pprof || !pprof->ops->profile_set || !pprof->ops->profile_ge=
t ||
> > > -=09    !pprof->ops->probe) {
> > > +=09/* Sanity check */
> > > +=09if (!dev || !name || !ops || !ops->profile_get ||
> > > +=09    !ops->profile_set || !ops->probe) {
> > >  =09=09pr_err("platform_profile: handler is invalid\n");
> > > -=09=09return -EINVAL;
> > > +=09=09return ERR_PTR(-EINVAL);
> > >  =09}
> > > =20
> > > -=09err =3D pprof->ops->probe(drvdata, pprof->choices);
> > > +=09struct platform_profile_handler *pprof __free(kfree) =3D kzalloc(
> > > +=09=09sizeof(*pprof), GFP_KERNEL);
> > > +=09if (!pprof)
> > > +=09=09return ERR_PTR(-ENOMEM);
> > > +
> > > +=09err =3D ops->probe(drvdata, pprof->choices);
> > >  =09if (err < 0)
> > > -=09=09return err;
> > > +=09=09return ERR_PTR(err);
> > > =20
> > >  =09if (bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST)) {
> > >  =09=09pr_err("platform_profile: no available profiles\n");
> > > -=09=09return -EINVAL;
> > > +=09=09return ERR_PTR(-EINVAL);
> > >  =09}
> > > =20
> > >  =09guard(mutex)(&profile_lock);
> > > =20
> > >  =09/* create class interface for individual handler */
> > > -=09pprof->minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > > -=09if (pprof->minor < 0)
> > > -=09=09return pprof->minor;
> > > +=09minor =3D ida_alloc(&platform_profile_ida, GFP_KERNEL);
> > > +=09if (minor < 0)
> > > +=09=09return ERR_PTR(minor);
> > > =20
> > > +=09pprof->name =3D name;
> > > +=09pprof->ops =3D ops;
> > > +=09pprof->minor =3D minor;
> > >  =09pprof->class_dev.class =3D &platform_profile_class;
> > > -=09pprof->class_dev.parent =3D pprof->dev;
> > > +=09pprof->class_dev.parent =3D dev;
> > >  =09dev_set_drvdata(&pprof->class_dev, drvdata);
> > >  =09dev_set_name(&pprof->class_dev, "platform-profile-%d", pprof->min=
or);
> > >  =09err =3D device_register(&pprof->class_dev);
> > >  =09if (err) {
> > > -=09=09put_device(&pprof->class_dev);
> > > +=09=09put_device(&no_free_ptr(pprof)->class_dev);
> > >  =09=09goto cleanup_ida;
> > >  =09}
> > > =20
> > > @@ -504,20 +524,21 @@ int platform_profile_register(struct platform_p=
rofile_handler *pprof, void *drvd
> > >  =09if (err)
> > >  =09=09goto cleanup_cur;
> > > =20
> > > -=09return 0;
> > > +=09return &no_free_ptr(pprof)->class_dev;
> > > =20
> > >  cleanup_cur:
> > > -=09device_unregister(&pprof->class_dev);
> > > +=09device_unregister(&no_free_ptr(pprof)->class_dev);
> >=20
> > I don't like how this is architected.
> >=20
> > IMO, no_free_ptr() should not appear on error/rollback paths. The point=
er=20
> > is going to be freed despite the code just told it's not going to be=20
> > freed, which sends conflicting signals. Obviously, it is because this=
=20
> > function has relinquished its ownership of the pointer but as is it see=
ms=20
> > a dangerous/confusing pattern.
>=20
> Makes sense.
>=20
> Quick fix would be to replace `goto cleanup_cur` with
>=20
> =09device_unregister(&no_free_ptr(pprof)->class_dev);
> =09goto cleanup_ida;
>=20
> and add a comment about ownership. Similar to the put_device() call
> above. Is this ok? If not I will think of a better way of writing this.

I think it would still be on the error path which is undesirable. While a=
=20
comment would make it understandable, it would be more logical to call=20
no_free_ptr() near device_register() which is when the ownership=20
gets transferred.

The trouble with that approach then is that no_free_ptr(pprof) will set=20
the pprof to NULL because of how the internal cleanup magic prevents=20
automatic freeing of pprof (Don't ask me how I know about that trap :-D).

I suppose you could take pointer of the pprof->class_dev into a local=20
variable before making the device_register() call since that is all you=20
need after that point?

So my suggestion is along the lines of:

=09/* device_register() takes the ownership of the pointer */
=09class_dev =3D &no_free_ptr(pprof)->class_dev;
=09err =3D device_register(class_dev);
=09...
=09

> > >  cleanup_ida:
> > > -=09ida_free(&platform_profile_ida, pprof->minor);
> > > +=09ida_free(&platform_profile_ida, minor);
> > > =20
> > > -=09return err;
> > > +=09return ERR_PTR(err);
> > >  }
> > >  EXPORT_SYMBOL_GPL(platform_profile_register);

--
 i.


--8323328-1510476100-1736875724=:1077--

