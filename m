Return-Path: <linux-acpi+bounces-7133-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524DF941F6C
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 20:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F1D282FDF
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 18:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED4B18A6D1;
	Tue, 30 Jul 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="chpwwF+z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FBF188011;
	Tue, 30 Jul 2024 18:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363602; cv=none; b=iUUXc1FMjZmVDGkZgU7ugE+HMhjLLYLX0SWOZts7cFvJp++zQnrpc/DE8F476luGGOBrGie/aSCudWru1T3Am17mTZyvqGW67nr6eIIyOYWH+5DdSFNYHfEIjX3WhQZlxrMBszWkAP/wkZ0r3pK9DkgjNY8AVmtdwyoGqgJhgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363602; c=relaxed/simple;
	bh=f88TzPbRw2gIsi8JN5MNpQBkskOmgv38ZIOH4vl4RkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/iTWLnsLtYfEnH8qtJH/lxXeiwtckPf6OVZYsu5JdPiB/Y5AM8azSlLGKj07/SAeMCZdPAxc+UdTdn5hrj/4AkRhKXCq/NiyDGsZzfq7EYq37z1Rl82VTumUDOsAExyToyZqY58U3TvF+R/flWOISftxhT9J47tBnEQbdwfehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=chpwwF+z reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id ed704e31ff840a14; Tue, 30 Jul 2024 20:19:57 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 67C51956ED0;
	Tue, 30 Jul 2024 20:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1722363597;
	bh=f88TzPbRw2gIsi8JN5MNpQBkskOmgv38ZIOH4vl4RkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=chpwwF+zXvLRKekLDac9QZtw6cFhdtOgvqMGwSudQ1A57nDTbHoJbqjLOL5i+5gnT
	 HMgcZ2W1LqpFeGAhQdpr1ekAHoOS4iIxjnCssClPR8r0YmGzTEJ7UzvBWLFTTrHafT
	 Rdiq61Wac13iEnVLOzvJpQi4q9PKDVnrBUSLJvCvBe/DSwFz9ZZmZoNmqQCHO5xqTs
	 Z1+XqzmTw09TCHwWzG1DNh1Hdt5UHFX+c+InNq2nYQczFzWvw8CGo46MITFqFkg65l
	 +V6MhPhylEo7vhs/aPKFmglrZALZy08YerHvPyWTOI7/ECIeeoZ8zjsx9nuLUkArsj
	 T5eTmXMhuL0wA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 03/17] thermal: core: Drop redundant thermal instance checks
Date: Tue, 30 Jul 2024 20:19:57 +0200
Message-ID: <1852186.3VsfAaAtOV@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuufhprghmkfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=18 Fuz1=18 Fuz2=18

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the trip and cdev pointers are sufficient to idendify a thermal
instance holding them unambiguously, drop the additional thermal zone
checks from two loops walking the list of thermal instances in a
thermal zone.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -850,7 +850,7 @@ int thermal_bind_cdev_to_trip(struct the
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+		if (pos->trip == trip && pos->cdev == cdev) {
 			result = -EEXIST;
 			break;
 		}
@@ -915,7 +915,7 @@ int thermal_unbind_cdev_from_trip(struct
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
-		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
+		if (pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
 			list_del(&pos->cdev_node);
 




