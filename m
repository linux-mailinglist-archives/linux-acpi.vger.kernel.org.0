Return-Path: <linux-acpi+bounces-20967-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B1IJPDKjmm/EwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20967-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325D0133522
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 07:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2EFF305263E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE20B2773CA;
	Fri, 13 Feb 2026 06:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b="anVFES7Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C88274B5C
	for <linux-acpi@vger.kernel.org>; Fri, 13 Feb 2026 06:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965740; cv=none; b=K6pLPGhMGIrOKAka6CH0SGjU7qxwfvsgRkUTvPOjCNDYyAsqDLcweahTj1oar1XymEHNEvyOs1ZAQOJpI4sXmPtgUUjwUMdthPImRFaHqhzBjy/7ffl8i5cnI5GQyMM1/6pTGuWpOwFyJG6lumQXIsoACpIEfcgMf3ujovQvXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965740; c=relaxed/simple;
	bh=sTMx8lEvcnLLY4zMCQI0Kt09CDIjF4lLt2+r+Wo/BiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=acPRgD2oIKPoiRLcQU9jKdonsoryq7afiCavnqi29k6w9ZIXoPNHUMPgyMWiFQsxE0YWGJbtQ9CL9l5bowKIOkWJTeaW4Qu0Uq2exwvW0sIWFg8hraGMLCz0o6jl8bQ60NPC0HHFagKQ5z6rHwW9zBlQj3rmHuAViEmiXiw0dP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net; spf=pass smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard.net header.i=@minyard.net header.b=anVFES7Z; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d19bfe1190so499503a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 12 Feb 2026 22:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1770965738; x=1771570538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfTgoVpApawEGawOItUes0+2N5MzHA5wDtH4Hi4KESQ=;
        b=anVFES7ZbBbTHo9VfR43V0m9ZSwmiQBtgqFPQOr+n+VpV8a84SQjZJ15p7VkdoAfKa
         XdC63Kb9IGhoDznxIBsxHKHbxOStMcztgZ2DRqhcLB1+xjb3WjHi7h+KBrYjXc2ncBnl
         KcFnVJWKxS2uXizc4X7sXY7ATmuGAvNcC29EHEDYBkME0GxbprRBSEcxlh77g1ywr0ew
         0VQrN5ZC7OrcoWZi08uXA51osHxQZri88riwPe9MlUVGsTwOxZatlYr6n7sn/yPTPsGs
         2vAy+tTQvZpG8XQZG+F6EFvJ6cJVpNXBRbCW3fi/wv7C7nTIwuNohHxqO+pnlLnja+Lt
         laUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965738; x=1771570538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pfTgoVpApawEGawOItUes0+2N5MzHA5wDtH4Hi4KESQ=;
        b=VcBNqAHAUJbhi7gr6dm5HigAinxljFc47NvCVIHJSBNVYhnaZmpcKY8RWte/p3Xcp+
         IwhwkGZUeXbzv9JZBIko7zCUXCCMsLzpGBjfyNVsjwsVLGUDD/b6Hd3J0HTgVWrtAUTV
         aqQOjR6UowftAsULAQZlg1YtNMqy7o+S2m+YY6Eb3rYsG0g0StDs7SRY4sGE358Pd17L
         VuBXqMfP+k5DOHjhcKuizjFCDt5OVr4GMyyzcKzUbr5zjmYBnDZA23N2NXScDHLOtRSR
         VSMGR1ukrTknW9UMo4hWTDEmStf5hH7Ttg4vFCcMvMfXZWn858PlpOpfq10Ewl6VXvR7
         2+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXbPCB/v3jZQlgFDv9LzZEVWVQ5aU+EB7Wfv62xV6ykcwKgnf2P3kTg6ia9hQ9YPsGR4r4QpS73CWKY@vger.kernel.org
X-Gm-Message-State: AOJu0YyLi8EiDSBf4zUqlnQ10nCiQaHu24bD90kMUFh3MxrdCYKcvLRI
	MtHt3e9bJOO8PbqkwIKH7dlbTxtG1UW2EV/E1qdcQFyLJMehZ6f5JiFC/loh3SxLuUo=
X-Gm-Gg: AZuq6aLlaYpqNp65tjrRjpydpv/ghG4jA4fq6ZMKfvhEXLRqSdZs2I4jjqqkVk/EnAg
	ua2+Yczsb7igkU2qLwwpvb0++26Rr81Wq8nsTvI5EkNeFh18C5ZE56zmiQzUyeVUbhq8Tx8Lyag
	l6A6lYNcZ4+nu9OsTr8sGY0B4c75QE+wJMKfHm7Lf03k8ZuLFmaSFHXTJ7Cr9QrbWVdFU1Ieu9r
	MFLOjX9Pdtsngmf7HBfkRsNfpQ8ZTFNro9LxKXaPgZINnuk2BSZWIDiOKfhqUagD1kVi1hWE5N1
	HFt9kNAmfYAwDsB05aAL5//gEJDQ6zJIjBQMcn++tx4k++QnwS0Zn+VwPpurqGDFDWtAXr3o6Am
	+kzl5gc9oGblfwkPGhTIDpmfbDfRZprQ8BLUFq/Qe/udhhUiodWqxf8WqHEKnVpjO8JujagoTxI
	ryIlLtKFpgRwD99ypUWKaUtvT7KzGYFf8zLZZu5HfRV0cQaHNaYPCfcNR/1uaBeXyxJDaugZhRO
	Jb+MA==
X-Received: by 2002:a05:6830:6f49:b0:7bb:7a28:51ba with SMTP id 46e09a7af769-7d4c4acb069mr432548a34.26.1770965738665;
        Thu, 12 Feb 2026 22:55:38 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:a3ab:7352:1dc1:6b46])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-7d4a754b4bbsm5380680a34.11.2026.02.12.22.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 22:55:37 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Igor Raits <igor@gooddata.com>,
	linux-acpi@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Daniel Secik <daniel.secik@gooddata.com>,
	Zdenek Pesek <zdenek.pesek@gooddata.com>,
	Jiri Jurica <jiri.jurica@gooddata.com>,
	Huisong Li <lihuisong@huawei.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 1/3] ipmi:si: Don't block module unload if the BMC is messed up
Date: Fri, 13 Feb 2026 00:52:13 -0600
Message-ID: <20260213065351.915707-2-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260213065351.915707-1-corey@minyard.net>
References: <20260213065351.915707-1-corey@minyard.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[minyard.net,none];
	R_DKIM_ALLOW(-0.20)[minyard.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20967-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[minyard.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@minyard.net,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 325D0133522
X-Rspamd-Action: no action

If the BMC is in a bad state, don't bother waiting for queues messages
since there can't be any.  Otherwise the unload is blocked until the
BMC is back in a good state.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 drivers/char/ipmi/ipmi_si_intf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index 0049e3792ba1..3667033fcc51 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2234,7 +2234,8 @@ static void wait_msg_processed(struct smi_info *smi_info)
 	unsigned long jiffies_now;
 	long time_diff;
 
-	while (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL)) {
+	while (smi_info->si_state != SI_HOSED &&
+		    (smi_info->curr_msg || (smi_info->si_state != SI_NORMAL))) {
 		jiffies_now = jiffies;
 		time_diff = (((long)jiffies_now - (long)smi_info->last_timeout_jiffies)
 		     * SI_USEC_PER_JIFFY);
-- 
2.43.0


