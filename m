Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78519BF07
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 12:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgDBKDe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 06:03:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:9961 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDBKDe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 06:03:34 -0400
IronPort-SDR: VNtJCpi3C0hajX7Pb9sW+Yi/Fwa/+z5ZsXVrwY7Ly9Jp6OtRXHdLgEFEaorQi6RQS8Twffytjq
 ZFXCGgJ3ij+w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 03:03:33 -0700
IronPort-SDR: SWftxASmWsrHWKHUlQKXRotx3DqavKlCC8J4s1r3GXLtJ+UrMVQwJ7unwzzc/SOuiFmjfX8HKJ
 qot8dldoGrAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="252944095"
Received: from lyan3-mobl.ccr.corp.intel.com ([10.255.28.246])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2020 03:03:31 -0700
Message-ID: <0926f44775e91145a83c9eb88a468c64261af20d.camel@intel.com>
Subject: Re: OOB access on ACPI processor thermal device via sysfs write
From:   Zhang Rui <rui.zhang@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Apr 2020 18:03:30 +0800
In-Reply-To: <s5h1rp6w97p.wl-tiwai@suse.de>
References: <s5h5zeiwd01.wl-tiwai@suse.de>
         <744357E9AAD1214791ACBA4B0B90926377CEB399@SHSMSX108.ccr.corp.intel.com>
         <s5h1rp6w97p.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2020-04-02 at 11:03 +0200, Takashi Iwai wrote:
> On Thu, 02 Apr 2020 09:47:50 +0200,
> Zhang, Rui wrote:
> > 
> > CC Viresh.
> > 
> > Yes, I've received it.
> > 
> > To me, there is not a hard rule that the cooling device max_state
> > must be static.
> > We should be able to detect the max_state change and reset the
> > stats table when necessary.
> > 
> > I just finished a prototype patch to do so, and will paste it
> > later.
> 
> Great, that sounds like a feasible option, indeed.
> 
> 
Please try the patch below and see if the problem goes away or not.

From 7b429674a0e1a6226734c8919b876bb57d946b1d Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Thu, 2 Apr 2020 11:18:44 +0800
Subject: [RFC PATCH] thermal: update thermal stats table when max cooling
 state changed

The maximum cooling state of a cooling device may be changed at
runtime. Thus the statistics table must be updated to handle the real
maximum cooling states supported.

This fixes an OOB issue when updating the statistics of the processor
cooling device, because it only supports 1 cooling state before cpufreq
driver loaded.

Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
Reported-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sysfs.c | 38 +++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..c69173eb4b24 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -755,6 +755,9 @@ struct cooling_dev_stats {
 	unsigned int *trans_table;
 };
 
+static int cooling_device_stats_table_update(struct thermal_cooling_device *cdev);
+static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev);
+
 static void update_time_in_state(struct cooling_dev_stats *stats)
 {
 	ktime_t now = ktime_get(), delta;
@@ -768,8 +771,12 @@ static void update_time_in_state(struct cooling_dev_stats *stats)
 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 					 unsigned long new_state)
 {
-	struct cooling_dev_stats *stats = cdev->stats;
+	struct cooling_dev_stats *stats;
 
+	if (cooling_device_stats_table_update(cdev))
+		return;
+
+	stats = cdev->stats;
 	spin_lock(&stats->lock);
 
 	if (stats->state == new_state)
@@ -904,24 +911,32 @@ static const struct attribute_group cooling_device_stats_attr_group = {
 	.name = "stats"
 };
 
-static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
+static int cooling_device_stats_table_update(struct thermal_cooling_device *cdev)
 {
 	struct cooling_dev_stats *stats;
 	unsigned long states;
-	int var;
+	int var, ret;
 
-	if (cdev->ops->get_max_state(cdev, &states))
-		return;
+	ret = cdev->ops->get_max_state(cdev, &states);
+	if (ret)
+		return ret;
 
 	states++; /* Total number of states is highest state + 1 */
 
+	stats = cdev->stats;
+	if (stats) {
+		if (stats->max_states == states)
+			return 0;
+		else
+			cooling_device_stats_destroy(cdev);
+	}
+
 	var = sizeof(*stats);
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
-
 	stats = kzalloc(var, GFP_KERNEL);
 	if (!stats)
-		return;
+		return -ENOMEM;
 
 	stats->time_in_state = (ktime_t *)(stats + 1);
 	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
@@ -930,6 +945,15 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	stats->max_states = states;
 
 	spin_lock_init(&stats->lock);
+	return 0;
+}
+
+static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
+{
+	int var;
+
+	if (cooling_device_stats_table_update(cdev))
+		return;
 
 	/* Fill the empty slot left in cooling_device_attr_groups */
 	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
-- 
2.17.1


