Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCED8E82
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 12:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390379AbfJPKsG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 06:48:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52840 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbfJPKsG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 06:48:06 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id aa54f32a6c5ccca0; Wed, 16 Oct 2019 12:48:02 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [RFT][PATCH 3/3] PM: QoS: Drop frequency QoS types from device PM QoS
Date:   Wed, 16 Oct 2019 12:47:53 +0200
Message-ID: <3223584.6srSoYZK3A@kreacher>
In-Reply-To: <2811202.iOFZ6YHztY@kreacher>
References: <2811202.iOFZ6YHztY@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no more active users of DEV_PM_QOS_MIN_FREQUENCY and
DEV_PM_QOS_MAX_FREQUENCY device PM QoS request types, so drop them
along with the code supporting them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/qos.c |   70 +----------------------------------------------
 include/linux/pm_qos.h   |    8 -----
 2 files changed, 2 insertions(+), 76 deletions(-)

Index: linux-pm/include/linux/pm_qos.h
===================================================================
--- linux-pm.orig/include/linux/pm_qos.h
+++ linux-pm/include/linux/pm_qos.h
@@ -34,8 +34,6 @@ enum pm_qos_flags_status {
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT	PM_QOS_LATENCY_ANY
 #define PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS	PM_QOS_LATENCY_ANY_NS
 #define PM_QOS_LATENCY_TOLERANCE_DEFAULT_VALUE	0
-#define PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE	0
-#define PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE	(-1)
 #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT	(-1)
 
 #define PM_QOS_FLAG_NO_POWER_OFF	(1 << 0)
@@ -54,8 +52,6 @@ struct pm_qos_flags_request {
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
-	DEV_PM_QOS_MIN_FREQUENCY,
-	DEV_PM_QOS_MAX_FREQUENCY,
 	DEV_PM_QOS_FLAGS,
 };
 
@@ -97,14 +93,10 @@ struct pm_qos_flags {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
-	struct pm_qos_constraints min_frequency;
-	struct pm_qos_constraints max_frequency;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
 	struct dev_pm_qos_request *flags_req;
-	struct dev_pm_qos_request *min_frequency_req;
-	struct dev_pm_qos_request *max_frequency_req;
 };
 
 /* Action requested to pm_qos_update_target */
Index: linux-pm/drivers/base/power/qos.c
===================================================================
--- linux-pm.orig/drivers/base/power/qos.c
+++ linux-pm/drivers/base/power/qos.c
@@ -115,20 +115,10 @@ s32 dev_pm_qos_read_value(struct device
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
-	switch (type) {
-	case DEV_PM_QOS_RESUME_LATENCY:
+	if (type == DEV_PM_QOS_RESUME_LATENCY) {
 		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
 			: pm_qos_read_value(&qos->resume_latency);
-		break;
-	case DEV_PM_QOS_MIN_FREQUENCY:
-		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE
-			: pm_qos_read_value(&qos->min_frequency);
-		break;
-	case DEV_PM_QOS_MAX_FREQUENCY:
-		ret = IS_ERR_OR_NULL(qos) ? PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE
-			: pm_qos_read_value(&qos->max_frequency);
-		break;
-	default:
+	} else {
 		WARN_ON(1);
 		ret = 0;
 	}
@@ -169,14 +159,6 @@ static int apply_constraint(struct dev_p
 			req->dev->power.set_latency_tolerance(req->dev, value);
 		}
 		break;
-	case DEV_PM_QOS_MIN_FREQUENCY:
-		ret = pm_qos_update_target(&qos->min_frequency,
-					   &req->data.pnode, action, value);
-		break;
-	case DEV_PM_QOS_MAX_FREQUENCY:
-		ret = pm_qos_update_target(&qos->max_frequency,
-					   &req->data.pnode, action, value);
-		break;
 	case DEV_PM_QOS_FLAGS:
 		ret = pm_qos_update_flags(&qos->flags, &req->data.flr,
 					  action, value);
@@ -227,24 +209,6 @@ static int dev_pm_qos_constraints_alloca
 	c->no_constraint_value = PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT;
 	c->type = PM_QOS_MIN;
 
-	c = &qos->min_frequency;
-	plist_head_init(&c->list);
-	c->target_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
-	c->default_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
-	c->no_constraint_value = PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE;
-	c->type = PM_QOS_MAX;
-	c->notifiers = ++n;
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
-
-	c = &qos->max_frequency;
-	plist_head_init(&c->list);
-	c->target_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
-	c->default_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
-	c->no_constraint_value = PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE;
-	c->type = PM_QOS_MIN;
-	c->notifiers = ++n;
-	BLOCKING_INIT_NOTIFIER_HEAD(n);
-
 	INIT_LIST_HEAD(&qos->flags.list);
 
 	spin_lock_irq(&dev->power.lock);
@@ -305,18 +269,6 @@ void dev_pm_qos_constraints_destroy(stru
 		memset(req, 0, sizeof(*req));
 	}
 
-	c = &qos->min_frequency;
-	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
-		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
-		memset(req, 0, sizeof(*req));
-	}
-
-	c = &qos->max_frequency;
-	plist_for_each_entry_safe(req, tmp, &c->list, data.pnode) {
-		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
-		memset(req, 0, sizeof(*req));
-	}
-
 	f = &qos->flags;
 	list_for_each_entry_safe(req, tmp, &f->list, data.flr.node) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
@@ -428,8 +380,6 @@ static int __dev_pm_qos_update_request(s
 	switch(req->type) {
 	case DEV_PM_QOS_RESUME_LATENCY:
 	case DEV_PM_QOS_LATENCY_TOLERANCE:
-	case DEV_PM_QOS_MIN_FREQUENCY:
-	case DEV_PM_QOS_MAX_FREQUENCY:
 		curr_value = req->data.pnode.prio;
 		break;
 	case DEV_PM_QOS_FLAGS:
@@ -557,14 +507,6 @@ int dev_pm_qos_add_notifier(struct devic
 		ret = blocking_notifier_chain_register(dev->power.qos->resume_latency.notifiers,
 						       notifier);
 		break;
-	case DEV_PM_QOS_MIN_FREQUENCY:
-		ret = blocking_notifier_chain_register(dev->power.qos->min_frequency.notifiers,
-						       notifier);
-		break;
-	case DEV_PM_QOS_MAX_FREQUENCY:
-		ret = blocking_notifier_chain_register(dev->power.qos->max_frequency.notifiers,
-						       notifier);
-		break;
 	default:
 		WARN_ON(1);
 		ret = -EINVAL;
@@ -604,14 +546,6 @@ int dev_pm_qos_remove_notifier(struct de
 		ret = blocking_notifier_chain_unregister(dev->power.qos->resume_latency.notifiers,
 							 notifier);
 		break;
-	case DEV_PM_QOS_MIN_FREQUENCY:
-		ret = blocking_notifier_chain_unregister(dev->power.qos->min_frequency.notifiers,
-							 notifier);
-		break;
-	case DEV_PM_QOS_MAX_FREQUENCY:
-		ret = blocking_notifier_chain_unregister(dev->power.qos->max_frequency.notifiers,
-							 notifier);
-		break;
 	default:
 		WARN_ON(1);
 		ret = -EINVAL;



