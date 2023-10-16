Return-Path: <linux-acpi+bounces-663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B67CAFFF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526A7B20CEE
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBD30F8D
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="qyJf0KUj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B962377B
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 16:08:35 +0000 (UTC)
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D75383;
	Mon, 16 Oct 2023 09:08:33 -0700 (PDT)
Received: from wse.fritz.box (p5b164245.dip0.t-ipconnect.de [91.22.66.69])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id C8D652FC0050;
	Mon, 16 Oct 2023 18:08:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1697472511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9laGN8nx+5K/7owT3MoEsNTBX2h0faxTTb42nHSwAi4=;
	b=qyJf0KUj/unaYyC5JVe1P8y1Y21HUrca0jilenDhMjPoBtJ5F1RxEwjz3ze4Knrc3ExOif
	O4FM+wvNturJhRhkg/UHgn7c8FkuDezvsqs4uDTEUTKkHLUdt+RAzfH3lxSCk/Bt9CdpDU
	ZYAjZXb9sgxZWwOKUe8Bd5Pw4L2E5Ck=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GMxXGxx
Date: Mon, 16 Oct 2023 18:08:28 +0200
Message-Id: <20231016160828.373599-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
for the keyboard to work. Adding an entry for this laptop to the
override_table makes the internal keyboard functional.

v2: Rebase onto linux-next

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 18f6353c142e..15a3bdbd0755 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -497,6 +497,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
 		},
 	},
+	{
+		/* TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
+		},
+	},
+	{
+		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
+		},
+	},
 	{
 		/* MAINGEAR Vector Pro 2 15 */
 		.matches = {
-- 
2.34.1


