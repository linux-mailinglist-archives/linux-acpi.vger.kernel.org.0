Return-Path: <linux-acpi+bounces-20298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C3D1ED83
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CC9D301D1D4
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7039A80A;
	Wed, 14 Jan 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diOdc9ZC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5F399A70;
	Wed, 14 Jan 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394510; cv=none; b=FXrLiAU7nkoiV4PY+eKOl/RIa9sRiTASjJSuGw8eZxdm9ydgZXSeOzj9a8OwoOAMwcuS1hx7DpNT6myFzez/f3K3vy1zwaJ/95exWWCv5szk2atZTXiHL06436StP61JQahlPl8Qk5LJ4V24b/I11LiUSW5fp7RyVqB3T90svz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394510; c=relaxed/simple;
	bh=OBTe+30OwnuOscGwTnIU5iMu0r732nrO5/qZXkBWshE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3a9cruOqH+5qB8ZGKN7v/2ENTL5xDKRABzHN1gJ27B4owRAH7eHzP7T9yhL3vUSDM1Htz/eAM8BRK9QkGqwr4KEhzomfDM3WVy5D6lrEEmevwLdZSJ67XQOiC2/zETXg5iWQDDgEC7IYS9E5AfEpIJJt5DT/wUCVRofLyqmKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diOdc9ZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC0C4CEF7;
	Wed, 14 Jan 2026 12:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394510;
	bh=OBTe+30OwnuOscGwTnIU5iMu0r732nrO5/qZXkBWshE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=diOdc9ZCcEtYJjvuQt+weGUEXKjRRK0uWY0+VeiBm3iHSeUrFDXToqu3uYxbgGdiz
	 GoaSqACvfMa4Jsszx49SHoVVNFVbb68nUEHd91Tji13Gje58nxBDmI6r52e0SIv6Ol
	 8zsxSkhRxoiw0PtmnYA12KKz4qPcUiHnXxayFeP8Hy6g42CEoI2h806dI+tFgUWGDc
	 Qx4NxDFnllMkERgar9J5GnXpYeCTl31QAbm/xySnl44lN1x22OIFUcEfRSWDHId4D7
	 1OdtGoEGxMlv9bz2eIp0mLNa/Qf2s4dj7ky678Yto7Ri/XoEnVsX+hj1um7dED7dZL
	 fRDuNP5aUxGcw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 19/26] ACPICA: Create auxiliary ACPI_TPR_AUX_SR structure for iASL
 compiler
Date: Wed, 14 Jan 2026 13:33:49 +0100
Message-ID: <2266165.Icojqenx9y@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Michal Camacho Romero <michal.camacho.romero@intel.com>

Define unofficial structure ACPI_TPR_AUX_SR, which holds information
about the number of serialization registers for TPRs.

It simplifies DTPR Serialization Request Info Table compilation.

Link: https://github.com/acpica/acpica/commit/31f470e708a9
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index f16020829f42..89541cd0c9b0 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -2001,6 +2001,11 @@ struct acpi_tpr_instance {
 	struct acpi_tpr_array tpr_array[];
 };
 
+struct acpi_tpr_aux_sr {
+	u32 srl_cnt;
+	//ACPI_TPR_SERIALIZE_REQUEST tpr_sr_arr[];
+};
+
 /*******************************************************************************
  * TPRn_BASE
  *
-- 
2.51.0





