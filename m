Return-Path: <linux-acpi+bounces-20768-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIvEFKZye2mMEgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20768-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 15:45:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B30B11FD
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 15:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6262E3005597
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7A0331A44;
	Thu, 29 Jan 2026 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JYPg1UM9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB132877D8;
	Thu, 29 Jan 2026 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697951; cv=none; b=GqmqeEnEpZTbVtHPN5lmZxQY97vmgqXgL9QClRQvn6TL8A0qR1iNNSp3dGbzD7nb/wCrO0FY7hOqDeAnSxaAtA0p+JBnQGR4h5TZJamD+7fElgyFqpokW4zUcwQIZ055eur0whtz8xfRQXOTwgLLvhkhqob/Ksbwf2ajergdfu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697951; c=relaxed/simple;
	bh=u/nOmzIjlMYybE6p6AlMcA31VZSKr+V4w0ZtXo9OfK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI9lTMmdPDplHi4X9SHJpSpUukZuREullDQ7I+iY8F7NNYbRsHqjMOJX1p1LFruUK/WB0sz6ER34aZ0x+zTe+yLFycMmm6E+46sZEsEC63lqYHV87HAc7oTPNpyYBs8KimPEnETpBMNzoo/Oa3tYEMHBBPrHIKaDOXPiZE4/FZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JYPg1UM9; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dv
	8Y7hYtYYZLX8fj2VaW0neCRg6TzrLuobtBO2O6I/E=; b=JYPg1UM9PirOw7C+Rj
	IQfA/N1jVYOZiXCjgiDot6nTXeWRie/Ey6/ksIcMjPqwJ+W/9kQsp9zrfjMGZs01
	vzGIXCFxxoKcEpUil5l1OZKl8tl2MUpGz7c41OxHdQmZ2wVZKl1qWv6DCfM4D3Ke
	oGCjTiEBXwPQJoNw3zX2nPf7g=
Received: from emily-VMware-Virtual-Platform.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAHBJjkcXtpfHbFIg--.5424S2;
	Thu, 29 Jan 2026 22:42:46 +0800 (CST)
From: huyuye <huyuye812@163.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn,
	guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn,
	hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn,
	zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn,
	huyuye <huyuye812@163.com>
Subject: [PATCH v4] ACPI: pci_root: Clear the acpi dependencies after PCI root bridge initialization on RISC-V
Date: Thu, 29 Jan 2026 22:42:41 +0800
Message-ID: <20260129144242.8730-1-huyuye812@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114123205.4019-1-huyuye812@163.com>
References: <20260114123205.4019-1-huyuye812@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHBJjkcXtpfHbFIg--.5424S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8tr18JFy5JrWUCw45Jrb_yoW8tF1xpF
	Wj9a43ta4kJwnIkrnrAw40gry5Xan3C3yUJrZrW34qka1kuFySqFyIyFWUAFy7XF4kAr1a
	qFZFqF1kAF1qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziFfO5UUUUU=
X-CM-SenderInfo: 5kx135bhyrjqqrwthudrp/xtbC-wbO1ml7ceYDUgAA31
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20768-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,ventanamicro.com,vger.kernel.org,zte.com.cn,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[huyuye812@163.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10B30B11FD
X-Rspamd-Action: no action

On RISC-V platforms with multiple PCI root bridges, the enumeration
order varies randomly across reboots due to APLIC driver initialization
occurring after ACPI device scanning. This defers PCI probing to a
unbound workqueue, resulting in non-deterministic device discovery
sequences.

Such random enumeration leads to changes in device naming across each
boot, which disrupts storage configurations, network settings, and
severely impacts the stability of server maintenance.

By adding the acpi_dev_clear_dependencies() call in acpi_pci_root_add(),
this patch enables the firmware to actively control the enumeration order
of multiple PCI root bridges through the ACPI _DEP method, providing the
firmware with the opportunity to initialize devices in the intended order,
thereby ensuring consistent enumeration results across multiple boots.

Signed-off-by: huyuye <huyuye812@163.com>
---
v3 -> v4:
-Removed __weak function

v2 -> v3:
- Added back the missing commit description from v1
- Moved v2 changelog to correct location after "---"

v1 -> v2:
- Removed the redundant #ifdef CONFIG_ACPI and if (!acpi_disabled) guard
- Moved acpi_dev_clear_dependencies to RISC-V specific architecture code
 drivers/acpi/pci_root.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 9d7f85dadc48..5169104b9d13 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -760,6 +760,18 @@ static int acpi_pci_root_add(struct acpi_device *device,
 	pci_lock_rescan_remove();
 	pci_bus_add_devices(root->bus);
 	pci_unlock_rescan_remove();
+	/*
+	 * On RISC-V platforms with ACPI, PCIe host bridge dependencies may be
+	 * explicitly defined via the _DEP method in the DSDT.
+	 *
+	 * The firmware uses _DEP to enforce initialization ordering: if host bridge B
+	 * depends on host bridge A, ACPI will delay B's enumeration until A is ready.
+	 *
+	 * Once this host bridge is fully initialized, we clear its _DEP entries to
+	 * release dependent bridges (like B) for enumeration.
+	 */
+	if (IS_ENABLED(CONFIG_RISCV))
+		acpi_dev_clear_dependencies(device);
 	return 1;
 
 remove_dmar:
-- 
2.43.0


