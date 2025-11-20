Return-Path: <linux-acpi+bounces-19165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA9C75754
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9D6543662F2
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Nov 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7A733F396;
	Thu, 20 Nov 2025 16:33:40 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D72EB85E
	for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2025 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656419; cv=none; b=krZLXYWtkzUFzQeTJjLE8dmaMktkuI24xZqCZDdm98NsQpQPLaQGl9PJ76Ym49LbYkVfZkWQJ0UXZaotXmxSXqZTptE8U8g9ARX1uHbhgvzOVBY2PUF7r/LA1daBH8JU6hHVehoOwpPCLZKwah6G/Ccez3vXl9+NDYLbiWIU34U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656419; c=relaxed/simple;
	bh=BymrWDzm1aaf+ik9dAyehkuDPweXjS+gzZgWHshEw34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QrPH6UlLCo6rW1swEANOC5omLkO1BpKXenFyI90xfJPj/LuDflY28pYDBpWo1z4LiUxW+ts48Q21nZYu44tNm4/O54PanozXzU3EznsLzxloWcHKGzog6pEnWxWDMy14jTV10yaD5ODehfttDgdwGja/aDPt+8ub7+NhlTFl+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vM7av-0004dB-QA; Thu, 20 Nov 2025 17:33:17 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
To: soc@kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [GIT PULL] Reset/GPIO/swnode changes for v6.19
Date: Thu, 20 Nov 2025 17:32:52 +0100
Message-ID: <20251120163252.34760-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-acpi@vger.kernel.org

Dear arm-soc maintainers,

The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  https://git.pengutronix.de/git/pza/linux.git tags/reset-gpio-for-v6.19

for you to fetch changes up to 5fc4e4cf7a2268b5f73700fd1e8d02159f2417d8:

  reset: gpio: use software nodes to setup the GPIO lookup (2025-11-20 16:51:49 +0100)

This tag is separated from reset-for-v6.19 because it may also be merged
into the driver core, GPIO or SPI trees, if needed.
It contains a single series [1] with changes to swnode, gpio, and reset
code.
It is based on v6.18-rc5, which includes the prerequisite commit
e5d527be7e69 ("gpio: swnode: don't use the swnode's name as the key for
GPIO lookup").

[1] https://lore.kernel.org/all/20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org/

----------------------------------------------------------------
Reset/GPIO/swnode changes for v6.19

* Extend software node implementation, allowing its properties to reference
  existing firmware nodes.
* Update the GPIO property interface to use reworked swnode macros.
* Rework reset-gpio code to use GPIO lookup via swnode.
* Fix spi-cs42l43 driver to work with swnode changes.

----------------------------------------------------------------
Bartosz Golaszewski (8):
      software node: read the reference args via the fwnode API
      software node: increase the reference of the swnode by its fwnode
      software node: allow referencing firmware nodes
      gpio: swnode: allow referencing GPIO chips by firmware nodes
      reset: order includes alphabetically in reset/core.c
      reset: make the provider of reset-gpios the parent of the reset device
      reset: gpio: convert the driver to using the auxiliary bus
      reset: gpio: use software nodes to setup the GPIO lookup

Charles Keepax (1):
      spi: cs42l43: Use actual ACPI firmware node for chip selects

 drivers/base/swnode.c         |  30 +++++++--
 drivers/gpio/gpiolib-swnode.c |   3 +-
 drivers/reset/Kconfig         |   1 +
 drivers/reset/core.c          | 146 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 drivers/spi/spi-cs42l43.c     |  40 +++---------
 include/linux/property.h      |  13 +++-
 7 files changed, 141 insertions(+), 111 deletions(-)

