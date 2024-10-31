Return-Path: <linux-acpi+bounces-9206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58F9B847D
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 21:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE831C21EDD
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 20:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989AA1CB520;
	Thu, 31 Oct 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Sx49+CvE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B270197A6C;
	Thu, 31 Oct 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407231; cv=none; b=pGUVgtCnnT8syW5JsDfADDWwprYlza4MQxqqTQeFXOCD9dncpj8yZbOkoRoXA5AwYrX5zD9VmtCFciSZORW2AkdD0NQTB0MO3ijXErSRKZnK2953Nqo+fDyRjC9j0N3OlNGuJ7T5urb0PwWR/9e881qzLEvtzZddeh2vL5kjJZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407231; c=relaxed/simple;
	bh=MV2PZMdCgyZVwxQqXYwbEL4UaF0wRJVB3Wcckw8d4vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdtJ1zsJKkcw2tZi2dL2DNJIPX1IgKvjYH3nXOeONe0VyajFObE+G1DV/sTrcaJ5jJVyjIcHb6czeWGt/4o8OP+zqZYSGNtyKDWKE1NJpOCW4b6f+yMSH3Qzuf5gbCc/BhzVT6B77NHuRo4/J9PkJaAGnhVq+HGs+Z1RKFPMMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Sx49+CvE; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730407150; x=1731011950; i=w_armin@gmx.de;
	bh=BXG43c4ilcZXIfs6uhHqCHjCjELoxxdYvZiqLVDmo/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sx49+CvEpA1KmgUAoDY71gw3MySZfBSPPwuvxH7mXXvOFeugVuDwsi/Vt1jR8ueB
	 dKiE0OV07v9Nz4CweI6fks+GZOYbo/kKS8kzp8RQ1YP9PtR1JXFwP3CI0KKPRtVvh
	 shPA9z5/ZRoBynL184fKdoCZId0A9c2HVjMsmaCB/jNP9cAymYHpVuwbYgKttryPe
	 oEl2K4iMn+IdY2nWHtPy7WB6dbyPdwV1fG7qszpJ68+ykWdAikVK5MudLhQOEVSzM
	 PglRzG6jD2wsJPJ8QS0fbSb3NEo2mnRtD6t74EoVeQuhTAvdwYD3xYAEFzSBlo5iA
	 BcB/d/2jBmOPobd1uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGQjH-1t5DQh2ISz-009IZ2; Thu, 31
 Oct 2024 21:39:10 +0100
Message-ID: <40b52d41-e3d6-4223-b9e9-0db6b2a19265@gmx.de>
Date: Thu, 31 Oct 2024 21:39:05 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/22] ACPI: platform_profile: Require handlers to
 support balanced profile
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-14-mario.limonciello@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20241031040952.109057-14-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9zQAKx0lk662rnl5CmEQRvMpMRajJCGH1oxs7owsE6gIQ6QBDJu
 R1xPtxAIVX8LvLVwPX0Ryw6MXqZvUXhWZGdWd77LpjMcP5kd1EXMqXDOo0KBseV6VpA4XHG
 AoZz1o8KX0Xf6Jav9WRWfv/flQeOVorWOa3tv9nL8DDsCMMYm9aLKXhyoVzzGS9aqvejdev
 sTgUTU2uR6xLjKD+86+sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:woXGqM+HeUU=;rAsgkzCdSQPkIiKVBZ8ELlIGNA0
 ad2TN95RxXYCaQHi5re4V03ES3MmMgIS2fAI5RQ6y5mOt9pEtmNrR09ynUGdAFBZTlutRyREP
 4lKLiMXaGkrxgZSJK0KldHKcCpRg71js+MYvOtyhaiige+Uyxu1gO6r//8uOSTOpNNz1ItBtF
 hgh05YhOUuP6DE03kJpdmMNLD/iTK7+VadT3VdvHyC/cVKlX42sV7PT3JaRKaRWPFg2OAmwGD
 rpiTMoYizNDpLs+g6Eik7LHATLWH346LKT+Jc/gOi4qwqhb3beHEqOcwnRadqQ+YLtoKRx5kC
 dFry1ryhhzng/0s5sdyyzvvA95d4JkB/QJuqZOFKk2VrVTRwMvTCFuYA+VciA/jGmz/e50G8Y
 GyYySX8f1hcdn4FBuTgV4bSyePsK7oB0Ud7chfjWWmdUTtUh1yPUffUQa6pY/ogW0sF41vOtk
 WYJkdG1UR3/KyHmlY7dFa/Eah1f3//8GMri+ltldvqjwOX1PGvVhhB5nZzUvuwIDN4Li2+0vO
 dSiu71Pu9YPtwkgZnljh2Ex39oKNs80WdKKtA9F79Fikr/l2wK3coQeL0+lF//+4vdK2jfKXD
 rez5oYofBJy7LTtog5yN88Sebe0ARqDh8ojPeF3OhOuD170txjkOJH0Ae4X99OoAPAs6tdUeq
 pLg459TtF7yvYjrf9KgBHNFqcBkuICUfJRysQhxmYBidzZQcIGwOC9rol9W8KdrQinuBNoICM
 ETqdYV5Mbnry6jn3QOoPj+g8xdDD5LKZ19hCtJkQEsv0qwR1K9Ex7DQzFtdOYDlHHo3GuZRzn
 qUuPS9/30Se7172+Gsu56oew==

Am 31.10.24 um 05:09 schrieb Mario Limonciello:

> As support for multiple simultaneous platform handers is introduced it's
> important they have at least the balanced profile in common.
>
> This will be used as a fallback in case setting the profile across one of the
> handlers happens to fail.

Do we actually need this patch anymore now that we have the "custom" platform profile?
If setting the platform profile fails for some handlers, then we simply display the current
platform profile as "custom".

Thanks,
Armin Wolf

> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/platform_profile.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
> index b70ceb11947d0..57c66d7dbf827 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -164,6 +164,10 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>   		pr_err("platform_profile: handler is invalid\n");
>   		return -EINVAL;
>   	}
> +	if (!test_bit(PLATFORM_PROFILE_BALANCED, pprof->choices)) {
> +		pr_err("platform_profile: handler does not support balanced profile\n");
> +		return -EINVAL;
> +	}
>   	if (!pprof->dev) {
>   		pr_err("platform_profile: handler device is not set\n");
>   		return -EINVAL;

