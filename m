Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9014F29942F
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788327AbgJZRpT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 13:45:19 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.4]:46198 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437239AbgJZRpS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 13:45:18 -0400
Received: from [100.112.131.148] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.us-west-2.aws.symcld.net id 10/91-27161-A2B079F5; Mon, 26 Oct 2020 17:45:14 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRWlGSWpSXmKPExsWS8eIhj64W9/R
  4g4lLVSz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RovLu+awWXzuPcJo0dTZBGR1TGax
  WL3nBbMDt8ekmTOYPXbOusvu8WvbGhaPzSu0POadDPR4v+8qm8fnTXIB7FGsmXlJ+RUJrBl73
  /5mKpiuVfHswjO2Bsazyl2MXBxCAv8ZJU7u+MgG4bxhlJj57wZzFyMnB5uAtsSWLb+AEhwcIg
  IyEh/WeoKEmQX2Mkns+JsCYgsLJEjsuXmHFcRmEVCVuPp4F5jNK2Aj8fTQJzBbQkBe4mnvcrC
  RnEA1Z7oes4DYQgIqEvcfLGGDqBeUODnzCQvEfHmJ5q2zmSFsCYmDL14wg5wgIaAg8eAKM8TI
  BIllL+8wT2AUmIWkexaS7llIuhcwMq9iNE8qykzPKMlNzMzRNTQw0DU0NNI1NDbUNTPRS6zST
  dQrLdYtTy0u0TXSSywv1iuuzE3OSdHLSy3ZxAiMqJSCZocdjLvffNA7xCjJwaQkyjuFa3q8EF
  9SfkplRmJxRnxRaU5q8SFGGQ4OJQlePpCcYFFqempFWmYOMLph0hIcPEoivDUgad7igsTc4sx
  0iNQpRkUpcd6LnEAJAZBERmkeXBssoVxilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMw7A2Q8
  T2ZeCdz0V0CLmYAWt1VMAVlckoiQkmpg2i1yc9czexXttSpW52epKOsZrGa//5mFJ+367odTH
  566K99VqzMnyeMLT56TcbVsXeTmRF/D4wqSj1jDI+dZnxU4GPflfrbE8bwZ/YeY+g+1z/T8Gf
  2jVzza5dIHq8Pf77oULpEULjj5Yont/F8takffZSmKeaQyTK/qb5mwT+9t32G2SsU9U5zL1Xe
  ffiP3LK1EY5fXzjvBmdVbj//fZ8eacUF4pu4ljrzd89zi+Sp/fvDbtryuR8ln63pb0aj2T0bL
  2ZM69uZMEtnDGHP78e8Ldr75N17I5vhl3AtbdCj71Rfbl6vOhqTvXxzs+FVTdG2utmecg+H7K
  6VHc0tO/f+q1Onzs2L6prqlWvUHlFiKMxINtZiLihMB1+rsrqMDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-14.tower-326.messagelabs.com!1603734313!14205!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26498 invoked from network); 26 Oct 2020 17:45:14 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-14.tower-326.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Oct 2020 17:45:14 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 1CF99C1806C424018A59;
        Mon, 26 Oct 2020 13:45:13 -0400 (EDT)
Received: from localhost.localdomain.com (10.64.83.193) by
 reswpmail04.lenovo.com (10.62.32.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Mon, 26 Oct 2020 10:45:09 -0700
From:   Mark Pearson <markpearson@lenovo.com>
To:     <markpearson@lenovo.com>
CC:     <dvhart@infradead.org>, <mgross@linux.intel.com>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <hadess@hadess.net>, <bberg@redhat.com>,
        <linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] [RFC] Documentation: Add documentation for new platform_profile sysfs attribute
Date:   Mon, 26 Oct 2020 13:44:44 -0400
Message-ID: <20201026174444.866545-1-markpearson@lenovo.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <markpearson@lenovo.com>
References: <markpearson@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.83.193]
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
 .../ABI/testing/sysfs-platform_profile        | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform_profile

diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
new file mode 100644
index 000000000000..37cb6275946c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform_profile
@@ -0,0 +1,85 @@
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
+   have a similar problem can use the same new. Usually new profile-names will
+   be added to the "extra profile-names" section of this document. But in some
+   cases the set of standard profile-names may be extended.
+
+What:		/sys/firmware/acpi/platform_profile_choices
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Reading this file gives a space separated list of profiles
+		supported for this device.
+
+		Drivers must use the following standard profile-names whenever
+		possible:
+
+		low-power:		Emphasises low power consumption
+		quiet:			Offers quieter operation (lower fan
+					speed but with higher performance and
+					temperatures then seen in low-power
+		balanced:		Balance between low power consumption
+					and performance
+		performance:		Emphasises performance (and may lead to
+					higher temperatures and fan speeds)
+
+		Userspace may expect drivers to offer at least several of these
+		standard profile-names! If none of the above are a good match
+		for some of the drivers profiles, then drivers may use one of
+		these extra profile-names:
+		<reserved for future use>
+
+What:		/sys/firmware/acpi/platform_profile
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		available_profiles changes the profile to the new value.
+
+		Reading this file may also return "custom". This is intended for
+		drivers which have and export multiple knobs. Such drivers may
+		very well still want to offer a set of profiles for easy of use
+		and to be able to offer a consistent standard API (this API) to
+		userspace for configuring their performance. The "custom" value
+		is intended for when ai user has directly configured the knobs
+		(through e.g. some advanced control-panel for a GPU) and the
+		knob values do not match any of the presets represented by the
+		platform-profiles. In this case writing this file will
+		override the modifications and restore the selected presets.
+
-- 
2.28.0

