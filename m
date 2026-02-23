Return-Path: <linux-acpi+bounces-21076-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP1PLXKcnGmhJgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21076-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 19:29:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E217B7C5
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 19:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA71B300DEC9
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CF233ADA2;
	Mon, 23 Feb 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTELZAyA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84449339861
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871343; cv=none; b=hlKhhp1rhGAAfzDtMBcR4BtO5cONEPVeAlZOBi15U1ENfyWPmPq0ILH0zjMxBAYo2boEabn6zjtdkNuY4fF4SnFQiDevE+v9rQpesi2OEhTg+vvCt7evepDphHJLfbFdrE3CzFIUFbB62s83ElzEvuERgG5pgJrestKviAuI14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871343; c=relaxed/simple;
	bh=mzfCjS37q2cu7V2ENDhFi7Xh2Xke6aNT6a5HvYIrLb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ujc9+EHabDIZBTrTCOHOo5FO9GdviBdWaV5/f1kxNLMb3IAydSnQWLFVgzGmElwJ+ckbikEpBn6B+0nXj+rjupcvPo6/nKvwhQUhp6Kz/+hG+nirVY8uUOjopUGGkilX4H3sxfwQSFVInYnY4szFxC4hJoUcSJM5Fegt6r55cws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTELZAyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9B2C19421
	for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771871343;
	bh=mzfCjS37q2cu7V2ENDhFi7Xh2Xke6aNT6a5HvYIrLb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iTELZAyAPi5Fd2XI7t2BCcnfsxRr4r9ZzHNDzvDQzhU2dLMnYmLW2yBKndZDpCWli
	 8Rdg1mtPSQKglFR2dx3YvugdxT3Dyg9f63oFI0SYJGIs//KFtxZEXnIh4IYIvT0StR
	 1QfbEl6rCJk6BykHtJD7Pk4kIQ0Owmp/U1n9EEwzbh5EzARZLit9tUO1Oo0oWqaSzj
	 M7bYSDXTC04eRu5xV2OsjJo2Xz5/d1nTJg6fhetLo6A8/AJSoqrs/PG9s1czDwSxK7
	 6slN6qeaYTDN6z85IHeAAIb3c46aDhZxTAmwKfkt092l7TQ0YFA66Vs9ZQVqMb6Qph
	 q27kyvsaJA7XA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-385c23b88e8so38590491fa.3
        for <linux-acpi@vger.kernel.org>; Mon, 23 Feb 2026 10:29:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt3/BOAEeke8GINz2w03OE3BLs5pHEGgvjicKuvZPGxbN6/8WDFYpfPUXiHsxP5lBsRt6SVpcs/O6t@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLGIcJncgns8zT9fBdCCwXjINNsQoaGg7fbYzSKdNli0aOW56
	86+MfdJGvROso8WRGupiCOoKaRE0yVCY3nUkhGZOlC9mVyzFRRcUPRNsHI+EtYCZz13CWzzql22
	KbmIS6LxMLkY0zdRYF0ZB0EejuIlN0tWC4mk92Dq7CQ==
X-Received: by 2002:a05:651c:198c:b0:385:dd91:a6ce with SMTP id
 38308e7fff4ca-389a5c4c7a0mr35763781fa.38.1771871342013; Mon, 23 Feb 2026
 10:29:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223-device-match-secondary-fwnode-v2-0-966c00c9eeeb@oss.qualcomm.com>
 <20260223-device-match-secondary-fwnode-v2-1-966c00c9eeeb@oss.qualcomm.com> <aZyUY3ZsmrwHw4X_@smile.fi.intel.com>
In-Reply-To: <aZyUY3ZsmrwHw4X_@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 23 Feb 2026 19:28:48 +0100
X-Gmail-Original-Message-ID: <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
X-Gm-Features: AaiRm537I4oIfjLvMIcGhYYnIzZ2C1QZQmqaYwSbwb8V6Bm_JwM3OvKhUk5BeoY
Message-ID: <CAMRc=MfpzgOPf4pkHd_tNQ4wBNMhfUBOh=ptajhhZwDpFUPGBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: make fwnode_is_primary() public
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21076-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 601E217B7C5
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 6:54=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 23, 2026 at 04:40:52PM +0100, Bartosz Golaszewski wrote:
> > Export fwnode_is_primary() in fwnode.h for use in driver code.
>
> ...
>
> > --- a/include/linux/fwnode.h
> > +++ b/include/linux/fwnode.h
> > @@ -230,4 +230,9 @@ void fwnode_links_purge(struct fwnode_handle *fwnod=
e);
> >  void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
> >  bool fw_devlink_is_strict(void);
> >
> > +static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
> > +{
> > +     return fwnode && !IS_ERR(fwnode->secondary);
> > +}
>
> This is inconsistent. Please, split out fwnode stuff from device.h to
> device/fwnode.h and share it there.
>
> This reminds me to look what I have locally in development...
>
>
> (With your patch it will be in device.h and fwnode.h and in the latter
>  it's even not properly grouped with other non-fwdevlink related stuff.)

Please rephrase the entire email because I have no idea what you mean. :(

Bart

