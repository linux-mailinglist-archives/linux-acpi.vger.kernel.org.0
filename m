Return-Path: <linux-acpi+bounces-7143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97EF941FF1
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABD71C234C6
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6C31AA3F7;
	Tue, 30 Jul 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="eIddPz1q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079731AA3D7;
	Tue, 30 Jul 2024 18:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365127; cv=none; b=i7oaZOU0H0aOh7bF6s8rUD0fG6j/AhB0bmtB3Fdx23nNSP5EMJlSgojrJSRjiumRHRytZolkeT7CgjFhiN8Rt8da/cpoRAj8pgsoPnnQIsB3/5XUhZdwciC4fc+lnWy6ha8MaSjy0qNt4WRjXMMIWI/Ci8a9Sq3UChMNy2pjn5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365127; c=relaxed/simple;
	bh=9n3sj/htmxTFmOWrdZYtljJoFQ7q9bBq4d373ID9rxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3dHHMaII41Lu2hWIY/xuIMZOQfonNwhIc7roj+KSKPOH2kP7kiVaBWNGME09tLE51tEXm+3r76ONIEH2zlkRXImC9wynVfrghJzXrDwdEigbZm4zJmVy53/2o5saTf2FCvr9LULup47G8U3KoiS43RuiqV3BmTpcQHDtNRf9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=eIddPz1q reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 24eb596f75ef3048; Tue, 30 Jul 2024 20:45:23 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 93473956ED0;
	Tue, 30 Jul 2024 20:45:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722365123;
	bh=9n3sj/htmxTFmOWrdZYtljJoFQ7q9bBq4d373ID9rxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIddPz1qN22MdMozvW9jSvdsYlCEooVoDch7IlmTFQ4PkOD6ywHViX49gppj8i0XZ
	 7gQF/xo2MI8qWMLJ0MDi+gaGF4GSHhM6SLpMqlTRFYn1kNx2XC94quqREfPRZYdWcw
	 Mp/9yxNT9VYEeD6pCXh8Jyrm+1p5Bw4rA2yUCmC2lUJNgUTy6+uQVqEe3x6y0Qy5h7
	 dxlGnCOxQvo90QLKGHCqUK6/wMnq5CF0vnoO93vv2wwWOSlO50uwdI7D44ub7Wlh/j
	 xyfFdlr2ENCylgtOKwAqyy3Ys191P/0CeIMfKk33weI5ARPJYIQPsV3UQ8w0Z2toRi
	 OLl1wGWSL2jZA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 02/17] thermal: core: Rearrange checks in
 thermal_bind_cdev_to_trip()
Date: Tue, 30 Jul 2024 20:45:22 +0200
Message-ID: <15273675.JCcGWNJJiE@rjwysocki.net>
In-Reply-To: <1922131.tdWV9SEqCh@rjwysocki.net>
References: <1922131.tdWV9SEqCh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: spam:low
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddufedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=36 Fuz1=36 Fuz2=36

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to look up the thermal zone and the cooling device
in the respective global lists to check whether or not they are
registered.  It is sufficient to check whether or not their respective
list nodes are empty for this purpose.

Use the above observation to simplify thermal_bind_cdev_to_trip().  In
addition, eliminate an unnecessary ternary operator from it.

Moreover, add lockdep_assert_held() for thermal_list_lock to it because
that lock must be held by its callers when it is running.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -781,25 +781,17 @@ int thermal_bind_cdev_to_trip(struct the
 {
 	struct thermal_instance *dev;
 	struct thermal_instance *pos;
-	struct thermal_zone_device *pos1;
-	struct thermal_cooling_device *pos2;
 	bool upper_no_limit;
 	int result;
 
-	list_for_each_entry(pos1, &thermal_tz_list, node) {
-		if (pos1 == tz)
-			break;
-	}
-	list_for_each_entry(pos2, &thermal_cdev_list, node) {
-		if (pos2 == cdev)
-			break;
-	}
+	lockdep_assert_held(&thermal_list_lock);
 
-	if (tz != pos1 || cdev != pos2)
+	if (list_empty(&tz->node) || list_empty(&cdev->node))
 		return -EINVAL;
 
 	/* lower default 0, upper default max_state */
-	lower = lower == THERMAL_NO_LIMIT ? 0 : lower;
+	if (lower == THERMAL_NO_LIMIT)
+		lower = 0;
 
 	if (upper == THERMAL_NO_LIMIT) {
 		upper = cdev->max_state;




