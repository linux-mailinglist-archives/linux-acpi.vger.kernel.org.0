Return-Path: <linux-acpi+bounces-8335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9897C4BF
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC761F22405
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86225192591;
	Thu, 19 Sep 2024 07:18:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from spindle.queued.net (spindle.queued.net [45.33.49.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D018F2DB;
	Thu, 19 Sep 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.49.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730326; cv=none; b=dNmcbxwehKt0ZUHA/DEnu5MdsXG5vvpdinZB2Jhsq3G2JAX2hJoRLdl06No2dEse244O/Lch6pNimY+tJaIZ/g3dTT8ESmgpNOHk8Mz1PDuCGnHbnireT46I2Z0q8qSahzZupMa6MH/AdCBwsbWp/R3cH4V8l8uQIQWSyNspCpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730326; c=relaxed/simple;
	bh=ztC9IifHoZoP/gHxsixJVA6+belHLREkY1bS0HpncBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFvPR2gwP3X6k1ho6M8eOt8nHrmg8aN0n98madTntVmK7Rc68Yx9tqOW+ubxAbaCBSriKDMQNubDoLooKpNjP4DB7JqTzEXkLAD18/JTVKNBKreyAN/w9opFmuTLLQvLt0SBmA8iVjAVGFMBx9Ixx6kJWi5KuW8hPXX8XZ9e9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net; spf=pass smtp.mailfrom=queued.net; arc=none smtp.client-ip=45.33.49.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=queued.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queued.net
Received: by spindle.queued.net (Postfix, from userid 1001)
	id 685E210E10E; Thu, 19 Sep 2024 03:13:35 -0400 (EDT)
Received: from 5400 (unknown [172.56.163.43])
	by spindle.queued.net (Postfix) with ESMTPSA id 2317310E0FB;
	Thu, 19 Sep 2024 03:13:34 -0400 (EDT)
Date: Thu, 19 Sep 2024 03:13:29 -0400
From: Andres Salomon <dilinger@queued.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: mjg59@srcf.ucam.org, pali@kernel.org, rafael@kernel.org,
 lenb@kernel.org, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: Fix crash when unregistering
 battery hook
Message-ID: <20240919031329.3e0f76d0@5400>
In-Reply-To: <20240919063332.362201-1-W_Armin@gmx.de>
References: <20240919063332.362201-1-W_Armin@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.2.5

On Thu, 19 Sep 2024 08:33:32 +0200
Armin Wolf <W_Armin@gmx.de> wrote:

> If the battery hook encounters a unsupported battery, it will
> return an error. This in turn will cause the battery driver to
> automatically unregister the battery hook.
> 
> However as soon as the driver itself attempts to unregister the
> already unregistered battery hook, a crash occurs due to a
> corrupted linked list.
> 
> Fix this by simply ignoring unsupported batteries.
> 
> Tested on a Dell Inspiron 3505.
> 
> Fixes: ab58016c68cc ("platform/x86:dell-laptop: Add knobs to change battery charge settings")
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> I CCed the maintainers of the ACPI battery driver since i believe
> that this patch highlights a general issue inside the battery hook
> mechanism.
> 
> This is because the same crash will be triggered should for example
> device_add_groups() fail.
> 
> Any ideas on how to solve this problem?
> ---

Hm, I see that when battery_hook_register() has the add_battery hook fail,
then __battery_hook_unregister() calls the remove_battery hook. Does
something like the following fix it?

(note: not any kind of final patch, just a test.)

---
 drivers/platform/x86/dell/dell-laptop.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x86/dell/dell-laptop.c
index a9de19799f01..c7b92b2f7ed2 100644
--- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2390,21 +2390,29 @@ static struct attribute *dell_battery_attrs[] = {
 	NULL,
 };
 ATTRIBUTE_GROUPS(dell_battery);
+static bool bgroup_registered = false;
 
 static int dell_battery_add(struct power_supply *battery,
 		struct acpi_battery_hook *hook)
 {
+	int err;
+
 	/* this currently only supports the primary battery */
 	if (strcmp(battery->desc->name, "BAT0") != 0)
 		return -ENODEV;
 
-	return device_add_groups(&battery->dev, dell_battery_groups);
+	err = device_add_groups(&battery->dev, dell_battery_groups);
+	if (!err)
+		bgroup_registered = true;
+
+	return err;
 }
 
 static int dell_battery_remove(struct power_supply *battery,
 		struct acpi_battery_hook *hook)
 {
-	device_remove_groups(&battery->dev, dell_battery_groups);
+	if (bgroup_registered)
+		device_remove_groups(&battery->dev, dell_battery_groups);
 	return 0;
 }
 
-- 
2.39.5


-- 
I'm available for contract & employment work, please contact me if
interested.

