Return-Path: <linux-acpi+bounces-13501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E5DAAC589
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83A91BA0EA4
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E221B9DE;
	Tue,  6 May 2025 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="bob6YepX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3C21773D;
	Tue,  6 May 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537190; cv=none; b=U51dffdaLG5gL95KSftsBB41RDZdUaRxmOQaLRrp++j7daB6ufGCOCHoRQgfI0BIUqDA0xip3brgTwoXkm5Hh3OWCU9uvWVE21PCYJgcBfOJn5vCF1X+M/82yWM9HMFaICLXk5uro/SJFCaPJFZfRIkY0EixjT/RhzHaA59+7ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537190; c=relaxed/simple;
	bh=YMI0vj0OrGpE/eP6t8dJ6R2e/dntMlSP+AkMjMPh4h4=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NgJjdsxdJHiTWiqfBXQhi+WrO4GKjfs5snC0g+E4LgzcC/LRinDOx+EfW1cpH9tRufZSa6gNYbt1E/LOVIWmmM1m603y5woZBJK6wKpeEKPfJ8qG3D4HozuNcx2hkz7EOwLRYjEmKeDk7CGKxARHQMC+XDrx6LWil67xYCSErWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=bob6YepX; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1746537189; x=1778073189;
  h=from:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eroNId8QJzKeQKmRo8q0ozQ4Sy0oITvhszR0rqprBLQ=;
  b=bob6YepXO5zQMZ9M8G1aoivh0yzGLDI841vQ0llDoypVSIq+M7HYhIES
   87+uJeb9puJlZ35mw84aIJ9DgWHgLJjZuSilZlDfC2M8O1FREwp4i3anU
   +k04HtjrXClbsuzfSXReRpEYAee7GZaNjdoOCF7vCNitHPcQL8wzwn9Dj
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,266,1739836800"; 
   d="scan'208";a="489596055"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 13:13:05 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:30777]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.85:2525] with esmtp (Farcaster)
 id 11723db5-b7e5-4450-80c2-cb2f93ea780e; Tue, 6 May 2025 13:13:02 +0000 (UTC)
X-Farcaster-Flow-ID: 11723db5-b7e5-4450-80c2-cb2f93ea780e
Received: from EX19D008EUC003.ant.amazon.com (10.252.51.205) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 13:13:02 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC003.ant.amazon.com (10.252.51.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 6 May 2025 13:13:02 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Tue, 6 May 2025 13:13:02 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel
	<ardb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Topic: [PATCH] ACPI/PPTT: fix off-by-one error
Thread-Index: AQHbvoiY1LpDnn/Xs0e1Rmh//GxC4g==
Date: Tue, 6 May 2025 13:13:02 +0000
Message-ID: <20250506-draco-taped-15f475cd@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 7ab4f0e37a0f ("ACPI PPTT: Fix coding mistakes in a couple of
sizeof() calls") corrects the processer entry size but unmasked a longer
standing bug where the last entry in the structure can get skipped due
to an off-by-one mistake if the last entry ends exactly at the end of
the ACPI subtable.

The error manifests for instance on EC2 Graviton Metal instances with

  ACPI PPTT: PPTT table found, but unable to locate core 63 (63)
  [...]
  ACPI: SPE must be homogeneous

Fixes: 2bd00bcd73e5 ("ACPI/PPTT: Add Processor Properties Topology Table pa=
rsing")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/acpi/pptt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index f73ce6e13065d..4364da90902e5 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -231,7 +231,7 @@ static int acpi_pptt_leaf_node(struct acpi_table_header=
 *table_hdr,
 			     sizeof(struct acpi_table_pptt));
 	proc_sz =3D sizeof(struct acpi_pptt_processor);
 =

-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <=3D table_end) {
 		cpu_node =3D (struct acpi_pptt_processor *)entry;
 		if (entry->type =3D=3D ACPI_PPTT_TYPE_PROCESSOR &&
 		    cpu_node->parent =3D=3D node_entry)
@@ -273,7 +273,7 @@ static struct acpi_pptt_processor *acpi_find_processor_=
node(struct acpi_table_he
 	proc_sz =3D sizeof(struct acpi_pptt_processor);
 =

 	/* find the processor structure associated with this cpuid */
-	while ((unsigned long)entry + proc_sz < table_end) {
+	while ((unsigned long)entry + proc_sz <=3D table_end) {
 		cpu_node =3D (struct acpi_pptt_processor *)entry;
 =

 		if (entry->length =3D=3D 0) {
-- =

2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


