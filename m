Return-Path: <linux-acpi+bounces-8406-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EB985C7F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 14:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92963284817
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEAC1D0168;
	Wed, 25 Sep 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JShIwDgE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245C1D0162;
	Wed, 25 Sep 2024 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265580; cv=none; b=H2MulySpjqJ5JGiQ5zBkOi/7oM2QjN3qujya/jQBG0dBNxweqDmbt9CjvD1XAB8eeKLVyBuo4J1Zo9cgeOZpf9Caj1wXK43xz5O8pobWIFn+pTaNjZWFJS1QNCAn6nTXKvW8ugfDxsUNgUsifQyZClpnfulpYYJ65EwgGj6AZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265580; c=relaxed/simple;
	bh=Ohhi8k8R187QiFgr3vx1uB0EkOOzrESJdh5GYE0JEOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LdqbaXcV4WVHz+MwQURBoM0Iv5tqTGzulbMzAGR5aPEuu/zdBssiaLRwrLPQ470zlFpe3CndJ8nfhFFhDn16XBBWUt3pPfwfrwtWH53MZcmVmr3u963YtTWyvBbpkPV/cGqfdinKcwTNsfg6B23A86U2i+oE1lGpdev811vQUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JShIwDgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F94C4CECE;
	Wed, 25 Sep 2024 11:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265580;
	bh=Ohhi8k8R187QiFgr3vx1uB0EkOOzrESJdh5GYE0JEOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JShIwDgEUUPdN5Po2wPAy4+99DOLRfI2Li/2W2ZE5PSfEjn/TI+S18ovQhu+ekE8J
	 7LqyZ82QO1tRAYLqLN5RaGosnInNqhZQVsGv5tZDhpvA6gNmUAovXtkL3ENK4tC45a
	 GxRp9lSkoP1N2DlOYhBCUswv7kWgI5RORTEAhqKDUGbEJJuyh2tFMcxV9wMR8ODYLF
	 KxlTXIsseOZqcyL2CERUWlYp89VHwI4rYBUWW3wXipUszAwA8oguNxhCNCa73e1mDb
	 C2gSOmdvV9xHIKa42jvT/aeJPgUQkTQspEn932J6vHRg0arqzMLWpKbuhM1hOWxpdm
	 suLo4nED4N/Rw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 034/197] ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()
Date: Wed, 25 Sep 2024 07:50:53 -0400
Message-ID: <20240925115823.1303019-34-sashal@kernel.org>
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

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit a5242874488eba2b9062985bf13743c029821330 ]

ACPICA commit 4d4547cf13cca820ff7e0f859ba83e1a610b9fd0

ACPI_ALLOCATE_ZEROED() may fail, elements might be NULL and will cause
NULL pointer dereference later.

Link: https://github.com/acpica/acpica/commit/4d4547cf
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Link: https://patch.msgid.link/tencent_4A21A2865B8B0A0D12CAEBEB84708EDDB505@qq.com
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dbconvert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dbconvert.c b/drivers/acpi/acpica/dbconvert.c
index 2b84ac093698a..8dbab69320499 100644
--- a/drivers/acpi/acpica/dbconvert.c
+++ b/drivers/acpi/acpica/dbconvert.c
@@ -174,6 +174,8 @@ acpi_status acpi_db_convert_to_package(char *string, union acpi_object *object)
 	elements =
 	    ACPI_ALLOCATE_ZEROED(DB_DEFAULT_PKG_ELEMENTS *
 				 sizeof(union acpi_object));
+	if (!elements)
+		return (AE_NO_MEMORY);
 
 	this = string;
 	for (i = 0; i < (DB_DEFAULT_PKG_ELEMENTS - 1); i++) {
-- 
2.43.0


