Return-Path: <linux-acpi+bounces-20563-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIBTGq9LcmnpfAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20563-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 17:09:19 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B869A46
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 17:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D290309E69D
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227D236074D;
	Thu, 22 Jan 2026 15:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br7FI+Z/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324535DD1D
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097331; cv=none; b=UyXwMLkIIb97btc6EDaFZUska2BV1/q+yEAXUJF8AElM0vNoKvAk1XFs+ZkkORSETeC1QsoOdzB4xT4gKUvE7X8Tfqn1GNiEN483o4Qn8mHyB/vbol6mF0x3WgwBSJ4MlREidqEovQca4Yptzqg0K3Wpkx6kvCKNtf/gxIb6+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097331; c=relaxed/simple;
	bh=V5b8HegB8GRX/lAVl+vWtZpAiWhKdfd1I/+Cxli1x/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbkquxAn1Qd1GxFb2IUytweCoix6SRpbDkArcsyJCL5kSMyP75henMUtB+W5Ci/ITcCL5P5MQR+7DOKDm7v6PgMtTjOyIAmdTlxlcbr7lsPzfPc09JbYH6WdFUPxLd4xuD9JS1oGd/LZhMdIeHKcl2KHnwv4A3zMLYV/cs//JJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Br7FI+Z/; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-121a0bcd364so1983527c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097323; x=1769702123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT7sxUlCTKBw+bxvJar1XKrjKbpL37hYJb8bo9j5S5g=;
        b=Br7FI+Z/RvxaX4t2XCZthxCvicYRTqC8KliAR2khFB9LAapxggZUTiyREzzFL3AHOh
         n9TCgAnr0VSLmZoJJkstjmjkB2/ZoMlwP2v4z7z8ib1v2w1EsuQKCuB7d2EAtsUTJMgQ
         h8uxgitbSqb28MuhMdyXIaB7whECT/EFDvws0cyqN6UvWCR8LzE2abIgBDpKuLtLp/0s
         lfE2hSCzpVTMBzM8LK7jFSLpoT5EA1FmOxxO9P6aYrAAlzo5IGV+j6CsvWSLM3pjNOj1
         zjf4h3uEC16heozXI8hq945rXIxaasheBVIUgg9AXfCKRPfp8AVyxV5krlqcxt/tkHxD
         SGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097323; x=1769702123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sT7sxUlCTKBw+bxvJar1XKrjKbpL37hYJb8bo9j5S5g=;
        b=fGiMBg4/+RSaTlOJCqlZ6ugjCdKePziox2SATKaFXDSqipRlqyu/3XR5ba+38dY79+
         xAQ33oSVmLwAglnxKvPOTxbMpKPX9PGxdRKA7p3LnFfiOxdvScT6zq5g2JVrKXIPU/Fm
         ho1TClosAuhYbfXVH61FrNUaFh2ygGWGbe7m/ZXBcBRDxsfdGtWmU6Hb2WwWpyZQnDd8
         W/xp3Np1fhoWcCVrTT48W9j5hVF8YRgSHIK+HLwWxm4Vf7QvonL6rX38V0yRgAFn3aVK
         g4RW452mvkcv5/oOc0hWGrNMHWCFVKNi3zn9M+vFO5A/zlYcI75PCGWcb68+dewjWGDa
         8pxQ==
X-Gm-Message-State: AOJu0YyfaJcRwXlEIcgoZ9wfHRE4gpK3ypTq0+wUS9G+/qgu2pCeTF09
	HAhopFCIDtGwoQettmvBE3gcV2jfx3elbASFCMTler4GPF/B1g2NwA8m
X-Gm-Gg: AZuq6aIoyLnfw1aV1diTQm9dZAmYw1Nkatug24T4B5kDydv2Oh9w9O3DKNxwiveD+g4
	YUCixENa5+3JA8tMi4yJoFa90g6Tu7V2wEVuBfp2Oc0Tn6Fhf/n0HxytOrxOfNHTYG1fH0qWcI8
	OzYb8hyDDw7RFP8vRK7v/UQjuKORoo5aqzFEc8x5zld2mKdJpYs3whXdzJzcKH9ELKm+AuOdvh6
	gomCMZeuxIShW7f9aeLr/IIf9IvKVy1bfb74LfIKSoOoQv6gHy2SroeW+yfHFEMPL2DOgaoH/8E
	qQ5m06Q09s9pnxx0J6mVmVYDskQ/nhyfJOVgcDfT0EczvzlIbtZ0KEbHTgftYb6BEvENlUZRWfr
	pBvlhJfsmXUSmQWZS+FDykD7Y9Adkvnr8IHf7kK02M5kPVtv1Y65IAvGcAB7etV8Zxb1xQ4E/If
	HR7akhApV3D8HosynafNZWi1YTwjQ7Z/zlXxYcxNXfVEtHRP8fFzax
X-Received: by 2002:a05:7300:e88e:b0:2ae:5a9f:d98c with SMTP id 5a478bee46e88-2b6b410b210mr13103401eec.33.1769097323537;
        Thu, 22 Jan 2026 07:55:23 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:23 -0800 (PST)
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
Subject: [PATCH v2 3/4] platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:55:00 +0800
Message-ID: <20260122155501.376199-4-550230171hxy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20563-lists,linux-acpi=lfdr.de];
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
X-Rspamd-Queue-Id: E70B869A46
X-Rspamd-Action: no action

The MECHREVO Wujie 15X Pro suffers from spurious IRQ issues related to
the AMD PMC. Add it to the quirk list to use the spurious_8042 fix.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index 404e62ad293a9..ed285afaf9b0d 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -302,6 +302,13 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
 		}
 	},
+	{
+		.ident = "MECHREVO Wujie 15X Pro",
+		.driver_data = &quirk_spurious_8042,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0


