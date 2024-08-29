Return-Path: <linux-acpi+bounces-7984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2E8964E02
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEA3B21BE6
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6D1BAED2;
	Thu, 29 Aug 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="e8F2YYo2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611631BA267;
	Thu, 29 Aug 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957072; cv=none; b=i6yjtFAXcyx8qsr3bRRCefr598YcwbHhnYVzQ0Ki9DIR0smAABJPrkaoAeTdr62rXmgdvIKBJVzjF+gPzLCTk0gu7xbEEiFqKZs6qOcNbYFF7lYDhEB0OQEhnsNZxbtQJdCcUcj831yw3kiO2cpyybzWUl1Oo0yHTLTc6mgR7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957072; c=relaxed/simple;
	bh=oKU/vh/PQ+kWaWVHJ4AO9C6R5Dk9lh0qjrxYoItlfeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ECAXidwtKRgztqTb8f6Epzs/MR5/J/Hvkx49nmBg8wSEFEPTXoaPBrjPHEunTEwDUzMIr7bPezLeNdpiQQIb4MyNwCFvAH74JxiNLEtKB5TVDS5UXXoXCR7UM3p23fYt2319FbcVS7DECbm9O1nS0Ui8LFQfksBQBSoONrynMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=e8F2YYo2; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id e0c3b0a80af672f6; Thu, 29 Aug 2024 20:44:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BB7D06A8C15;
	Thu, 29 Aug 2024 20:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957068;
	bh=oKU/vh/PQ+kWaWVHJ4AO9C6R5Dk9lh0qjrxYoItlfeA=;
	h=From:Subject:Date;
	b=e8F2YYo2W4ptWnAutW6N86+tIVvjEyLyDFMap6BGOKvBBzewsiqcVh3tDHKJzzMLy
	 Q6QlOMzd2gWcWpRN6fRPbbg+AZJaZ7ir7BOz/09Q/jR08neTrQ44eGGa17IVA32nTx
	 ebfV7HWHHbBwN+D4W2Mr/Ue4/CEb2TbeV4bHNSpeQY5VTTyVhQ/CC8pnTO5GcvhRu3
	 TMN9BnLHjLn78gScsjeJwYAEx3qoVtQsel57KLtDoUdf3HPFFhR/+qKH3kvfz3Pip2
	 yOcSucQJ5H3NzJRFa90Gwu+VIL6zH1ANTp83jXkJObpYpUMPa3LaFuvgCrbPzlC4Uo
	 FPDNb07vOEbOw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 09/20] ACPICA: Allow PCC Data Type in MCTP resource
Date: Thu, 29 Aug 2024 20:34:40 +0200
Message-ID: <9335495.CDJkKcVGEf@rjwysocki.net>
In-Reply-To: <5819337.DvuYhMxLoT@rjwysocki.net>
References: <5819337.DvuYhMxLoT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeuteeilefhueefgfffteeihfduudevjeefhfejfedvleeuheekledttdetvdeuvdenucffohhmrghinhepthhirghnohgtohhrvgdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdr
 tghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Adam Young <ayoung@amperecomputing.com>

ACPICA commit f0776a465cc2c20393bec534c16bdee4a78f7bb7

Explicitly allow QWord address space description type
to be 0xA to indicate it refers to a Platform Communication channel
IAW  ACPI_ECR_PCC_DESCRIPTORS_CF_V2

An entity in a DSDT or in SSDTs that requires
a platform communication channel table (PCCT) entry
to communicate with a remote service will have a single
value that is the index of the entry in the PCCT.

This data type with have a resource_type value of 0xA.

This value indicates that the type shares the same
footprint as a Dword_space section.

Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4594
Link: https://github.com/acpica/acpica/commit/f0776a46
Signed-off-by: Adam Young <ayoung@amperecomputing.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/rsaddr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index fff48001d7ef..27384ee245f0 100644
--- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -282,7 +282,8 @@ acpi_rs_get_address_common(struct acpi_resource *resource,
 
 	/* Validate the Resource Type */
 
-	if ((address.resource_type > 2) && (address.resource_type < 0xC0)) {
+	if ((address.resource_type > 2) &&
+	    (address.resource_type < 0xC0) && (address.resource_type != 0x0A)) {
 		return (FALSE);
 	}
 
-- 
2.43.0





