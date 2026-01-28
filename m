Return-Path: <linux-acpi+bounces-20740-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JA7K6Jyemme6gEAu9opvQ
	(envelope-from <linux-acpi+bounces-20740-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:33:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13546A89BB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE873306B143
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D00B37475B;
	Wed, 28 Jan 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvNmYpXN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C43793D2;
	Wed, 28 Jan 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632093; cv=none; b=P8LKAQFAH3r4HlrsoUgG+tdr793vJbfUyS6KnyF+HKzs+v0dpIzCLq7fy3Xfd4HVIelfA8YoSB503oZAobXjK6fpbfnLbJEmmuVRwqZWlHhdD4qALRQUqslkvw/GzlU+9huJ2EhT1o1ntSyDWwgTRyYfLJTIANrzTTBm01Ne0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632093; c=relaxed/simple;
	bh=2p876OLLX8prfj4iRVt0MftQApA/Ndfp5I0kmihgDv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGwcIOBqugLpTWSBPMFnwZ5+pl72kFznA3JZ3uA/xjXqP9CAfN9Da40bBQlWPdbV5ksA/ERXlK1AmH53BXe+LMKj1Z1P34qY5/7Q04OsJmOIjl6qJHdLe0o/1bfXlfyEpQAG/ZDk7EQbmCbIva8wtt/X1kKjQqggfMUNgnMlbS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvNmYpXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1B4C19421;
	Wed, 28 Jan 2026 20:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632092;
	bh=2p876OLLX8prfj4iRVt0MftQApA/Ndfp5I0kmihgDv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nvNmYpXNTrs2Gd+j6e50jmN2l9Z23bYLF6ssVdaiXzTPbUxc1qT0mjM+DcxcHugJA
	 J/87PsgTsnafBZfhqlt4m2QgOzifGKJFseryVtiSaY/M0PZYJrWd3Zv+x6wuWpMVbc
	 a1FuXbEM4c1p717fgARM4pWgqSQ/6nuzP/cOqvACY6mrFevw2R7SPPJXKH407qNmfj
	 p0xLmcEpdgDon99ai9bazDER0LJA7+06Vrm4HlSAQdMY5mHWpeFfHtKjcFyPq/YjCS
	 TdH8SRbUVexwp+kUyzm/u5LFPIRobL4hdKcn85jEL3DIxztlARfclD0EkOvOxPxA7G
	 eqS2ZdeZ/bEiw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:38 -0800
Subject: [PATCH RFC v2 17/17] acpi: riscv: Add support for RISC-V Quality
 of Service Controller (RQSC)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-17-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, Rob Herring <robh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1324; i=fustini@kernel.org;
 h=from:subject:message-id; bh=2p876OLLX8prfj4iRVt0MftQApA/Ndfp5I0kmihgDv8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQbtj1tz8omO0oPqJVoaSzVyZ5XOXdDCNGlde9i+1
 cb+1ue5O0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATSbnM8FfULF18ztyD7n2W
 pqyZ+yauDr77hnXnoYku5rIKxUJ/WFcyMhy7rmJWJHzzwKmlUrNj/W1SknNrz7VFH7jXoNB0Qjb
 wEgcA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20740-lists,linux-acpi=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,ventanamicro.com,sifive.com,baylibre.com,semihalf.com,linux.dev,rivosinc.com,bytedance.com,linux.alibaba.com,gmail.com,zte.com.cn,intel.com,amd.com,google.com,arm.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fustini@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13546A89BB
X-Rspamd-Action: no action

Enable support for the RQSC table which describes the capacity and
bandwidth QoS (CBQRI) controllers in a system.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/acpi/riscv/init.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index 7c00f7995e86..784fa0c56516 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -6,10 +6,29 @@
 
 #include <linux/acpi.h>
 #include "init.h"
+#include <linux/riscv_qos.h>
 
 void __init acpi_arch_init(void)
 {
+	struct acpi_table_header *rqsc;
+	acpi_status status;
+	int rc;
+
 	riscv_acpi_init_gsi_mapping();
+
 	if (IS_ENABLED(CONFIG_ACPI_RIMT))
 		riscv_acpi_rimt_init();
+
+	if (!acpi_disabled) {
+		status = acpi_get_table(ACPI_SIG_RQSC, 0, &rqsc);
+		if (ACPI_FAILURE(status)) {
+			pr_err("%s(): failed to find ACPI RQSC table: %d", __func__,
+			       ACPI_FAILURE(status));
+		} else {
+			rc = acpi_parse_rqsc(rqsc);
+			if (rc < 0)
+				pr_err("%s(): failed to parse ACPI RQSC table: %d", __func__, rc);
+		}
+		acpi_put_table((struct acpi_table_header *)rqsc);
+	}
 }

-- 
2.43.0


