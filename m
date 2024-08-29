Return-Path: <linux-acpi+bounces-7988-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D067B964E0A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 20:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE79B23219
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D651BC084;
	Thu, 29 Aug 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="di+XRM49"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C61BB680;
	Thu, 29 Aug 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724957075; cv=none; b=odl3t9HQOkZ6H/0HW3lT2v57Y6C5yxPUUYlha8Calo0RMynwW/rrzQPtbDrwa5cI3Rk4QPktYdiX9bibzGtZ84Mmw5LBF3/v2AIwCDvH+nGICpjjbj5kJWNxUse09dfyDzi2SAzCMZhkmovMlRfvkcc24XtDtEDBRSkffCr4ImI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724957075; c=relaxed/simple;
	bh=sGCV6gT1QXovl51NWkzJkzYV8Tcr7dOdipkMZnRWFXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ubGHrNr0OkhILFtPzE6F+e5nq9fSPJbD/9ngpMj77SNU3sR1Squ56enhfXjqW7N3klL0BP5v5f1/IK/snQ5gCuagSJ2YmRYsNo/3zrmEdi4vyTk4PDz5UDipHg1Y7GL1fr052xInCPX2VvTstBWBbrZgmJvtFWNl9BjeFtPL1c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=di+XRM49 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 86963aea2bfa84e1; Thu, 29 Aug 2024 20:44:31 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 9BE736A8C15;
	Thu, 29 Aug 2024 20:44:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1724957071;
	bh=sGCV6gT1QXovl51NWkzJkzYV8Tcr7dOdipkMZnRWFXI=;
	h=From:Subject:Date;
	b=di+XRM49stClmeAT5A/OgxZgIJLYKteCTR0maIrqhPeJA7feEVKQkqqvzEvxk/36u
	 zDT/elkDa4R2nOGpeIW+kjNrhh9hGWVtyloWL+fjzkVwYF5TUJqeZ/VyFZBNuBN3NH
	 UyXOuW+xHGXn0N6qd2mwPddBf/kVYx3U7hYz94WXIrnFFtq9fAFgFDTw2EM6bXOw6K
	 7DAoeYghPMUXHLtT/sGJ+QIQoxceh9C7mEl3b4SvNrucBkMj43CyU5U+4FLVurkKOf
	 zzrorWhB5VbArXARgRDxKFIa9cBWMV/+U6kW7ehPoEmNbEsfobj5L/MEuEqKW5z/GK
	 PCqk282rs0yaw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject:
 [PATCH v1 06/20] ACPICA: MPAM: Correct the typo in struct acpi_mpam_msc_node
 member
Date: Thu, 29 Aug 2024 20:30:44 +0200
Message-ID: <10529431.nUPlyArG6x@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedguddvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeltdeikeekkeevieektefggfetueetfeejveejgeduledvudehieeuvdeiheeiveenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsghrvgesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Punit Agrawal <punit.agrawal@bytedance.com>

ACPICA commit 3da3f7d776d17e9bfbb15de88317de8d7397ce38

A member of the struct acpi_mpam_msc_node that represents a Memory System
Controller node structure - num_resource_nodes has a typo. Fix the typo

No functional change.

Link: https://github.com/acpica/acpica/commit/3da3f7d7
Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index e27958ef8264..d3858eebc255 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1607,7 +1607,7 @@ struct acpi_mpam_msc_node {
 	u32 max_nrdy_usec;
 	u64 hardware_id_linked_device;
 	u32 instance_id_linked_device;
-	u32 num_resouce_nodes;
+	u32 num_resource_nodes;
 };
 
 struct acpi_table_mpam {
-- 
2.43.0





