Return-Path: <linux-acpi+bounces-21114-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKYUKBdmnWlgPQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21114-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:49:27 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023C5183FAE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B9E3101626
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B645A368276;
	Tue, 24 Feb 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0PoJMfa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93685366DD9
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922891; cv=none; b=PeBGdU4PW+uaMt3D2IJXs90N4TiYDkAs7iMNMbG877iyJJOUZ9ANgzCGUswm4hkMlpB8jnXDBBA0KnGUDFDS4bKQT/Nqmoj+EYCyENli2rX1TBJSKc6LC7dmkfS1Olny/GQJasyX/cohxTbE+UbiyKqs02y3XOKVJj+fQ9e21vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922891; c=relaxed/simple;
	bh=4PBxKCmgxvK6WwZLmo+9PGexMT6DsJoaoUauCu/9suA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0Sm7V3ZQzadWIzQvkZgyQs4PzHA0bCM5/xhFbGWm+sreDR//V6nKPEDjyicfXiIVXkW1Mtr/yrV+NxE3YJTaExQD/gNM1VWXl0Rh9zBzLahDmIHsEsLIQ5EtyxhaR3pI+k5Go1xUH87vsSPTotMigOuv1DTrHE9jNF1x8WfRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0PoJMfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47980C2BC86
	for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771922891;
	bh=4PBxKCmgxvK6WwZLmo+9PGexMT6DsJoaoUauCu/9suA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g0PoJMfagTwDUKv0g694fSX2JVR5/C1a445QMSU0KOYZZj4sEl9tx3HfComF/bBVV
	 VKthXQl7PzynYFdRxBM/mHRPoIeB+lLGgRcnv5G5RYBWQuvAkAyNVyalMsIWy0Dz0T
	 JPustmhKfVuDKNgo3J+4QJS8YEQryVRgauYWwoeobUlhiUFWF9Cr9IiVoJI1cyHivz
	 /BfkSYTnwQa8BDP2Dn9MICeF4Z3xD66YHcKEoq04z6U9rQLZuVgU6AR4VAa5JMv3p7
	 Eu26gMAhDJOm8aKQ99FrzOW3ebCjx0k3fyPfV4R25zzFkPKMLj225kE//B/Sm+p8/I
	 FfKnmU24KufSA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-385d9fb297dso56332091fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Feb 2026 00:48:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK0kLppObg2M2PsA/nYrCZ6o98mfcU/EaExZwdTX11TI76HH9EpTqSkg7WKxsoj/r/p5UP2IdMZDVC@vger.kernel.org
X-Gm-Message-State: AOJu0YyEKCv/bGBCU/k1rsUQB9Z2841DBMTKuzZTYZssYnOYIp5vGJxf
	7WdavsOHKdstjeciSxpqREEo9l4WX7Ucwh82wrRhBG2todJy0ycIovJFx98AIEoRtSumRPEgasM
	UPv0goulWB17cui5A3OkQa+1HzT2PAevVZsQxuXdmSA==
X-Received: by 2002:a05:651c:2116:b0:37b:b140:e512 with SMTP id
 38308e7fff4ca-389a5cb4560mr30753211fa.10.1771922889950; Tue, 24 Feb 2026
 00:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-2-966c00c9eeeb@oss.qualcomm.com>
 <aZyNErXB_acR3yYq@kekkonen.localdomain> <CAJZ5v0ibXKiUNf5Fvj=q=f9JbHT=w3j3h=33ri_awzEHm_dBng@mail.gmail.com>
 <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
In-Reply-To: <aZzPqbXH79Q6GvEn@kekkonen.localdomain>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 24 Feb 2026 09:47:57 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
X-Gm-Features: AaiRm50D_7LwkjWsKnNOowMphZqsmUfE0WwbpZEcKLUQ8S5X9UmeYY6QEuyxM28
Message-ID: <CAMRc=MeSbRySCe9wuEUifhOxzX2PydsjnttAJ_n=Nr1NdU6W5w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21114-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,oss.qualcomm.com,linuxfoundation.org,gmail.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 023C5183FAE
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 11:07=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> > > >
> > > >  static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const v=
oid *fwnode)
> > > >  {
> > > > -     return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > > > +     struct device *dev =3D &gc->gpiodev->dev;
> > > > +     struct fwnode_handle *node =3D dev_fwnode(dev);
> > > > +
> > > > +     if (IS_ERR(fwnode))
> > > > +             return 0;
> > > > +
> > > > +     if (device_match_fwnode(dev, fwnode))
> > >
> > > Could device_match_fwnode() match secondary fwnode as well?
> >
> > In the previous discussion on this, Andy was against doing that due to
> > the concern that it might introduce subtle bugs, which I agree with.
>
> Could you elaborate or provide an example?
>
> The function has some 27 users although few are individual drivers.
>
> My understanding is that we only have the secondary fwnode for being able
> to attach objects from different backend to the same node. The fwnode API
> in the meantime generally tries to hide the existence of the secondary
> fwnode; a rewrite (which ideally would have happened perhaps a few years
> ago?) would probably make the fwnode a linked list instead so we'd lose
> that secondary pointer in the process.
>

It already is a (singly) linked list. Ideally it would be a
doubly-linked list moved into struct device with struct fwnode_handle
having no concept of primary and secondary nodes.

Bartosz

