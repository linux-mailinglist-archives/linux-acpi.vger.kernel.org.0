Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E829BD92
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 17:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811850AbgJ0Qmw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 12:42:52 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:24365 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1811836AbgJ0Qmu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 12:42:50 -0400
Received: from [100.112.135.1] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id 06/B9-42875-70E489F5; Tue, 27 Oct 2020 16:42:47 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleJIrShJLcpLzFFi42JJl3vFpsvuNyP
  eYMFWUYv91yUsuhYaWCy8f4rV4uu32+wWb45PZ7JYvq+f0eLyrjlsFp97jzBaNHU2AVkdk1ks
  Vu95wezA7TFp5gxmj52z7rJ7/Nq2hsVj8wotj3knAz3e77vK5vF5k1wAexRrZl5SfkUCa8aZs
  5IFX5UqFt7KamB8ItvFyMUhJPCfUeLZ8cWMXYycQM4bRomXG4tAbDYBbYktW36xdTFycIgIyE
  h8WOsJEmYW2MskseNvCogtLBAl8f1JDwuIzSKgKvFt2142EJtXwEbi0KxnYCMlBOQlnvYuZwa
  xOYFqznQ9ZoFYpSJx/8ESqHpBiZMzn7BAzJeXaN46mxnClpA4+OIFM8QcBYlvd78xQdgJEste
  3mGewCgwC0n7LCTts5C0L2BkXsVollSUmZ5RkpuYmaNraGCga2hopGtobKRroZdYpZukV1qsW
  55aXKJrpJdYXqxXXJmbnJOil5dasokRGEspBS0cOxgPv/6gd4hRkoNJSZR3iceMeCG+pPyUyo
  zE4oz4otKc1OJDjDIcHEoSvNo+QDnBotT01Iq0zBxgXMOkJTh4lER4J4KkeYsLEnOLM9MhUqc
  YFaXEedeDJARAEhmleXBtsFRyiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw73uQKTyZeSVw
  018BLWYCWtxWMQVkcUkiQkqqgcn59Gm9FSua+vveO7mYvo+/91DQvyVvwZTpfzdl/X74vu/vr
  Orgx6mu6+pPy37e3RMQuXj73KVfHi3dXrA2ZbHR5mlJz84//3krcR/7jC1PD15u3K5boKJ5Me
  Dt0nPXplsozH9WMslVuZt9ckdOgO2NS+ImqQcebKqcnsE2w1xJbM5m17Cj8615Drkff6GUFVh
  4efKqlVz9+huuMczfV/coQyPy+ppXU2bPU883U8na5tHQ9G3Ts2W/qx7l+keazb+b5lSZ7xv+
  Iz1Xx1sgMGOn16Uz+otM3gt+XVlf8P7bPkapCdk5V3e/f8grV+sQHige5vFvsUSE5dqwhF0tK
  1j177qv3PM04lVuKZPn5CUiSizFGYmGWsxFxYkA1pxFwqADAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-3.tower-355.messagelabs.com!1603816965!7460!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16068 invoked from network); 27 Oct 2020 16:42:47 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-3.tower-355.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2020 16:42:47 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 7B7A14184040F8AEE639;
        Wed, 28 Oct 2020 00:42:42 +0800 (CST)
Received: from localhost.localdomain.com (10.64.85.148) by
 reswpmail04.lenovo.com (10.62.32.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 27 Oct 2020 09:42:37 -0700
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <dvhart@infradead.org>, <mgross@linux.intel.com>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Tue, 27 Oct 2020 12:42:19 -0400
Message-ID: <20201027164219.868839-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.85.148]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

On modern systems the platform performance, temperature, fan and other
hardware related characteristics are often dynamically configurable. The
profile is often automatically adjusted to the load by somei
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
Changes in V1:
 - Moved from RFC to proposed patch
 - Added cool profile as requested
 - removed extra-profiles as no longer relevant

 .../ABI/testing/sysfs-platform_profile        | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
new file mode 100644
index 000000000000..240bd3d7532b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -0,0 +1,66 @@
+Platform-profile selection (e.g. /sys/firmware/acpi/platform_profile)
+
+On modern systems the platform performance, temperature, fan and other
+hardware related characteristics are often dynamically configurable. The
+profile is often automatically adjusted to the load by some
+automatic-mechanism (which may very well live outside the kernel).
+
+These auto platform-adjustment mechanisms often can be configured with
+one of several 'platform-profiles', with either a bias towards low-power
+consumption or towards performance (and higher power consumption and
+thermals).
+
+The purpose of the platform_profile attribute is to offer a generic sysfs
+API for selecting the platform-profile of these automatic-mechanisms.
+
+Note that this API is only for selecting the platform-profile, it is
+NOT a goal of this API to allow monitoring the resulting performance
+characteristics. Monitoring performance is best done with device/vendor
+specific tools such as e.g. turbostat.
+
+Specifically when selecting a high-performance profile the actual achieved
+performance may be limited by various factors such as: the heat generated
+by other components, room temperature, free air flow at the bottom of a
+laptop, etc. It is explicitly NOT a goal of this API to let userspace know
+about any sub-optimal conditions which are impeding reaching the requested
+performance level.
+
+Since numbers are a rather meaningless way to describe platform-profiles
+this API uses strings to describe the various profiles. To make sure that
+userspace gets a consistent experience when using this API this API
+document defines a fixed set of profile-names. Drivers *must* map their
+internal profile representation/names onto this fixed set.
+
+If for some reason there is no good match when mapping then a new profile-name
+may be added. Drivers which wish to introduce new profile-names must:
+1. Have very good reasons to do so.
+2. Add the new profile-name to this document, so that future drivers which also
+   have a similar problem can use the same name.
+
+What:		/sys/firmware/acpi/platform_profile_choices
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Reading this file gives a space separated list of profiles
+		supported for this device.
+
+		Drivers must use the following standard profile-names:
+
+		low-power:		Emphasises low power consumption
+		cool:			Emphasises cooler operation
+		quiet:			Emphasises quieter operation
+		balanced:		Balance between low power consumption
+					and performance
+		performance:		Emphasises performance (and may lead to
+					higher temperatures and fan speeds)
+
+		Userspace may expect drivers to offer at least several of these
+		standard profile-names.
+
+What:		/sys/firmware/acpi/platform_profile
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		available_profiles changes the profile to the new value.
-- 
2.28.0

