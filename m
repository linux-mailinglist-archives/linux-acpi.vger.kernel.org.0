Return-Path: <linux-acpi+bounces-9958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5349E5FB3
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31CC21885618
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 20:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF371C8FB5;
	Thu,  5 Dec 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jrK2HXrI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B31B4F3F;
	Thu,  5 Dec 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431651; cv=none; b=pFTf3eaI8wzhNSayZGmpZ1rCi66t1zD/iU84I7mPxA7tasvrFbvKTE5Vjeril9xJpNcpzrSzjeefWMjtFhadWPoCrUcBSjqwhICIlHJzRLFwUojiOQiPcWFrK79SEgk2aJDJJaycOjO2vnPz1+3w+QMSeNGlL13qvM8UpdkEm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431651; c=relaxed/simple;
	bh=b1zTW6DElMsDViBpZSCu/+badKZ9NsMyg7DpUYtw6d4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XsDEU3hk1RNS8PMIEpvTkVB3xjJu3LGm6mxPhj99toWvlT8BZFMgdBYt4j10WIfh6C9xZmpBQbGx14LGX6S/xCeGOxViKAg2/jUjDKoJokPK0v76Hs3712XlEPjmij3g6FW4AJOFy6drmQXoe5ZfCUcD1VHNFDqaVJ8hGfMo1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jrK2HXrI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733431639;
	bh=b1zTW6DElMsDViBpZSCu/+badKZ9NsMyg7DpUYtw6d4=;
	h=From:Subject:Date:To:Cc:From;
	b=jrK2HXrI2LZ4PvhVv1qAAml1hIWcgcvElW/HqrLu7w7bytXx2Hvdudr65I5mO6B4T
	 lsjS9bL1JlGHTpZoWFPZv6Vc5MeEkPBVIF+X9olFSs4cf6/tESG4ASoCynXTAhbf0D
	 NcLDOixSuw+nWSS41TyCC6jCDakvsMt0tUZ4SqyQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 0/4] power: supply: extension API
Date: Thu, 05 Dec 2024 21:46:34 +0100
Message-Id: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACoRUmcC/3XRzW6DMAwH8Fepcl4qx4SU7LT3mHYAYkakCWgMt
 FXFu9d0n9JKbv9I/tmyr4opRWL1vLuqRHPk2HcS8qedqtuyeycdg2SFgBYcoB76EyXN0zB8XDS
 dR+rWEtZwCN76JgcfvJLqIVETz3f59U1yG3ns0+XeaDbr77fpNs3ZaNCVzZ3z6KEK9cuJIjPX7
 dTuOxrVCs/4Fyu2MRQMQx2yvAKDZXiIZb+YB7uNZYI5pIYqnzUFPZ7M/mBG3jZmBTtIR2NtKMu
 C/mHL50ITHSe50Pi11WW5AUMAIyC/AQAA
X-Change-ID: 20240602-power-supply-extensions-07d949f509d9
To: Sebastian Reichel <sre@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733431638; l=4498;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=b1zTW6DElMsDViBpZSCu/+badKZ9NsMyg7DpUYtw6d4=;
 b=cN47rX61WtrgbzbI2q4s5x2xV9Wy2D8Fs0nCNIjm6QvIBAFF2qYGAr4GmiGxV075xOn556agI
 Vfw6OCqHGIHBmiZXiXwCo7a4GTAFJjWgCAqCa6yXjPh+nyVkO0/+zGy
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Introduce a mechanism for drivers to extend the properties implemented
by a power supply.

Motivation
----------

Various drivers, mostly in platform/x86 extend the ACPI battery driver
with additional sysfs attributes to implement more UAPIs than are
exposed through ACPI by using various side-channels, like WMI,
nonstandard ACPI or EC communication.

While the created sysfs attributes look similar to the attributes
provided by the powersupply core, there are various deficiencies:

* They don't show up in uevent payload.
* They can't be queried with the standard in-kernel APIs.
* They don't work with triggers.
* The extending driver has to reimplement all of the parsing,
  formatting and sysfs display logic.
* Writing a extension driver is completely different from writing a
  normal power supply driver.
* ~Properties can not be properly overriden.~
  (Overriding is now explicitly forbidden)

The proposed extension API avoids all of these issues.
An extension is just a "struct power_supply_ext" with the same kind of
callbacks as in a normal "struct power_supply_desc".

The API is meant to be used via battery_hook_register(), the same way as
the current extensions.
Further usecases are fuel gauges and the existing battery_info
properties.

When testing, please enable lockdep to make sure the locking is correct.

The series is based on the linux-power-supply/for-next branch.

Contents
--------

* Patch 1 cleans up the logging messages of the ACPI battery hooks
* Patch 2 implements the extension API itself.
* Patch 3 adds extension support to test_power.c
* Patch 4 converts the in-tree cros_charge-control driver to the
  extension API.

Open issues
-----------

* As this is only useful with the hooks of CONFIG_ACPI_BATTERY, should
  it also be gated behind this or another config?
* Is an rw_semaphore acceptable?

[0] https://lore.kernel.org/lkml/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v5:
- Drop already picked up patches
- Simplify power_supply_ext_has_property()
- Handle failure of power_supply_update_sysfs_and_hwmon()
- Reduce some locking scopes
- Add missing locking to power_supply_show_charge_behaviour()
- Improve sanity checks in power_supply_register_extension()
- Implement writeable property in test_power battery
- Rename ACPI battery hook messages for clarity
- Link to v4: https://lore.kernel.org/r/20241111-power-supply-extensions-v4-0-7240144daa8e@weissschuh.net

Changes in v4:
- Drop RFC state
- Integrate locking commit
- Reregister hwmon device
- Link to v3: https://lore.kernel.org/r/20240904-power-supply-extensions-v3-0-62efeb93f8ec@weissschuh.net

Changes in v3:
- Make naming more consistent
- Readd locking
- Allow multiple active extensions
- Allow passing a "void *ext_data" when registering
- Switch example driver from system76 to cros_charge-control
- Link to v2: https://lore.kernel.org/r/20240608-power-supply-extensions-v2-0-2dcd35b012ad@weissschuh.net

Changes in v2:
- Drop locking patch, let's figure out the API first
- Allow registration of multiple extensions
- Pass extension to extension callbacks as parameter
- Disallow property overlap between extensions and core psy
- Drop system76/pdx86 maintainers, as the system76 changes are only RFC
  state anyways
- Link to v1: https://lore.kernel.org/r/20240606-power-supply-extensions-v1-0-b45669290bdc@weissschuh.net

---
Thomas Weißschuh (4):
      ACPI: battery: Rename extensions to hook in messages
      power: supply: core: implement extension API
      power: supply: test-power: implement a power supply extension
      power: supply: cros_charge-control: implement a power supply extension

 drivers/acpi/battery.c                     |  14 +-
 drivers/power/supply/cros_charge-control.c | 217 ++++++++++++-----------------
 drivers/power/supply/power_supply.h        |  14 ++
 drivers/power/supply/power_supply_core.c   | 159 +++++++++++++++++++--
 drivers/power/supply/power_supply_sysfs.c  |  26 +++-
 drivers/power/supply/test_power.c          | 111 +++++++++++++++
 include/linux/power_supply.h               |  32 +++++
 7 files changed, 427 insertions(+), 146 deletions(-)
---
base-commit: 39f3bd9c9a27d526858da153090376decdf7bfea
change-id: 20240602-power-supply-extensions-07d949f509d9

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


