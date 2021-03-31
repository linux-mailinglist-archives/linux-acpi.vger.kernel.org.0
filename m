Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4169350A2E
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Apr 2021 00:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCaW0k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 18:26:40 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21385 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhCaW0O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Mar 2021 18:26:14 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2021 18:26:14 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1617228663; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OfuQO4ZWcJiSj1BIStNZMUEENOCZPqJM8o1U6/irGVS+9JiwGxM8LJ9JOkdvY9eRQIMFRh5O3cWM9B+9H8MRRIEL6MHdwZHdBC+4W1xbpzljm6quD9okVJJ+S9vmiFfuO0qQlYR8YSNeMxNgJWDNnBUHlvPv0gRis6KPEtwb2GU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1617228663; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=mIj2ubKyNk1AbgGfcv8nvb+y5MC92I8zGuwTQ28EZRA=; 
        b=czqgYAOS9tHI55e5v5y02Ks0i2vNeDLdSAFOuxz/DvmHwCVZ6u2t+qDmxBlOjUu0DU1umN/sHeLLMKRvwKrkbnBc+we61/+v536ND6GXcTkpirl466OTQ+50tWitT4LVd2TMSz59SXMDew/7UztmVLUa5OBmUwUnOKf0wh7JIcE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com> header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1617228663;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=mIj2ubKyNk1AbgGfcv8nvb+y5MC92I8zGuwTQ28EZRA=;
        b=TAjeW+Sv34kA6vWwySaXztudfM/lBGGf0iTs74pf4CEPnddwCr77ktoJOEIigE7T
        E1ZIOMc9v4n9kCidyEreCdqqOWwjSJg5yQFxKOv9PiitDisxYGekq4OzA4Bju01ho7a
        b6CaV3Daq6iRfPflscKlIAc7r3HX9WvpzxfEG+Jg=
Received: from localhost.localdomain (106.51.106.225 [106.51.106.225]) by mx.zohomail.com
        with SMTPS id 1617228661119881.9075492888667; Wed, 31 Mar 2021 15:11:01 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: fix build warning in processor_idle.c
Date:   Thu,  1 Apr 2021 03:40:25 +0530
Message-Id: <20210331221025.31891-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

GCC shows the following warning during build:

drivers/acpi/processor_idle.c: In function ‘acpi_idle_play_dead’:
drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end
of #ifdef directive

Fix by replacing "ifdef" with "if".

Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/acpi/processor_idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 19fb28a8005b..0925b1477230 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -539,7 +539,7 @@ static int acpi_idle_play_dead(struct cpuidle_device *dev, int index)
 		} else
 			return -ENODEV;
 
-#ifdef defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
+#if defined(CONFIG_X86) && defined(CONFIG_HOTPLUG_CPU)
 		/* If NMI wants to wake up CPU0, start CPU0. */
 		if (wakeup_cpu0())
 			start_cpu0();
-- 
2.26.2

