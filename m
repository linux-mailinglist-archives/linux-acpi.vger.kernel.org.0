Return-Path: <linux-acpi+bounces-16185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50318B3BDAC
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0094A7C51DF
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AF3203BC;
	Fri, 29 Aug 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/GNEGjQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8EC3203A9
	for <linux-acpi@vger.kernel.org>; Fri, 29 Aug 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477672; cv=none; b=cKtDXha6qg7O+8w92fF0a0MGxbh+WWSg1ez6rRQgw5KapbvxaWOMLIv215iZFjLaiz2Cf/jGJBjmCoZTud5L/yQBf1Vwhupad28FB0GI+E+EmrN2Oi4Z+eXzczxtUwKffoBltT15yiB4p9R90m3KV/AULxIP4sBw44NZ5oeU3m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477672; c=relaxed/simple;
	bh=bBz01lXeDvBT2Ak8u/J941+Xc7DwhlRqSfoQfNhZW7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFKmWevBtryHUV5CqSctRtsybuLExSCGjd8g7QOEZp9nWhVLmhFhzeQu1R/du/Lb5rk5xPJnz03ygESo/koFPpRbvhuynDkShk4/MDrWhWvRd4rmryBhn29A8GkUIxHzmLO7Oo5QqPfaD0BBbNeNUEGXH/gA2i6w7gKODQqN+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/GNEGjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDE0C4CEF5;
	Fri, 29 Aug 2025 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756477671;
	bh=bBz01lXeDvBT2Ak8u/J941+Xc7DwhlRqSfoQfNhZW7c=;
	h=From:To:Cc:Subject:Date:From;
	b=t/GNEGjQtkW0+idB8CN6sh3ZgGQ98sd6vWpyUuu6BBMCO7/GFjmZekhxxLEAONgpL
	 QoKMxhXKx/4tCzPJCNBu/CiqfNbgmb4jhmAiigtngP8W+XUOJ0YsJXFlUvJli+0MVR
	 yZ5PHzuvxobjsklpte+8bPT7dnurLQNP3LcBDW8ReLLmU24HPf7vys3Zi8+M+lBNPZ
	 X9Zp5Ux9iq1pddKesD6JEvbulwyF3+BticRaqp1YE62JLEcF6HXAj8dZWIXHpZZ4fJ
	 F+nwoDJMHD7PnXkKZ+tLOUr+RDVzZb36xfKLmVYSf2CoYW0UAQJ3kDJyIM4p0eE0/A
	 H5wjdiZrvm+vQ==
From: Hans de Goede <hansg@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: scan: Add Intel CVS ACPI HIDs to acpi_ignore_dep_ids[]
Date: Fri, 29 Aug 2025 16:27:48 +0200
Message-ID: <20250829142748.21089-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some x86/ACPI laptops with MIPI cameras have a INTC10DE or INTC10E0 ACPI
device in the _DEP dependency list of the ACPI devices for the camera-
sensors (which have flags.honor_deps set).

These devices are for an Intel Vision CVS chip for which an out of tree
driver is available (1).

The camera sensor works fine without a driver being loaded for this
ACPI device on the 2 laptops this was tested on:

ThinkPad X1 Carbon Gen 12 (Meteor Lake)
ThinkPad X1 2-in-1 Gen 10 (Arrow Lake)

For now add these HIDs to acpi_ignore_dep_ids[] so that
acpi_dev_ready_for_enumeration() will return true once the other _DEP
dependencies are met and an i2c_client for the camera sensor will get
instantiated.

Link: https://github.com/intel/vision-drivers/ #1
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fb1fe9f3b1a3..9865faa996b0 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -845,6 +845,8 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
 static const char * const acpi_ignore_dep_ids[] = {
 	"PNP0D80", /* Windows-compatible System Power Management Controller */
 	"INT33BD", /* Intel Baytrail Mailbox Device */
+	"INTC10DE", /* Intel CVS LNL */
+	"INTC10E0", /* Intel CVS ARL */
 	"LATT2021", /* Lattice FW Update Client Driver */
 	NULL
 };
-- 
2.51.0


