Return-Path: <linux-acpi+bounces-12464-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC47A72087
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE3F7A308A
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A6C25F7A2;
	Wed, 26 Mar 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oDwxYQ6P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD9B214A9C;
	Wed, 26 Mar 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023527; cv=none; b=VXeF6idbjNjBK1SfbuRjBQlyZ28H5c2U59tW5zKmBImfo/kmKXdvjEUkE0HK/85L4Y9BnqHyIkZOPpRKFgFPxDCti50gGTHwN2kPnnC/DxyytwgnyYzxabCBAZzHjtqljMRnI8d0hKLsUwGH5rlB8uIh9Ou3PbwVHHCAMWTqf9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023527; c=relaxed/simple;
	bh=Dcnpfly5qy+P3YzzQNuAqHaGTXdNYexYwQcfSTJjMSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsOyg28i/2HZv3GqCL27mBaW6gr4mJ1lYILB3oICr3Ty5Qysnl7VczpAToL8Mzo18uXFIwK+ja+RPKI3epaKhTpaSeCqsO0GVpkWLVH1LHifIDoY5WlYGabub+Ntf11JkJ0i8LM3yzrVqs5OisBtvP2ZToBhafyyL8IexHWWZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oDwxYQ6P; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 6cd39c22a11b9dde; Wed, 26 Mar 2025 21:12:03 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D47BC7F6388;
	Wed, 26 Mar 2025 21:12:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019923;
	bh=Dcnpfly5qy+P3YzzQNuAqHaGTXdNYexYwQcfSTJjMSU=;
	h=From:Subject:Date;
	b=oDwxYQ6PtNbPJYeG3aKo0vWU+rbvnmzZ6b4L9Rs3DadR1RP0O8J9z+tc5Zcvs1YLe
	 JWkp/wUCbA3xRXRjV7WvFwOu/UK/VKZNnpzwBzjCW8vzua4nO3lFYz/Mm04RD5dUBC
	 5ejLpWDHcfQXHri+v7ZomA34+dYMtwPxC7as9+j5CDpYWBpkaoo7WfdbkqTYdiHBcK
	 qFTYq/byo3ThDHSoMzOGmlUFranfTnNHgR3UPprY6HUadPmJK/e9glyub6iUyj3+f0
	 LiXqXycVBWotnvCf8uFg+U8rZgs9r9LpwlVjwQYVuL445tSc9pyCxobP81vuKwuf5o
	 D8ji31gao2sPQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 8/8] ACPICA: Logfile: Changes for version 20241212
Date: Wed, 26 Mar 2025 21:11:33 +0100
Message-ID: <22641776.EfDdHjke4D@rjwysocki.net>
In-Reply-To: <5873907.DvuYhMxLoT@rjwysocki.net>
References: <5873907.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepledtieekkeekveeikeetgffgteeuteefjeevjeegudelvdduheeiuedvieehieevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Saket Dumbre <saket.dumbre@intel.com>

ACPICA commit 7dae72155bf06b0edda9f3aea713da1d48c1c418

Link: https://github.com/acpica/acpica/commit/7dae7215
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 25a071d305bd..adf315e25d8d 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20240927
+#define ACPI_CA_VERSION                 0x20241212
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.43.0





