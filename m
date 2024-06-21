Return-Path: <linux-acpi+bounces-6568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D607F9125A2
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E7C1F2432F
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B9715A49F;
	Fri, 21 Jun 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDZrxKG3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39615533B;
	Fri, 21 Jun 2024 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973487; cv=none; b=lWSgNipU6XGvkNa9qVh4VN61tah2KFW1D+viWke7Iw3NPRyUAs1eRbGd7J7VUwRQfL1bZH+ciJ5f+9FS79DytxxeLVXmm0ituj1/B0PsESoyeMWLKDHud7dq8sHNq7mQhAHiJPwptpe19zatUtI6fAQ60OL8eLEXfZmuY/uOebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973487; c=relaxed/simple;
	bh=fAXK1QgzF7LJbbeA5R35QOZgboVtLdgjHBnUyDFNMHI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qnv/synegcJPphA0NeFTzEuEYtm78C/7OcfAnasOx+YeUaJHJ1G+pj/PaYmyHKRHc6xFjzZz5NxTEJEaYBsmRHAfbm+GHsJx4ZJJP24mDOHCIcoN8oASm0idQtwmah3bX010zOKxERaxg4g+PoMVI1XWYE3JdtrU02T5BOsziyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDZrxKG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E638C4AF08;
	Fri, 21 Jun 2024 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718973487;
	bh=fAXK1QgzF7LJbbeA5R35QOZgboVtLdgjHBnUyDFNMHI=;
	h=From:Date:Subject:To:Cc:From;
	b=MDZrxKG3ns/oTJqeoBXfR1rQqkcAdIS4h37JVmcwJoK1k3TN3mhI+CmJEogD6wiqF
	 cLeXi+74szx2yJscg3PcC7MATIcE49fSKMJure1AR619OWjUJuB8hi/VLkf9jxAzq7
	 TfoHTTruGJkQigl9EcwwD8d1z8k67rXIHXgrfhXwtFTT/mZ6JS8l/TjcdXi94AfXS9
	 pX/u2W7D5ju8BaHrIUnYz8ZpfLvunGa6tnyaQ8Csz5nd2ksttEPTkFiMHNZ3iV6rxH
	 cYrCUeuudf1Knp7JaPAby0MmU07PaumM4sNhjRsXvajJ36pYl0HxpfaR1kELTNdu/U
	 l4vjpbz/TH+qQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25989f87e20so105390fac.1;
        Fri, 21 Jun 2024 05:38:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtBj6SS5Cw+imr+ykC8myruQlKc4MMlaYPva19ACm+FCe+1qdKuTr4FAUYABE+qbTHAWSnMSu38Yz3ZsLqIa+Xvi6iT9r4gIIroczt
X-Gm-Message-State: AOJu0YzHRQ6dtbIOyCN+tYOpFvhjuwf3Y1PDD2+tGrzh7clc05TqXg+5
	dGln5MhvagxnLpoNLBgWM7lo4oiK5jSWU9xbJv8hk2BECmHmytRP/LmS+RUCnviugeWe/BHSHIz
	WBO1QC8ivoo55TLBNEN0Ns0qGLHc=
X-Google-Smtp-Source: AGHT+IEvK1oAnwrbimNpWmSccBMH9H+LvKSnFMn7lW1TvK4q5pvihD8xYvOK49umzp6s0L8Qngo3N5L3uyX2xssuk0g=
X-Received: by 2002:a05:6870:148d:b0:258:476d:a781 with SMTP id
 586e51a60fabf-25c94d52e3emr8982429fac.3.1718973486633; Fri, 21 Jun 2024
 05:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 14:37:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jiAQKKgOdqwmWGTMHWoz2Cf_P8ASU9KxWbFCN=7EgnnQ@mail.gmail.com>
Message-ID: <CAJZ5v0jiAQKKgOdqwmWGTMHWoz2Cf_P8ASU9KxWbFCN=7EgnnQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.10-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.10-rc5

with top-most commit 5e409a29171c5ce22d21d5b0ae88bfce780643ad

 Merge branch 'acpi-scan'

on top of commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f

 Linux 6.10-rc4

to receive ACPI fixes for 6.10-rc5.

These address a possible NULL pointer dereference in the ACPICA code and
quirk camera enumeration on multiple platforms where incorrect data are
present in the platform firmware.

Specifics:

 - Undo an ACPICA code change that attempted to keep operation regions
   within a page boundary, but allowed accesses to unmapped memory to
   occur (Raju Rangoju).

 - Ignore MIPI camera graph port nodes created with the help of the
   information from the ACPI tables on all Dell Tiger, Alder and Raptor
   Lake models as that information is reported to be invalid on the
   platforms in question (Hans de Goede).

 - Use new Intel CPU model matching macros in the MIPI DisCo for Imaging
   part of ACPI device enumeration (Hans de Goede).

Thanks!


---------------

Hans de Goede (2):
      ACPI: scan: Ignore camera graph port nodes on all Dell Tiger,
Alder and Raptor Lake models
      ACPI: mipi-disco-img: Switch to new Intel CPU model defines

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your
kernel is fine."

---------------

 drivers/acpi/acpica/exregion.c | 23 ++---------------------
 drivers/acpi/internal.h        |  4 ++++
 drivers/acpi/mipi-disco-img.c  | 28 +++++++++++++++++++---------
 3 files changed, 25 insertions(+), 30 deletions(-)

