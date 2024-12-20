Return-Path: <linux-acpi+bounces-10218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A0C9F9B35
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 21:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D7E1607D8
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5952253ED;
	Fri, 20 Dec 2024 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ynu6OD7V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22F9222595;
	Fri, 20 Dec 2024 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734727595; cv=none; b=g4x8fnjKrJ+hrxImqvu9pR6K7oxEDiZGQHCa/jf9iPjtnFdswJPyRi7UyCihbd2RAufzjdZuHfRSsZJdRsiCo/4wp7DApVYY+uEEbrli25gIVrTmAR+fdsvSgDkf2qFacj/y50JPzRpaUX4jvqabAt6DDNzsNDTTvwxXV6LB5oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734727595; c=relaxed/simple;
	bh=uOQUOLRV8lDSQYSnQLBWdpa3VNa5i80x2mmrdQyqp7I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fBp6x457yheq1iGqSL8fXSyg4nVEUXz5+tqnrwn1yz3KcsmdIA9nlqBV7Skbzk72pnsd5bkhlhnl2NJ591eOr+QSkiNbxM09YGqp8zGJQdbCA2Diq8aK9C6E9W2pZ3wyPloy0+WkwgdAYw/38+ikd0WitY/U6hf3rKDg2cZ07Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ynu6OD7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B857C4CECD;
	Fri, 20 Dec 2024 20:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734727594;
	bh=uOQUOLRV8lDSQYSnQLBWdpa3VNa5i80x2mmrdQyqp7I=;
	h=From:Date:Subject:To:Cc:From;
	b=Ynu6OD7Vn4FbRZ5YMsV0wXtrHGx3zvu+ifqCv78Hu8j62A0PyIa/tnbbu+hjlJ6xU
	 yaOyqBJ0ScjD1t6KTpTwkL5iBYQw0AqZqxYfpvgvSQkBAEII1h5RxT7ss39I27AVCQ
	 G3rSeOnTxG4hi40/YFQKTfIFkeErJoG3qa+VVA/JyAOVi5j+YPVVg0sY+zu02Y78nT
	 PeyL/PdcTHbqGDMZoymKjxI4U1XueYk71ritzEg1mGEmPRXUh6ffC2v92DvPDr8Nn6
	 TdurXH16SwvJSQKuiTN6x6NEsKUIDhilQjtRbr9GdZA6LYNGzyN1RAdhKS8ZClUJPH
	 MJFrOH1mpAFow==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb7ecc3c54so1238057b6e.0;
        Fri, 20 Dec 2024 12:46:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcousXt8vqhjdQj7jsS/RX368ewFJ6VM6WBxzy+yii1tpVu3I68jkaLS8HDNE2PqXJlCAnIqKnOxUnJFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqGrfrrLTM9HLEOUMF2DI+6tPQVZaouFLLAub5JHleGpy+aVc
	r4E65jyu1MqeX6Srze/EtuLunFdQ8hXewTH3s3b50xFIIGdrHE4t819Zwof9qGf4TPtK0TIY0qU
	uNmHAEtv3e0JYzwIdgMrl0UXKRDY=
X-Google-Smtp-Source: AGHT+IFYiykY8+CqxwxV1zbXg5j2q7z9AJ5PtzCdQOeT+UrD/Cy3CMidEeLikD8eHv03iZvMzpL2SBtzmoQAyBlQtcY=
X-Received: by 2002:a05:6808:1807:b0:3eb:45e7:2bb2 with SMTP id
 5614622812f47-3ed88f8891amr2370235b6e.10.1734727593484; Fri, 20 Dec 2024
 12:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Dec 2024 21:46:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hO2aekS5K0o07h=+sK2+dK24+RVy1JbJMTYCZgw6zphg@mail.gmail.com>
Message-ID: <CAJZ5v0hO2aekS5K0o07h=+sK2+dK24+RVy1JbJMTYCZgw6zphg@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.13-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.13-rc4

with top-most commit 0674188f2f4d38d74aa863f17373d76256f2ed09

 ACPI: EC: Enable EC support on LoongArch by default

on top of commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8

 Linux 6.13-rc3

to receive an ACPI fix for 6.13-rc4.

This unbreaks ACPI EC support on LoongArch that has been broken earlier
in this development cycle (Huacai Chen).

Thanks!


---------------

Huacai Chen (1):
      ACPI: EC: Enable EC support on LoongArch by default

---------------

 drivers/acpi/Kconfig               | 4 ++--
 drivers/platform/loongarch/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

