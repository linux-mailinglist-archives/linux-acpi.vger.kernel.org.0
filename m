Return-Path: <linux-acpi+bounces-8212-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A579734C6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 12:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5361C25008
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 10:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5175197A69;
	Tue, 10 Sep 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JekQfvfq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JekQfvfq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048C1974EA;
	Tue, 10 Sep 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964813; cv=none; b=j7SkMt1gRH6D0regEMr50gvA+Xv6qFhDS5VK0rB3aiLdx79OR51JqQXQ5tzDdtqVm3jV1OhRxisjmsD3caFcHbbCpos6Kts/6irOIfUNEY7ypX1S+NfKtPWeOWgzaTVCt2HfhZgYM9eCmG/ZcDEmS7/ca5XtU/T5C54CBDe+JM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964813; c=relaxed/simple;
	bh=ycpAlu+sX/j10mk59bJJG9XZwz8FBkRtrrgRUvfSAnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTI/CzHYGUVJ+Lnin9542SRIbgsvC5d6TCGZKhc1f0eH4XWjg7sCR/Le41pPBDsnD03AyE4YbGWMaITup7MivXxFy9esDNsjyH17oFu0ZfcujQgy5QbdXVd4F099Jta+tX41fi5DtA5OwZB2HbJQSbDRmAShR2y4tzZviNFDDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JekQfvfq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JekQfvfq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A5D61F80E;
	Tue, 10 Sep 2024 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725964810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4E2YV8ab3rtlkcTkU/deOosd7xEwn8/WuMZMIwtC3dQ=;
	b=JekQfvfqdCWVZv8gir3nbMWrqDjbnxmhtTvUzqduMIb/cXlETSOLb587XPD2PT1gqjEkCU
	0hPa8CfTBFwZsUfIIVWBiBu6d+0Y66F3iF1bnMjHsvcWUTHI7gqBAeel7qDb9UCRBIttgn
	jq8fhT8QfbGXixNYknZkAjoUfyCFXQc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725964810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4E2YV8ab3rtlkcTkU/deOosd7xEwn8/WuMZMIwtC3dQ=;
	b=JekQfvfqdCWVZv8gir3nbMWrqDjbnxmhtTvUzqduMIb/cXlETSOLb587XPD2PT1gqjEkCU
	0hPa8CfTBFwZsUfIIVWBiBu6d+0Y66F3iF1bnMjHsvcWUTHI7gqBAeel7qDb9UCRBIttgn
	jq8fhT8QfbGXixNYknZkAjoUfyCFXQc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF262132CB;
	Tue, 10 Sep 2024 10:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NcobLQki4GbsYwAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 10 Sep 2024 10:40:09 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-acpi@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH v3 6/7] xen: allow mapping ACPI data using a different physical address
Date: Tue, 10 Sep 2024 12:39:31 +0200
Message-ID: <20240910103932.7634-7-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910103932.7634-1-jgross@suse.com>
References: <20240910103932.7634-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

When running as a Xen PV dom0 the system needs to map ACPI data of the
host using host physical addresses, while those addresses can conflict
with the guest physical addresses of the loaded linux kernel. The same
problem might apply in case a PV guest is configured to use the host
memory map.

This conflict can be solved by mapping the ACPI data to a different
guest physical address, but mapping the data via acpi_os_ioremap()
must still be possible using the host physical address, as this
address might be generated by AML when referencing some of the ACPI
data.

When configured to support running as a Xen PV domain, have an
implementation of acpi_os_ioremap() being aware of the possibility to
need above mentioned translation of a host physical address to the
guest physical address.

This modification requires to fix some #include of asm/acpi.h in x86
code to use linux/acpi.h instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch (Jan Beulich)
V3:
- add const attribute (Jan Beulich)
- guard ACPI related code with CONFIG_ACPI (Jan Beulich)
- use CONFIG_XEN_PV instead of CONFIG_XEN_PV_DOM0
---
 arch/x86/include/asm/acpi.h        |  8 +++++++
 arch/x86/kernel/acpi/boot.c        | 10 +++++++++
 arch/x86/kernel/mmconf-fam10h_64.c |  2 +-
 arch/x86/kernel/x86_init.c         |  2 +-
 arch/x86/xen/p2m.c                 | 34 ++++++++++++++++++++++++++++++
 arch/x86/xen/setup.c               |  2 +-
 6 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 21bc53f5ed0c..5ab1a4598d00 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -174,6 +174,14 @@ void acpi_generic_reduced_hw_init(void);
 void x86_default_set_root_pointer(u64 addr);
 u64 x86_default_get_root_pointer(void);
 
+#ifdef CONFIG_XEN_PV
+/* A Xen PV domain needs a special acpi_os_ioremap() handling. */
+extern void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys,
+					 acpi_size size);
+void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
+#define acpi_os_ioremap acpi_os_ioremap
+#endif
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9f4618dcd704..2de8510c56dd 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1778,3 +1778,13 @@ u64 x86_default_get_root_pointer(void)
 {
 	return boot_params.acpi_rsdp_addr;
 }
+
+#ifdef CONFIG_XEN_PV
+void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	return ioremap_cache(phys, size);
+}
+
+void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys, acpi_size size) =
+	x86_acpi_os_ioremap;
+#endif
diff --git a/arch/x86/kernel/mmconf-fam10h_64.c b/arch/x86/kernel/mmconf-fam10h_64.c
index c94dec6a1834..8347a29f9db4 100644
--- a/arch/x86/kernel/mmconf-fam10h_64.c
+++ b/arch/x86/kernel/mmconf-fam10h_64.c
@@ -9,12 +9,12 @@
 #include <linux/pci.h>
 #include <linux/dmi.h>
 #include <linux/range.h>
+#include <linux/acpi.h>
 
 #include <asm/pci-direct.h>
 #include <linux/sort.h>
 #include <asm/io.h>
 #include <asm/msr.h>
-#include <asm/acpi.h>
 #include <asm/mmconfig.h>
 #include <asm/pci_x86.h>
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 82b128d3f309..47ef8af23101 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -8,8 +8,8 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 
-#include <asm/acpi.h>
 #include <asm/bios_ebda.h>
 #include <asm/paravirt.h>
 #include <asm/pci_x86.h>
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 5b2aeae6f9e4..a64e9562733e 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -70,6 +70,7 @@
 #include <linux/memblock.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/acpi.h>
 
 #include <asm/cache.h>
 #include <asm/setup.h>
@@ -836,6 +837,33 @@ void __init xen_do_remap_nonram(void)
 	pr_info("Remapped %u non-RAM page(s)\n", remapped);
 }
 
+#ifdef CONFIG_ACPI
+/*
+ * Xen variant of acpi_os_ioremap() taking potentially remapped non-RAM
+ * regions into acount.
+ * Any attempt to map an area crossing a remap boundary will produce a
+ * WARN() splat.
+ */
+static void __iomem *xen_acpi_os_ioremap(acpi_physical_address phys,
+					 acpi_size size)
+{
+	unsigned int i;
+	const struct nonram_remap *remap = xen_nonram_remap;
+
+	for (i = 0; i < nr_nonram_remap; i++) {
+		if (phys + size > remap->maddr &&
+		    phys < remap->maddr + remap->size) {
+			WARN_ON(phys < remap->maddr ||
+				phys + size > remap->maddr + remap->size);
+			phys = remap->paddr + phys - remap->maddr;
+			break;
+		}
+	}
+
+	return x86_acpi_os_ioremap(phys, size);
+}
+#endif /* CONFIG_ACPI */
+
 /*
  * Add a new non-RAM remap entry.
  * In case of no free entry found, just crash the system.
@@ -850,6 +878,12 @@ void __init xen_add_remap_nonram(phys_addr_t maddr, phys_addr_t paddr,
 		BUG();
 	}
 
+#ifdef CONFIG_ACPI
+	/* Switch to the Xen acpi_os_ioremap() variant. */
+	if (nr_nonram_remap == 0)
+		acpi_os_ioremap = xen_acpi_os_ioremap;
+#endif
+
 	xen_nonram_remap[nr_nonram_remap].maddr = maddr;
 	xen_nonram_remap[nr_nonram_remap].paddr = paddr;
 	xen_nonram_remap[nr_nonram_remap].size = size;
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 2c79bb5a9cd0..1114e49937da 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -15,12 +15,12 @@
 #include <linux/cpuidle.h>
 #include <linux/cpufreq.h>
 #include <linux/memory_hotplug.h>
+#include <linux/acpi.h>
 
 #include <asm/elf.h>
 #include <asm/vdso.h>
 #include <asm/e820/api.h>
 #include <asm/setup.h>
-#include <asm/acpi.h>
 #include <asm/numa.h>
 #include <asm/idtentry.h>
 #include <asm/xen/hypervisor.h>
-- 
2.43.0


