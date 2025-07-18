Return-Path: <linux-acpi+bounces-15234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EC0B0A826
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jul 2025 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12804A43EF7
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Jul 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17E72E612B;
	Fri, 18 Jul 2025 16:11:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C02E611F;
	Fri, 18 Jul 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752855082; cv=none; b=jnTW15KRutjxSx5oVpbb1wd3uKSZwcXjKaT3PYbVctoNHvZmnkAYHupR8iFc764ahxNG+kxrhjoRiA8UAmlV8Om9kLHnrl04xzhgH6LpQFN3KDpIIM36TuwgpMGqpOuDWj4vEDQK/c03OsRk1XlRTP+9LGZmlkiF2IvYQFWFHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752855082; c=relaxed/simple;
	bh=XHgiyEjPJ+WCMu2WjrK8ME5xyrBwVfaiU4xdmlEA4aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhP1sX6WMN42n//CwFKOAHALFObqG+yY0EUQZWXGOq8D6wXL5BlnjbR8581Ri1wlWvod/Hnb4G7uuM6sv1OmVGyrHgGxuV/GzJCbxwc0/W1kBUGjyJzVxgQ1hI7GcOlk0q2U7cIKr2uQWj6U+DmV4TrpES4mrAx2Ae6bBfqbTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0de1c378fso332922066b.3;
        Fri, 18 Jul 2025 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752855079; x=1753459879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqEj8W5u0PUeUJPY+sEKzsugXYSIb9vt2kBSXIxBRws=;
        b=fBmhyVRjos9AtLOFFv/MuIwhcLOTDRhcec66jKuJl/Vz/FTSrDqCw5fTTPCBxg5mH4
         UqH1Gw2x0gGLml9g00nqepm8fdL327THBY7ly3tMX7WnBLiP/ZWEe3ZkyPZASQjaCmu1
         BVSHppVcJ9TNfIVOCNvj9jwJkcZjZTjIG1wYQpcg4uuTiP34wHaRXh2trdaXobwnXXZz
         3EGn9jIkWwDZGhS4TXCaC/n9/0IGEgRoLcExVVnukXt9mP3qRJjih24UXLJG3ddebNVs
         0YzcOlgMPXZ7bCxH81AbGxduL1gV8FYnL7PeUMtGlXLSUtbKfRLu/2LPwGForJNNJZqN
         Q6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbogGpddAGc0PHRble7v+qPA4tzfiLXodlArgZ5ZZlYiFEHRCyVOOwunnpWyAtFMpoNf/rxqpNDVbu@vger.kernel.org, AJvYcCWzKoCvEFrXOj8hQFZirvBpJuU8033Zsm8fwEJ/RMJn0I+NRqttkVyA7HLFPWq6I1tGMJ3SFFGfiEnnrieg@vger.kernel.org
X-Gm-Message-State: AOJu0YzmJ2KV6a7qkxHQfLFjTqDJgzCS39BlbFKcuZ1J00Rq+eTeqE91
	pnNZ22mkJSZe5P7OCiPCleGGzPoLL5ls3ydFMOBRoBlKjKq/7rOkb/Dz
X-Gm-Gg: ASbGncs5GB/0M+E3pNg81mTAjMl3JD5sGhx99XHIqgfj8YI7w9PYkzhoBxjjByM3DQb
	xbpBvsgpHuRyeU0/ZtIT74AO6Gq+Mlcm0fWvNJ47ywkXfUs7hMqMr/yDwi0zC595YJpJEoSBysw
	clDpSHOsp4SDwjGLnhh0zuaVEiMEP1XBwR+tEp9rtii0m/18SBhHH1vb3QC3tgkyVOlTvxP/IbU
	WLRn3++GxBHGaXHwv5OvXP6vb0xCj2k91LbJSrVWP3fUiw22G0Y0hhhMsYY5+C0loqcOI2Hav5N
	JVaGAl6ff0u96+528Dqcwv2XPM3FqAlu5VXiNwQ0hnIeQCq22nArb4B/49LlkeALIF4isNDo+lC
	QFwFdvRI824tOXt3ZwzDx
X-Google-Smtp-Source: AGHT+IEiIuDXKUJLBKu3VOqaAEewUE0HyZp4v/jj6blHZALvKRW9GCnqD0O0owXO5y4N0JWIx1a0ew==
X-Received: by 2002:a17:906:d54d:b0:aec:578e:caf0 with SMTP id a640c23a62f3a-aec578ecd9fmr676449266b.29.1752855078677;
        Fri, 18 Jul 2025 09:11:18 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7ae11sm142459866b.108.2025.07.18.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:11:18 -0700 (PDT)
Date: Fri, 18 Jul 2025 09:11:15 -0700
From: Breno Leitao <leitao@debian.org>
To: "Luck, Tony" <tony.luck@intel.com>, xueshuai@linux.alibaba.com, 
	mahesh@linux.ibm.com, oohall@gmail.com
Cc: Borislav Petkov <bp@alien8.de>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>, osandov@osandov.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <mazejvrglvtqdfsevduahqxvlvjv6hlo3apivossn2jnxpsuds@os6kxmmsq3xt>
References: <20250714-vmcore_hw_error-v1-1-8cf45edb6334@debian.org>
 <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <kw7mwmca3ir4nfyofumqiack5sht3aisdchevykdtmlio6xo7z@5xbdibpqvqix>
 <SJ1PR11MB6083CEAB23FCE85937DC5403FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083CEAB23FCE85937DC5403FC51A@SJ1PR11MB6083.namprd11.prod.outlook.com>

Hello Tony,

On Thu, Jul 17, 2025 at 05:29:14PM +0000, Luck, Tony wrote:
>
> If the intent is still to add this information to vmcore (as in
> earlier discussions in this thread). Then it could go into
> kernel/vmcore_info.c (and be configured with CONFIG_VMCORE_INFO).
> 
> Would just need an empty stub in some header file for the
> log_recovered_error() function.

Thanks for the suggestion.

I found that I don't need to expose the metrics in vmcore info at all to
be able to read them from vmcore, given crash/drgn can read those
symbols.

Global variable hwerror_tracking will be write-only during kernel
run-time, and only read during post morten analyzes. I am still not sure
if the compiler might not get rid of them completely, given no on reads.
I am wondering if I should EXPORT_SYMBOL_GPL(hwerror_tracking) to avoid
any optimization there.

Anyway, this is the patch I am using and it solves the problem I am
interested in. Any opinion?

Thanks for your support,
--breno

commit 396d9bd5266607731b535f4246fd3e4971df9016
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jul 17 07:39:26 2025 -0700

    vmcoreinfo: Track and log recoverable hardware errors
    
    Introduce a generic infrastructure for tracking recoverable hardware
    errors (HW errors that did not cause a panic) and record them for vmcore
    consumption. This aids post-mortem crash analysis tools by preserving
    a count and timestamp for the last occurrence of such errors.
    
    This patch adds centralized logging for three common sources of
    recoverable hardware errors:
    
      - PCIe AER Correctable errors
      - x86 Machine Check Exceptions (MCE)
      - APEI/CPER GHES corrected or recoverable errors
    
    Each source logs to a shared `hwerror_tracking` array, protected by a
    spinlock, and maintains a per-source error count and timestamp of the
    most recent event.
    
    hwerror_tracking is write-only at kernel runtime, and it is meant to be
    read from vmcore using tools like crash/drgn. For example, this is how
    it looks like from drgn:
    
            >>> prog['hwerror_tracking']
            (struct hwerror_tracking_info [3]){
                    {
                            .count = (int)0,
                            .timestamp = (time64_t)0,
                    },
                    {
                            .count = (int)0,
                            .timestamp = (time64_t)0,
                    },
                    {
                            .count = (int)844,
                            .timestamp = (time64_t)1752852018,
                    },
            }
    
    Suggested-by: Tony Luck <tony.luck@intel.com>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81d..781cf574642eb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -45,6 +45,7 @@
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
 #include <linux/kexec.h>
+#include <linux/vmcore_info.h>
 
 #include <asm/fred.h>
 #include <asm/cpu_device_id.h>
@@ -1692,6 +1693,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 out:
 	instrumentation_end();
 
+	/* Given it didn't panic, mark it as recoverable */
+	hwerror_tracking_log(HWE_RECOV_MCE);
 clear:
 	mce_wrmsrq(MSR_IA32_MCG_STATUS, 0);
 }
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f0584ccad4519..255453cdc72e9 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -43,6 +43,7 @@
 #include <linux/uuid.h>
 #include <linux/ras.h>
 #include <linux/task_work.h>
+#include <linux/vmcore_info.h>
 
 #include <acpi/actbl1.h>
 #include <acpi/ghes.h>
@@ -1100,13 +1101,16 @@ static int ghes_proc(struct ghes *ghes)
 {
 	struct acpi_hest_generic_status *estatus = ghes->estatus;
 	u64 buf_paddr;
-	int rc;
+	int rc, sev;
 
 	rc = ghes_read_estatus(ghes, estatus, &buf_paddr, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+	sev = ghes_severity(estatus->error_severity);
+	if (sev == GHES_SEV_RECOVERABLE || sev ==  GHES_SEV_CORRECTED)
+		hwerror_tracking_log(HWE_RECOV_GHES);
+	else if (sev >= GHES_SEV_PANIC)
 		__ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ);
 
 	if (!ghes_estatus_cached(estatus)) {
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 70ac661883672..9d4fa1cb8afb9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -30,6 +30,7 @@
 #include <linux/kfifo.h>
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
+#include <linux/vmcore_info.h>
 #include <acpi/apei.h>
 #include <acpi/ghes.h>
 #include <ras/ras_event.h>
@@ -746,6 +747,7 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	switch (info->severity) {
 	case AER_CORRECTABLE:
 		aer_info->dev_total_cor_errs++;
+		hwerror_tracking_log(HWE_RECOV_AER);
 		counter = &aer_info->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
diff --git a/include/linux/vmcore_info.h b/include/linux/vmcore_info.h
index 37e003ae52626..5894da92a6ba4 100644
--- a/include/linux/vmcore_info.h
+++ b/include/linux/vmcore_info.h
@@ -77,4 +77,18 @@ extern u32 *vmcoreinfo_note;
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len);
 void final_note(Elf_Word *buf);
+
+enum hwerror_tracking_source {
+	HWE_RECOV_AER,
+	HWE_RECOV_MCE,
+	HWE_RECOV_GHES,
+	HWE_RECOV_MAX,
+};
+
+#ifdef CONFIG_VMCORE_INFO
+void hwerror_tracking_log(enum hwerror_tracking_source src);
+#else
+void hwerror_tracking_log(enum hwerror_tracking_source src) {};
+#endif
+
 #endif /* LINUX_VMCORE_INFO_H */
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f89..c3d2bfffec298 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -31,6 +31,14 @@ u32 *vmcoreinfo_note;
 /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
 static unsigned char *vmcoreinfo_data_safecopy;
 
+static struct hwerror_tracking_info {
+	int         count;
+	time64_t    timestamp;
+};
+
+static struct hwerror_tracking_info hwerror_tracking[HWE_RECOV_MAX];
+static DEFINE_SPINLOCK(hwerror_tracking_lock);
+
 Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
 			  void *data, size_t data_len)
 {
@@ -118,6 +126,23 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
+void hwerror_tracking_log(enum hwerror_tracking_source src)
+{
+	struct hwerror_tracking_info *hwet;
+	unsigned long flags;
+
+	if (src < 0 || src >= HWE_RECOV_MAX)
+		return;
+
+	hwet = &hwerror_tracking[src];
+
+	spin_lock_irqsave(&hwerror_tracking_lock, flags);
+	hwet->count++;
+	hwet->timestamp = ktime_get_real_seconds();
+	spin_unlock_irqrestore(&hwerror_tracking_lock, flags);
+}
+EXPORT_SYMBOL_GPL(hwerror_tracking_log);
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);

