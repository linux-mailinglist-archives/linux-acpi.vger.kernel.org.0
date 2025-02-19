Return-Path: <linux-acpi+bounces-11319-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91FA3C94C
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0A1177257
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5822CBD2;
	Wed, 19 Feb 2025 20:10:28 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4054F21B9E0;
	Wed, 19 Feb 2025 20:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739995828; cv=none; b=XBes+jaCn8W3yKg9svOo2xXaux22+HM/LUuK15XdeTcqkeUmW8CFBoCgza2V7/tQ4bzNcDAcv2yLdDEVECvlX4cNRE8hy8wxS59wsePfAkM1qDrHQ0p6klFz3qPZ3Dbm2pA0kQx4gLkY+OYSnfexlIuVuQJBztr+hwJIieQvIj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739995828; c=relaxed/simple;
	bh=zDq3K0cRUJ0dtWhls7Hgc8PZm4L+F8WCGJO3BOMagfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvXUDvODdqCbIsI8V1cfYdvGMuwaH52CdnsoNnVSUGdX8NxEqIyrybUoJ22FpTBA3DHiqO4qsKeRG5V858sCSTddYiOkE3xKOyToqrGWPe6BAmBLS0yZcIh4MX7kO3mbXVks3Ma4nUQGuYuwZ8eA+xGwPWHykyY34wxulAVvVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8856152B;
	Wed, 19 Feb 2025 12:10:43 -0800 (PST)
Received: from beelzebub.ast.arm.com (unknown [10.118.29.240])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0303F3F59E;
	Wed, 19 Feb 2025 12:10:24 -0800 (PST)
From: Stuart Yoder <stuart.yoder@arm.com>
To: linux-integrity@vger.kernel.org,
	jarkko@kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Add support for the TPM FF-A start method
Date: Wed, 19 Feb 2025 14:10:09 -0600
Message-Id: <20250219201014.174344-1-stuart.yoder@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware Framework for Arm A-profile (FF-A) is a messaging framework
for Arm-based systems, and in the context of the TPM CRB driver is used
to signal 'start' to a CRB-based TPM service which is hosted in an
FF-A secure partition running in TrustZone.

These patches add support for the CRB FF-A start method defined
in the TCG ACPI specification v1.4 and the FF-A ABI defined
in the Arm TPM Service CRB over FF-A (DEN0138) specification:
https://developer.arm.com/documentation/den0138/latest/

The first patch adds an FF-A driver to handle the FF-A messaging when
communicating with a CRB-based TPM secure partition built on FF-A.
The driver is probed when the TPM secure partition is discovered by
the Linux FF-A infrastructure.

The second patch consolidates the check for idle support in the CRB
driver to one place.

The third patch defines the new ACPI start method enumeration for
CRB over FF-A.

The fourth patch adds support for the FF-A ACPI start method to
the TPM crb driver.

The fifth patch adds documentation explaining how the CRB driver
and FF-A relate.

Version 5
-tpm_ffa_crb patch: removed module version
-tpm_ffa_crb patch: fixed module description
-tpm_ffa_crb patch: updated comment on mutex declaration
-reworded commit message for patch 2 as per Jarkko's 
 suggestion
-added Acked tag by Sudeep to patch 1 for FF-A changes 
-added Reviewed-by tag to patches 3 and 4

Version 4
-fix warning from kernel test robot in patch 1
-fix warnings from checkpatch.pl --strict
-clean up unecessary parenthesis usage
-update variable declaration to be reverse tree order
-document exported functions in tpm_crb_ffa driver
-remove unnecessary author and maintainer info in tpm_crb_ffa driver
-fix declaration of variables to be in reverse tree order

Version 3
-changed prefixes used throughout patch series to tpm_crb_ffa*

Version 2
-updates to cover letter to define FF-A
-added new patch with documentation
-created pull request in ACPIA and added link to the patch
 updating actbl3.h
-added tpm_ prefix to the FF-A CRB driver

Stuart Yoder (5):
  tpm_crb: implement driver compliant to CRB over FF-A
  tpm_crb: clean-up and refactor check for idle support
  ACPICA: add start method for Arm FF-A
  tpm_crb: add support for the Arm FF-A start method
  Documentation: tpm: add documentation for the CRB FF-A interface

 Documentation/security/tpm/tpm_ffa_crb.rst |  65 ++++
 drivers/char/tpm/Kconfig                   |   9 +
 drivers/char/tpm/Makefile                  |   1 +
 drivers/char/tpm/tpm_crb.c                 | 105 +++++--
 drivers/char/tpm/tpm_crb_ffa.c             | 348 +++++++++++++++++++++
 drivers/char/tpm/tpm_crb_ffa.h             |  25 ++
 include/acpi/actbl3.h                      |   1 +
 7 files changed, 535 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm_ffa_crb.rst
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.c
 create mode 100644 drivers/char/tpm/tpm_crb_ffa.h

-- 
2.34.1


