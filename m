Return-Path: <linux-acpi+bounces-21081-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGnlHbeunGmYJwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21081-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:47:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6AA17C814
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 763253069AF3
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 19:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087EF37419E;
	Mon, 23 Feb 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjWx1d1l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803537416E
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771875954; cv=none; b=bCf5lWjWZXkXGstESN1w61YWQe37m5fWSfbB/Cfdi0WVzgDVvVIjkuU8ppJjR5VpR/fbjvHKjTsVB1ouzxN9gppz2q1gpWp9Tye3LL8P/+ylRTahCSMrBfX2VCxBEmgeVpv5q1/pRK+tNGFuUUOf2wYl4cerjZxo875kWuifNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771875954; c=relaxed/simple;
	bh=gl6z+z6JwrPxKtnDC3wFABuTO/xoflGEsD03jhwd1BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZqaExOYc/LUUgXUbvvPSEqebKDaYl6Kog1sk7i6OwZ/t3kDhehsr3Qwk3NjjeXzIfb+8VcRem+uSZtPTNZTbrmws9MOO4CcZjS57eXIwOjWLMG/plrCOttrTcX65z1Tvb/F5HlZob7q+1ZwI07av1z9id5Ia0dqPize11nP3k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjWx1d1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CAAC19421
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771875954;
	bh=gl6z+z6JwrPxKtnDC3wFABuTO/xoflGEsD03jhwd1BA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EjWx1d1l2/0A8KwSNkaBb8302dEFoN+c4jFpgRhMef+zPY74+fZocooN2V2giJclZ
	 ot+4/476YQ3on0b3AfADPb8XS2L4fdwovEeMa+STaL0XDDkDsF2LHP4V7nOYYa0gq1
	 H+8hLidMZMUfKX728roAHYEaF//bsQbSAQEylz3vGlSQzpB/SJ21NUTQmCw3Q22b93
	 Ez3IVZRCETfRRUbuGe1PwJZGM1+MtkNumQ4HmKg0WinFPgN5V+3n0Z8wagrz4kA+jI
	 7xQXPQCTM0ElRqLusvbOjr20cOTwKNYHjxkfuUYz8+vmLGJ61h5K+Z25j31cG9tOOi
	 sT+PHTGHr8lDg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662efd1bdd4so2688506eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 11:45:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmu4Fq1rVbflfm3x34SjCmLkHtYzV/Hu+2a2k8qNGX3PnSV/qsXziOYsKu8xkVbomM0/fJ6OzUthvj@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmC4amqmokqYJnm8MkXPLD+8ciwo9zucTGyCpRiaGJmii8CZL
	kalikqEnnyXM4P7r3QvMxXDyACzg/vimbdSvl8bTmLXoQsCNzigR2+hdMNlBKeQHz7D0DgxABbH
	U9fx0oJNtt2XPrYyivUXJmfG2OcDiBP4=
X-Received: by 2002:a05:6820:2110:b0:674:d7f:539d with SMTP id
 006d021491bc7-679c4ad378fmr4937902eaf.30.1771875953684; Mon, 23 Feb 2026
 11:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com>
 <aZyUY3ZsmrwHw4X_@smile.fi.intel.com> <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
 <aZyrVWYQKT-JUYR3@smile.fi.intel.com>
In-Reply-To: <aZyrVWYQKT-JUYR3@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 23 Feb 2026 20:45:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ivGazojW0BfSh7HzWyu+1ij6p=KbpwsmZPJ5YuTSahDw@mail.gmail.com>
X-Gm-Features: AaiRm51TiyeROrSoZppy1lvz6wk5jsAJRmIS3urBZ3TXwW4SfTEsTE7evmxqeHU
Message-ID: <CAJZ5v0ivGazojW0BfSh7HzWyu+1ij6p=KbpwsmZPJ5YuTSahDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Scally <djrscally@gmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21081-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: DA6AA17C814
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 07:28:48PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Feb 23, 2026 at 6:54=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> > > > Export fwnode_is_primary() in fwnode.h for use in driver code.
>
> ...
>
> > > > --- a/include/linux/fwnode.h
> > > > +++ b/include/linux/fwnode.h
> > > > @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *f=
wnode);
> > > >  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnod=
e);
> > > >  bool fw_devlink_is_strict(void);
> > > >
> > > > +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> > > > +{
> > > > +     return fwnode && !IS_ERR(fwnode->secondary);
> > > > +}
> > >
> > > This is inconsistent. Please, split out fwnode stuff from device.h to
> > > device/fwnode.h and share it there.
> > >
> > > This reminds me to look what I have locally in development...
> > >
> > >
> > > (With your patch it will be in device.h and fwnode.h and in the latte=
r
> > >  it's even not properly grouped with other non-fwdevlink related stuf=
f.)
> >
> > Please rephrase the entire email because I have no idea what you mean. =
:(
>
> The primary/secondary and other device-fwnode related stuff is currently
> exposed via include/linux/device.h. The problem is that device.h is overl=
oaded
> and starves for more splitting, which I'm doing (very slowly, though).
> The idea is to have all device-fwnode  (and maybe of_node) stuff to be ga=
thered in
> include/linux/device/fwnode.h

I don't see "struct device" anywhere in fwnode_is_primary().  This
check is only about whether or not the given fwnode has a valid
secondary fwnode.

> You, guys, missed the keyword 'device' in the pathname for the proposed
> [include/linux/device/]fwnode.h.

Why do you think we missed it?

