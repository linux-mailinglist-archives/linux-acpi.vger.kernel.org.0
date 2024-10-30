Return-Path: <linux-acpi+bounces-9140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 882059B6C1A
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 19:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348E21F2206F
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB93E1CB518;
	Wed, 30 Oct 2024 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="BBLI19gx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DC1BD9DA;
	Wed, 30 Oct 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730312981; cv=none; b=uaPflV4Qmi2YQ/VB44/oVZ322fKGNA0SRKd6pkWinvNZ+aJ+nl9oeL0Oqfbe/yZcplq2YAkAnrj6bZhfekTCDn4eN+ErD3uGurKaCemWdQnlrw6Q5VlWijdFuKyAaKlHzbD0gbw9Im9IvqhvMWvWaOqvbNdwjF9dstahyiRz+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730312981; c=relaxed/simple;
	bh=hYoR0YqPyvmejtGbq8Tt3Ox/H/FdThrUkxzrtIn2j1o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mURA4feeFiuoiAtJv2Qi1lelK0shtovRTw5NfrPzGLMbTAw6jvfYfouqiUan2XVexI0REZDvbEpOhShj8qrh44ehtASbfang2kFunPgGpVNSREASHxbfupG3f2NSWhs8sDwJLLJktwFYiMbF2epsHIWHjXHwcBih5t5nEcij++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=BBLI19gx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1730312976;
	bh=hYoR0YqPyvmejtGbq8Tt3Ox/H/FdThrUkxzrtIn2j1o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BBLI19gxXBoRT2hGgIYHeg3Xte60wUM5Ul+uXHj0WHDqcuuZtR36NZ1QmmJ6QTjYd
	 8LtSmmd3mYpk12vavBj3NbqIiQH4bwu50hnmv1OAjCRXDjq1ZV+l2JBeeSQP93lWAc
	 5DxY2HeydBl2DYgVZ9lSl1YrdFbYileezlNKhLtE=
Date: Wed, 30 Oct 2024 12:29:31 -0600 (CST)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Message-ID: <550e1dd5-91fb-44ae-bbd5-a10ce1b73ad4@weissschuh.net>
In-Reply-To: <ZyJtXzIReSHfKkd_@smile.fi.intel.com>
References: <20241030162754.2110946-1-andriy.shevchenko@linux.intel.com> <63b16433-9f80-492f-9389-633a9852a223@weissschuh.net> <ZyJtXzIReSHfKkd_@smile.fi.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: battery: Check for error code from
 devm_mutex_init() call
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <550e1dd5-91fb-44ae-bbd5-a10ce1b73ad4@weissschuh.net>

Oct 30, 2024 11:31:21 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Wed, Oct 30, 2024 at 10:42:18AM -0600, Thomas Wei=C3=9Fschuh wrote:
>> Oct 30, 2024 10:28:03 Andy Shevchenko <andriy.shevchenko@linux.intel.com=
>:
>
> ...

>> wouldn't it make sense to mark devm_mutex_init() as __must_check?
>
> It's macro, any idea how to do that for the macros?

It should work on __devm_mutex_init().
I don't think the expression macro=C2=A0 in between should interfere.
Unfortunately I can't test it myself right now.

