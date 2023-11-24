Return-Path: <linux-acpi+bounces-1821-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06A7F7E92
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 19:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0542821D8
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144733CC2
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Nov 2023 18:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34301FD5;
	Fri, 24 Nov 2023 10:24:50 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1efba24b038so560215fac.1;
        Fri, 24 Nov 2023 10:24:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700850290; x=1701455090;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ar+ThvUpj7eV+zdMuBiTJvuCDtNf2SG+hNoODxv3v1w=;
        b=hg3fZrfz7Fq3tBm4HKrW8VEF6pnpwWla5rs8NSUOxXMNLy7bVvvDu1rEe7XdV13wLk
         ponOBPTb0/GV2bTI3VhN94n9AOp/pOIgz1/LJbRC52w3ZOEo7d69vJe0AfdGDifJmJ04
         8XTDDK7VEp1EpFaniPNy3ZXlt0FGwp/7HKcqSt4O2khhjfYiG+AVqptR5+rsO7PMS9Qm
         L6QrNUT67jHi88s5w9/U0IqV+3WLX9N3fsJ/mSRCQea/IMBot7lGl0NtYqx4k8H7Q/fo
         sDGES2PRP/AuH6FeA0IeIaMHcDXedTMnSaz/trWObamu998upMUbvH1Pcb7OUf8NsP1i
         N5+g==
X-Gm-Message-State: AOJu0Yz13V5RkYIeNVaN8BPeL4AbsCGy1WHY12dzWAznPxWrEnpkheCh
	jdbNVC59YBWRCo9LRS1fHJ700vaU8hShn9wavgjKtSpMss0=
X-Google-Smtp-Source: AGHT+IFoDHMU8QraPdePpGYPcbBSRSp8GngdfE13t9o6t1sh46HSOvIACAeBwowK0F9HefziLEYy8kF7q474RxKZjM4=
X-Received: by 2002:a05:6870:f78f:b0:1e9:9440:fe4a with SMTP id
 fs15-20020a056870f78f00b001e99440fe4amr4926193oab.3.1700850290144; Fri, 24
 Nov 2023 10:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 24 Nov 2023 19:24:39 +0100
Message-ID: <CAJZ5v0ikr8Z8KJxqfVzEmCwW4FTg+xLgVKO33D8vqd1XA8+58w@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v6.7-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.7-rc3

with top-most commit e37470624e008579fec020c6be062dd200877129

 Merge branches 'acpi-video' and 'acpi-processor' into acpi

on top of commit 98b1cc82c4affc16f5598d4fa14b1858671b2263

 Linux 6.7-rc2

to receive ACPI fixes for 6.7-rc3.

These add an ACPI IRQ override quirk for ASUS ExpertBook B1402CVA
and fix an ACPI processor idle issue leading to triple-faults in Xen
HVM guests and an ACPI backlight driver issue that causes GPUs to
misbehave while their children power is being fixed up.

Specifics:

 - Avoid powering up GPUs while attempting to fix up power for their
   children (Hans de Goede).

 - Use raw_safe_halt() instead of safe_halt() in acpi_idle_play_dead()
   so as to avoid triple-falts during CPU online in Xen HVM guests due
   to the setting of the hardirqs_enabled flag in safe_halt() (David
   Woodhouse).

 - Add an ACPI IRQ override quirk for ASUS ExpertBook B1402CVA (Hans
   de Goede).

Thanks!


---------------

David Woodhouse (1):
      ACPI: processor_idle: use raw_safe_halt() in acpi_idle_play_dead()

Hans de Goede (3):
      ACPI: PM: Add acpi_device_fix_up_power_children() function
      ACPI: video: Use acpi_device_fix_up_power_children()
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA

---------------

 drivers/acpi/acpi_video.c     |  2 +-
 drivers/acpi/device_pm.c      | 13 +++++++++++++
 drivers/acpi/processor_idle.c |  2 +-
 drivers/acpi/resource.c       |  7 +++++++
 include/acpi/acpi_bus.h       |  1 +
 5 files changed, 23 insertions(+), 2 deletions(-)

