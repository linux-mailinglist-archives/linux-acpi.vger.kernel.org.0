Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29B45BD2F
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2019 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfGANnK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Jul 2019 09:43:10 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:52960 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfGANnK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Jul 2019 09:43:10 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 309B24D08B;
        Mon,  1 Jul 2019 15:43:07 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, nv@vosn.de
Subject: [PATCH v2 0/2] ASoC: tas5720.c: add ACPI enumeration support
Date:   Mon,  1 Jul 2019 15:42:50 +0200
Message-Id: <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628143037.GH5379@sirena.org.uk>
References: <20190628143037.GH5379@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Patch 1 aggregates variant specific stuff in a struct which is
directly referenced in the id tables (no functional change).

Patch 2 actually adds ACPI IDs for the two DAC variants and uses the
device match API to get the variant in a firmware agnostic manner.

v2:
- split patch into series as suggested by Mark Brown and Andrew F. Davis.
- don't integrate variant data into variant struct but reference it
  (suggested by Andrew F. Davis).

Nikolaus Voss (2):
  ASoC: tas5720.c: cleanup variant management
  ASoC: tas5720.c: add ACPI enumeration support

 sound/soc/codecs/tas5720.c | 111 +++++++++++++++----------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

-- 
2.17.1

