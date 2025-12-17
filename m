Return-Path: <linux-acpi+bounces-19612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF6ECC77C4
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 13:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7D60302DB7D
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Dec 2025 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB1C34D921;
	Wed, 17 Dec 2025 11:28:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C468F34D4E4;
	Wed, 17 Dec 2025 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970937; cv=none; b=VQmpmnqgL8jQhydWqUvQvai9S2sol1z4uzjUotSNkk1eHzI9LkY4Nng94PVxhgcu0IXdN26tCIivKlv3ARqkm/bx2egGKPnGGcGMuvTk+Pp3y+Uyfok76K7SHf6sqtR/B6+9XOrUrysGZEqEQv9dGsBTAMbHyUp3pbh7X4l4eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970937; c=relaxed/simple;
	bh=a7kpjgX+R64zDwghcI5SJingJevntasZlpZAFDn2lf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fiMd9A1Raogc8heotcSZwMqpcRGEAlOAtTGW8qg+E1INeU60R1d3G+CELdrs1KfekIP94lf2ZYIo4cXlIAlNB0pILfb5CM6eYF9mAP1hkVr+T695aq6UVtQFcrVOMUHO6XD+3klubFBadED4KpQJhglCNLPPDeVfNFh3GqThhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9033114BF;
	Wed, 17 Dec 2025 03:28:46 -0800 (PST)
Received: from e134710.manchester.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8F0A3F73B;
	Wed, 17 Dec 2025 03:28:51 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
To: linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: tony.luck@intel.com,
	bp@alien8.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rafael@kernel.org,
	linux-doc@vger.kernel.org,
	Dmitry.Lamerov@arm.com,
	Michael.Zhao2@arm.com,
	ahmed.tiba@arm.com
Subject: [PATCH 00/12] ras: share firmware-first estatus handling
Date: Wed, 17 Dec 2025 11:28:33 +0000
Message-ID: <20251217112845.1814119-1-ahmed.tiba@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platforms that rely on firmware-first RAS today only get the full Linux
handling pipeline when the records arrive through ACPI/APEI GHES. This
series lifts the generic parts of GHES into a reusable estatus core, wires
GHES up to that core, and adds a DeviceTree-facing provider so non-ACPI
systems can route CPER records through the same logic. The final patches
document the binding and the admin-guide flow.

The end result is a single estatus implementation that covers vendor record
notifier support, memory error queueing, IRQ/NMI handling and the CXL/PCIe.
GHES and DT users now simply provide transport-specific ops.

This is based on v6.19-rc1

Ahmed Tiba (12):
  ras: add estatus core interfaces
  ras: add estatus core implementation
  ras: add estatus vendor handling and processing
  ras: add estatus queuing and IRQ/NMI handling
  ras: flesh out estatus processing core
  efi/cper: adopt estatus iteration helpers
  ghes: prepare estatus hooks for shared handling
  ghes: add estatus provider ops
  ghes: route error handling through shared estatus core
  dt-bindings: ras: document estatus provider
  ras: add DeviceTree estatus provider driver
  doc: ras: describe firmware-first estatus flow

 Documentation/admin-guide/RAS/main.rst        |   24 +
 .../devicetree/bindings/ras/arm,ras-ffh.yaml  |   95 ++
 MAINTAINERS                                   |    8 +
 arch/arm64/include/asm/fixmap.h               |    5 +
 drivers/acpi/apei/Kconfig                     |    1 +
 drivers/acpi/apei/ghes.c                      | 1292 +++--------------
 drivers/firmware/efi/Kconfig                  |   11 +
 drivers/firmware/efi/Makefile                 |    1 +
 drivers/firmware/efi/cper.c                   |   29 +-
 drivers/firmware/efi/estatus.c                | 1056 ++++++++++++++
 drivers/ras/Kconfig                           |   14 +
 drivers/ras/Makefile                          |    1 +
 drivers/ras/estatus-dt.c                      |  318 ++++
 include/acpi/ghes.h                           |   58 +-
 include/linux/estatus.h                       |  267 ++++
 15 files changed, 2001 insertions(+), 1179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ras/arm,ras-ffh.yaml
 create mode 100644 drivers/firmware/efi/estatus.c
 create mode 100644 drivers/ras/estatus-dt.c
 create mode 100644 include/linux/estatus.h

-- 
2.43.0


