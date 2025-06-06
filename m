Return-Path: <linux-acpi+bounces-14186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B9CACFD80
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9567F176823
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Jun 2025 07:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A352276051;
	Fri,  6 Jun 2025 07:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="YUTj02IA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD64469D;
	Fri,  6 Jun 2025 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194965; cv=pass; b=ouBpd+4un5+6vOa+DU0iLoQiKBfTNaQJZXf5zAuW4ckbq41dzGNSKwvinHUeFyA1MN6lKRX0N9BJzcnJLkh4dOwEZZQJvf2ZKxmS1ncyHdEYrEyXNM2iiDgC0tTVyTTG1bA4uX5Fuk+WGyZee7uFt59E348lzaYOaZlvn1hQoxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194965; c=relaxed/simple;
	bh=H5R8o0kXd66u4+i/qXbUVwWj9FSg3AdZtj4azxMfffE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE5cQ9CTar8NA9CpAg8Lv1HDP9M0Gh3f+c1zlMIZpgMzQqccGGsqASPsVPYVV3JK+z21UhJW9rfipJFmCFUj4AGaBgZ0by2vInIqz/i5oB3+dynpFKUsnQsoes4Dwfj2hZ1ujxqgFRGXvdaPtUni7pMFCHeq9eNXckioa20BODA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=YUTj02IA; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1749194901; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jT+1H/LxEAY3EbsWnqWj8dczRAs1f6ZSKFQIg/lwPFbyEkHO+Tun2f1+rh6qFF+e1TzzbN++r6JSY2izPRyTnlbKh2kp1eUsT6TgNH0/KNd25HBnxB4WBR7MNlGTbeyoRjqXlX8cUF3JORya7eIsUOPtAi2rWVY4uwiJC1XWo+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1749194901; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=ih0cPhQO9yl9dR3mzLUlHo55Ox0dnBul4xmprtM+Rl4=; 
	b=OLlGPuzdj5ulnL4RZklEU2WRqnPAVm+P/Pb9P1TXYIwaSD5M9EeShYHfjEy5wH7Ubr/cIX6+/oYnfcCO+wvzDg2CgNmQB+ghkvQcaN4v1ZJDrCHe4S3Ij4XDKrKjocH6D5Lp9YS9d76VjjAU8OKNDBZ3Wc7hfxBzgUkL9BzLajE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1749194901;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=ih0cPhQO9yl9dR3mzLUlHo55Ox0dnBul4xmprtM+Rl4=;
	b=YUTj02IAxGNPvp3Z1gRnhCzZoY4/mxo8Q7Ca7H1mnM6/mAg27xTxxgKRmkG0PRuE
	hfqW64lknvNHvEYq2PfSijGwikxu3KwZHV3NliLZSaD3I9CFdjmAYJJ6YwtcSfhqeQ3
	CyNg4RV/AkAD6lBKf3wtjuNNwTB+6ERwzjtdKzg0=
Received: by mx.zohomail.com with SMTPS id 174919490049757.462558800920874;
	Fri, 6 Jun 2025 00:28:20 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Liu Wei <liuwei09@cestc.cn>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Chen <chenl311@chinatelecom.cn>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] ACPI: Return -ENODEV from acpi_parse_spcr() when SPCR support is disabled
Date: Fri,  6 Jun 2025 15:27:44 +0800
Message-ID: <20250606072802.191580-2-me@linux.beauty>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606072802.191580-1-me@linux.beauty>
References: <20250606072802.191580-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

If CONFIG_ACPI_SPCR_TABLE is disabled, acpi_parse_spcr()
currently returns 0, which may incorrectly suggest that
SPCR parsing was successful. This patch changes the behavior
to return -ENODEV to clearly indicate that SPCR support
is not available.

This prepares the codebase for future changes that depend
on acpi_parse_spcr() failure detection, such as suppressing
misleading console messages.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 include/linux/acpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index f102c0fe34318..71e692f952905 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1503,7 +1503,7 @@ int acpi_parse_spcr(bool enable_earlycon, bool enable_console);
 #else
 static inline int acpi_parse_spcr(bool enable_earlycon, bool enable_console)
 {
-	return 0;
+	return -ENODEV;
 }
 #endif
 
-- 
2.49.0


