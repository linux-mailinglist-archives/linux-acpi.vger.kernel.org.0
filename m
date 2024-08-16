Return-Path: <linux-acpi+bounces-7631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC38955018
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 19:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555CBB2594E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2024 17:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862851BF322;
	Fri, 16 Aug 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNts9R3g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6AF1BCA1C;
	Fri, 16 Aug 2024 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829770; cv=none; b=B/pXxgNbA476m+Uy2B69YtyfNHSlejrAKIaf6JH+9HIjABWAHUcI82wzH0/zKn+XWA0VCM+W4pM+Ap5uhP58TYx0PSiIljCJxS99MssPt9ZxeUKsBpnUzUUXL75KpLhV+stpXYpvBvvNWkGhLyrqs9P+yFo7oa131BdhwQkrr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829770; c=relaxed/simple;
	bh=LbWAum3TDMTF23ROfbSuNdhCdQX40RA2+0HqRc8JVT4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DzBWc7fsU2vmOp92dS7rVrcLQx8+Lde9onj2j1Yoyy1eIhox1NVat0NA99WqrxF5iPSd5ChZkBt3fxXtLaCEeJpu/0G/NdQhqaO86ouMWXj1B/BjbYaAh1mQIOt/hJpNMi2xPQytfHej/vjvUzdGctJWhaG1eAJJs9bhC0SB558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNts9R3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E16C32782;
	Fri, 16 Aug 2024 17:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723829770;
	bh=LbWAum3TDMTF23ROfbSuNdhCdQX40RA2+0HqRc8JVT4=;
	h=From:Date:Subject:To:Cc:From;
	b=HNts9R3gnNqA5GUB0G07xqxsoL7SNSM0O105rmvUufeLAUup6JLFgkp/BqLmc/K3n
	 N72tHhYCFVVYWaMW5T4wY0uk/+dmEKiEPYyVldeeZKtj+u0EZmGzBK0bNgWbmYdFe5
	 cKBjBCwue/ASPZWxd9fnYYK4C1kK+0J/DwfPuVhIqRSp9FxDYhd7ri5q3i9PejfKpK
	 VNY6fh16SDBGeqlY+ZwRH6AMshQYPChhUgc00xUvo6yBNNngsTdtEcMCfmGvax6os8
	 7HgwoD2/I7kEQr+U6ZJbjafIsu89rD5ew6NLNhAasaWEN+eyikuZ2hTbeGm8zIfzvR
	 8EBJ/X1a2pmOw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2644f7d0fb2so266358fac.0;
        Fri, 16 Aug 2024 10:36:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaPxnfwc9GfpmJVU6rxgxIKNpMEHfhe5TzZWHalgBj+vxETXlK/+q5qW7bnklYedkBZxBsg4tmFgSKgRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQwzu8cypuJF8lPjs9xi4C6i9/+bSrWh6xYKwifHc8kkkbAQ4
	8I2EV57rdZm6FBS5c3sIrRGFyhEl70xbXxTXCRhKh/LEQd072mgAsNU6shhO1Uh/kj95J/bJl4j
	Wvg31YC652G4Rg+MLO+m1rD/nrlE=
X-Google-Smtp-Source: AGHT+IHVIJTonjQL1VVXDILSwPotqkcHnZ5uGJdZSl5fopqgZlgLKcMu3FawxBIFcv8XRYl1PU7J46MSJtYyvGmDJ08=
X-Received: by 2002:a05:6870:a489:b0:260:ccfd:2e52 with SMTP id
 586e51a60fabf-2701c564010mr1933458fac.7.1723829769494; Fri, 16 Aug 2024
 10:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 Aug 2024 19:35:58 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9-phbMjZmrY36p0joOFhJm9-op9uRs3pdE=cpO54cpw@mail.gmail.com>
Message-ID: <CAJZ5v0g9-phbMjZmrY36p0joOFhJm9-op9uRs3pdE=cpO54cpw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.11-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.11-rc4

with top-most commit 71bf41b8e913ec9fc91f0d39ab8fb320229ec604

 ACPI: EC: Evaluate _REG outside the EC scope more carefully

on top of commit 7c626ce4bae1ac14f60076d00eafe71af30450ba

 Linux 6.11-rc3

to receive an ACPI fix for 6.11-rc4.

This fixes an issue related to the ACPI EC device handling that causes
the _REG control method to be evaluated for EC operation regions that
are not expected to be used which confuses the platform firmware and
provokes various types of misbehavior on some systems.

Thanks!


---------------

Rafael J. Wysocki (3):
      Revert "ACPI: EC: Evaluate orphan _REG under EC device"
      ACPICA: Add a depth argument to acpi_execute_reg_methods()
      ACPI: EC: Evaluate _REG outside the EC scope more carefully

---------------

 drivers/acpi/acpica/acevents.h |  6 +---
 drivers/acpi/acpica/evregion.c | 12 ++++++--
 drivers/acpi/acpica/evxfregn.c | 64 +++++-------------------------------------
 drivers/acpi/ec.c              | 14 +++++----
 drivers/acpi/internal.h        |  1 +
 drivers/acpi/scan.c            |  2 ++
 include/acpi/acpixf.h          |  5 +---
 7 files changed, 30 insertions(+), 74 deletions(-)

