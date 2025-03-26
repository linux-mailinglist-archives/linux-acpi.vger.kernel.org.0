Return-Path: <linux-acpi+bounces-12456-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0910A71FF1
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357051782DC
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981D22571A8;
	Wed, 26 Mar 2025 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lVlzVs2g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93A253B59;
	Wed, 26 Mar 2025 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743019935; cv=none; b=VLgtVaDBF2T7RWoEN7qfhDHGHoOV4ZlDHIJFO+zqcK25r+6sxgWLqxH5xgO5+3j+RNlroM66vBR74cgHCMGS6LSTgal1pEsJvy07vBcVCZT9fuk1NCsytRzASeODuqn1rGuk4LdT7+T0SfJpVaK2sqiaSuL9KcI1c0bdy72GyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743019935; c=relaxed/simple;
	bh=DLVhu0vtl8L7mHg1TiLT36ykzz3ITYF1djo57NTnUSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGbwbmjry4nLND2oCa/r5p1oFi0KALM1RU0IFduicxn88pcvx3kU2yIb5HWoH0oSUF4PrPmm02tE7w7h00Wmr7g0AYs5R2PeDA7GfxavrYN4bgdUyCnfIje5GseKJnH+NBZWvAMSBDAzhjrHKRV8IQ6dZAZJ0FUFR+7RMavVxus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lVlzVs2g; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.3.1)
 id b1b41c0b5c00127b; Wed, 26 Mar 2025 21:12:10 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3A72F7F6388;
	Wed, 26 Mar 2025 21:12:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1743019930;
	bh=DLVhu0vtl8L7mHg1TiLT36ykzz3ITYF1djo57NTnUSw=;
	h=From:Subject:Date;
	b=lVlzVs2gOkOpqnTEzpKwmDe0VjpB2bGyfEc5qiDrFLPGslBZiYPc5Ih45+hYbAuD1
	 twyNiKsN8DiCqU9mBuIpjDCmgRLNQiEupDpc4FOkiRRQhFcF0U2NvvstUoH0wBBIFt
	 9yDmq1a0qzovSbWL2eSSm2pptO9l3MSse55IWh5i/GCl0GZCn6j+dbVA4eYUhzBYeb
	 JAbwCPQwGRFSNPmzqLzWwyUBXRbEoJtV1GV46sYAj5YMUZOsfu1fH/rTvH7WHsvNxd
	 0cZSxOqZIQ1uxmhmvLR7PWRD2P2ZlUL7h7+hcemyaBUA7dynUz/ehAjzd2ocJiUTNK
	 /oZL3+/rk2mjA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 0/8] ACPICA: ACPICA 20241212
Date: Wed, 26 Mar 2025 21:04:13 +0100
Message-ID: <5873907.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeigeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi All,

This series of patches represents upstream ACPICA changes made between
the 20240827 release and the 20241212 release that have not been included
into the Linux source code yet.

It contains the following material:

Adam Lackorzynski (1):
      ACPICA: Fix typo in comments for SRAT structures

Saket Dumbre (3):
      ACPICA: New release 20240927
      ACPICA: Fix warnings from PR #295 merge
      ACPICA: Logfile: Changes for version 20241212

Seunghun Han (2):
      ACPICA: fix acpi operand cache leak in dswstate.c
      ACPICA: fix acpi parse and parseext cache leaks

Zaid Alali (2):
      ACPICA: actbl1: Update values to hex to follow ACPI specs
      ACPICA: actbl1: Add EINJv2 get error type action

Thanks!




