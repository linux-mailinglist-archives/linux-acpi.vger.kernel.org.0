Return-Path: <linux-acpi+bounces-8390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCF1985851
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D6A285927
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1F18C023;
	Wed, 25 Sep 2024 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh5JFOFC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB218BBBA;
	Wed, 25 Sep 2024 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264245; cv=none; b=BZa8mznsdGs5laNw/qqBt6dsAIeg9g3iz2dd/tw3A6MnfXR2h7f/OY0Dxl4Htn7g6jWUupJVUAwrcxHVrOBty8K+vEOYCh5h+EDP1o1kLoSB4sTZCZRZHFABdp8XcTfcw4OvQmEbErFQHn9MoBHtIQK/oSxy5xkX6+efD2kMkYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264245; c=relaxed/simple;
	bh=+vRT/9sKMUBWk8ChoX3rH60aEURssGy3Awjy1YZ6UG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URBOhucLEjlWoo8jFy41E6EOZH+pOboElI1fXBIdKAMODXHhXZVQqRJMvzEQhknB4JLmYm8hhMswjhTipxk82Zc2BZJA3mGEJQvSAItdCnuRn9e+F3a6Fi+vhLJEZyCup1l/L5b0N4xsXnaMHckoEreoj9Wa69NNMRLYbVZ1kJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh5JFOFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609D3C4CECE;
	Wed, 25 Sep 2024 11:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264245;
	bh=+vRT/9sKMUBWk8ChoX3rH60aEURssGy3Awjy1YZ6UG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vh5JFOFCyl+/eI8gAXtJLhC1vJ4waINnvaVtxueV06TZFPsR5msVCkBluzUe/qhPH
	 OiXBs+ufkcw7dOcnGoOYAaAhOQMRPRUtNYu73aubxyIeRIGde0SIj7tA4a7xJARPvf
	 Gyaywf6PJyEfmXSSVj6oyP4IvxYzYy8O5XbjP2ERudN5XNMwAyVw0SMpbJAigdJlV2
	 QG0eMllyOJp2CHuQqxxqayIn/I1JKnS1lTkOke+vUUnN7DpLt9fFARoC7go3g6JO5c
	 mp5JtXYuEVwRLYnCGw/TgSYQ512LZkZS6e7wT7HbYKrTaxMETcB5LapQl85pMDkoBR
	 3sz0BReviRKxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 018/244] ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
Date: Wed, 25 Sep 2024 07:23:59 -0400
Message-ID: <20240925113641.1297102-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 5accb265f7a1b23e52b0ec42313d1e12895552f4 ]

ACPICA commit 2802af722bbde7bf1a7ac68df68e179e2555d361

If acpi_ps_get_next_namepath() fails, the previously allocated
union acpi_parse_object needs to be freed before returning the
status code.

The issue was first being reported on the Linux ACPI mailing list:

Link: https://lore.kernel.org/linux-acpi/56f94776-484f-48c0-8855-dba8e6a7793b@yandex.ru/T/
Link: https://github.com/acpica/acpica/commit/2802af72
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/psargs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 422c074ed2897..7debfd5ce0d86 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -820,6 +820,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_NOT_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 		} else {
 			/* Single complex argument, nothing returned */
 
@@ -854,6 +858,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 			    acpi_ps_get_next_namepath(walk_state, parser_state,
 						      arg,
 						      ACPI_POSSIBLE_METHOD_CALL);
+			if (ACPI_FAILURE(status)) {
+				acpi_ps_free_op(arg);
+				return_ACPI_STATUS(status);
+			}
 
 			if (arg->common.aml_opcode == AML_INT_METHODCALL_OP) {
 
-- 
2.43.0


