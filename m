Return-Path: <linux-acpi+bounces-6049-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035ED8D1895
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 12:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54FFEB247A1
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AD16B734;
	Tue, 28 May 2024 10:27:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2016B729
	for <linux-acpi@vger.kernel.org>; Tue, 28 May 2024 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892043; cv=none; b=fl/7nuHGCOZO5ypOh3mfNGcgS9MAT/4popjbCgd5Cbg89REXK4kUl4456kKMRpStvEoKAKf2elfsu0oj8/bXdqCPGEJKSaGYTN4Mr4c48nFJHQ4vXbUksJ/ayktldZ1sFZ4hFHME85Airl/uo4MFm0I7fXxCxxSB/ZZbd2u0zMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892043; c=relaxed/simple;
	bh=N9amqOCoV3GG88T8bdtY3NbClGQO4HdYR4FDOKVBIHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVbhPul02cpnpUiDFy6UGHvt1/Sc5hrQC5R89Z6xVp7lhx/EhdqSOzEFXqlDQ9/k0/6HDykEJo2vVPAEys8dnnD+atf0e4s1zgO6olgCj4S2VS0xdsktbo9VQxlPDY3/Evdm7sofEYCbR03nDWuWrd0s18At21mGj4niPqURyiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id dbde0bab-1cdc-11ef-8e2a-005056bdf889;
	Tue, 28 May 2024 13:27:18 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/2] PNP: Fix handling of pnp_bus_type
Date: Tue, 28 May 2024 13:25:01 +0300
Message-ID: <20240528102708.1451343-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a fix for recently introduced dev_is_pnp() that involves pnp_bus_type
and one improvement to hide that variable from the wider audience for good.

In v2:
- reworked patch 1 as suggested by Christoph
- added a new patch to make less possibilities for (ab)using pnp_bus_type

Andy Shevchenko (2):
  PNP: Make dev_is_pnp() to be a function and export it for modules
  PNP: Hide pnp_bus_type from the non-PNP code

 drivers/pnp/base.h   | 1 +
 drivers/pnp/driver.c | 6 ++++++
 include/linux/pnp.h  | 6 ++----
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.45.1


