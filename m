Return-Path: <linux-acpi+bounces-15547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE7B1C9A0
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCF8625E4E
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Aug 2025 16:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA374299AB1;
	Wed,  6 Aug 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="XAjsJpb1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A9299AA0
	for <linux-acpi@vger.kernel.org>; Wed,  6 Aug 2025 16:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754496838; cv=none; b=DFTQVIJ/8rU6dQ4HopJofeDumJocInaMULjMx7eQmPxJhGaPlRb0dgVEcKYSlp501WiNDAqyL85tEr+vggIGKaqiTYHwGI2VFkwqKcQ14pjmEq/uUqQomD9QOqIlkyBhPM8wIX+QqDq9J64LrFFEmapIPOX5d3M04dONw4od8Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754496838; c=relaxed/simple;
	bh=6ISx/nw3+eOU66AbHs7u3iNQmuaQbReknNmnLszrGhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ChO+8qJIcdQv5P5CZtU3UEJ4PQwmEtv0uBgHWlwiyIZxBilzhRx5d9ygKdHVQ7TuTJBTrdXBgMeq++j4yrRVHqNeMSivcXEciSafR/5ipWXkVnrPpk2cmGLqWvu7jBzTMY2E0AOD/qyCco9QYkQ5PyEbS7FmxY//UqiLrHBQgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=XAjsJpb1; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:384c:0:640:64ee:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id D4ADF80601;
	Wed, 06 Aug 2025 19:13:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id iDkRkoZNA4Y0-dXQ0zFAK;
	Wed, 06 Aug 2025 19:13:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1754496826; bh=X+v/n9rLerBM2RmlNzlMSZsG8oTEMlbl7bgj1hgRlno=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=XAjsJpb1WmOITWC9sW5dpJLnHHrI4yTCtNlMxN/WbW0O3O/A0OAer3YisJt6hjN70
	 DyS3Elis5HXTVYAGr9Brs/YRojphEx6mS+uZYBO5Guaxx9nDn0GWLITPL4rZGxOlql
	 eXiB9egVtYSuQYWncYTkcdDcNAk6frYLKV7oXiQI=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Niyas Sait <niyas.sait@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] ACPICA: fix largest possible resource descriptor index
Date: Wed,  6 Aug 2025 19:13:01 +0300
Message-ID: <20250806161301.233242-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI_RESOURCE_NAME_LARGE_MAX should be equal to the last actually
used resource descriptor index (ACPI_RESOURCE_NAME_CLOCK_INPUT).
Otherwise 'resource_index' in 'acpi_ut_validate_resource()' may be
clamped incorrectly and resulting value may issue an out-of-bounds
access for 'acpi_gbl_resource_types' array. Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 520d4a0ee5b6 ("ACPICA: add support for ClockInput resource (v6.5)")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/acpi/acpica/aclocal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 0c41f0097e8d..f98640086f4e 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1141,7 +1141,7 @@ struct acpi_port_info {
 #define ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION   0x91
 #define ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG     0x92
 #define ACPI_RESOURCE_NAME_CLOCK_INPUT          0x93
-#define ACPI_RESOURCE_NAME_LARGE_MAX            0x94
+#define ACPI_RESOURCE_NAME_LARGE_MAX            0x93
 
 /*****************************************************************************
  *
-- 
2.50.1


