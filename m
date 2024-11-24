Return-Path: <linux-acpi+bounces-9769-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81D9D6F0F
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 14:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F1CB23DFF
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Nov 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D81B0F39;
	Sun, 24 Nov 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqTm90za"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F91B0F31;
	Sun, 24 Nov 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452328; cv=none; b=Pidalg/c4Yv7d86CJVL45B5XBMGOWTvu5OCPolfWu4GvAz246GoV+E54hAm27yMWIXIHTdvfnL0ccXicV8YQeTSnUk2kdMtpvu2SDyGnJJ8hQ0McpVFe0tjFq1k2wFSjn+V6ermyeevg1x51ChvvlhzbBMRXsV4NRYvEuIeB+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452328; c=relaxed/simple;
	bh=JARJ7MlqaJlJzU7OrtcD3lfGrOAaDkKG7o7NIu4VXnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh2dRI7uTfmp9vl9/WfpL6eqnawt6C8EL4+aWTB6wsUbpYiDLSND0x7ywOypf53Zi7cAEPZTowx8dCBVwdYRBj0fiz2FG7lBcPrin1KXmh+WulxVvc3skZA7q+nNL/9jVtCXESigwRdBHX8pniR+CyVcByf5TkCVkyRpSLpu5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqTm90za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E8C4CED8;
	Sun, 24 Nov 2024 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452328;
	bh=JARJ7MlqaJlJzU7OrtcD3lfGrOAaDkKG7o7NIu4VXnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqTm90zayKhTlgydAMN9M8q52VQf72nzVUnXvZ6irmnjHSFPnHTfRNlmeKGIg0Yy3
	 yOP+Rxw7NpRO25GjtlBvXOYF4W0dKzjSQBKGjGkQe8ly0mplQ1i8OYrT7Lm2Tg9GkY
	 OuuPODudDR/NrRHX7V0vTka1+UV46Wk8oq/yms9UZtIjhrmz03UcuK43InRfFv8tGz
	 i+H4LJYl5mwU788/mTCEfjrOZuyGDojr8C7fPpo+AHzJGo7Q/BgCZ0iczr6t1mbG+6
	 cs+OWE9K3wqDwjfTIyFjkZ+nNbdsCa4xumNxF5MjIFsWT3yvs4ClJ/pXitRICHLygU
	 gctIm+KKjGx+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonathan Denose <jdenose@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 6/6] ACPI: video: force native for Apple MacbookPro11,2 and Air7,2
Date: Sun, 24 Nov 2024 07:45:11 -0500
Message-ID: <20241124124516.3337485-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124516.3337485-1-sashal@kernel.org>
References: <20241124124516.3337485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Jonathan Denose <jdenose@google.com>

[ Upstream commit 295991836b23c12ddb447f7f583a17fd3616ad7d ]

There is a bug in the Macbook Pro 11,2 and Air 7,2 firmware similar to
what is described in:

commit 7dc918daaf29 ("ACPI: video: force native for Apple MacbookPro9,2")

This bug causes their backlights not to come back after resume.

Add DMI quirks to select the working native Intel firmware interface
such that the backlght comes back on after resume.

Signed-off-by: Jonathan Denose <jdenose@google.com>
Link: https://patch.msgid.link/20241112222516.1.I7fa78e6acbbed56ed5677f5e2dacc098a269d955@changeid
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 015bd8e66c1cf..d507d5e084354 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -549,6 +549,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Air 7,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir7,2"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Apple MacBook Air 9,1 */
@@ -565,6 +573,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Apple MacBook Pro 11,2 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,2"),
+		},
+	},
 	{
 	 /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
 	 .callback = video_detect_force_native,
-- 
2.43.0


