Return-Path: <linux-acpi+bounces-21528-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ+oL4uRrmk7GQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21528-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 10:23:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B32361AE
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 10:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FEA03035267
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C686B3783D7;
	Mon,  9 Mar 2026 09:20:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC567256C84;
	Mon,  9 Mar 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048046; cv=none; b=WTuV0HOYYoEdtZ6GpYMOc5LDPrJ8qZsFsfXuzOHfnAGbwX7yVRcVzATTFXP+L/zDAn48RuD9Pw2hHIhEuiB2TZtW2aQv+x7Tc/uimXbtDKn0iqs677wglLsE7REssRhbbl4iQ+Qoi2k0aM3NCAE1ZU3V4FpFFQYL8yfUxuDQf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048046; c=relaxed/simple;
	bh=zp9Rt221AmrSDf0mVc6DMXSzcqZbo8m6Bj80HUPy0Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wg6ZHLa5PoDfRbUb24SPcunC6v8oP3DGGPNbEWKU7/2ZvyxD/3KcKhQjYZAZLxMSr3fNfWCZ9tKCb/xbhNqMa1+viffqAWlVqkmL8dyCkwmqOOUR+aTxU+jwNk/I2iQCwTKbTFgsBbDw4lS4dxebYE5avCJIYZKf4ClEZMoBpjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowACXKAzlkK5piwXyCQ--.20115S2;
	Mon, 09 Mar 2026 17:20:38 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH] ACPICA: scope PCI region setup helpers to ACPI_PCI_CONFIGURED
Date: Mon,  9 Mar 2026 09:20:31 +0000
Message-Id: <20260309092031.720808-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACXKAzlkK5piwXyCQ--.20115S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw43KryUGryfJry5Xr4DXFb_yoW5Jryxpr
	WUtr4UAr17JF129F1jywn5ur13A34kCF4UJwsrJryDZr1UGw15Ar1qqw17ta4UJryUtr1Y
	vF4UJF15XF1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU82NtDUUUU
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Queue-Id: CE7B32361AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21528-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,linux-acpi@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.348];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isrc.iscas.ac.cn:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Action: no action

In current linux.git (1954c4f01220), acpi_ev_pci_config_region_setup()
and acpi_ev_pci_bar_region_setup() are defined and declared 
unconditionally. However, their only in-tree references are within 
evhandler.c, which are already guarded by #ifdef ACPI_PCI_CONFIGURED.

Match the internal declarations and definitions to that scope by wrapping
them in #ifdef ACPI_PCI_CONFIGURED. This fixes the config-scope mismatch
and avoids including PCI-specific setup logic when PCI support is not
configured in the ACPI subsystem.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
diff --git a/drivers/acpi/acpica/acevents.h b/drivers/acpi/acpica/acevents.h
--- a/drivers/acpi/acpica/acevents.h
+++ b/drivers/acpi/acpica/acevents.h
@@
 acpi_status
 acpi_ev_io_space_region_setup(acpi_handle handle,
 			      u32 function,
 			      void *handler_context, void **region_context);
 
+#ifdef ACPI_PCI_CONFIGURED
 acpi_status
 acpi_ev_pci_config_region_setup(acpi_handle handle,
 				u32 function,
 				void *handler_context, void **region_context);
@@
 acpi_status
 acpi_ev_pci_bar_region_setup(acpi_handle handle,
 			     u32 function,
 			     void *handler_context, void **region_context);
+#endif
 
 acpi_status
 acpi_ev_data_table_region_setup(acpi_handle handle,
 				u32 function,
diff --git a/drivers/acpi/acpica/evrgnini.c b/drivers/acpi/acpica/evrgnini.c
--- a/drivers/acpi/acpica/evrgnini.c
+++ b/drivers/acpi/acpica/evrgnini.c
@@
  *
  ******************************************************************************/
 
+#ifdef ACPI_PCI_CONFIGURED
 acpi_status
 acpi_ev_pci_config_region_setup(acpi_handle handle,
 				u32 function,
 				void *handler_context, void **region_context)
@@
 	*region_context = pci_id;
 	return_ACPI_STATUS(AE_OK);
 }
+#endif
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_is_pci_root_bridge
@@
  *
  ******************************************************************************/
 
+#ifdef ACPI_PCI_CONFIGURED
 acpi_status
 acpi_ev_pci_bar_region_setup(acpi_handle handle,
 			     u32 function,
 			     void *handler_context, void **region_context)
@@
 
 	return_ACPI_STATUS(AE_OK);
 }
+#endif
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ev_cmos_region_setup


