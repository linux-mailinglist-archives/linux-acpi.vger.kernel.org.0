Return-Path: <linux-acpi+bounces-21427-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF4kNSelqWl5BQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21427-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:45:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6DB214C77
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3CE8306C868
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770EC3CF662;
	Thu,  5 Mar 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs/dxjN0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526EB3CD8C7;
	Thu,  5 Mar 2026 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725043; cv=none; b=LZVijQ9xZIDzvmfAv8omxj+5L8Jf2/JxWGHJjWUD0sYICsb35PS9qD9be/TuzwgIuihWEjhIus0cWEVPH2H9vYe6FMoQudrapZ9VUQF4i6VMMccoOmZ2TjQax6R90Q6Po6xVlfCPOUs0eaNeYbAWlzZCzCUv10i+ILVYn7nrD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725043; c=relaxed/simple;
	bh=DOvJRtrm8csSKn5upxPEpeea11SDLR82Bgy8HUnvITg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPPF+AGwOvWYnhnqrLIQ1LHEsC/2kr+8syunOy1nMIPsUlOOTHyigydBOhTYQJRsmz+w0Mhp9ZYPiuZyVIPMhlR3wmwcRnNBU00mb2dpIvgu49z7ISHa2PtZ8QIescJXnfs85wP8LKS2RrrLqdyXhLLHrXkKiAuiQh2Ep1pMlBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs/dxjN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C47C2BC9E;
	Thu,  5 Mar 2026 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772725043;
	bh=DOvJRtrm8csSKn5upxPEpeea11SDLR82Bgy8HUnvITg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qs/dxjN0+k+UUq2oIj0vx4r57oNs23EncOa5FSe3ASKIhVXXKjL24+cn19l5bhMSf
	 Ol5Y7HBL30l6g+vQTncUZkApMYgdiX2af2S2mpSeyO4UTcOoZ0UGwBLDU1Lib4iYlc
	 zyVH4YjUfLBuib+mZ9eAHR8/8cndQHgw6sLLGx3h3WvxD0qYJOeVY6RBg3XiIqFXCc
	 rGRi6EOrZ3ZdYC0uYvA2JvWlhLTcPXYevnqEdchrfhh7esjLp08v+kmYE8svkvGCwt
	 LSkTWsEHb35EMnr2wEYLP6Q70bj4HCS8ePItXcsEBtcP5DvtgYVQtNxb0XvgHz2a6O
	 kgamFtSma77zA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sofia Schneider <sofia@schn.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] ACPI: OSI: Add DMI quirk for Acer Aspire One D255
Date: Thu,  5 Mar 2026 10:36:55 -0500
Message-ID: <20260305153704.106918-12-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260305153704.106918-1-sashal@kernel.org>
References: <20260305153704.106918-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DF6DB214C77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21427-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:email]
X-Rspamd-Action: no action

From: Sofia Schneider <sofia@schn.dev>

[ Upstream commit 5ede90206273ff156a778254f0f972a55e973c89 ]

The screen backlight turns off during boot (specifically during udev device
initialization) when returning true for _OSI("Windows 2009").

Analyzing the device's DSDT reveals that the firmware takes a different
code path when Windows 7 is reported, which leads to the backlight shutoff.
Add a DMI quirk to invoke dmi_disable_osi_win7 for this model.

Signed-off-by: Sofia Schneider <sofia@schn.dev>
Link: https://patch.msgid.link/20260223025240.518509-1-sofia@schn.dev
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The `dmi_disable_osi_win7` callback already exists and is used by other
quirks (ASUS K50IJ at line 368). This commit simply adds another entry
to the same table using the same callback.

### Stable Kernel Criteria Assessment

1. **Obviously correct and tested**: Yes. It's a straightforward DMI
   table entry addition following the exact same pattern as dozens of
   existing entries in the same table. The author analyzed the DSDT to
   confirm the firmware behavior. The ACPI maintainer (Rafael Wysocki)
   accepted and signed off.

2. **Fixes a real bug**: Yes. The screen backlight turns off during boot
   on this specific laptop model — a clear user-visible
   regression/hardware issue. Users cannot see their screen.

3. **Important issue**: Yes. A blank screen during boot is a significant
   usability problem — the laptop is effectively unusable without a
   workaround.

4. **Small and contained**: Yes. The change adds exactly 13 lines (a
   comment and a DMI table entry) to a single file. Zero logic changes.
   Zero risk to other hardware.

5. **No new features**: Correct. This uses the existing
   `dmi_disable_osi_win7` mechanism. No new APIs, no new code paths.

6. **Applies cleanly**: The change is a simple table entry insertion.
   Even if surrounding entries differ slightly between stable versions,
   this can be trivially applied at any point in the table.

### Risk Assessment

- **Risk**: Essentially zero. The DMI match is specific to vendor "Acer"
  + product "AOD255". It cannot affect any other hardware.
- **Benefit**: Screen backlight works correctly on Acer Aspire One D255
  during boot.
- **Blast radius**: One specific laptop model only.

### Verification

- Verified `dmi_disable_osi_win7` callback exists at line 279 of
  `drivers/acpi/osi.c` and is already used by another quirk entry (ASUS
  K50IJ at line 368).
- Verified the diff adds only a DMI table entry following the identical
  pattern of existing entries in the same `acpi_osi_dmi_table[]` array.
- Verified the commit was accepted by Rafael Wysocki, the ACPI subsystem
  maintainer.
- The change touches exactly one file (`drivers/acpi/osi.c`) with a
  trivial table addition.
- The `acpi_osi_dmi_table` and `dmi_disable_osi_win7` have existed in
  the kernel for many years, so this applies to all active stable trees.

### Conclusion

This is a textbook hardware quirk addition — the exact type of commit
that stable trees exist to carry. It fixes a real, user-visible bug
(blank screen) on specific hardware, uses existing infrastructure, has
zero risk to other systems, and is trivially small.

**YES**

 drivers/acpi/osi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index f2c943b934be0..9470f1830ff50 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -389,6 +389,19 @@ static const struct dmi_system_id acpi_osi_dmi_table[] __initconst = {
 		},
 	},
 
+	/*
+	 * The screen backlight turns off during udev device creation
+	 * when returning true for _OSI("Windows 2009")
+	 */
+	{
+	.callback = dmi_disable_osi_win7,
+	.ident = "Acer Aspire One D255",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "AOD255"),
+		},
+	},
+
 	/*
 	 * The wireless hotkey does not work on those machines when
 	 * returning true for _OSI("Windows 2012")
-- 
2.51.0


