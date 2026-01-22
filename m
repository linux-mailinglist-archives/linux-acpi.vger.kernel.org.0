Return-Path: <linux-acpi+bounces-20544-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAk2OwUicmmPdQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20544-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:11:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 517066717A
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52971723750
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E14219E4;
	Thu, 22 Jan 2026 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLD1++fQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8C3B52F6
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083594; cv=none; b=N73kQlGqDoAMhHi2pjUQ22C4SOB3D+3wEamwUB6SkdwThpLkKwVkwKDkd8Ty9SgjQDwrEPgQMdC1fc+TaFu7J+PMMWvt2ksNpjDl1iwnYh90ZYqAkjrrMpzMJJPzxw8Ht1kalLbFbZppFQiH5nXcSA7VACgxVkQijFsXqyqmjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083594; c=relaxed/simple;
	bh=0AbgW36MdhS6eB6eHCdYw+5wNnE+/sDbwR83OrPAbY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W0NtAe93qnUrSg4G81rsODFNO5ncIZTT9ocb2HczTwUitgiDrsHIpNEFdqFFCWrT6rd+EWu8FnaTYVI9+duc7aiRzut6nTj9Mh5onF5gyqMGmn4MNVWeVAuh7JFfZrp6uz39o34St9FhJvD6J1B/gKtwn5coqs2NYz31Kr3xzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLD1++fQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12460a7caa2so1250888c88.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 04:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769083591; x=1769688391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7NNlJioF9TutCXRmGC/U8g6cqN3dq9dwMLqiUwgqcY=;
        b=hLD1++fQbi0jzHjWXD0YTsCWzCpZUJ9dwBAAZplZQpXdZNWaW3NmWwVDYVmekCa6ZJ
         p2YyuqCvgHYXrMOFqsvaL11VpTsdVBTfeVG9uIPSzH1wdcWZm9AcOo8Af/v/oAaN4uJb
         20pf2s8vadOXZeYWJ0jZWjKzmrL9tjS/MFOrTn7nea8t3PkitIBSuyEprr5rKggWaebP
         M9tkq+0NS+RM1ZBAVKIs7ENL4oZ8sWxSd/4kRh0B2iLVbwRJyHN0xXVpCZnrwokDYU9H
         nNS4op5vuwHj+JVL238FsDMmQcycwO8zf/dXUrxnv+ZyyQJe+smcNWoWoLAVgX82zdDC
         kACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769083591; x=1769688391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7NNlJioF9TutCXRmGC/U8g6cqN3dq9dwMLqiUwgqcY=;
        b=nOZOWWBBZ+wxTdK+SZv+RcJNGVur0QtjgNTGdcdyyGfiQwuKIwHmRVAViex8HhIhrA
         Tc8gs5f0XeaIKVO+8Q674zO0cIBFJ5wArrHDPBMYsGxnmLY/BMLzv/RXMGpqw6VoyLk0
         Ddgg8GVog6j+6clPh1cYT2BfLE2K+2DwK6umqDGRQc98ZZrrG/o35WFQG3uzXeHAYL2n
         w/GBZDdsgNyqkINFrqDg6rYIpiujOsB2ZiVU0mJnr60DrmX8urC+OznxfqQXcRYhwuEL
         EpD3lm0a+9UUqcVcUIRdHKugnmjSblncTFrcH0r3b/ffi9kloS9u+PuKXMpx/85iDYFy
         gKog==
X-Gm-Message-State: AOJu0Yyvf3OUPTZEf9aavqM31e82DoYJtJqW1wXr+gB9sbl/vCTPAxfd
	nsKrYto/ScnQfO8gbib/lh2yfQFkmoQidNxls9hjdEnbKGWClsV/UMhFbrbqqQ==
X-Gm-Gg: AZuq6aK0TOxQGEvv/rf4UiYUc7RO7/9xdD+LdMC5C7NcW7Nz3IHCU6kkPxpNsMECyyL
	FbR5zComKbv97IcSgQ7fbZuRHw5wlJ1ZMM9zsVbZ77e3uthNEIUGEWbZOm3/bVgCsgr8AWz6gBV
	EnVeejBnLSVTkx1dktuuR61hWeA10KjCJT1kFMI9dIAmFysGeEhHPf6YdOcbbaNVN3VW+aE8nt5
	NcVtlLBkkt8qMTMWPcb3REUFnqjfgkh8LpTIUP5UnGvEMsvM4nxg+zHzy2zPT/sFzWsAkxWN6Yv
	ge4RRpUNFAWPQPwEQy30hdgQPMwEbI/kxZCo95jospdsUdNSo75r5hLPaIl+GtxueJERJWwq+/l
	V6CnEhbJPd0wlK6pgpMLChu/YvDWOhtZHI5LYXYS8Rxu1jEWcmA+CIKeRDD3AIbMQQ4+fvqK+Hb
	2pjkVd9wvIuQanGqWxans020DkD1VjvdLSn4ZdzjFxzB/UDEmj7y3xSg==
X-Received: by 2002:a05:7022:e0c:b0:123:3584:de4b with SMTP id a92af1059eb24-1244b35ad12mr12266103c88.29.1769083591543;
        Thu, 22 Jan 2026 04:06:31 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.213.30.126])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm31605421c88.10.2026.01.22.04.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:06:31 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: rafael@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gongqi <550230171@qq.com>
Subject: [PATCH 1/4] ACPI: resource: Add IRQ override quirk for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 20:06:26 +0800
Message-ID: <20260122120626.3471848-1-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20544-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,qq.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[550230171hxy@gmail.com,linux-acpi@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,qq.com:email]
X-Rspamd-Queue-Id: 517066717A
X-Rspamd-Action: no action

From: gongqi <550230171@qq.com>

On the MECHREVO Wujie 15X Pro (Board Name: WUJIE Series-X5SP4NAG), the keyboard does not function properly without an IRQ override. Add a DMI entry to force IRQ1 to edge_low.
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


