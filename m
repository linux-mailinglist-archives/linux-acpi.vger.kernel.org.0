Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4050F2A231B
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 03:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgKBCfs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Nov 2020 21:35:48 -0500
Received: from mail-m973.mail.163.com ([123.126.97.3]:35706 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbgKBCfs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Nov 2020 21:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=2eTmrCKSEZ5sTcw2bc
        BINOvh7851Ksw9VIukUh0jZGA=; b=pyPECmsy77ISx5GCUngxK/RdgJ6XDFT2hM
        sQbkqYpQhXJhDhNcfvlMiGyzkW4bxA9GffVl/LpKlAWGslXKu4J6vUWakHZBNpRb
        wi/g0SVez3oDo17vpJPZb1iJKByDrDDTDXA5R8XWhJSGsheLxZGfJJfzVd5NUXzu
        daQv1hF7I=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp3 (Coremail) with SMTP id G9xpCgCHYCoVcJ9fK6WQJw--.78S2;
        Mon, 02 Nov 2020 10:34:03 +0800 (CST)
From:   yaoaili126@163.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: [PATCH] ACPI, APEI, Fix incorrect return value of apei_map_generic_address
Date:   Sun,  1 Nov 2020 18:33:32 -0800
Message-Id: <20201102023332.7638-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <28dc453f-40b8-8263-5aeb-f8979f54a941 () arm ! com>
References: <28dc453f-40b8-8263-5aeb-f8979f54a941 () arm ! com>
X-CM-TRANSID: G9xpCgCHYCoVcJ9fK6WQJw--.78S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw13XryfCrWUCryUtw4rAFb_yoWrKw17pF
        WxurWFkw4rJr4xG3yxAr4jgry5Zws7Gay3t39Fkwn5uF1UGrW5urWDXFyUXFyrJrW8Wr4S
        qFZ8tFsxCanFvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jV6wZUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/1tbiLBXQG1spZS3+4AAAsW
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Aili Yao <yaoaili@kingsoft.com>

From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
acpi_os_map_generic_address() return value"),acpi_os_map_generic_address
will return logical address or NULL for error, but
pre_map_gar_callback and related apei_map_generic_address ,for
ACPI_ADR_SPACE_SYSTEM_IO case, it should be also return 0,as it's a
normal case, but now it will return -ENXIO. so check it out for such
case to avoid einj module initialization fail.

Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 arch/x86/kernel/cpu/mce/core.c |  2 +
 drivers/acpi/apei/apei-base.c  |  4 ++
 drivers/acpi/apei/ghes.c       | 67 ++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h            |  2 +
 4 files changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4102b866e7c0..22efa708ef53 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -341,6 +341,8 @@ static void mce_panic(const char *msg, struct mce *final, char *exp)
 		if (!apei_err)
 			apei_err = apei_write_mce(final);
 	}
+	/* Print possible additional cper error info, get cper cleared */
+	ghes_in_mce_cper_entry_check();
 	if (cpu_missing)
 		pr_emerg(HW_ERR "Some CPUs didn't answer in synchronization\n");
 	if (exp)
diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index 552fd9ffaca4..3294cc8dc073 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -633,6 +633,10 @@ int apei_map_generic_address(struct acpi_generic_address *reg)
 	if (rc)
 		return rc;
 
+	/* IO space doesn't need mapping */
+	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		return 0;
+
 	if (!acpi_os_map_generic_address(reg))
 		return -ENXIO;
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fce7ade2aba9..6f5d89b54561 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1147,9 +1147,76 @@ static void ghes_nmi_remove(struct ghes *ghes)
 	 */
 	synchronize_rcu();
 }
+
+int ghes_in_mce_cper_entry_check(void)
+{
+	int rc = -ENOENT;
+	struct ghes *ghes;
+	struct list_head *rcu_list = &ghes_nmi;
+	enum fixed_addresses fixmap_idx = FIX_APEI_GHES_NMI;
+	struct acpi_hest_generic_status *estatus, tmp_header;
+	struct ghes_estatus_node *estatus_node;
+	u32 len, node_len;
+	u64 buf_paddr;
+	int sev;
+
+	/* if NMI handler already in process, let NMI do its job */
+	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
+		return 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ghes, rcu_list, list) {
+		rc = __ghes_peek_estatus(ghes, &tmp_header, &buf_paddr, fixmap_idx);
+		if (rc) {
+			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+			return rc;
+		}
+
+		rc = __ghes_check_estatus(ghes, &tmp_header);
+		if (rc) {
+			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+			return rc;
+		}
+
+		len = cper_estatus_len(&tmp_header);
+		node_len = GHES_ESTATUS_NODE_LEN(len);
+		estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
+		if (!estatus_node) {
+			/*
+			 * Going to panic, No need to keep the error.
+			 */
+			ghes_clear_estatus(ghes, &tmp_header, buf_paddr, fixmap_idx);
+			return -ENOMEM;
+		}
+		estatus_node->ghes = ghes;
+		estatus_node->generic = ghes->generic;
+		estatus_node->task_work.func = NULL;
+		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
+
+		if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
+			ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+			return -ENOENT;
+		}
+
+		/*
+		 * As we are going to panic, and preemt the possible NMI handing,
+		 * dump all the info and get it cleared.
+		 */
+		ghes_print_queued_estatus();
+		__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
+		ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+		      node_len);
+	}
+	rcu_read_unlock();
+	atomic_dec(&ghes_in_nmi);
+	return rc;
+}
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
 static inline void ghes_nmi_add(struct ghes *ghes) { }
 static inline void ghes_nmi_remove(struct ghes *ghes) { }
+int ghes_in_mce_cper_entry_check(void) {}
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static void ghes_nmi_init_cxt(void)
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 34fb3431a8f3..be1ee0e993d2 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -145,4 +145,6 @@ int ghes_notify_sea(void);
 static inline int ghes_notify_sea(void) { return -ENOENT; }
 #endif
 
+int ghes_in_mce_cper_entry_check(void);
+
 #endif /* GHES_H */
-- 
2.18.4

