Return-Path: <linux-acpi+bounces-21185-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHSfJewZoGmzfgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21185-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 11:01:16 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 448181A3E3D
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 11:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F2B301C164
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139883A0B19;
	Thu, 26 Feb 2026 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTOJs0JE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505B39E6DD
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099757; cv=none; b=iVfKBpNiR1rJIaatN4kKCOS1MeQdHq43zDlltbRUuMBU/sS7zN6ACIEIwTvcDRKXrThMLEkApsXmkwu4EzAR6v64peGXSOQsxeCwjXehlUdmtpMAGfChYXSxTGlOtsmmpEAMbzVIbOHB9z7xaokddEo4wBxF1wbN0lfhIsirB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099757; c=relaxed/simple;
	bh=QEZxnJMrH0Qa2UVeDbP+54yDMgZNzL6WAowXNzcKlLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+f/Cs8YfWBqZBvsnbHdiLE/+oobamRqgMb3+hgz4BAinCQFSf7uDLMwsjY1dN/n1zIckxxHNg9dkGHq8wAbrmqc6i5TbxPL0G4nVAVzbWTFh/+Vpn3HPNetLq1LuMXiv9vcO8TIasNH1ejjdj6QFIL8W96I831mFAJms8RUQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTOJs0JE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EDDC19424
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772099757;
	bh=QEZxnJMrH0Qa2UVeDbP+54yDMgZNzL6WAowXNzcKlLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hTOJs0JEdsdCKSn77dFPDgamFNy53m6MBrJoZ7/pgpFSHo7LBsMzLRXFF9D8wAkO9
	 eUcmUVSyIw9pdRhkV8gEn42GLwz1bwgL/B0pjQZybJa6aLWPjy44eBCTTBm34Q+6Mm
	 Cr7YtwWgRaxfJeZjs0FWn6uzbylODgRATkSvinUzoJkGtWLsQQzUX1HKH3+cyFsr2+
	 UknPipxBvxVDamDpRNNW2IQAFSJoz9C+jzIeDVRrd4M7XPJwtKuUILX+i2/Wdr4f2t
	 0qbtHp6x0X2GXjEwuR+Wd91TOTg0RtsuoiGSgWZs8ZOAXOqHrcVXz5Pl2+e0TvMCoX
	 LFsgG12HOz7GQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a10e1bff5aso126676e87.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 01:55:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkmSrC/rmowcDJvsze2y6WFpIMFawTjeVHe3LS/or2lGUM6len3xKCGUSTBDFtJCySlxpGW1yjPUH+@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKnQ+PnRKgRI5DJP/UvoJW229Nge7ixyBdKgUXputnS5DVelG
	sGqqj7Ed0WD/dPK7SHgoGaszjvzufrxTF3ekoC+0J5jI9DSElGufOneZb90zrg552EOjQ1pJNo8
	m1zf+JOskV59x4DFGtjJ52y/GF699bNHCiEmV/SuOXg==
X-Received: by 2002:a05:6512:1087:b0:59e:46c6:9081 with SMTP id
 2adb3069b0e04-5a105d8acf7mr1235592e87.2.1772099756151; Thu, 26 Feb 2026
 01:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225-device-match-secondary-fwnode-v3-1-a7152054135a@oss.qualcomm.com>
 <CAJZ5v0j0-7WPVY_YYHyjNZenBAaXD1awLHq-cKmLKce4hw-7Uw@mail.gmail.com> <CAJZ5v0jf-S-=H7Dyan0aBhOX5jeg-UNgg_P-Lh46SWHH+Z2fDQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jf-S-=H7Dyan0aBhOX5jeg-UNgg_P-Lh46SWHH+Z2fDQ@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 26 Feb 2026 10:55:40 +0100
X-Gmail-Original-Message-ID: <CAMRc=McgW9WTJG4MWZqB4MKKOzRVeAKwVY=qLaWyB2gq-J9Zzw@mail.gmail.com>
X-Gm-Features: AaiRm52gnf_4Dkoa9pIuN6uKyeXWIu8fiVe2nAGPSzw7Y3KCHUX2x4m3tk7bONQ
Message-ID: <CAMRc=McgW9WTJG4MWZqB4MKKOzRVeAKwVY=qLaWyB2gq-J9Zzw@mail.gmail.com>
Subject: Re: [PATCH v3] gpiolib: match secondary fwnode too in gpio_device_find_by_fwnode()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21185-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linuxfoundation.org,kernel.org,gmail.com,linux.intel.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[rafael.kernel.org:query timed out];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 448181A3E3D
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
> >
> > The second check is redundant because fwnode cannot be an error
> > pointer (it has been checked against that already above) and so if
> > node->secondary =3D=3D fwnode, then node->secondary is not an error
> > pointer.
> >
> > I'm not sure if fwnode can be NULL here, but if it can, it should be
> > checked against NULL.  Alternatively, node->secondary can be checked
> > against NULL and compared to fwnode.
> >
> > So, if fwnode !=3D NULL cannot be guaranteed,
> >
> >         return fwnode && node && node->secondary =3D=3D fwnode;
> >
> > or
> >
> >         return node && node->secondary && node->secondary =3D=3D fwnode=
;
> >
> > The overhead of the former may be a bit lower because it avoids
> > dereferencing node when fwnode is NULL, but the compiler should be
> > able to optimize this anyway.
>
> Or even the device_match_fwnode() check can be folded into the last line:
>
> static int gpio_chip_match_by_fwnode(struct gpio_chip *gc, const void *fw=
node)
>  {
> -       return device_match_fwnode(&gc->gpiodev->dev, fwnode);
> +       struct device *dev =3D &gc->gpiodev->dev;
> +       struct fwnode_handle *node =3D dev_fwnode(dev);
> +
> +       if (IS_ERR_OR_NULL(fwnode))
> +               return 0;
> +
> +       return node =3D=3D fwnode || (node && node->secondary =3D=3D fwno=
de);
>  }

device_match_fwnode() already contains the NULL check for fwnode. I'm
sending a v4 with the IS_ERR() check for secondary dropped I hope this
is the final one.

Bart

