Return-Path: <linux-acpi+bounces-20472-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOJtGky7b2kOMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20472-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:28:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF844890A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65B13804F76
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7EF43D510;
	Tue, 20 Jan 2026 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oliGbYJi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AD328B67;
	Tue, 20 Jan 2026 15:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923905; cv=none; b=bc3n9DdCo43yKH6uoFEKBglyVUvRtb0QSX8Ik8FbpgXeAYgW6g1Iw8xrVj1clMfbvoCAvkl167DK3hCImgVAYS7UAZH/XDOryfHEkck3vQww+XaEjgfyBGsXUz3+7fFcxJLTr3/jhpS7sBF0HqCbz83IxM+0WVQnra+q0DUsyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923905; c=relaxed/simple;
	bh=Pg2BkQxsBc9dyXpGiautqBpvS/L5bPjmKtyYe6frzsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r07jCA7o0hNp/EzIAwsYZAnKNkqRA8NoJMcohgn8j+lPcVeGQ3hCUxcaG+uLDzbNBhCLH4K0tFWkvks+NGF5gPZJnTry1gJzN0UxFCWNdegPzG1peqVlG1pYMPWdTGwcU6JRbYMVO5y4tb1it8M3W1qA4zYnahU+K8WsQmnOF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oliGbYJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831C1C16AAE;
	Tue, 20 Jan 2026 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923904;
	bh=Pg2BkQxsBc9dyXpGiautqBpvS/L5bPjmKtyYe6frzsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oliGbYJie196+c4ttIbPNu57yqceJ+D1IEs6ZgTZi+shSIQViVl/n4pP6ddDXCiJE
	 snYjeR4IiJ5p4PHSbQDQmS3GJhcq5eDObwiY9DS9XwImTK7bEkR6/3V34Dh3khbeX/
	 KUU/benvNWZfSbH0qoPNWc/vUVG8rIdharRIi6Sb9YWgQiM//vUlZT536nNyzZAVCT
	 gKVSog0yEr7zmaz0fyAPPVzr/Gmln+Ko3qzuWPlHicfHOP1YJBrhDD06os00XNIARr
	 bdnC3JnigDe/275MmP3mjsCMTWefQYyepvxRZsh9kijUezYZ6n7mkWNfy7Tr4clzFw
	 xPo7asB6qzXuA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org,
 Azael Avalos <coproscefalo@gmail.com>,
 Matthew Garrett <matthew.garrett@nebula.com>
Subject:
 [PATCH v1 2/2] platform/x86: toshiba_haps: Fix memory leaks in add/remove
 routines
Date: Tue, 20 Jan 2026 16:44:23 +0100
Message-ID: <10789244.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3026924.e9J7NaK4W3@rafael.j.wysocki>
References: <3026924.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nebula.com];
	TAGGED_FROM(0.00)[bounces-20472-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1DF844890A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

toshiba_haps_add() leaks the haps object allocated by it if it returns
an error after allocating that object successfully.

toshiba_haps_remove() does not free the object pointed to by
toshiba_haps before clearing that pointer, so it becomes unreachable
allocated memory.

Address these memory leaks by freeing the memory in question as
appropriate.

Fixes: 23d0ba0c908a ("platform/x86: Toshiba HDD Active Protection Sensor")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/toshiba_haps.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/platform/x86/toshiba_haps.c
+++ b/drivers/platform/x86/toshiba_haps.c
@@ -142,8 +142,8 @@ static void toshiba_haps_remove(struct a
 {
 	sysfs_remove_group(&device->dev.kobj, &haps_attr_group);
 
-	if (toshiba_haps)
-		toshiba_haps = NULL;
+	kfree(toshiba_haps);
+	toshiba_haps = NULL;
 }
 
 /* Helper function */
@@ -195,15 +195,20 @@ static int toshiba_haps_add(struct acpi_
 	/* Set the protection level, currently at level 2 (Medium) */
 	ret = toshiba_haps_protection_level(acpi_dev->handle, 2);
 	if (ret != 0)
-		return ret;
+		goto err;
 
 	ret = sysfs_create_group(&acpi_dev->dev.kobj, &haps_attr_group);
 	if (ret)
-		return ret;
+		goto err;
 
 	toshiba_haps = haps;
 
 	return 0;
+
+err:
+	kfree(haps);
+
+	return ret;
 }
 
 #ifdef CONFIG_PM_SLEEP




