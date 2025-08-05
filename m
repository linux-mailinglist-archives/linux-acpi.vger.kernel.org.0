Return-Path: <linux-acpi+bounces-15534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E92FDB1B8C3
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B663118A645E
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D2215793;
	Tue,  5 Aug 2025 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="Tmseg/Dw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02129CE6;
	Tue,  5 Aug 2025 16:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754412465; cv=none; b=FUIfWkYSB9cpIH5+piPCNi9yMtHLfeF6TKNBpyxS8wEF3ASrARcC+NThVb6Argi5A1NYzYxmt2CvVRb1kGMzVtcHBZ8rW2oUaqS5uaM//r+dleS4r9KqW+R0ydzA6tMlFXe2AuEpLQE4sUJtKkHIMKAeCWfDtKY6iC9R4BvxFZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754412465; c=relaxed/simple;
	bh=s5ypr8oxL9cj8XWAEhK6FVzKvi6UgCznPiR7nEXLhbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjl1ERAnL9/bXdkzj1Rj6HQBfsQsMEI5Wi48bOTDXNwit8v7AODwMcL84nBUt4FyKi365rNBaT/Vm/4t6ZHwuopeVDn+Aj3AE1HVqMgo8zKcvZN46b2PxjIv/Q+CSAX+ZkdaAnebUoa29TX8yC6I7skAtfoX3jwQcDQLiTgpaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=Tmseg/Dw; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:14a6:0:640:e35f:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 980F081A51;
	Tue, 05 Aug 2025 19:40:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nejrQShMnmI0-hw0TM4kI;
	Tue, 05 Aug 2025 19:40:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1754412051; bh=qZhHLN1jdew6uEYFDrAVzrNfOVV/ZZ12gq8YHmPcCS4=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=Tmseg/DwBInPwGbdsFITMnjueZePUWr3YRJDJxu8b42027UMPMY7e7NNqTnZedKDn
	 Wu/BBFu9x7dahWB9r8oaUU+X8WKa9oM6GlKuRW8z4UdqOKN9C2RDQGD1JLFPasMXCb
	 /kOrPSawld5TuNb2IzEJ2fTPU1eTZoDd98Pf+F0c=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.iva.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <a9c82a42-3184-4f0b-8e9e-96918cc69972@0upti.me>
Date: Tue, 5 Aug 2025 19:40:48 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Armin Wolf <W_Armin@gmx.de>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <d8f9875b-03be-465b-9715-addd8334a782@gmx.de>
 <992be8dd-f0da-4a3c-8f82-85a6a605e2cb@0upti.me>
 <abf93c41-b026-486e-94bc-e1c2b46b81f8@gmx.de>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <abf93c41-b026-486e-94bc-e1c2b46b81f8@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> 
> FWTS already warns that the ID string is wrong, so all good on this site.
> 

Is there anything else I can do to help get this merged? It's a pretty major regression and it would be good to have it in the next stable.

