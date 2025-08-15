Return-Path: <linux-acpi+bounces-15728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82412B27C1D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F3E17441E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95C2F60A9;
	Fri, 15 Aug 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulM83OMw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B82F49E1;
	Fri, 15 Aug 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248200; cv=none; b=RsIM0rcCRedm0OoeUkZzjSUPe+bgfn4l6t9/qUuQdg4qnn8TOcF6o0OcOkYXRbfRuQa2sAkdo0K1gIksaPs+GRWhxMygvVh0esiIvG7t9ReAyBHUVl8pbuy5/CBTIXb90QTO/PhqYx7VNj3/TrUcdVppPb3ht5sz7/GU2Emfdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248200; c=relaxed/simple;
	bh=8s1RWUEDTVGm4h3m+AVbG9qZVr/HNG9Xzjq84v8RjyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l25Xh8cm3VdGgaKpNGLQTpiKiZjVbr9LiHhMOuSCSj4xRFK0zRRqA+0qZ1gCv8BsYkgV+2+LqQ3l0tIAC8a70PJuNr5jBB2czMaVRu8ckpytXHV2hPlKCVTaCQgCr0EchbsXBqg5RVqTkVTdK5GOxE3Md//jbiE+sK+VV/jj9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulM83OMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43FC4C4CEF4;
	Fri, 15 Aug 2025 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755248200;
	bh=8s1RWUEDTVGm4h3m+AVbG9qZVr/HNG9Xzjq84v8RjyU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ulM83OMwAIfYozyuCs4JKqkxIIVJsEiGNQPZ5reZgflsmG4WPfsvP0PU8KsqlErYI
	 eRV19Wah6hUai3XZuxyKZcW7OxNawP4oKfrZFSnsz3Gq2k3RJj04NG+pfl38vs6PKi
	 M3QuezB8YRiTIpOZp6+7n+31d03ac+XCq7fujvrN/KQAn8iix9d6jxDDlWEnmoXVUJ
	 olPVAUtEHj3F9wpB5hfHEAd5FtgMfg0QEIbTxi9Pszsahotx/s5qO4DKHln6l5Afbv
	 +SOgdkjP1VhmOjiX+hkywLFVOWsEC4/chvSHQSfbouRpKGVAjfEmv1ye8wZVr+uldo
	 zbQc5x4OOfc7A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314F1CA0EE4;
	Fri, 15 Aug 2025 08:56:40 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Fri, 15 Aug 2025 16:56:39 +0800
Subject: [PATCH] ACPICA: add more parameter validation for
 acpi_walk_namespace()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-acpi_fix-v1-1-a05ebfe1b8ac@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAEb2nmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0NT3cTkgsz4tMwKXWNzI5NUs2STlEQDIyWg8oKiVKAw2Kjo2NpaAKq
 N1oJaAAAA
X-Change-ID: 20250815-acpi_fix-3724e6c4da02
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, wangyuli@uniontech.com, 
 guanwentao@uniontech.com, niecheng1@uniontech.com, zhanjun@uniontech.com, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248199; l=1219;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=TsnirmhdVe95wU+g+49Bvoj0s1Au2GOZZ9diwqQO6Lc=;
 b=sdZiZROQGQifna8Wfyn1Q9udujXPJBP3+KY88fRSul/V+zzMEqmEK6+0L2CgrbIC0AD/2g8sL
 fRoZUvajx4oCPt7xrDmguQSeIxaJutZUblGtKdK3xHjwupTMI6Yzr3C
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

On the Honor FMB-P-PCB laptop, an incorrect ACPI table causes
sdw_intel_acpi_scan to pass a NULL pointer as start_object to
acpi_walk_namespace() when calling it, which eventually causes the
kernel to report a NULL pointer dereference[1].

1. https://gist.github.com/Cryolitia/a860ffc97437dcd2cd988371d5b73ed7

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 drivers/acpi/acpica/nsxfeval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/nsxfeval.c b/drivers/acpi/acpica/nsxfeval.c
index f9d059647cc52e94ce013af3382addba338820e8..c1f318ea7d5fcd846dc158b155286a6f5bba4cff 100644
--- a/drivers/acpi/acpica/nsxfeval.c
+++ b/drivers/acpi/acpica/nsxfeval.c
@@ -564,7 +564,7 @@ acpi_walk_namespace(acpi_object_type type,
 
 	/* Parameter validation */
 
-	if ((type > ACPI_TYPE_LOCAL_MAX) ||
+	if ((type > ACPI_TYPE_LOCAL_MAX) || (start_object == NULL) ||
 	    (!max_depth) || (!descending_callback && !ascending_callback)) {
 		return_ACPI_STATUS(AE_BAD_PARAMETER);
 	}

---
base-commit: 24ea63ea387714634813359e2c8e0e6c36952f73
change-id: 20250815-acpi_fix-3724e6c4da02

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



