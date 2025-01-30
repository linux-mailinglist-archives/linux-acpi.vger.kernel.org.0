Return-Path: <linux-acpi+bounces-10868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641F7A23652
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 22:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECFCA7A18F7
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9931EF09C;
	Thu, 30 Jan 2025 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkdTbpXo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5D1AC884;
	Thu, 30 Jan 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738271206; cv=none; b=r8WE5TtjOk7kghZ24m+eIMvWquGAkCydtTVNIC+x1QhknrNaCGa9dNiXOSp+YtW/adECzPmiAj5nV4pXWT6EbB/Y8XpZ/42svbnsh/D0boR99OTE8iM9ftknRGupMADTIZEMzxF3JVWpUG+JbfI9DludCcDCY6Ze5HnNs9zRopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738271206; c=relaxed/simple;
	bh=uKOu5xoHzaHq9aArS/2GZ9s3Qm3F9AEuVkbisnOrqoI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bcmwNJmdAvexkavNdKM7u+AWQecjY+9oJEKTCzrNumvh6BPLmVlIOCsZU9+79N6Z8tLJLGMeYxE3gR7og7+C+/S6jBUB9kryv3hbuFIcp8EZIsDMtJ1yVfl5WkNc7Wv23JDBYv5AqQE0B1bzdox3HJhukw1zBKm20L5WvGkhnWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkdTbpXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5336C4CED2;
	Thu, 30 Jan 2025 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738271205;
	bh=uKOu5xoHzaHq9aArS/2GZ9s3Qm3F9AEuVkbisnOrqoI=;
	h=From:Date:Subject:To:Cc:From;
	b=AkdTbpXoV6j82sLw94JUroFXeB8elyv+DCQT+hnTZhrNn8d5D/v6wkJM3sfRGqHG+
	 j+ikK+lj1aawDnUUnEe+NlE6kOyZFspYDFbrCeJdlptd/yKjDrQ3BRu5PGVMT05R4s
	 P29+Dp9BfTlarNBVBpFpmPfJevVqVGLMCdPg4o6I+1yPZBC5NejW5SUQChWegwcfVg
	 FwLIP3GG/uUN46i/3j0bbhyrez6/CxY50+601yfNfD2bGOjBSgPcUX8fR+U2rCbbi+
	 P64xoLriPXCm4xrJX7DfY/FuU5VHNOmFou0ZbH3clVyHa020uO9A7iyhf/Eeg009WQ
	 NXSPHgsVnAeSQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2b1f7406e49so538618fac.3;
        Thu, 30 Jan 2025 13:06:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5Mt3f1pgCrh5mZiLegLxyW5XpSmRgg+pQs+96m1h/QhnWmBTYXYAvdJHiHU4NHLqcuEb8XJsVRiUziKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rJ3sAc0BGxFezhSkK7QeheU6e+vIMkeufoEYAbPK27NMgrpy
	KbgzNTpJ1VU1OMIZ2kFgAFGfvyJybkoeuyxbiGCYSgHo5tJVx2X2lm1KOIwPfFUb/Nz/hZT9nfn
	0oBiWf6V/QLTJgcrIZgKGxgh0xes=
X-Google-Smtp-Source: AGHT+IHvXUTarGMYeOaKKsW+FN3QwtQv2QpSGOZ23ZRLPE5CzPFtcgCvZSOOCJ7H6AXnol9+HR1kh2qnv8rowRMDuRA=
X-Received: by 2002:a05:6871:538e:b0:297:2719:deb6 with SMTP id
 586e51a60fabf-2b32f0997bamr5266199fac.1.1738271205069; Thu, 30 Jan 2025
 13:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Jan 2025 22:06:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htsHzumnajMzcndHi1C1SjxQXXZp6Sg4qo6mnkftHUng@mail.gmail.com>
X-Gm-Features: AWEUYZn2FeCVR0sHvPIe_QR3ehy2o7_H-nv_bLEDhZD3nCeLHyBl1qcK8NwADN8
Message-ID: <CAJZ5v0htsHzumnajMzcndHi1C1SjxQXXZp6Sg4qo6mnkftHUng@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.14-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.14-rc1-2

with top-most commit 0141978ae75bd48bac13fca6de131a5071c32011

 x86/acpi: Fix LAPIC/x2APIC parsing order

on top of commit 603f162a02d5ccf0b3c5b2c6f488e456be81007f

 Merge tag 'acpi-6.14-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI fixes for 6.14-rc1.

These add a new ACPI-related quirk for Vexia EDU ATLA 10 tablet 5V (Hans
de Goede) and fix the MADT parsing code so that CPUs with different entry
types (LAPIC and x2APIC) are initialized in the order in which they appear
in the MADT as required by the ACPI specification (Zhang Rui).

Thanks!


---------------

Hans de Goede (1):
      ACPI: x86: Add skip i2c clients quirk for Vexia EDU ATLA 10 tablet 5V

Zhang Rui (1):
      x86/acpi: Fix LAPIC/x2APIC parsing order

---------------

 arch/x86/kernel/acpi/boot.c | 50 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/acpi/x86/utils.c    | 13 ++++++++++++
 2 files changed, 58 insertions(+), 5 deletions(-)

