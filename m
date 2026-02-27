Return-Path: <linux-acpi+bounces-21202-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EmHLXaioWnEvAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21202-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:56:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B21C1B8003
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1756330F8E5D
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E3407573;
	Fri, 27 Feb 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="igX8lQVp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980C53F23D7;
	Fri, 27 Feb 2026 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200510; cv=none; b=L8Vc2pqJUMoWoRrZvSl+1ecWIRbV8WqoANgT7rgypXlsObB9a1fAlK6kdzsKspEAobSMa7/itrmh7TfJnTte73qrxpGH4rHKEMTAc80qBYFqSDiTTEkZhWtFla0y0RnD77V2h0CJTw46ZgLuiKrL2f+SQLR4URAt2UGnQVCCrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200510; c=relaxed/simple;
	bh=C1DkhxjU6XOyhVwLQ6OUr299uGDSgaNu52Va6SbVWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DbJmcSierxDXEKhONv3mftGFN9x6CAIF7XyRZhDyl3QXBsVsgk5HpYqGvfViPISRubfTSiQhL3PGFmVIPitqu1jmHUxXFCo82EGLzOhtzMAT7yDyU5uZMzA/EvHyKF/r5l9XodeelfJ1cYBpunvc9WH/EFjLNRkT1I57ZdvluJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=igX8lQVp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0B83C1A118A;
	Fri, 27 Feb 2026 13:55:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBE295FE74;
	Fri, 27 Feb 2026 13:55:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2C7C21036945B;
	Fri, 27 Feb 2026 14:54:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772200503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ir0k/DdY5XLICbT9UseNVUNN8qOUDOalOZGSQwnXHDQ=;
	b=igX8lQVpeb5/H+C47rMVNhzbUaZ1op5dL8EK1XWqlUukaX3vmO7mCdeOhrG11TdXW4Ew9i
	+LKVvVtmtcU6gcUS9d8hKTpTdNfTEi+xd4kPp3ZdCjTnuFa310SmS203u7dbOE3+BmNGKx
	mjMKxmZfdTlWrtc+B88z3snvBESBHathdL9sVd4t388XdCMfiGxu7sg+dt7IWsNx5SEYBw
	T5eHCD358lxGHP2HgSVxt9HnV7Cyz0S+NoO1gZ7qDvBoQMiMUTX6ccvzJq6g7uqMGjhDEz
	X6zOIBw5fa9NPAEVIW5Q8g6f1R/wGP3oCMxwiaxrDnqBfhZpftj2HVkpgSGi6Q==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 00/28] lan966x pci device: Add support for SFPs
Date: Fri, 27 Feb 2026 14:53:57 +0100
Message-ID: <20260227135428.783983-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21202-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,bootlin.com,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCPT_COUNT_GT_50(0.00)[63];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:mid,bootlin.com:dkim,fwnode.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B21C1B8003
X-Rspamd-Action: no action

Hi,

This series add support for SFPs ports available on the LAN966x PCI
device. In order to have the SFPs supported, additional devices are
needed such as clock controller and I2C.

As a reminder, the LAN966x PCI device driver use a device-tree overlay
to describe devices available on the PCI board. Adding support for SFPs
ports consists in adding more devices in the already existing
device-tree overlay.

With those devices added, the device-tree overlay is more complex and
some consumer/supplier relationship are needed in order to remove
devices in correct order when the LAN966x PCI driver is removed.

Those links are typically provided by fw_devlink and we faced some
issues with fw_devlink and overlays.

This series gives the big picture related to the SFPs support from
fixing issues to adding new devices. Of course, it can be split if
needed.

The first part of the series (patch 1, 2 and 3) fixes fw_devlink when it
is used with overlay. Patches 1 and 3 were previously sent by Saravana
[0]. I rebased them on top of v7.0-rc1 and added patch 2 in order to
take into account feedback received on the series sent by Saravana.

Also I added a call to driver_deferred_probe_trigger() in Saravana's
patch (patch 3) to ensure that probes are retried after the modification
performed on the dangling consumers. This allows to fix issues reported
by Matti and Geert [2] with the previous iteration patches.

Those modification were not sufficient in our case and so, on top of
that, patches 4 to 6 fix some more issues related to fw_devlink.

Patches 7 to 12 introduce and use fw_devlink_set_device() in already
existing code.

Patches 13 and 14 are related also to fw_devlink but specific to PCI and
the device-tree nodes created during enumeration.

Patches 15, 16 and 17 are related fw_devlink too but specific to I2C
muxes. Patches purpose is to correctly set a link between an adapter
supplier and its consumer. Indeed, an i2c mux adapter's parent is not
the i2c mux supplier but the adapter the i2c mux is connected to. Adding
a new link between the adapter supplier involved when i2c muxes are used
avoid a freeze observed during device removal.

Patch 18 adds support for fw_delink on x86. fw_devlink is needed to have
the consumer/supplier relationship between devices in order to ensure a
correct device removal order. Adding fw_devlink support for x86 has been
tried in the past but was reverted [1] because it broke some systems.
Instead of enabling fw_devlink on *all* x86 system, enable it on *all*
x86 except on those where it leads to issue.

Patches 19 and 20 allow to build clock and i2c controller used by the
LAN966x PCI device when the LAN966x PCI device is enabled.

Patches 21 to 25 are specific to the LAN966x. They touch the current
dtso, split it in dtsi/dtso files, rename the dtso and improve the
driver to allow easier support for other boards.

The next patch (patch 26) update the LAN966x device-tree overlay itself
to have the SPF ports and devices they depends on described.

The last two patches (patches 27 and 29) sort the existing drivers in
the needed driver list available in the Kconfig help and add new drivers
in this list keep the list up to date with the devices described in the
device-tree overlay.

We believe some items from the above list can be merged separately, with
no build dependencies. We expect:

 - Patches 1 to 6 to be taken by driver core maintainers

 - Patches 7 to 12 to be taken by driver core maintainers

 - Patches 13 and 14 to be taken by driver core or PCI maintainers
  (depend on patch 7)

 - Patches 15 to 17 to be taken by I2C maintainers

 - Patch 18 to be taken by driver core or OF maintainers

 - Patch 19 to be taken by clock maintainers

 - Patch 20 to be taken by I2C maintainers

 - Patches 21 to 28 to be taken by misc maintainers

Once again, this series gives the big picture and can be split if
needed. Let me know.

Compare to previous iteration, this v5 series mainly:
 - Handle Matti and Geert use cases [2]
 - Remove simple-platform-bus driver introduced in v4 and switch the
   simple-bus modification back to what was proposed in v3. In the v4
   iteration, conclusion was to use v3 changes [3].

[0] https://lore.kernel.org/lkml/20240411235623.1260061-1-saravanak@google.com/
[1] https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/
[2] https://lore.kernel.org/all/072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com/
[3] https://lore.kernel.org/lkml/20251114083056.31553866@bootlin.com/

Best regards,
Hervé

Changes:

v4 -> v5
  v4: https://lore.kernel.org/lkml/20251015071420.1173068-1-herve.codina@bootlin.com/

  - Patch 2:
    Add 'Acked-by: Ulf Hansson'

  - Patch 3:
    Add a call to driver_deferred_probe_trigger()

  - Patch 5: (new patch)
    Depopulate devices at remove

  - Patch 6:
    Populate devices at probe.
    Switched back to modification proposed in v3

  - Patch 7 in v3 removed

  - Patch 7 (8 in v4):
    Add 'Reviewed-by: Andy Shevchenko'
    Add 'Reviewed-by: Ulf Hansson'

  - Patch 8 (9 in v4):
    Add 'Reviewed-by: Ulf Hansson'

  - Patches 9 to 15 (10 to 16 in v3)
    No changes

  - Patch 16 (17 in v4):
    Add 'Reviewed-by: Andi Shyti'

  - Patch 17 (18 in v4):
    Change an error code from -EINVAL to -ENODEV
    Add a blank line and fix a typo in commit log

  - Patch 18 (19 in v4):
    Simplify of_is_fwnode_add_links_supported().
    Move IS_ENABLED(CONFIG_X86) check in of_is_fwnode_add_links_supported().

  - Patches 19 to 21 (20 to 22 in v4)
    No changes

  - Patch 22 (23 in v4)
    Update due to simple-platform-bus removal

  - Patches 23 to 28 (24 to 29 in v4)
    No changes

v3 -> v4
  v3: https://lore.kernel.org/lkml/20250613134817.681832-1-herve.codina@bootlin.com/

  - Patch 1:
    No change

  - Patch 2:
    Update and fix conflicts. Indeed, since v3 iteration
    get_dev_from_fwnode() has been moved to device.h and used by
    pmdomain/core.c.

  - Patch 3:
    remove '#define get_device_from_fwnode()'

  - Patch 4:
    Fix conflict (rebase v6.17-rc6)
    Add 'Reviewed-by: Rafael J. Wysocki'
    Add 'Reviewed-by: Saravana Kannan'

  - Patch 5 (new in v4):
    Introduce simple-platform-bus (binding)

  - Patch 6 (5 in v3):
    Rework patch and introduce simple-platform-bus

  - Patch 7: (new)
    Use simple-platform-bus in LAN966x

  - Patch 8 (6 in v3):
    - No change

  - Patch 9 and 10 (7 and 8 in v3):
    Add 'Reviewed-by: Andy Shevchenko'

  - Patch 11 and 12 (9 and 10 in v3):
    Add 'Reviewed-by: Dave Jiang'

  - Patch 13 (11 in v3):
    Add 'Reviewed-by: Andy Shevchenko'

  - Patch 12 in v3:
    Patch removed.
    Adding __private tag in fwnode.dev is going to be handled in a
    dedicated series. Indeed a test robot reported an issue and more
    patches are needed (I have missed fwnode.dev users in several part
    in the kernel).

  - Patch 14 and 15 (13 and 14 in v3):
    No change

  - Patch 16 (14 in v3):
    Add 'Reviewed-by: Andi Shyti'

  - Patch 17 and 18 (16 and 17 in v3):
    No change

  - Patch 19 (18 in v3):
    Filter out support for fw_devlink on x86 based on some device-tree
    properties.
    Rewrite commit changelog
    Remove 'Reviewed-by: Andy Shevchenko' (significant modification)

  - Patch 20 (19 in v3):
    Add 'Acked-by: Stephen Boyd'

  - Patch 21 (20 in v3):
    Fix conflict (rebase v6.18-rc1)

  - Patches 22 to 24 (21 to 23 in v3):
    No change

  - Patch 25 (24 in v3):
    Fix conflict (rebase v6.18-rc1)
    Add 'Acked-by: Bjorn Helgaas'

  - Patches 26 to 29 (25 to 28 in v3):
    No change

v2 -> v3
  v2: https://lore.kernel.org/all/20250507071315.394857-1-herve.codina@bootlin.com/

  - Patch 1:
    Add 'Acked-by: Mark Brown'

  - Patch 2 and 3:
    No changes

  - Patch 4:
    Rewrite the WARN_ON() condition to avoid an additional 'if'

  - Patch 5:
    Fix typos in commit log
    Update a comment
    Remove the unneeded check before calling of_platform_depopulate()

  - Patches 6 to 11:
    No changes

  - Patch 12 (new in v3)
    Tag the fwnode dev member as private

  - Patch 13 (12 in v2)
    Fix a typo in the commit log

  - Patches 14 to 16 (13 to 15 in v2)
    No changes

  - Patch 17 (16 in v2)
    Check parent_physdev for NULL

  - Patch 18 (17 in v2)
    Capitalize "Link:"
    Add 'Reviewed-by: Andy Shevchenko'

  - Patch 19 (18 in v2)
    No changes

  - Patch 20 (19 in v2)
    Add 'Acked-by: Andi Shyti'

  - Patch 21 (20 in v2)
    No changes

  - Patch 22 (21 in v2)
    Add 'Reviewed-by: Andrew Lunn'

  - Patch 23 (22 in v2)
    Add 'Reviewed-by: Andrew Lunn'

  - Patch 24 (new in v3)
    Introduce PCI_DEVICE_ID_EFAR_LAN9662, the LAN966x PCI device ID

  - Patch 25 (23 in v2)
    Add 'Reviewed-by: Andrew Lunn'
    Use PCI_DEVICE_DATA() with PCI_DEVICE_ID_EFAR_LAN9662 instead of
    PCI_VDEVICE()

  - Patch 26 to 28 (24 to 26 in v2)
    No changes

v1 -> v2
  v1: https://lore.kernel.org/lkml/20250407145546.270683-1-herve.codina@bootlin.com/

  - Patch 1 and 3
    Remove 'From' tag from the commit log

  - Patch 2
    Add 'Reviewed-by: Andy Shevchenko'
    Add 'Reviewed-by: Saravana Kannan'
    Add 'Reviewed-by: Luca Ceresoli'

  - Patch 4 and 5
    No changes

  - Patch 6 (new in v2)
    Introduce fw_devlink_set_device()

  - Patch 7 (new in v2)
    Use existing device_set_node() helper.

  - Patch 8 to 11 (new in v2)
    Use fw_devlink_set_device() in existing code.

  - Patch 12 (6 in v1)
    Use fw_devlink_add_device()

  - Patch 13 (7 in v1)
    No changes

  - Patch 14 (8 in v1)
    Update commit log
    Use 'physdev' instead of 'supplier'
    Minor fixes in i2c_get_adapter_physdev() kdoc

  - Patch 15 and 16 (9 and 10 in v1)
    Use 'physdev' instead of 'supplier' (commit log, title and code)

  - Patch 17 (11 in v2)
    Enable fw_devlink on x86 only if PCI_DYNAMIC_OF_NODES is enabled.
    Rework commit log.

  - Patch 18, 19 and 20 (12, 13 and 14 in v1)
    No changes

  - Patch 21 (new in v2)
    Split dtso in dtsi/dtso

  - Patch 22 (new in v2)
    Rename lan966x_pci.dtso using the specific board name

  - Patch 23 (new in v2)
    Improve the driver introducing board specific data to ease support
    for other boards (avoid the direct dtbo reference in the function
    loading the dtbo).

  - Patch 24 (15 in v1)
    Refactor due to dtso split in dtsi/dtso

  - Patch 25 (new in v2)
    Sort exist driver list in Kconfig help

  - Patch 26 (16 in v1)
    Keep alphanumeric order for new drivers added in Kconfig help

Herve Codina (26):
  driver core: Rename get_dev_from_fwnode() wrapper to
    get_device_from_fwnode()
  driver core: Avoid warning when removing a device while its supplier
    is unbinding
  bus: simple-pm-bus: Remove child devices when the bus is unbound
  bus: simple-pm-bus: Populate child nodes at probe
  driver core: fw_devlink: Introduce fw_devlink_set_device()
  drivers: core: Use fw_devlink_set_device()
  pinctrl: cs42l43: Use fw_devlink_set_device()
  cxl/test: Use device_set_node()
  cxl/test: Use fw_devlink_set_device()
  PCI: of: Use fw_devlink_set_device()
  PCI: of: Set fwnode device of newly created PCI device nodes
  PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge
    node
  i2c: core: Introduce i2c_get_adapter_physdev()
  i2c: mux: Set adapter physical device
  i2c: mux: Create missing devlink between mux and adapter physical
    device
  of: property: Allow fw_devlink device-tree on x86
  clk: lan966x: Add MCHP_LAN966X_PCI dependency
  i2c: busses: at91: Add MCHP_LAN966X_PCI dependency
  misc: lan966x_pci: Fix dtso nodes ordering
  misc: lan966x_pci: Split dtso in dtsi/dtso
  misc: lan966x_pci: Rename lan966x_pci.dtso to
    lan966x_evb_lan9662_nic.dtso
  PCI: Add Microchip LAN9662 PCI Device ID
  misc: lan966x_pci: Introduce board specific data
  misc: lan966x_pci: Add dtsi/dtso nodes in order to support SFPs
  misc: lan966x_pci: Sort the drivers list in Kconfig help
  misc: lan966x_pci: Add drivers needed to support SFPs in Kconfig help

Saravana Kannan (2):
  Revert "treewide: Fix probing of devices in DT overlays"
  of: dynamic: Fix overlayed devices not probing because of fw_devlink

 MAINTAINERS                               |   3 +-
 drivers/base/core.c                       | 108 ++++++++++---
 drivers/bus/imx-weim.c                    |   6 -
 drivers/bus/simple-pm-bus.c               |  24 +--
 drivers/clk/Kconfig                       |   2 +-
 drivers/i2c/busses/Kconfig                |   2 +-
 drivers/i2c/i2c-core-base.c               |  16 ++
 drivers/i2c/i2c-core-of.c                 |   5 -
 drivers/i2c/i2c-mux.c                     |  26 ++++
 drivers/misc/Kconfig                      |  11 +-
 drivers/misc/Makefile                     |   2 +-
 drivers/misc/lan966x_evb_lan9662_nic.dtso | 167 ++++++++++++++++++++
 drivers/misc/lan966x_pci.c                |  30 +++-
 drivers/misc/lan966x_pci.dtsi             | 172 +++++++++++++++++++++
 drivers/misc/lan966x_pci.dtso             | 177 ----------------------
 drivers/of/dynamic.c                      |   1 -
 drivers/of/overlay.c                      |  15 ++
 drivers/of/platform.c                     |   5 -
 drivers/of/property.c                     |  26 +++-
 drivers/pci/of.c                          |  10 +-
 drivers/pci/quirks.c                      |   2 +-
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c  |   2 +-
 drivers/pmdomain/core.c                   |   4 +-
 drivers/spi/spi.c                         |   5 -
 include/linux/device.h                    |   2 +-
 include/linux/fwnode.h                    |   7 +
 include/linux/i2c.h                       |   3 +
 include/linux/pci_ids.h                   |   1 +
 tools/testing/cxl/test/cxl.c              |   4 +-
 29 files changed, 584 insertions(+), 254 deletions(-)
 create mode 100644 drivers/misc/lan966x_evb_lan9662_nic.dtso
 create mode 100644 drivers/misc/lan966x_pci.dtsi
 delete mode 100644 drivers/misc/lan966x_pci.dtso

-- 
2.53.0


