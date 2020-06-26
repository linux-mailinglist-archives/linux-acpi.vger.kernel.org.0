Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF9320A9D8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 02:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFZA1V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Jun 2020 20:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgFZA1U (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Jun 2020 20:27:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E827C08C5DB
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2020 17:27:20 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id d3so5430319pjv.2
        for <linux-acpi@vger.kernel.org>; Thu, 25 Jun 2020 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EfF/SDXieMxdBzzRNR3vjXRP9ELsApXSIPoFiYsV8L8=;
        b=paDQtPIbzZ2WSuFquOtQehWbSHMmSB+a126xQsSFdnJ+LWvXx9zh3xoaXaxtDIWPS1
         aj+RavY/oV4sdZMGj+JxuTxWLKrxKs/vuctrDwS3ssgObe36pmdICn64FKPmAyRHjxwe
         XtehEjQ0v87qVFGKmNVDHwVMoI5Pn9GxvrlDvItnji8r2/359JdayOqIPyCmWStKA9+v
         5bmemCJMXczy9khjne/ZecgDVafiUFo3pgwAosZuPIctUt449NK/rI3VYJ1hM3BWMdSf
         CUP5JOLmNVSWSZ/xqN/vEyuLzjYjfWCuHZX6swe8v49YWnPDTEIbd5ny/cAj9qxjVpkU
         YbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EfF/SDXieMxdBzzRNR3vjXRP9ELsApXSIPoFiYsV8L8=;
        b=gaAwSPplyyCIBIJLCwb21vz4ab3knFkdhsrE/kO91Y5duO5jIL3uS/CMPXJ/pblbZl
         e3mW0EOjCIjzEktpGnGkyLAyk1YKsbm0V334mvsP+ycOVdl4nkdqOJnvn/GzdSgn1bPi
         TnoGaDrrwmkOVqBAfhHm3h6JkwrEKR3FTsICL72LySxXirMQyfRfrltcZsK6l34DOLrN
         AtB2jrZMBKRx0oSjitGhlCc3VgUJ6mRlHFhyYBapQhOosv2yrpEe55LEfXMFnnKOGb7p
         6UpILKKA1vGFBYK/cE/i1LiAEYxdU/NMftMUT3fDJdP35PZMt2M+EhFHNIJA/xZB//W3
         TMpQ==
X-Gm-Message-State: AOAM533Cy7Il9O+Hnnf+X9K/yhGzJnRDVdghTc4p+nNDDlq7QaCWeRVv
        W55syNRm/LcnK45k3zwVcUfLu843lWsX
X-Google-Smtp-Source: ABdhPJyg+Tx781kWCf0f1ygzfZiFbsIs8XO5OHEWZ3G9zVxZL03LpMQELqZK3FRDzjGcWC5sc5IvuWvWCLEp
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr611640pjs.196.1593131239458;
 Thu, 25 Jun 2020 17:27:19 -0700 (PDT)
Date:   Thu, 25 Jun 2020 17:27:10 -0700
In-Reply-To: <20200626002710.110200-1-rajatja@google.com>
Message-Id: <20200626002710.110200-2-rajatja@google.com>
Mime-Version: 1.0
References: <20200626002710.110200-1-rajatja@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 2/2] pci: Add parameter to disable attaching untrusted devices
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
        oohall@gmail.com
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Introduce a PCI parameter that disables the automatic attachment of
untrusted devices to their drivers.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
Context:

  I set out to implement the approach outlined in
    https://lkml.org/lkml/2020/6/9/1331
    https://lkml.org/lkml/2020/6/15/1453

  But to my surprise, I found that the new hotplugged PCI devices
  were getting automatically attached to drivers even though
  /sys/bus/pci/drivers_autoprobe was set to 0.

  I realized that the device core's "drivers_autoprobe":

  * only disables the *initial* probe of the device (i.e. from
    device_add()). If a subsystem calls device_attach() explicitly
    for its devices like PCI subsystem does, the drivers_autoprobe
    setting does not matter. The core will attach device to the driver.
    This looks like correct semantic behavior to me because PCI is
    explicitly calling device_attach(), which is a way to explicitly
    ask the core to find and attach a driver for a device.

  * "drivers_autoprobe" cannot be controlled at boot time (to restrict
    any drivers before userspace comes up).

  The options I considered were:

  1) Change device_attach() so that it takes into consideration the
     drivers_autoprobe property. Not sure if this is semantically correct
     thing to do though. If I do this, then the only way a driver can
     be attached to the drivers would be via userspace
     (/sys/bus/pci/drivers/bind) (Good for our use case though!).

  2) Make the drivers_autoprobe property available to PCI to use
     (currently it is private to device core). The PCI could use this
     to determine whether or not to call device_attach(). This still
     leaves the other problem (of not being able to set
     drivers_autoprobe via command line open).

  3) I found the pci_dev->match_driver, which seemed similar to what I
     am trying to do, but can't be controlled from userspace. I considered
     populating that field based on drivers_autoprobe (still need (2)).
     But the problem is that there is the AMD IOMMU driver which is setting
     this independently, so setting the match_driver based on
     drivers_autoprobe may not be a good idea. May be we can populate it
     for untrusted devicesi, based on the parameter that I'm introducing?

  4) This patch was my option 4 that helps fix both the problems for me.

 drivers/pci/bus.c | 11 ++++++++---
 drivers/pci/pci.c |  9 +++++++++
 drivers/pci/pci.h |  1 +
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3cef835b375fd..336aeeb4c4ebf 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -321,9 +321,14 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_bridge_d3_update(dev);
 
 	dev->match_driver = true;
-	retval = device_attach(&dev->dev);
-	if (retval < 0 && retval != -EPROBE_DEFER)
-		pci_warn(dev, "device attach failed (%d)\n", retval);
+
+	if (dev->untrusted && pci_dont_attach_untrusted_devs) {
+		pci_info(dev, "not attaching untrusted device\n");
+	} else {
+		retval = device_attach(&dev->dev);
+		if (retval < 0 && retval != -EPROBE_DEFER)
+			pci_warn(dev, "device attach failed (%d)\n", retval);
+	}
 
 	pci_dev_assign_added(dev, true);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ce096272f52b1..dec1f9ef27d71 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -127,6 +127,13 @@ static bool pcie_ats_disabled;
 /* If set, the PCI config space of each device is printed during boot. */
 bool pci_early_dump;
 
+/*
+ * If set, the devices with "untrusted" flag shall not be attached automatically
+ * Userspace will need to attach them manually:
+ * echo <pci device>  > /sys/bus/pci/drivers/<driver>/bind
+ */
+bool pci_dont_attach_untrusted_devs;
+
 bool pci_ats_disabled(void)
 {
 	return pcie_ats_disabled;
@@ -6522,6 +6529,8 @@ static int __init pci_setup(char *str)
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
 			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
 				disable_acs_redir_param = str + 18;
+			} else if (!strcmp(str, "dont_attach_untrusted_devs")) {
+				pci_dont_attach_untrusted_devs = true;
 			} else {
 				pr_err("PCI: Unknown option `%s'\n", str);
 			}
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f758671064..30ffad047d926 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -13,6 +13,7 @@
 
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
+extern bool pci_dont_attach_untrusted_devs;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
 bool pcie_cap_has_rtctl(const struct pci_dev *dev);
-- 
2.27.0.212.ge8ba1cc988-goog

