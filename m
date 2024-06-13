Return-Path: <linux-acpi+bounces-6392-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB58907DDA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FB3B22C8D
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 21:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF513BC03;
	Thu, 13 Jun 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K8wN2Jgg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEE1139CE2;
	Thu, 13 Jun 2024 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313025; cv=none; b=QroPcWfD2V7LOCsAClA0NWdZ8WrQ84bK6kRRkFd13hkgmB3Fk4qP47K3LPkflHMMDZIpNUlKzzOakOMsoq89+n03PAFnQph6rYaTsPpIpJUNCwkDncPQrQRrQzpeoLCaKZLIGzZZnGmiLLLBwabqCVY9/Nwmgwof7MPxE8SOaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313025; c=relaxed/simple;
	bh=yI2pM6glGsJJWxvQAAeW+lCGZZ32jQj4MnUR25Blips=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MHw/O8iBZ3gjQm7MWDr32KkdbfSJjxuMoTLuTHfuap/aPQF1DP0z7sXrgqs6kmDvCQQew8pQbUrpAPR6JBpRkFxyVPDLeApo6xS0MnE6C3ss90rOvzgaSRohyaIFoZ2ulnTiQ3D0wYXR4exm01SepdfHEaJhde3kN98AmrONfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K8wN2Jgg; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718313024; x=1749849024;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bFPHb1i9S0EjfPl1sZl0nOIw+Pf+rfxtOrLIDnf0FG8=;
  b=K8wN2Jgg+miWwYsM8umXPqdwxUKg5eLNvpCFIcA7Hs2vIYm535NsWFZ7
   pmG8FRoFF1/G9e6E4H7etRf9285n8BJOaVSbNK8mcGfTybT/ZOuM6a9ce
   IizeI/P5gyD12XT4qCPDPtCCHEMgLpcO5JvwHibYDo8eevKb/zWXkxZUc
   M=;
X-IronPort-AV: E=Sophos;i="6.08,236,1712620800"; 
   d="scan'208";a="302075455"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 21:10:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:3454]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.14:2525] with esmtp (Farcaster)
 id 50c18be9-c072-4499-aed4-f6d36ec1fcc8; Thu, 13 Jun 2024 21:10:23 +0000 (UTC)
X-Farcaster-Flow-ID: 50c18be9-c072-4499-aed4-f6d36ec1fcc8
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 21:10:23 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.119.132.17) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 13 Jun 2024 21:10:22 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <linux-acpi@vger.kernel.org>
CC: <acpica-devel@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<surajjs@amazon.com>, <sjitindarsingh@gmail.com>, <robert.moore@intel.com>,
	<rafael.j.wysocki@intel.com>, <lenb@kernel.org>, <okaya@kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] acpi: Support CONFIG_ACPI without CONFIG_PCI
Date: Thu, 13 Jun 2024 14:10:11 -0700
Message-ID: <20240613211011.413120-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)

Make is possible to use ACPI without having CONFIG_PCI set.

When initialising ACPI the following call chain occurs:

  acpi_init() ->
    acpi_bus_init() ->
      acpi_load_tables() ->
        acpi_ev_install_region_handlers() ->

acpi_ev_install_region_handlers() calls acpi_ev_install_space_handler() on
each of the default address spaces defined as:

  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
          ACPI_ADR_SPACE_SYSTEM_MEMORY,
          ACPI_ADR_SPACE_SYSTEM_IO,
          ACPI_ADR_SPACE_PCI_CONFIG,
          ACPI_ADR_SPACE_DATA_TABLE
  };

However in acpi_ev_install_space_handler() the case statement for
ACPI_ADR_SPACE_PCI_CONFIG is ifdef'd as:

  #ifdef ACPI_PCI_CONFIGURED
                  case ACPI_ADR_SPACE_PCI_CONFIG:

                          handler = acpi_ex_pci_config_space_handler;
                          setup = acpi_ev_pci_config_region_setup;
                          break;
  #endif

ACPI_PCI_CONFIGURED is not defined if CONFIG_PCI is not enabled, thus the
attempt to install the handler fails.

Fix this by ifdef'ing ACPI_ADR_SPACE_PCI_CONFIG in the list of default
address spaces.

Fixes: bd23fac3eaaa ("ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset")
CC: stable@vger.kernel.org # 5.0.x-
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 drivers/acpi/acpica/evhandler.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 1c8cb6d924df..371093acb362 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
 	ACPI_ADR_SPACE_SYSTEM_MEMORY,
 	ACPI_ADR_SPACE_SYSTEM_IO,
+#ifdef ACPI_PCI_CONFIGURED
 	ACPI_ADR_SPACE_PCI_CONFIG,
+#endif
 	ACPI_ADR_SPACE_DATA_TABLE
 };
 
-- 
2.34.1


