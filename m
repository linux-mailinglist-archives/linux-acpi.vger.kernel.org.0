Return-Path: <linux-acpi+bounces-8407-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC3E985CC4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE71F2156D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C31D365E;
	Wed, 25 Sep 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r48s24hh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED161D3656;
	Wed, 25 Sep 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265630; cv=none; b=He2VgVo+JZnMCzTNbbN15pRFUwfUqCed/4Q/pUigeydnnLMRUC/o5r3PXkRQ5+zjU1FOJAI42fCka0zgzKCicr28VuL1uM9H6Zn5Ak81qu7dmX01uCke5pF9+J27znkEapKxqEZQ8YyFyDB8Ya2rVhwgnnc4iHnsfq8Wh4cBs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265630; c=relaxed/simple;
	bh=nxvCESaPo3tee+1z3SSAOCc5NyVOaygaIYLanQVQlwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLbuJTcd8NXlV+bdfUn06bH3a9Kx6+KTX85OJPEM3oUbINzYjPje2Z9iFPIhMhhQYJHarncywLX5e0FsfF9wXIOZG90RXzaTNdpHKfR/GhGpmCKxfOp4/0/AaON2WyI6CWTzD35IAbXk2p+UyKHhwv6kAAvFwMk4JEVpZWPD6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r48s24hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3D4C4CECE;
	Wed, 25 Sep 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265629;
	bh=nxvCESaPo3tee+1z3SSAOCc5NyVOaygaIYLanQVQlwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r48s24hhvfVEwGlIoGqydBwbCckfeBYxB7z6QJSC52YbdHGVHgYyFB31MeqnQJBGN
	 w22XV8j4T7ekbJ8C1ur2OQ8kLypvVTqQTCc3unSSprbYn9yOS7u14VXX+dVVRsRl9u
	 7yYJalL5h9fzQj3hs+Ru4rAhnNh6t2ubBsRCZ7A9C2b7glhVLblgSZF7aXQZfBtZuh
	 ql9G3ullDluhPKcG7gMu8pdG1RFMpinmAty1LRH34Prtx+Ton685MpiQ27ceL8rYYD
	 hwZ7Rk1brFZmx88sTGJ8EAyHEqbWflXFe2qD3/G5V6ZGmxqGGBqFf0aj2La3qPmpW2
	 bLaieohkixYNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 053/197] ACPICA: iasl: handle empty connection_node
Date: Wed, 25 Sep 2024 07:51:12 -0400
Message-ID: <20240925115823.1303019-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


