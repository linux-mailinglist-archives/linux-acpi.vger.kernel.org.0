Return-Path: <linux-acpi+bounces-20622-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK+BJX9wd2m8gAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20622-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:47:43 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD489115
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 14:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF96F3053B38
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 13:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4373633AD90;
	Mon, 26 Jan 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L49Nx+e5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F200433AD8E;
	Mon, 26 Jan 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434963; cv=none; b=qYr3IceIDE6TEBsVo7O5uSKcOOtG/6BoJ+OTb/SpkyaYgBEcBEPh6aKZprpAc9bYJQqNipL0DKzQql1eFv6wgz5bmEhJCLiIlkGMwqvYmC3sazKa7osOenTMU+tN5xZuE7fDTiRnWH9yvxmFYd7BfpMUS+K3ilTfVKLBCNSYBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434963; c=relaxed/simple;
	bh=GDAHXhSRQj0EBC5oOb2IAJ30dteZ5PgXCZacdEcLSNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oMeaDT9h9W4Reg+BfmqwOv2lKdQ5HPRnSdjMxYHXNAXchrQ/5XE1wSPW4lXvzWhQ91QXgi7UJjh+ZnAPbNSheQKnsnLHTyoZC4yA6LihENC2+ywr/S29/heaB0SWQwK1r8f8kctHGFKz0/RW+ljEdq7qu+wb0zfk0mIrfvPTF6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L49Nx+e5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769434956; x=1800970956;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GDAHXhSRQj0EBC5oOb2IAJ30dteZ5PgXCZacdEcLSNI=;
  b=L49Nx+e5NyfS/0jEwGPrPkixyZADK7X23pA8GT+YEXCRfxqSLYcmS7Mo
   FCXbv8njlBdC7PKt3ayN4DxrY7+lc7dk9ul65rleCfyOR1iwH6JrzDpYq
   oq8kGYsTujgRE3yxRFjEuqxnZ8K9CgXTppnRfM9UxC3FJlBEz+phEX97o
   EP10L5twKoNQhrpwjwp+C5T4jzzpp6wOmONbUeBnqMzimE6+4XxqiJz9m
   zC1MqzKqyQha1ATqXYlrjlKcAOxyFY/qWRC3kJpnI4Efl+HS/rIyCoIGD
   NwdwXSKF3TqDW5xVxphzhi526TRtKWo/BaF/4UZAA6+epVISQ7j7SC0Lj
   w==;
X-CSE-ConnectionGUID: +yg/QC5hRmOArciZssG81w==
X-CSE-MsgGUID: GGtV/8gOTge7BDKb/Kp0NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70514002"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="70514002"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 05:42:36 -0800
X-CSE-ConnectionGUID: Rg9mcOUNRK64OyVUSRQ39g==
X-CSE-MsgGUID: SW7xGHSxRembUdfNx8ZO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207566550"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jan 2026 05:42:33 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 70F4E95; Mon, 26 Jan 2026 14:42:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: [PATCH v1 1/1] gpiolib: acpi: Fix potential out-of-boundary left shift
Date: Mon, 26 Jan 2026 14:42:26 +0100
Message-ID: <20260126134226.3617924-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20622-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: EBAD489115
X-Rspamd-Action: no action

GPIO Address Space handler gets a pointer to the in or out value.
This value is supposed to be at least 64-bit, but it's not limited
to be exactly 64-bit. When ACPI tables are being parsed, for
the bigger Connection():s ACPICA creates a Buffer instead of regular
Integer object. The Buffer exists as long as Namespace holds
the certain Connection(). Hence we can access the necessary bits
without worrying. On the other hand, the left shift used in the
code is limited by 31 (on 32-bit platforms) and otherwise considered
to be Undefined Behaviour. Also the code uses only the first 64-bit
address for the value, and anything bigger than	63 will be also
subject to UB. Fix all this by modifying the code to correctly set or
clear the respective bit in the bitmap constructed of 64-bit values.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 83dd227dbbec..da0ab749b4dc 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1104,6 +1104,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
 		struct gpio_desc *desc;
+		u16 vala, valo;
 		bool found;
 
 		mutex_lock(&achip->conn_lock);
@@ -1158,10 +1159,17 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 
 		mutex_unlock(&achip->conn_lock);
 
-		if (function == ACPI_WRITE)
-			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT(i)));
-		else
-			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
+		vala = i / 64;
+		valo = i % 64;
+
+		if (function == ACPI_WRITE) {
+			gpiod_set_raw_value_cansleep(desc, value[vala] & BIT_ULL(valo));
+		} else {
+			if (gpiod_get_raw_value_cansleep(desc))
+				value[vala] |= BIT_ULL(valo);
+			else
+				value[vala] &= ~BIT_ULL(valo);
+		}
 	}
 
 out:
-- 
2.50.1


