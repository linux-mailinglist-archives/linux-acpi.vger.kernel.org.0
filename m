Return-Path: <linux-acpi+bounces-8503-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61C98AC68
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 20:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B61C31C219D4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Sep 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABF7198A11;
	Mon, 30 Sep 2024 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cO2Y8auM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C4198E93;
	Mon, 30 Sep 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722423; cv=none; b=KatejFoyuZGZtMASL46wLwmhbYos++CJ4Oy8loXjooSD+UAxIDARHHj4NVVMD16t6R7ehUSt/1NrAUwKJW5M+t8FY25xQj+DQZNvVcTqyI57FUli/S55J03CgGRXkTCXM6/+vRG0B7WVB/q/tDgqY/ejBzn/BUoEj5ZA8qgLEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722423; c=relaxed/simple;
	bh=ppReR8GcGyVCEegWkUwP4oz7BDNDQnUjnv0dlUVwO1Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=D5lrDfrYc/JWTnDo7lsC4hKZs1XQDczmlAIigxg2FzEGixjGCbSzhcJ2uFdU0puTubm8G+PEx+pSDYJ8vC1bBH6o83tAF3/xykqzi4G3/xAGex6d3chs2bAtdPiJIhfuFC6yhy/q6+tCVWHi7Ldtojy9NWSN5gfwHtrVrIrD3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cO2Y8auM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727722401; x=1728327201; i=w_armin@gmx.de;
	bh=qyNnKDWNIRzY7n2r+FhUqUDgrRdnczD0CqYqMHYr4jQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cO2Y8auMeEy30LUbMwUCfy0CC0uvp4boY2j7s6vIzVV0fwEzmelaA/YeJP7/4o/L
	 qdtWFIfRAhBPly9wFtLZdSDcQ4camxtGhEkevuNsQ1QUR7H+3V7iLJy16SsoNZCcS
	 J3Ngjx+2BV9rReR/e6ZK80mZ+0Gfn1gvBBWv7NdxvvHR2kzd3eUGziD+BJ4K3n9yy
	 EgHtf8PQWD4vQF+CUSG5mT1Rp+ny1vO/bPY4GVYGF0v9p0cPNjW21X6BqY7amAuqH
	 NyOnfyc89CICzMsrJ7d0YNCksTHMb87ApuN8huSuhu5UgNkw6Vk7ynlr3sjs5boUm
	 KGEW3B1HvTJvDU6Pjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1sembl3Ck8-00Nuf8; Mon, 30
 Sep 2024 20:53:21 +0200
Message-ID: <92b62046-d225-4dd8-a894-30f051267f29@gmx.de>
Date: Mon, 30 Sep 2024 20:53:18 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] platform/x86: dell-laptop: Battery hook fixes
From: Armin Wolf <W_Armin@gmx.de>
To: mjg59@srcf.ucam.org, pali@kernel.org, dilinger@queued.net
Cc: rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240922064026.496422-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20240922064026.496422-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bIvUH7micSPGPrZ9NXnFSmxVbu4ulZKux1Y2QH7fAX/LYAdN2j1
 itCxWE+ZdMFImPWCJ7be7TULPssKW/5adqrkE/wRPsyevChu2FuWDwY4XhPo0mCzH0SxPA5
 MNHakeUfiilwN8MJ/q5LUPy29ZK3LFUllp/DVo6aGF6usYSJk1q7JZQTHm1NWdmyMeZaglj
 Tv76BJsxsP1ApLe4DWFMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Cziecr+DTkk=;AOniTTCBKVeGrews7r6KXJ5sZLb
 pzK3m4HMFhcpItGlGHpAgRDirpwtFAOKmTIjIGz5xZCAcQU9bEGBP1dL6c41e4FJLfHGro6w8
 BtCcPcDjQkXNuuNHm8M6VgZ5ooaY8Zit8tRvUHMLssV7rdRGCZBTdVVVKcFdV1IaB/lvkke5C
 27F3Z5TftQq/9UBDi0cXzjheVmRFq4aHLihk+PqTPxaLYlmfApTwcJSOy8LIvQgd1SwqGrC7N
 8WSQ2EHUX2fS37qY0nyGdSDW7qb9cnmtxttICp4e+4NHYl2lYwMZFj5itlRFmNh50yG1MDOsf
 k8qJMAKNmbWCO3yGXPST80VwGSnqP2AdCRzHQ9xB9Sdxdn0k8rBBaJTgxXBBusIMxD2biCiM/
 LhZ2oor2Kf8y1gmQffIQhpaadpMra1p2XFSL2G0JHl8Y2IPpiAtD5X1LIIRmW4kfwEFVETj0H
 LSKQyb2xxc1VSWMmsL9ArL1uHUqyfxrBkWKYmPDxYIJO7w3R9Iw8lbASTnIXQMFT/H2fkVePH
 QCkMN6JE0pz+PZvScni2pVKhcvHBRZ/5H0HxsHVlFnersm4RFMeklAwmhbCXBpWSgFoctcsDN
 weHA5cik1WB8SHiEeotJbNtBOvvLXLBqgr5iRtdwOD61QR2153124zAO6ui1XLpOZLHCC5j8G
 EbV2fNQ06raEfyWQdruBx+VuBRgZKWFM4K3Is/qYUw7Io2ZYhytYjHSz1bZ81wnT37KdXfeaX
 0HMeHhMtJe/+jTQuWYXINwOigZ4ySx0UjE0P88VMW+kCBWVKWIgYPtJ8XVB5zfZiZuyYFIsRk
 AbD+/ABehy4FFXV5gJMBtEF+s7zAmrMjDTFWwbSzJDDZI=

Am 22.09.24 um 08:40 schrieb Armin Wolf:

> This patch series fixes some issues around the battery hook handling
> inside the ACPI battery driver and the dell-laptop driver.
>
> The first patch simplifies the locking during battery hook removal as
> a preparation for the second patch which fixes a possible crash when
> unregistering a battery hook.
>
> The third patch allows the dell-laptop driver to handle systems with
> multiple batteries.
>
> All patches where tested on a Dell Inspiron 3505 and appear to work.

Any thoughts from the ACPI maintainers?

Thanks,
Armin Wolf

> Changes since v1:
> - fix the underlying issue inside the ACPI battery driver
> - reword patch for dell-laptop
>
> Armin Wolf (3):
>    ACPI: battery: Simplify battery hook locking
>    ACPI: battery: Fix possible crash when unregistering a battery hook
>    platform/x86: dell-laptop: Do not fail when encountering unsupported
>      batteries
>
>   drivers/acpi/battery.c                  | 27 ++++++++++++++++---------
>   drivers/platform/x86/dell/dell-laptop.c | 15 +++++++++++---
>   include/acpi/battery.h                  |  1 +
>   3 files changed, 31 insertions(+), 12 deletions(-)
>
> --
> 2.39.5
>
>

