Return-Path: <linux-acpi+bounces-21084-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAVsA9qynGmxJwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21084-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:04:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747DE17CB20
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 21:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D78B3013B6A
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC850371050;
	Mon, 23 Feb 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNx9zSGO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99643361641
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771877076; cv=none; b=MXqRLISmp8rlffUDjligXA2t10KzFv93vLwXncOypNpbKPpDihXn+SH24hSPG0JBco0HfnFh7IbUm/PujoWbbCmjjrFTvVETHgyqa8GCvOAnbAFN3ndEsn0VlZIzKCdKA5owlpfzrIcL45dGBMGRi7z3WhtEDkIo6PtKyVaT0bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771877076; c=relaxed/simple;
	bh=LW7UkkaEKpjkuojFydHTX/vRlZAUw/MTRcwfpsbP5Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIJr/WudBfrbrR8Y2KXkJw076PTbYZQwROiD4h23977kv3KMeNvZjIgCRlAIyYjkjngGIhuCmV7I5HjprO2SShbuW4n1r26qyMVCM1Tn+K628oHqobchZSlV0UnhBbZVZXrMIWawDg4NQAuUwTjE9QtqJ8vqw2ii5mc3wt7xe9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNx9zSGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B967C2BCAF
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771877076;
	bh=LW7UkkaEKpjkuojFydHTX/vRlZAUw/MTRcwfpsbP5Uo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oNx9zSGOiQ27afI5YoUFRnhMtgBulPJ15Yqb0v8a00ebTIgrm1gQ/GTYTJrYVCD/z
	 8BU1NwfpbC2eOSohxppgfsh0+RzDo1fHq8ddMIx4XpLBTTRwKAzxdj2tvVp3HWVi6t
	 mSrjKvZCK7Ak1OMbLy2i8FuYRtGxaq4qbVIED5rL97isY0UENfenerJiRo3xkx3fVd
	 pv2ugJoTJb3XTcYcJw2xHCjnEXQKHYP37L5E3UL3TYsqpzJlICFyVdfheEX8Zdi6xI
	 hQC+NNaNbBPvPRjA95HbCMfcjm4hMNXnrxeZD4zwgWRWiTpaG36QcyLhEFUFZnAezM
	 Onz7f1UOXHbrA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6729292dcd7so2330816eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 12:04:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1rAfdlv/TL3n0G75W5f/L2jwLMPzhxQCtq/7UyLZmisZrn1QNMrqei5EWPYSEfG9G9VaA8e2HZhDS@vger.kernel.org
X-Gm-Message-State: AOJu0YwtDW00Js1ind7DNtnZAdyLPt84L0lj6DfEA4CM0wkjUbnejBcK
	nFtEPlJF4mmSxfH2ogWi3MNuIM77k3OvH5TOXGIkmzcfLXYA1HGbcZ9m8W8gglpt1bRisDCNOhM
	oKcxMTd4GB4BtNWIiQP6ZpzjDMtlQ/os=
X-Received: by 2002:a4a:ee83:0:b0:662:fe9f:2259 with SMTP id
 006d021491bc7-679c44ded2emr5808231eaf.50.1771877075530; Mon, 23 Feb 2026
 12:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <DGMLL6SYIK5C.DJ8U368VN9CG@kernel.org> <CAJZ5v0jr_i9k3d+np8c+ANhewMhT-TL9exLzZKUJOVarBGnHfw@mail.gmail.com>
 <DGMLWYUO9Z48.1769AL2OS2YMK@kernel.org>
In-Reply-To: <DGMLWYUO9Z48.1769AL2OS2YMK@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 21:04:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gq7tqTpOLiNA1J+QMFw0RTOi=CxYgT_ENO6rrZt=L3yw@mail.gmail.com>
X-Gm-Features: AaiRm53hKBAm0GU5uIz6RO0cjN69BOTwUs7KTBzzK-ujqtfJXeW0V9o3CXXbk40
Message-ID: <CAJZ5v0gq7tqTpOLiNA1J+QMFw0RTOi=CxYgT_ENO6rrZt=L3yw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linusw@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21084-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,linuxfoundation.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 747DE17CB20
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 9:00=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Feb 23, 2026 at 8:55 PM CET, Rafael J. Wysocki wrote:
> > On Mon, Feb 23, 2026 at 8:45=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> >>
> >> On Mon Feb 23, 2026 at 4:40 PM CET, Bartosz Golaszewski wrote:
> >> >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const vo=
id *fwnode)
> >> >  {
> >> > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> >> > +     struct device *dev =3D &gc->gpiodev->dev;
> >> > +     struct fwnode_handle *node =3D dev_fwnode(dev);
> >> > +
> >> > +     if (IS_ERR(fwnode))
> >> > +             return 0;
> >> > +
> >> > +     if (device_match_fwnode(dev, fwnode))
> >> > +             return 1;
> >> > +
> >> > +     return fwnode_is_primary(node) && node->secondary =3D=3D fwnod=
e;
> >> >  }
> >>
> >> Rafael, I understand [1] as you agree with my point, but object to int=
roduce
> >> device_match_fwnode_ext() (or whatever name we would pick eventually :=
)
> >> regardless because only the GPIO code would need it as by now.
> >
> > This is a preference, not a strong objection, but yes.
> >
> >> IIUC, I wonder if exposing fwnode_is_primary() instead is a good trade=
.
> >
> > Well, there is the secondary pointer in struct fwnode_handle, so it is
> > kind of exported anyway and it could be documented as "a secondary
> > fwnode_handle supplying additional properties or an error pointer", so
> > exposing this static inline doesn't change much IMV.
> >
> > What's your specific concern about exposing it?
>
> No concern with either approach from my side, I was just curious. :)
>
> Maybe it makes sense to add a comment to gpio_chip_match_by_fwnode() hint=
ing to
> move this into common code once there's another occurance of this pattern=
.

A comment like that might help, yes.

> But either way, this is
>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>
> >> [1] https://lore.kernel.org/driver-core/CAJZ5v0jUCtKTW-g-C0pKu0DQqOkyf=
Sz=3DupXwbtYeV_=3DrMBUMyg@mail.gmail.com/

