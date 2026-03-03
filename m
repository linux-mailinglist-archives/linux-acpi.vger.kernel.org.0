Return-Path: <linux-acpi+bounces-21308-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAdeLanwpmk/agAAu9opvQ
	(envelope-from <linux-acpi+bounces-21308-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 15:31:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2323B1F17DF
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 15:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76215301C899
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 14:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8915B3DEAD9;
	Tue,  3 Mar 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0N5X7ME"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B053BED40;
	Tue,  3 Mar 2026 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547997; cv=none; b=fzbuL3dwT/i/6tOXBx6wLINrRRgDZ0pT19vy518XArVsQYJWZHFOvuZh3lXIu5QHaPdtHOUv6svvjeaQesac/rCocjV5Ht27bQKx4y5mQ35DDJa8gv2RRmaRbZqX0rYxwqd6vJca5bW/lSVCaNzYtN/bafHiVZ0ucjskUvhNybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547997; c=relaxed/simple;
	bh=V77Vef1lGeU7KNrGbwZQq9wh14fSJAB9UhZf/XRGgvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p7MUG0kPePEb7qJE9sHHqNlTNQulprg/7owVj4wSqOaOoUgqLjYmmaPyemtvmOsQwzl/LSuyghHziS78kc1TniZbyuYapKRKy1+nvHpgzMADopmrC1bh6dO53B3JZbsjb2B3U/L0EVNHS8kEdbLrDHRRaAsYGjh44hDFtIE/q8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0N5X7ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0CDC116C6;
	Tue,  3 Mar 2026 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772547997;
	bh=V77Vef1lGeU7KNrGbwZQq9wh14fSJAB9UhZf/XRGgvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=c0N5X7MErl84IR+YSi1jyCLgkC+jmxUyzqeZWnOgy/FRdXNCl6dqLxlEyeHKjWne7
	 SC1BliHACWjsKIE3RW39L3jEgg87Nald2IA1f8u1b0lkgBj2m9OLV+9dXKhIPwu91y
	 jNnzPuQR8tn6QaukaoVPqYNLK6t6Cc4o0SsXQ1sal2jJCknci6URSiG9oPSxXBAO3V
	 Org+eDob8h7Nd8VqMC0MxJY1NcncKQ+S+B4ObbDTQsBt6HHyHB4lG5Y+/6FxQshftW
	 MQ15TBWlsmRbE+f/xWqnDmsOP15rMDKIzvONFzY0UHHluwmxwt3AsXmiH0yR17PcYJ
	 PXsSnv/PJipew==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1] Revert "ACPI: PM: Let acpi_dev_pm_attach() skip devices without
 ACPI PM"
Date: Tue, 03 Mar 2026 15:26:31 +0100
Message-ID: <2829615.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2323B1F17DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21308-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

=46rom: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit 88fad6ce090b ("ACPI: PM: Let acpi_dev_pm_attach() skip
devices without ACPI PM") that introduced SoundWire suspend regression
[1].

It is actually not true that the commit above doesn't make a functional
difference because acpi_subsys_suspend(), for example, may resume
devices in runtime-suspend which affects the subsequent handling of
those devices during the suspend transition.  For this reason, the
devices that were handled by the ACPI PM domain before that commit may
be handled differently now which may lead to suspend-resume issues.

=46ixes: 88fad6ce090b ("ACPI: PM: Let acpi_dev_pm_attach() skip devices wit=
hout ACPI PM")
Reported-by: P=C3=A9ter Ujfalusi <peter.ujfalusi@linux.intel.com>
Closes: https://github.com/thesofproject/linux/pull/5677#issuecomment-39843=
75077 [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/acpi/device_pm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index f2579611e0a5..aa55ecfc2923 100644
=2D-- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1456,15 +1456,6 @@ int acpi_dev_pm_attach(struct device *dev, bool powe=
r_on)
 	if (!adev || !acpi_match_device_ids(adev, special_pm_ids))
 		return 0;
=20
=2D	/*
=2D	 * Skip devices whose ACPI companions don't support power management and
=2D	 * don't have a wakeup GPE.
=2D	 */
=2D	if (!acpi_device_power_manageable(adev) && !acpi_device_can_wakeup(adev=
)) {
=2D		dev_dbg(dev, "No ACPI power management or wakeup GPE\n");
=2D		return 0;
=2D	}
=2D
 	/*
 	 * Only attach the power domain to the first device if the
 	 * companion is shared by multiple. This is to prevent doing power
=2D-=20
2.51.0





