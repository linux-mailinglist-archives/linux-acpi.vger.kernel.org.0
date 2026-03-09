Return-Path: <linux-acpi+bounces-21557-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHQyENb1rmnZKgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21557-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:31:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A61F23CBC2
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 17:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A6453010738
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 16:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD13BD63E;
	Mon,  9 Mar 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2T2QG2V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94093B8BA9
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073511; cv=none; b=RtdyZB3vwZfCAF6YjjyCAfU06Z8uXKA5iInteh3YFZEgLDSke12AVsW4c2FutTyYxq4OKpBgGA5zJsw2iWlX/5Rfm0NjKvw8Im1g2Glh8w6jQRDqqN5tICAFdWHHHf5nwM5ke+JdEazMTykn2MMnunD7Ec+CigAgfxuXV2vTVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073511; c=relaxed/simple;
	bh=AdBNa9vqUNvpBTQPu5uCQG/IBHl7wb3wBKW8acjrsKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFgdrmn7tZYfruHWSlFV8pBtSHytIJIot2hH/Sfn8Tv6i9Q9ffL1VF17I+EEKhywc1EsSqMEc14NHHveNFsLZg+YZniCrzst++oPStXibmvx2jE4/pfSW+iJKs4dIhx8PA7hdlwGFmRZYDJ77BWQ3rxIGC9sANOKU8rPogg19QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2T2QG2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83199C2BCB3
	for <linux-acpi@vger.kernel.org>; Mon,  9 Mar 2026 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773073511;
	bh=AdBNa9vqUNvpBTQPu5uCQG/IBHl7wb3wBKW8acjrsKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O2T2QG2VRupjeiOc/9dJCWnv3tI4op1pn3bmtKEmktuxpIx4CsYrjWP6MO6yR2M3H
	 PkydBg7y8qi2ILqxbGr5ePI+zPYj8WGGJCfJGZVVd2ZdMdceVg97ND+hVF8HCF73sO
	 KkryAfaHG2ysHQbRGFoBwrZldWaPZfa1dgEj2rln6tVFRt/KeDrbVRoDM4MrSo9DKr
	 F3a69/p3gF2JUPFBNYj4HCv07KazaeCHJHlHdA2WAbL4sfaCK2h9J9XfRv2hNYJDQd
	 AJzpEfOzaksCLdza64WZcgAywNPgUe0X2bBM8AGutO+Uh0FrjjYgwluhu0KWjUfXXD
	 uTuhEDx5uEdlQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-46703fb602fso351397b6e.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Mar 2026 09:25:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWq3X6BYB04UbemF0O9Kp/OOCRx62gHVVuS9NniY7dDk5+AKr1Kq8CwfJ4gQgWrQMx39WoD7xmavANo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1HDbzUWZlUcMUqMsqG5V8YHjdZG1fWUwXwDehli95gcuAnuH
	KEiSDfP63ybuxIgAbnkcqcxNmuLIfM0n/ZEdMpKQ4U/QikR7ZdXSSSJMlcktuQZr8HBtLXr/0I3
	C1quDDv6BlWb///i2mPCA3ReIWYdfjSc=
X-Received: by 2002:a05:6808:1389:b0:467:13b5:8ae7 with SMTP id
 5614622812f47-46713b5986bmr1001512b6e.37.1773073510572; Mon, 09 Mar 2026
 09:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1968442.tdWV9SEqCh@rafael.j.wysocki> <10828467.nUPlyArG6x@rafael.j.wysocki>
 <b645ebf3-6389-7255-db1c-a0322546b6dd@linux.intel.com> <6255907.lOV4Wx5bFT@rafael.j.wysocki>
 <f82b9099-2920-6947-d5dd-b56b0d0d02f3@linux.intel.com>
In-Reply-To: <f82b9099-2920-6947-d5dd-b56b0d0d02f3@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Mar 2026 17:24:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i+TGtqkwpWgeCuurfTKJMSQdh2kAGMNF7qB-KFgNPcLg@mail.gmail.com>
X-Gm-Features: AaiRm51exsTew9EfIm2w-dm0cH53U1j6moX1TMyiq63mIm1uR0l7Zfs4aKXyAuk
Message-ID: <CAJZ5v0i+TGtqkwpWgeCuurfTKJMSQdh2kAGMNF7qB-KFgNPcLg@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] platform/x86: fujitsu: Register ACPI notify
 handlers directly
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8A61F23CBC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,vger.kernel.org,just42.net];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21557-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 5:17=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 9 Mar 2026, Rafael J. Wysocki wrote:
> > On Monday, March 9, 2026 2:00:31 PM CET Ilpo J=C3=A4rvinen wrote:
> > > On Wed, 25 Feb 2026, Rafael J. Wysocki wrote:
> > >
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > To facilitate subsequent conversion of the driver to using struct
> > > > platform_driver instead of struct acpi_driver, make it install its =
ACPI
> > > > notify handlers directly instead of using struct acpi_driver .notif=
y()
> > > > callbacks.
> > > >
> > > > No intentional functional impact.
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/platform/x86/fujitsu-laptop.c | 30 ++++++++++++++++++++++-=
----
> > > >  1 file changed, 25 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platfo=
rm/x86/fujitsu-laptop.c
> > > > index 1adce90ae3e6..cb13c06b8f35 100644
> > > > --- a/drivers/platform/x86/fujitsu-laptop.c
> > > > +++ b/drivers/platform/x86/fujitsu-laptop.c
> > > > @@ -502,8 +502,9 @@ static int fujitsu_backlight_register(struct ac=
pi_device *device)
> > > >
> > > >  /* Brightness notify */
> > > >
> > > > -static void acpi_fujitsu_bl_notify(struct acpi_device *device, u32=
 event)
> > > > +static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, =
void *data)
> > > >  {
> > > > + struct acpi_device *device =3D data;
> > > >   struct fujitsu_bl *priv =3D acpi_driver_data(device);
> > > >   int oldb, newb;
> > > >
> > > > @@ -558,7 +559,18 @@ static int acpi_fujitsu_bl_add(struct acpi_dev=
ice *device)
> > > >   if (ret)
> > > >           return ret;
> > > >
> > > > - return fujitsu_backlight_register(device);
> > > > + ret =3D fujitsu_backlight_register(device);
> > > > + if (ret)
> > > > +         return ret;
> > > > +
> > > > + return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY=
,
> > > > +                                        acpi_fujitsu_bl_notify, de=
vice);
> > > > +}
> > > > +
> > > > +static void acpi_fujitsu_bl_remove(struct acpi_device *device)
> > > > +{
> > > > + acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> > > > +                                acpi_fujitsu_bl_notify);
> > > >  }
> > > >
> > > >  /* ACPI device for hotkey handling */
> > > > @@ -941,8 +953,9 @@ static void acpi_fujitsu_laptop_release(struct =
acpi_device *device)
> > > >   }
> > > >  }
> > > >
> > > > -static void acpi_fujitsu_laptop_notify(struct acpi_device *device,=
 u32 event)
> > > > +static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 eve=
nt, void *data)
> > > >  {
> > > > + struct acpi_device *device =3D data;
> > > >   struct fujitsu_laptop *priv =3D acpi_driver_data(device);
> > > >   unsigned long flags;
> > > >   int scancode, i =3D 0;
> > > > @@ -1056,6 +1069,11 @@ static int acpi_fujitsu_laptop_add(struct ac=
pi_device *device)
> > > >   if (ret)
> > > >           goto err_free_fifo;
> > > >
> > > > + ret =3D acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIF=
Y,
> > > > +                                       acpi_fujitsu_laptop_notify,=
 device);
> > > > + if (ret)
> > > > +         goto err_free_fifo;
> > >
> > > Hi Rafael,
> > >
> > > Is the rollback path still correct after adding this here?
> >
> > Why wouldn't it be?  There's only kfifo_free() in it.
>
> So it's intentional to not add fujitsu_laptop_platform_remove() there?

Ah, yes, it needs to be called when acpi_dev_install_notify_handler() fails=
.

A fix would be relatively straightforward, but I guess I need to
resubmit the whole series with this fixed.

Will do, thanks!

