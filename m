Return-Path: <linux-acpi+bounces-11531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5836A47087
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 01:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8880E3ADD4D
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4838DD3;
	Thu, 27 Feb 2025 00:50:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B510F7462
	for <linux-acpi@vger.kernel.org>; Thu, 27 Feb 2025 00:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740617449; cv=none; b=eTFMr0zenlkFSmP3bVt/V951hlMEqEipiqRu/GEiendq23w1Qt4ohyIHAfNA6IQxRhoNqL7GSk46oP4nAdoSpsZckMn3RasCPTOkNUWhJgS8qsGeCPx5aMoW0a6NNlqU209kMTZSgmfMDRYplrZ8neMml+9orQdPz6+HCj6y/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740617449; c=relaxed/simple;
	bh=VNYGYJK2seFGVd1KiZeuCd8DMJxYxkvPtam/PB9klKQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urbwv5pBE3Lms10hC0uQho8dgwimJCzHJRLTRS6pHmdfNthvYmCvTLYlLSnnsKg7lFu2Tm8LIaOJvHHnDZ5L9ica+EyH5zwxnn9jp2mD0SSdAMVmnOTcKpBEDjDjBF8Da0K4VteJGYqSjlOKO82b4V1peF9A8kFql6T18UGz+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1740616659-086e23601815e2e0002-I98ny2
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id IjfANJBAOSPLeToM (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 27 Feb 2025 08:37:40 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX2.zhaoxin.com (10.28.252.164) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Thu, 27 Feb
 2025 08:37:40 +0800
Received: from ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298]) by
 ZXSHMBX2.zhaoxin.com ([fe80::4dfc:4f6a:c0cf:4298%4]) with mapi id
 15.01.2507.044; Thu, 27 Feb 2025 08:37:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 20:19:02 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v5 3/4] PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
Date: Wed, 26 Feb 2025 20:18:37 +0800
X-ASG-Orig-Subj: [PATCH v5 3/4] PCI: Add AER bits #defines for PCIe to PCI/PCI-X Bridge
Message-ID: <20250226121838.364533-4-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
References: <20250226121838.364533-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 2/27/2025 8:37:38 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1740616660
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1179
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.137757
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Define secondary uncorrectable error mask register, secondary
uncorrectable error severity register and secondary error capabilities and
control register bits in AER capability for PCIe to PCI/PCI-X Bridge.
Please refer to PCIe to PCI/PCI-X Bridge Specification r1.0, sec 5.2.3.2,
5.2.3.3 and 5.2.3.4.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 include/uapi/linux/pci_regs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..0566c663beb7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -812,6 +812,10 @@
 #define PCI_ERR_ROOT_ERR_SRC	0x34	/* Error Source Identification */
 #define PCI_ERR_PREFIX_LOG	0x38	/* TLP Prefix LOG Register (up to 16 bytes=
) */
=20
+#define PCI_ERR_UNCOR_MASK2	0x30	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_UNCOR_SEVER2	0x34	/* PCIe to PCI/PCI-X Bridge */
+#define PCI_ERR_CAP2		0x38	/* PCIe to PCI/PCI-X Bridge */
+
 /* Virtual Channel */
 #define PCI_VC_PORT_CAP1	0x04
 #define  PCI_VC_CAP1_EVCC	0x00000007	/* extended VC count */
--=20
2.34.1


