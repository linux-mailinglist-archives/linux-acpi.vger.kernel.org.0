Return-Path: <linux-acpi+bounces-3342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AEC850254
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 04:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8141C240AA
	for <lists+linux-acpi@lfdr.de>; Sat, 10 Feb 2024 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A587472;
	Sat, 10 Feb 2024 03:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJK37S4E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDD15E9B
	for <linux-acpi@vger.kernel.org>; Sat, 10 Feb 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707534363; cv=none; b=dLQ0dF+JEqhtFsI0lAGg+UKlGcwZMjgZJtPG3+C2ff7QPxEkItVxYVYfJo3LCMP4KZp8O12L6fm7BO5fQKhw7tvQo6NE+pq5B5QVHtdHTkkrIYRC6YU4o57f4EZBJ5ppm7Ud5+gmSL3z2Po3IHqsf2hWzQtN4XkFSLgyUjhtLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707534363; c=relaxed/simple;
	bh=iEDFuhE8mOQtSS/B79HZRgChFrCS7/VJXwJaloRdLeI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=QkxEU5F8LwWaeEDV38BWmnKgr3zartzNGc0C5RtiSdY8v/o4YsZVL0EZ/2u/uA51fafO+gDP3aHym+jzWXHK9MIjdpmC8xqqDaRa4t2tTujr4M2ZT/xrNm+9E79r1TJXnZPHlIYWtfpq1AbJh3ivmhbHEGIOn5/fjuzt2OhY2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJK37S4E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1d932f1c0fbso18808615ad.0
        for <linux-acpi@vger.kernel.org>; Fri, 09 Feb 2024 19:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707534361; x=1708139161; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fSy7E0mRmW50qOB3N+Jt7mdFvxY1Kvxhhy9gLys//A=;
        b=RJK37S4EgogTgmG8r4v6aIVIVO9nqQFNXTAaU1tT2aRuHhL0IXlmIl3UcqVF0P+nsm
         20lzJw1/s5hMABm7QxC5NOEuI0hIdfErY1usuhpHFCs0tl5v9ZSOGus/z3zrFZDNoJqA
         aeHf+f3RprulHXkbfiOAkG9xeaSqswgPShQXHJX4WowQxb2st6Aawr7zPSr3WKOytRhj
         sRZeKsidmhC9xO5ufN2pHzlkWKYIDuLWEMGuf8b6o/YdM/FAu2yG4gUnCNY1Pf1No+ky
         Ct/NksQG/Xvl/EuAdjTuwk6zzJxITcV3MgNC/oqVGX4376xG64Ayaq3QSkO5Gq4SDDaL
         4xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707534361; x=1708139161;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5fSy7E0mRmW50qOB3N+Jt7mdFvxY1Kvxhhy9gLys//A=;
        b=neVBAlUCBvmu6+ssnnqLSUloZyWAf0fLzUidGh4dv9nNv143W/gE42dysljkM5xym9
         XZCllVmVaC5DH/UHkAobdYn9VnyOC5m1SF+Y91yEott+abF2RFuFxdab2RE8eru1371A
         4iwNlWPpze4XpF6ozmc8H79QPS/cgtL2sEQPbbi2Dva5xsm0QX5OFaqEbaQRJ4GNC2hO
         jWm15q0T+jGt9MTO6rC/VepZU3chwWQRasZSSY22iHvMV+NxcqE9m2DuHrmIsj8wpNhM
         o0TlUIRcVC3K3w8H/3rWMZJwLBCE6qCxlHHPcIEBiuAf6l44GduckM5d2fnHuIZeiNNQ
         BkGA==
X-Forwarded-Encrypted: i=1; AJvYcCUj/EZrpSP8ZUZ+9q4MKQjQUbFYTfWwlyTptc4x8cOBQhhUwNSlXSPV8vyKnUPAJb/FP4zgjTulnD2PTmL3G9i8FoI8R90QwaYtBw==
X-Gm-Message-State: AOJu0Yz5DljKY9oijAYkTBFoEejqHX3dtWfVsjPNOl04T1+/7eswoyPl
	pyGhLLzjZoVzXMYxMoEeEfOLg8rugXgcd29pDrkDidPzhZgk3jP5htIsy5+CYrNH3KkO59o1X9l
	LK1X+fX4CZs72cQ==
X-Google-Smtp-Source: AGHT+IFWQd3ADLGIN9R/9xvZhHRJ+RPurPLpihD0sq3xyJZb/dJ7ssC6WTUszuSQfK+LYMB6XWbO5ag2vHFXWK0=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6b44:91e7:13e1:5d92])
 (user=saravanak job=sendgmr) by 2002:a17:902:d4ca:b0:1d9:5d39:9438 with SMTP
 id o10-20020a170902d4ca00b001d95d399438mr2814plg.4.1707534360849; Fri, 09 Feb
 2024 19:06:00 -0800 (PST)
Date: Fri,  9 Feb 2024 19:05:45 -0800
In-Reply-To: <20240210030549.4048795-1-saravanak@google.com>
Message-Id: <20240210030549.4048795-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210030549.4048795-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 2/4] driver core: Add FWLINK_FLAG_IGNORE to completely
 ignore a fwnode link
From: Saravana Kannan <saravanak@google.com>
To: Saravana Kannan <saravanak@google.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A fwnode link between specific supplier-consumer fwnodes can be added
multiple times for multiple reasons. If that dependency doesn't exist,
deleting the fwnode link once doesn't guarantee that it won't get created
again.

So, add FWLINK_FLAG_IGNORE flag to mark a fwnode link as one that needs to
be completely ignored. Since a fwnode link's flags is an OR of all the
flags passed to all the fwnode_link_add() calls to create that specific
fwnode link, the FWLINK_FLAG_IGNORE flag is preserved and can be used to
mark a fwnode link as on that need to be completely ignored until it is
deleted.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c    | 9 ++++++++-
 include/linux/fwnode.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 33055001e08e..bd762d90dac0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1010,7 +1010,8 @@ static struct fwnode_handle *fwnode_links_check_suppliers(
 		return NULL;
 
 	list_for_each_entry(link, &fwnode->suppliers, c_hook)
-		if (!(link->flags & FWLINK_FLAG_CYCLE))
+		if (!(link->flags &
+		      (FWLINK_FLAG_CYCLE | FWLINK_FLAG_IGNORE)))
 			return link->supplier;
 
 	return NULL;
@@ -1960,6 +1961,9 @@ static bool __fw_devlink_relax_cycles(struct device *con,
 	}
 
 	list_for_each_entry(link, &sup_handle->suppliers, c_hook) {
+		if (link->flags & FWLINK_FLAG_IGNORE)
+			continue;
+
 		if (__fw_devlink_relax_cycles(con, link->supplier)) {
 			__fwnode_link_cycle(link);
 			ret = true;
@@ -2033,6 +2037,9 @@ static int fw_devlink_create_devlink(struct device *con,
 	int ret = 0;
 	u32 flags;
 
+	if (link->flags & FWLINK_FLAG_IGNORE)
+		return 0;
+
 	if (con->fwnode == link->consumer)
 		flags = fw_devlink_get_flags(link->flags);
 	else
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index c964749953e3..21699eee9641 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -53,8 +53,10 @@ struct fwnode_handle {
  * fwnode link flags
  *
  * CYCLE:	The fwnode link is part of a cycle. Don't defer probe.
+ * IGNORE:	Completely ignore this link, even during cycle detection.
  */
 #define FWLINK_FLAG_CYCLE			BIT(0)
+#define FWLINK_FLAG_IGNORE			BIT(1)
 
 struct fwnode_link {
 	struct fwnode_handle *supplier;
-- 
2.43.0.687.g38aa6559b0-goog


