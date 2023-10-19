Return-Path: <linux-acpi+bounces-762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A94D7D01EB
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 20:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E89B212E0
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A9F39845
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Oct 2023 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JksnQeSf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E1335A7
	for <linux-acpi@vger.kernel.org>; Thu, 19 Oct 2023 17:35:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685DC106;
	Thu, 19 Oct 2023 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736905; x=1729272905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gBdBqK0lr5M7oMLjhnyfiZtfTMF/bpomSSs0LTiNgSs=;
  b=JksnQeSfy+KRhHPNCOC6a27QyhSac0gmNtntkm8qAS7C+I59vRe+YoNR
   YdD/HaR9iDAqpcMGUDeVtk+s1scWOdyM24EFAKvrGwHxc70UlwSQV7lZ5
   UbIwpD8gIzBTypgN8yWGEtEniAdQ2prdI7q55JUdHKC16lrDgt1Bf6kJk
   uoneM9plqNxoH/QgUTUPGnkQDvdPsADxuYf0T0Rm2zMdJaR9KB+/m+Ej5
   tejhg9uAgIbbJD5ElF4YOTgOgL/kDmi4a/Zq+coCqchu+1NGHV3eYp2A8
   zyRnBAxv45YqBgNPcdRzM7i/nrGJkh7AUUjCtelRQbESs8zxldXXPfFa/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389184242"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389184242"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760723565"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760723565"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 19 Oct 2023 10:35:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3162E17D; Thu, 19 Oct 2023 20:35:00 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v1 0/3] gpiolib: acpi: More fixes to the consolidation rework
Date: Thu, 19 Oct 2023 20:34:54 +0300
Message-Id: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On top what Hans already fixed, Ferry reported a few bugs that pointed
out to the same consolidation rework done in v6.2.

The first is most serious issue, that needs to be fixed ASAP.

The second is good to have.

And the third one I'm not fully okay with, so open for advice on
how to improve.

Note, that long list of parameters to a _find_gpio() functions
can be hidden in the specifically crafted a new data structure,
but this is out of scope of the _fixes_ series. I'm all ears as
well for that one.

Andy Shevchenko (3):
  gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()
  gpiolib: Fix debug messaging in gpiod_find_and_request()
  gpiolib: Make debug messages in gpiod_find_by_fwnode() less confusing

 drivers/gpio/gpiolib-acpi.c   | 10 ++++-----
 drivers/gpio/gpiolib-acpi.h   | 13 ++++++------
 drivers/gpio/gpiolib-of.c     | 13 ++++++------
 drivers/gpio/gpiolib-of.h     |  8 ++++----
 drivers/gpio/gpiolib-swnode.c |  4 ++--
 drivers/gpio/gpiolib-swnode.h |  1 +
 drivers/gpio/gpiolib.c        | 38 ++++++++++++++++++++---------------
 7 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.40.0.1.gaa8946217a0b


