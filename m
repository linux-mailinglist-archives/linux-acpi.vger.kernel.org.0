Return-Path: <linux-acpi+bounces-15894-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10A2B302AD
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 21:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C1AAC5E46
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Aug 2025 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7749A346A12;
	Thu, 21 Aug 2025 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6XOegMn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28C346A07;
	Thu, 21 Aug 2025 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755803515; cv=none; b=GAXasFpTCfl8wq+oVF1fvk2d+STNH5eCMjt0QrhSr81kp6B4O905LD/wsSJSN3NwLzdqLzpBx33WNZSHmfnw+T5j45/HGoVe8U2ATczZmBB4OdNzw7hYw69qjw6CymTxpfThi3UnFqVfdr/S1xgPY5OtKXvx/1du3YvCRol4cAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755803515; c=relaxed/simple;
	bh=9bq8TRH3pmMCgM4QGK5DGzweiXvoNbg1o7dd4OhY1NM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=h3tFfYg0Ms9bCrGYD04obWHdTh8D2WYPFDwJf2etZjbeokGu0+eDkIMOw8ny4NgzTLjbuk/PkVMB5LJ9YcDWMDPpZME3tZ3xoey+eujpC21yUtszt0mxQ9Vl3HCd7RBf5/H1KEY0dXQxLUz2kP1jiJJbrRDkdOTl/vmPKERb9wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6XOegMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB06C4CEF4;
	Thu, 21 Aug 2025 19:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755803514;
	bh=9bq8TRH3pmMCgM4QGK5DGzweiXvoNbg1o7dd4OhY1NM=;
	h=From:Date:Subject:To:Cc:From;
	b=T6XOegMnOIWccuN+2gbPEap4vsTFpGBHx+pIRluqNjqQZcBYxmQgqlrK5z3CKJkwC
	 4IatRkRSnyqowCxZWJu2dsDHXb4t0Qz/l1I2Y5BfqhTLfVLJuKedA9KrEKEprCi9Fl
	 /7x3dQtB01IA1q8X+NnfAqG74WAUQEPI8NVsDSpWh40MQrUU/uQkhFRGnKhoGd6ppG
	 zYtISmUu5E31SVBBUnJe1mUs7NrjXnzLVdHrLGGD46KRve16KF8KoIZV31aAfl/Fg9
	 QDhmoe7Guw75lhLBnvmhFW2nC+8/WwBNtm8zns6pGI0QVA61VmENI5bSXSZ/aCTyJc
	 EKnspLTwuwE/Q==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-61d9db7d6b9so460573eaf.3;
        Thu, 21 Aug 2025 12:11:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHerBYJSrPjSquej3Ll11ob1/8JAOWxtAn8EntwcvxoyoiE6CXVDBCzum6PZ6ghAQxhqXJXCfRgfJ29bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4hz4WF/R4KL0aihS5GmQPMTT15zXPW1SWs+0AC9iqSXRDbSzU
	f8NyComivwAWZHSzTrdaBWSgs6pMqQ9OkOyH8IjjbWkvlQ6tZZ/qHMWcPVYWy/YkJGQK5VFdUXo
	p8XWWVDz1CuwMt54pvy76PrXQZNjuIBE=
X-Google-Smtp-Source: AGHT+IH1aij3b5dMQjuwiUFz3Kya5f4PdgIe+096dkNPF0mD0NRrjz+OWIlLDIU/KmtK48XxPAWUAsEPbK8HnTfPmoM=
X-Received: by 2002:a05:6820:22a7:b0:61d:98a4:e904 with SMTP id
 006d021491bc7-61db9b430c7mr180697eaf.3.1755803514056; Thu, 21 Aug 2025
 12:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Aug 2025 21:11:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4Df7055nA_niXzhonrE2QebyQFzEFY5FVYb=M5F1B2Q@mail.gmail.com>
X-Gm-Features: Ac12FXwA_MimmHmtrBoUB8L5MzATnXzYlrSVwb9tbsEsBx4sTx391jj1AGVJMQ8
Message-ID: <CAJZ5v0j4Df7055nA_niXzhonrE2QebyQFzEFY5FVYb=M5F1B2Q@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.17-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.17-rc3

with top-most commit 670b51121ed09ff3a41539243407e4bd52eea9f4

 Merge branches 'acpi-apei' and 'acpi-pfrut'

on top of commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9

 Linux 6.17-rc2

to receive ACPI fixes for 6.17-rc3.

These fix three new issues in the ACPI APEI error injection code and
an ACPI platform firmware runtime update interface issue:

 - Make ACPI APEI error injection check the version of the request when
   mapping the EINJ parameter structure in the BIOS reserved memory to
   prevent injecting errors based on an uninitialized field (Tony Luck)

 - Fix potential NULL dereference in __einj_error_inject() that may
   occur when memory allocation fails (Charles Han)

 - Remove the __exit annotation from einj_remove(), so it can be called
   on errors during faux device probe (Uwe Kleine-K=C3=B6nig)

 - Use a security-version-number check instead of a runtime version
   check during ACPI platform firmware runtime driver updates to prevent
   those updates from failing due to false-positive driver version check
   failures (Chen Yu)

Thanks!


---------------

Charles Han (1):
      ACPI: APEI: EINJ: fix potential NULL dereference in __einj_error_inje=
ct()

Chen Yu (1):
      ACPI: pfr_update: Fix the driver update version check

Tony Luck (1):
      ACPI: APEI: EINJ: Check if user asked for EINJV2 injection

Uwe Kleine-K=C3=B6nig (1):
      ACPI: APEI: EINJ: Fix resource leak by remove callback in .exit.text

---------------

 drivers/acpi/apei/einj-core.c | 17 +++++++----------
 drivers/acpi/pfr_update.c     |  2 +-
 include/uapi/linux/pfrut.h    |  1 +
 3 files changed, 9 insertions(+), 11 deletions(-)

