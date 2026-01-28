Return-Path: <linux-acpi+bounces-20699-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDCPMy96eWlQxQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20699-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 03:53:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A79C6D3
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D29D9300AB13
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 02:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD52C0F95;
	Wed, 28 Jan 2026 02:53:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [61.152.208.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08A129994B
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.152.208.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769568813; cv=none; b=Fe+6J2Boks4HFYdGbw/odIBqZSC3AqOg6S6BIWa8XNBbiP00+S+UUf1tyef92+3Bkti14LCEeXTurvdw0u4VS7sFT3e7NO8fQaO1T9sAjY8m0W1U9lMrdMvNnuL9fEmsn2lxAknqxxgl8vATnUGSYIu56IEdVwBFGX9uIwOwOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769568813; c=relaxed/simple;
	bh=TtZU9iYwHYZo0cGIa77+NosUadDiXetEjZX82Zpiwzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FnRoY/OO53hCZv76h/SsrwASslG9iEsO65/krUn8ecZHY/pJFONtv4iwQIRBWMa3ntJowhkBUyJh2NEDdsqbeM16Nrx7yHMdxLSFcxuD/ERLmr3cKeC1eAAZyMnW26+UPsxuIbylUqIGXdDMWJRCGLm9il6U6TJxbmxs7PxKO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=61.152.208.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1769568800-1eb14e7c0135bf0001-I98ny2
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id AXvnwyl7Fx4wo9aZ (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 28 Jan 2026 10:53:20 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 10:53:20 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Wed, 28 Jan 2026 10:53:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from tony.zhaoxin.com (10.32.64.8) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Wed, 28 Jan
 2026 10:52:13 +0800
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <jonathan.cameron@huawei.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <leitao@debian.org>,
	<fabio.m.de.francesco@linux.intel.com>, <jason@os.amperecomputing.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<LyleLi@zhaoxin.com>
Subject: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_ systems
Date: Wed, 28 Jan 2026 10:52:16 +0800
X-ASG-Orig-Subj: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_ systems
Message-ID: <20260128025216.12564-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 1/28/2026 10:53:19 AM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1769568800
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 827
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.153675
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[zhaoxin.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20699-lists,linux-acpi=lfdr.de];
	TAGGED_RCPT(0.00)[linux-acpi];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[TonyWWang-oc@zhaoxin.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zhaoxin.com:mid,zhaoxin.com:email]
X-Rspamd-Queue-Id: 1E0A79C6D3
X-Rspamd-Action: no action

Let ghes_edac to be the preferred driver to load on  __ZX__ and _BYO_=20
systems by extending the platform detection list in ghes.c

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Tested-by: Lyle Li <LyleLi@zhaoxin.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b49a5da46788..f96aede5d9a3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1897,6 +1897,8 @@ void __init acpi_ghes_init(void)
  */
 static struct acpi_platform_list plat_list[] =3D {
 	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
+	{"__ZX__", "EDK2    ", 3, ACPI_SIG_FADT, greater_than_or_equal},
+	{"_BYO_ ", "BYOSOFT ", 3, ACPI_SIG_FADT, greater_than_or_equal},
 	{ } /* End */
 };
=20
--=20
2.25.1


