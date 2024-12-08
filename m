Return-Path: <linux-acpi+bounces-10014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7B9E858C
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Dec 2024 14:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45298281510
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Dec 2024 13:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B031482E8;
	Sun,  8 Dec 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnTiWhea"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82D1420DD
	for <linux-acpi@vger.kernel.org>; Sun,  8 Dec 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733666037; cv=none; b=AD/3cu4yV6mX0ep6wU5dC3ejIDwv8hLNPTvq0xLiq+hyP0XvJ5sHvDUMnkGcsb6coQrQUkYVvBfiQAzQplgTyCzlIoZFQ0zOPvrx/tpWANP+oKLETwKgQqtitq5REoYWelWzXEV9tHVt16psZvb+q1Rs3qGB4kEGH8rLkBIZAY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733666037; c=relaxed/simple;
	bh=eerFgtGd/HqSvsrzRLeFC5/NYF5/ni7FrBQR/PQyPh4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LaUBGw9Iw3eXtKtNOC1bZq0h/OmBHi0yyYYNDElZgAPqfMJ8oNci+Ah6FFZOH2LPoe2UulasLbQej9RllarX72qCeye8H4UL5tBg1rEMzeHMa6k1k4vbHu/cLkdKcYT57N3HePxYrizz9OeXAiRUuPn9995CS2nVjBYw1pGwfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnTiWhea; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ef05d0ef18so627406a91.0
        for <linux-acpi@vger.kernel.org>; Sun, 08 Dec 2024 05:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733666035; x=1734270835; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5zr3V42aTZGJJxz5l78WQcpAPgo+zvGTkekdCXdeP4=;
        b=OnTiWheashKbvozPOO9RquLyNefSyGH+TuI17N8cQnqPGdvJ4BBenbPaDjhv6SBQlC
         afjBsOjC0HiUBFU2HMSQo1a3O3aegw8umEIeqMUbK3hPgzBVb3dl7VX1sdZjmQO9KQ+W
         C3Y4o/TExaNBwNfER3jf4FNmlHyEvnJ10g0QOGNeyFSTrRf/67DbnHcUcZE3CwTyqOaa
         Cud19uielrXAf0+iS6gaiw+OmqEvc/xOpzuX4Vd17fh/SeEkqdz5aHVMVHGSuT/VN+Ug
         KvUrr67/tGxx4L5LdW0T+vQLtXjAf3SL+u+r02o2oSCuhuDgI9woX5s8iwocA1Y4PXhI
         VECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733666035; x=1734270835;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5zr3V42aTZGJJxz5l78WQcpAPgo+zvGTkekdCXdeP4=;
        b=kCvO58iwysk/4z/n153o/h2k7Lbz7zUbZIBIAnXpu0l2P6hI+UDLYQ4miDhXElFOYb
         CRMTND8DBdTM7DgQMsCD2QO90tHjo1VJtuzBZ+3p6BTdgBrkMJ4QzEd6QVHz3AzWmRbN
         a1rIMdPjawbmcD7Hra5J7rsvfmne+/u2sxwfu3d+rn0TS0JQJhG/5qCS7QixiSiinO0h
         N6pU57EkUXxwBssOvjTZQxl/k5SeQ+injwaHWFelvuYHlbhx9UJhKI3Cya1Ls4E6bOFq
         L1sM6f7MzNecuHRhEEqtHRQeyHW2cIcPNn8jXfutuS1qc8AQrqEOCQnia3PrLQZLDRUs
         sf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDhZ5d95DdxeRcmDOPL5Yya+o7ZNOQy6HiC9JHYyA1as8A48WjGpMNsxTF9Fr/boxa5L6Juw3jBsP0@vger.kernel.org
X-Gm-Message-State: AOJu0YwMtneooXYhii8PfrVUCSwyZ3bzN400oFSiQ9WseCM9bVgzpRNG
	acIJ987VBGt3hWKHe06oZDfZWn6+qQnfenO5cMznrrksVSLRA/cK
X-Gm-Gg: ASbGnctWflBliTwQi13RsMF49Z3d1z9gEhAu+8DAnJIuqPmrW39nZ/Xy9Zq25Rk2E+T
	xSR72w+EpYuldDiaGsYBi5wHzuOVdSfKtEcvFwAiBqPyKMDAhf12i0P0mBJ0TG+6f6mj+nKjqk8
	GoayFlMczb5zJ7jeecvGW1VWPkgHXtmynDDmtG8oa2NYzOHwkadBDMO93u/hdEPnK7Aw+4vyl2B
	UJ3eapKvUj/n5QE8+KjjsX7hcy17gDP8x690+Q1zL3BYm+bHx+ZIw1dsh7qdQ==
X-Google-Smtp-Source: AGHT+IES7/8w/DncgHUTqC/ukWB68qy1HNVnoe9WlZIpidlRAyTNd9rN6DJR5NduMV85/617DVDreQ==
X-Received: by 2002:a17:903:25cb:b0:216:282d:c691 with SMTP id d9443c01a7336-216282dd754mr32820135ad.13.1733666034924;
        Sun, 08 Dec 2024 05:53:54 -0800 (PST)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9ee4sm56887455ad.161.2024.12.08.05.53.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2024 05:53:54 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 2/7] ACPI: scan: Extract CSI-2 connection graph from
 _CRS
From: Miao Wang <shankerwangmiao@gmail.com>
In-Reply-To: <CAJZ5v0hzHONOO=JCCniQONPAhFMLuDaWO=_n=fpStEQyaYP5hg@mail.gmail.com>
Date: Sun, 8 Dec 2024 21:53:34 +0800
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4AE6B366-4F8A-41AC-BCE9-4C39CCFE767F@gmail.com>
References: <4542595.LvFx2qVVIh@kreacher> <2927980.e9J7NaK4W3@kreacher>
 <C20272A3-65B5-4AAD-B6AD-0B93A95C5D93@gmail.com>
 <CAJZ5v0jeE=3-0ad7OMWETnhYfQE+fhw2dQTfYTmn=_6gDnDghQ@mail.gmail.com>
 <2D27B47A-A6EB-487C-8DEA-6792A0BAE886@gmail.com>
 <CAJZ5v0hzHONOO=JCCniQONPAhFMLuDaWO=_n=fpStEQyaYP5hg@mail.gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)



> 2024=E5=B9=B412=E6=9C=885=E6=97=A5 18:54=EF=BC=8CRafael J. Wysocki =
<rafael@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>>=20
>> Maybe we can prioritize the initialization of the PCI host bridge to
>> fully eliminate this issue?
>=20
> The problem with this is that the current code requires struct
> acpi_device objects to be present for all PCI devices that have
> corresponding objects in the ACPI Namespace at the time when the host
> bridge is initialized because that causes the PCI bus to be scanned
> for devices and struct acpi_device objects are looked up from there.
>=20
> To make this work, the "ACPI companion lookup" code needs to be
> changed and that would be kind of a heavy lifting and it may introduce
> some unexpected enumeration ordering issues.
>=20
> Alternatively, the PCI host bridge could be initialized early, but
> without scanning the PCI bus which would be scanned at the time when
> all of the struct acpi_device objects are present.  It looks like this
> could be made work, but it would require some investigation and code
> refactoring.

Thanks again for your explanation on this. I understand that it may need
lots of work. I think it would be better if the fix would become as =
minor
as possible, because it would be easier to backport and more =
importantly,
the case where legacy IO device is used on non-x86 ACPI-enabled
architectures is really rare.

I'm currently running out of better ideas, due to my limited experience
on this part of code. I suppose maybe we can scan the ACPI device tree
in three passes, adding one in the beginning to pick out the PCI Host.
But we should deal with the case where evaluating the _CRS of the PCI
Host itself requires reading IO ports, since it seems that the
specification does not forbid this...

If you are familiar with someone in the UEFI forum, maybe this problem
can be raised to them and a clarification can be requested.

Cheers,

Miao Wang=

