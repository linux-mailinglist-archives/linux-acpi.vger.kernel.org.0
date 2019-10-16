Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F10DCD8E7F
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Oct 2019 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfJPKsG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Oct 2019 06:48:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48603 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbfJPKsG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Oct 2019 06:48:06 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id a18b1f79b1ba11c8; Wed, 16 Oct 2019 12:48:03 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <digetx@gmail.com>
Subject: [RFT][PATCH 1/3] PM: QoS: Introduce frequency QoS
Date:   Wed, 16 Oct 2019 12:41:24 +0200
Message-ID: <4551555.oysnf1Sd0E@kreacher>
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

Introduce frequency QoS, based on the "raw" low-level PM QoS, to
represent min and max frequency requests and aggregate constraints.

The min and max frequency requests are to be represented by
struct freq_qos_request objects and the aggregate constraints are to
be represented by struct freq_constraints objects.  The latter are
expected to be initialized with the help of freq_constraints_init().

The freq_qos_read_value() helper is defined to retrieve the aggregate
constraints values from a given struct freq_constraints object and
there are the freq_qos_add_request(), freq_qos_update_request() and
freq_qos_remove_request() helpers to manipulate the min and max
frequency requests.  It is assumed that the the helpers will not
run concurrently with each other for the same struct freq_qos_request
object, so if that may be the case, their uses must ensure proper
synchronization between them (e.g. through locking).

In addition, freq_qos_add_notifier() and freq_qos_remove_notifier()
are provided to add and remove notifiers that will trigger on aggregate
constraint changes to and from a given struct freq_constraints object,
respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_qos.h |   44 ++++++++
 kernel/power/qos.c     |  240 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 284 insertions(+)

Index: linux-pm/include/linux/pm_qos.h
===================================================================
--- linux-pm.orig/include/linux/pm_qos.h
+++ linux-pm/include/linux/pm_qos.h
@@ -267,4 +267,48 @@ static inline s32 dev_pm_qos_raw_resume_
 }
 #endif
 
+#define FREQ_QOS_MIN_DEFAULT_VALUE	0
+#define FREQ_QOS_MAX_DEFAULT_VALUE	(-1)
+
+enum freq_qos_req_type {
+	FREQ_QOS_MIN = 1,
+	FREQ_QOS_MAX,
+};
+
+struct freq_constraints {
+	struct pm_qos_constraints min_freq;
+	struct blocking_notifier_head min_freq_notifiers;
+	struct pm_qos_constraints max_freq;
+	struct blocking_notifier_head max_freq_notifiers;
+};
+
+struct freq_qos_request {
+	enum freq_qos_req_type type;
+	struct plist_node pnode;
+	struct freq_constraints *qos;
+};
+
+static inline int freq_qos_request_active(struct freq_qos_request *req)
+{
+	return !IS_ERR_OR_NULL(req->qos);
+}
+
+void freq_constraints_init(struct freq_constraints *qos);
+
+s32 freq_qos_read_value(struct freq_constraints *qos,
+			enum freq_qos_req_type type);
+
+int freq_qos_add_request(struct freq_constraints *qos,
+			 struct freq_qos_request *req,
+			 enum freq_qos_req_type type, s32 value);
+int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
+int freq_qos_remove_request(struct freq_qos_request *req);
+
+int freq_qos_add_notifier(struct freq_constraints *qos,
+			  enum freq_qos_req_type type,
+			  struct notifier_block *notifier);
+int freq_qos_remove_notifier(struct freq_constraints *qos,
+			     enum freq_qos_req_type type,
+			     struct notifier_block *notifier);
+
 #endif
Index: linux-pm/kernel/power/qos.c
===================================================================
--- linux-pm.orig/kernel/power/qos.c
+++ linux-pm/kernel/power/qos.c
@@ -650,3 +650,243 @@ static int __init pm_qos_power_init(void
 }
 
 late_initcall(pm_qos_power_init);
+
+/* Definitions related to the frequency QoS below. */
+
+/**
+ * freq_constraints_init - Initialize frequency QoS constraints.
+ * @qos: Frequency QoS constraints to initialize.
+ */
+void freq_constraints_init(struct freq_constraints *qos)
+{
+	struct pm_qos_constraints *c;
+
+	c = &qos->min_freq;
+	plist_head_init(&c->list);
+	c->target_value = FREQ_QOS_MIN_DEFAULT_VALUE;
+	c->default_value = FREQ_QOS_MIN_DEFAULT_VALUE;
+	c->no_constraint_value = FREQ_QOS_MIN_DEFAULT_VALUE;
+	c->type = PM_QOS_MAX;
+	c->notifiers = &qos->min_freq_notifiers;
+	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
+
+	c = &qos->max_freq;
+	plist_head_init(&c->list);
+	c->target_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	c->default_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	c->no_constraint_value = FREQ_QOS_MAX_DEFAULT_VALUE;
+	c->type = PM_QOS_MIN;
+	c->notifiers = &qos->max_freq_notifiers;
+	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
+}
+
+/**
+ * freq_qos_read_value - Get frequency QoS constraint for a given list.
+ * @qos: Constraints to evaluate.
+ * @type: QoS request type.
+ */
+s32 freq_qos_read_value(struct freq_constraints *qos,
+			enum freq_qos_req_type type)
+{
+	s32 ret;
+
+	switch (type) {
+	case FREQ_QOS_MIN:
+		ret = IS_ERR_OR_NULL(qos) ?
+			FREQ_QOS_MIN_DEFAULT_VALUE :
+			pm_qos_read_value(&qos->min_freq);
+		break;
+	case FREQ_QOS_MAX:
+		ret = IS_ERR_OR_NULL(qos) ?
+			FREQ_QOS_MAX_DEFAULT_VALUE :
+			pm_qos_read_value(&qos->max_freq);
+		break;
+	default:
+		WARN_ON(1);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+/**
+ * freq_qos_apply - Add/modify/remove frequency QoS request.
+ * @req: Constraint request to apply.
+ * @action: Action to perform (add/update/remove).
+ * @value: Value to assign to the QoS request.
+ */
+static int freq_qos_apply(struct freq_qos_request *req,
+			  enum pm_qos_req_action action, s32 value)
+{
+	int ret;
+
+	switch(req->type) {
+	case FREQ_QOS_MIN:
+		ret = pm_qos_update_target(&req->qos->min_freq, &req->pnode,
+					   action, value);
+		break;
+	case FREQ_QOS_MAX:
+		ret = pm_qos_update_target(&req->qos->max_freq, &req->pnode,
+					   action, value);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * freq_qos_add_request - Insert new frequency QoS request into a given list.
+ * @qos: Constraints to update.
+ * @req: Preallocated request object.
+ * @type: Request type.
+ * @value: Request value.
+ *
+ * Insert a new entry into the @qos list of requests, recompute the effective
+ * QoS constraint value for that list and initialize the @req object.  The
+ * caller needs to save that object for later use in updates and removal.
+ *
+ * Return 1 if the effective constraint value has changed, 0 if the effective
+ * constraint value has not changed, or a negative error code on failures.
+ */
+int freq_qos_add_request(struct freq_constraints *qos,
+			 struct freq_qos_request *req,
+			 enum freq_qos_req_type type, s32 value)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(qos) || !req)
+		return -EINVAL;
+
+	if (WARN(freq_qos_request_active(req),
+		 "%s() called for active request\n", __func__))
+		return -EINVAL;
+
+	req->qos = qos;
+	req->type = type;
+	ret = freq_qos_apply(req, PM_QOS_ADD_REQ, value);
+	if (ret < 0) {
+		req->qos = NULL;
+		req->type = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(freq_qos_add_request);
+
+/**
+ * freq_qos_update_request - Modify existing frequency QoS request.
+ * @req: Request to modify.
+ * @new_value: New request value.
+ *
+ * Update an existing frequency QoS request along with the effective constraint
+ * value for the list of requests it belongs to.
+ *
+ * Return 1 if the effective constraint value has changed, 0 if the effective
+ * constraint value has not changed, or a negative error code on failures.
+ */
+int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
+{
+	if (!req)
+		return -EINVAL;
+
+	if (WARN(!freq_qos_request_active(req),
+		 "%s() called for unknown object\n", __func__))
+		return -EINVAL;
+
+	if (req->pnode.prio == new_value)
+		return 0;
+
+	return freq_qos_apply(req, PM_QOS_UPDATE_REQ, new_value);
+}
+EXPORT_SYMBOL_GPL(freq_qos_update_request);
+
+/**
+ * freq_qos_remove_request - Remove frequency QoS request from its list.
+ * @req: Request to remove.
+ *
+ * Remove the given frequency QoS request from the list of constraints it
+ * belongs to and recompute the effective constraint value for that list.
+ *
+ * Return 1 if the effective constraint value has changed, 0 if the effective
+ * constraint value has not changed, or a negative error code on failures.
+ */
+int freq_qos_remove_request(struct freq_qos_request *req)
+{
+	if (!req)
+		return -EINVAL;
+
+	if (WARN(!freq_qos_request_active(req),
+		 "%s() called for unknown object\n", __func__))
+		return -EINVAL;
+
+	return freq_qos_apply(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
+}
+EXPORT_SYMBOL_GPL(freq_qos_remove_request);
+
+/**
+ * freq_qos_add_notifier - Add frequency QoS change notifier.
+ * @qos: List of requests to add the notifier to.
+ * @type: Request type.
+ * @notifier: Notifier block to add.
+ */
+int freq_qos_add_notifier(struct freq_constraints *qos,
+			  enum freq_qos_req_type type,
+			  struct notifier_block *notifier)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(qos) || !notifier)
+		return -EINVAL;
+
+	switch (type) {
+	case FREQ_QOS_MIN:
+		ret = blocking_notifier_chain_register(qos->min_freq.notifiers,
+						       notifier);
+		break;
+	case FREQ_QOS_MAX:
+		ret = blocking_notifier_chain_register(qos->max_freq.notifiers,
+						       notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(freq_qos_add_notifier);
+
+/**
+ * freq_qos_remove_notifier - Remove frequency QoS change notifier.
+ * @qos: List of requests to remove the notifier from.
+ * @type: Request type.
+ * @notifier: Notifier block to remove.
+ */
+int freq_qos_remove_notifier(struct freq_constraints *qos,
+			     enum freq_qos_req_type type,
+			     struct notifier_block *notifier)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(qos) || !notifier)
+		return -EINVAL;
+
+	switch (type) {
+	case FREQ_QOS_MIN:
+		ret = blocking_notifier_chain_unregister(qos->min_freq.notifiers,
+							 notifier);
+		break;
+	case FREQ_QOS_MAX:
+		ret = blocking_notifier_chain_unregister(qos->max_freq.notifiers,
+							 notifier);
+		break;
+	default:
+		WARN_ON(1);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(freq_qos_remove_notifier);



