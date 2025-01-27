Return-Path: <linux-acpi+bounces-10848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBEA1DC23
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE9B163A9A
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Jan 2025 18:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46518FDA5;
	Mon, 27 Jan 2025 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="byC++DyB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2718A6C5;
	Mon, 27 Jan 2025 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003075; cv=none; b=iShZEpUpAp1PYciCqHw4MqLB606l10VryQABT98F2R5bS9G+qPmsMeYdRqbytIZfOEZ/vFvIReyotUtIR4aHXkJciPFd3yq5je4lVWRMkyu0lvy+4uFtMLbe5U0c7xyyTYSgMg6/MFad+lnzvTb/JS09U7G8yPSMzTsuz+C7Dec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003075; c=relaxed/simple;
	bh=Uj0u3hwlkZnUutAQG5/jQ/nLfuJ7O608wy5pDLRwvrA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o4J5dikGZX3GayqgZFStltDe4ACtbfS6YX8XKx8P1SVwF33BE50dpdM90WJCW5l7AS+wdT6m1hL9UKUS6sxbUd9nqxVAtOA1/JScDsF/u9PdbfmdXqT19ruiBRS0zNMVrmAW6o3HXTPs180sXFr0sXy/zxxWtqfMvQ6grJ3rgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=byC++DyB; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 9676A1E0016;
	Mon, 27 Jan 2025 21:37:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 9676A1E0016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1738003063; bh=yg01RDFF1Jqdc58yUnd1GFV/463ska2o6NOv39MqFSQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
	b=byC++DyBD1Hw/6J1znKz9UrnNpL/IIkXUtzAsaG+M1h0CvZ1kbN1CzFU8YXGZKw0/
	 9m/8e9uRonS8qkuIXBPBeQkH1bPYiHhEcNOO0SWl8MCqfeqfdJpQxFEWHbv41hyZmU
	 l/y5pYKRz5kxgSmWUyWLacZQbugCXKlxWiLnI3SIZqidvVzgxMU/7Bo6vwp3wwtA1d
	 aeNqHnxD06NlgxfsUT2T4+l7i5Z6rEri0tQ3MpeHEAS4SgoeqBwuOFAD6djyRITG3N
	 Fw/s92xaQwH3jcwB6WgIUjB77QK44xhtiLnD+CZgMncu8/6RGHTN8XBtMN3G3V7tnF
	 +NdGLJh3g0TFw==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Mon, 27 Jan 2025 21:37:43 +0300 (MSK)
Received: from mmail-p-exch02.mt.ru (81.200.124.62) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 27 Jan
 2025 21:37:41 +0300
Received: from mmail-p-exch02.mt.ru ([fe80::5fe7:9066:a884:475c]) by
 mmail-p-exch02.mt.ru ([fe80::5fe7:9066:a884:475c%9]) with mapi id
 15.02.1544.004; Mon, 27 Jan 2025 21:37:41 +0300
From: "Murad Masimov " <m.masimov@mt-integration.ru>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, "nvdimm@lists.linux.dev"
	<nvdimm@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
	"syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com"
	<syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Thread-Topic: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Thread-Index: AQHbbbW+YWbRIqLg90Kdd63unsRF6rMk03WAgADVgoaAAGu9AIAE4xKa
Date: Mon, 27 Jan 2025 18:37:41 +0000
Message-ID: <e8e39191429d4211a0e9a784c5eb2288@mt-integration.ru>
References: <20250123163945.251-1-m.masimov@mt-integration.ru>
 <649ed1bb-0686-42f0-802f-9f1909aeed8c@intel.com>
 <741f409ae5be4f1f9b62d9223f026e26@mt-integration.ru>,<6793e1945e9f2_9caff29489@iweiny-mobl.notmuch>
In-Reply-To: <6793e1945e9f2_9caff29489@iweiny-mobl.notmuch>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: m.masimov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, ksmg02.maxima.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mt-integration.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.62:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190601 [Jan 27 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/01/27 13:50:00 #27131010
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

> I tend to agree this is not ideal.  But IMO the issue is that family is
> treated as an int throughout the code rather than u64.  Even u32 would
> have been better than int because negative numbers are not allowed AFAICT
> just skimming the code.
>=20
> Unfortunately, ripping through the code to change family to u32 is
> probably not worth the churn.  I'll think on this but I'm tempted to appl=
y
> this.
>=20
> Ira

Hi,

I believe this patch is better suited for the stable branches.
Additionally, replacing int to u32 or u64 in all relevant parts of the
code seems too risky, as it could potentially introduce new bugs.

Given the discussion so far, would it be appropriate to resend the same
patch, but with a more detailed commit message this time?

Thank you=

