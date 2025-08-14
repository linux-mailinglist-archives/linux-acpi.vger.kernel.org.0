Return-Path: <linux-acpi+bounces-15664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA3B25B83
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 08:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EF156085B
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 06:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83CB23236D;
	Thu, 14 Aug 2025 06:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmiIXJIT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2650722AE65;
	Thu, 14 Aug 2025 06:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755151437; cv=none; b=ADF3DbJlENjGMhXaHRMdBeaW9JvCNGvAJ8nksczERKmQLPZES8v/FcYqDhUYsle6MJ1pAtj5kx+K8gr5sxmWxb5QzsOP/gFdJK9ih5t2Ntf5vy+juE5JeYwhalkXftUVyMWdCBD5wxPnG3DFx2BLzEj/Jr+rdlCBOamfUjKeJdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755151437; c=relaxed/simple;
	bh=j0vNBj2gpH35ScOLHQLz1YkYvPcpxqiqC0ReXni/6xg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cJ82KvjJBTu1AAERMN1uDj0far9W56m6QCcy6/Oq7nP62/qk6CtcvZJSTDcYVE4dQSYt7GBvKF4c7dJfPoKjCtlfw5oDIRmA3koQcsx+h5YFajhCEryIIjqCnK/H6a27RDLAmegop1oEpjveYj9+06ikq5c9cc07gFU9tAWPDig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmiIXJIT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581c3b43so4439675ad.2;
        Wed, 13 Aug 2025 23:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755151435; x=1755756235; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXSdbUvV7zwhM2KrNQ09Pxxed345/wSQFLElkhqFCsk=;
        b=UmiIXJITJNetxFETs9lpFEwBdDBQM6am28Kia6MIlYRv/6OUZ+6XPLQBbPp8Ou14rH
         5bVgrFL4I4IIvq6UVN5o8JUb6vrUaHVcZHM5H4TX2XUkh0EvRnhAe9B0uBcURXNU4zcc
         yOfa8A0Bu2QtOk5+jE2nNB+Q148o0947gRzcmHUZ00RTKLJdrs1fO1zVjenRJhJIa76E
         VWdy4ytqfwK09jqFuIsg56bg/Bq32vFbIjOXrLTKcJzicvWSD1VZWpM3LH7PsxB2wPA0
         b+qwXC5R/k8avBkl3XMxeCKAMIqJVlXYRgg7Idvt9Ecd8KlskJaTmQdpJJ4xEYI12Dmc
         hbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755151435; x=1755756235;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXSdbUvV7zwhM2KrNQ09Pxxed345/wSQFLElkhqFCsk=;
        b=khqtJK8drql/CNCzCReUC/78CpTCyIqLK3LA5GP8KI+PV8FEugr1GiQD2pEBtrQMCa
         KnZegnSKp8PHtv9PYR9sIMDS8GudEsqxRRNYZncZ4Ud5QRbOJEdWV2m/xinx91ZvmpE6
         DFqmigmm98NqCr8Z6yg5/V7wHqlUHIm9DSqsVTW9x3bxOg2LCDP5qPWZ8KMcca9/95Qt
         LgNhcOHi3ArfA6YTZSqZZAH55Cuvizdni381zR7btJwBWYxTYdGOaDDeX+0i5SCh+3Sw
         scPBpiBhy8wtjcjlWbpl4vZpO9l5K5Gsx4RJaK+Jjm8uYCQ0XEOdcf8AQcCk5VbkXxyK
         aQRw==
X-Forwarded-Encrypted: i=1; AJvYcCUtGrIGUvzzJe8fvMT0lnALDpVlWcjCyda/iBfLiKcJ15lArX3y77Vl9Ljayfajg18egfXsfol7Hzht@vger.kernel.org, AJvYcCWCp3ywBKSKV1Kz9YhdqqmWCUVpNo8FI0+gsEtabAZHoDbyuS7tE8FSXhWoVNY+rscEP8JVPPT7qpHS8fiP@vger.kernel.org
X-Gm-Message-State: AOJu0Yytzel12uwHEfsjRNo+3FVL1PbzWekNkTU4fE1u+syHL35iDn3m
	e9Cr4yfXPCGez4xDyJHhbY0Vy4DQyZ6rcIeaWNZGlqKNKByZ3SogYjz1
X-Gm-Gg: ASbGnctd63XTW83Ibnz7NI+DGQ0LdNtNjyxef/DxJj4PdRUPMw9eFOWx84FVeIXwmvo
	UTZTRTQjIHyiCHJqGBWuQ//W8ilOx41eg3f6hiCPhuvWqpFscMZuW9uy/He/fUiYOMaa0j7norq
	ZuZomnewfFR5mv2XnpV7R3yO64mzHdrW4HoCSstD+tuuP+0BVW3aVjogQTBbBwtQ1JhqA/EWZ//
	OXgN76TdnRPjY/CATsbNXyEsBpszjQekYI5KQh/V6l3lfV0UnMUWoLo9S8jZB3XlAJ70SxE6ZFU
	u1W5o1sLRgQFuJ4LUpVYRmqHhIUvB1ilSN+PLyUdn2m2TYgJWRKTy+oZO2pkMwP7wYTuz/ppDd2
	rRy8ZEmaN73OGr9XrscOROHo=
X-Google-Smtp-Source: AGHT+IGh+C/BbqiOozv0lDUV64n+P/dOZFC/hb8RcQUr/ch7AH7JfXdgNhR0bMXz9N/hI15sWZzFRg==
X-Received: by 2002:a17:903:11c4:b0:240:3584:6174 with SMTP id d9443c01a7336-2445851908fmr24440015ad.21.1755151435177;
        Wed, 13 Aug 2025 23:03:55 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:bd82:9778:4ed6:7372])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0f603sm341999675ad.48.2025.08.13.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:03:54 -0700 (PDT)
Date: Wed, 13 Aug 2025 23:03:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] software node: Constify node_group in registration functions
Message-ID: <2zny5grbgtwbplynxffxg6dkgjgqf45aigwmgxio5stesdr3wi@gf2zamk5amic>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The software_node_register_node_group() and
software_node_unregister_node_group() functions take in essence an
array of pointers to software_node structs. Since the functions do not
modify the array declare the argument as constant, so that static
arrays can be declared as const and annotated as __initconst.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/swnode.c    | 5 ++---
 include/linux/property.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index deda7f35a059..be1e9e61a7bf 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -844,7 +844,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
  * of this function or by ordering the array such that parent comes before
  * child.
  */
-int software_node_register_node_group(const struct software_node **node_group)
+int software_node_register_node_group(const struct software_node * const *node_group)
 {
 	unsigned int i;
 	int ret;
@@ -877,8 +877,7 @@ EXPORT_SYMBOL_GPL(software_node_register_node_group);
  * remove the nodes individually, in the correct order (child before
  * parent).
  */
-void software_node_unregister_node_group(
-		const struct software_node **node_group)
+void software_node_unregister_node_group(const struct software_node * const *node_group)
 {
 	unsigned int i = 0;
 
diff --git a/include/linux/property.h b/include/linux/property.h
index f718dd4789e5..a8cc3e102f45 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -573,8 +573,8 @@ const struct software_node *
 software_node_find_by_name(const struct software_node *parent,
 			   const char *name);
 
-int software_node_register_node_group(const struct software_node **node_group);
-void software_node_unregister_node_group(const struct software_node **node_group);
+int software_node_register_node_group(const struct software_node * const *node_group);
+void software_node_unregister_node_group(const struct software_node * const *node_group);
 
 int software_node_register(const struct software_node *node);
 void software_node_unregister(const struct software_node *node);
-- 
2.51.0.rc0.215.g125493bb4a-goog


-- 
Dmitry

