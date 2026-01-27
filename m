Return-Path: <linux-acpi+bounces-20650-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHYoNLWceGlurQEAu9opvQ
	(envelope-from <linux-acpi+bounces-20650-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:08:37 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF56993606
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 862E93004C8C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50132C31E;
	Tue, 27 Jan 2026 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPuxB+bf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F930B53B;
	Tue, 27 Jan 2026 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512110; cv=none; b=M0ya9yRyRYuhPjXo2zy96J9KCdTPStbpsFlNFeBL0lNIFpGAqTogRZLELVorUiOEYxaJ/Dt45q809ZsKraII94QbYyoFicuLosSWGJ7hIdr8WmyE1DHmBic9MktVtmTG0+g24IzXD/LBKbwouUYwc3I0WfCXJNSRPAQNL467Dsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512110; c=relaxed/simple;
	bh=cFIOMrzT3uM1rdnO82AA4t4EzjiteWXiAZke6E6rZmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LagWzNV4IGTRykPeDwbje2aw3+JzwmLkEb2RY5yPz626Fugune+kKrwJ3NkfWRxHJbg+blICYoI5SG1ovDd2KjFi1orexbzFIV8oi7RgkWXXki+4IntiNQPTr2szyi6XayBG9+hnOCM/Hh2fO7NyehL1F3J1mh8qiqJP5nKyvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPuxB+bf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769512109; x=1801048109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cFIOMrzT3uM1rdnO82AA4t4EzjiteWXiAZke6E6rZmw=;
  b=GPuxB+bfNMncfpxTGrWl7u89p1KEahNIwfPmcv0ycjSfaBXSiA2TNWnO
   N+tcRHFohDQ6/VnoO0c+JuQNPEoBmjFK8ARO1E0unEVNAHe+5qS2Ac3WQ
   mxWusvj/EywEDC22JLhmlkQJwcGHe1UiwEAAK6o1qQZRx/8ml01XmXUhr
   CUM/p4vA8KDjOLoqNHjP4J/GWTwao33x2YYMlg0a7tkbd01O00e3Drw75
   en/ks3gOwiZzDaiOMpVrYphO8qFZBfPRVld6WPlIQcbx2C5xp2JrKhk7F
   0CZcvJ6tR5ay5sQQxL5IolL51+f1CgBpEUy1adDVRbntdMZI6bHJZJoyX
   g==;
X-CSE-ConnectionGUID: Y3c50WtDTF2dAXyqnQnChg==
X-CSE-MsgGUID: QuSs2QYrQOKI9JKTNBUU7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="82071802"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="82071802"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:08:29 -0800
X-CSE-ConnectionGUID: hy5nwggCRh26hKvGvw3oDw==
X-CSE-MsgGUID: i9s5J883ROSyL5YWfLz71Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="230902479"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jan 2026 03:08:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id EF17B98; Tue, 27 Jan 2026 12:08:25 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Subject: [PATCH v2 1/1] gpiolib: acpi: Fix potential out-of-boundary left shift
Date: Tue, 27 Jan 2026 12:06:30 +0100
Message-ID: <20260127110824.4020130-1-andriy.shevchenko@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20650-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: EF56993606
X-Rspamd-Action: no action

GPIO Address Space handler gets a pointer to the in or out value.
This value is supposed to be at least 64-bit, but it's not limited
to be exactly 64-bit. When ACPI tables are being parsed, for
the bigger Connection():s ACPICA creates a Buffer instead of regular
Integer object. The Buffer exists as long as Namespace holds
the certain Connection(). Hence we can access the necessary bits
without worrying. On the other hand, the left shift, used in
the code, is limited by 31 (on 32-bit platforms) and otherwise
considered to be Undefined Behaviour. Also the code uses only
the first 64-bit word for the value, and anything bigger than 63
will be also subject to UB. Fix all this by modifying the code
to correctly set or clear the respective bit in the bitmap constructed
of 64-bit words.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added a comment, named variables differently (Mika), rebased on top of accepted patch
 drivers/gpio/gpiolib-acpi-core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index d42f769eeb11..9627b3a9c7f3 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -1104,6 +1104,7 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 		unsigned int pin = agpio->pin_table[i];
 		struct acpi_gpio_connection *conn;
 		struct gpio_desc *desc;
+		u16 word, shift;
 		bool found;
 
 		mutex_lock(&achip->conn_lock);
@@ -1158,10 +1159,22 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 
 		mutex_unlock(&achip->conn_lock);
 
-		if (function == ACPI_WRITE)
-			gpiod_set_raw_value_cansleep(desc, !!(*value & BIT_ULL(i)));
-		else
-			*value |= (u64)gpiod_get_raw_value_cansleep(desc) << i;
+		/*
+		 * For the cases when OperationRegion() consists of more than
+		 * 64 bits calculate the word and bit shift to use that one to
+		 * access the value.
+		 */
+		word = i / 64;
+		shift = i % 64;
+
+		if (function == ACPI_WRITE) {
+			gpiod_set_raw_value_cansleep(desc, value[word] & BIT_ULL(shift));
+		} else {
+			if (gpiod_get_raw_value_cansleep(desc))
+				value[word] |= BIT_ULL(shift);
+			else
+				value[word] &= ~BIT_ULL(shift);
+		}
 	}
 
 out:
-- 
2.50.1


