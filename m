Return-Path: <linux-acpi+bounces-13289-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD64FA9D1B6
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B4F4E4142
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0A92236F4;
	Fri, 25 Apr 2025 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M/Vu+IXU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DF221714;
	Fri, 25 Apr 2025 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609666; cv=none; b=ehwSe3l/srySoBOaWrfl4XPjBz5D5bBon8662O37kLt1fW9+5QlT06WfGTk+px3P37xiluIO4Dig5fnzhoYrXSrPeFScPVoXMCAb1VmiIB5uaSkCUIS/67rPuWdlMe53HPQLruazcAjKjt06LMufjYYOFMiZIbhh+xjXUkVVVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609666; c=relaxed/simple;
	bh=nVy5aWKIgku0ASs8zTDYZiXGEtNCnxnzwhpSxvmTSYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLS3PlE62Dld4S3DCsR2JWojQ69Om3rRG4X01akiSdL1KoBfSSVojVGnfYEcf6kRjU4vjaoA0ZXZYJ9vyw9PPLhe2fTiYimVDnlyhv0C3uVmGHSuxV2EQ+ixAa1B4QMcBWl+BOHN6tbvWHE/lBcCwdDjRBHF+gcjyxdplVsQ3ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M/Vu+IXU; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EC3D5664A4B;
	Fri, 25 Apr 2025 21:34:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609660;
	bh=nVy5aWKIgku0ASs8zTDYZiXGEtNCnxnzwhpSxvmTSYs=;
	h=From:Subject:Date;
	b=M/Vu+IXUXpbX8iEUoY2TIj2ulH6EIaALgLo9NB2SngF9v1MQlJIOy0xvTkFeDXS0O
	 miaaw9cZxHYn4/jYjM7+fG0w7HDcjfxSL+TTOqCyXiVzWdMbIY16iVZBhJYgQIs2jh
	 1Hmo+CDWgcfZw2Xyi7OgWPvJHaJOBjwRulwkR2fQk3beB+CtngfL2ADO5KorZ08dS2
	 RM0UwEZGCn+8fzlBpTHCRlJ7/HFPTSd3Eh1eovJQaQmR1tvnIaHAGtkIwrOVfYCvfX
	 7pcAflp6mas8X1pwGbflD/whXGLGyPtA7WhQ9BANvyjSpsgEB51VKPx9eIKvb7fMu5
	 3wpJI2tqxcqMw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 09/19] ACPICA: Utilities: Fix spelling mistake "Incremement"  ->
 "Increment"
Date: Fri, 25 Apr 2025 21:26:03 +0200
Message-ID: <7814589.EvYhyI6sBW@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Colin Ian King <colin.i.king@gmail.com>

ACPICA commit 0faa6e20cfe56fdaefc37a38f8fd04e3137fcdad

There is a spelling mistake in a literal string. Fix it.

Fixes: a171306ed1a1 ("Reference count: add additional debugging details)

Link: https://github.com/acpica/acpica/commit/0faa6e20
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utdelete.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
index c85bfa13ac1e..e8180099d01f 100644
--- a/drivers/acpi/acpica/utdelete.c
+++ b/drivers/acpi/acpica/utdelete.c
@@ -404,7 +404,7 @@ acpi_ut_update_ref_count(union acpi_operand_object *object, u32 action)
 				  object, object->common.type,
 				  acpi_ut_get_object_type_name(object),
 				  new_count));
-		message = "Incremement";
+		message = "Increment";
 		break;
 
 	case REF_DECREMENT:
-- 
2.43.0





