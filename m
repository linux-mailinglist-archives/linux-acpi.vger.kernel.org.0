Return-Path: <linux-acpi+bounces-13755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6EABA0B1
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 18:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF27AE329
	for <lists+linux-acpi@lfdr.de>; Fri, 16 May 2025 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87538137932;
	Fri, 16 May 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXFneLah"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF81FAA;
	Fri, 16 May 2025 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747412168; cv=none; b=Zcrud36wcGWJtIM9ygMpS01B/2REypYz1AhXtvEVYLqIlkWwTBkilTTOurCQGLrOVVyeSF36eiqE4gc2IrZGwx+HhFLoxQeTZBXGg8bMnITmwCr8/aevUEw/UP+q6YVDmdyfrCeBiFiReHu9YqqNAuLXSCFWzeJHHkKxxZ+iRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747412168; c=relaxed/simple;
	bh=yjD13qd8TH3MTmxXGa6HwrUxPQnDRVChHd1GPusVJr0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uN3qpxqju9TxFE0BXMl2jLZl/wfKslcz1tKvpQreDYAzjkUN/Mj8m1gQx/zPpg5z6O8+7H6EaBwjwXZndy/lCkudFTYaO7A5x/UwL9lejVOGEi/o2M044eGJLZil8K/PtW5hL7up46dvfMxbZZz3RXPkYnZL2fSTX+T7AoZLG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXFneLah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8D0C4CEEF;
	Fri, 16 May 2025 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747412167;
	bh=yjD13qd8TH3MTmxXGa6HwrUxPQnDRVChHd1GPusVJr0=;
	h=From:Date:Subject:To:Cc:From;
	b=ZXFneLahaNsa1axN90QbHt9Jugmv50OJdblzGLfGpqIFnngw/VJXZiqBA8/JgNvdf
	 LrmbMRDFj5QYkuHZYD+bRkchgxMBk7zz9DTtZVHIGfhPB0oXUvQ7WmbDo3d3JOD8zn
	 /kR9E+P+ZM27vJyjolssb9eOMlQt4hU0NHg674H+XnrGyJ3DTantLn3XDLEIZMgZKZ
	 lpoIH5L1+NBoslFvBE1l4XSOMlUDnqMhIvYOdmXHVnKQRbt7GWdbM/CZ5KQ8ZwsF7d
	 NY9Fl7LXRFp14rFhwONhfmMPVrLXY7QpV2w3d1nthY/j/Oci1GGWIQVXWRb108a8at
	 Sb7/Ks2R4d+aQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-605f7d3216bso737020eaf.1;
        Fri, 16 May 2025 09:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXxUqj2jgrlYz2gmkdBFAiEK2EG3aJkcUyW56QBcoVmFWdOCopQLGUJJBJWgP6u/8KWUzx5wcz4DaW8eXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqbVDuOZd0hDWedOcgr9MBDmR5WDMU2OsVhZ5+YtFQs4uCUF30
	8YXMowM1y+a0Pbyw/qCPJBD6yA93ZlrdeclGfDHatUhRcCpbf13efdlgYeq4IYgMNG7OOVZb49N
	NmF8szzY2ME5hbzOG5cLguUXcC/apfAY=
X-Google-Smtp-Source: AGHT+IF3NFxCjmzUF7rlTm405mQS1/usElZoPbU+64c32LTOYfvoWKpq7JVwh4LUOFXzlx4RepwS0ytrkeLKujPcy+Y=
X-Received: by 2002:a05:6820:1896:b0:603:f903:c85a with SMTP id
 006d021491bc7-609f3736881mr2120181eaf.4.1747412167116; Fri, 16 May 2025
 09:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 18:15:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8HbDaYStdN-isATh-+gPM2ztacvvgdux1WHy2aiiSoQ@mail.gmail.com>
X-Gm-Features: AX0GCFt8c8zb29qic_Nvq8ZGhU_v4STg0J4BORTdTS4YuXzyt3Dpdw9E5wXeOes
Message-ID: <CAJZ5v0i8HbDaYStdN-isATh-+gPM2ztacvvgdux1WHy2aiiSoQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.15-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.15-rc7

with top-most commit adfab6b39202481bb43286fff94def4953793fdb

 ACPI: PPTT: Fix processor subtable walk

on top of commit 92a09c47464d040866cf2b4cd052bc60555185fb

 Linux 6.15-rc5

to receive an ACPI fix for 6.15-rc7.

This fixes ACPI PPTT parsing code to address a regression introduced
recently and add more sanity checking of data supplied by the platform
firmware to avoid using invalid data (Jeremy Linton).

Thanks!


---------------

Jeremy Linton (1):
      ACPI: PPTT: Fix processor subtable walk

---------------

 drivers/acpi/pptt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

