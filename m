Return-Path: <linux-acpi+bounces-14396-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B73ADB8BC
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 20:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE00188E166
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Jun 2025 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF73288C23;
	Mon, 16 Jun 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="q/J+XrCP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD315278E;
	Mon, 16 Jun 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098032; cv=none; b=bGqdBu72bBc9jknnD1hKopdwaZKMgVupdxgR6AL+Npbp1QxcxRk2OmPnjVn23xVn/8gXhIpevMKU7ifYC2iBzTcZlMSZaQS8BM5O5tPhGS9DzXrk+Vr6uEkvFatwQDjX+JKiAehcoUoAoZpbAiugQ7hJPwgLu7KGe7e2mxi2drA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098032; c=relaxed/simple;
	bh=2xsHb+q5IHqLtHvguGYSnl0ZBTyInNxGPvvq/Gyq7Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgWfWB1vTC/2RiCcAKUbDAMmrDcgss71VtfguMNDLWM9To9nLAxtGIfyTanTW+00rUz1CSCcm+FjRC9yJjszbKidmcLk79SffGkYKiwBxK+BN1dVrKQ4+9Amu9O5e9kBvBnkUKafQ6slq2wev4v+27NTs7xD/GjdBUAlCY7vslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=q/J+XrCP; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9320666DC60;
	Mon, 16 Jun 2025 20:20:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750098029;
	bh=2xsHb+q5IHqLtHvguGYSnl0ZBTyInNxGPvvq/Gyq7Hk=;
	h=From:Subject:Date;
	b=q/J+XrCPXUXfLTQo3YnLxTuzEnv/0iZV8fB/87gKrMjqFJb+BUeWbE8AGi4v37yOk
	 w8uZsz2RlEDrWKNXUvRjYSJFcyjrD2hBdu+0FS9CRbEPtrej1yr5PyT0VmYT5Q2o6N
	 lT68DgzMTU1IX/reT+gxv5RaWdRE09l6ybDlaV8GTtR9i8wFEnctsohfvxNxvd4dqE
	 67osYXgEQPvDQa61B62bmHNo8esDSs1IdVANXRI848yg4Fia7rEnlXCIEn+xKuAfeW
	 m9CiRC3/d91EuXPm+1M6XF6xoKYIv4LsxF678VRRwxnJw/IPkk8wKGnSbrXSjAmDPs
	 C9ZKnjAzH6IHw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v1] ACPI: PM: Set .detach in acpi_general_pm_domain definition
Date: Mon, 16 Jun 2025 20:20:28 +0200
Message-ID: <4665476.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTGaPyNzBzuKZv8nTKdDK6Sjua6andLAiYcj7NSiFyofwvUhBXQU+doYmpL173XtwefGUGi6uKfpXJ1EVmG7RvGg+kx1RxqB9qla1ZccX7cVis3Wz8NlzNWbVPWivkFfL9G/qRXoMpPkI6wGwKg2DmW2ACnrhbWzLyWgNLoSTHi4srQh2WuwSX6MgNYJhuRdc9owYbpSSuJPQVuRKsiVVMp5fCOHQRQ4W2wXuHLPrQ0HQZKAZD5/xMVCzSfS7evwYdu/wY7Qp/Qk1Xtj9aKCH65SLwll0YQOoca2VFTo/uo8OJoLVBeowm2ryk3kWqSa/0FNWZDUFTlaaIhpUZQEUE3OIuD9Hxr/fOkk/KS2EuMyyAn+2NZWc56G8hyhtbcpffWVJcS2CPvZBt5XczwJCEWbatJR5jdP+mbw8hODzZKB21HujK9WjESPcypCSA1Ob7kxQysLPMDWjWjS7UcaBcTXF303oaT1jh4FKxt/TFl9FnFMEuqL2f8SRHowHjOCp0VtejVccJjqBIdNeVKp5X6j6h3IuvzO5ZmCX43UDlJDrlpwsAaOzd4OQ9A8/Htp1NRrBUsbfsIMHxcVBZ9V4vjIww9WKC8uQPdSd2WcXmb/YR5BONFU5+vEgWxX7HwjMVXe/s+UcUxcijW3xuPw8nz0zlXowRbZm5deJJdRjL77yw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Instead of setting the .detach callback pointer for acpi_general_pm_domain
every time it is attached to a device, which is confusing, set it once
in the definition of acpi_general_pm_domain.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/device_pm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1362,6 +1362,8 @@
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static void acpi_dev_pm_detach(struct device *dev, bool power_off);
+
 static struct dev_pm_domain acpi_general_pm_domain = {
 	.ops = {
 		.runtime_suspend = acpi_subsys_runtime_suspend,
@@ -1382,6 +1384,7 @@
 		.restore_early = acpi_subsys_restore_early,
 #endif
 	},
+	.detach = acpi_dev_pm_detach,
 };
 
 /**
@@ -1465,7 +1468,6 @@
 		acpi_device_wakeup_disable(adev);
 	}
 
-	dev->pm_domain->detach = acpi_dev_pm_detach;
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);




