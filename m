Return-Path: <linux-acpi+bounces-2084-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 343E380165B
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 23:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6523B1C208EB
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 22:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD233F8D5
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Dec 2023 22:33:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFC10D0;
	Fri,  1 Dec 2023 13:19:27 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b85d97a529so387742b6e.0;
        Fri, 01 Dec 2023 13:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701465567; x=1702070367;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Na5SuSnuGSKFtr3bwJTXAsXLv0Bpp+jJLrkc0svhQs=;
        b=VlPLDeQI4xfHpelXtmbZ9bma3FXq7BWeo3ctW3tavKWCgDi9GAUsgmDaBKCOkz+DTE
         q4snhugFtsrSNC3RUGElcRv0oWOCnUowVnmSY21tc72+0jCw4I7c7R2ejVx/pQbmmZj3
         jmo5MQcdngf9pVisAAvB2d8wpFLlgtn14nRFS2Zf5GMOZf8HzAV6LB5roY3pbi6tn20b
         fYVCyba/EeX+biDBU8aAe07UC3vcqamKbugm5StEn8sLSqUhB6kfFt6UeIPaOW5Izeee
         lWY7SA/ijBxW/hJjcoJADnKweWcAOLOSV1FzA1thA1tD1Qock4iHNwoZ2SPM6dLzJfh+
         0spA==
X-Gm-Message-State: AOJu0YxPXACLpK00i0bhiKLff8Qd7/DHDuRQZXkI8HNcSqAL8mwqjYnX
	SZe83msth3vB7mwnJK1JmL2fYRClpmmyNnBL+h9WfO/DocA=
X-Google-Smtp-Source: AGHT+IFEc4P+oh95LTEsSLeRVbfU6mBGECB8PMHw30gUbESltyScgK6F/oxN4q8ypDgHTa5g37jjAkAgU5l7sc24BmA=
X-Received: by 2002:a05:6870:971f:b0:1fa:f195:e3b4 with SMTP id
 n31-20020a056870971f00b001faf195e3b4mr2755801oaq.2.1701465566780; Fri, 01 Dec
 2023 13:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 1 Dec 2023 22:19:15 +0100
Message-ID: <CAJZ5v0gCXED78oLB7wPJ+bn0keQvYzZhyk-XsQVUJrP2i+c-xQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.7-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.7-rc4

with top-most commit 7d4c44a53dade7103c3a9a928705db2326efba6f

 Merge branch 'acpi-tables'

on top of commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab

 Linux 6.7-rc3

to receive ACPI fixes for 6.7-rc4.

This fix a recently introduced build issue on ARM32 and a NULL pointer
dereference in the ACPI backlight driver due to a design issue exposed
by a recent change in the ACPI bus type code.

Specifics:

 - Fix a recently introduced build issue on ARM32 platforms caused by an
   inadvertent header file breakage (Dave Jiang).

 - Eliminate questionable usage of acpi_driver_data() in the ACPI
   backlight cooling device code that leads to NULL pointer dereferences
   after recent ACPI core changes (Hans de Goede).

Thanks!


---------------

Dave Jiang (1):
      ACPI: Fix ARM32 platforms compile issue introduced by fw_table changes

Hans de Goede (1):
      ACPI: video: Use acpi_video_device for cooling-dev driver data

---------------

 drivers/acpi/acpi_video.c | 14 +++++---------
 include/linux/acpi.h      | 22 +++++++++++-----------
 include/linux/fw_table.h  |  3 ---
 lib/fw_table.c            |  2 +-
 4 files changed, 17 insertions(+), 24 deletions(-)

