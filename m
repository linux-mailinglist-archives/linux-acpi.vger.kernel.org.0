Return-Path: <linux-acpi+bounces-21355-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFtEBYCAqGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21355-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:57:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCF206B4E
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96B7A302D96C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6EE3D75DE;
	Wed,  4 Mar 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBvC38mE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996243D75B1;
	Wed,  4 Mar 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650549; cv=none; b=U++4MXsUCtozOcUBt8pIjY9CByio1pmb7uraIgVwVLoIOYNijWW4+eg5sUkeqTCz8yVmLnOfXdiVvMwgDDJJbxib/+3702DBeXtOsndOjeddjQRp38Dv8wM199jKu9NwK7Jb7WOeU8IFHOUa6neH8nCvU/HGqgKmntuR+LDTkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650549; c=relaxed/simple;
	bh=keQN4MQzfFmdymT+KQmMToZOdNzJU47UOF5Dz8Xbz8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT+7WuS1XQkGGT+njWV7NxoEC7OFYUmhNUSbPaVjeQ6KKVLHMJGE48VFWj8BFGMIySWwcvcyLqGUZIFBFQKG9OWM/sb3RoMqrPFbxsJUbUC9pdxchMRlapK73nDUnNvhxlY/EYDzif3niwChtBkn331BQ/jmhlZEOtt5M2oTnzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBvC38mE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BBAC19425;
	Wed,  4 Mar 2026 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650549;
	bh=keQN4MQzfFmdymT+KQmMToZOdNzJU47UOF5Dz8Xbz8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jBvC38mEZditdFLPm5MoXIg7fWrn2Ra1s9CBVcTzji29zHrhZLWPRJW8+kcXmCD2w
	 cqfVIuoQhyXJltGBMrGf5IDEawGZHcNvS0vNKDC074IL7oqALoZqhuhUr1e1gj0n5n
	 GSARVcydMxTu+J6ar2M9+sua8GuEoVP+CUI2dRFF997Sp0tdLsywzU50QiMgye9+Qt
	 fGKU1OdynQChHGTv+2xe5Q73PwQoJE01/9Yzwdnl1rJLzxkYQ4XNROqeG0FWLKSNXR
	 ADJ+0haNiXvCJJ8Vz+UqrdfUr9/YpYOSBcbQkYeB8U+gJYmTRGWxjylCJsmZhaYGid
	 5NaznL9X8Hajg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 1/3] platform/surface: surfacepro3_button: Drop wakeup source on
 remove
Date: Wed, 04 Mar 2026 19:54:08 +0100
Message-ID: <4368848.1IzOArtZ34@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2909929.BEx9A2HvPv@rafael.j.wysocki>
References: <2909929.BEx9A2HvPv@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 92FCF206B4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21355-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The wakeup source added by device_init_wakeup() in surface_button_add()
needs to be dropped during driver removal, so update the driver to do
that.

Fixes: 19351f340765 ("platform/x86: surfacepro3: Support for wakeup from suspend-to-idle")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surfacepro3_button.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 9bd39f09c7db..a6c9d4d370be 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -242,6 +242,7 @@ static void surface_button_remove(struct acpi_device *device)
 {
 	struct surface_button *button = acpi_driver_data(device);
 
+	device_init_wakeup(&device->dev, false);
 	input_unregister_device(button->input);
 	kfree(button);
 }
-- 
2.51.0





