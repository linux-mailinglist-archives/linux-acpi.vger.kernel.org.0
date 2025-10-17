Return-Path: <linux-acpi+bounces-17927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BDEBEBCB4
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 23:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FA0B4E6912
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 21:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D964A27877D;
	Fri, 17 Oct 2025 21:21:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DD2701C4;
	Fri, 17 Oct 2025 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736068; cv=none; b=Su+7QKaaWcTzgElxOsdqhV8cq7SxtEHh1Y8WxL1/T2sa5AdG3vY8HDQ1yrcgKtbqHHrdO4Tfqk2IYdoeI9kfE7dxhkl+ffap7aH+JoTUFS4AWZDFIZtU89LIAHMNca9PUIbxW+dp1GM2vZ8G4NaJ/yw7AKE4GPPVywWN97jjY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736068; c=relaxed/simple;
	bh=I1vgqidd1Lia8aLaAQ58zz+OgSHpPPEQ9m0GfLNVbFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1fprjKETdnTg/jNhAlWUBeZyRI+JSjtF5vstQMMrgoGLHhV1V1N2fw9AJe0cdcVrI4iYhH/Kcun/JuFpX7VJ+2mXe9M6VbYfPibcFWf79FNC+is4oNwYh84G14Y/jBBMXr24O2mbItrdCJ4LgkWaUlYe4f5o/Pzs36Ymsedeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D0CC4CEE7;
	Fri, 17 Oct 2025 21:21:07 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org
Subject: [PATCH v3 0/2] acpi/hmat: hmat_register_target() refactor to address lockdep warning
Date: Fri, 17 Oct 2025 14:21:03 -0700
Message-ID: <20251017212105.4069510-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series has changes that refactor the hmat_register_target() function
to clean up a lockdep warning.

Dave Jiang (2):
  acpi/hmat: Return when generic target is updated
  acpi/hmat: Fix lockdep warning for hmem_register_resource()

 drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 21 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.51.0


