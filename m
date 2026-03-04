Return-Path: <linux-acpi+bounces-21338-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHtlK8R4qGnpugAAu9opvQ
	(envelope-from <linux-acpi+bounces-21338-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:24:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5BE2063DA
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6981F3080B9E
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3E3DA5BB;
	Wed,  4 Mar 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGS+T7jE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D4D3DA5A0;
	Wed,  4 Mar 2026 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648236; cv=none; b=tZnJNd5OxFlIxOOIVg9KbpPfIoscqXx9iKpuIPWhwXKgasT+rLQen1HCcapBSs7F6uZc8MDOq3ZkqNyPAIMsxQ6BpMdtucLLJuavzsAn2mHsmFgZ2qQdZEmX/nkVOXOtMFIoEy2X7es8MmQMGhLTUodZ+4JhrqEbjhnJTIn4JGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648236; c=relaxed/simple;
	bh=9GoprUYSUZssZ1PQaBB39NYf3vii5X9keDoAbe8U6Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+IVfWicohIGPoeZvXCKvPkQn+xtuG7OGTsamZE1CXCILt69Y6b/K1Kwq4ZNcX+q5RX06hUbnHfuNszxIoX92rPJSe9Qm2bTxceBYkJlE25flF3srD75j2OcKTy2UjA2i7z7gQllLJGD/twWrBn6+IuPkeBMIu6S27VIQxiGXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGS+T7jE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AA2C19425;
	Wed,  4 Mar 2026 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648236;
	bh=9GoprUYSUZssZ1PQaBB39NYf3vii5X9keDoAbe8U6Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGS+T7jEcTI8Be2G2lD/3RTtYDyJSp3vsWY7cU6obHXHU3W9sEA4r3xkZhijR4mEX
	 gtGxDuZ7Cz2Di8+7XdHJlp7eLhP8dtKn4n9Um374xMTfJgbeMo6sAc3V+1YNUt9TiI
	 lgVvmBPi6jPXKeJ5j0C/kCSUuxXPFggtSKsb+ywM/EmM5oTaA+cMkjDxvpOQqvb8a/
	 uwYiMVRgM4R4pvLNpqFFBqTjw2OSDx8hCa12qUGoIExhiOtyzvUU+mrw6aXdK3+pTR
	 FLot7dtIMpr5wlLT8r1OR+q1o5MUkDvkb3xyleXy02VteaGVPruNtZo3VFX6JvSQKz
	 i709I89LSKhPQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 3/7] ACPI: TAD: Use __free() for cleanup in time_store()
Date: Wed, 04 Mar 2026 19:14:01 +0100
Message-ID: <13971300.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4F5BE2063DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21338-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use __free() for the automatic freeing of memory pointed to by local
variable str in time_store() which allows the code to become somewhat
easier to follow.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -167,57 +167,57 @@ static ssize_t time_store(struct device
 			  const char *buf, size_t count)
 {
 	struct acpi_tad_rt rt;
-	char *str, *s;
-	int val, ret = -ENODATA;
+	int val, ret;
+	char *s;
 
-	str = kmemdup_nul(buf, count, GFP_KERNEL);
+	char *str __free(kfree) = kmemdup_nul(buf, count, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
 	s = acpi_tad_rt_next_field(str, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.year = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.month = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.day = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.hour = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.minute = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.second = val;
 
 	s = acpi_tad_rt_next_field(s, &val);
 	if (!s)
-		goto out_free;
+		return -ENODATA;
 
 	rt.tz = val;
 
 	if (kstrtoint(s, 10, &val))
-		goto out_free;
+		return -ENODATA;
 
 	rt.daylight = val;
 
@@ -226,10 +226,10 @@ static ssize_t time_store(struct device
 	memset(rt.padding, 0, 3);
 
 	ret = acpi_tad_set_real_time(dev, &rt);
+	if (ret)
+		return ret;
 
-out_free:
-	kfree(str);
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t time_show(struct device *dev, struct device_attribute *attr,




