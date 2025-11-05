Return-Path: <linux-acpi+bounces-18555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF8C36D67
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E06354E3A88
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 16:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E331E33890E;
	Wed,  5 Nov 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVpbhQKs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72023016F2
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361527; cv=none; b=QpqAFgm6I5tgaq23qSd2XnEzs+xB8fAJUXD4B8vhzs76iGHw6I2/+Q+9bJr1S+RzrKKFCB8erAeq9+2Jwnh8Bk5sKb30L+mcAAcn/pb1G0H9NvjT0az4muP6YwjdJXwjASscbDEy/k6APS/Flfq8Jc3K0dm1d46E/RAaoscPrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361527; c=relaxed/simple;
	bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxgf9f0zPxVxTOXWrNdexrOasw5SrknBSBxc+49hp8tIGcEj1tZH34K2Fq4QaEugsqosda02aJMsB1WMMfzMheb/l+thJonIBjKUpd9PunMs+2DVkwDHkud3EqgEu0RImf4fV8tICOVANUU2zRW3XkMEM9+jc4VEn1oNJmEPosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVpbhQKs; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477563bcaacso75255e9.1
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361524; x=1762966324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=AVpbhQKsWHsJPurkBtpFjS569EuYKUxy0Ewl5KvxLz11TynIudTMz6x27b6A6doKWz
         ip2xD5KKY1oMJCK0Dweum3CzpsfSfe5Azmrly9qy+6lx5DTGxHpK2A+42y5Z3pqNqWXK
         5oMVmrIxCr+TXfau1fOpH55Ds8Gfkw+SKMup3+25IM0tOOtYD8mCPcmX3YHevXG3I9fS
         voKjd3O+6JkWCl7xwg0Uy4qskOwo95lmPAQUzNV1zgopuIouOGjmjNsUQ0iiplG4NNw3
         pJwe6bLtD5Fb+hz4cFTbQ+dE2Dx8twHim57o5xVAlYBYEkIZ+8VVi9pnTa3HqwZj4o61
         JDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361524; x=1762966324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=Ff7OOH/MEBWDV+W3wzcJBAIaA5aajKzDORrc/AFrMKyA3/TU/WMPSV6VxRyZyYPvvu
         2A2n4C2+BY4zlKT9HpDIuKRVa9MkrKPSMYjKdv0Ai0jcYC4+gOGHzfttxHkYqgZDbziv
         EaD5b6h4058TTAtrG0zUtR1tFPy7V0w3MB9sLJF+qGFa04ZHVzrp3C5Qp9Tsqmw1V+eK
         JCnQZg8WMxAtlFTx0Eg8vaJlWuHRXQ8n6ElPJfHMTKVwxN/qfTSfJ6WRtrfSJML6X/qd
         eIRM3sOPWscYsz5TkObWic0+O6kO23LUAf6i270EoMlPzIQ7Cip12Zwz9hpy5/KUAH8E
         DWpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTP/uidB4gozog1BVaQPdUekfQ0/PdAiPYDPlerW0pKNHcjMToZ21sy8AhGLmxZDCSSzx7wCi/Mu9X@vger.kernel.org
X-Gm-Message-State: AOJu0YytBm5FN8Bvqld39zhyLtfIu03r5fUUd5SI7PW3tbyYamE0gq67
	5YWPtJEDgX3dSYq2z8IHuf+/DqiN8nBjapcHhWMB4/neYidtICHcHvlM
X-Gm-Gg: ASbGncvYBFp1ZbP8dyfnSVzEuK/poaoMM6DjFj+gabEt8NG7yffw7K/ZygXtyutC3TG
	VUQ1PwpgmHzLzMswkd+2kpjKu51Ro83VCkVLdEMIXF2ETOmiVZD7TP1LtXSBMxuuGTkiB2XoUB1
	3EmS5I5hM/lmjevKOlpVoYak5q8vTJ0qDBrvC06oHfECInkdhIAD+Ly9CXGjJv0iUb8TdK2STZO
	3HXQVnDj1QAvrJuuYiI/wOzm08uo4CFf5k44OBEfokdu1Y3IzV7secWTNuBFen9a/o/rF9N6PL+
	aMiu+YLa+5W+ByKA68tc7uPUqtBxF95jyz+Xhw2/XfcVPu8YICnalzLqHgab1b2V1nJJl8Tzs6F
	351bhsHHbhxZ6Eb1yRlDHj88z3d2YNOAgukD30U+MT0jUsx4WSyV728XOMPy0nxS2cKRgvLQf7D
	4DA8JTqkwQI0PQGwT1YFQUdjoqX1s6q7CBsjO9Kp86QX6CngEnROZutIPEoCtIs4M=
X-Google-Smtp-Source: AGHT+IF1eT04urNHEfsD9kdCj32CNL1YcHJ6oGuMVK3cU2BLT/aQRFRmm7ox5OYZe77ML31HK9v5ow==
X-Received: by 2002:a05:600c:1c94:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4775ce23efemr42468465e9.17.1762361524090;
        Wed, 05 Nov 2025 08:52:04 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm59725725e9.12.2025.11.05.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:52:02 -0800 (PST)
Date: Wed, 5 Nov 2025 17:52:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
Message-ID: <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
 <20251029163336.2785270-2-thierry.reding@gmail.com>
 <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykyajizgfjgayrmb"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>


--ykyajizgfjgayrmb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Mon, Nov 03, 2025 at 05:18:08PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 29, 2025 at 5:33=E2=80=AFPM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Several drivers can benefit from registering per-instance data along
> > with the syscore operations. To achieve this, move the modifiable fields
> > out of the syscore_ops structure and into a separate struct syscore that
> > can be registered with the framework. Add a void * driver data field for
> > drivers to store contextual data that will be passed to the syscore ops.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> This change is fine with me, so I can apply it unless somebody has any
> specific heartburn related to it (Greg?), but in case you want to
> route it differently
>=20
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

I have a few follow-up patches for the Tegra PMC driver that depend on
this. 6.19 is what I was targetting, so if we could put this into a
stable branch that'd be the best solution. I can set that up via the
Tegra tree if you and Greg are okay with it.

If that's all too complicated, I can probably wait until the next cycle
to merge the PMC changes.

Thierry

--ykyajizgfjgayrmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkLgLAACgkQ3SOs138+
s6F0Lg//dTn1/PUCYHRhF8cm1xB6JKggiLC40TRct49fcf9eF5gAdCqXm44qKoaF
67aqiXAiwzovTctJIu3rz8p71/FeXp/qGWDdPm/+wI7yD+BoCcVO0nmvXuPwCzhd
ZMwqeaRVm57JX4M9S5BdkOGtDLgAjyZ/6Qq/2isiQSPiWWl/IT3YiLyzw8vq8mcY
VoepQGK5hm7CHFf8FOBs+sMt6q5JJDm0VjNi+seVcCNg9U25GaXCRc2D9ztAqRib
3768/KMhlftnoJKsizCwWq2Gyw0Se7ifz66djjf51sHd064LLDv7OZpfeGyiFK01
MvVGXoPFuIJB0yqIoMRBbeRULm4kq+dkUkt1JWwYAMw9ZJnhXPJJI8bal2IASj8/
E6NADiYd9HS8kAXWYvLkm0xHv4FN5WXWG2a+Gf6K2vpBm07zG2xnI+eVjYQSnb9W
O9TcZf3jDWvgEQ31plH5JFY32sI4vjLAdcKS2oRfkbxFDJvTS+RRjj3EPqFshNXf
B5E6pXTCltOkUepuhbGDzIifVWzYgg/GyXNfwzdnJUXcAz7QPPJySfMraf/dn+8S
hggVgAivRFDEtaNEqKU6iqoePR3HIUJe/Ebjrb199RV9t4FcnVYOpviJRf5EWpsF
2YEUJPiA7neiac9fPLwCoRh33bJTIzanmWVxmFF1nQ2vozIt68U=
=3Mmd
-----END PGP SIGNATURE-----

--ykyajizgfjgayrmb--

