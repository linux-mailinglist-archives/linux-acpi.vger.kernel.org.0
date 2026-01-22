Return-Path: <linux-acpi+bounces-20561-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOgrHk9JcmkJiQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20561-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:59:11 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A807695E3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7701F3011C4D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6D54EA391;
	Thu, 22 Jan 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgpIKp3R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F135B63F
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097325; cv=none; b=dJg7GZKI97qqVluSwRupMjQoxsvKZH79mHSXsGrxZsAjNI1a1/cvS9vL32yr16aW5AONg/iyXscAbGbPfN/r982De+vVcbhwzEElwpmB60P+icxO6+px8Swj9JTRqYyXGHH0ARpkcwZmDAksXe7hPL4UIlKpii0gSNlGID3Towg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097325; c=relaxed/simple;
	bh=Fv4eY4ZAe/ifk4I9BIo/tRFyO/cE+seyo7xdkN2ocJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnM/TfERubPvuJJ4Xako6y2grhlXBHnWFFeIi2Qes5MEe86M1s1tAnwusYQeTleFgt7eWWz9nXQAVglhI4ZZZK26HkcbzUbpdhEX6u83yl+caCuZtli/px38TUDDCrG+OQvMwcnuu3RzBgnoG7KwTAlA/KIQEYeoxuZqxF72uyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgpIKp3R; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b73112ab62so452337eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097314; x=1769702114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Oz/tfZRKv6Pmtw6Fd2KxgTHXyb+JusOVo4ZtSAS9YU=;
        b=XgpIKp3RyqAtUQnEI1VgojIBbEKGSn1FCmb0nBTEhArp7RPFqcbKvqJB26mL7PiLn9
         ts/pEuqTZHjZHJIzXmOp0Ryo3y7oInx9vYUksdfboWe++0wQDv+Ux9Od7yprE9BtiG9k
         CfQITGotcM6Y6wX6Z98ksCBUGnQ7pAV8oi+AtE5zYDOJ/P86HOQ0jeOB5Aml+oG3Eam6
         t6dNhemOKKxl2GuEdXW/S1TBCwTkmbw5Cr9WvOKdq2+vPezegZPagrKw2BeWpe47eKdy
         23MByUxAP5nAxs8FjEkaAXcFA2BRJc4ZSchN3Fuhds7IVXquhdqdvKQ/bdf1m97LNMas
         Ytcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097314; x=1769702114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Oz/tfZRKv6Pmtw6Fd2KxgTHXyb+JusOVo4ZtSAS9YU=;
        b=TWr+mOa9lejv3aEjPzk+g2qSUFPWn0nuuhTdFtijB0xThtIhB0un+6g1WyKujc0gKt
         lSM17LWleI+LbTWmu2nZsS8ew30fDnGLHVC4gSXNtToorMqNeyaBeyhUygVVbIAyaw2v
         RN1pnSPphHX3iEzZQ2T5NY4YnZFkx0nA3iDCxpUlNJEco/MteAO23xarnJKyim1o6lUi
         EOB+6EkMBeommJyIR6LmrEj4QpvInl8XZSoe0RKxV8RCTUKF7rWwqSmAyTUlwQRPt7Xm
         3LmlO8/vK4dlKhrTrKllMOZxfJ27g9a+23zcnZrXcqN77+8LfHobzQswsQqGKjUceGTV
         Nvrw==
X-Gm-Message-State: AOJu0YznvlvWr+9jDZ3MwyExjNGZYOfoUddBQsAvaAdLEOvA1+LSjW79
	Qsmk5+XfIlYbBL7Pr0kHbqBDVWulcj5UiIzI2Qp/rJwT7syB/2DpOX9d
X-Gm-Gg: AZuq6aKYfiE1Zr6EKAyYc6KxhxrlECCvRFS8PuexDVtpJt49TUOYcnHfb+g43Fj8ipg
	GxDCQ33X7fjblj/70/HZmD02Fy31XskBWJPoWgEN55WyrUKN9TiXiaezE3wCxGzLV0RC9Q9Es9n
	vhcFJs8FDe1KXPgmlEzSx/wbqoyhPKySwi5EYJ83bgOFR6MUKKDNCnT+zodyBtXeOgvCPaaJjo4
	MEH5EFqWP2IkXLvdDGxDgjk9dUKl89XbpeLw4B+u+GPspc73GfU+IJNOYkMfGPBwCvNHHNArv1n
	sXtICP8x1yxE08YLR+NyFYzKUAfOTbViGXr5dRblU+YLKj4wln82VYMMRRC4tH/VVdw97HIefjG
	L1QzefvVJZggeDmgkL8fQlExGaxSkO+QhOf83A2LWY94OFNJWwPKGx73MCPs8cIwD1juzPet9Kr
	Dg58VtsS1CPQ1D7CRONNgu86jmAgIbmDQ8rhkENFejllPCArWcprGhn24eCa834j/+chMtj5Ei7
	A==
X-Received: by 2002:a05:7300:7b86:b0:2ae:582b:db80 with SMTP id 5a478bee46e88-2b6b46d2ffdmr17440533eec.9.1769097313706;
        Thu, 22 Jan 2026 07:55:13 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:13 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	550230171hxy@gmail.com
Subject: [PATCH v2 1/4] ACPI: resource: Add IRQ override quirk for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:54:58 +0800
Message-ID: <20260122155501.376199-2-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122155501.376199-1-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,amd.com,linux.intel.com,perex.cz,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20561-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[550230171hxy@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A807695E3
X-Rspamd-Action: no action

On the MECHREVO Wujie 15X Pro (Board Name: WUJIE Series-X5SP4NAG), the
keyboard does not function properly without an IRQ override. Add a DMI
entry to force IRQ1 to edge_low.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d16906f46484d..2ec5472aa0763 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -674,6 +674,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/* MECHREVO Wujie 15X Pro */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
+		},
+	},
 	{
 		/* MACHENIKE L16P/L16P */
 		.matches = {
-- 
2.43.0


