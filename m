Return-Path: <linux-acpi+bounces-20931-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPHXJdl2jGk6ogAAu9opvQ
	(envelope-from <linux-acpi+bounces-20931-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FDA12445E
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 533EE3011F20
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305DC1917FB;
	Wed, 11 Feb 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cH+qQUI9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB75219FC;
	Wed, 11 Feb 2026 12:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813098; cv=none; b=uJ40wiO5QZuOS2I8kIXPzy5Ho6Lwijt1Qnnde1FuT+WkbI99I5UAc87Ry819Ovqgdlz3MuSV7rjvQTHtcUzISUXuiYF1aiCAr0AOerzt5vTPQQWJ6E+ke5yXjAAys7IY4e3YhNlD41vlxnkq/7PkN+j2O2GCfdDudi13q/XvPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813098; c=relaxed/simple;
	bh=AKmn+x7+9jSRIAMop/lI7X3hUMmGJY4xfeP9EXGj6Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmZYqz1rI83RWRFhMFBABbnU+NnyS5ZT7F8EHPfIrtbw9XS2bmWQVqa9/h2sx9tN4GyBTII9SS/kCjyNuQMVW/CRxe14sUgyZF0MqokzfPviH3c/SdUEu2ItdHn/s4UR+sqmb+eAu2GDNoBXFKF7DWpIkGUrsTvPXjJ33HS9pzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cH+qQUI9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78044C19421;
	Wed, 11 Feb 2026 12:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813097;
	bh=AKmn+x7+9jSRIAMop/lI7X3hUMmGJY4xfeP9EXGj6Vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cH+qQUI9Fs5Y/2hV1TmzhH1S7njSPwHas0VL6ZJEKMw76cgE6R2/wYzuL+yh12x/X
	 FG5bFG79H2pII2TZtPypAKEhrtncdGvtcXRIoUYCBMcLk1RzyCMr2pcQ8rudO6uwk9
	 1zp/T54g+CYF0U8sW7Vgy3xWs1I884DQGa6BqE6QFBpsNd+m3r2aFLXV2G4btlp+Tv
	 e86ZZT8VIoESOtNhwBCG8EwB5iCHQAzD0LqODYm9xmIE5OBvNATXIece0YP5zkCsQt
	 sfnX1d1tPg46E+VZuvsos3Bqx8k2DGEMGuaZe/BcrW7swzJGKqUhBuxebWnwt4Qit7
	 AzrFIrt/eoz6w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	bp@alien8.de,
	patrick.rudolph@9elements.com,
	zhangdandan@uniontech.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] EFI/CPER: don't go past the ARM processor CPER record buffer
Date: Wed, 11 Feb 2026 07:30:21 -0500
Message-ID: <20260211123112.1330287-11-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211123112.1330287-1-sashal@kernel.org>
References: <20260211123112.1330287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-20931-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,huawei];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 28FDA12445E
X-Rspamd-Action: no action

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit eae21beecb95a3b69ee5c38a659f774e171d730e ]

There's a logic inside GHES/CPER to detect if the section_length
is too small, but it doesn't detect if it is too big.

Currently, if the firmware receives an ARM processor CPER record
stating that a section length is big, kernel will blindly trust
section_length, producing a very long dump. For instance, a 67
bytes record with ERR_INFO_NUM set 46198 and section length
set to 854918320 would dump a lot of data going a way past the
firmware memory-mapped area.

Fix it by adding a logic to prevent it to go past the buffer
if ERR_INFO_NUM is too big, making it report instead:

	[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
	[Hardware Error]: event severity: recoverable
	[Hardware Error]:  Error 0, type: recoverable
	[Hardware Error]:   section_type: ARM processor error
	[Hardware Error]:   MIDR: 0xff304b2f8476870a
	[Hardware Error]:   section length: 854918320, CPER size: 67
	[Hardware Error]:   section length is too big
	[Hardware Error]:   firmware-generated error record is incorrect
	[Hardware Error]:   ERR_INFO_NUM is 46198

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
[ rjw: Subject and changelog tweaks ]
Link: https://patch.msgid.link/41cd9f6b3ace3cdff7a5e864890849e4b1c58b63.1767871950.git.mchehab+huawei@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Here's the complete, thorough analysis:

---

## Comprehensive Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly describes a **buffer overread vulnerability**
in the ARM processor CPER (Common Platform Error Record) parser. It
explains:

- **Root cause**: The existing code only validated if `section_length`
  was too *small*, but never checked if it was too *big* relative to the
  actual buffer size.
- **Concrete exploit scenario**: A 67-byte CPER record with
  `ERR_INFO_NUM=46198` and `section_length=854918320` would cause the
  kernel to read far past the firmware memory-mapped area.
- **Impact**: "Would dump a lot of data going a way past the firmware
  memory-mapped area" — this is an **out-of-bounds memory read**.
- **Quality indicators**: Reviewed-by Jonathan Cameron, Acked-by Ard
  Biesheuvel (the EFI subsystem maintainer), Reviewed-by Hanjun Guo.
  Multiple expert reviewers agreed this is needed.

### 2. CODE CHANGE ANALYSIS

The vulnerability is in `cper_print_proc_arm()` in
`drivers/firmware/efi/cper-arm.c`. Here's the precise mechanism:

**Before the fix** (current code at lines 228-247 of cper-arm.c):

```228:247:drivers/firmware/efi/cper-arm.c
void cper_print_proc_arm(const char *pfx,
                         const struct cper_sec_proc_arm *proc)
{
        int i, len, max_ctx_type;
        struct cper_arm_err_info *err_info;
        struct cper_arm_ctx_info *ctx_info;
        char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
        char error_type[120];

        printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);

        len = proc->section_length - (sizeof(*proc) +
                proc->err_info_num * (sizeof(*err_info)));
        if (len < 0) {
                printk("%ssection length: %d\n", pfx,
proc->section_length);
                printk("%ssection length is too small\n", pfx);
                printk("%sfirmware-generated error record is
incorrect\n", pfx);
                printk("%sERR_INFO_NUM is %d\n", pfx,
proc->err_info_num);
                return;
        }
```

The problem:
- `proc->section_length` comes from firmware (untrusted data)
- `proc->err_info_num` also comes from firmware (untrusted data)
- The code checks `len < 0` — this catches the case where
  `section_length` is too small to hold the claimed `err_info_num`
  entries
- **But it never compares `section_length` against the actual buffer
  size** passed from GHES as `gdata->error_data_length`

When `section_length` is absurdly large (e.g. 854918320), `len` becomes
a huge positive number, passing the `len < 0` check. Then:

1. The `for (i = 0; i < proc->err_info_num; i++)` loop at line 266
   iterates `err_info_num` times (e.g. 46198 times), reading `struct
   cper_arm_err_info` entries at `proc + 1` and beyond — **far past the
   actual 67-byte buffer**.

2. The `ctx_info` loop at line 311 uses `ctx_info->size` (read from
   garbage memory) for `print_hex_dump()`, dumping arbitrary memory to
   the kernel log.

3. The vendor-specific data section at line 333 dumps `len` bytes — up
   to 854 million bytes of arbitrary memory.

**The fix** makes three surgical changes:

1. **Adds a `u32 length` parameter** to `cper_print_proc_arm()` — this
   is the true buffer size from GHES (`gdata->error_data_length`)

2. **Extends the validation** from `if (len < 0)` to `if (len < 0 ||
   proc->section_length > length)` — catches both "too small" AND "too
   big"

3. **Updates the caller** in `cper.c` to pass `gdata->error_data_length`

### 3. CLASSIFICATION

This is an **out-of-bounds read / buffer overread bug fix**.
Specifically:
- **Security vulnerability**: Kernel reads past buffer bounds based on
  untrusted firmware input
- **Information disclosure**: Arbitrary kernel memory dumped to kernel
  log via `print_hex_dump()`
- **Potential crash**: If the read crosses into unmapped pages, a kernel
  oops/panic results
- The data source (firmware CPER records) is effectively **untrusted
  input** that can be malformed due to firmware bugs or potentially
  malicious firmware

### 4. SCOPE AND RISK ASSESSMENT

**Size**: ~20 lines changed across 3 files. Extremely small and focused.

**Files touched**:
- `drivers/firmware/efi/cper-arm.c` — the fix itself (adds parameter +
  check)
- `drivers/firmware/efi/cper.c` — call site update (passes buffer
  length)
- `include/linux/cper.h` — declaration update

**Risk of regression**: Essentially zero.
- For **correct firmware** data where `section_length <=
  error_data_length`, behavior is completely unchanged
- For **incorrect firmware** data where `section_length >
  error_data_length`, the function now safely returns early with a
  diagnostic message instead of overreading memory
- The only caller (`cper_estatus_print_section`) is updated in this same
  commit

**Dependency check**: The function `cper_print_proc_arm` has existed
since 2018 (commit c6d8c8ef1d0d). The two-parameter signature has been
stable. The core fix (adding a `length` parameter and a bounds check) is
independent of recent changes like the FIELD_GET refactoring
(96b010536ee02) or the infopfx size fix (8ad2c72e21efb). For older
stable trees, a minor context adjustment may be needed but the actual
fix lines will apply cleanly.

### 5. USER IMPACT

- **Affected platforms**: ARM64/ARM systems with GHES hardware error
  reporting — primarily ARM servers (e.g., Ampere, HiSilicon Kunpeng,
  Qualcomm Centriq) used in data centers
- **Trigger**: Firmware sends a malformed CPER record with a bogus
  `section_length`. This can happen due to:
  - Firmware bugs (the commit message gives a concrete real-world
    example)
  - Corrupt error records in BIOS/UEFI memory
  - Potentially adversarial firmware in a compromised system
- **Severity when triggered**: Information disclosure (kernel memory in
  dmesg), potential kernel crash, massive log flood (millions of lines)
- **Impact on enterprise systems**: ARM servers running in production
  with RAS features are the primary users of this code path

### 6. STABILITY INDICATORS

- **Reviewed-by**: Jonathan Cameron (experienced kernel developer)
- **Acked-by**: Ard Biesheuvel (EFI subsystem maintainer)
- **Reviewed-by**: Hanjun Guo (ARM/ACPI maintainer)
- **Merged by**: Rafael J. Wysocki (ACPI/PM maintainer)
- Multiple expert reviewers agreed on the fix — high confidence in
  correctness

### 7. DEPENDENCY CHECK

Confirmed via `semcode-find_callers` that there is exactly **one
caller** of `cper_print_proc_arm()`: `cper_estatus_print_section()` in
`cper.c`. Both the caller and the callee are updated in this single
commit. The fix is completely self-contained with no external
dependencies.

The code this fixes has existed since Linux 4.16 (when `cper-arm.c` was
split out), and the vulnerable pattern (only checking for "too small"
section_length) has been present since the original ARM CPER parsing
code was added. All stable trees with ARM CPER support are affected.

### Summary

This commit fixes a clear **out-of-bounds memory read vulnerability** in
the ARM CPER error record parser. Firmware-provided `section_length`
values are blindly trusted, allowing a malformed record to cause the
kernel to read (and dump to dmesg) vast amounts of memory beyond the
actual buffer. The fix adds a single bounds check comparing the
firmware-claimed length against the actual buffer size. It is:

- **Small and surgical** (~20 lines, 3 files)
- **Obviously correct** (just adding a missing bounds check)
- **Zero regression risk** (only changes behavior for malformed data)
- **Security-relevant** (information disclosure, potential crash)
- **Well-reviewed** (4 expert reviewers/ackers)
- **Self-contained** (no dependencies on other patches)
- **Affects real hardware** (ARM servers with GHES)
- **Long-standing bug** (present since 2018, affects all stable trees)

This is a textbook stable backport candidate that meets every stable
kernel rule.

**YES**

 drivers/firmware/efi/cper-arm.c | 12 ++++++++----
 drivers/firmware/efi/cper.c     |  3 ++-
 include/linux/cper.h            |  3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 76542a53e2027..b21cb1232d820 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -226,7 +226,8 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 }
 
 void cper_print_proc_arm(const char *pfx,
-			 const struct cper_sec_proc_arm *proc)
+			 const struct cper_sec_proc_arm *proc,
+			 u32 length)
 {
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
@@ -238,9 +239,12 @@ void cper_print_proc_arm(const char *pfx,
 
 	len = proc->section_length - (sizeof(*proc) +
 		proc->err_info_num * (sizeof(*err_info)));
-	if (len < 0) {
-		printk("%ssection length: %d\n", pfx, proc->section_length);
-		printk("%ssection length is too small\n", pfx);
+
+	if (len < 0 || proc->section_length > length) {
+		printk("%ssection length: %d, CPER size: %d\n",
+		       pfx, proc->section_length, length);
+		printk("%ssection length is too %s\n", pfx,
+		       (len < 0) ? "small" : "big");
 		printk("%sfirmware-generated error record is incorrect\n", pfx);
 		printk("%sERR_INFO_NUM is %d\n", pfx, proc->err_info_num);
 		return;
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 09a4f0168df80..06b4fdb59917a 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -664,7 +664,8 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 
 		printk("%ssection_type: ARM processor error\n", newpfx);
 		if (gdata->error_data_length >= sizeof(*arm_err))
-			cper_print_proc_arm(newpfx, arm_err);
+			cper_print_proc_arm(newpfx, arm_err,
+					    gdata->error_data_length);
 		else
 			goto err_section_too_small;
 #endif
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 5b1236d8c65bb..440b35e459e53 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -595,7 +595,8 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *,
 const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
 void cper_print_proc_arm(const char *pfx,
-			 const struct cper_sec_proc_arm *proc);
+			 const struct cper_sec_proc_arm *proc,
+			 u32 length);
 void cper_print_proc_ia(const char *pfx,
 			const struct cper_sec_proc_ia *proc);
 int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg);
-- 
2.51.0


