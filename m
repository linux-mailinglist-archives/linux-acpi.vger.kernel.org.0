Return-Path: <linux-acpi+bounces-21529-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CXYOheTrml0GQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21529-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 10:29:59 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEBD2362D1
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 10:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCC7304C623
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 09:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C954D36A016;
	Mon,  9 Mar 2026 09:25:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2AC361664;
	Mon,  9 Mar 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048348; cv=none; b=VR7n1PJ5zGdNficDrdWnVLwWUzAhCOSQ4I87xrpn4tlxiTJL4YrP9TSLeVUWxMjlBjWopwVgs/Sr5tTUzcwi/nymWAml7bYsG7zXLUEgspfwtugb1gZRPlOKbU7hQnDXg11SlVWfJ94MJFVLziYmi1sg+PJp6Jb4qv+cb6UJ6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048348; c=relaxed/simple;
	bh=cMzT8cIxJI/GGK2J4aXtAB9E6hwN67XBw1IHL7KFt90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qa9SLW1FAh9PZrGDylCsa0vejr/IWBeJttO28O4EBAn/k2Dt2QXFop5pYK4b8yfLZ9MU0aPVnHBqClIkaTv3hIs1K7hs/8+wQh1xXLhv+/VR+4RG3vatnJGTVoa+jVIUO/pAkylGT6bY67wWrtJXWOq6Ud9mVroQfoz+nqbEZNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [210.73.43.101])
	by APP-05 (Coremail) with SMTP id zQCowAC3RgoVkq5pWRzyCQ--.46057S2;
	Mon, 09 Mar 2026 17:25:41 +0800 (CST)
From: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
Subject: [PATCH] ACPICA: scope acpi_ex_trace_point() to ACPI_DEBUG_OUTPUT
Date: Mon,  9 Mar 2026 09:25:37 +0000
Message-Id: <20260309092537.721172-1-pengpeng.hou@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3RgoVkq5pWRzyCQ--.46057S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4UGw45trWfXF13Cr1fCrg_yoW8AryrpF
	WIyrWjyr17Jw4UKr1UZw4Dur15Ja4FyryUGrW7Gr1rZF4UW3WUArnrtryUXFy5C3srKrWS
	vr4DZr15WF1UZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfU82NtDUUUU
X-CM-SenderInfo: pshqw1hhqjhx1rx6x21ufox2xfdvhtffof0/
X-Rspamd-Queue-Id: 5CEBD2362D1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21529-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengpeng.hou@isrc.iscas.ac.cn,linux-acpi@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.352];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isrc.iscas.ac.cn:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Action: no action

In current linux.git (1954c4f01220), acpi_ex_trace_point() is
defined and declared unconditionally. However, its only in-tree caller
is within the debug tracing path in drivers/acpi/acpica/utdebug.c,
which is guarded by #ifdef ACPI_DEBUG_OUTPUT.

Match the internal declaration and definition to that scope by wrapping
them in #ifdef ACPI_DEBUG_OUTPUT. This fixes the debug-scope mismatch
and avoids including tracing logic when ACPI debug output is disabled.

Signed-off-by: Pengpeng Hou <pengpeng.hou@isrc.iscas.ac.cn>
---
diff --git a/drivers/acpi/acpica/acinterp.h b/drivers/acpi/acpica/acinterp.h
--- a/drivers/acpi/acpica/acinterp.h
+++ b/drivers/acpi/acpica/acinterp.h
@@
 void
 acpi_ex_stop_trace_opcode(union acpi_parse_object *op,
 			  struct acpi_walk_state *walk_state);
 
+#ifdef ACPI_DEBUG_OUTPUT
 void
 acpi_ex_trace_point(acpi_trace_event_type type,
 		    u8 begin, u8 *aml, char *pathname);
+#endif
 
 void
 acpi_ex_trace_args(union acpi_operand_object **params, u32 count);
diff --git a/drivers/acpi/acpica/extrace.c b/drivers/acpi/acpica/extrace.c
--- a/drivers/acpi/acpica/extrace.c
+++ b/drivers/acpi/acpica/extrace.c
@@
  * DESCRIPTION: Internal interpreter execution trace.
  *
  ******************************************************************************/
 
+#ifdef ACPI_DEBUG_OUTPUT
 void
 acpi_ex_trace_point(acpi_trace_event_type type,
 		    u8 begin, u8 *aml, char *pathname)
 {
@@
 				  acpi_ex_get_trace_event_name(type),
 				  begin ? "Begin" : "End", aml));
 	}
 }
+#endif
 
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_trace_args


