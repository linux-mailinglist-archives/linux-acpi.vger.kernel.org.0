Return-Path: <linux-acpi+bounces-17685-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B2BCA1D1
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64C884FEC2E
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 16:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3670F2F5A24;
	Thu,  9 Oct 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqYrkiyn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0221C9E5;
	Thu,  9 Oct 2025 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025674; cv=none; b=uXB/6l6FPUV2MY09uncbGvyK9TjzRsVi22WGZrR7bdpiwz5kqhL++wnXRYhkjq2GdaWJkaMv5iDIgXitiM6epPDDKh6VeLP5DhmnJ3yKto5a2LuDWu58z+Bf+oWfVY+9IolipOBap9Jk5XSglcT0KEt+nrMnCz1Oe3mA9Nb1xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025674; c=relaxed/simple;
	bh=GemkRLfESMh2tFr6/xGywQSr+fRi9j9xxLHWBi3E+q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gElNNL6t/XJA2l2LExD4Q0dbC5hzNdpehGx0eSF5/rURtudgDsFVqxffsGUWpB4JCBxvxYESU6OCrdynBxCwWaZ08XyxKk3msA0WkaUXUqQdGglL0DSW9vHx4bf16+iPAZw+JUZmdKd5zT7xD61PCmSCBDfgpsq2AsrldwwOfng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqYrkiyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0DCC4CEF7;
	Thu,  9 Oct 2025 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025673;
	bh=GemkRLfESMh2tFr6/xGywQSr+fRi9j9xxLHWBi3E+q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HqYrkiynmoeyDlLwPPt41cVpRutGJNgtefHZ5pz3TdJ91gxr56lTL7OsLg0tGdEpp
	 ff5DLylrmHz7ZHD/NlCIrkLBK+UeeWAuhwt/Ln36I5bX15TJbOZOlaPoYdDaqYBXDC
	 86k4qhLFqHLGRT3NAerUdIN5rtqS74pRvhcJBf70nHJ55voWjWaUcQrtuDSVesdvkd
	 MCo1sfA+2Lw7gq98aclxu6cetlMV0ZzRDpZ/G2RuZIjU50hzDtvw9O5J92lXX+Zx9T
	 CyRwA7l+7gBxyTITH+MebXMmrYkEMGDUWTWlJhM0NeQzI9mgHpxMOpSjiH3eNIjgnj
	 5m2jhs5SYKsww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Chen Pei <cp0613@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] ACPI: SPCR: Support Precise Baud Rate field
Date: Thu,  9 Oct 2025 11:56:13 -0400
Message-ID: <20251009155752.773732-107-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

[ Upstream commit 4d330fe54145ecfbb657ac01a554fdedf3c1927e ]

The Microsoft Serial Port Console Redirection (SPCR) specification
revision 1.09 comprises additional field: Precise Baud Rate [1].

It is used to describe non-traditional baud rates (such as those
used by high-speed UARTs).

It contains a specific non-zero baud rate which overrides the value
of the Configured Baud Rate field. If this field is zero or not
present, Configured Baud Rate is used.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table [1]
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Link: https://patch.msgid.link/20250913070815.16758-1-cp0613@linux.alibaba.com
[ rjw: Corrected typo in the subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it changes and why it matters:
  - Adds support for the SPCR “Precise Baud Rate” field so the kernel
    honors non‑standard/high‑speed UART baud rates from firmware. The
    new logic checks `table->precise_baudrate` and, if non‑zero, uses
    it; otherwise it falls back to the existing enumerated “Configured
    Baud Rate” mapping.
  - Code reference: drivers/acpi/spcr.c:153 adds the explanatory comment
    and the override logic; drivers/acpi/spcr.c:158 uses `if
    (table->precise_baudrate) baud_rate = table->precise_baudrate; else
    switch (table->baud_rate) { ... }`.
  - Without this, systems that publish a precise baud in SPCR (e.g.,
    1.5M, 3M, etc.) end up with an incorrect console configuration
    (typically 115200), breaking or garbling the serial console. This is
    a user-visible bug in environments that follow SPCR 1.09+.

- Scope and risk:
  - Minimal, self‑contained change in one file (drivers/acpi/spcr.c). It
    does not alter console selection logic, I/O type decisions, or
    errata handling; it only sets `baud_rate` earlier when the field is
    present, leaving the long‑standing switch on `table->baud_rate`
    unchanged.
  - No architectural or behavioral changes beyond honoring an existing
    spec field. No new features; this is a spec‑compliance fix.

- Dependencies and compatibility:
  - Requires the ACPICA header update that introduced the field in
    `struct acpi_table_spcr`:
    - Code reference: include/acpi/actbl3.h:124 defines `u32
      precise_baudrate;` (added by “ACPICA: SPCR: Update the SPCR table
      to version 4”, present from v6.12 and newer).
  - For stable trees older than v6.12, this commit will not compile
    unless that ACPICA update (and its related SPCR struct changes) is
    backported first. Backporting both together is straightforward and
    low‑risk, as the header change is additive and this code only reads
    the new field.

- Subtlety to be aware of:
  - The SPCR spec says the precise field “overrides” when non‑zero; if
    zero or not present, use the configured enumerated value. The code
    implements this correctly by falling back to the existing switch
    when the field is zero (drivers/acpi/spcr.c:158).
  - As upstream implemented, there is no explicit table-length check
    before reading `precise_baudrate`. This matches mainline, but when
    backporting to very old kernels and encountering very old SPCR
    revisions, maintainers may optionally add a guard using
    `table->header.length` to be extra defensive. Not required for
    v6.12+ where the header and field are in place.

- Stable backport criteria:
  - Fixes a real, user‑visible issue (misconfigured or non‑functional
    serial console on systems using SPCR precise baud).
  - Small and localized change with minimal regression risk.
  - No architectural churn or new feature exposure.
  - Touches the ACPI SPCR parsing path only; console setup remains
    unchanged aside from using the correct baud.

Conclusion: This is a good candidate for stable backport, provided the
target stable series already contains (or is backported with) the SPCR
v4 ACPICA header update that defines `precise_baudrate`.

 drivers/acpi/spcr.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
index cd36a97b0ea2c..fa12e740386de 100644
--- a/drivers/acpi/spcr.c
+++ b/drivers/acpi/spcr.c
@@ -146,7 +146,15 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 		goto done;
 	}
 
-	switch (table->baud_rate) {
+	/*
+	 * SPCR 1.09 defines Precise Baud Rate Filed contains a specific
+	 * non-zero baud rate which overrides the value of the Configured
+	 * Baud Rate field. If this field is zero or not present, Configured
+	 * Baud Rate is used.
+	 */
+	if (table->precise_baudrate)
+		baud_rate = table->precise_baudrate;
+	else switch (table->baud_rate) {
 	case 0:
 		/*
 		 * SPCR 1.04 defines 0 as a preconfigured state of UART.
-- 
2.51.0


