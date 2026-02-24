Return-Path: <linux-acpi+bounces-21140-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAQfIgb7nWmeSwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21140-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 20:24:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1930318C058
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 20:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31424307B201
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 19:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14163ACA6A;
	Tue, 24 Feb 2026 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="AsaQEA/w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC183ACA60;
	Tue, 24 Feb 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961083; cv=none; b=MWCRrIBkyKsE1T5Ipi6qHCeEi4O54DMjGaBS9TEzhpcifzecQ26vOKieABnDWK/C32n4XonurCcytlu0Ap4d2Np0KPH9bMQuDgl0a2wq4kItNOTybX/tXNoZOsa+Y9YOWff1hxqchMh4PyuqaRUFqgsVnA3rCWV1RTe6eMTMg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961083; c=relaxed/simple;
	bh=P0/TTO8pzv23txP1028WtYIaRtSQrDcnutHTO5onWEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WRY7inFmZUqHlyEBPLDZXRipjW80RWB/if57MHO/s5/+rAyPEPR0Tb6CPyaYtdl4jDXV8OFU2FbTEc5E8KI29b9O7vJ5HGf8C98k2lhcmLV/BI5woBrubX+MLGK8FLUt6PXOwVgEvVREHYDwIZaQ4Akkkn9iwk/rLB0CEYnuO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cobaltdigital.com; spf=fail smtp.mailfrom=cobaltdigital.com; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=AsaQEA/w; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cobaltdigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cobaltdigital.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1771960775; bh=Ar+4u8MdyZN+umjANRDKc5FqJw2I9UKQXK1yqrmanSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AsaQEA/wHzjrfZZIbGbFOHTB1gBL6yZ/kqXOSa77L2IYds0S/0U4IhT3HoqqDpAdi
	 d0X7Q7DOeV37mwcVN2oxjr84mcOzVwhTriH+WSWYR8AT89gmdbPzWEbmFOmxQbZd9T
	 j68l+lLAAKTUDSVQWMP963L3f+Jn7G/QhKfB1Pv1lyiR6d2kWRXYqlZkhUoIM
Original-Subject: [PATCH 1/1] sofware node: Only the managing device can unreference managed software node
Author: mike.isely@cobaltdigital.com
Original-Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Received: from cobalt1.prod.cobalt.internal (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A000A.00000000699DF9C7.000069D2; Tue, 24 Feb 2026 13:19:35 -0600
From: mike.isely@cobaltdigital.com
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] sofware node: Only the managing device can unreference managed software node
Date: Tue, 24 Feb 2026 13:19:22 -0600
Message-ID: <20260224191922.2972974-2-mike.isely@cobaltdigital.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
References: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[isely.net:s=deb];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[cobaltdigital.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21140-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mike.isely@cobaltdigital.com,linux-acpi@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[isely.net:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pobox.com:email]
X-Rspamd-Queue-Id: 1930318C058
X-Rspamd-Action: no action

From: Mike Isely <mike.isely@cobaltdigital.com>

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

Signed-off-by: Mike Isely <isely@pobox.com>
---
 drivers/base/swnode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 16a8301c25d63..2ead8e4062f63 100644
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
@@ -1078,7 +1078,7 @@ int device_create_managed_software_node(struct device *dev,
 	if (IS_ERR(fwnode))
 		return PTR_ERR(fwnode);
 
-	to_swnode(fwnode)->managed = true;
+	to_swnode(fwnode)->managing_dev = dev;
 	set_secondary_fwnode(dev, fwnode);
 
 	if (device_is_registered(dev))
@@ -1121,7 +1121,7 @@ void software_node_notify_remove(struct device *dev)
 	sysfs_remove_link(&dev->kobj, "software_node");
 	kobject_put(&swnode->kobj);
 
-	if (swnode->managed) {
+	if (swnode->managing_dev == dev) {
 		set_secondary_fwnode(dev, NULL);
 		kobject_put(&swnode->kobj);
 	}
-- 
2.47.3


