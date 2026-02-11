Return-Path: <linux-acpi+bounces-20933-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOOiCfJ2jGktpAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20933-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D0A1244B1
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6CF301727F
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 12:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B801E194AD7;
	Wed, 11 Feb 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeaPklRw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1F1862;
	Wed, 11 Feb 2026 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813103; cv=none; b=bMdKhUuIKs1yoM1yCwzHKuO9cyf3AqPF3/NWkGctKhlaxCER2gQirrdob1O2Jk+NtEhXK6RQaExep6nmoLQWd8mms1JxCkaZCSNC/IC7CXLD1+UUfspRs712K3N+14gY4Lc4cDEiH8HdFv0bII3YnWMyqoPbqP+0rjb78lcV/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813103; c=relaxed/simple;
	bh=IuUmQoIriVmOsUtRQ4eRzcOCpMlPETZZJK6kkYLwc+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhUWE0SmlN4BcH7A4+KbOnZG9eKqFlDwc2hXnSikhlDNYpL4weFTIDQVN1ftT+E4+JzuOueoc/fNkSdEUAj+m68o9iEU/SqYK/bLvflSJobsn/WUhuvDjYa7f7IFj9Y4FWiOG7ETRTw8fqKERw1UpzUQnAzxYoih1QYJzFdozQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeaPklRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16146C19424;
	Wed, 11 Feb 2026 12:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813103;
	bh=IuUmQoIriVmOsUtRQ4eRzcOCpMlPETZZJK6kkYLwc+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YeaPklRwjyMhOm+jf+9blAzD7WfkuYUzttKg5RomXVGraRCuBDFla1HO9K3nDefGL
	 zQOTr6+kJIsXb3ChDbQ+6/ahvNsrDvWe28DvLY9mNuzg9e4WOWorDCVCpYy9529xfs
	 akzjKrMD1ZOwaZcyuilEwUyhIWeA5X2gHtlAqoA2UL+iKOj7rg3DVO/kgCVfWc33Ep
	 gMzyoaUbjNx2HGXtlEJFoqZH9sjeu0wDp8bjUXlUTrqBN2U6AEYywIPam4uzkFqwyc
	 0ocsyDUrwDLvPKI8CzPtCwRWK9IAHfNtbj4VH0XqiahJvnKmxPnPTy5vlLjvHH/ZS2
	 bRskeK6g5PBZw==
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
	zhangdandan@uniontech.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] EFI/CPER: don't dump the entire memory region
Date: Wed, 11 Feb 2026 07:30:24 -0500
Message-ID: <20260211123112.1330287-14-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-20933-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: E4D0A1244B1
X-Rspamd-Action: no action

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit 55cc6fe5716f678f06bcb95140882dfa684464ec ]

The current logic at cper_print_fw_err() doesn't check if the
error record length is big enough to handle offset. On a bad firmware,
if the ofset is above the actual record, length -= offset will
underflow, making it dump the entire memory.

The end result can be:

 - the logic taking a lot of time dumping large regions of memory;
 - data disclosure due to the memory dumps;
 - an OOPS, if it tries to dump an unmapped memory region.

Fix it by checking if the section length is too small before doing
a hex dump.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
[ rjw: Subject tweaks ]
Link: https://patch.msgid.link/1752b5ba63a3e2f148ddee813b36c996cc617e86.1767871950.git.mchehab+huawei@kernel.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This completes my analysis. Here is the comprehensive summary:

---

## Detailed Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message is extremely clear about the bug and its
consequences:
- **Root cause**: `cper_print_fw_err()` does not validate that the error
  record's `length` is large enough to accommodate the computed
  `offset`. On buggy firmware, if offset > length, the unsigned
  subtraction `length -= offset` underflows.
- **Three consequences**: (1) Massive kernel log output dumping huge
  memory regions (DoS), (2) Data disclosure from kernel memory dumps,
  (3) Kernel OOPS if it accesses unmapped memory.

The commit is authored by Mauro Carvalho Chehab (a prominent Linux
kernel developer), reviewed by Jonathan Cameron, acked by Ard Biesheuvel
(the EFI subsystem maintainer), and merged by Rafael J. Wysocki.

### 2. CODE CHANGE ANALYSIS

The fix is exactly **5 lines** of new code, inserted at lines 563-567 of
`cper.c`:

```563:567:drivers/firmware/efi/cper.c
        if (offset > length) {
                printk("%s""error section length is too small:
offset=%d, length=%d\n",
                       pfx, offset, length);
                return;
        }
```

**The bug mechanism in detail:**

The `struct cper_sec_fw_err_rec_ref` is packed:
- `record_type` (u8): offset 0
- `revision` (u8): offset 1
- `reserved[6]` (u8): offset 2
- `record_identifier` (u64): offset 8
- `record_identifier_guid` (guid_t, 16 bytes): offset 16
- Total `sizeof` = 32

The function computes an `offset` based on the `revision` field from
firmware:
- revision 0: offset = 16 (`offsetof(record_identifier_guid)`)
- revision 1: offset = 8 (`offsetof(record_identifier)`)
- revision ≥ 2: offset = 32 (`sizeof(*fw_err)`)

The caller in `cper_estatus_print_section()` (line 682) only validates
`gdata->error_data_length >= SZ_16` (16 bytes) before calling
`cper_print_fw_err()`. This means:

- **Any firmware reporting revision ≥ 2 with `error_data_length` between
  16 and 31 bytes causes the underflow.** For example, with `length=16`
  and `revision=2`, `offset=32`, and `length -= offset` wraps the `u32`
  to **0xFFFFFFF0 (4,294,967,280 bytes = ~4 GB)**.

This massive value is then passed to `print_hex_dump()` which loops
through the buffer printing 16 bytes per line. This causes:
1. The kernel to attempt reading ~4GB of arbitrary memory past the
   firmware error record
2. Massive printk output flooding the kernel log
3. A kernel OOPS/crash when accessing unmapped memory regions

### 3. CLASSIFICATION

This is unambiguously a **security and stability bug fix**:
- **Integer underflow** leading to out-of-bounds memory access
- **Information disclosure** (kernel memory contents leaked via printk)
- **Denial of service** (system hangs printing ~4GB of memory)
- **Kernel crash** (OOPS when accessing unmapped addresses)

This is triggered by bad firmware data, which is a realistic scenario -
the CPER subsystem exists specifically to parse firmware-provided error
records, and firmware is notoriously buggy.

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: +5 lines (one bounds check + error message +
  return)
- **Files touched**: 1 file (`drivers/firmware/efi/cper.c`)
- **Complexity**: Minimal - a simple comparison before subtraction
- **Risk of regression**: Essentially zero. The fix adds a guard that
  only fires when `offset > length`, which is an invalid/corrupt
  condition. Normal firmware error records will have length ≥ offset, so
  the new check won't affect normal operation.
- **Subsystem maturity**: The EFI/CPER subsystem is mature and stable

### 5. USER IMPACT

- **Who is affected**: All systems with EFI firmware that produce CPER
  records (most modern x86 and ARM64 systems)
- **Trigger**: Buggy firmware producing a Firmware Error Record
  Reference section with a small section length and revision ≥ 2
- **Severity**: HIGH - ranges from system hang to kernel crash to
  information disclosure
- **Real-world likelihood**: Moderate. CPER records are generated by
  firmware during hardware errors, and the commit message indicates this
  was found during real firmware debugging ("On a bad firmware...")

### 6. STABILITY INDICATORS

- Reviewed-by: Jonathan Cameron (experienced kernel developer)
- Acked-by: Ard Biesheuvel (EFI subsystem maintainer)
- Merged by: Rafael J. Wysocki (ACPI/PM subsystem maintainer)
- Author: Mauro Carvalho Chehab (long-time kernel maintainer)

### 7. DEPENDENCY CHECK

- The buggy code was introduced in **v5.7** (commit `3d8c11efd528`,
  "efi: cper: Add support for printing Firmware Error Record
  Reference").
- The `cper_print_fw_err()` function has **never been modified** since
  its introduction - the fix will apply cleanly to all stable trees from
  5.10.y onward.
- The fix is completely self-contained with **zero dependencies** on
  other patches.
- The surrounding context (both before and after the insertion point) is
  identical to the original code from 2020.

### Summary

This is a textbook stable-tree backport candidate. It fixes a real
security/stability bug (unsigned integer underflow causing ~4GB out-of-
bounds memory access) with a tiny, obviously correct, 5-line bounds
check. The fix has been reviewed and acked by the relevant subsystem
maintainer, has zero risk of regression, no dependencies, and applies
cleanly to all stable trees where the vulnerable code exists (5.10.y
through 6.12.y and beyond). The bug has been present since v5.7 and
affects all EFI systems.

**YES**

 drivers/firmware/efi/cper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index bd99802cb0cad..09a4f0168df80 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -560,6 +560,11 @@ static void cper_print_fw_err(const char *pfx,
 	} else {
 		offset = sizeof(*fw_err);
 	}
+	if (offset > length) {
+		printk("%s""error section length is too small: offset=%d, length=%d\n",
+		       pfx, offset, length);
+		return;
+	}
 
 	buf += offset;
 	length -= offset;
-- 
2.51.0


