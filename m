Return-Path: <linux-acpi+bounces-21301-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIcXFzdwpml2PwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21301-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 06:23:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E141E932F
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 06:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EAB0303A112
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 05:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925DA7263B;
	Tue,  3 Mar 2026 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="ABfH6uHm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D83BB48;
	Tue,  3 Mar 2026 05:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772515322; cv=none; b=jagiSjZ/w1X8br6rMuTOdUYZsEpKWW8/9tSxfLDuYsXvoeM3KE0ChxlSE5uUp6bdUcJyGezrPFNzUmKSXHHEP8BdZVf/Bxc5fjyjLLGqFpS9Fhd6FyObdSyAfX8tBFUldqvlZKnWnZbbRU236oREOXyGJ7/0YNti7PWhDtPOnTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772515322; c=relaxed/simple;
	bh=NJRHljmK4dCn9HBxJpHfWdbGwB4zdCQ2Y/BCxUkoE+s=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=pJ9Tfth+5HAqyoYj8SeihQceWCvo0ZARSx84aBgnv34hetm2/fyuL9oVSIH0jGMSILLSN4s1PrQHTjAwpOkXCDwMVOBmWfIw/WipdpZtLL+QpuudmKSyiY+3ztZ1tCKAJLpfzfmyaroB/9P7Q6x3KIJtAaIYi2P4kb7WCvtkBs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cobaltdigital.com; spf=fail smtp.mailfrom=cobaltdigital.com; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=ABfH6uHm; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cobaltdigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cobaltdigital.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1772515314; bh=CXDsVMKPyybRszcxRIEhXdAH0I7glKFE+R9UuY6wqik=;
	h=From:To:Cc:Subject:Date;
	b=ABfH6uHmSr3LIRPEYp7/8ptERJbSWgv9udJNq4ZPuiyf07Mux9CxR2v/JlLDDpCtN
	 uy+aX70oDGQAicEM4sc4fG9T0Gdr5RjFwfAmo9zsKZO2Npi9I8cjDIq4FEJAg36BKu
	 Wc/UHmFIoiasJEKjgD7op0e3iNkA/wmHZAh/skkA/qnP408wsf0/AVRntubRj
Original-Subject: [PATCH] sofware node: Only the managing device can unreference managed software node
Author: mike.isely@cobaltdigital.com
Original-Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Received: from cobalt1.prod.cobalt.internal (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A0004.0000000069A66FF2.000053AF; Mon, 02 Mar 2026 23:21:54 -0600
From: mike.isely@cobaltdigital.com
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: [PATCH] sofware node: Only the managing device can unreference managed software node
Date: Mon,  2 Mar 2026 23:21:41 -0600
Message-ID: <20260303052146.1166717-1-mike.isely@cobaltdigital.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Rspamd-Queue-Id: 66E141E932F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[isely.net:s=deb];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cobaltdigital.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21301-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mike.isely@cobaltdigital.com,linux-acpi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[isely.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pobox.com:email]
X-Rspamd-Action: no action

From: Mike Isely <mike.isely@cobaltdigital.com>

Explanation here is lengthy because the problem is subtle.

A scenario exists where device_create_managed_software_node() is used
to create an swnode instance that will be implicitly shared to a child
device despite best intentions not to permit such sharing (per the
comment in device_create_managed_software_node()).  I encountered this
with the sfp kernel module when it was instantiated with properties
via a call to platform_device_register_full() - it will create hwmon
child devices which get all property references.  Unfortunately with
just a "managed" boolean in struct swnode handling this, then
kobject_put() gets called for the managed aspect when the child device
goes away instead of the parent.  This leads to premature freeing of
the swnode structure, followed by use-after-free problems, heap
corruption, and generally chaos / crashes / misbehavior in the kernel.

This commit changes that boolean into a pointer to the actual managing
struct device, which is then checked against the struct device
instance that is actually going away (via the usual call back into
software_node_notify_remove()).  Thus the child device removal is
ignored as it should, and we only do the kobject_put() when the actual
managing struct device instance goes away.  We effectively carry a
little bit more information now so that we can be sure to clean up
only when the correct struct device instance is actually going away.

Note that while we are now keeping a pointer to a struct device here,
this is safe to do because the pointer itself only stays in use while
the pointed-to device remains valid.  (So no need to be concerned
about additional reference counting.)

Here's a succinct, generic sequence that spells out the steps which
lead to trouble:

  1. Somebody creates a struct device instance.

  2. Somebody calls device_create_managed_software_node() associating
  it with that struct device instance.  This causes two kobject
  references to be counted against the swnode instance (one for the
  struct device and one because the managed flag was set).  refcount=2

  3. Some time later, a child struct device is created and the
  properties of the parent are shared with the child.  This causes
  another kobject reference to be counted against the swnode instance.
  refcount=3

  4. Some time later, that child struct device instance goes
  away (perhaps due to a hotplug removal).  During the tear-down,
  software_node_notify_remove() notices that the managed field of the
  swnode instance is set, so TWO kobject references are removed
  instead of the single reference created by the previous step.
  refcount=1

  5. Repeat step 3.  refcount=2

  6. Repeat step 4.  refcount=0

  7. Now the kobject reference count inside the swnode instance has
  dropped to zero and so the swnode instance is released.  Notice that
  the parent device is still holding a physical reference, now
  pointing into freed memory.  Chaos likely follows.  If lucky, a NULL
  pointer kernel oops is the result.

The patch fixes this by causing step 4 to only do the second reference
decrement if the device being torn down is the same one that
established the managing relationship in the first place.  Then
everything stays balanced.

I confirmed this exact sequence of behavior in the context of the sfp
kernel module with appropriate printk debug trace added, when
instantiated with platform_device_register_full() with properties
provided.  While that's may be hard for to reproduce without sfp
hardware, anything else which performs those steps should produce
similar results.

Note that because platform_device_register_full() will implicitly
employ a managed swnode instance any time it is passed properties in
its pdevinfo argument, then by implication anyone calling
platform_device_register_full() in that manner - which happens in
multiple other places in the kernel - is at risk for the same issue.

Signed-off-by: Mike Isely <mike.isely@cobaltdigital.com>
Signed-off-by: Mike Isely <isely@pobox.com>
---
 drivers/base/swnode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 53b3f0061ad12..18a903a35197c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -36,8 +36,8 @@ struct swnode {
 	struct list_head children;
 	struct swnode *parent;
 
+	struct device *managing_dev;
 	unsigned int allocated:1;
-	unsigned int managed:1;
 };
 
 static DEFINE_IDA(swnode_root_ids);
@@ -1060,7 +1060,7 @@ int device_create_managed_software_node(struct device *dev,
 	if (IS_ERR(fwnode))
 		return PTR_ERR(fwnode);
 
-	to_swnode(fwnode)->managed = true;
+	to_swnode(fwnode)->managing_dev = dev;
 	set_secondary_fwnode(dev, fwnode);
 
 	if (device_is_registered(dev))
@@ -1104,7 +1104,7 @@ void software_node_notify_remove(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "software_node");
 	kobject_put(&swnode->kobj);
 
-	if (swnode->managed) {
+	if (swnode->managing_dev == dev) {
 		set_secondary_fwnode(dev, NULL);
 		kobject_put(&swnode->kobj);
 	}
-- 
2.47.3

---

