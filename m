Return-Path: <linux-acpi+bounces-9887-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8AA9E0C2E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 20:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5819B3F3F6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0A1DED55;
	Mon,  2 Dec 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DIjPzdRL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FBB1DE3B2;
	Mon,  2 Dec 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166253; cv=none; b=C57Mr66gAsKEG2YyQLUHn7ayoDtgUrfWla85/aydRjTCUertVKGCSD88Ys+1dLzvMy7tflvXwJ17gNkwkA9IxPTKIwXmkVZ2+g1zgV3kHNqd43FlDC7kiIVdyRj5/XeDANK8tG6oqpI2IYCacQcvsj/fZRPqQT+Ad12ZLmLLeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166253; c=relaxed/simple;
	bh=n1oVtaxO6zoj5Nfd+PLAsf4IlOLtQpIGsAupGPgoIEg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YG4LfGpOXki/AJ2C/aWu75JKZRdFf/OysyvzldNQX1CBJ0TKCwElHbzTsljevWxJ8hqS+/73fD0J1yuKAQdD0RVPGn6ryfsYvtaQN7IMYdUgjShtYMofGkWBMo0D1QJnM62X9qAhKCaXLIPXjlpGetX7BSpZEjp5Pn5LuRsfpVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DIjPzdRL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166250;
	bh=n1oVtaxO6zoj5Nfd+PLAsf4IlOLtQpIGsAupGPgoIEg=;
	h=From:Subject:Date:To:Cc:From;
	b=DIjPzdRLNYBUf/i1CJVI+8N/iHEKC5JNSJRYxIlY6TSF3QvSiyCyvpbz5vWiV5iey
	 8KhR7OoocAd03xENRbLlzpkwk45hX8+L5aDzpH3mu9UsJTCdBhkKPOU1gVai8Tnziy
	 B6Nj6A1FYSan2EAIElw76vfBTKfIofIdB09OgcWQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] ACPI: Constify 'struct bin_attribute'
Date: Mon, 02 Dec 2024 20:04:08 +0100
Message-Id: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKgETmcC/x3MQQqEMAxA0atI1gZsGMrgVUQkrXHMpkpTRBHvb
 pnlW/x/g0lWMeibG7IcarqlCtc2EFdOP0Gdq4E6+jjqHNpli2HckhUMmiYuJSPHXTEIfcXP3jM
 x1H7Psuj5fw/j87xA/dNUawAAAA==
X-Change-ID: 20241201-sysfs-const-bin_attr-acpi-be28e6d66a2a
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166249; l=866;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=n1oVtaxO6zoj5Nfd+PLAsf4IlOLtQpIGsAupGPgoIEg=;
 b=dwu83tM9Akmh12pE0eqjoa2Fo03j95/KHBqRkxEDuPRCnGFGOWaHpNoPwG4v8Jir0rcF2CBus
 /EoubLSwsxPAIeE9lIso4y93TAlkMCX7Eb4yYEVxAMENfGcYpr0MUwG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

The usage of read_new/write_new/bin_attrs_new is a transition mechanism
and will be reverted after the transition is complete.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      ACPI: BGRT: Mark bin_attribute as __ro_after_init
      ACPI: BGRT: Constify 'struct bin_attribute'
      ACPI: sysfs: Constify 'struct bin_attribute'

 drivers/acpi/bgrt.c  | 6 +++---
 drivers/acpi/sysfs.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)
---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241201-sysfs-const-bin_attr-acpi-be28e6d66a2a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


