Return-Path: <linux-acpi+bounces-20910-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NikI6AbimnKHAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20910-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 18:38:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 475E71131E3
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Feb 2026 18:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 310CC3019FCC
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Feb 2026 17:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144123859DF;
	Mon,  9 Feb 2026 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSMMIrDa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4C2E62C4
	for <linux-acpi@vger.kernel.org>; Mon,  9 Feb 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770658716; cv=none; b=nrd7mMw/X0N5O4idfGJy4I+EbP1mwFdAv5IqMG2/1LsfU9WpTBZMk1iCxVdH11aF/xXmYMDhF4+tq3A0B01kvGJTO72td1F6+vLdSdQkm9UNtYFFUp6fU7coQ1N8bOB9u82ouUv6yadp/Sj3DzN+wv1eAfpCMCGRAPlE1AOMPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770658716; c=relaxed/simple;
	bh=m/i1X2lXiKcn07FMp6qZlT9erwk+ht7cleXRIb7SBZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAg96F0EcVQqHoizGmCYoy4R6jOSXE46FV4uGF6HC0kJ2tmSxq/FUKSRw19azT8lrzGtAPSVG3aonboQyb9ybwa1xKhmW4mF09KlnD3de8ePoAOsaRw8tCbrTjeYvSnyyn05pcYBvm2YUUdhAgcXU3lU1L8qXr5y3fme53NL2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSMMIrDa; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-382fb275271so32905421fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Feb 2026 09:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770658714; x=1771263514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ1qvlMmC9r0M+r6ivGBZ3k3nGz8gfz87Oob6k8D3IQ=;
        b=DSMMIrDaZMANDwYalNiCbeYvavfvB3VzGv7KDnUbjFOpTRLoU519pYalgRZMuKil3w
         W6J9T6trk7A5990RIaxgdVV4ZcqbTiPhxSWIevDWQO+a38YReLbKsoMX3Nb37DNMMYy+
         mJNPfV3H4guZWrS2BcU7l+oEkCfGSHrYvHkHX6P58bIZjl4GIlfqgNsVO8lByePiBRAc
         xVWx0T0OqgLv6w/HLFx+ahyMeBm3DasObvpirLjeb8ToYQ+saFq1qkZAhtXPgRzAEZH/
         JZlKPcEW9phHtrMkaaBGdqKVADrRx1OdBUuSn9K8VDhcNSiypICxGMvJytds1PdhtOiO
         evZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770658714; x=1771263514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJ1qvlMmC9r0M+r6ivGBZ3k3nGz8gfz87Oob6k8D3IQ=;
        b=lf/swEKXNzEBtflSY/wnCp0TGeLK/ipwrwQwTk/94HII8DezixJ1pQQ0bKiiHv/W/L
         T8rHn4gutASF/oFyCiT30ACqf29qsdNKvbKOVHvsvMygcwOan7t40nlWW54sEBOXMmtY
         87xAlxCun3QRx8A6HSzanRC/60lRo7DGHNZHQUDU1AvjQ9bxSTzBuLIUZ6y89Ht0ndiT
         u+prQeYo8WmTeSsHsoG+dVUmo6RpnfitW63zEqs0cadhDp9WFfGirIuBf6iF8KBaDsbs
         Ot383hKZtaGxM3QjqeSAHZa0ZrZj7V2rglTcKr9FeBgADKiZMPKqDfH+jqtUNXuLacPy
         FZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN4s07q9L8afN3aJ7TUJGU5/2YWwYA7nt7fJ9yKnifang2Ut88I6HdseOZGz7BoPPiGF9Nvw9M8987@vger.kernel.org
X-Gm-Message-State: AOJu0YwrPma74F7p3sE9HROT7a0/4KaFJdgqVAsKbZUlD22xf3qj8ePs
	0gA8bNjWBtkkBhYo/1kw0qrYA5iDDKgqqqFrQVexO49Gl37UQxv9DJvt
X-Gm-Gg: AZuq6aLMh/IipOBK16y8fdYTXasxXS5/4s0CrKmP3OG3STVUbSx2mZP2fFwtPXg7GcD
	iSy99+AAo1BrKv8/rskTO01vJGr98FSFTkpR88zmfQTsv7ekq2NeaUYaNK2kQN9me88WdfTuVaf
	L9h0Qs6TKHhAclyBR1wcZNkTE5TYeVs3mv4DJhqVXsjh9SujxLDoSdT+7Dh39O3vtwpd6ldyioz
	CeFQNNH8KpSlo3grqJ0PZkAnaQMbZdyvSsSgOijwOQE+lg10bTCQJ8gMqpkqOPMQFDWv+9iVyzb
	Ti8pvuTf7H5tnyw3WaDAiD8vEMWPvAiYjvm+xSQrHZhCw+0aiR9HSowpJPIErVp4PQ8bhGlX/4t
	/3x73MGFwleuyKt8+CN6FnifC+j5SyAiT+JrSdGphuGRjICQFsu7J0Y2cq2OFxnANlfH9NrXjUF
	yvf4K5EPnIqDHGhAY2hbT735vffdegKGjUCY9uiZnnsrNa46srV2+oHiYQr69YTBHodEepAvZ8h
	dpXbiFtVTHkL4IzqRxwUIyzKg==
X-Received: by 2002:a2e:be91:0:b0:37c:cf34:536c with SMTP id 38308e7fff4ca-386b4e92401mr37765091fa.3.1770658713610;
        Mon, 09 Feb 2026 09:38:33 -0800 (PST)
Received: from localhost.localdomain ([176.33.64.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b62363a9sm26282541fa.9.2026.02.09.09.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 09:38:33 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alper Ak <alperyasinak1@gmail.com>
Subject: [PATCH] ACPI: battery: Avoid dereferencing battery before NULL check
Date: Mon,  9 Feb 2026 20:38:27 +0300
Message-ID: <20260209173827.87744-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20910-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alperyasinak1@gmail.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 475E71131E3
X-Rspamd-Action: no action

acpi_battery_notify() dereferences the battery pointer before checking
for NULL. Reorder the check to ensure the pointer is validated before
use.

This issue was reported by the Smatch static analyzer.

Fixes: 08b54fd57782 ("ACPI: battery: Adjust event notification routine")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/acpi/battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3bbddd6f622c..abc82be69215 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1063,12 +1063,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_battery *battery = data;
-	struct acpi_device *device = battery->device;
+	struct acpi_device *device;
 	struct power_supply *old;
 
 	if (!battery)
 		return;
 
+	device = battery->device;
+
 	guard(mutex)(&battery->update_lock);
 
 	old = battery->bat;
-- 
2.43.0


