Return-Path: <linux-acpi+bounces-15032-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C83AF9BAA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 22:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421F71895904
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jul 2025 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A848231CB0;
	Fri,  4 Jul 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsFbVSDC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DA42AA3;
	Fri,  4 Jul 2025 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660644; cv=none; b=cmIK1wOdKbt4OQ6KR1PHo9PQ1wgP8UxBz7D49lcMvrMQ0rCv11Rax1bCrIYoouY4lliMxQUvRX88yQJ1KZrF4nCIcTqSqF4x6tLRoiltsPge+vr36nuDOEBhSzaKOvkDEE5rfukB8zB+ZF0WtTaWJCPwT0BfWrs42Ai7hqR16wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660644; c=relaxed/simple;
	bh=Q21PofIgBP9dI+Tfz8rPgeX/piinRsHxz0jawEt/xO0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bRvD3cwV/8tXzhF4XuplHGdEOR5JB1FPwyY6Nf46kbLSwBizkwDQeTIAISD6XyUVxm8WZxk7VjB92uhJPW5Qakdv75CVhpmVVl1f8KXr5051kHdn93PLDG3Ns/DnJCk9rMKfIV+35mpAK++6qTFgOspy53s4ErF+Om6xG1tXFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsFbVSDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D0C4CEE3;
	Fri,  4 Jul 2025 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751660644;
	bh=Q21PofIgBP9dI+Tfz8rPgeX/piinRsHxz0jawEt/xO0=;
	h=From:Date:Subject:To:Cc:From;
	b=LsFbVSDClyblFMpaOq0PlfjgmONGSUWpr9UTpYtTAIvHiBnkFLYSOzVMRfFd5l3FR
	 vzPDpwWCc3WLPxhQw5eHOdKEj4p0i7OyvbuNBe3ytHbUXx4m6mpCziNKkei77maeIj
	 S8VMBI43VL9X5r3sJT+HabvnsrCpMVYr0AiWRPz08Z8P4BNGKqnNeVLA5pvBpaYnqa
	 QJOeEeLm58/G9nVdWZnehFi+T/VytR5nguGPTDv+DRz+1aMB2qzXeWEPIpZkX3aFnN
	 99JPPSoasREqVy6SBP1HxEyMrWklg7jucKZX/1QSoKCXPEFe9ZQ0PfaIHLyC+SShk+
	 kxTFGoHwwu3ew==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73afbe149afso842559a34.1;
        Fri, 04 Jul 2025 13:24:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVayAkSbgbe3kUzESrfoLWeOXXBcj9BLquKFlLeJ4G3P5V/PEPcJgvCituVuAZm08FsvQcjTfKdQx0=@vger.kernel.org, AJvYcCXnscdgLZKd5yQIYA7XD9acVFecm4i2JS08eFeBkPMNMHv0IRRHuJMTdKzfgHNstxPRLi5XpxYJFCUm7PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznowua+blWghtP+HJngCA1A7rO0vsR28+wY0pcXEd1Y0yViTqs
	Nm10WVYFO29kcJiVYLYeRRuFvm9rXKBu/U3nkxdr8cX28b/Yki5oEEJrb86V1H8A/fTTf21Z6SC
	+e5Zk1z4Xr0bn+Yysgy4id9XTcGyc6yE=
X-Google-Smtp-Source: AGHT+IE5pb/BmkLzpIvx4ESVIlKFMogctVtXGNtSme3P8OHYRfDDrgjqzb2SRaHfJFksA/nXHw/s2nVy+mh6z+5Y6Kc=
X-Received: by 2002:a9d:3e57:0:b0:73a:9f43:6395 with SMTP id
 46e09a7af769-73ca6717da8mr1665496a34.19.1751660643664; Fri, 04 Jul 2025
 13:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 4 Jul 2025 22:23:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSU7CZ1PHB1-3ff-sBPt8SzhaYo9LNDYNPWzKG1DPq4Q@mail.gmail.com>
X-Gm-Features: Ac12FXxTeYCy7UIMQC3O5GECFn4LVyGmT15wSPoVHIYgh7kgcG7tC74QIfra0zw
Message-ID: <CAJZ5v0jSU7CZ1PHB1-3ff-sBPt8SzhaYo9LNDYNPWzKG1DPq4Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.16-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.16-rc5

with top-most commit de1675de39aa945bad5937d1fde4df3682670639

 Revert "ACPI: battery: negate current when discharging"

on top of commit 234f71555019d308c6bc6f98c78c5551cb8cd56a

 ACPI: battery: negate current when discharging

to receive an ACPI fix for 6.16-rc5.

This reverts a problematic ACPI battery driver change merged recently.

Thanks!


---------------

Rafael J. Wysocki (1):
      Revert "ACPI: battery: negate current when discharging"

---------------

 drivers/acpi/battery.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

