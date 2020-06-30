Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06020ECE8
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jun 2020 06:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgF3Ett (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Jun 2020 00:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgF3Ets (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Jun 2020 00:49:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B887C03E979
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2020 21:49:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r17so21175252ybj.22
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jun 2020 21:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7hLDfRQH9BxeLi4te4CqBue6K7HzO3HL8RSU93kt7FA=;
        b=eJkYImkbmfnxFDU8hfMSme7dtbktJO+dptPEHM9OdfQSJquqzQ2Dunh2RSfdHPb0QW
         Lflu+V+rxJDuJGJNEgAH0tTRKH7f5MqQgf3QW0Z2ck//h43mrzeqbqh0e7nLTIf71cEH
         ++LvFFqJ1jHJpzirL6NEoOQneAUQd9UDn/9Spdl5TObv/Xs3i5rNr1sGPXs3mjGImXnq
         Kqz+FLWa8DEnSdugcjdmJbcrAcQ6bjdXvXnMTyP98VaJ0b09I/lArhactOpdnppimtGy
         AjBG7WoCDugm9DNdgy5doLCdISe0m1Y97+ZJQvrFb3QKqABKPpqA8fRzSHUUaoDHsOeL
         RDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7hLDfRQH9BxeLi4te4CqBue6K7HzO3HL8RSU93kt7FA=;
        b=t09D8Ezw5GtM2VFZRdCWqqyDF70FiRySTw5Y9fjfe7Pm5wzpVlrV07OGwNwLL4GIyz
         b1ziHlO0rVFniTYj9oWhteZWL+hIdS6NjXpBT2nuLli81Lutp52VDwv+LtfnnZToKDCf
         Jjpy+5b1rEmnr4xjrMOOYyOtOGw4B3Q/o8YjOzPJGLVsfqoc46IpDFEsVau0PqWAS18u
         Z5+7tQF/jdxR79h761RXj9QVFF0D+oPa00CnahRvtQ19wvuD5IsrckAyv5c+kwUNPm3Z
         pC+IZuTfMmkQXs8sctcBJfJMqDMFraca0SHsR8eVOpdK9naOjBCaQPVihb9x1w5wlypa
         TzJQ==
X-Gm-Message-State: AOAM532cb3UnE4bwGWLankmSiSPeve0LERlnyjEka8k/l3PLZZt5jBIT
        GkxWjTZSx9Z1v+visw77aaW3K2dFdZ6P
X-Google-Smtp-Source: ABdhPJxrD07NSjDpYr9t7nKiVps1AKnSwgUbfmBRtxm6cbXEYEj7w22JAGn9Re24HqxAzu0RSiaZt3/6TOEw
X-Received: by 2002:a25:a2d1:: with SMTP id c17mr32028859ybn.192.1593492587468;
 Mon, 29 Jun 2020 21:49:47 -0700 (PDT)
Date:   Mon, 29 Jun 2020 21:49:36 -0700
Message-Id: <20200630044943.3425049-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2 0/7] Tighten PCI security, expose dev location in sysfs
From:   Rajat Jain <rajatja@google.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This is a set of loosely related patches most of whom emerged out of
discussion in the following threads. In a nutshell the goal was to allow
an administrator to specify which driver he wants to allow on external
ports, and a strategy was chalked out:
https://lore.kernel.org/linux-pci/20200609210400.GA1461839@bjorn-Precision-5520/
https://lore.kernel.org/linux-pci/20200618184621.GA446639@kroah.com/
https://lore.kernel.org/linux-pci/20200627050225.GA226238@kroah.com/

* The first 3 patches tighten the PCI security using ACS, and take care
  of a border case.
* The 4th patch takes care of PCI bug.
* 5th and 6th patches expose a device's location into the sysfs to allow
  admin to make decision based on that.
* 7th patch is to ensure that the external devices don't bind to drivers
  during boot.

Rajat Jain (7):
  PCI: Keep the ACS capability offset in device
  PCI: Set "untrusted" flag for truly external devices only
  PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing devices
  PCI: Add device even if driver attach failed
  driver core: Add device location to "struct device" and expose it in
    sysfs
  PCI: Move pci_dev->untrusted logic to use device location instead
  PCI: Add parameter to disable attaching external devices

 drivers/base/core.c         | 35 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++---------
 drivers/pci/ats.c           |  2 +-
 drivers/pci/bus.c           | 13 ++++++------
 drivers/pci/of.c            |  2 +-
 drivers/pci/p2pdma.c        |  2 +-
 drivers/pci/pci-acpi.c      | 13 ++++++------
 drivers/pci/pci-driver.c    |  1 +
 drivers/pci/pci.c           | 34 ++++++++++++++++++++++++++----
 drivers/pci/pci.h           |  3 ++-
 drivers/pci/probe.c         | 20 +++++++++++-------
 drivers/pci/quirks.c        | 19 +++++++++++++----
 include/linux/device.h      | 42 +++++++++++++++++++++++++++++++++++++
 include/linux/device/bus.h  |  8 +++++++
 include/linux/pci.h         | 13 ++++++------
 15 files changed, 191 insertions(+), 47 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog

