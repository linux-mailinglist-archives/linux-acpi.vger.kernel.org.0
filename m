Return-Path: <linux-acpi+bounces-13638-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A236AAF896
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 13:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A1E7B1E25
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B4D215175;
	Thu,  8 May 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="eY7LW48K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BCE1AC44D;
	Thu,  8 May 2025 11:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746703003; cv=none; b=DFCypDNhWp+W8EAJ4KwxK/hRW4q0LhOiHZ6t5tXcEEBerja/AgKeO5By910ty5A7+6NxnoFJHwmN2w5AB/bVIj6ioHeseVoDeNaPs/8c9bTl+hTii7phIBupIARAusJaCYNlTQblIaHSFcdgwD8CbN8Jfe3skVWL2JwSQAY/efs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746703003; c=relaxed/simple;
	bh=ESCyKV2QNz5lB1rwZTodXqc2WbpVOmaYDfFLI4kr5oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqpZwo9ySmKuaAKOBQp0QxWVbyeK9sCkFuzrHIfjZcc3KW7f/Q0BsXsuNvvZedkGCNEf6/bipuJ84cU+S1sbkrDp6fis8f/dw5x7Pcpyvy4LGnCxDXC3dSlIN/KO2AFygx1wqw2+DSj2m7iBmPOXQB1Ct9938QgARaT5k0UM37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=eY7LW48K; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 82C3A2FC0048;
	Thu,  8 May 2025 13:16:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1746702991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0M1MfNww3KFRpX88ZLbLr5/0L/vSuNj89put1lMZ9+E=;
	b=eY7LW48KpUrtMk3lz6/LbiJIRdwjj9vPT/YVPU9TXd/rCqgcWLLfVQiUln9Wp2Nkqn1/DH
	geh+vXzuj2lqlree8YWHXkyTcaw3mg0smcAtee36jSaqGL7j9fUTqHSyO1xvznoMDNO1M8
	FfCegbsyV4lqwulPE4qoWjS2XOMrfh4=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] acpi/ec: Add device to acpi_ec_no_wakeup qurik
Date: Thu,  8 May 2025 13:16:18 +0200
Message-ID: <20250508111625.12149-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup quirk
list to prevent spurious wakeups.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/acpi/ec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8db09d81918fb..de45a5b59effd 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -2301,6 +2301,12 @@ static const struct dmi_system_id acpi_ec_no_wakeup[] = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHAN 66 Pro"),
 		},
 	},
+	{
+		// TUXEDO InfinityBook Pro AMD Gen9
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
 	{ },
 };
 
-- 
2.43.0


