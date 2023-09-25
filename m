Return-Path: <linux-acpi+bounces-101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32847ADD36
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 55BB4281E7A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFA81D6A9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB5219EA
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 15:58:13 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE6B8;
	Mon, 25 Sep 2023 08:58:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 7587266072FC;
	Mon, 25 Sep 2023 16:58:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1695657489;
	bh=/jor1FFC8SKohb/3sjU4fNSEVcDdd5txHAwwx7fIBc0=;
	h=From:To:Cc:Subject:Date:From;
	b=Yj7TZPGyFSKyYUXBAftWJ3qbMbHh0mNoeK4uMfrKq9i3JM/0QRIIHCkI+AyPTbQAl
	 P/89sJTx9UWu7mnSpcKa03WHuHHuo6EjAquah4HRMEB+hajtAU9dLrsPklof/fEIRg
	 ZQ35ITZn9dbYss1m75f6PsBPGP+sLgA7pCL1hdhhYs4RGi70xIteGWNGIE4gKwmYcW
	 nHLW++Y1ii3M7l7DeJ0upjzB84UscOnXAhY1RtHIBSlWqBE1AnIyuEoTZeyMulbfVW
	 SYEmByZhyhfZlKGQCMwcE6GeryzXqOtL9oFmtKW5PCkq/3IqiXEYKFfS9WNxwC3TN3
	 8TjP9ypoHuQhw==
From: Laura Nao <laura.nao@collabora.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	groeck@chromium.org,
	broonie@kernel.org,
	robh+dt@kernel.org,
	kernelci@lists.linux.dev,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [RFC PATCH 0/2]  Add a test to verify device probing on ACPI platforms
Date: Mon, 25 Sep 2023 17:58:04 +0200
Message-Id: <20230925155806.1812249-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Regressions that prevent a driver from probing a device can significantly
affect the functionality of a platform.

A kselftest to verify if devices on a DT-based platform are probed
correctly was recently introduced [1], but no such generic test is
available for ACPI platforms yet. bootrr [2]  provides device probe
testing, but relies on a pre-defined list of the peripherals present on
each DUT.

On ACPI based hardware, a complete description of the platform is
provided to the OS by the system firmware. ACPI namespace objects are
mapped by the Linux ACPI subsystem into a device tree in
/sys/devices/LNXSYSTEM:00; the information in this subtree can be parsed
to build a list of the hw peripherals present on the DUT dynamically.

This series adds a test to verify if the devices declared in the ACPI
namespace and supported by the kernel are probed correctly.

This work follows a similar approach to [1], adapted for the ACPI use
case.

The first patch introduces a script that builds a list of all ACPI device
IDs supported by the kernel, by inspecting the acpi_device_id structs in
the sources. This list can be used to avoid testing ACPI-enumerated
devices that don't have a matching driver in the kernel. This script was
highly inspired by the dt-extract-compatibles script [3].

In the second patch, a new kselftest is added. It parses the
/sys/devices/LNXSYSTEM:00 tree to obtain a list of all platform
peripherals and verifies which of those, if supported, are correctly
bound to a driver.

Feedback is much appreciated,

Thank you,

Laura

[1] https://lore.kernel.org/all/20230828211424.2964562-1-nfraprado@collabora.com/
[2] https://github.com/kernelci/bootr
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/dtc/dt-extract-compatibles

Laura Nao (2):
  acpi: Add script to extract ACPI device ids in the kernel
  kselftest: Add test to detect unprobed devices on ACPI platforms

 MAINTAINERS                                   |  2 +
 scripts/acpi/acpi-extract-ids                 | 60 +++++++++++++++
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/acpi/.gitignore       |  2 +
 tools/testing/selftests/acpi/Makefile         | 23 ++++++
 .../selftests/acpi/test_unprobed_devices.sh   | 75 +++++++++++++++++++
 6 files changed, 163 insertions(+)
 create mode 100755 scripts/acpi/acpi-extract-ids
 create mode 100644 tools/testing/selftests/acpi/.gitignore
 create mode 100644 tools/testing/selftests/acpi/Makefile
 create mode 100755 tools/testing/selftests/acpi/test_unprobed_devices.sh

-- 
2.30.2


