Return-Path: <linux-acpi+bounces-13643-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096FAAFDC0
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FFD1BA7C91
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23ABA278167;
	Thu,  8 May 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="jzZKrupp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB12279337;
	Thu,  8 May 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715821; cv=none; b=eJlUK2X+41ZBV9iWTuSWxpuCwUOVLoqIW2qEcOsKUGxCGp0fCIhqAskWyhqxATqAejUzxDlhtUnuMEz2HjDJMDpFEWhCjZzz29GShLxAJQG1qQ1H8XynT3+gsJ+9Fi642JS+a4+7kM6VizR27scUGjC166YQsThCILFoXru3jBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715821; c=relaxed/simple;
	bh=kSyOd/YqwB4I7SCdXQSrZ2DZeX6cJamcOQno4YyOQA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K4zFU3WkZfm9r7VmRPcdhC1xjE7t+PU59hsu4DJWAVb05x9OQYmP9CljHAmdwu0O8DE8/x5Y7Xxp7DuucKTMQr4IJ/Ptp5rLTC/rKavamnVKC2LK/aYE13FxtC0Qu2hQvFvBokXQAjO+1U0oil99WHlq9x0TDBPuO9zYx1q2SlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jzZKrupp; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1746715817; x=1778251817;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=BHpCAxEHtnyUYUm3CkHmDoIQw35lsCllGPJ1yOn0X/M=;
  b=jzZKruppJ9XiyNyM96RJUYQFfvubslfmg+agRJsgcLNXMKxkK/zosHov
   n6Snk9KmcFARQ2exLyMne70+TpgsZO2Ob167yLUVO+ukCB48fCuDaFNSR
   oSMT91gh4OJO9HtvjJrJK/bif7jz5Hai25M6W1KUdZvD/cgKSF1FQxFjv
   y3SfkM8AKcu+RpM4eihDPh/9ZRbo050sUqBGiFzrDl7tdm4IVgyPNwps8
   E/e77Hi+qgL/QAjyT4ARkttDzaBOOIWV+66ZGjFhP7cS7uJCP89AoILqV
   jUs7SZT1s0bOd812QhmNg87t8X9whKd+Le7svKDuImOE+uGmG8hTWJpeu
   w==;
X-IronPort-AV: E=Sophos;i="6.15,272,1739836800"; 
   d="scan'208";a="17815690"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 14:50:09 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:2671]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.128:2525] with esmtp (Farcaster)
 id 44994329-5418-4e57-adac-c37e048f9fa5; Thu, 8 May 2025 14:50:06 +0000 (UTC)
X-Farcaster-Flow-ID: 44994329-5418-4e57-adac-c37e048f9fa5
Received: from EX19D008EUC002.ant.amazon.com (10.252.51.146) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 14:50:06 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC002.ant.amazon.com (10.252.51.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 8 May 2025 14:50:06 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.1544.014; Thu, 8 May 2025 14:50:06 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Jeremy Linton <jeremy.linton@arm.com>
CC: "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
	<lenb@kernel.org>, "jmeurin@google.com" <jmeurin@google.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, Yicong Yang
	<yangyicong@hisilicon.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PPTT: Fix processor subtable walk
Thread-Topic: [PATCH] ACPI: PPTT: Fix processor subtable walk
Thread-Index: AQHbwCh8rUbZYEeM7U2CpGyi5RqI0g==
Date: Thu, 8 May 2025 14:50:06 +0000
Message-ID: <20250508-laugh-stud-e5037c82@mheyne-amazon>
References: <20250508023025.1301030-1-jeremy.linton@arm.com>
In-Reply-To: <20250508023025.1301030-1-jeremy.linton@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2D3D35BEE9554B4D99A6B058091F6CEE@amazon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 09:30:25PM -0500, Jeremy Linton wrote:
> The original PPTT code had a bug where the processor subtable length
> was not correctly validated when encountering a truncated
> acpi_pptt_processor node.
> =

> Commit 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of
> sizeof() calls") attempted to fix this by validating the size is as
> large as the acpi_pptt_processor node structure. This introduced a
> regression where the last processor node in the PPTT table is ignored
> if it doesn't contain any private resources. That results errors like:
> =

>   ACPI PPTT: PPTT table found, but unable to locate core XX (XX)
>   ACPI: SPE must be homogeneous
> =

> Furthermore, it fail in a common case where the node length isn't
> equal to the acpi_pptt_processor structure size, leaving the original
> bug in a modified form.
> =

> Correct the regression by adjusting the loop termination conditions as
> suggested by the bug reporters. An additional check performed after
> the subtable node type is detected, validates the acpi_pptt_processor
> node is fully contained in the PPTT table. Repeating the check in
> acpi_pptt_leaf_node() is largely redundant as the node is already
> known to be fully contained in the table.
> =

> The case where a final truncated node's parent property is accepted,
> but the node itself is rejected should not be considered a bug.
> =

> Fixes: 7ab4f0e37a0f4 ("ACPI PPTT: Fix coding mistakes in a couple of size=
of() calls")
> Reported-by: Maximilian Heyne <mheyne@amazon.de>
> Closes: https://lore.kernel.org/linux-acpi/20250506-draco-taped-15f475cd@=
mheyne-amazon/
> Reported-by: Yicong Yang <yangyicong@hisilicon.com>
> Closes: https://lore.kernel.org/linux-acpi/20250507035124.28071-1-yangyic=
ong@huawei.com/
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Jean-Marc Eurin <jmeurin@google.com>
> Cc: <stable@vger.kernel.org>

Thank you so much for providing this proper fix and also thanks for the
great discussions. This allowed my to learn new things. Much
appreciated.

I confirm the fix works for me. Therefore,

Tested-by: Maximilian Heyne <mheyne@amazon.de>




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


