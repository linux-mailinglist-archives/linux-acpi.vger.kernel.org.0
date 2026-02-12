Return-Path: <linux-acpi+bounces-20957-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P02HKTYjWng7wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20957-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:41:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A512DEA8
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2908D308DC4F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770F35CB6A;
	Thu, 12 Feb 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgCyU4Bx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4EC35CB8D;
	Thu, 12 Feb 2026 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903674; cv=none; b=Xn+t7WO7NWUtpSoSyNIbwkERSi0Nv5vtTEONs7VakZ808Wqi+y/pUv2mfo13Vb5jvjGngdRbEmW+oB50iBt3g0alKVHlydUTTzcRhcDq37ChsoW6n9VDkWjn2nSCbSVS0g6PCVEwJOb0DBEmY6wJ6cujAGpgMAhpHMhlfKyIIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903674; c=relaxed/simple;
	bh=eAko90GRKuDabjJmZ8Ccxjj5nzFmGO0UGhMpq6ntqLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RCdcpIG6/dxydOmm3RK99a0l0DvfOBF3Y9qU1oDpygVsE3QBRkiwlB+dgAF9RzXLhVwYVpeQI9nft9e0u7CYGb7MYGPnC2x4CpL0nvS47/aRUZddYN4ea+G2aTwMArZU9ZTHeVP0qKXLmoPuy6Pnb3RrVbZyR5qWLlhEVPe4p3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgCyU4Bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F61C16AAE;
	Thu, 12 Feb 2026 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770903673;
	bh=eAko90GRKuDabjJmZ8Ccxjj5nzFmGO0UGhMpq6ntqLo=;
	h=From:To:Cc:Subject:Date:From;
	b=RgCyU4BxxwYFwWYlc3nWbqgsU/IKiAc2im9W4+c/eLYayvTmBnLIWVeDjRMskRXwW
	 v2UqjF9cXYa2PQTe1WdJPvOJbbrOSZ5cKcS02d4YXZQbKKjJU8KMwvTUqq7dpaIBG/
	 +FH1kKxbli066HQYD8ox+aI7xPpsmo936zwKMZJ9bMRd0UTdB8/q08whF1u22krbdR
	 9HVXmo4OuigxpTBhh4YlLkP8GNxYcm7eIfF3eDfNiEurqUaUA6d+hsXC3MloagLegV
	 UcA/3JbaFt/fApgtBFKkXAHuLhnlebjFWoq5cW96TsZQ93fwdnmPlBj/pN69A3XYF4
	 Mt/8McnYOvpgQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>, Corey Minyard <corey@minyard.net>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 openipmi-developer@lists.sourceforge.net, regressions@lists.linux.dev,
 Igor Raits <igor@gooddata.com>, linux-hwmon@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
Subject:
 [PATCH v1] Revert "ipmi:si: Gracefully handle if the BMC is non-functional"
Date: Thu, 12 Feb 2026 14:41:08 +0100
Message-ID: <10802540.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20957-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: DE3A512DEA8
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Revert commit bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is
non-functional") that attempted to improve the handling of the cases
in which the BMC was not responsive, but did not succeed.

Instead, it introduced a regression causing AML in ACPI tables that use
IMPI operation regions to block indefinitely on the tx_msg->tx_complete
completion in acpi_ipmi_space_handler(), which may affect ACPI control
methods on any system where IPMI is involved resulting in various types
of breakage that is not straightforward to diagnose.

For example, on the system where the regression was first observed, it
caused sysfs accesses to attributes exposed by the acpi_power_meter
driver to block because they involved AML evaluation which is not
super-easy to connect to IPMI.

This is a nasty and rather urgent problem with no viable fix in sight.

Note that AI was involved in diagnosing it, but didn't help much.

Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Closes: https://lore.kernel.org/linux-acpi/CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com/
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Tested-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/ipmi/ipmi_si_intf.c |   29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -53,7 +53,6 @@
 #define SI_TIMEOUT_JIFFIES	(SI_TIMEOUT_TIME_USEC/SI_USEC_PER_JIFFY)
 #define SI_SHORT_TIMEOUT_USEC  250 /* .25ms when the SM request a
 				      short timeout */
-#define SI_TIMEOUT_HOSED	(HZ) /* 1 second when in hosed state. */
 
 enum si_intf_state {
 	SI_NORMAL,
@@ -62,8 +61,7 @@ enum si_intf_state {
 	SI_CLEARING_FLAGS,
 	SI_GETTING_MESSAGES,
 	SI_CHECKING_ENABLES,
-	SI_SETTING_ENABLES,
-	SI_HOSED
+	SI_SETTING_ENABLES
 	/* FIXME - add watchdog stuff. */
 };
 
@@ -754,8 +752,6 @@ static void handle_transaction_done(stru
 		}
 		break;
 	}
-	case SI_HOSED: /* Shouldn't happen. */
-		break;
 	}
 }
 
@@ -770,10 +766,6 @@ static enum si_sm_result smi_event_handl
 	enum si_sm_result si_sm_result;
 
 restart:
-	if (smi_info->si_state == SI_HOSED)
-		/* Just in case, hosed state is only left from the timeout. */
-		return SI_SM_HOSED;
-
 	/*
 	 * There used to be a loop here that waited a little while
 	 * (around 25us) before giving up.  That turned out to be
@@ -797,20 +789,18 @@ restart:
 
 		/*
 		 * Do the before return_hosed_msg, because that
-		 * releases the lock.  We just disable operations for
-		 * a while and retry in hosed state.
+		 * releases the lock.
 		 */
-		smi_info->si_state = SI_HOSED;
+		smi_info->si_state = SI_NORMAL;
 		if (smi_info->curr_msg != NULL) {
 			/*
 			 * If we were handling a user message, format
 			 * a response to send to the upper layer to
 			 * tell it about the error.
 			 */
-			return_hosed_msg(smi_info, IPMI_BUS_ERR);
+			return_hosed_msg(smi_info, IPMI_ERR_UNSPECIFIED);
 		}
-		smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
-		goto out;
+		goto restart;
 	}
 
 	/*
@@ -908,7 +898,7 @@ static void flush_messages(void *send_in
 	 * mode.  This means we are single-threaded, no need for locks.
 	 */
 	result = smi_event_handler(smi_info, 0);
-	while (result != SI_SM_IDLE && result != SI_SM_HOSED) {
+	while (result != SI_SM_IDLE) {
 		udelay(SI_SHORT_TIMEOUT_USEC);
 		result = smi_event_handler(smi_info, SI_SHORT_TIMEOUT_USEC);
 	}
@@ -921,9 +911,6 @@ static int sender(void *send_info, struc
 
 	debug_timestamp(smi_info, "Enqueue");
 
-	if (smi_info->si_state == SI_HOSED)
-		return IPMI_BUS_ERR;
-
 	if (smi_info->run_to_completion) {
 		/*
 		 * If we are running to completion, start it.  Upper
@@ -1104,10 +1091,6 @@ static void smi_timeout(struct timer_lis
 	spin_lock_irqsave(&(smi_info->si_lock), flags);
 	debug_timestamp(smi_info, "Timer");
 
-	if (smi_info->si_state == SI_HOSED)
-		/* Try something to see if the BMC is now operational. */
-		start_get_flags(smi_info);
-
 	jiffies_now = jiffies;
 	time_diff = (((long)jiffies_now - (long)smi_info->last_timeout_jiffies)
 		     * SI_USEC_PER_JIFFY);




