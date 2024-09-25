Return-Path: <linux-acpi+bounces-8415-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0266E985EE6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 15:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C7A1C258CE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6451B04E0;
	Wed, 25 Sep 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMxwLxK+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1A156236;
	Wed, 25 Sep 2024 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266399; cv=none; b=JujVZ0BarczuIoyn7HlbgEhLbbG8G0J1ZPoiAhQozxUGTiNWfh324m3a15+sJGpFYLdoZ0yWbIHyg+Iq1XC7WvkDiKC1HrTRAL+wWOMe/+vMqv+UQdEOd1HKf+lRPF6f37CdsLW8843JoyOlHP+dmlh9xdbFztrk8lVF/I5crrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266399; c=relaxed/simple;
	bh=nxvCESaPo3tee+1z3SSAOCc5NyVOaygaIYLanQVQlwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoLUBzmaBLkGLZC0rMst48vapM2+0rogutxib3H7QSc3WbYd6dXvah1j7ZrgaYLL5cfiuLERPLYmNahNh9SoVG+qCelO5H5iab9Lj1U1VWbHi0cY+NTcla3hRwhRlezV1i3X854ad1DvnhAfLuBb+k0k9ZSB4CNM5Fwv4bO5sAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMxwLxK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C84C4CECD;
	Wed, 25 Sep 2024 12:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266399;
	bh=nxvCESaPo3tee+1z3SSAOCc5NyVOaygaIYLanQVQlwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMxwLxK+vGxAa/fjU3udQJdO8rcUe6yM29nDzbuIGs27YaJYS89p+3nczqttpY8VH
	 DoDswmMKAkMddFnFp8pcXIVIXbMz1WxrHNllJjGh3YTYf2O7YcXXP0A5pWGiZ3SG0y
	 b0ERHydKOI/c9DIpFGp6s+oIyUmFEPV+27jg4P4IIIKPPv+UuT8ZOu6uXn+ZVU/qTz
	 HUfBpiqesoicVMmF3S5iH3yGRAPqkKQ+duLddxrQVZLsJ/GGiaViLTZsGTAA7yu2Yr
	 yqpWRM+9+XFiC9PgVXab8Bsa1Y9SiQxi4y3l4TVXSfQ41LsGh75S5TI/d8KdS9D8e+
	 jKlbV55caVSSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 047/139] ACPICA: iasl: handle empty connection_node
Date: Wed, 25 Sep 2024 08:07:47 -0400
Message-ID: <20240925121137.1307574-47-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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


