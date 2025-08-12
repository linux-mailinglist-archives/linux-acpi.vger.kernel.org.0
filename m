Return-Path: <linux-acpi+bounces-15617-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91633B22CB9
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 18:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AE77BB5CD
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 16:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6592F83DA;
	Tue, 12 Aug 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="WQdp+g2Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E984323D7FB;
	Tue, 12 Aug 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014292; cv=none; b=RGQCvywAed7F0kI/qHgIfLwdqh5Ueo2Ttl/e8+aLsF6fpwO+QVZ5f9EB0NpINAqKQDedjTZbtgr9YRf6zznhLo8+qGMf0SqabOcYig1YX9r07XXisX4stLyh+/5+wtFQwqC2LJigzqgmTZAVVvPrq3+yPIil6LZqVVMtrkNaz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014292; c=relaxed/simple;
	bh=xv+rmX46Y9t64i9ZEtyothmd3qVuj/q7MJ/Dq6rC208=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omxkf6hJAif2wHSEt+6KFCp1P3DEUObpCUek0KRF1jCShjPnOfHw/gPPcyGCnX0GgPANiz22KFSiA/nZPesMh5T0Fhf5Os79kFf0KtlT+9mjfPkheFz0MqOCz4nIENRCIf9X5xb+CuJFnAikJI6npZlJGL877PKb7MmlelePEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=WQdp+g2Z; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:50cf:0:640:8bee:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id B42BEC1ADF;
	Tue, 12 Aug 2025 18:51:13 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ApMGfrFL3Gk0-9wvaO8N4;
	Tue, 12 Aug 2025 18:51:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1755013872; bh=0sVBm01edeogawEcxutleKZJWOsoIpfQWZw1giV3TTo=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=WQdp+g2ZnKrwmDVVYUKBlqV93JpeAwUMBTuzdKtUKkewvmWFB8v2bENyPBWDkI2SP
	 lcENff3J1DHqoG9huAUERplud4W2prCajRxSdcf2apJ1kxbjgpOQy8yg1JNEDTnDcD
	 QG2XxdiPKN006WBkKJn9jv2MT+JHG5uby2Qk9ZYI=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
Date: Tue, 12 Aug 2025 18:51:10 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-12 16:32, Rafael J. Wysocki wrote:
> 
> Applied as 6.17-rc material and sorry for the delay (I was offline).
> 
> Thanks!

Thanks!

Tagging stable@ so we're hopefully in time for 6.16.1.


