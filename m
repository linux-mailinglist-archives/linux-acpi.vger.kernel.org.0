Return-Path: <linux-acpi+bounces-21449-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNOfKGnoqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21449-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:32:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07023218301
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FBC1316AE3E
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA933987E;
	Thu,  5 Mar 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouhh5c98"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA2298CBE;
	Thu,  5 Mar 2026 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742570; cv=none; b=RGdCXfnIowXhlsVEnBIhAZ8iC2kU5dOb1DXGzeW/e439GwySeoZgMUtlV/l+rwznKqYQAbio5g51iZ3EPziF11Zl1Z+oQx7lPg2JPIBR2/XN/UiB5kd1lauRdtkDRj4VsBDsNP3wmTHV+gq+6l3nMrMclivxwJHdviBa98a64g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742570; c=relaxed/simple;
	bh=EEw9askz0wqJGI8+BzgWY3zRUi+YorrUJiw9FNnQOEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6ONNnD5Gdx5je697khO7iKBfmFntQLeaEUhKhdV8ef0XP85ajTRpnizGOXBGxPoCbqK9gpIc+mXWEmGqApNlCQSJT70VibxZ3RaLvetM0M3uKcxvZ7VScxAlgc+PZKW3qfC4eJ6W1EGA7VVd1FjiSxI+P0PDoLGqhniGQ3MlPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouhh5c98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD3C116C6;
	Thu,  5 Mar 2026 20:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742570;
	bh=EEw9askz0wqJGI8+BzgWY3zRUi+YorrUJiw9FNnQOEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ouhh5c98WXrq+0UG4vmsg8poVnJUEK+qnkSi3nSP7UWKZaNPjD5bvXMRnbYI12M8w
	 4ywPViktVqPahGa39BGUyJIfQEYAJY4vH3n5q9cc95v5k5uWvf0o2aHCOS/Bmf5fl9
	 sn0DhoZjGoMzF6hsmEJ7KC5dCHpwZK6nHK13wXBgZMOACU95Z8txCwcw37nT3AmKCj
	 NF3+HwYDCbXrP2xrTt3t6ZJVXyZYnVp1G3UFTALnhX1ulKLH9UA9RiMXqv/hYDBFiV
	 0IZ4rH/BFszbosvPX2IkydfjhYDZJAq1P/uuNIdZMmH5jWHludfbvyOW9pXXMeR4B/
	 XTB2aYNRQuHGA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 4/9] ACPI: video: Rework checking for duplicate video bus devices
Date: Thu, 05 Mar 2026 21:16:12 +0100
Message-ID: <5663583.Sb9uPGUboI@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4505861.ejJDZkT8p0@rafael.j.wysocki>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 07023218301
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21449-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current way of checking for duplicate video bus devices in
acpi_video_bus_probe() is based on walking the ACPI namespace which is
not necessary after converting the driver to a platform one proper.  It
is also susceptible to race conditions (for example, if two video bus
devices are probed at the same time) and ordering issues.

Instead of doing it the old way, inspect the children of the parent of
the platform device being probed, excluding the latter and the children
that are not platform devices.  For each of the remaining children,
check if any of the entries in the video_bus_head list is equal to its
driver data which can only happen if the given child has been processed
by acpi_video_bus_probe() successfully and so it is a duplicate of the
one being probed.

Moreover, to prevent acpi_video_bus_probe() from processing two devices
concurrently, which might defeat the above check, use a new internal
mutex in it.

Also, print the FW_BUG message only if allow_duplicates is unset which
allows the entire duplicates check to be skipped in that case (doing
it just to print the message about the case that is going to be
ignored anyway is kind of pointless).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_video.c |   57 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1683,26 +1683,6 @@ static int acpi_video_resume(struct noti
 	return NOTIFY_DONE;
 }
 
-static acpi_status
-acpi_video_bus_match(acpi_handle handle, u32 level, void *context,
-			void **return_value)
-{
-	struct acpi_device *device = context;
-	struct acpi_device *sibling;
-
-	if (handle == device->handle)
-		return AE_CTRL_TERMINATE;
-
-	sibling = acpi_fetch_acpi_dev(handle);
-	if (!sibling)
-		return AE_OK;
-
-	if (!strcmp(acpi_device_name(sibling), ACPI_VIDEO_BUS_NAME))
-			return AE_ALREADY_EXISTS;
-
-	return AE_OK;
-}
-
 static void acpi_video_dev_register_backlight(struct acpi_video_device *device)
 {
 	struct backlight_properties props;
@@ -1978,27 +1958,48 @@ static int acpi_video_bus_put_devices(st
 	return 0;
 }
 
+static int duplicate_dev_check(struct device *sibling, void *data)
+{
+	struct acpi_video_bus *video;
+
+	if (sibling == data || !dev_is_platform(sibling))
+		return 0;
+
+	guard(mutex)(&video_list_lock);
+
+	list_for_each_entry(video, &video_bus_head, entry) {
+		if (video == dev_get_drvdata(sibling))
+			return -EEXIST;
+	}
+
+	return 0;
+}
+
+static bool acpi_video_bus_dev_is_duplicate(struct platform_device *pdev)
+{
+	return device_for_each_child(pdev->dev.parent, &pdev->dev,
+				     duplicate_dev_check);
+}
+
 static int acpi_video_bus_probe(struct platform_device *pdev)
 {
 	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	static DEFINE_MUTEX(probe_lock);
 	struct acpi_video_bus *video;
 	static int instance;
 	bool auto_detect;
 	int error;
-	acpi_status status;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE,
-				acpi_dev_parent(device)->handle, 1,
-				acpi_video_bus_match, NULL,
-				device, NULL);
-	if (status == AE_ALREADY_EXISTS) {
+	/* Probe one video bus device at a time in case there are duplicates. */
+	guard(mutex)(&probe_lock);
+
+	if (!allow_duplicates && acpi_video_bus_dev_is_duplicate(pdev)) {
 		pr_info(FW_BUG
 			"Duplicate ACPI video bus devices for the"
 			" same VGA controller, please try module "
 			"parameter \"video.allow_duplicates=1\""
 			"if the current driver doesn't work.\n");
-		if (!allow_duplicates)
-			return -ENODEV;
+		return -ENODEV;
 	}
 
 	video = kzalloc_obj(struct acpi_video_bus);




