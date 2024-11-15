Return-Path: <linux-acpi+bounces-9605-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDBF9CF67E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 22:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BCB286F2A
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 21:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBB91E2830;
	Fri, 15 Nov 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="RC+iVSn9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36812F585;
	Fri, 15 Nov 2024 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704477; cv=none; b=urnCNRoCWMmAIgIV6hvAsM9as3X2JQ1Co5ZOVcaksb957Ieb7rXupQQFqaL5iv+3h36PAzdZOo/7gsvyvzxFzZV3jgmc8Czj/SECy3AIDBbzs975RhVff8WWAeBxhfyv3+6Vjn6++uUZ2Vg4U+boX3BQ047hGDx2AexGnhX8AO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704477; c=relaxed/simple;
	bh=rsn+RwiG0Uq2EfiVehR0Bd4Q9j5Z+jOh9GWo9JKzu9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/YDcTrY4jaZ6inAsDWxFeCHkbnht2nP/VBNJU7mV3MkCAeNpk+FUMe4oKxyBsTZPsyY5caDg4nhcFyFHklFay+j2AdfaYRpo2rM1/lTgO/kY12ezil+kWhII1PhIGJdzw9nLdE49QfsMdVjMwLnB3Ag/55fobIzyGhDUefxB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=RC+iVSn9 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id fb68522096ef80c5; Fri, 15 Nov 2024 22:01:06 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A77EB851B10;
	Fri, 15 Nov 2024 22:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1731704466;
	bh=rsn+RwiG0Uq2EfiVehR0Bd4Q9j5Z+jOh9GWo9JKzu9w=;
	h=From:Subject:Date;
	b=RC+iVSn9FP6QblHtHIh0ohYq30KmyFXkknXYdM7ru2rZTMecRI7YA574xcdhp38BW
	 XXMpm4RvxLCwlSCxnUpVAJqzWoysngdKvSJ0OQAp7Rxow9+xaZ+Ae52wNUKMdfJ6DC
	 apWvPZIoSJeVqI1i8AfCxxHwtYVBzOKNw/6TdCIWeXMzbBuFjkBjX+zVcvI+S/NFYT
	 sfjZpn4vz2i9LhNTu0fxuYZOe9d8bLg/o/fu2kBH8LIv2jtyRyfPhihP22dHKPLrDH
	 e7LSYL1kMu6z0gNrGZ3MroI8aUa9nkjV9dkOQuWXUS+yDj/xh2R5NKgeqIiIY1C+dK
	 LRWuP1FM/eJ9w==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject:
 [PATCH v2 0/2] cpuidle: Do not return from cpuidle_play_dead() on callback
 failures
Date: Fri, 15 Nov 2024 21:57:41 +0100
Message-ID: <13636465.uLZWGnKmhe@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeggddugeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthhrhihkrdiflhgriihlhihnsehlihh
X-DCC--Metrics: v370.home.net.pl 0; Body=9 Fuz1=9 Fuz2=9

Hi Everyone,

This series of 2 patches supersedes

https://lore.kernel.org/linux-pm/4992010.31r3eYUQgx@rjwysocki.net/

in order to address review feedback.

Patch [1/2] modifies cpuidle_play_dead() as per the subject and patch [2/2]
changes the :enter_dead() cpuidle state callback return type to void.

Thanks!




