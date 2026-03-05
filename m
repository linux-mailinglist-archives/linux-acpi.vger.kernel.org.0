Return-Path: <linux-acpi+bounces-21452-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJDAOMzoqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21452-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:34:20 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFDF21832F
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1A6D31A3E3D
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E53A33A6F9;
	Thu,  5 Mar 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+gGHJ3M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1E33A6E0;
	Thu,  5 Mar 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742580; cv=none; b=s8Id/NSBaxOE9zoTlVCYXEFLeHvGnY/PN8GA20HomdkAV5E58x7jV3Sz3sAodHK/47CMgmWcezE0nX19wxjdMuitp7a2ne5y0/HA1tyrdHFUVJRZ4Qf+uyOcz5hWYtNFZGDCnNu6g+mH42BbiD3vX1SF92KqDVR1uwbOG2VyEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742580; c=relaxed/simple;
	bh=72VhL5VI+u+DGmZ9WG+ARxMqs4HGRfcVXAra2KxkbKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6ZvorbARiAQbQMQzekTsphp8hianJRaWJXWWSZlXFPaSzQIFZqDAQsnSyPkF5AXSH6de6sITKaaEORntdCF+MNK8XDKWRxS2bOt3RV9VKA/xmiyKmUWyuErBfbaK3329MESgVoYZCBrsIYiDOfJRKq94gj2RTpiWt0SI/BPzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+gGHJ3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4680DC116C6;
	Thu,  5 Mar 2026 20:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742580;
	bh=72VhL5VI+u+DGmZ9WG+ARxMqs4HGRfcVXAra2KxkbKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B+gGHJ3Me4uN8pczwIYhQIOM4v0JeVYuI8+0bz7eQfrbEa59Lgw+BW88gfJo6NK0c
	 hBUb3ePrkErEE/0EbgnR6CvxruWiYrkTLafyrxdSrXk1gl4s+88sIvbaDRaizxLAmj
	 k60SRxQv761NNDKsPLwTKu83i/miVmeVEBFDrhqDw+zfNx20OZVrGUiudqf6hvD7ZW
	 gUWLozbaU8SUrvbEFDAZUxcEBKESGQEEJKYckE+R/3CMbVRNddLG+n4kSrKEavlIiE
	 s0jtxZMVG5TPPqUGREE2P2T+XOTZ1PiB+vNtw6CBLNHvkp1fhY+ipFW+amMy8Rn8tg
	 mp5PlmR8RtdUQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject: [PATCH v1 1/9] ACPI: AC: Get rid of unnecessary declarations
Date: Thu, 05 Mar 2026 21:10:38 +0100
Message-ID: <3757869.R56niFO833@rafael.j.wysocki>
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
X-Rspamd-Queue-Id: 6AFDF21832F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21452-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Drop unnecessary forward declarations of 4 functions and move the
SIMPLE_DEV_PM_OPS() definition after the definition of the resume
callback function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ac.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index c5d77c3cb4bc..e0560a2c71a0 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -33,22 +33,12 @@ MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI AC Adapter Driver");
 MODULE_LICENSE("GPL");
 
-static int acpi_ac_probe(struct platform_device *pdev);
-static void acpi_ac_remove(struct platform_device *pdev);
-
-static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
-
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
 	{"", 0},
 };
 MODULE_DEVICE_TABLE(acpi, ac_device_ids);
 
-#ifdef CONFIG_PM_SLEEP
-static int acpi_ac_resume(struct device *dev);
-#endif
-static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
-
 static int ac_sleep_before_get_state_ms;
 static int ac_only;
 
@@ -272,10 +262,10 @@ static int acpi_ac_resume(struct device *dev)
 
 	return 0;
 }
-#else
-#define acpi_ac_resume NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
+
 static void acpi_ac_remove(struct platform_device *pdev)
 {
 	struct acpi_ac *ac = platform_get_drvdata(pdev);
-- 
2.51.0





