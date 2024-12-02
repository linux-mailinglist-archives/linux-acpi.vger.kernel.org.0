Return-Path: <linux-acpi+bounces-9888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CE9E0BB5
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 20:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2EB164455
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Dec 2024 19:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A31DEFE4;
	Mon,  2 Dec 2024 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="p5ZdpFJd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB11D958E;
	Mon,  2 Dec 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166253; cv=none; b=kBI7Vk2D+TBDivsTfczw/BpYb++W96tRUaNcPbDPFDrnm+UUoyLTAgcvj+cx23oLMfNf2HHmCy3W4eymqCnF5BQnqsAlaNTIOvi2pjYDUvLklsQc4ptxcm6ak5xl3yDKxoKX2pf1XImWXUHSFTuAOBjmm+RHaXSq01tClpw9z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166253; c=relaxed/simple;
	bh=s/bcJ0LBtQNLQMlmnLBuTDfzYiYUoVgtb9Rx7FMamO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OC9a/EqhOx7/1XMOdisQ0qisvmv5UPBeGXl/djpb7hMb6U2oiCsdMx240hYphDl9PQJYyfiiM8VPMFsstjp1LAVQ6GzvxEn4xb8VNtzKuxT8lNHg2Cy2L8+Biy4om7KUD2pc7OaTQUpQdtUKEYniU7Y7gRMyXlOpvessPdFYKAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=p5ZdpFJd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733166250;
	bh=s/bcJ0LBtQNLQMlmnLBuTDfzYiYUoVgtb9Rx7FMamO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p5ZdpFJdICUgCyVgmKl+X6L/gPNoWiIXmQwZaFL+00pHwGvBXfmvQL652ic3dehBi
	 O9MJ1jxDI4k8uP1wEmO3m7Ap1XDQbEjKEBhKY5lMGOtMdIX0pQAt/JuEUxlTGcTqfR
	 GdAutSxhP//Z8VUFIJuoqsR7gk6JGJ/7k3Jbr0ak=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:04:09 +0100
Subject: [PATCH 1/3] ACPI: BGRT: Mark bin_attribute as __ro_after_init
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-acpi-v1-1-78f3b38d350d@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-acpi-v1-0-78f3b38d350d@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733166249; l=785;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=s/bcJ0LBtQNLQMlmnLBuTDfzYiYUoVgtb9Rx7FMamO4=;
 b=z4KHS12m9aEwQCmu78SR62Wvv+3TxbEzyQ5lbDOsS/X6FE+tn8y/Dc3wMvahxUTjF18EHmQAj
 klaI/d4DPSrCr4ZcDBMWM7RbhtHnFTifppDMdG9FUytVs4Xc1M7Wxbo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The attribute is only modified during __init phase.
Protect it against accidental or intentional modifications afterwards.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/bgrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index d1d9c9289087a1ca6b36e8497cb104bad3282737..88837c291a7630416f0ae3854d6d1a733a590961 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -29,7 +29,7 @@ BGRT_SHOW(type, image_type);
 BGRT_SHOW(xoffset, image_offset_x);
 BGRT_SHOW(yoffset, image_offset_y);
 
-static BIN_ATTR_SIMPLE_RO(image);
+static __ro_after_init BIN_ATTR_SIMPLE_RO(image);
 
 static struct attribute *bgrt_attributes[] = {
 	&bgrt_attr_version.attr,

-- 
2.47.1


