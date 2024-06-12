Return-Path: <linux-acpi+bounces-6321-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6469050CA
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40FA11F2210D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 10:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7D716F26B;
	Wed, 12 Jun 2024 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn2bO7G2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3A16F282
	for <linux-acpi@vger.kernel.org>; Wed, 12 Jun 2024 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718189327; cv=none; b=CgNCEV1fcGPtLAi29PG9nL5MjrfFLKlen7syMVDzVyjH+oUplTOdhL+pPxZDqKzv/Pbt4p9Xuu74NRlv+5Xt3a9OlurHYAjEeP9WUpg/djzJJKKOoPUkk1EBGRlN/opk2GqaEdfaUdQyuz6TgaVpa/6x9u1nuygZne3F9BvIFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718189327; c=relaxed/simple;
	bh=GepX4zBkYvPjQZAKwdjGamNBQibq0dFWl5KSbaxvixw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdGKrifRviPBhjigzuV2PMvQRlwBMMZjdPAa7ahjqXmwneE4t1FzEfk8E1JJLY6CGFKNY8W2Nm7wHisZQ9gkbIJd16YePVWXNSI53GOWZI23Ed8W0a8VshCr9i+MBAk/lTMPng3ZV2urgK9vWgOKolgHR93VmImz31B8d7WUHBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn2bO7G2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718189324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vA2EVeRK9NWPrxUoSPZf0kMqlgDnRY4qjeQ4n5ZT9ms=;
	b=cn2bO7G2SQ0luBLSDo8lKsx8VBoUxXbMN2DW9YdieHxYOEn/rnDEzq821rmu/2iK+RlWub
	Lvwcu+3jpcH5MRh0G6DFQW6pUxlZHz8lJEAQE5mjd45aCmGUyhsOlXb7RpFSpCPrjZa7xF
	4lFkbCY7xa1pyc4NReN57RNVWETo7YE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-cxz-2SjfMHuh98b4AOUtVA-1; Wed,
 12 Jun 2024 06:48:40 -0400
X-MC-Unique: cxz-2SjfMHuh98b4AOUtVA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC3E119560B8;
	Wed, 12 Jun 2024 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 26AE21956053;
	Wed, 12 Jun 2024 10:48:37 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: mipi-disco: Switch to new Intel CPU model defines
Date: Wed, 12 Jun 2024 12:48:28 +0200
Message-ID: <20240612104828.25612-1-hdegoede@redhat.com>
In-Reply-To: <20240612104220.22219-1-hdegoede@redhat.com>
References: <20240612104220.22219-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Switch over to using the new Intel CPU model defines, as the old ones
are going away.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
This is done in a separate patch to make backporting the switch
to the CPU generation check easier.
---
 drivers/acpi/mipi-disco-img.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
index 0ab13751f0db..92b658f92dc0 100644
--- a/drivers/acpi/mipi-disco-img.c
+++ b/drivers/acpi/mipi-disco-img.c
@@ -731,13 +731,13 @@ void acpi_mipi_crs_csi2_cleanup(void)
 
 /* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
 static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_TIGERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE, NULL),
+	X86_MATCH_VFM(INTEL_ALDERLAKE_L, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_P, NULL),
+	X86_MATCH_VFM(INTEL_RAPTORLAKE_S, NULL),
 	{}
 };
 
-- 
2.45.1


