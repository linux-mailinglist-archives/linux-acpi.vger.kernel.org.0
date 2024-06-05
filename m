Return-Path: <linux-acpi+bounces-6198-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D18FCF88
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE631C22886
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 13:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398751953B5;
	Wed,  5 Jun 2024 13:15:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F911953A1
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jun 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593305; cv=none; b=j89ULGicEkDRcMJuGI0UrXlU++ue8lHyzh7Juua/jmhgMIdjIrkcDHiByVupI7+ILGGaJg+r+GAHR0hhIWG2XtXuVIafUEylR8BAS9nkCPG3TQC1cYuKFHu+JxFFqmHrNO835FFKwmIw21pBQ/6ctgHPnpQlPo4KfGoZXnqQHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593305; c=relaxed/simple;
	bh=HBde14be5uMyMag6V/QDxwFGDr+UgM4w8kuNu5nGNhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vw/fYm2eHWAg5YylRDWre3BoLYZNALcpaMO79qS4qdCfs8PYZhRy9Es4J1qbxHjeC33JEey5X1KpTzV++t5riDWFg8ZsbJz7qH3SR0o/OgBQ5P3VjhF5QjHyeU3H4sN9dvTs0MNSryBIEfO28ut5KDQl0c33x/2/8ZvNmHp9yQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C1A2339;
	Wed,  5 Jun 2024 06:15:26 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2007E3F792;
	Wed,  5 Jun 2024 06:15:01 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 0/3] ACPI: arm64: some cleanups
Date: Wed,  5 Jun 2024 14:14:55 +0100
Message-ID: <20240605131458.3341095-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Couple of patches to move the ACPI arch specific code into
drivers/acpi/arm64/ as they are not strictly arch specific to
keep them under arch/arm64.

Regards,
Sudeep

Sudeep Holla (3):
  ACPI: arm64: Sort entries alphabetically
  arm64: cpuidle: Move ACPI specific code into drivers/acpi/arm64/
  arm64: FFH: Move ACPI specific code into drivers/acpi/arm64/

 arch/arm64/kernel/Makefile                    |   1 -
 arch/arm64/kernel/acpi.c                      | 105 -----------------
 drivers/acpi/arm64/Makefile                   |   6 +-
 .../kernel => drivers/acpi/arm64}/cpuidle.c   |   4 -
 drivers/acpi/arm64/ffh.c                      | 107 ++++++++++++++++++
 5 files changed, 111 insertions(+), 112 deletions(-)
 rename {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c (97%)
 create mode 100644 drivers/acpi/arm64/ffh.c

--
2.45.2


