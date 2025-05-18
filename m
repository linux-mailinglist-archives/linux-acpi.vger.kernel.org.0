Return-Path: <linux-acpi+bounces-13779-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB67ABAF43
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591E218994A9
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110C72135B8;
	Sun, 18 May 2025 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC7lH3X8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D30212B1E;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747563521; cv=none; b=bq6nzyNMI/YZslzvPeXeeYDW/jNx8KaNJrNrYDPTZTK6U/ecOJwdFtBcQBYDR9DDtTpn2lKT/Vdd4FzCekbliwRd9xsvmRLZfVMWhyXVcf+0veknGHLpS1DcUdsvg9tgSXAOq2IGIQRetcaDou4b4tV3BMxZmVsVhacdXspQHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747563521; c=relaxed/simple;
	bh=3bpWePsE3/8Eyz1vaUmT1v61DH/LDZGGR7WSY5sci1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npu5q2pZh6SGPkIzPwVDHxSLWzFcwuM/K0OlsUKyugq4O+oDYktuOLYzZ/F9T9GXgPa+XY0+8cYHp8o+RpkMjP4XIvisgedpc0VgZJSWP+QMQtzqIF1LYDqcfXACaxRuDFHvZotu12wePSdh9ee9t3ZmBSWGBNir80Uv7aEeNmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC7lH3X8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 640A6C4CEE9;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747563521;
	bh=3bpWePsE3/8Eyz1vaUmT1v61DH/LDZGGR7WSY5sci1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oC7lH3X8rVJseb0ZvcrL2bK9WvUfQslKri0aARhMV+5VoSRHEY2gaPBHKWGgcUPBb
	 C3ubdSplrdPEo1qRndvoToJlp2I5UhPu/tpU3wuvyt7M31z/e/CaE2cUOhP53nWe6k
	 2G69Md1nJWxICfPuMbEwrgF0gi+tWYK/OcmSq6hCM8t5sGbRxUAnx87OaKvlx9utAB
	 yiktpWW4lo+oF7OxGwrVNWsViH4m9Iit0cjg15u0Tuig40tqsuG4uyot40fzgz3NV9
	 vJbhN2PcyFC9HPfKGtSriHyvbSYPnMEgFSuJPhpsU1nzcfXkrO+DQoWvO2VMLDI4sx
	 pWIeHi4N+nS5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB5C3ABC9;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 18 May 2025 12:18:38 +0200
Subject: [PATCH 2/2] HID: lenovo: Remove CONFIG_ACPI dependency
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-hid_lenovo_acpi_dependency-v1-2-afdb93b5d1a6@jannau.net>
References: <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
In-Reply-To: <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=bo27DdOTnOoQpDLRJMS1oIMxCFrEhqBgkKEdS+8giu4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhgzNLQyts6/cn2c7q3CmUPq6uJoXXNkbxIX3eQSc0Z9eN
 e985vrCjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABOpbGT4H3TL9sD882cqd2nN
 mev9+03S9PYF317PPXVpabnF16OpE00Y/kpvWfjl6syyfxtOnGldsen6306L6Q+tnC88/H2nw+9
 +6XxuAA==
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

With platform_profile_cycle() stubbed the dependency on CONFIG_ACPI can
be relaxed to `ACPI || !ACPI` and CONFIG_ACPI_PLATFORM_PROFILE is only
selected if ACPI is enabled.
Cycling through platform profiles is only functional with ACPI but that
should not be an issue as it only used on a detachable keyboard of a x86
tablet with a special connector.

Fixes: 52572cde8b4a4 ("HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/hid/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a503252702b7b43c332a12b14bc8b23b83e9f028..984f7bd235141f21e018b51f97546ec9d00324e8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -595,8 +595,8 @@ config HID_LED
 
 config HID_LENOVO
 	tristate "Lenovo / Thinkpad devices"
-	depends on ACPI
-	select ACPI_PLATFORM_PROFILE
+	depends on ACPI || !ACPI
+	select ACPI_PLATFORM_PROFILE if ACPI
 	select NEW_LEDS
 	select LEDS_CLASS
 	help

-- 
2.49.0



