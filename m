Return-Path: <linux-acpi+bounces-12052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F1A5A71E
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 23:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E667F7A8355
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317C3214A92;
	Mon, 10 Mar 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdRMgXXF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C851EB5F9;
	Mon, 10 Mar 2025 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645477; cv=none; b=t9WrOY2iHZlV9vDgRwHcl+DqxUYkzwIlNDYDCkVLNTJOnfvH81gabykVuY/RIfgMHAfeVb4kS8HNf9GFdLCiViBszCuxf19izyv3n4tYhDlYjHK8oSaG/J24Sx3VVG+Km/WEd/vs6ZbSWg4V1z0b6SDH+uGr4cWbR8Wde1aKco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645477; c=relaxed/simple;
	bh=7WT8qF/73LJ2WnugKO6jPcQACcXStCGR0IoeR3Nxp50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laJD9h1Htk0AcTgDITHCZXHRQ16mNItR7oCI1m2I3olrqCEn1Gc9CJ03BvDkNZ5r4eo4sXU/crcAcBaHTFBLOjm9xuFwIybswy/utLHFprPvGY5pfmYVjDkU6xKh1a+yNns2rPFnSCOpboeprbm8iX2znEhwbEgh77fgIn8hoys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdRMgXXF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F27C4CEE5;
	Mon, 10 Mar 2025 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741645476;
	bh=7WT8qF/73LJ2WnugKO6jPcQACcXStCGR0IoeR3Nxp50=;
	h=From:To:Cc:Subject:Date:From;
	b=JdRMgXXFsj4QMN7T5GPFC5/700G9r70irl+Zk7ZC+QqnjJ/ad1WyUJSgoZvdGd3Hj
	 JUurGjdfBgCWSZ5+3UBuGHFlbek7rh3cxr0MXU+WjXC49td4qG28IWsprXKzSjjFfQ
	 0G2N9lTJxgIrYtVi1b9a4jZHNOj0WrD3e864kTNbW4rEvj3plk+aFk4i+3ncuRZYq2
	 RbJwcmuBkKK1dpuJMLSXvv8RrubEctFTra00tv61ItP27d/L5XLM+CQckOJ1eORUZW
	 pwjxpF7SslV1jZaqry1Yaa144tgeYAE7hDTdVJZfMpA6tdlEjlhQtWgFK9JK9lvNnX
	 UEFugGWuOMxmA==
From: Kees Cook <kees@kernel.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] PNP: Expand length of fixup id string
Date: Mon, 10 Mar 2025 15:24:33 -0700
Message-Id: <20250310222432.work.826-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=kees@kernel.org; h=from:subject:message-id; bh=7WT8qF/73LJ2WnugKO6jPcQACcXStCGR0IoeR3Nxp50=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnn0xYEGnM+SFx1fObR2LjYbQ95QvMWhe1McdSJ3RV7X +j+rmeLOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZyrJCR4d9bL9n0w7JHDzot f9uw/GK8+6HAdhGhmts3zb88YuT7co+R4eWZa89DpgvMWrUj6bqLVdIB9obZJiLzys1mZCs1784 vZAUA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's -Wunterminated-string-initialization saw that "id" was not
including the required trailing NUL character. Instead of marking "id"
with __nonstring[1], expand the length of the string as it is used in
(debugging) format strings that expect a properly formed C string.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/pnp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pnp.h b/include/linux/pnp.h
index b7a7158aaf65..23fe3eaf242d 100644
--- a/include/linux/pnp.h
+++ b/include/linux/pnp.h
@@ -290,7 +290,7 @@ static inline void pnp_set_drvdata(struct pnp_dev *pdev, void *data)
 }
 
 struct pnp_fixup {
-	char id[7];
+	char id[8];
 	void (*quirk_function) (struct pnp_dev *dev);	/* fixup function */
 };
 
-- 
2.34.1


