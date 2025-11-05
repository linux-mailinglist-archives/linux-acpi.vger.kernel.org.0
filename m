Return-Path: <linux-acpi+bounces-18559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F9C38679
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6503A3B3F24
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60E25522B;
	Wed,  5 Nov 2025 23:48:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2119F40A;
	Wed,  5 Nov 2025 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386535; cv=none; b=LnEBQFLzutAZ8y0AAjeVltUxhLyVOyNV0gYHZzecZNJ/aDap6OTqEzsICOV7fnvwgGVGUHLc2YjrXqJxlNJaHLNMbT6IWvxtPHUcT2qrVBKftTUxf8aIicdSUPXaFF016N4YsRq+r2RQVbAff/7XcMaNeQu0c5swLjRtwwdfgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386535; c=relaxed/simple;
	bh=I1vgqidd1Lia8aLaAQ58zz+OgSHpPPEQ9m0GfLNVbFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXD25F9fAX+lvgKnL+ycHFOt71g6nbSx71uPV8X2VrYmQn0jm9SzmtUfRHk5FgEIdRkWTTA8aVH0ow7y792KJWQwa9+L82/VcTHqxKFcEFaqidPihGPGJXhif5Bht0FJoXUgVqpFn/xQ1mwiNLw4tLH7gyu6fNJI7QGNbk4Iqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E236AC4CEF5;
	Wed,  5 Nov 2025 23:48:54 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rafael@kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v3 0/2] acpi/hmat: hmat_register_target() refactor to address lockdep warning
Date: Wed,  5 Nov 2025 16:48:46 -0700
Message-ID: <20251105234851.81589-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
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


