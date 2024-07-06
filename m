Return-Path: <linux-acpi+bounces-6787-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D09293E8
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003CCB217FE
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Jul 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD56BFB5;
	Sat,  6 Jul 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fnpFjxMm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2817722;
	Sat,  6 Jul 2024 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720273646; cv=none; b=CYhZ44x624/8E356k+NgBD3PXeddqsJthPKG8omyYueyW3f9AWgjGVWeGiH0ycEzSviGWCwRMw9wy3DfFSph2Rb7YA24topkh+z3PQAOflm1rjy1CkhgnWpsGC2Fsif09BqBm+Id+HBgjAzL8nqKLp4UcEr6W9thtOk4aNOSX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720273646; c=relaxed/simple;
	bh=gKb+fOdqmF+Ow9L9QOaxxCq+3QMp16IRzNpmu/XxDQU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=a7bU9x5R+73OtOuX4EkogoQgf3VUSKQogK+ex+gc3sqhF6KRu0zuyi2ADhpBlfRv6CaMcQDfeEplzkUI7XhQQgwI7NOoDKji0hf6b4Vb8qa1wVuH6GMSv/Wu5gb90u/s2nmVW2C2vSdltVH7fYpyFqfUNTmsJ5FDBgnqwu3isX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fnpFjxMm; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720273629; x=1720878429; i=markus.elfring@web.de;
	bh=MByzy7Ml2oLP3hM4rp6O/TDGgtDc1cSqYNTvBixN6dc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fnpFjxMmy2tXUu/pPUp91fzsHHdSUiOIYCubMqIdYpUNbtQ1opSobH7aSx6YUHxT
	 QYoQW285Yu1GrUbmeh8VgTngC94IOfD0ScsI504ThGEJ7mjWkWijJl5kyD09PbHGp
	 f+4nYB72VI9xhyYRxIaZwQZINfyvL+37rV0xwL+MshZsB/i6LG7Dlvkfka/mFXGVb
	 4jmaolh5XR5/RHMVVIKnF0SN2mDvhGhPb/3P+k3CqGxsPQrE6NNXrdNhlzX5znaQV
	 Oha8BhkQEkG03Z8pens6jkOUKM8ldDRAtFmoLXRjwUgMfQgHjeNiYdFY5LhtCWhPd
	 Zqp8lN/AHWXNpVRQyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLifq-1shcbc43Q8-00XEGs; Sat, 06
 Jul 2024 15:47:09 +0200
Message-ID: <4ffe1d11-8442-40fc-bb93-581e9d1c93ab@web.de>
Date: Sat, 6 Jul 2024 15:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Aleksandr Mishin <amishin@t-argos.ru>, linux-acpi@vger.kernel.org,
 lvc-project@linuxtesting.org, Rajmohan Mani <rajmohan.mani@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Len Brown <lenb@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240705113434.17249-1-amishin@t-argos.ru>
Subject: Re: [PATCH] ACPI / PMIC: Remove unneeded check in
 tps68470_pmic_opregion_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240705113434.17249-1-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2cul2SYca5S9Qs6D+C4Qi/0pJNP9zIDAziQ2WAPO29p2UDgE49M
 4fd7xKzA0AeKp5wnWl3LVRLzXfAocDoqpJ6+GgvscAJoAT2A830Tn4OKoxuKZjw4wKyxN33
 l+cT0xtm5wdWf0T7i3vwzBaaFKO/7YAHqoz24gPaurWyzNN1L10W/x2X9ONhTEmpEE3IyFb
 sGoAjkcf6R8mgF1zs/mTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3X6Ayt8S5eE=;xTS0IF0OTLenoH1/SApCXE9Y5Aq
 PXtSPqqjpUcxjYrm34GXgf0eufpOeTXkUflYUKasosvHwBSN9kB3HGC2dC7sSiSjy/EkMUG0k
 soMNY7UZNc+SC7LQVz0vNpVF10/8QDoEiGy7dt1/NucJcCu0JZ6/X5/at+eeAhanmaJbWc79n
 32pXiN0zprJ8XZK40kXSDMCGzH0tzRR/P6yEmXKzNnFPM2Kkf4CiAm9j0bDHHNj5gv5OEQbUT
 tHDMc1QupM5MvCU6jSTVsSHIddPyPiUXN/gvZuyiZQdDCdivrVwfZvEzQUy3Q28ota91YlGkZ
 tZL76VTFPrxn2OR77q6fNvNFMzh4whsAXtmeCqmyzuKFdD5ffQCF89T18oGEZUYjSVV00XnRT
 brYkCp+otppvBeqnRuDtUcvDquLbTZp39lcZckSPiPhdxiUoQf30PJAE3qg2GWKJ4oboLHIAe
 eOXhb5OTQywu/GJIcZ8UwrjGtwB+gFbOvMjXWfs8/AVtz6ZDIzvfGRDXA1PWASwSIvlqfbYK2
 mrXka99jGmTx4WxbvM4qWog6Aw5JyP+OTdWtGp/AkzzpTa81Lng0Qhhjryw99uup/a2S8ymVl
 R8XyIXta+8zU+QDgXskPG440UbOnO25nwuhI8raqDH87otwpi4y2VnaVQsJucqrXXfilo11cI
 hez1Qg5TgkUjRqdS8gcpzmabmtyDRK+Ubm0yVylMRAmAfLvqIXezNk9pZ+8y/IkMV1MgL8VeN
 z2C77iwSleXUe6ApZH92ua1zQhVQd3eb5Lrw58ynrUEfuMd14MHsgdK5liXPcIgm4O/S45AQv
 RKhnXQQqC75zx49rK1HQrueO5NEGkF44J4mQcNs+ODJWc=

> In tps68470_pmic_opregion_probe() pointer 'dev' is compared to NULL whic=
h
> is useless.

            because =E2=80=A6?


> Fix this issue by removing unneeded check.

Another wording suggestion:
  Thus remove a redundant check (and =E2=80=A6?).


=E2=80=A6
> +++ b/drivers/acpi/pmic/tps68470_pmic.c
> @@ -376,7 +376,7 @@ static int tps68470_pmic_opregion_probe(struct platf=
orm_device *pdev)
>  	struct tps68470_pmic_opregion *opregion;
>  	acpi_status status;
>
> -	if (!dev || !tps68470_regmap) {
> +	if (!tps68470_regmap) {
>  		dev_warn(dev, "dev or regmap is NULL\n");
=E2=80=A6

Would you like to adjust the passed string literal accordingly?

Regards,
Markus

