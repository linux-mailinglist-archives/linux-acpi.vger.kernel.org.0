Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4B45A7E1
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhKWQgz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:36:55 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:49652 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236982AbhKWQg3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANCeXB6012277;
        Tue, 23 Nov 2021 10:31:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=ucjt4u4uTbS/qnZq4hfiNfHKaM+njkEGxLdhXZteZWk=;
 b=cdqmwtw0ikxL8X54apKCvV2OhpmAGPO0XC639K5H7qExV0JE4uhL+ctpJDFFefLFBx2X
 krs7Xb3kQWq+JxZ/TsAHJwbwo8PY7HkGmAc+mGGBgP8SgSyTDHHwho56DsBxGysswYR4
 ae22w+hX2o0Qq26iZZ10AVZgDD3/3oRi0rs3fVNTz24hErlLooARRsmyVptdx2PNxzmt
 Y+eBWUlKgjx/SmkotdmTLnun7OIJSJHSQfKsc/JDHVKdhvqb4DQtWp4ZEHaCdnCrX0tQ
 f2uEKec9z6OyY55hc5GrpVQAf2leLCsp961NGFWCO/K4lmmktCGTpUnWL+HKLIduB2wS ow== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cg5ms21ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Nov 2021 10:31:53 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 23 Nov
 2021 16:31:51 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 23 Nov 2021 16:31:51 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.11])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4C3562A1;
        Tue, 23 Nov 2021 16:31:50 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Shuming Fan <shumingf@realtek.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>
CC:     Jeremy Szu <jeremy.szu@canonical.com>,
        Hui Wang <hui.wang@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Sami Loone <sami@loone.fi>, Elia Devito <eliadevito@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jack Yu <jack.yu@realtek.com>, "Arnd Bergmann" <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 00/11] Add support for Legion 7 16ACHg6 laptop
Date:   Tue, 23 Nov 2021 16:31:38 +0000
Message-ID: <20211123163149.1530535-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ic3OlGLxT8IDaeMWD-aoYxFb4fz33N4k
X-Proofpoint-ORIG-GUID: ic3OlGLxT8IDaeMWD-aoYxFb4fz33N4k
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for laptops that have CS35L41 connected to an
HDA codec by I2S and direct I2C/SPI connection to the CPU

Hardware:
 - The 16ACHg6 laptop has two CS35L41 amplifiers, connected
to Realtek ALC287 by an I2S bus and by and direct I2C to the CPU.
 - The ALC287 codec is connected to the CPU by an HDA bus.
 - The CS35L41 has a DSP which will require firmware to be loaded.

Architecture:
 - Creation of a library of shared functions for CS35L41 ASoC and HDA
 - HDA codec driver (RealTek) and CS35L41 HDA driver are combined
 by using component binding, where it uses device names to find the
 components and bind to the master
 - The HDA CS35L41 driver applies pre-defined registers sequences
 for each action in playback for HDA Sound card

Changes from V2:
 - Not an RFC
 - Create a new HDA driver for CS35L41 instead of using the ASoC one
 - Use component binding and device names to find the CS35L41 driver
 - Create a shared library for ASoC and HDA CS35L41 drivers

Lucas Tanure (11):
  ASoC: cs35l41: Set the max SPI speed for the whole device
  ASoC: cs35l41: Convert tables to shared source code
  ASoC: cs35l41: Move regmap config struct to shared code
  ASoC: cs35l41: Create function for init array of Supplies
  ASoC: cs35l41: Move cs35l41_otp_unpack to shared code
  ASoC: cs35l41: Move power initializations to reg_sequence
  ASoC: cs35l41: Create shared function for errata patches
  ASoC: cs35l41: Create shared function for setting channels
  ASoC: cs35l41: Create shared function for boost configuration
  hda: cs35l41: Add support for CS35L41 in HDA systems
  ACPI / scan: Create platform device for CLSA0100 ACPI nodes

 MAINTAINERS                                   |   2 +
 drivers/acpi/scan.c                           |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c  |   7 +
 include/sound/cs35l41.h                       | 741 ++++++++++++++++++
 sound/pci/hda/Kconfig                         |  10 +
 sound/pci/hda/Makefile                        |  28 +-
 sound/pci/hda/cs35l41_hda.c                   | 522 ++++++++++++
 sound/pci/hda/cs35l41_hda.h                   |  69 ++
 sound/pci/hda/cs35l41_hda_i2c.c               |  61 ++
 sound/pci/hda/hda_component.h                 |  20 +
 sound/pci/hda/patch_realtek.c                 | 103 +++
 sound/soc/codecs/Makefile                     |   4 +-
 sound/soc/codecs/cs35l41-i2c.c                |  16 -
 .../{cs35l41-tables.c => cs35l41-lib.c}       | 400 +++++++++-
 sound/soc/codecs/cs35l41-spi.c                |  49 +-
 sound/soc/codecs/cs35l41.c                    | 390 +--------
 sound/soc/codecs/cs35l41.h                    | 739 -----------------
 17 files changed, 1964 insertions(+), 1198 deletions(-)
 create mode 100644 sound/pci/hda/cs35l41_hda.c
 create mode 100644 sound/pci/hda/cs35l41_hda.h
 create mode 100644 sound/pci/hda/cs35l41_hda_i2c.c
 create mode 100644 sound/pci/hda/hda_component.h
 rename sound/soc/codecs/{cs35l41-tables.c => cs35l41-lib.c} (68%)

-- 
2.34.0

