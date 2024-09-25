Return-Path: <linux-acpi+bounces-8414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CC985EBE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 15:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3D8D1F22614
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA2215F44;
	Wed, 25 Sep 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKXRTE4Y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D301D09E4;
	Wed, 25 Sep 2024 12:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266366; cv=none; b=X7n6j97wu3SgRjVkathVnZa537iePCuYTOL0G1abKwi76VW/MMXCoLrjO61/OF5/ZwSn+xbsqf4y1CPlmfEoGF7CZpTsIct/qTRT3SZkQUeLzhkm1j86p98AVC2fakawjQvJWMzxNafvj1Keb1pITVYPuGA7wjiwT+HzNhGBmO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266366; c=relaxed/simple;
	bh=Ohhi8k8R187QiFgr3vx1uB0EkOOzrESJdh5GYE0JEOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfyjc90LQlA7EWGuXZJsxNElz8+yjHswt9ZqXY4ddlqzvBK6KLM1jdod1GR9t4LFk2LelTIZjRA2N0ELTWS6hXGwyvNJAjiNgmXYpoCfRATAmqUHFEBbCVzs2QPdrSnoyH5IHfcY6dMq6Y5nNsdjQ28fmfXuRZ+WwJ+vp0dHMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKXRTE4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F337C4CEC3;
	Wed, 25 Sep 2024 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266366;
	bh=Ohhi8k8R187QiFgr3vx1uB0EkOOzrESJdh5GYE0JEOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKXRTE4Y341MVRhBaFi86pznrdplVEXXgD0Vu+9Uale/6uoJIEgErNBSlyaOLCjbU
	 oNFpSXLbC70+gIWbe5atInmQQ5U493dEnTbUNZJEeEYJ3X4FSzlnfoGzq7kauvJ8BE
	 8Vkjjcg6GTOCXWx77eUwQhYrElKjkIoLvgHMjM3c6o04KWoBBd5vlRSG2mzCAK1rRj
	 7+RnrGXK38NxpT/rGietBiu10GJ9I/fC6GX27nXqJwJj2f1UW04DQHpOALcv2mdrdh
	 rFeL++J1unsuSpaPj20g2WufxSZewoLOKlA5yvick4R35MLCoeS2XprEFaIA+58jG7
	 OFvWG+fyusr1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 032/139] ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()
Date: Wed, 25 Sep 2024 08:07:32 -0400
Message-ID: <20240925121137.1307574-32-sashal@kernel.org>
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


