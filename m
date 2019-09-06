Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F0BAB063
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Sep 2019 03:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbfIFBvS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Sep 2019 21:51:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45909 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbfIFBvS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Sep 2019 21:51:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so470548oti.12;
        Thu, 05 Sep 2019 18:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PdszrnvCyYJ1/N3K55Liud7Rvy+uBK6mqVwr3ZYJofk=;
        b=d1j6xdzWg69nfNx2xb9WAumX2TV3PXvSE+G2IyMb301beyZbla4F+NHrljVNXgsY0e
         tvE1jYS3QzN/KzOAC3CtZu+TLQczMKFNDy3MRK3F6lOjEfyP6AIzpH06rsLRy/JJ7h4W
         JribNGoznDc6YSWxHHGx70KB6JY5UTuh3EOIzXZTArgWsMrd5wqqaaJpdWyGUXU/VOy7
         AtOC56VL34AaldrgTupE/H5tEP5oP8y9dUYNB3Db0OMLMMvIW59SAeOGBjLNf4HgF3MP
         d/QuR5L20AiX0JVcqfObmNhLT7tawOEI80TNn+BWsL6MtxgIqw6CPgJzKmVMyFkNSebU
         rp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PdszrnvCyYJ1/N3K55Liud7Rvy+uBK6mqVwr3ZYJofk=;
        b=ehMILvpROjUCPj3EqDJayivRC1GiV71BHidris7q49cvDSq4gQug4ikhmoczwX/zBJ
         InOjO9BjIbQMtCSOhcZn3b3vvvG2bXHcPgx7MvxCYFLAz0qobVhayzV585iTvHHer3GP
         TE9W/7/CugvWPAP9ngCgv+AY0U4rUk15ho1scaMVVyFYw3ApyYqYv8VwUnTp1gajofdx
         az8jHePdwr0AielmoaZVBndBJ/DN8kaTsJaWJnq0Wg0gIgD12AdYDUQilDd5G5qYSYkh
         RY9F9TSiJT3fRGtDhhVl+OLXebPgmpj7yWsF1CxUSxAg+r+hXAdjK23C4vpyZavJh9C0
         l7pw==
X-Gm-Message-State: APjAAAUpDndYyECY7iXQkxWDX0RDb4yXwWmLCSRdBLMY03/MCyYm+Y3k
        5AOm0p+RojeK8GWW9hHRKng=
X-Google-Smtp-Source: APXvYqx7CiUROA6PoykwMCL/Wz/7J6/JPYAFDyuSKOthPup2DAafrXel1Kod31c7nFHFjjDGECaaeg==
X-Received: by 2002:a05:6830:20c6:: with SMTP id z6mr4621063otq.191.1567734677182;
        Thu, 05 Sep 2019 18:51:17 -0700 (PDT)
Received: from chip-MS-7B92.austin.rr.com ([2605:6000:f350:3e00:fc3b:b63b:919f:ceef])
        by smtp.gmail.com with ESMTPSA id e1sm1324097otj.48.2019.09.05.18.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 18:51:16 -0700 (PDT)
From:   Charles Hyde <chip.programmer@gmail.com>
To:     Oliver Neukum <oliver@neukum.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Charles Hyde <charles.hyde@dellteam.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v3 0/3] Add get/set ethernet address functions and ACPI MAC address pass through functionality to cdc_ncm driver
Date:   Thu,  5 Sep 2019 20:51:12 -0500
Message-Id: <20190906015115.12796-1-chip.programmer@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In recent testing of a Dell Universal Dock D6000, I found that MAC
address pass through is not supported in the Linux drivers.  However,
this same device is supported in Windows 10 (Pro) on my personal
computer, in as much as I was able to tell Windows to assign a new MAC
address of my choosing, and I saw through wireshark the new MAC address
was pushed out to the device.  Afterward, Windows reported a new IP
address and I was able to view web pages.

This series of patches give support to cdc_ncm USB based Ethernet
controllers for programming a MAC address to the device, and also to
retrieve the device's MAC address.  This patch series further adds ACPI
MAC address pass through support specifically for the cdc_ncm driver, and
generally for any other driver that may need or want it, in furtherance of
Dell's enterprise IT policy efforts.  It was this latter that I initially
found lacking when testing a D6000 with a Dell laptop, and then I found
ifconfig was unable to set a MAC address into the device.  These patches
bring a similar level of functionality to cdc_ncm driver as is available
with the Realtek r8152 driver, and is available with Windows.

The cdc_ncm driver limits the ACPI MAC address pass through support to
only the Dell Universal Dock D6000, so no other cdc_ncm device will be
impacted.

Today's v3 patch series includes a function named get_ethernet_addr()
which replaces two instances where the same code snippet was located in
teh previous patch series.  I also created a post reset function to set
the MAC address, if there exists an ACPI MAC address pass through (MAPT)
method.  Oliver Neukum had requested a post reset function for this
purpose.


Charles Hyde (3):
  net: cdc_ncm: add get/set ethernet address functions
  ACPI: move ACPI functionality out of r8152 driver
  net: cdc_ncm: Add ACPI MAC address pass through functionality

 drivers/acpi/Makefile            |   1 +
 drivers/acpi/acpi_mac_passthru.c |  63 +++++++++++++
 drivers/net/usb/cdc_ncm.c        | 148 ++++++++++++++++++++++++++++---
 drivers/net/usb/r8152.c          |  44 +--------
 include/acpi/acpi_mac_passthru.h |  27 ++++++
 5 files changed, 232 insertions(+), 51 deletions(-)
 create mode 100644 drivers/acpi/acpi_mac_passthru.c
 create mode 100644 include/acpi/acpi_mac_passthru.h

-- 
2.20.1

