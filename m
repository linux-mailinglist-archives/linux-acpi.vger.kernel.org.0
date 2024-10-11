Return-Path: <linux-acpi+bounces-8720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DD99A7EC
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 17:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087D0B212C1
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE964194C78;
	Fri, 11 Oct 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8ieCERo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C19194AF3;
	Fri, 11 Oct 2024 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661011; cv=none; b=G+V/nreNUckX6CECgDIFc0LQlWizKcgKn9i3CpAwJdpiDjxmOeuzm4O7egMg2Oj1lnljaC7rj37/vY+ntEgB7X1GguNHpP45tAuk8VWzr8/W3Qs1fCrMN8hKU0H4vw7RXzEXYHOZ91cWNtqE0KGJzIhTrlK977KU9Tje+rt5tT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661011; c=relaxed/simple;
	bh=2e2aAbeHFM/XJiLOLYfo31xFHP9CBo1V6ggyJGJuMZQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YYJ5uIyiCYb/t9N73TMHV/sbDdsn8bxurljugFyYl+UoPEMxidKL3E7DjouXspKxvrMzhSF1U4ZAS+lCjPGxQ/AYUAOgzXSy1H7XagpPWp/iUSPXO4i2h5Di7wEAYDaPP60yEmixafw5fM+a0QhtsqwJSV8Htu9A8/Se8CGh7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8ieCERo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCDEC4CED4;
	Fri, 11 Oct 2024 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661011;
	bh=2e2aAbeHFM/XJiLOLYfo31xFHP9CBo1V6ggyJGJuMZQ=;
	h=From:Date:Subject:To:Cc:From;
	b=J8ieCERo1jePD8yOJ5b7CBpot+4B+EvucrEG0wx/ZkLNJJIZteAUKmewCo5Y+HHAZ
	 F1MsHJO5eAmqYf652+oNcACL87pHynefR2b887tD41BceMxgQUaT9ZBVSgysA7ldsX
	 6QS+kBsjnKKB6EY4so0y1S/KTQ5lahXA2Z/gsJmfmEmSTvP2o2FoB+ZcszLU1cMrK6
	 ry/IFi0k1XRQu09wEmeeiwVSNd5dhXUkfcBjG8f8WOItIwCEDuiCE/iUegJ3PmeRrE
	 Q3I26Fb6JFL+348AQEdtAMu4sb/jAxLy4mkJkAyHxtHA2mVy2YJrmuFZZOmGuNVKTv
	 b0mf7Z35JUkBg==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e4d624ac28so1374069b6e.2;
        Fri, 11 Oct 2024 08:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt9Qu2TTr2KXf50arKOpDw0rSWYsPo/3ptKsdGOIpPbt8GJXPfuo+Pv9A56V9gsdUnuv8KbmeCgHmSdlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYt/V+/IXD8tXGVxWtsn45j1sKYpgWHFHiAIiBmLO71Qjv69S1
	Zd6FXOr5i3qGQ+tXirV/bkHDneq4bSxAI7gTyLziqPY5ZMTMMPOrQMgk8669qEZ7VlVX5a4Z9a+
	2jnSrsPK6BgYb3G+ZrNF84HWFL2A=
X-Google-Smtp-Source: AGHT+IG5oYqdHeubz5datcEne84s3DCdCUh6B1Z9T5VGnQ35URrQQWnEGK/GMqPZUAU6nSgCEuNfcKSl3qxkR5zQ0A4=
X-Received: by 2002:a05:6870:b6a3:b0:287:130e:f665 with SMTP id
 586e51a60fabf-2886ddbabb2mr1959804fac.16.1728661010551; Fri, 11 Oct 2024
 08:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 17:36:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j9MrSTXS-uZxNy=hfx514QdBCqFQ25tC0nVV-URX2xBQ@mail.gmail.com>
Message-ID: <CAJZ5v0j9MrSTXS-uZxNy=hfx514QdBCqFQ25tC0nVV-URX2xBQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.12-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.12-rc3

with top-most commit 1af7e441feb08cdaab8f4a320577ed0bba1f5896

 ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together

on top of commit e1043b6765d6ca310a10be342e25d5451d58ee53

 Merge tag 'acpi-6.12-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for 6.12-rc3.

These reduce the number of ACPI IRQ override DMI quirks by combining
quirks that cover similar systems while making them cover additional
models at the same time (Hans de Goede).

Thanks!


---------------

Hans de Goede (4):
      ACPI: resource: Make Asus ExpertBook B2402 matches cover more models
      ACPI: resource: Make Asus ExpertBook B2502 matches cover more models
      ACPI: resource: Fold Asus ExpertBook B1402C* and B1502C* DMI
quirks together
      ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together

---------------

 drivers/acpi/resource.c | 76 +++++++------------------------------------------
 1 file changed, 10 insertions(+), 66 deletions(-)

