Return-Path: <linux-acpi+bounces-12465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A4A72088
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFE73B1F8E
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A633261373;
	Wed, 26 Mar 2025 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="TZyVDbOv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F849659;
	Wed, 26 Mar 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023528; cv=none; b=cT5ME7oovIIkKlPBOFs78ynSj/1WhJw1SYVH6iPuxujeAJmqzYl9eGW0fzFUwAU7K3xkvR2NgEoGF2urU2/omJkGg0xUqfHwqLuGu0M5L6uoyQsO5WQwCsIoiMkIEhlsa+cr/UF4TvldDswFWvAkZOO1Vl3HnIvoBOpXceaYrDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023528; c=relaxed/simple;
	bh=KE/5QmfLMOgm0zVoq1QF1iuJCaWhuNwtm0KhXGhBjrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMrN7iBoiN7Gq6X6Tn4JkgNcQl9BAjkOj5DVQavqWquimJafZAl2Z87bEYdGBCcn/9a75+ioUMvyks5uMOGmI7nGpTOgq1mCvCzkfchs1z9j0sNtFisHwtBNbIdXuP6uCRziB/L6r2LQw2kX3Zp9rPWgaRcOWz8FILmnx2DnF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=TZyVDbOv; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 3821ec9f594a68db; Wed, 26 Mar 2025 21:12:04 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A5D097F6388;
	Wed, 26 Mar 2025 21:12:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019924;
	bh=KE/5QmfLMOgm0zVoq1QF1iuJCaWhuNwtm0KhXGhBjrM=;
	h=From:Subject:Date;
	b=TZyVDbOvqodQUIFUfmJC4yKETSbungb7RkWBBD3segCD9Wmy2eTemXOQu7FxDy/Db
	 kVKvxbqa2at/rdXXhaLr5ZX3D0kjG5gtI+PRSPQwXp0Rv2AQyZFz1iXZ0p/kpAlW0S
	 20tc1UykQ1Lsq8ECWGbxg4weNZ8ypXPDzA3j8s0hZMeaLrTeb7gPzfVR1kmfLFoqEL
	 CwFlgVnmQ33JeDVKUFNXbHzaq0MW4BiGuUh2PQSgxoRAAmberZVffrS9zI/dJ3rF3h
	 UqOBKXhZBGfoSOo7tRnaXrik0wnDYklsZwkJ0xixsElLXEuKPPDid3vzCqnTtF60gk
	 aOjt6lNRd9aUw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 7/8] ACPICA: Fix warnings from PR #295 merge
Date: Wed, 26 Mar 2025 21:10:39 +0100
Message-ID: <2304653.iZASKD2KPV@rjwysocki.net>
In-Reply-To: <5873907.DvuYhMxLoT@rjwysocki.net>
References: <5873907.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Saket Dumbre <saket.dumbre@intel.com>

Possible loss of data from u32 to u8 conversions.

ACPICA commit 1d7a0aa04793ff731da13f2070877ec7a9498571

Link: https://github.com/acpica/acpica/commit/1d7a0aa0
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/dsutils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/dsutils.c b/drivers/acpi/acpica/dsutils.c
index 2bdae8a25e08..baf6a1f27605 100644
--- a/drivers/acpi/acpica/dsutils.c
+++ b/drivers/acpi/acpica/dsutils.c
@@ -723,11 +723,11 @@ acpi_ds_create_operands(struct acpi_walk_state *walk_state,
 	 * pop everything off of the operand stack and delete those
 	 * objects
 	 */
-	walk_state->num_operands = i;
+	walk_state->num_operands = (u8)(i);
 	acpi_ds_obj_stack_pop_and_delete(new_num_operands, walk_state);
 
 	/* Restore operand count */
-	walk_state->num_operands = prev_num_operands;
+	walk_state->num_operands = (u8)(prev_num_operands);
 
 	ACPI_EXCEPTION((AE_INFO, status, "While creating Arg %u", index));
 	return_ACPI_STATUS(status);
-- 
2.43.0





