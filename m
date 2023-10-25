Return-Path: <linux-acpi+bounces-980-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A717D75BA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9223A281BB9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B4434188
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DyWMReTT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5D14F8D
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 18:51:35 +0000 (UTC)
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 11:51:34 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A46111
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 11:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698259895; x=1729795895;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tyuad4CLXZh+vdA2dSWx/kiizQs1zXdiTr0LZZF2EVE=;
  b=DyWMReTTKvqI8P1WW2NiLhdMYB6LNcGnCn0Fqmnv75d/4RuVIsmbzUzQ
   /a1QD27EX7sBkvOaqSUcUR8qeJljxCiuVfe5Z/P+wikB4zi6J1+9zBIdI
   JQUNbvTEFELxJMFBSq9XXle6rC6yw6saRnzY4NzHd9TpUVEBAYLUvKC5N
   6xqCVdPSGVjNKD/NZCP5d8nfRy89T2bxq+XxU1hYQzLBOWa9bma6ddyNl
   HkoNKY7GxnX6hpRmxzjKI8C2PLiBUpO/Imtt6eRnP8Yx0fmbNKXJ0UZb5
   Owwkmb5qMzm4lGNYGzmvZUt87qeSpAD0bQ8CYMuh4asAYrX94pbnLfSkT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="176167"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="176167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902642575"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902642575"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2023 11:48:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C8283125; Wed, 25 Oct 2023 21:43:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v1 0/3] gpio: mmio: Make driver agnostic
Date: Wed, 25 Oct 2023 21:42:56 +0300
Message-Id: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver uses so far some OF APIs when generic fwnode ones can be used.
Replace these APIs accordingly. Note, this will help to clean up OF
headers even more.

Andy Shevchenko (3):
  device property: Implement device_is_big_endian()
  gpio: mmio: Make use of device properties
  gpio: mmio: Clean up headers

 drivers/gpio/gpio-mmio.c | 53 +++++++++++++++-------------------------
 include/linux/property.h | 26 ++++++++++++++++++++
 2 files changed, 46 insertions(+), 33 deletions(-)

-- 
2.40.0.1.gaa8946217a0b


