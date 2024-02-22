Return-Path: <linux-acpi+bounces-3869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73528602B4
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 20:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA1CBB245B7
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF99137922;
	Thu, 22 Feb 2024 18:52:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F514B808
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627972; cv=none; b=p7kXSvbcDh5OrTlHydwet3F0uidGa9Jq/RpNBjdvIUFQsvMGnxLnLkAIvVcrgcK/Tfko9nQU3jGinMNpolg0BDyukIEIPV0KqobZlwS8lrz5MMw+kMxd+U4EuMHrzgk/zvqOY7crUgxrQWR2Gw8Zx2Mo+93qJhv8ZOrQawS+Zrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627972; c=relaxed/simple;
	bh=U/wbPr3+llCZADBMK4n5ZGIFCnBeMwKOEwcH7g+SQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UYNyuMnCJWLmkDO7mQyWsWfE2o7+eicJD7PJ7nvBrQf+qm42N/XEvd4sHqVfcm5nECyYhU8AeYbl1N3ctPxiOifzFurxD8XZX1CM0bkksc82ACWewgFW5IjR3XdMTKpNop6KiZ8CTd5jMsotcm2uxhHVP86zBn5q47V8EWwJT74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBc-0003OK-Os; Thu, 22 Feb 2024 19:52:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBZ-002HYe-Qb; Thu, 22 Feb 2024 19:52:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rdEBZ-009dAF-2M;
	Thu, 22 Feb 2024 19:52:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	kernel@pengutronix.de,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/7] ACPI: Convert to platform remove callback returning void
Date: Thu, 22 Feb 2024 19:52:32 +0100
Message-ID: <cover.1708627599.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=U/wbPr3+llCZADBMK4n5ZGIFCnBeMwKOEwcH7g+SQiA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl15fy+F3kRVlCRszRfuuzTmYJ/h0cD/uGnw/8M J5UUxVxvTyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZdeX8gAKCRCPgPtYfRL+ ToZ5B/90cJBQ1a1M0RjTsY2xAF2BLUe45z57G6Y2lNr526NpVE0Qytw6olBUK4ON+/oeBuQeWym i7giAESWKHXKyudK5ax13hDjLJsTaUTceiVh3s5NIX5msldUgymTU7KnOjqyP96gInn7C+7ZFtC ECb4+ULvFdyev8M5YO0D00eY2Lw30vEps3DEvdWlZ6n2slA/fbtVuDvG3kycG+hJpnYydKSyTFr 27llXZNaf//Z1HwT1HxMHvmqDqZ7/Q0oHQR6JlDN0/bd+ZldnSuVs6VInOEUbICRj6ifjQv0wHg mt8IQzCJWGkfbyTuMCOsHp75Bi196lyZ8euA1Fs3wJAgzZTe
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

Hello,

this series converts all drivers below drivers/acpi to struct
platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value") for an extended
explanation and the eventual goal.

All conversations are trivial, because their .remove() callbacks
returned zero unconditionally.

There are no interdependencies between these patches, so they could be
picked up individually. But I'd hope that they get picked up all
together by Rafael.

There is another driver that needs adaption (as of today's next), but
this is discussed separately, see
https://lore.kernel.org/linux-acpi/CAJZ5v0jJX-6L9f_TLe-cv2MNnZVK7au=drbKCn-tEWEagY-9ZA@mail.gmail.com
.

Best regards
Uwe

Uwe Kleine-König (7):
  ACPI: TAD: Convert to platform remove callback returning void
  ACPI: AGDI: Convert to platform remove callback returning void
  ACPI: DPTF: Convert to platform remove callback returning void
  ACPI: GED: Convert to platform remove callback returning void
  ACPI: fan: Convert to platform remove callback returning void
  ACPI: pfr_telemetry: Convert to platform remove callback returning void
  ACPI: pfr_update: Convert to platform remove callback returning void

 drivers/acpi/acpi_tad.c           | 5 ++---
 drivers/acpi/arm64/agdi.c         | 8 +++-----
 drivers/acpi/dptf/dptf_pch_fivr.c | 6 ++----
 drivers/acpi/dptf/dptf_power.c    | 6 ++----
 drivers/acpi/evged.c              | 5 ++---
 drivers/acpi/fan_core.c           | 6 ++----
 drivers/acpi/pfr_telemetry.c      | 6 ++----
 drivers/acpi/pfr_update.c         | 6 ++----
 8 files changed, 17 insertions(+), 31 deletions(-)

base-commit: 4893c639cc3659cefaa675bf1e59f4e7571afb5c
-- 
2.43.0


