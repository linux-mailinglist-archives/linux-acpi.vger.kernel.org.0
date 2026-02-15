Return-Path: <linux-acpi+bounces-20993-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE/ZNU0FkmnNpQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20993-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 18:41:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F8813F3BC
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 18:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5F0E3006171
	for <lists+linux-acpi@lfdr.de>; Sun, 15 Feb 2026 17:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793002EF67A;
	Sun, 15 Feb 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh4YFcss"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554B02DC783;
	Sun, 15 Feb 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771177284; cv=none; b=FiWcN17lhjLmgqqPHStHRaYXaGozPizUi27uH8O5G+GKKeBcqHzqnI4pattkkZ046t9dChwO4WquZI9QvEIVcd9BER+CFGdW3R8WW1LTGIi3O4N0JLXKHD30BBjb0efE0we94Xs/ztMDLifK81X7QdTac1Vf37RBfXaer3/exFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771177284; c=relaxed/simple;
	bh=r5J4AEx7QDheVPTS2mZ9qThHD9yb0ZzFxAfze8Kjz7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=na3LvXBYZ4O89FlVqQbhuaAL6x46CeKbKxZpY8j86FKsB3AdvfdVjsI1eoYh3gTbzOPvz/ixG2t1gHRswNtK1nam9l8JqqhnMGzva5KYgmsG1T+ZRzVK27KoLXnt+g7iXSO3zwiHszS9cD8cVhrRKkQiqxNwwHXc+l+yb44zatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh4YFcss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982E6C2BC86;
	Sun, 15 Feb 2026 17:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771177283;
	bh=r5J4AEx7QDheVPTS2mZ9qThHD9yb0ZzFxAfze8Kjz7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qh4YFcss2RW4ftocuF/jwUa3mSm27vNZWW3TO2xu3JfM+wBpI7SBFARLhrFEidArj
	 /P/JCKOugCSJfwpD9T/i+7b3zub1jPhFIfTCHm1teYtxil1MiMhqo0ISidXU1ceX1l
	 V+kZjAHqQ2LGUJybVXheXsBurJXf3ysoOqufrH2Wrv0rTrMRc0y3VGFuFMjfFvRDmX
	 pTod8GXs7nrol/lBDt6m2Pau7qE4oYhoQnFafHw5g3OLt6tjwDoXmeAH3o8o5/dtmO
	 yzE5odXwQ9kxnPWpBM8fS6KoiZqKfB50ANOiXWyqHC19wQmUIRa5w7d02crW6jYeyH
	 pKQFyD/NADF4g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	sudeep.holla@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.19-6.1] mailbox: pcc: Remove spurious IRQF_ONESHOT usage
Date: Sun, 15 Feb 2026 12:41:10 -0500
Message-ID: <20260215174120.2390402-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215174120.2390402-1-sashal@kernel.org>
References: <20260215174120.2390402-1-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20993-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,linutronix.de,goodmis.org,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email]
X-Rspamd-Queue-Id: 69F8813F3BC
X-Rspamd-Action: no action

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 673327028cd61db68a1e0c708be2e302c082adf9 ]

The PCC code currently specifies IRQF_ONESHOT if the interrupt could
potentially be shared but doesn't actually use request_threaded_irq() and
the interrupt handler does not use IRQ_WAKE_THREAD so IRQF_ONESHOT is
never relevant. Since commit aef30c8d569c ("genirq: Warn about using
IRQF_ONESHOT without a threaded handler") specifying it has resulted in a
WARN_ON(), fix this by removing IRQF_ONESHOT.

Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Summary of Analysis

### What the commit fixes

The PCC mailbox driver (`drivers/mailbox/pcc.c`) incorrectly specifies
`IRQF_ONESHOT` when requesting a shared interrupt. `IRQF_ONESHOT` is
only meaningful for threaded interrupt handlers (registered via
`request_threaded_irq()`), but this driver uses `devm_request_irq()`
with a hardcoded primary handler (`pcc_mbox_irq`) and no thread
function.

Since commit `aef30c8d569c` (merged 2026-01-13 into v6.19 cycle), the
generic IRQ code now emits a `WARN_ON_ONCE()` when `IRQF_ONESHOT` is
specified without a threaded handler. This means on any system with a
PCC shared interrupt, the kernel produces a warning splat at
boot/runtime — a visible regression for users.

### Stable kernel criteria assessment

1. **Obviously correct and tested**: Yes — the change removes a flag
   that has no effect (since the driver doesn't use threaded IRQs).
   Reviewed by the SCMI/PCC co-maintainer Sudeep Holla.

2. **Fixes a real bug**: Yes — it fixes a `WARN_ON()` that fires at
   runtime. WARN_ONs are treated as bugs by many distributions and can
   be flagged by automated testing.

3. **Important issue**: Moderate — a WARN_ON at boot is visible to users
   and breaks CI/testing systems. On PREEMPT_RT systems, the underlying
   issue (IRQF_ONESHOT without threading) could also be problematic
   since the handler is exempt from forced-threading.

4. **Small and contained**: Yes — single line change, single file, no
   side effects.

5. **No new features**: Correct — this purely removes a spurious flag.

### Dependencies

This fix only makes sense if commit `aef30c8d569c` ("genirq: Warn about
using IRQF_ONESHOT without a threaded handler") is also present in the
stable tree. That commit was merged in the v6.19 cycle (January 2026).
If `aef30c8d569c` is NOT backported to stable, then the `IRQF_ONESHOT`
flag is harmless (no WARN_ON fires, and the flag is simply ignored).
However, the `IRQF_ONESHOT` was always incorrect — removing it is safe
regardless.

The PCC shared interrupt support was added by commit `3db174e478cb0b` in
September 2023 (v6.7 cycle), so this code exists in stable trees 6.6.y
and later.

### Risk assessment

**Risk: Extremely low.** Removing an unused flag from an IRQ
registration call cannot break anything. The flag was never functional
since the driver doesn't use threaded IRQs.

**Benefit: Eliminates WARN_ON** splat on systems with shared PCC
interrupts, which affects ACPI-based ARM64 and x86 platforms using PCC
for CPPC/SCMI.

### Verification

- **Verified**: Commit `aef30c8d569c` exists in tree and adds
  `WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn)` in
  `kernel/irq/manage.c` (dated 2026-01-13).
- **Verified**: `drivers/mailbox/pcc.c` uses `devm_request_irq()` (line
  556), NOT `request_threaded_irq()`.
- **Verified**: No `IRQ_WAKE_THREAD` or `request_threaded_irq` usage in
  `pcc.c` (grep returned no matches).
- **Verified**: The `IRQF_ONESHOT` was introduced by commit
  `3db174e478cb0b` ("mailbox: pcc: Support shared interrupt for multiple
  subspaces", 2023-09-11), which is in the v6.7 cycle, making it present
  in 6.6.y stable and later.
- **Verified**: The change is a single flag removal (`IRQF_SHARED |
  IRQF_ONESHOT` → `IRQF_SHARED`), one line modified.
- **Verified**: Reviewed by Sudeep Holla (PCC/SCMI co-maintainer),
  reported by an ARM engineer.

### Conclusion

This is a straightforward fix for a WARN_ON triggered at runtime. The
change is minimal (removing one unused flag), obviously correct
(verified by code inspection that no threaded handler exists), reviewed
by a domain expert, and has zero risk of regression. It meets all stable
kernel criteria.

The only nuance is that the WARN_ON itself comes from a very recent
commit (`aef30c8d569c`), which may or may not be present in all stable
trees. However, even without that commit, removing the spurious
`IRQF_ONESHOT` is correct — the flag was never needed and was always a
no-op in this context. Removing incorrect flags proactively prevents
future issues and is good practice.

**YES**

 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ff292b9e0be9e..060489e5ae6de 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -552,7 +552,7 @@ static int pcc_startup(struct mbox_chan *chan)
 
 	if (pchan->plat_irq > 0) {
 		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
-						IRQF_SHARED | IRQF_ONESHOT : 0;
+						IRQF_SHARED : 0;
 		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq,
 				      irqflags, MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
-- 
2.51.0


