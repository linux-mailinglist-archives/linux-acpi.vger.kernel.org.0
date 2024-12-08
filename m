Return-Path: <linux-acpi+bounces-10013-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415639E858B
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Dec 2024 14:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2871638F1
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Dec 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA5213B59A;
	Sun,  8 Dec 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvNsZ7s8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF0C4A3C
	for <linux-acpi@vger.kernel.org>; Sun,  8 Dec 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733666035; cv=none; b=RNg2Ojy71LpXTsKKPs87wpI+pDytOZngd9+3CcuaortSj4Awuv5Q7IXuDYIUQHh5bvhQpiHpiUTjEymY837hzn6/dSph9bWKjMvkQlC0InkePEMO+YXo+3sE7e8+NcfmJEPgB3flJYeKZxcic1bMcD/uzUKx8wGNmoOX8KsUhlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733666035; c=relaxed/simple;
	bh=eerFgtGd/HqSvsrzRLeFC5/NYF5/ni7FrBQR/PQyPh4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=M04y83cJW4NpR9ziyIM7Wq3Q+GzlV58CJZAU1H8d1j6E6Yr/yWeZ0KPpovKF9tBwbo7Sknt8tdPv8fla9qZKei46ek6p8G9hn15ndCvNQqpxAt7ZOBPPczFztjxihvPpDOGPsuWDJUA3W9B3AAGx9y4QHSztQTN+cKdrxCFu01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvNsZ7s8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21564262babso2442815ad.3
        for <linux-acpi@vger.kernel.org>; Sun, 08 Dec 2024 05:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733666033; x=1734270833; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5zr3V42aTZGJJxz5l78WQcpAPgo+zvGTkekdCXdeP4=;
        b=RvNsZ7s8I77g4BNBf86Yn9XJytGLl36ScC2Sfb5d1Qs3XodzwM9Ny+VCXp1zGjj+rE
         pfQzJSbIwrBSKsHe38aKocdpSLsYPph7rUoGzgwekntb3VFoj/uYRep/YaM6Jqshr1R1
         6xH5eIZc/mPCp100sLSpOfL098oxCqNmhNZkbIxJ6NhVpNv9t9PLWpm0hBP9D42tbNdf
         jjRIu65dhkr3jvaV6ErDoKmOjkbXb8Nb9hYxJ7m7hZEDSzvP0ntBSMbIlmVFwZVpaWHJ
         fWipqlyIztQUoYV26CNGOi5F7UBg56ZqG9C13yRybuj/KzCSQSPEotEXLs4WJ7ehS7TN
         tI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733666033; x=1734270833;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5zr3V42aTZGJJxz5l78WQcpAPgo+zvGTkekdCXdeP4=;
        b=qEryRC8S+CrAerQuDvxC0hpHrJHtrEGGNQGynYWNpxf9ab6SjZFm6RpRiPwiQ2G8D2
         li9o60GAxRG91LDxCrPaALMdFro3wHS7XlL5Q9cNM02yDLcnK1xcA5PdbnPWgJr3fCKz
         9FSkL98qZB2tC5HQHWRk42t1PzWbLap0IrgpiXDw9jeB4y0fBgfLyYYVO2xupu2+4zhj
         +f2VaXgmWrYLJjlNCifUzQWSrZ1aYtMkxNIiKyBvdS2oG3xLjYkkCI+bzi0KgqNdiQ7D
         qHMdZJrE3wviBqol19RW/yw6tsA2snB63Ej6xVvmZoPl2xt2LLBUC2SE2qNSTCmMOCh0
         AUtA==
X-Forwarded-Encrypted: i=1; AJvYcCUV074q5+VvhN/ns7Y4MSccIMFRu2v0T1hVx9eSzp+yt6GdTN1IDW30PzZGOUoZq6jyKOQ13+YwLuQx@vger.kernel.org
X-Gm-Message-State: AOJu0YwMu21UivL6I1AlJbs4QxLkwGsFIRALeomotEzZ1yDXWMzFkDdz
	APsUtrkki+7H9qdud3UgTexT13lNG9jMy/ojhxw0r3p4jRzbwyyiMJOTew==
X-Gm-Gg: ASbGncvPhZNWrX0u9zIL8Qh20CyNZQj+jCVQN7gKsbRkOWklRVoE79mC47VTx+cC4GB
	Y5grmRKxh1/T5+WpXOOLnsqHbf9yfbW45U5xaNYSiuVw2sYw43iquifZkBm1r9vQkJTNetoJsyH
	Th9mfjnTQWdLeCcuFPE/aYq1OD8WH+/bsxV7ssOpGCAiLMVXAPGx/CZ3GnFRwyjwMGkiRg3xMcD
	kjLlJ/uz6aDLQ8m0Zc7Z8Ys40B5qFT9ZbQ/6qZjxzs9IJ8+kDeDSS8h1EsGRA==
X-Google-Smtp-Source: AGHT+IF7gOXoukBRUGOW7WzT1pRXz7xO6PvHfxcp6MU8SsFsXaIgj1sx4L4TmmYJ75j53jQbwmKG1A==
X-Received: by 2002:a17:902:f54d:b0:215:5f17:4296 with SMTP id d9443c01a7336-21614d763famr49026605ad.8.1733666033363;
        Sun, 08 Dec 2024 05:53:53 -0800 (PST)
Received: from smtpclient.apple ([2406:4440:0:105::41:a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e61ef7sm57021825ad.95.2024.12.08.05.53.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Dec 2024 05:53:52 -0800 (PST)
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

