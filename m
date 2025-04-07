Return-Path: <linux-acpi+bounces-12768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5067A7D1EB
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 04:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F59316DBCA
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 02:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F8212F8F;
	Mon,  7 Apr 2025 02:07:25 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F7212D84
	for <linux-acpi@vger.kernel.org>; Mon,  7 Apr 2025 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991645; cv=none; b=jvL3zEaGGr8GjbsTNGtAVom2IUVPrYzAQmaD7zGUcuzVK7TWL8GT80BAE4p1oPsvyi7iBvJsuTP92sBxB8QH2PUn7LnZPyq/cAkay9PFDybeoKJKEfl0x5RSD/w/KpYzN85kIzGbgYv2zrCaJHFqVGqZiwTggs+KI7R/2hJbWWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991645; c=relaxed/simple;
	bh=dKXp16Umr8V19xEpxxtzH3lSLHY1ldeIn4H5CA6nmLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNM4Hx7ZEmvTzqkSK9x41Aqb4XvISqBcntI2q7J+qAfAO6c6f010/pnElIBCGAOw7MP8IIxkYNSIGt7eN9V/UQWYrs4kkiLtYh65OrMpnBmnJ7/JaHQP7wRAWsPy5Id/z+bdmEmWSO/3s1rsKkmEh4gvHz//1EMeBHc9Aizx7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1743991633-1eb14e119b07030001-I98ny2
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id SxWmBqo6xoMqzqmW (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 07 Apr 2025 10:07:13 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Mon, 7 Apr
 2025 10:07:13 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2]) by
 ZXSHMBX3.zhaoxin.com ([fe80::8cc5:5bc6:24ec:65f2%6]) with mapi id
 15.01.2507.044; Mon, 7 Apr 2025 10:07:13 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 7 Apr
 2025 10:06:00 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <bhelgaas@google.com>,
	<robert.moore@intel.com>, <yazen.ghannam@amd.com>, <avadhut.naik@amd.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <acpica-devel@lists.linux.dev>
CC: <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
	<leoliu@zhaoxin.com>, LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH v6 1/4] ACPI: APEI: Move apei_hest_parse() to apei.h
Date: Mon, 7 Apr 2025 10:05:54 +0800
X-ASG-Orig-Subj: [PATCH v6 1/4] ACPI: APEI: Move apei_hest_parse() to apei.h
Message-ID: <20250407020557.1225166-2-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
References: <20250407020557.1225166-1-LeoLiu-oc@zhaoxin.com>
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
X-Moderation-Data: 4/7/2025 10:07:12 AM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1743991633
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1415
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.139598
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

Remove static from apei_hest_parse() so that it can be called in another
file.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/acpi/apei/hest.c | 4 +---
 include/acpi/apei.h      | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20d757687e3d..05ab4388cd4b 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -132,9 +132,7 @@ static bool is_ghes_assist_struct(struct acpi_hest_head=
er *hest_hdr)
 	return false;
 }
=20
-typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
-
-static int apei_hest_parse(apei_hest_func_t func, void *data)
+int apei_hest_parse(apei_hest_func_t func, void *data)
 {
 	struct acpi_hest_header *hest_hdr;
 	int i, rc, len;
diff --git a/include/acpi/apei.h b/include/acpi/apei.h
index dc60f7db5524..da8fe0d9758a 100644
--- a/include/acpi/apei.h
+++ b/include/acpi/apei.h
@@ -39,6 +39,9 @@ void __init acpi_hest_init(void);
 static inline void acpi_hest_init(void) { }
 #endif
=20
+typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *d=
ata);
+int apei_hest_parse(apei_hest_func_t func, void *data);
+
 int erst_write(const struct cper_record_header *record);
 ssize_t erst_get_record_count(void);
 int erst_get_record_id_begin(int *pos);
--=20
2.34.1


