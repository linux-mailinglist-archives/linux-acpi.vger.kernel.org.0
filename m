Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5886E282448
	for <lists+linux-acpi@lfdr.de>; Sat,  3 Oct 2020 15:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgJCNT4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Oct 2020 09:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgJCNTx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Oct 2020 09:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601731191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwMPMobhzodd3LpTbKx7ncPlyXiWAhBwmXqsIKHjwg4=;
        b=ZGXtAxNj2xcOl+K3DSqG/wl8ie0vqsmrbHKNDcVrtxYHVTQyPyddGhMb222bLf1tQ97ExJ
        L4dcUHNeZuueQ8uwcL0lv9G5SJR3rE76QBHm3Qq4Nf3LnAvUuJ4M0ci7Axk626nFU1yqAV
        H0FIeXehZYVtGelDy0V1tMuiCNv5gJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7_qOyy28MqCKlucBrvrcHg-1; Sat, 03 Oct 2020 09:19:47 -0400
X-MC-Unique: 7_qOyy28MqCKlucBrvrcHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE2D801ADE;
        Sat,  3 Oct 2020 13:19:45 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1EEFF73677;
        Sat,  3 Oct 2020 13:19:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
Subject: [RFC] Documentation: Add documentation for new performance_profile sysfs class
Date:   Sat,  3 Oct 2020 15:19:38 +0200
Message-Id: <20201003131938.9426-2-hdegoede@redhat.com>
In-Reply-To: <20201003131938.9426-1-hdegoede@redhat.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On modern systems CPU/GPU/... performance is often dynamically configurable
in the form of e.g. variable clock-speeds and TPD. The performance is often
automatically adjusted to the load by some automatic-mechanism (which may
very well live outside the kernel).

These auto performance-adjustment mechanisms often can be configured with
one of several performance-profiles, with either a bias towards low-power
consumption (and cool and quiet) or towards performance (and higher power
consumption and thermals).

Introduce a new performance_profile class/sysfs API which offers a generic
API for selecting the performance-profile of these automatic-mechanisms.

Cc: Mark Pearson <markpearson@lenovo.com>
Cc: Elia Devito <eliadevito@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Berg <bberg@redhat.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-performance_profile

diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile b/Documentation/ABI/testing/sysfs-class-performance_profile
new file mode 100644
index 000000000000..9c67cae39600
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-performance_profile
@@ -0,0 +1,104 @@
+Performance-profile selection (e.g. /sys/class/performance_profile/thinkpad_acpi/)
+
+On modern systems CPU/GPU/... performance is often dynamically configurable
+in the form of e.g. variable clock-speeds and TPD. The performance is often
+automatically adjusted to the load by some automatic-mechanism (which may
+very well live outside the kernel).
+
+These auto performance-adjustment mechanisms often can be configured with
+one of several performance-profiles, with either a bias towards low-power
+consumption (and cool and quiet) or towards performance (and higher power
+consumption and thermals).
+
+The purpose of the performance_profile class is to offer a generic sysfs
+API for selecting the performance-profile of these automatic-mechanisms.
+
+Note that this API is only for selecting the performance-profile, it is
+NOT a goal of this API to allow monitoring the resulting performance
+characteristics. Monitoring performance is best done with device/vendor
+specific tools such as e.g. turbostat.
+
+Specifically when selecting a high-performance profile the actual achieved
+performance may be limited by various factors such as: the heat generated by
+other components, room temperature, free air flow at the bottom of a laptop,
+etc. It is explicitly NOT a goal of this API to let userspace know about
+any sub-optimal conditions which are impeding reaching the requested
+performance level.
+
+Since numbers are a rather meaningless way to describe performance-profiles
+this API uses strings to describe the various profiles. To make sure that
+userspace gets a consistent experience when using this API this API document
+defines a fixed set of profile-names. Drivers *must* map their internal
+profile representation/names onto this fixed set.
+
+If for some reason there is no good match when mapping then a new profile-name
+may be added. Drivers which wish to introduce new profile-names must:
+1. Have very good reasons to do so.
+2. Add the new profile-name to this document, so that future drivers which also
+   have a similar problem can use the same new. Usually new profile-names will
+   be added to the "extra profile-names" section of this document. But in some
+   cases the set of standard profile-names may be extended.
+
+What:		/sys/class/performance_profile/<device>/available_profiles
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
+					(and also cool and quiet)
+		balanced-low-power:	Balances between low power consumption
+					and performance with a slight bias
+					towards low power
+		balanced:		Balance between low power consumption
+					and performance
+		balanced-performance:	Balances between performance and low
+					power consumption with a slight bias
+					towards performance
+		performance:		Emphasises performance (and may lead to
+					higher temperatures and fan speeds)
+
+		Userspace may expect drivers to offer at least several of these
+		standard profile-names! If none of the above are a good match
+		for some of the drivers profiles, then drivers may use one of
+		these extra profile-names:
+		<reserved for future use>
+
+What:		/sys/class/performance_profile/<device>/current_profile
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Reading this file gives the current selected profile for this
+		device. Writing this file with one of the strings from
+		available_profiles changes the profile to the new value.
+
+		Reading this file may also return "custom". This is intended for
+		drivers which have and export multiple knobs influencing
+		performance. Such drivers may very well still want to offer a
+		set of profiles for easy of use and to be able to offer a
+		consistent standard API (this API) to userspace for configuring
+		their performance. The "custom" value is intended for when a
+		user has directly configured the knobs (through e.g. some
+		advanced control-panel for a GPU) and the knob values do not
+		match any of the presets represented by the
+		performance-profiles. In this case writing this file will
+		override the modifications and restore the selected presets.
+
+What:		/sys/class/performance_profile/<device>/type
+Date:		October 2020
+Contact:	Hans de Goede <hdegoede@redhat.com>
+Description:
+		Performance-profiles may be system-wide, or for a specific
+		device (e.g. CPU / GPU). System-wide profiles are typically
+		used on devices where where a single cooling solution is
+		shared between all components, such as laptops and NUCs.
+
+		Reading this file indicates the type of the device for which
+		the thermal-profile is being configured.
+
+		Valid values: "system"
+		Reserved for future use values: "cpu", "gpu"
-- 
2.28.0

