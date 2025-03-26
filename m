Return-Path: <linux-acpi+bounces-12467-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ED7A7208D
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 22:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168E717A828
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BAA2641F0;
	Wed, 26 Mar 2025 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="HNNqAfDn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390AC261362;
	Wed, 26 Mar 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023530; cv=none; b=S60qdq1C0CytlBd7yH99VjDa6Qkj+wuw/qk7Bj8sMNa08BrLADx/Q0+c88hIPc299XZqq0JiBUHX0z4HY8MFDS9/EV+HJLdqGh+ajWv+iRAxHUJa1aBREfGLX1baPbxPrHD1jnwJOgrsTPZDb4cKZcYQ+Ndtze+U1peMvBTXNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023530; c=relaxed/simple;
	bh=iOkJVqPz/EE0HoTpVOu7fXxtqt69cVoK8ffjFcGTtGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJgHOSCgw0KAXVJDLXrS0a1IQbAY+vEm1chCd6JgJaImKyF5o7m7GTcQa72+YchzLnLFm6hS2rAM1eOdXRHNav8prpvPXiD73YmmdlUfapzo+L2Fqx5V75jfO1CRvkXSxhRoLsu6fl0HcVrZAagYESle1PwW0zTmjUb5/6Axoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=HNNqAfDn; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id 3a5aaa8058b43fb5; Wed, 26 Mar 2025 21:12:06 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DE8A47F6388;
	Wed, 26 Mar 2025 21:12:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019926;
	bh=iOkJVqPz/EE0HoTpVOu7fXxtqt69cVoK8ffjFcGTtGg=;
	h=From:Subject:Date;
	b=HNNqAfDny3nGozSC9I3CMapo6PpaqCsEyLYIguAhYyu0l66eEOml2H/COTUd+fi0A
	 2bIwohXEFbTTeyRbiUHvhOngYpY4Qit54XAqVyOeZ4zG4h3ij5vTbBHFr9Nc836/5C
	 eSwoj3hu46jpGO+zcqOSnglDlAklnCgzVxU55kcop8vzptgf0+71E9VinwSc6BEprx
	 qSZS8ni7Yqhc5UWzzi9mZ0mIZAZstItygzIJTkqVxQjoAltTi8gy2y3+Vi01Or56be
	 9uTHn+AefK/5RawXOSpXRWaTBg/kEkCZ9q2fupJGWt3yS2QytG+O8Kw5CGEdYq70kc
	 Z2x46xody8hIQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 5/8] ACPICA: actbl1: Add EINJv2 get error type action
Date: Wed, 26 Mar 2025 21:08:46 +0100
Message-ID: <3344273.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepueetieelhfeufefgffetiefhudduveejfefhjeefvdelueehkeeltddttedvuedvnecuffhomhgrihhnpehtihgrnhhotghorhgvrdhorhhgpdhgihhthhhusgdrtghomhenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Zaid Alali <zaidal@os.amperecomputing.com>

ACPICA commit 6975cd07e20ba955556e1eafe8a326834c354ae6

Add EINJV2_GET_ERROR_TYPE as defined in the new specs(1)(2).

Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4615 (1)
Link: https://bugzilla.tianocore.org/attachment.cgi?id=1446 (2)
Link: https://github.com/acpica/acpica/commit/6975cd07
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 1dc29933e2a3..329454c303b9 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1034,7 +1034,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS = 0x7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 0x8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS = 0x9,
-	ACPI_EINJ_ACTION_RESERVED = 0xA,	/* 10 and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE = 0x11,
+	ACPI_EINJ_ACTION_RESERVED = 0x12,	/* 0x12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
 };
 
-- 
2.43.0





