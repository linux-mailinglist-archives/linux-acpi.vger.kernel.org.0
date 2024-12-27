Return-Path: <linux-acpi+bounces-10313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE429FD2EF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 11:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E3418837FD
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Dec 2024 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F26614B95A;
	Fri, 27 Dec 2024 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Uo4asleD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62086F2F2;
	Fri, 27 Dec 2024 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735294210; cv=none; b=UgVrBZfI+52ehy2V0zb9j2aPm5HWelL5ZrBbUZlT2vUiQwLNGROE9Wrm4hMm8gBYAdC2kY6bkYSec1UDoN+lyL83B/Hi3S0BTauk11MdL0lcHgZpJGGtfmgSajCMYU/pNyeXon6G711zrTINdryE7q2zkC/WsFbHsRgw/Ejn4TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735294210; c=relaxed/simple;
	bh=sLITGNfFF0ccuqjEaxHCPmw8IkWmp6nI6NCiXF0ojCs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HruKlmMAPsce2yo9Zbn0pukNRvYlA1CT0UEplXNHi8MXPGx7Y7ibBWW9tqorhQm7BGQgaQ8n5uH4Ti9F8uXAZIQT84wn8cIpGBdlRRkqQEulWvc9MQIYNL/c5u8Rfsp0vuK5jacGnGpx9NPTVcUMYuTfdz5oRc2nHkchMuITviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Uo4asleD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 77A3740E0163;
	Fri, 27 Dec 2024 10:09:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rDDF8CsRZvSx; Fri, 27 Dec 2024 10:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1735294194; bh=4xPHGPQ5yw093cG7yHtJXHWmwTAhtSXxcQqI3IUeIWk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Uo4asleDUGZ8NGIJrCbgAWxebvrahrveUH/0Lp1VSxq+Rpda3SiAJ+HUJ535j3fx1
	 3HgfQK7+bu7yAGjVFA3GeIyqHbdOGO6edlDFoUbnMCrSjhu3lLZoDa/ppMibuJw2TR
	 iafM7Qedu6270/tkxZOAq8ZUT6DbX4JEwdm+3tOmTtwNCxVTPnaZeit21ko6pvv/n8
	 TnjDELVVISd0275IcqkAWock9AaSaNT0DsUone6aKga0friN1W0ShC1MK8eBCJfw5O
	 fJKTUwn69e6DMFx2NtEksEZbbDsiQmtUs8y61+iFJjXS2lDZJ9IsiHakN53JfMxGEg
	 xxzDq+PCZrOjX3o5lJOdOasC+wmWqRv0RMPHfRcRjUqpz1Ir/F+KjEXTWDIhwvEfph
	 VAc3U8vr/1gvPv7oeRWg5vUG9vv/3W3kWc34x82eUVt/1Kw1nIfv1zWUgCof317Hbb
	 lo2eoKtp0/ms7JiYxrroKb06rU2eCECluuWBmcx7A+mB7c0ZOcR4QpdSRg6NEdTezC
	 qAgOmU3WjbwSKmWZV+fR/zta1VWFR+4ZQDHdA242CMwI+kCjI76BRA2exCBjH+UzlS
	 hSGsCy3dU4hF86iSd1f7E7MTuMQhmjp3eURFk8widUf87B7sCGbACJW2qJ1ew1aNli
	 vXVLTlxUFnwO75W10utfuE4M=
Received: from [127.0.0.1] (unknown [57.133.22.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B6E1440E01C5;
	Fri, 27 Dec 2024 10:09:42 +0000 (UTC)
Date: Fri, 27 Dec 2024 11:09:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: Feng Tang <feng.tang@linux.alibaba.com>, rafael@kernel.org,
 Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
 Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
CC: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, ying.huang@linux.alibaba.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_acpi/ghes=3A_Make_ghes=5Fpan?=
 =?US-ASCII?Q?ic=5Ftimeout_adjustable_as_a_parameter?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
References: <20241227095422.44147-1-feng.tang@linux.alibaba.com>
Message-ID: <1EA3C309-6508-489B-9F13-7659E8388A17@alien8.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 27, 2024 10:54:22 AM GMT+01:00, Feng Tang <feng=2Etang@linux=2E=
alibaba=2Ecom> wrote:
>There is a problem report that when debugging a hard-to-reproduce panic
>issue, user wanted the kernel to not reboot by adding "panic=3D0" in
>kernel cmdline, so that the panic context could be kept, say the panic
>was caught randomly in the mid-night, and user hoped to check it in
>the morning=2E GHES panic handler may overwrite that user setting and
>force to reboot after 'ghes_panic_timeout'(30) seconds=2E

Why doesn't the ghes panic handler honor a panic=3D0 setting?

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

