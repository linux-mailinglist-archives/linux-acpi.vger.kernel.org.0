Return-Path: <linux-acpi+bounces-8397-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09109985979
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60E81F2178D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5621A2620;
	Wed, 25 Sep 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umLkRrl8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80591A2623;
	Wed, 25 Sep 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264348; cv=none; b=gBwNVPjPC7Coi8Xm4GL1vkg5b3Ne4LNqKECaNPsXMefDS7zNIMztNC5QoIqf1xiqQdBPDcdZVatOAwNRPm26AdlNgnRo3Gl1f091FsVua0ZaIWTXkFBH1gNmRWeZrjMijLxPVZEgseIHkiwvgw4woDeUaGkvaSPpF+rINxxlpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264348; c=relaxed/simple;
	bh=nxvCESaPo3tee+1z3SSAOCc5NyVOaygaIYLanQVQlwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzQxzlgG/Irbmn2logX9hcdd0i/haZsneaMdtfo0l+y2Zt2eQOUqx/5z2lrB08lO7yC6obi/gE6LUNXnABYx3arnW2tu2pDCL20o40O0OER3Llj8UcfNrw3OGmqs7EdJin1rX9SwsOm0Xsp+rBelnNR91Rai3IbnOB04Ur4QGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umLkRrl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E40C4CECD;
	Wed, 25 Sep 2024 11:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264348;
	bh=nxvCESaPo3tee+1z3SSAOCc5NyVOaygaIYLanQVQlwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umLkRrl8vlIeclQEcDE6vMIs31H3TqSGbSNMxcZCTiI+LZlFigTAPd2gypb8yxTq+
	 pB/wTZzCeAIfsAlwNmslMYolv8Vux0YnBaTJkB0oyIqZNhi+y0yrLO55pXJZmfDaux
	 qK079jCxt3jMSipHr1QbXmL1WuuBGoWSf9c/3BDLL9yp88Feg3Mc5mJPbO980hS7ie
	 zf46PTlmGKWjlmb1IGT6qJ89OXOIX9x4ytvCQPctqUjU3WmQkZyJnNtmIupZjWVy2j
	 hYNZQrarhBah+6mb23SULyD7MuXOI+ZeIq1S+rh+HcM5FhSCwjFG84Re5+3NSImw/d
	 bVEnOntyG56oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 063/244] ACPICA: iasl: handle empty connection_node
Date: Wed, 25 Sep 2024 07:24:44 -0400
Message-ID: <20240925113641.1297102-63-sashal@kernel.org>
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

From: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

[ Upstream commit a0a2459b79414584af6c46dd8c6f866d8f1aa421 ]

ACPICA commit 6c551e2c9487067d4b085333e7fe97e965a11625

Link: https://github.com/acpica/acpica/commit/6c551e2c
Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/exprep.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/exprep.c b/drivers/acpi/acpica/exprep.c
index 08196fa17080e..82b1fa2d201fe 100644
--- a/drivers/acpi/acpica/exprep.c
+++ b/drivers/acpi/acpica/exprep.c
@@ -437,6 +437,9 @@ acpi_status acpi_ex_prep_field_value(struct acpi_create_field_info *info)
 
 		if (info->connection_node) {
 			second_desc = info->connection_node->object;
+			if (second_desc == NULL) {
+				break;
+			}
 			if (!(second_desc->common.flags & AOPOBJ_DATA_VALID)) {
 				status =
 				    acpi_ds_get_buffer_arguments(second_desc);
-- 
2.43.0


