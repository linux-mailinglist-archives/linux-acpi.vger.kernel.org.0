Return-Path: <linux-acpi+bounces-21102-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCw/IJo3nWlINQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21102-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:31:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD7181EC3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFB6B3068395
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 05:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C02529AAE3;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/yW2hnT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48561DFE22;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911052; cv=none; b=IEif6uezSn054op/9Bl4qhDDEJi3tSgmpw/eyGrB33YqY40QQFi4WBZAC6vgyKRPl3lo5/6dxCEgh55KnXodx+17EPZhSIpQPxpe/nuCsLZ8xR0SUJf4N0/vAl2qKTCBS2PG3eNo5cgV+OXD2Ue4HPgTmAXVoRsKt6bD65zehZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911052; c=relaxed/simple;
	bh=SnZaSMf2cA5Gwe7vWZar/n+eIHqWH+U1vFZSUccO7B8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Rd5wTeZQE79XxexrC4J/DHEgs3C09QgPTowfTireN3aBqo8d0KXxhZRVlsR0JJyVQ+ZmzFDJdC1dHWPtkeURw+H0tAMkCQTdQrUaECJT9hrUy94folDr9sRaPvtwyw9QECJodCsdfFczsAXLDLYNEtgsT+8wXNZls0T0ovoRCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/yW2hnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 568ADC116D0;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911052;
	bh=SnZaSMf2cA5Gwe7vWZar/n+eIHqWH+U1vFZSUccO7B8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=K/yW2hnTgjuW+OV4W32r3GuyvCMu1qKhVgDsYCyoGo7rXQ5mDiTZZeM/vxqgWj272
	 K4qf1SgeNqlrtZdCQdbnR+gYHUoWP91OnkgP944GS8IdPPlIb/ALGqrWh2wB23ahBE
	 3za6z9CA/8NACBfNVoTfGOd676VLvcbIcBs7BEqwCCy6TcpHxmucIDPwqtQ7ZGYpOk
	 +h81h1aVmcBmeC/3MMw5L/MtkWit1Q884Ca9hFZThgqbZJSv/Asb/8bWHPd23UfMd8
	 YgJINR27NU3khLdaYSUCze0d5Tuebkn9uGBGBnmh86uBMTD36hzH8BTt2brp8ThZpA
	 ZMR1zfex5zKpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA05EFB7F9;
	Tue, 24 Feb 2026 05:30:52 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v5 0/9] Add support for handling PCIe M.2 Key E connectors
 in devicetree
Date: Tue, 24 Feb 2026 11:00:46 +0530
Message-Id: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIY3nWkC/3XQTW7DIBAF4KtYrIsFY37srHqPqgsCQ4NUxwk4q
 FWUu3ecqBKLZIM06H1Po7mygjlhYbvuyjLWVNJypEG/dcwf3PELeQo0MxCgpZTATz7xGTjySZl
 JOz8Foy2j+CljTD/3qo9Pmg+prEv+vTdXuf0+KamSCz5ZJYdg9nEE9b6U0p8v7tsv89zTw7auC
 o0H3XggP8AIJqCw3usXfvj3RkgpGj+QV9Eh2iCCdvjCq9a3+yvyGOOoAngTwDzxt8dxMp4vdN7
 1cSG2dwX5Fkrrrqu2Fzx7SeHbH931VIiTAQAA
X-Change-ID: 20251112-pci-m2-e-94695ac9d657
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7106;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=SnZaSMf2cA5Gwe7vWZar/n+eIHqWH+U1vFZSUccO7B8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpnTeHc38+CBV++wJV7Ph9fzZscIthcHTpquo3C
 7qv2DEbNnaJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZ03hwAKCRBVnxHm/pHO
 9RbuB/92igV75YDs1agNrzI2uKiZVuENfGsyJBJWJHvrh8O9dZTBfeVXJU+ePQoP50g7f2K4eSw
 etn6zHUocr8MCzv73IE5fFWHefi/fNQT4CfzonA/vtJH4mPWiQN3AeuE5hXfsBNzc3NAipZ+opi
 +xARb09n8puTbPugIE/4utoJg1vIvAceo/cACSMof5s5zjO0zpu1eBrqE8uFphSDgqeNE6u4k9n
 J2t1NyTLaJAprIhEUkAsssghZ6BFwT7PfT9l9LdnT05ZXNuIrPhIg4gURB9UaNhFOnZjLp/ujSY
 2oPFEHO2uJJshvi6qM4SLCaf73SlDWWUXN0gml66DtFurq43
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21102-lists,linux-acpi=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:replyto,qualcomm.com:email,0.0.0.0:email,0.0.0.1:email]
X-Rspamd-Queue-Id: BDFD7181EC3
X-Rspamd-Action: no action

Hi,

This series is the continuation of the series [1] that added the initial support
for the PCIe M.2 connectors. This series extends it by adding support for Key E
connectors. These connectors are used to connect the Wireless Connectivity
devices such as WiFi, BT, NFC and GNSS devices to the host machine over
interfaces such as PCIe/SDIO, USB/UART and NFC. This series adds support for
connectors that expose PCIe interface for WiFi and UART interface for BT. Other
interfaces are left for future improvements.

Serdev device support for BT
============================

Adding support for the PCIe interface was mostly straightforward and a lot
similar to the previous Key M connector. But adding UART interface has proved to
be tricky. This is mostly because of the fact UART is a non-discoverable bus,
unlike PCIe which is discoverable. So this series relied on the PCI notifier to
create the serdev device for UART/BT. This means the PCIe interface will be
brought up first and after the PCIe device enumeration, the serdev device will
be created by the pwrseq driver. This logic is necessary since the connector
driver and DT node don't describe the device, but just the connector. So to make
the connector interface Plug and Play, the connector driver uses the PCIe device
ID to identify the card and creates the serdev device. This logic could be
extended in the future to support more M.2 cards. Even if the M.2 card uses SDIO
interface for connecting WLAN, a SDIO notifier could be added to create the
serdev device.

Open questions
==============

Though this series adds the relevant functionality for handling the M.2 Key M
connectors, there are still a few open questions exists on the design. 

1. Created a dynamic 'bluetooth' node with the compatible property matching the
WCN7850 device and attached it to the serdev device. This allowed reusing the
existing OF based BT driver without much modifications.

2. PCIe client drivers of some M.2 WLAN cards like the Qcom QCA6390, rely on
the PCIe device DT node to extract properties such as
'qcom,calibration-variant', 'firmware-name', etc... For those drivers, should we
add the PCIe DT node in the Root Port in conjunction with the Port node as
below?

pcie@0 {
	wifi@0 {
		compatible = "pci17cb,1103";
		...
		qcom,calibration-variant = "LE_X13S";
	};

	port {
		pcie4_port0_ep: endpoint {
			remote-endpoint = <&m2_e_pcie_ep>;
		};
	};
};

This will also require marking the PMU supplies optional in the relevant ath
bindings for M.2 cards.

3. Some M.2 cards require specific power up sequence like delays between
regulator/GPIO and such. For instance, the WCN7850 card supported in this series
requires 50ms delay between powering up an interface and driving it. I've just
hardcoded the delay in the driver, but it is a pure hack. Since the pwrseq
driver doesn't know anything about the device it is dealing with before powering
it ON, how should it handle the device specific power requirements? Should we
hardcode the device specific property in the connector node? But then, it will
no longer become a generic M.2 connector and sort of defeats the purpose of the
connector binding.

I hope to address these questions with the help of the relevant subsystem
maintainers and the community. 

Testing
=======

This series, together with the devicetree changes [2] was tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the WCN7850 WLAN/BT
1620 LGA card connected over PCIe and UART.

Dependency
==========

This series is dependent on the M.2 Key M series [1] on top of v6.19-rc1.

[1] https://lore.kernel.org/linux-pci/20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com
[2] https://github.com/Mani-Sadhasivam/linux/commit/b50f8386900990eed3dce8d91c3b643fb0e8739d

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v5:
- Incorporated comments in the binding patch by using single endpoint per port,
  reordering port nodes, adding missing properties and using a complete example.
- Incorporated comments in the pwrseq patch (nothing major)
- Fixed the build issue in patch 2
- Collected tags
- Rebased on top of 7.0-rc1
- Link to v4: https://lore.kernel.org/r/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com

Changes in v4:
- Switched to dynamic OF node for serdev instead of swnode and dropped all
  swnode related patches
- Link to v3: https://lore.kernel.org/r/20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com

Changes in v3:
- Switched to swnode for the serdev device and dropped the custom
  serdev_device_id related patches
- Added new swnode APIs to match the swnode with existing of_device_id
- Incorporated comments in the bindings patch
- Dropped the UIM interface from binding since it is not clear how it should get
  wired
- Incorporated comments in the pwrseq driver patch
- Splitted the pwrseq patch into two
- Added the 1620 LGA compatible with Key E fallback based on Stephan's finding
- Link to v2: https://lore.kernel.org/r/20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com

Changes in v2:
- Used '-' for GPIO names in the binding and removed led*-gpios properties
- Described the endpoint nodes for port@0 and port@1 nodes
- Added the OF graph port to the serial binding
- Fixed the hci_qca driver to return err if devm_pwrseq_get() fails
- Incorporated various review comments in pwrseq driver
- Collected Ack
- Link to v1: https://lore.kernel.org/r/20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com

---
Manivannan Sadhasivam (9):
      serdev: Convert to_serdev_*() helpers to macros and use container_of_const()
      serdev: Add an API to find the serdev controller associated with the devicetree node
      serdev: Do not return -ENODEV from of_serdev_register_devices() if external connector is used
      dt-bindings: serial: Document the graph port
      dt-bindings: connector: Add PCIe M.2 Mechanical Key E connector
      dt-bindings: connector: m2: Add M.2 1620 LGA soldered down connector
      Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
      power: sequencing: pcie-m2: Add support for PCIe M.2 Key E connectors
      power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth

 .../bindings/connector/pcie-m2-e-connector.yaml    | 191 ++++++++++++++
 .../devicetree/bindings/serial/serial.yaml         |   3 +
 MAINTAINERS                                        |   1 +
 drivers/bluetooth/hci_qca.c                        |   9 +
 drivers/power/sequencing/Kconfig                   |   3 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 278 ++++++++++++++++++++-
 drivers/tty/serdev/core.c                          |  28 ++-
 include/linux/serdev.h                             |  24 +-
 8 files changed, 514 insertions(+), 23 deletions(-)
---
base-commit: 559f264e403e4d58d56a17595c60a1de011c5e20
change-id: 20251112-pci-m2-e-94695ac9d657

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



