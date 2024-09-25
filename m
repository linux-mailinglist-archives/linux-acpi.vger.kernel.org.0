Return-Path: <linux-acpi+bounces-8396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6969858D8
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 13:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FA41C21155
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Sep 2024 11:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB51925A9;
	Wed, 25 Sep 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N27tAzjb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93619259E;
	Wed, 25 Sep 2024 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264288; cv=none; b=qVimZO/gNhqlHcQUQH6/msWg0Ne4ACSWOEgcf4PydTNTFvC+0+Gv1d79MUG/nKrmWGWbW2AyWUOMZt2GDIjeNRFw7UAfhkX4bEQKZDH5iv2hwF7DbEMXQApftXWU6VPxY+eaFu1DX6rVnfP7LzqkeQfRdHjq1bBrplUpx7FcfkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264288; c=relaxed/simple;
	bh=Ohhi8k8R187QiFgr3vx1uB0EkOOzrESJdh5GYE0JEOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoaB+tp2hKLGhitbdnpTB70z63xkatC9I0XOoAtG3Ecm7EWQ4WIEtmzg9zPoL6YtNk0igG1mN7kqB4WlDzeiuRJTPXgBjB/ydToyWaV9DZWsW3zcI7/Wu04uYC+NBSajGBZ24Jp6Adt6774EZIDicl+mwBrcW2VVsNFc2mzlPrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N27tAzjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5781FC4CEC7;
	Wed, 25 Sep 2024 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264288;
	bh=Ohhi8k8R187QiFgr3vx1uB0EkOOzrESJdh5GYE0JEOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N27tAzjbL16pNUe4+1U9JE8d2u696uVoUkQouLjhOBs0cfZR9YyWvRe5fjNV57aEi
	 /H/3n/9fk+ssBrEmELRs2EQ9wZLjjlsv8e0pw3tqnyyhZ/s/xo8brXl//SbFsQa9nS
	 FQm2JzJoNX0/IniE8zKD5hl5T2hWJq3QAAdK7d4H+dDx/zw0ZX0lTjovZYkkdFEFtO
	 a0/g2eHOl/W/psIQurx2+dJtIry3Bp1jrBCUhIe76Lb9bv0v5fT5WEj657IDAa2WYw
	 Je7Y6SlTSFjd3ZXCLlyN7Vq4+xXJjdfs8cJE2B65gqPgHociCcYeyHVVvL6ar/TtvC
	 1W4TUF74cVITA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 041/244] ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()
Date: Wed, 25 Sep 2024 07:24:22 -0400
Message-ID: <20240925113641.1297102-41-sashal@kernel.org>
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


