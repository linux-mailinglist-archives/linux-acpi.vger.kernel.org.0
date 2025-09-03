Return-Path: <linux-acpi+bounces-16342-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245C8B427B1
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9FEF5E3BE0
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FBD31A56C;
	Wed,  3 Sep 2025 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ont3MVVU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7630DED9
	for <linux-acpi@vger.kernel.org>; Wed,  3 Sep 2025 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919645; cv=none; b=GHmiarOA1CeNgxV/OUzbZDRYqqWj1Pqawh3XBpgnC3VoA9slyDf6MXRNoUZZcWnpjnsFIyhePr7sU9Y+C9IwVucqjutOfS/cfK1TIcH6HETBYxMDz2Jz/ffcmJ7amV/ZLv9Lkpyf6FjyuZl0TOIXE/qRNj4swWKaI057jnRMlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919645; c=relaxed/simple;
	bh=cj3CyxRS2XK1WHoYNM9POX30bm2iqsoA3IJN4yEICYk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HefbN7REI6iGTwW4TxDp541O3EPzVawU2MEFs0zUMAuwlo00aIKtnNfr7tgd7XtMSNDnGO6gD9QgY35x3nAkQhEpVKlXlbF20uTUUWPnGKaoyo4am+/5HxMOnbw1t973gfqLAwdDWU4pEslw0pQ3ZfyPq+f6h8KM303UR6lZLzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ont3MVVU; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1756919633; x=1757178833;
	bh=cj3CyxRS2XK1WHoYNM9POX30bm2iqsoA3IJN4yEICYk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ont3MVVUqVq0a0lJ2OzQEw1M9JZcuNuqyuqZLm6qcgcS7uVBWVXJZfRAJLZEuScZK
	 KjVjb0ouj4F0rLe7NDvAV7gIrJrwQeev2QzynQH5LTCPQBReKTD/Wf/mSxxoWTWggc
	 H/bfN7EIauNlmpilEoy+xPN4dDWg4EYBseJK6on+cjuQNVCcpftQeSeliFaIMVHn/E
	 ET7c8cSxsmB4SZFJpcywQRyEpm3HaV/ONzNXAIJwcuaYHBEUqqBEYe9dOWVfLdVe93
	 3SHSnwf2PsT556dn2mOCbeEqInMQORaLe6KLUoJ5+03j0YKtb6pVpeweqYs9GGdIb3
	 AT1V1+46gL0UA==
Date: Wed, 03 Sep 2025 17:13:50 +0000
To: Mario Limonciello <superm1@kernel.org>
From: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted s2idle wakeups
Message-ID: <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me>
In-Reply-To: <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me> <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
Feedback-ID: 151975985:user:proton
X-Pm-Message-ID: ef2023fdd6a00a3ccd5ee11fdf542811fb984d5d
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> Hi,
>=20
> Can you please reproduce the issue using 'amd-s2idle' from
> https://pypi.org/project/amd-debug-tools/ ?
>=20
> Basically install the wheel, run 'amd-s2idle test'. When prompted how
> long, set it for ~20 seconds. Then wait for the LED to flash and close
> the lid and it should wake up and generate a report.
>=20
> This will capture a lot of artifacts about the problem in the report and
> we can go from there on next steps. Ideally if you can put the report
> on a new issue here and tag me (@superm1):
> https://gitlab.freedesktop.org/drm/amd/-/issues
> We can iterate back and forth on it to come up with the best solution.
>=20
> Thanks,

Hi! Here's the output:

https://paste.gentoo.zip/mpV8dQcl

I disabled the patched dsdt since with it amd-s2idle would think ASPM Polic=
y is set to power-saving and refuse to run.

It's late here and I'll probably return tomorrow. Thanks!

