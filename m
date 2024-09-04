Return-Path: <linux-acpi+bounces-8135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105B96B289
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 09:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E42A2820CF
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Sep 2024 07:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C0146D5A;
	Wed,  4 Sep 2024 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OoE81LeU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B7146A86;
	Wed,  4 Sep 2024 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433990; cv=none; b=uSuwDwC55ix5OduE7oqV6GcaeUKIMT2T2KbjmfqvKMs4/BnoIljUT0Yn9ksA8Tx4fK1yeX3HM6r40uH7sOCIiKcDgxz2MiY/FvgJG753gzeaNf0yMUnagT9gOPOtqh+q7+RX6M7shL5LTNvXR/3QVyXZ8ZXwmPvkdze+C6+Dm0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433990; c=relaxed/simple;
	bh=wkA1Ag1bZ5p18BJ58kweeNOw7CQlEmrZboPv4f9bCUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lMXOvDIG0Z2yXtza+YGVfu1O7nluaCb5/gYQmgEbf1tLvZCBK3a1V6BNRR6ijQOzp/GG1eFW9i90qHkdy9QpAmYi3vpcHH0/w3Iayg53RzS4PxogNV75Jtd9iyqsGwqji+kY5kiS9bfzWhH+dAWf9Uqw9xRJl5iu9SEbDSrS5eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OoE81LeU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1725433984;
	bh=wkA1Ag1bZ5p18BJ58kweeNOw7CQlEmrZboPv4f9bCUw=;
	h=From:Subject:Date:To:Cc:From;
	b=OoE81LeUdOWp+1XU9os7LbbVL1dk6/9AP5R6JYpvAId49eitldTYETlt4DneF3rVR
	 N6fV+P8f6d3znBh9eX/nQuZAlrMjuB4qWJR1WqyvF/Y7qO1wXtkvUwWfNXLAk6DMUd
	 tMxtdl46iWd/V9zUSuhrfY6SPARl7dB20PKp6CYs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/5] ACPI: battery: various cleanups
Date: Wed, 04 Sep 2024 09:12:51 +0200
Message-Id: <20240904-acpi-battery-cleanups-v1-0-a3bf74f22d40@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHMI2GYC/x3MQQ5AMBBA0avIrE0y6EJdRSzaGkwi1bQIEXfXW
 L7F/w8kjsIJuuKByKck2XxGVRbgFuNnRhmzoaZakSaFxgVBa/ad441uZeOPkFC3mho7KWVHgty
 GyJNc/7cf3vcDtDJ0qWcAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725433984; l=689;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wkA1Ag1bZ5p18BJ58kweeNOw7CQlEmrZboPv4f9bCUw=;
 b=3JhgsFHkxMA+9POHbXXv9PApqxoXBHemz9Qc7NpMGAXt6d+xxJJ1xCiOaPLBEyOdmkb2UTS5a
 7fzp1J8tGHZDtkLnnowZqXiZYn7hAohxac2v9lUlVbFONvzWDzfauEK
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (5):
      ACPI: battery: check result of register_pm_notifier()
      ACPI: battery: allocate driver data through devm_ APIs
      ACPI: battery: initialize mutexes through devm_ APIs
      ACPI: battery: use DEFINE_SIMPLE_DEV_PM_OPS
      ACPI: battery: install notify handler through ACPI core

 drivers/acpi/battery.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)
---
base-commit: 88fac17500f4ea49c7bac136cf1b27e7b9980075
change-id: 20240904-acpi-battery-cleanups-98903bf44bd0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


