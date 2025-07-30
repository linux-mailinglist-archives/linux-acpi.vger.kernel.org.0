Return-Path: <linux-acpi+bounces-15423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D4B16520
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B737A3156
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 17:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24721DFDAB;
	Wed, 30 Jul 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="aBvgDuBI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F8153BE8;
	Wed, 30 Jul 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895085; cv=none; b=PYtInPcsUe7IZwY4UchOvC+7MLJoyeb9VE1SPtJJmm3A4J2tL/EazsOGbtHXw0TbvvAYUakJes8hUgnuLw8G3JjBUXwQQNiFk9QSFJM/q3bcLMSLnyv5CusWfwG3vc6Npa/WMP9QGQZi/1nNCw9H1Qmsc4FmCdF3miw2bmQw5Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895085; c=relaxed/simple;
	bh=hs3dzAjyUKphmkDxjxvVhAKvISabdzhuvqT2WcHlYq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+g5MdhJjH4qflIPQ4jUzK+rGd9EYTjNAdHxjxff9aMoJ5DZnrTryij1yPtSTrUw6K7/HgKSoue4KHUSLl1EkvKkNjJpsoiw7XCoUh/VHWd/fWosR6bRbn36S2jdbRTt492DF7Uq9ExnfwvEgFS9qYkfvPYJTWyVjyUPvxMqP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=aBvgDuBI; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:1ca9:0:640:4823:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 240FD8998F;
	Wed, 30 Jul 2025 19:59:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 1xdvEk5MaGk0-7c6jaPuk;
	Wed, 30 Jul 2025 19:59:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1753894742; bh=yLAVHffmFzit0X/rM00O1XYfW0WHPBgT57gj8AuJI30=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=aBvgDuBIeS18OFmd24+Houqtycb/2KKlen/4z59Trw46fs8L/N1XrocdWBfrAo1Tp
	 a2VZJniED7n0ZjpYXGS05FNHkYXyyN6JXycMEXqpPXvGh2u6HLlPDhvoT3EDcJEa3z
	 d2VH5aYe4lSD+KIz6PlZHZ6E0Qg6Wz3zzKjbdFKw=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.iva.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <992be8dd-f0da-4a3c-8f82-85a6a605e2cb@0upti.me>
Date: Wed, 30 Jul 2025 19:59:00 +0300
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
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <d8f9875b-03be-465b-9715-addd8334a782@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> The Linux kernel is not a verification kit, so i am against keeping the old check. Instead i suggest that we ensure that
> the FWTS project (https://github.com/fwts/fwts) detects such invalid ECDT tables. Can you share the full output of
> acpidump so that i can run the fwts tool on it?
> 
Uploaded here: https://github.com/K900/21mr-acpi-dumps

Thanks!

