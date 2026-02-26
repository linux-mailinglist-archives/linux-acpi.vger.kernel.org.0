Return-Path: <linux-acpi+bounces-21188-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGbjOCw4oGmOgwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21188-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 13:10:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 621251A596A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 13:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0FB30457EE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 12:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F13803EC;
	Thu, 26 Feb 2026 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuwL5L0J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE1311960
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772107767; cv=none; b=FH4wYVIEIoIrziMoY+4yd1D9GmRgNCRLS7JL+OgwKm8Rc3RpG56CkDMGs6HckP/2QeH3qqgbwHje0sfz66W6iZl1E/hYDoKR664UDtmWgCb56zT5A61Qm3FsX2TzUZTlhRYe7UsKoGjMcHDQTjhVJW9uJy/66EMU2WHYhGimjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772107767; c=relaxed/simple;
	bh=vKkUe97N0G5LO6wiJ5EcKin2Xz6zGq+CEVpaKixKkR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJ+4XMlM7g0QWD8MLcy5OD7zpUHw4XIuctODjc5CUsplpzy/+FpHdZW2ALWXwdNc7M+/KYl695hz2UCXG2LI5v+HkJSli+IPnFnofwhiQg9WI/3NqEo6OBdRSUSw7ixhABr+3V0RDaBA+z/ryPYweEOZezrmWaNc9duFePK7r8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuwL5L0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE2EC2BCB4
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772107767;
	bh=vKkUe97N0G5LO6wiJ5EcKin2Xz6zGq+CEVpaKixKkR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QuwL5L0J9LFaYWEk9Ram8d5e7YJlXaalLL2VzqbThmrV//BchIjktwkys93W6ZMyi
	 2tVHu4C9ScLJGtIlBt5PdJysItVT+I+U5QfOkwyn4zA1e/89t5erH5QHr9/mCyXxGH
	 ekLTwQOYDuAIi9OWC/iWqe1CticDOjCfYnWk0Aheg3qiWKRcS4oGVGEhogjVVjlKdV
	 FyeG0UwtzBvc1ZqgJUoKxvsRhAYg6t5Ivyw3a4aPpNfPNrV7Od5H/CXNW1dTsqyPhu
	 xLB2oKSYcPjtRhWPe5WZPG5eUySfJ9VGLhkGcFObYW0WAV9IUtauBRJkeC7dxGl8m7
	 S2h3EMSq2pxyg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d18d02af68so566162a34.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 04:09:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4rI2g5PFD0XPazF/vY0xM0VO3SIRkvA7RAf0oUSh4psnrbzresQtWmzyhD0fcy5lvlctBa49j4brF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5Ly+/W+RMpqiTlb08zW2XfOvi/Z+H14CxEM4MIyUEjokDmXb
	dBLZT1jvwJwLxPU2MbtrGerSlgvV4j8ejsM45vyfDsZqlhmb2AmlqJ4QBUWV9gBbgi+zoiYuW0V
	JJz14LgPzwkY/Dgd2LDU8JWFKxiQFgBE=
X-Received: by 2002:a05:6870:6492:b0:3fd:a31d:104e with SMTP id
 586e51a60fabf-4157ac24e54mr10050319fac.11.1772107766448; Thu, 26 Feb 2026
 04:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
 <CAJZ5v0j0-7WPVY_YYHyjNZenBAaXD1awLHq-cKmLKce4hw-7Uw@mail.gmail.com>
 <CAJZ5v0jf-S-=H7Dyan0aBhOX5jeg-UNgg_P-Lh46SWHH+Z2fDQ@mail.gmail.com> <CAMRc=McgW9WTJG4MWZqB4MKKOzRVeAKwVY=qLaWyB2gq-J9Zzw@mail.gmail.com>
In-Reply-To: <CAMRc=McgW9WTJG4MWZqB4MKKOzRVeAKwVY=qLaWyB2gq-J9Zzw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Feb 2026 13:09:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jOaVPNtbOf3Lra4Tz8-JDyxn=bHh8y6jb45KHF=MQ20g@mail.gmail.com>
X-Gm-Features: AaiRm52YP8w3gzEByVAid25YEyQGlO_Vxhn_qJv-R2-cC3N01TzmGmsSEzFMTAY
Message-ID: <CAJZ5v0jOaVPNtbOf3Lra4Tz8-JDyxn=bHh8y6jb45KHF=MQ20g@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21188-lists,linux-acpi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 621251A596A
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:55=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Wed, Feb 25, 2026 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> > >
> > > The second check is redundant because fwnode cannot be an error
> > > pointer (it has been checked against that already above) and so if
> > > node->secondary =3D=3D fwnode, then node->secondary is not an error
> > > pointer.
> > >
> > > I'm not sure if fwnode can be NULL here, but if it can, it should be
> > > checked against NULL.  Alternatively, node->secondary can be checked
> > > against NULL and compared to fwnode.
> > >
> > > So, if fwnode !=3D NULL cannot be guaranteed,
> > >
> > >         return fwnode && node && node->secondary =3D=3D fwnode;
> > >
> > > or
> > >
> > >         return node && node->secondary && node->secondary =3D=3D fwno=
de;
> > >
> > > The overhead of the former may be a bit lower because it avoids
> > > dereferencing node when fwnode is NULL, but the compiler should be
> > > able to optimize this anyway.
> >
> > Or even the device_match_fwnode() check can be folded into the last lin=
e:
> >
> > static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *=
fwnode)
> >  {
> > -       return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> > +       struct device *dev =3D &gc->gpiodev->dev;
> > +       struct fwnode_handle *node =3D dev_fwnode(dev);
> > +
> > +       if (IS_ERR_OR_NULL(fwnode))
> > +               return 0;
> > +
> > +       return node =3D=3D fwnode || (node && node->secondary =3D=3D fw=
node);
> >  }
>
> device_match_fwnode() already contains the NULL check for fwnode.

Yes, it does, but if device_match_fwnode() returns false, you don't
know the exact reason: fwnode may be NULL or it may be non-NULL, but
different from the device's one.  You can't generally assume that
fwnode is not NULL in that case.

> I'm sending a v4 with the IS_ERR() check for secondary dropped I hope thi=
s
> is the final one.

This one is fine with me so long as NULL is never passed as fwnode to
this function.

