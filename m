Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431294770E0
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Dec 2021 12:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhLPLoL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Dec 2021 06:44:11 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46362 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233791AbhLPLoH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Dec 2021 06:44:07 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BG6WwLk019726;
        Thu, 16 Dec 2021 05:43:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=gAHG/0V1sjSagdKCpk5TIIdUJV0C7cyNn7S+12pk0dA=;
 b=lxDmSRewS/cnzpF6kelIY3ucziWuz0tZijFhpxYM97/xaRSFeDnckoeL1NiFaWdvhxea
 CY0p7LFI1jWy7xmNsA8jLnSpJq5W/FDgdU1GYEF4OsLhBcp+Npq1jQK8p48Xzmz3D3y6
 SFYMFsa7KzLaXKinu4cXGkkXeRCJazA+AcuLSutjv//roCgbkKPC7Zt81cXnOh3Y5xW+
 ukQuAEiXmD+E2boqBY54nmulfw2ylz7uuYUTS7S+i19psbzxK0LJf/A5d2VUOu4gmOi8
 XW5w9o2DqTTXFi/cakVF0Vtx5W9IyYKasfNGTiJ/JJYN+IVn729BkZ62xupjhByQ7/Kr lQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cymsc110q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 05:43:37 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 11:43:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 16 Dec 2021 11:43:35 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.64.39])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2DA8245D;
        Thu, 16 Dec 2021 11:43:34 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v5 00/10] Add support for CS35L41 in HDA systems
Date:   Thu, 16 Dec 2021 11:43:22 +0000
Message-ID: <20211216114332.153409-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: w7Fa3cK6lporfCyW8W7ov1JAsaIY6yY8
X-Proofpoint-ORIG-GUID: w7Fa3cK6lporfCyW8W7ov1JAsaIY6yY8
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for laptops that have CS35L41 connected to an HDA
codec by I2S and direct I2C connection to the CPU.

Laptops that use CS35L41 and are SPI will be added in the future,
after the support for it is resolved at i2c-multi-instantiate driver.
i2c-multi-instantiate thread: https://lkml.org/lkml/2021/12/10/557

Hardware:
 - Some laptops have two CS35L41 amplifiers, connected to Realtek ALC287
   by an I2S bus and by and direct I2C to the CPU.
 - The ALC287 codec is connected to the CPU by an HDA bus.
 - The CS35L41 has a DSP which will require firmware to be loaded.

Architecture:
 - Creation of a library of shared functions for CS35L41 ASoC and HDA
 - HDA codec driver (RealTek) and CS35L41 HDA driver are combined
 by using component binding, where it uses device names to find the
 components and bind to the master
 - The HDA CS35L41 driver applies pre-defined registers sequences
 for each action in playback for HDA Sound card

Changes from V4:
 - Save index received from ACPI for latter use in DSP Support
 - Move CS35L41_DSP1_CCM_CORE_CTRL to regmap_write so doesn't
affect DSP hibernation feature
V4: https://lkml.org/lkml/2021/12/14/487

Changes from V3:
 - SPI bus driver starter added
 - Use separate modules approach instead of liking library
 - Add CSC3551 ACPI _HID for more I2C laptops
 - Removed regulators from HDA driver
 - Add note about Non-conforming _HID
V3: https://lkml.org/lkml/2021/11/23/723

Changes from V2:
 - Not an RFC
 - Create a new HDA driver for CS35L41 instead of using the ASoC one
 - Use component binding and device names to find the CS35L41 driver
 - Create a shared library for ASoC and HDA CS35L41 drivers
v2: https://lkml.org/lkml/2021/10/8/344

Lucas Tanure (9):
  ASoC: cs35l41: Convert tables to shared source code
  ASoC: cs35l41: Move cs35l41_otp_unpack to shared code
  ASoC: cs35l41: Move power initializations to reg_sequence
  ASoC: cs35l41: Create shared function for errata patches
  ASoC: cs35l41: Create shared function for setting channels
  ASoC: cs35l41: Create shared function for boost configuration
  hda: cs35l41: Add support for CS35L41 in HDA systems
  ACPI / scan: Create platform device for CLSA0100 and CSC3551 ACPI
    nodes
  ALSA: hda/realtek: Add support for Legion 7 16ACHg6 laptop

Stefan Binding (1):
  ALSA: hda/realtek: Add CS35L41 support for Thinkpad laptops

 MAINTAINERS                                   |   2 +
 drivers/acpi/scan.c                           |   3 +
 drivers/platform/x86/i2c-multi-instantiate.c  |  11 +
 include/sound/cs35l41.h                       | 739 ++++++++++++++++++
 sound/pci/hda/Kconfig                         |  27 +
 sound/pci/hda/Makefile                        |  10 +
 sound/pci/hda/cs35l41_hda.c                   | 527 +++++++++++++
 sound/pci/hda/cs35l41_hda.h                   |  69 ++
 sound/pci/hda/cs35l41_hda_i2c.c               |  66 ++
 sound/pci/hda/cs35l41_hda_spi.c               |  63 ++
 sound/pci/hda/hda_component.h                 |  20 +
 sound/pci/hda/patch_realtek.c                 | 144 ++++
 sound/soc/codecs/Kconfig                      |   7 +
 sound/soc/codecs/Makefile                     |   4 +-
 sound/soc/codecs/cs35l41-i2c.c                |   1 -
 .../{cs35l41-tables.c => cs35l41-lib.c}       | 355 ++++++++-
 sound/soc/codecs/cs35l41-spi.c                |   1 -
 sound/soc/codecs/cs35l41.c                    | 360 +--------
 sound/soc/codecs/cs35l41.h                    | 734 -----------------
 19 files changed, 2051 insertions(+), 1092 deletions(-)
 create mode 100644 sound/pci/hda/cs35l41_hda.c
 create mode 100644 sound/pci/hda/cs35l41_hda.h
 create mode 100644 sound/pci/hda/cs35l41_hda_i2c.c
 create mode 100644 sound/pci/hda/cs35l41_hda_spi.c
 create mode 100644 sound/pci/hda/hda_component.h
 rename sound/soc/codecs/{cs35l41-tables.c => cs35l41-lib.c} (71%)

-- 
2.34.1

