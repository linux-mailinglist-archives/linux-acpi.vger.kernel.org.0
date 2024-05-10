Return-Path: <linux-acpi+bounces-5732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9554D8C264B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADF5285F63
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79535172761;
	Fri, 10 May 2024 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sfMumB9T"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A6171E54;
	Fri, 10 May 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349905; cv=none; b=BBIKD4corvhmrtIEC47GHOx9+wrvi39iVKKTLRf3nInJfpJ2eFna54zY4C3/zdYGwAFfgV2aulHNgNDrRc/nuY8kvhxkoy5BFBuhzrZLNstrvKo2/pCONooJhvXnlyFTlzBY4RkGfT//jOpc167YhkM36i8VmtXTQq/BQHkZLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349905; c=relaxed/simple;
	bh=M4vNfNhSkf79qU0rJCyfCBaGhDTGtuVQv5YxYiYbpwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=COSTXNxA69AdolNlY3BVVQcIZ8F1O/rLdAtWZGgQ8vwpcZJcjdmPB9ZBa50QxpmshfoBsRZTVtAcZAx1wjajXi6FxMuCV2uIeweDY48yWOT9IQ4caf9mtaUuu3QTk4gvXnNTFoHKqdf/kpzx0ZkdL440mUiWpnBOWu9xseq2qOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sfMumB9T reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.0.0)
 id 0053621c028d5798; Fri, 10 May 2024 16:05:00 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 59E4D21031DA;
	Fri, 10 May 2024 16:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1715349900;
	bh=M4vNfNhSkf79qU0rJCyfCBaGhDTGtuVQv5YxYiYbpwk=;
	h=From:To:Cc:Subject:Date;
	b=sfMumB9TIOhpsMEjm+y7vNPkY5ILiFNdt2rkMxA7XgOzfYzoD9AOTAe9yNRqB4VS/
	 v1Jh4j4yuWjOndXrgKCvVwFGCYnJGpmxiguLcauJ/IWz4FoWRCoUinzOl19/S6K1qZ
	 dyauwkxVNpv6mXFiDS0/xn2X6dz105TWaJJ6BmlxfzARf++5rS6PT4Qs2il6ahPMC0
	 AyozfpBT+Gi4cn/U+BbI0OX+sJjdrrLmTY8DB5kIr9nxhL3Hq1lbdue59TLW8l8TC7
	 MhMkCkmLh5HK6ecXmezwlREodgDuNflRac62vXmgQBmtK7NC/Rpf21wd2Oigjm4AIH
	 Gv1CvCEp0ZH9A==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject:
 [PATCH v1 0/2] ACPI: EC: Install EC address space handler at the namespace
 root
Date: Fri, 10 May 2024 16:01:41 +0200
Message-ID: <5787281.DvuYhMxLoT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehhuggv
 ghhovgguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeifpggrrhhmihhnsehgmhigrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

Hi Everyone,

This is a follow up for the discussion in:

https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t

Patch [1/2] is a resend of the patch posted in the thread above and patch [2/2]
removes the custom EC address space handler from the WMI driver as it should
not be necessary any more.

Thanks!




