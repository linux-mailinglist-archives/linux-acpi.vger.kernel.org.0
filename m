Return-Path: <linux-acpi+bounces-7994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF63C964E16
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772B21F25716
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC4C1BE23C;
	Thu, 29 Aug 2024 18:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="I3rjWKT7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789F1BDA94;
	Thu, 29 Aug 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957080; cv=none; b=EudgWTHY+4tXK/OY3vtfnObb0TbI8uw+M+Q/jHNtO+tpJOZSShdMQPKcNwFXL0sX9DucYaEI8uKd2oinfxGFQLt9b5OQJUCysidjOeLSREbqIQxWYmgHNcknQFqpihQCXSEinknaYfYKrCdPuaNB4fKizmBAkOEvUmUWRh2iVbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957080; c=relaxed/simple;
	bh=D9Kqd3FKIOYvAEPnmVq1vDuA0cMh5s8MRJ8xmOBpr7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l2dxTm9k/xSXHziKJHdBkhTAknyxHwN541CDWXOc4HchRy43NDNWQmkcF2RWy2xzn30lqJZVYdLiDtFrONgaNfX+Upg57zykTVrzh7iIEqj8/JlPYVpzCyukznnS9X1looP3CGEIsi0+iFhGWv03mR3agDYaAelcXURS9UxCxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=I3rjWKT7; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 96faff22bc9cb589; Thu, 29 Aug 2024 20:44:37 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id A9D876A8C15;
	Thu, 29 Aug 2024 20:44:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957077;
	bh=D9Kqd3FKIOYvAEPnmVq1vDuA0cMh5s8MRJ8xmOBpr7Y=;
	h=From:Subject:Date;
	b=I3rjWKT7/20WEhOoPufhG4WG99D7kblUSzX+rJfFPD5AIPyPVah5ojO7H1IFT5G07
	 L3nM3MOY+lyUucTSN1g4/7NZyrVOuQzJycdbznoZmThfKsF7Kk4jQgh9JHyiNunQXQ
	 CwdZ4SzRvzDf/p9ygRIZ3EsW3JN6fajBS9FMiWa4AdPZQQ9FqKgE/bT2T9SPIJ9MOk
	 j98LUZ4jnVMO+JNgNB2lm9GaoUjhqC0ljmb1HcyqEnceupIEbSaLwtufF0N3rAPzWS
	 eDqvtrscWPUJUaZZ4drKMN1gB6rUOpz/DX9xLraoddKMJmw3Bm/RlqUXE8qbaW45zR
	 J/92JefRGnksA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 00/20] ACPICA: Release 20240827
Date: Thu, 29 Aug 2024 20:18:53 +0200
Message-ID: <5819337.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhmohhorhgvsehinhhtvghlrdgtohhmpdhrtghpthhtohepshgrkhgvthdrughumhgsrhgvsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

Hi All,

These are ACPICA 20240827 changes ported to Linux, except for some
patches that have been applied already or are going to be routed
through other maintainer trees.

The following changes are included:

Adam Lackorzynski (1):
      ACPICA: Avoid warning for Dump Functions

Adam Young (1):
      ACPICA: Allow PCC Data Type in MCTP resource.

Adrien Destugues (1):
      ACPICA: haiku: Fix invalid value used for semaphores

Aleksandrs Vinarskis (1):
      ACPICA: iasl: handle empty connection_node

Armin Wolf (6):
      ACPICA: Fix memory leak if acpi_ps_get_next_namepath() fails
      ACPICA: Fix memory leak if acpi_ps_get_next_field() fails
      ACPICA: Allow for supressing leading zeros when using acpi_ex_convert_to_ascii()
      ACPICA: Add support for supressing leading zeros in hex strings
      ACPICA: Update integer-to-hex-string conversions
      ACPICA: Add support for Windows 11 22H2 _OSI string

Dave Jiang (1):
      ACPICA: HMAT: Add extended linear address mode to MSCIS

Jose Marinho (1):
      ACPICA: Implement the Dword_PCC Resource Descriptor Macro

Punit Agrawal (1):
      ACPICA: MPAM: Correct the typo in struct acpi_mpam_msc_node member

Saket Dumbre (2):
      ACPICA: Allow for more flexibility in _DSM args
      ACPICA: Setup for ACPICA release 20240827

Sia Jee Heng (2):
      ACPICA: SPCR: Update the SPCR table to version 4
      ACPICA: Headers: Add RISC-V SBI Subtype to DBG2

Vasily Khoruzhick (2):
      ACPICA: Implement ACPI_WARNING_ONCE and ACPI_ERROR_ONCE
      ACPICA: executer/exsystem: Don't nag user about every Stall() violating the spec

Zhang Rui (1):
      ACPICA: Complete CXL 3.0 CXIMS structures

Thanks!



