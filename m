Return-Path: <linux-acpi+bounces-20735-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN6EBnZxemlI6QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20735-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:28:38 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F9A880B
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 21:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7F7C300C02A
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D319378817;
	Wed, 28 Jan 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPPkuaDg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25874378805;
	Wed, 28 Jan 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632090; cv=none; b=moL55zLHI1QMGqY+VXmHTxPlx8SC9qcRcvsrw1qi+bPhT6iI1IAigJ8LjTTibRFoUxTgrXzt15EsluAUPeAQHxjuE+yj4XLWmnsFvFCIaScwUJzP8WunrZuxXQG0XFGliiPtn4Gl2n4bf4yMmmDcxfyKQWble8kGtYwrqjiqyps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632090; c=relaxed/simple;
	bh=uFVTMJOPvCbobzJzlLLOywkmk/8YKf9YQOLxRrQYfB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+7tFJwFkut1Y9ztJNeMESRnhU8UKOrE3O4O9LwrGiuTJBiaxCKEgnMN03za1tkr0s0Rjp8/4EWjwxJ1pn4Muq7QxRUKZDKGuICMFP91OuowuktxGTZqwiLVEc7MDB4qeffsSL8h9KLuKI3eXxQOw4KtZJQXSnra613eNJjkZWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPPkuaDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CBDC4CEF7;
	Wed, 28 Jan 2026 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632089;
	bh=uFVTMJOPvCbobzJzlLLOywkmk/8YKf9YQOLxRrQYfB8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SPPkuaDgcf/BvE0ZirdITV/+1qku/YWxWJrcZ7ODvLUS+ziSK4eRpeoN86oXxrxuv
	 hUvJXiPJxwfGoTMU0NrA9PBme53oM2P2Sj6j1PaiS6oswVMgqPaM7ar14rupJk7RS+
	 y7dy/w7147MJX6/d/q2MSnxv6lbmHrxq2CrY+z0HD4qqVimIX0qfXJPLrGkWF/tFFf
	 8eS0as/v5sXvgIbi7yvdz8ZCsjgEE9UaG0p1/X1UPeG9R+rfaRfRBmq6CNH2pEMOSr
	 D9B6nWgJcxjT1Y/KR3UEctH0ei3I6OlLCsQ1wjBC+x7S0dkJmjko4uI2ZRKXEvb3l3
	 pasmzSX/29q9A==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:33 -0800
Subject: [PATCH RFC v2 12/17] RISC-V: QoS: make CONFIG_RISCV_ISA_SSQOSID
 select resctrl
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-12-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=875; i=fustini@kernel.org;
 h=from:subject:message-id; bh=uFVTMJOPvCbobzJzlLLOywkmk/8YKf9YQOLxRrQYfB8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQa2ul2WMDnBtvGQZY1t1YQ7obmFv5+eiOHI/h1rK
 8Wc0xvWUcrCIMbFICumyLLpQ96FJV6hXxfMf7ENZg4rE8gQBi5OAZjI93kM/+N8ns6Zv2thVmVO
 yi7r27o1X99LPIiWES0WtvNoy9xWEMjwV+yvzak3rAYW8vzctWWPJRSmX6g4l/X6hLDfNpV5+h5
 izAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20735-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email]
X-Rspamd-Queue-Id: E98F9A880B
X-Rspamd-Action: no action

Make CONFIG_RISCV_ISA_SSQOSID select the config options for resctrl:
ARCH_HAS_CPU_RESCTRL, RESCTRL_FS and MISC_FILESYSTEMS.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 35a6238b02c5..8ff6d962b6b2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -598,6 +598,9 @@ config RISCV_ISA_SVNAPOT
 config RISCV_ISA_SSQOSID
 	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
 	default y
+	select ARCH_HAS_CPU_RESCTRL
+	select RESCTRL_FS
+	select MISC_FILESYSTEMS
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).

-- 
2.43.0


