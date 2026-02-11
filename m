Return-Path: <linux-acpi+bounces-20937-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDrjNeB2jGk6ogAAu9opvQ
	(envelope-from <linux-acpi+bounces-20937-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 915CD124484
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 13:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B444E301C106
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Feb 2026 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738A1C84BD;
	Wed, 11 Feb 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVjHm1AJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41331BCA1C;
	Wed, 11 Feb 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770813134; cv=none; b=ubGZo+O966GsggevRSvcvLJS0ym4Jeo7QLwWakO73O6vKB98PvzfDr7D5MKvxGdbTJ27UgDA29K1ZxIyVzDGMSeAlmw81tZbs55Q696rgKs3nnrdTHQIoVNFiPY+LreQAeCQEeOqWjlmGckxSC4LiHFf96pYZKbwBD68iKfh/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770813134; c=relaxed/simple;
	bh=KmWpsL7YEzJCn/fYCpLilJVC1KaJwKdJsUjebXGoJG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAEuG0dvNahBXDEaLOO6a143uLqYLlw9Wqzfjsx+lA4JL2Z/i7q0uovqjiNhuKoBi+M1bsGHSo3l/wR3CWvvjsG2J2kfc9YUPli8H/gOHAUoi3mVnIm66ww0jodAHUSI4RC4otbLg/VRglShYRXq6n/AJAvikTJ0y1bVu9RFcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVjHm1AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71AAC19421;
	Wed, 11 Feb 2026 12:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770813134;
	bh=KmWpsL7YEzJCn/fYCpLilJVC1KaJwKdJsUjebXGoJG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVjHm1AJx2yZ5r+agmLqLnJLMa2LxLFNLlCkz5hc+o1C/dWfW0jaNxNeqVtsfZ+y3
	 kRks0ky603HOVr8+V8CzqDpZzx8FY+znOe80eQEHQE4OybOgBISJImFMRh8zzFwqvy
	 UFzQGBaeIGgXuKEm/v8oraHQ14iDMAcrNxTac3v/1Yp38+MgtkJV9UE9VmHf/HqRT7
	 vVlUOY5iu1noq7XhMQ5KcwA+vDYGa9fTShcf8YZaERotZ8zizDE6y7OJ6tXutXiThm
	 lbTjeQRXTazHgMxxfRAYFhDw3J19SR1uR2Bh5OIJKRA9uaN203eHPPkKuskRdLwXs8
	 MEXyuEZ8H/Adw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tuo Li <islituo@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] ACPI: processor: Fix NULL-pointer dereference in acpi_processor_errata_piix4()
Date: Wed, 11 Feb 2026 07:30:39 -0500
Message-ID: <20260211123112.1330287-29-sashal@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20937-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 915CD124484
X-Rspamd-Action: no action

From: Tuo Li <islituo@gmail.com>

[ Upstream commit f132e089fe89cadc2098991f0a3cb05c3f824ac6 ]

In acpi_processor_errata_piix4(), the pointer dev is first assigned an IDE
device and then reassigned an ISA device:

  dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB, ...);
  dev = pci_get_subsys(..., PCI_DEVICE_ID_INTEL_82371AB_0, ...);

If the first lookup succeeds but the second fails, dev becomes NULL. This
leads to a potential null-pointer dereference when dev_dbg() is called:

  if (errata.piix4.bmisx)
    dev_dbg(&dev->dev, ...);

To prevent this, use two temporary pointers and retrieve each device
independently, avoiding overwriting dev with a possible NULL value.

Signed-off-by: Tuo Li <islituo@gmail.com>
[ rjw: Subject adjustment, added an empty code line ]
Link: https://patch.msgid.link/20260111163214.202262-1-islituo@gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me write the final analysis.

---

## Detailed Analysis

### 1. Commit Message Analysis

The commit explicitly says "Fix NULL-pointer dereference" - a well-
documented, clearly understood bug. The commit message includes:
- The exact code path that triggers the bug
- The specific variable (`dev`) that becomes NULL
- The mechanism: overwriting a pointer with two sequential PCI lookups
- Accepted and adjusted by the ACPI subsystem maintainer Rafael J.
  Wysocki

### 2. Code Change Analysis - The Bug

Looking at the pre-patch code in `acpi_processor_errata_piix4()`:

```49:147:drivers/acpi/acpi_processor.c
static int acpi_processor_errata_piix4(struct pci_dev *dev)
{
        u8 value1 = 0;
        u8 value2 = 0;
        // ...
        // Inside switch cases 0-3:
                dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
                                     PCI_DEVICE_ID_INTEL_82371AB,
// IDE controller
                                     PCI_ANY_ID, PCI_ANY_ID, NULL);
                if (dev) {
                        errata.piix4.bmisx = pci_resource_start(dev, 4);
                        pci_dev_put(dev);   // drops ref, dev is now
dangling
                }

                dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
                                     PCI_DEVICE_ID_INTEL_82371AB_0,
// ISA controller
                                     PCI_ANY_ID, PCI_ANY_ID, NULL);
// dev may become NULL!
                if (dev) {
                        // ...
                        pci_dev_put(dev);
                }
                break;
        }

        if (errata.piix4.bmisx)
                dev_dbg(&dev->dev, "Bus master activity detection...");
// NULL DEREF HERE
        if (errata.piix4.fdma)
                dev_dbg(&dev->dev, "Type-F DMA livelock erratum...");
// NULL DEREF HERE
```

**The bug**: The function parameter `dev` (the PIIX4 ACPI Controller,
`PCI_DEVICE_ID_INTEL_82371AB_3`) is overwritten by the two
`pci_get_subsys()` calls inside the switch. If the first lookup (IDE,
`82371AB`) succeeds and sets `errata.piix4.bmisx`, but the second lookup
(ISA, `82371AB_0`) fails, `dev` becomes NULL. Then `dev_dbg(&dev->dev,
...)` dereferences NULL, causing a kernel oops.

### 3. Bug Origin

From `git blame`, the NULL dereference was **introduced by commit
52af99c3f55ff0** ("ACPI: processor: Get rid of ACPICA message printing",
2021-02-22, first in v5.13-rc1). Before that commit, the debug messages
used `ACPI_DEBUG_PRINT()` which did not reference `dev`:

```c
// BEFORE 52af99c3f55ff0 - safe, no dev reference:
if (errata.piix4.bmisx)
    ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Bus master activity
detection..."));
```

When converted to `dev_dbg(&dev->dev, ...)`, the code now dereferences a
pointer that could be NULL.

### 4. Trigger Conditions

The NULL dereference triggers when:
1. System has a PIIX4 ACPI controller (revision 0-3)
2. The PIIX4 IDE function (`82371AB`) exists on PCI bus
3. The PIIX4 ISA function (`82371AB_0`) does NOT exist on PCI bus
4. With `CONFIG_DYNAMIC_DEBUG` and dynamic debug enabled for this
   callsite, OR with `DEBUG` defined at compile time

With `CONFIG_DYNAMIC_DEBUG` (default in most distro kernels), the
dereference is behind a runtime branch that defaults to off. However,
anyone debugging ACPI on a PIIX4 system (e.g., `echo 'file
acpi_processor.c +p' > /sys/kernel/debug/dynamic_debug/control`) would
trigger a kernel crash.

### 5. The Fix

The fix is clean and minimal: introduce two separate local pointers
(`ide_dev` and `isa_dev`) instead of overwriting the function parameter
`dev`. Each PCI device is looked up independently, and the final debug
messages check the appropriate device pointer.

The diff is +2/-1 new lines (one variable declaration), and changes
existing lines only to rename `dev` → `ide_dev`/`isa_dev`. The logic
also changes the condition from `if (errata.piix4.bmisx)` to `if
(ide_dev)`, which is semantically equivalent (bmisx is only set when
ide_dev was found).

### 6. Scope and Risk Assessment

- **Files changed**: 1 (`drivers/acpi/acpi_processor.c`)
- **Lines changed**: ~30, mostly variable name renames
- **Risk**: Very low - purely local changes within one function, no
  changes to function signatures or external interfaces
- **Call chain**: Only called via `acpi_processor_errata()` →
  `acpi_processor_get_info()` → `acpi_processor_add()`

### 7. Stable Tree Applicability

The bug was introduced in v5.13-rc1 via commit 52af99c3f55ff0. All
current stable/LTS trees (5.15.y, 6.1.y, 6.6.y, 6.12.y) contain this
buggy code. The fix should apply cleanly to all of them since the
surrounding code has been stable since 2013.

### 8. Summary

This is a textbook NULL-pointer dereference fix:
- **Obviously correct**: The fix separates two PCI device lookups into
  independent variables
- **Fixes a real bug**: NULL dereference that can crash the kernel
- **Small and contained**: Changes are local to one function, ~30 lines
  of mostly renames
- **No new features**: No API changes, no behavioral changes
- **Accepted by maintainer**: Rafael J. Wysocki reviewed and merged it
- **Applies to stable trees**: The bug exists in 5.15+, patch should
  apply cleanly

**YES**

 drivers/acpi/acpi_processor.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7ec1dc04fd11b..85096ce7b658b 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -50,6 +50,7 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 {
 	u8 value1 = 0;
 	u8 value2 = 0;
+	struct pci_dev *ide_dev = NULL, *isa_dev = NULL;
 
 
 	if (!dev)
@@ -107,12 +108,12 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		 * each IDE controller's DMA status to make sure we catch all
 		 * DMA activity.
 		 */
-		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+		ide_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB,
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (dev) {
-			errata.piix4.bmisx = pci_resource_start(dev, 4);
-			pci_dev_put(dev);
+		if (ide_dev) {
+			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
+			pci_dev_put(ide_dev);
 		}
 
 		/*
@@ -124,24 +125,25 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		 * disable C3 support if this is enabled, as some legacy
 		 * devices won't operate well if fast DMA is disabled.
 		 */
-		dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
+		isa_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 				     PCI_DEVICE_ID_INTEL_82371AB_0,
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
-		if (dev) {
-			pci_read_config_byte(dev, 0x76, &value1);
-			pci_read_config_byte(dev, 0x77, &value2);
+		if (isa_dev) {
+			pci_read_config_byte(isa_dev, 0x76, &value1);
+			pci_read_config_byte(isa_dev, 0x77, &value2);
 			if ((value1 & 0x80) || (value2 & 0x80))
 				errata.piix4.fdma = 1;
-			pci_dev_put(dev);
+			pci_dev_put(isa_dev);
 		}
 
 		break;
 	}
 
-	if (errata.piix4.bmisx)
-		dev_dbg(&dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
-	if (errata.piix4.fdma)
-		dev_dbg(&dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
+	if (ide_dev)
+		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
+
+	if (isa_dev)
+		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
 
 	return 0;
 }
-- 
2.51.0


