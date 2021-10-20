Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880443477B
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Oct 2021 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTJCu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Oct 2021 05:02:50 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42364 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhJTJCu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Oct 2021 05:02:50 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K5H3Xu026523;
        Wed, 20 Oct 2021 03:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=+O36JWjC5ZXwGoQw3AKB9Rbjg7nf6gOPh3aLObxoE7g=;
 b=XErknXshbsjFnZr/Nugoff10RIBBHz8dqo1WlCdqhGTXlGVxUjHOYR7kI8l5L8L58hcG
 BnmLjECpvtmbzGzp41xa4IjBPsQlu0xbe24yyekcyIgDEWHxUfGA/Dav8Cpc0pPmZ1Ah
 w5zGvcyzv8apHE4Qx40SFtoyTtoZ/tjPQ42NyGSmd/AaFK4djSVtoWDCZBL2LyQ1vYm9
 LbOAy0HqWlAxhycNwvzTD4tH8T/yZsR896xqilWelcbQeRHS9O0heb/KJtzJZ/lHMZU7
 9pymEhYZiUYDK5ebyS88TmrBWlvzQTQgl16doOAmfTtpDNfzLcaiG4tUzrlxA4urG2HI 9w== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3bst7q1jty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Oct 2021 03:59:48 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 20 Oct
 2021 09:59:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.7 via Frontend
 Transport; Wed, 20 Oct 2021 09:59:46 +0100
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.166])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA18711D2;
        Wed, 20 Oct 2021 08:59:45 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Len Brown <lenb@kernel.org>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-acpi@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [RFC PATCH v2 0/3] Add support for Legion 7 16ACHg6 laptop
Date:   Wed, 20 Oct 2021 09:59:41 +0100
Message-ID: <20211020085944.17577-1-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tQDFLlznbJ_LI0CRoY4fRA16gpamDsvt
X-Proofpoint-GUID: tQDFLlznbJ_LI0CRoY4fRA16gpamDsvt
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

I would like to get some guidance about this solution to
support the 16ACHg6 laptop.

Hardware:
 - The 16ACHg6 laptop has two CS35L41 amplifiers, connected
to Realtek ALC287 by an I2S bus and by and direct I2C to the CPU.
 - The ALC287 codec is connected to the CPU by an HDA bus.
 - The CS35L41 has a DSP which will require firmware to be loaded.

Architecture:
 - To load the firmware for CS35L41, this solution will require
the wm_adsp library, which requires regmap, header definitions and
register tables.
 - The HDA machine driver will find the registered ASoC by its
 dai name.
 - To minimize the duplication of the code, the HDA will call
 snd_soc_dai_ops from the ASoC driver.

Notes:
 - This is a work in progress, so the code is not functional, its
only intent is to demonstrate the overall solution

Changes from V1:

 - Split into multiple patches, separating ACPI, ASoC and HDA patches
 - Removed CS35L41 exported functions, moved code to snd_soc_dai_ops
 - Patch realtek uses dai ops functions

Lucas Tanure (3):
  sound: cs35l41: Allow HDA systems to use CS35l41 ASoC driver
  ALSA: hda/realtek: Add support for Legion 7 16ACHg6 laptop Speakers
  ACPI / scan: Create platform device for INT3515 ACPI nodes

 drivers/acpi/scan.c                          |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c |   7 +
 include/sound/cs35l41.h                      |   1 +
 sound/pci/hda/patch_realtek.c                | 109 ++++++++++++++-
 sound/soc/codecs/cs35l41.c                   | 139 +++++++++++++++++--
 sound/soc/codecs/cs35l41.h                   |   1 +
 6 files changed, 249 insertions(+), 9 deletions(-)

-- 
2.33.1

