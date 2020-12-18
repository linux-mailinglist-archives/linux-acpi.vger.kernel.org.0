Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9202DE894
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Dec 2020 18:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgLRRyd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 12:54:33 -0500
Received: from mail1.bemta24.messagelabs.com ([67.219.250.113]:12905 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgLRRyc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 18 Dec 2020 12:54:32 -0500
Received: from [100.112.132.72] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.us-west-2.aws.symcld.net id 42/98-28581-F8BECDF5; Fri, 18 Dec 2020 17:49:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsWSLveKTbf/9Z1
  4gzmTJC32X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RoumziY2i88dk1ksVu95wWyx9ss8
  Noszpy+xOnB7TJo5g9lj56y77B6/tq1h8di8Qstj3slAj562TUwe7/ddZfPYcrWdxePzJrkAz
  ijWzLyk/IoE1ozJ97UKnutUXJ2zla2B8aZaFyMXh5DAf0aJy5+uskA4DxklNsxrY+pi5ORgE9
  CW2LLlF1sXIweHiICMxIe1niBhZoFtTBK9+4JAbGGBRInOG9NYQWwWAVWJC70LwWxeARuJna3
  72UFsCQF5iae9y5lBbE6gmjNdj1lAbCEBFYn7D5awQdQLSpyc+YQFYr68RPPW2cwQtoTEwRcv
  mCHmKEgsevafDcJOkFj28g7zBEaBWUjaZyFpn4WkfQEj8ypG86SizPSMktzEzBxdQwMDXUNDI
  11DYyNdM2O9xCrdJL3SYt3y1OISXSO9xPJiveLK3OScFL281JJNjMAoSylosd/BOOPNB71DjJ
  IcTEqivFoP7sQL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuAtfwWUEyxKTU+tSMvMAUY8TFqCg0d
  JhDfoJVCat7ggMbc4Mx0idYpRUUqcd9NDoIQASCKjNA+uDZZkLjHKSgnzMjIwMAjxFKQW5WaW
  oMq/YhTnYFQS5g0EGc+TmVcCN/0V0GImoMV8M26DLC5JREhJNTD1FOjo1MjtdHkup2Y9J6yA5
  5CG3kYrtZtH+g6zFZ/xWxt1wPnpAk/tn+vrhLPn3XjBesda5+UW2S2s/2ILHASTV+4I379ZiK
  lVeAHvpH9l67VnT/xyxdn94z0PzkvzvAJatrTcKD9Saxv0fOvq4/VOgZtjXiROKGOR3y7Hs27
  eU1aRqqqsRKeGG0eKdl/tXsbfX/xMzKYtp3rW2RVNc77KbGvNrAuq/qbTckb0jtvmncGhDScj
  2+ccvadqLr07V2Nr6sx1DS+/hjSed3fjecoVZnql45i09rl1m66dsTxxdkdT6UpNtZP/9r7Ym
  Ohh5hC+TFr7QfDHKa8vRS15yZYz05nRzYGta9kdhTM/VE8psRRnJBpqMRcVJwIA7u0oQa0DAA
  A=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-23.tower-355.messagelabs.com!1608313741!2698!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17089 invoked from network); 18 Dec 2020 17:49:03 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-23.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Dec 2020 17:49:03 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id DE37AB9277B14558C298;
        Sat, 19 Dec 2020 01:48:58 +0800 (CST)
Received: from localhost.home (10.64.89.183) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 18 Dec
 2020 09:48:53 -0800
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <hdegoede@redhat.com>, <mgross@linux.intel.com>,
        <rjw@rjwysocki.net>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <hadess@hadess.net>,
        <pobrn@protonmail.com>, <mario.limonciello@dell.com>,
        <eliadevito@gmail.com>, <bberg@redhat.com>, <dvhart@infradead.org>,
        <njoshi1@lenovo.com>
Subject: [PATCH v7 1/3] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Fri, 18 Dec 2020 12:47:57 -0500
Message-ID: <20201218174759.667457-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.89.183]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On modern systems the platform performance, temperature, fan and other
hardware related characteristics are often dynamically configurable. The
profile is often automatically adjusted to the load by some
automatic-mechanism (which may very well live outside the kernel).

These auto platform-adjustment mechanisms often can be configured with
one of several 'platform-profiles', with either a bias towards low-power
consumption or towards performance (and higher power consumption and
thermals).

Introduce a new platform_profile sysfs API which offers a generic API for
selecting the performance-profile of these automatic-mechanisms.

Co-developed-by: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Mark Pearson <markpearson@lenovo.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
 - updated to rst format
Changes in v3, v4, v5
 - version bump along with rest of patch series
Changes in v6:
 - Split sysfs-platform_profile.rs into ABI text and then admin guide in
   userspace-api section. Hope this is correct - I'm guessing a bit.
Changes in v7:
 - Correct available_choices to platform_profile_choices
 - Improve phrasing as recommended by review

 .../ABI/testing/sysfs-platform_profile        | 24 ++++++++++
 Documentation/userspace-api/index.rst         |  1 +
 .../userspace-api/sysfs-platform_profile.rst  | 44 +++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
 create mode 100644 Documentation/userspace-api/sysfs-platform_profile.rst

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
new file mode 100644
index 000000000000..9d6b89b66cca
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -0,0 +1,24 @@
+What:		/sys/firmware/acpi/platform_profile_choices
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:	This file contains a space-separated list of profiles supported for this device.
+
+		Drivers must use the following standard profile-names:
+
+		============	============================================
+		low-power	Low power consumption
+		cool		Cooler operation
+		quiet		Quieter operation
+		balanced	Balance between low power consumption and performance
+		performance	High performance operation
+		============	============================================
+
+		Userspace may expect drivers to offer more than one of these
+		standard profile names.
+
+What:		/sys/firmware/acpi/platform_profile
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:	Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		platform_profile_choices changes the profile to the new value.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index acd2cc2a538d..d29b020e5622 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -24,6 +24,7 @@ place where this information is gathered.
    ioctl/index
    iommu
    media/index
+   sysfs-platform_profile
 
 .. only::  subproject and html
 
diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
new file mode 100644
index 000000000000..046bf2f3ffd0
--- /dev/null
+++ b/Documentation/userspace-api/sysfs-platform_profile.rst
@@ -0,0 +1,44 @@
+=====================================================================
+Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
+=====================================================================
+
+On modern systems the platform performance, temperature, fan and other
+hardware related characteristics are often dynamically configurable. The
+platform configuration is often automatically adjusted to the current
+conditions by some automatic mechanism (which may very well live outside
+the kernel).
+
+These auto platform adjustment mechanisms often can be configured with
+one of several platform profiles, with either a bias towards low power
+operation or towards performance.
+
+The purpose of the platform_profile attribute is to offer a generic sysfs
+API for selecting the platform profile of these automatic mechanisms.
+
+Note that this API is only for selecting the platform profile, it is
+NOT a goal of this API to allow monitoring the resulting performance
+characteristics. Monitoring performance is best done with device/vendor
+specific tools such as e.g. turbostat.
+
+Specifically when selecting a high performance profile the actual achieved
+performance may be limited by various factors such as: the heat generated
+by other components, room temperature, free air flow at the bottom of a
+laptop, etc. It is explicitly NOT a goal of this API to let userspace know
+about any sub-optimal conditions which are impeding reaching the requested
+performance level.
+
+Since numbers on their own cannot represent the multiple variables that a
+profile will adjust (power consumption, heat generation, etc) this API
+uses strings to describe the various profiles. To make sure that userspace
+gets a consistent experience the sysfs-platform_profile ABI document defines
+a fixed set of profile names. Drivers *must* map their internal profile
+representation onto this fixed set.
+
+If there is no good match when mapping then a new profile name may be
+added. Drivers which wish to introduce new profile names must:
+
+ 1. Explain why the existing profile names canot be used.
+ 2. Add the new profile name, along with a clear description of the
+    expected behaviour, to the sysfs-platform_profile ABI documentation.
+
+
-- 
2.28.0

