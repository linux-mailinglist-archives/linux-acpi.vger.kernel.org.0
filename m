Return-Path: <linux-acpi+bounces-6847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5877292D68D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 18:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C19D1F267E8
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38DD197A82;
	Wed, 10 Jul 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqFRE8j/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E4197A6A;
	Wed, 10 Jul 2024 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629004; cv=none; b=ArmGsHyArpBTVlr85/H7VkQOrWvisTVr8FH5bPnWjOy1YqBzbmp9r/bq/yvO4dGB9W/Sj6jVIZxgJuiVYGAFdXaTITKMEbJmu25CMXH1aKM/mp7WkcSk45b9EEXFwT6xcYb4kF2axttcYfjzI/SqKbnZcwMu7LbLD3XQlXMJavw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629004; c=relaxed/simple;
	bh=Bx9uFFb7QrVPq34e0L9QEl0vHkz4QoQtHL7QlIkMJyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YZg4J9iG6bVj9eEY5XWPbFTxIBBWHTYpVZRJQmqrzKcSz6zWM/pC/dMDj9yArYBDKlD+BfXnC3pid64Uf2SozYsJ6LUXr8yMfSqg/Uahc0sLLA3cShIj0+rv7Xx1HGGfaQWAZaFarzywPQjhjefVTgM5vfdFYJas+tJi2Sje6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqFRE8j/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD8FC32781;
	Wed, 10 Jul 2024 16:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720629004;
	bh=Bx9uFFb7QrVPq34e0L9QEl0vHkz4QoQtHL7QlIkMJyE=;
	h=From:Date:Subject:To:Cc:From;
	b=gqFRE8j/S79AhOUC4URKYKzrVWPU+N0fv2wttMwDyWtjaoI2eC0E8woMVWwyW7laz
	 xgcKXCAmNqahfeRt6ixKjoPzTFbZg6hySnJBVuiG9YkaZq8smbFSc/IwzoHmGy0UxS
	 U0TD56cE7l9iYy5xB7J+Kbw4K7lJWQOhTd3P8hB0iXunVQLpeOhdiUlG60RAupn1t0
	 Jp2YJTAw8rvX9HNIfSzZCGYXADvwfOTbJvnPQs8CuJA0ABuLGJWi7THegfi5+PvlOr
	 X/hfMlzHr5E0WaCnhXKsPLfRN0niVzbT8y36USIFJ/xHqwgF++Z4U/884WNfVqO18E
	 QH4cORy3G1UhA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 10 Jul 2024 09:29:57 -0700
Subject: [PATCH] ACPI: HMAT: Mark hmat_set_default_dram_perf() as __init
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAS3jmYC/x2NywrCQAwAf6XkbGDbioq/IlKiSWrA7pakPqD03
 108zmFmVghxk4Bzs4LL28JKrtDuGrg/KI+CxpWhS90+HduEal+cCs8lFvyQZ8sjsii9nsvATtO
 QC0tgf7odlFSlZ4Iam12q+R9drtv2A0FOH9p4AAAA
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Ho-Ren Chuang <horen.chuang@linux.dev>, 
 "Huang, Ying" <ying.huang@intel.com>, 
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=nathan@kernel.org;
 h=from:subject:message-id; bh=Bx9uFFb7QrVPq34e0L9QEl0vHkz4QoQtHL7QlIkMJyE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGl927l9fn5sq/wov0A079N3Zbed05huq07edODku+apJ
 5f0/bsm31HKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmEuzKyHBpfteazMOXDx+t
 feQc8NezVCPt6stfdf/Cyq0drG8Gfz/KyHA55s+HIMZrVWe+lGRLhqc9e+p8IfamvdjB/Mkr7V/
 UHeQCAA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 4dc70b711dbc ("memory tier: consolidate the initialization
of memory tiers"), there is a modpost warning when
hmat_set_default_dram_perf() is not inlined into its callsite, as it
appears that default_dram_nodes may be accessed after its memory has
been freed.

  WARNING: modpost: vmlinux: section mismatch in reference: hmat_set_default_dram_perf+0x18 (section: .text) -> default_dram_nodes (section: .init.data)

The single callsite, hmat_init(), is __init, so this warning is not a
problem in reality but it is easily solvable by marking
hmat_set_default_dram_perf() as __init, which should have been done when
this function was added in commit 3718c02dbd4c ("acpi, hmat: calculate
abstract distance with HMAT").

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406292310.hlRATeZJ-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I left off a fixes tag as I assume this is going to be squashed into the
former change mentioned above, as it is still in mm-unstable, but feel
free to add one if the patch is going to be standalone.
---
 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index a2f9e7a4b479..ca0c0ea3e1ef 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -933,7 +933,7 @@ static int hmat_callback(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static int hmat_set_default_dram_perf(void)
+static __init int hmat_set_default_dram_perf(void)
 {
 	int rc;
 	int nid, pxm;

---
base-commit: 17bcc624e67da6383060ee24483db77aa17276aa
change-id: 20240710-fix-modpost-warning-default_dram_nodes-38b6faffe3da

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


