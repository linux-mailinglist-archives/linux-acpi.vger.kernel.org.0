Return-Path: <linux-acpi+bounces-15621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560CB230E7
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 19:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1EB189A906
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC642FDC5D;
	Tue, 12 Aug 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b="ofFm2+Kj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17CF2FAC02;
	Tue, 12 Aug 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021430; cv=none; b=aygC/08PzUYbO4FEiMQMPSkJquZfdyMJbXH9bZrqKuKZ2sK2/sDqMbyibHmonYjZUCExb8iKpYyI3YhYKOtTaEPMcF3ED60b65rzDNPCXFSF6mXUexj2R25Sljs1k013v/IOOrzQlMoQqjs+grKNA9fpsEd6kNzDEjfAkgdl3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021430; c=relaxed/simple;
	bh=1Z+U2DJlMAuCw1lLwAJpxBKenOLT+M23V2k2PAUX/N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWX7dkvLesWtOfug5jlYlCq4uVuuaAo8DIMXGsfdlX/UzLK0LuT/yO8FWJngcY9MtVEaEjPubmMpudlVJQEphKdoYxNUyJX1vJETojBb6v+Ox5xdsmIMsndRjUNreiobPJsNvbbem0dqY7YV+6pC8Vir+quzo09i6jlGLKT2Z18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me; spf=pass smtp.mailfrom=0upti.me; dkim=pass (1024-bit key) header.d=0upti.me header.i=@0upti.me header.b=ofFm2+Kj; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=0upti.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0upti.me
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:1aa8:0:640:56c3:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 02B8DC155E;
	Tue, 12 Aug 2025 20:56:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id tuOFsvIM14Y0-jyHhrPpY;
	Tue, 12 Aug 2025 20:56:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0upti.me; s=mail;
	t=1755021416; bh=MAVwawUlLgCHpxdh35P/HleysPyy+xhHuOJcxMhmnSQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=ofFm2+Kjrq2J1SYDJpKgMUPpMyoQfpv1IitwJazcQadpjSjrVHbVvVIoS33OeK/lS
	 YbsWRq4ugUdDW2ESetorV/XTzDY26cv7lp6qI0Qf3TdtmrFFdC+VIFWww8+U5p/azJ
	 Ch9MF6Rs++ptPjtWoB1bZ/nzELxDrqQzatzbNSME=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@0upti.me
Message-ID: <d51317d4-92da-4617-970d-6a63236aec30@0upti.me>
Date: Tue, 12 Aug 2025 20:56:55 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Greg KH <gregkh@linuxfoundation.org>, Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
 <2025081246-raft-tattle-642c@gregkh>
 <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de>
 <2025081227-humpback-garden-7a4b@gregkh>
Content-Language: en-US
From: Ilya K <me@0upti.me>
In-Reply-To: <2025081227-humpback-garden-7a4b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-12 20:10, Greg KH wrote:
> 
> Please read the above link for the full details on how to do this (hint,
> Fixes: will not do it.)
> 

I might be missing something, but doesn't that just tell you to CC stable@?
Or do you have to specifically have the CC on the initial patch submission, not anywhere in the thread?

