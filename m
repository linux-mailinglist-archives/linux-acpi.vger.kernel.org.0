Return-Path: <linux-acpi+bounces-12979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C8DA8609B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A1B1B81499
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 14:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E361F4CAF;
	Fri, 11 Apr 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkccE8nC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6901F417A;
	Fri, 11 Apr 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381811; cv=none; b=Y4vOCFSuTb+MU6VSgrDZXzlyT/6Mf+Lec8AC1olhpb76I3t9msFJ2dHt0HWHU59R2G2VJnQPi5F27l2icIPKXpaq6WPcitUy/b2cTasVRwQzobssH9848EbEj6BimyyGdt4DWofXz2aNEP8M1fku8PKKbY+EsLADjPer84xAncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381811; c=relaxed/simple;
	bh=aKErMgxVbs+xUrWl8vNAgJtDuFNx5da5an6Q5t47O+A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eeFVcbLycFk9LpafYh3ipczQbMxrTZcVEFQtwbwastVDUNC0Mi/m78M9wpdBr+xUbfikBXaaSChcoY1xLhOcLqyDp/4vu7dYnw/c0ub9uZJVXrOTGkix9HyewmqGIES0GQhr6PRdE+Lm37uwGTF0pMnGqNQgCsmTpOUzjwucsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkccE8nC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF01C4CEE7;
	Fri, 11 Apr 2025 14:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744381810;
	bh=aKErMgxVbs+xUrWl8vNAgJtDuFNx5da5an6Q5t47O+A=;
	h=From:Date:Subject:To:Cc:From;
	b=SkccE8nCAgIjIQ1vYKumzUm1/ywjp1658zPJqMD07gn55b2wogMIeLlqeXWtUBEUW
	 kWW2pR+teLTvPH6k6c/ykxmCfHam83NX5FoWv//APw7fFpsY9GocZtklAVYNqF2ZJi
	 yjc6CWWZ86XEmEiJW4Nz5VCT0PN58JDa9pjHzaMx90eY5gFT+mt3ZaX4t+tL1JGjXq
	 fQnd4eZokiQdNvjm5RSmpNk/8K230RZkEYTtqcRKVsMIu/5W5hOroEi4np5yANtz+2
	 l2IeD+u+kF0YttGqY2Snx3alNcVvryCSoDrGhw9ig/qoL5WoSr7lboV4ds/qsrBY7z
	 x/CogI6gmojuA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d0920c6f96so1182540fac.1;
        Fri, 11 Apr 2025 07:30:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2NpUuHsKkcIZKtrf0jGB9ko5QmOGgwcVUZM5ge8MtzRX+9KSzI4nEDFSbb151hthoSevMIwO7x3NKdSw=@vger.kernel.org, AJvYcCVfS7wasbJP87aaacIbaXauislgG6/ztHYDcIfOowy5e3zlm//c/7lksP/28ZjiGwrKzqx4cffF8pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9wmXwUCZ6LkNDc+nyfnix1IJ4JeOobCWGzGhI5ngf95VOJIG
	8HaHuLavyLl5uAa53vXhIiTse89QdPwFQwynqMJuXcJxFc6T8YM4GDc+y3Shhc+2uL5gvGQ0Pq2
	MBOoscOaHiAVXqcC8i7OdS7XsKbU=
X-Google-Smtp-Source: AGHT+IEKLQVgQGIDC6CoyMs0cDrFKXnGh6FRKItdtN8Q1MNXaMGq1BH3zAGp41hrmMb9/IXA52hdZFtn1qFuE9tMVsk=
X-Received: by 2002:a05:6870:6f14:b0:2cf:bc73:7bb2 with SMTP id
 586e51a60fabf-2d0d5cf3960mr1730677fac.14.1744381809589; Fri, 11 Apr 2025
 07:30:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Apr 2025 16:29:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iEn-Lyic6zxDehxF1HHfNfg11_S7COMsHnZeQ+TzZAsA@mail.gmail.com>
X-Gm-Features: ATxdqUE4Uv7yWFaD_KWqchTFzOWSZpHH0_Dmpi-EtzCnNuJ0_TkNVLmU64PwDcg
Message-ID: <CAJZ5v0iEn-Lyic6zxDehxF1HHfNfg11_S7COMsHnZeQ+TzZAsA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.15-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.15-rc2

with top-most commit dcc4aca53338d09f7b3272e00aab4a1ff8c69067

 Merge branches 'acpi-ec' and 'acpi-button'

on top of commit 0af2f6be1b4281385b618cb86ad946eded089ac8

 Linux 6.15-rc1

to receive ACPI fixes for 6.15-rc2.

These fix a recent regression in the ACPI button driver, add quirks
related to EC wakeups from suspend-to-idle and fix coding mistakes
related to the usage of sizeof() in the PPTT parser code:

 - Add suspend-to-idle EC wakeup quirks for Lenovo Go S (Mario
   Limonciello).

 - Prevent ACPI button from sending spurions KEY_POWER events to user
   space in some cases after a recent update (Mario Limonciello).

 - Compute the size of a structure instead of the size of a pointer
   in two places in the PPTT parser code (Jean-Marc Eurin).

Thanks!


---------------

Jean-Marc Eurin (1):
      ACPI PPTT: Fix coding mistakes in a couple of sizeof() calls

Mario Limonciello (2):
      ACPI: button: Only send `KEY_POWER` for `ACPI_BUTTON_NOTIFY_STATUS`
      ACPI: EC: Set ec_no_wakeup for Lenovo Go S

---------------

 drivers/acpi/button.c |  2 +-
 drivers/acpi/ec.c     | 28 ++++++++++++++++++++++++++++
 drivers/acpi/pptt.c   |  4 ++--
 3 files changed, 31 insertions(+), 3 deletions(-)

