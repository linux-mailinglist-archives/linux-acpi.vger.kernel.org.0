Return-Path: <linux-acpi+bounces-12425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA9CA70A9C
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 20:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77547A4959
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Mar 2025 19:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE54A1C84B2;
	Tue, 25 Mar 2025 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i+uptN6X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E471DF98F;
	Tue, 25 Mar 2025 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931400; cv=none; b=qFsjO9viyGlIX2vM3g+ZxBNSrpQDw/94xbR2yLMiQWExheieU0TNtaTAwwpsuDR5H449dxbeapC4HzoCo4+UyFPV0zBPNgGKxb+DYHSHAUDx5RtbJshaN/lx+2pYL9Fx7uYqiHXTb8UIsyy0ckvzBs0MnvLTCE1Ec6roD4IDxrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931400; c=relaxed/simple;
	bh=DUTM7ztKjFmkSDEZYYjGIaN2pOjh/5as/gUaUsrAHCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZwK0GtKJ1YiQnBxejzSZQHvhFd4k+/MhkZrfAEn2cHyDnN+XTOBotNL9Z3gFwPuk0gfDsuwOPHYM8Vp4fJCoAuBGGsb+6fXbrvQaqMMAgZbvfDYQaVJf8QiZOu0C89U3Hq46KIVhAAmhec+0VgJ3PyOoavDw9T4wMBB/xEu4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i+uptN6X; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742931385; x=1743536185; i=w_armin@gmx.de;
	bh=w2rUU1hQX5apf6NgBk8mjjsIeJ2b5QAp1KZy+bb5PAA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i+uptN6XHmA+yfQToCxf2jy/V0VL4j99LufTKAF4qv16loWWeh/ac/2qPNVBdTku
	 d5exj6jK4uBzGXLwiT0dc3yBLoglWaqTN5SK0ONY883MVGIdUWdQWcN3k75TTfzRK
	 OWOitPy23vhps/5Soe0EMqQ+GLk97FNNNe/c8FEEtnLKnU6779TXT4G70zqdR2Ady
	 WEep099rBYeww8Op5MnaG99gaf1zwqufBkPz2GzMAk9Tu5kIeaDTkSBPWP2Nwaejv
	 MIjUcosedj96d+AwE25q4dP/WPY1shgH9ITZ9qdBV0edr56Y3iJJlxw9yGTnlsyWb
	 dN7dvtlMVBLJAEUrcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.124.146] ([141.76.8.146]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1tlQuI2T3z-00S1zW; Tue, 25
 Mar 2025 20:36:25 +0100
Message-ID: <a66f55aa-9ee1-404b-8f78-258b307ea361@gmx.de>
Date: Tue, 25 Mar 2025 20:36:24 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: platform_profile: Optimize _aggregate_choices()
To: Kurt Borja <kuurtb@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Len Brown
 <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250322-pprof-opt-v1-1-105455879a82@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20250322-pprof-opt-v1-1-105455879a82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KSxO+wDvcf8a7WrXYKlHDkbpkbjAD1j7r+uUxQ4lmVKaj+/pnNK
 SWhWHC8KVXIuS4HVSqRIODnb/7MT24uurFHmowf6Gme0KtlUgyMtTdlf27mEUlp5bC86JJ7
 8ZrkjcDafXYokWfowZwafd1pahvDfzN8ELdb9nDYPJeX27pD+cGV2aQUigd8XZVnC2vtuiC
 ekPmvVrtwy7nlfQKKkjgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZSYWGQOiG5M=;XLK0EbOElR7+swyocv4Ly0nbB3N
 8GVMOMmCKLjwxFPltKpgEqspCMgup1He/zS1jKk9Np+1Ecx5XYezZD4hg2j7V2RNrLzDJbmYo
 WGpotl4cmWZWRi75fsu1j7Aw0NN/rAUpzRMIUlXrw51ENofTOhF7D1lJ6NOja1X8KHheBADIc
 QSAaWljl0aRvhgEl6w09XjMhJStfWLzt4/qPnOacuCa6txL9x9hQBKbjR0ZOPPYzgMTP27n3d
 ZC7+UrTHN/nN4c5tO9Yl92SbyoPJ6KYNp6tcvExrJzHeM0jXKHzl9J5qxbDd6xNZTy8Iw1VUL
 ZV96MpQLjpsrY00nDHAigGap33le24KHpGmoa8lIIiuXycOliWOZLe2BYc36tnFW0yaQOvrqn
 5M25PLSKZwmGegcmo6iCcmDj8CPb5ypSCIYf0jDty3E66bVG6m/95ohmg86qgUNYVqkPj+Op9
 p8H7AnqFeRwtvd7s/jhUFAPHxYQCBbPkQT05T2S7bLdq1ilopEIFcY3y/lEmDKUozHI/LSn5E
 kkEu/P+K/59PhKIFNvj+W/kwA/XgGaDEmM+FJqFQj1PDEIT6OmRGs3SuLWMtoOcAG+JkWWIC0
 RGflubmmNgLxFQUOKIp/V2WIbWAX+F5mFLtG8PTKly8xwIPlBtmpBXD0JgNMN/P2zxAFGcWIM
 fIiSRjZmQ9EU6a83tzPjNUKZzCtBlRmOGKhTUiy3ytj1pNvX1Xk7kIFIudtuotWewYNY32RrC
 QVCNBYBxeLrLDSvIZ2ZrRmByKu+z1tN7ROK5BkWtvcB1bJkKu4VAZUtsui7WwmF4uvcfp4sVt
 Q7wogVblGEO2e40mjmqAUOTj4RK+BCIwxMi42jNx0IjUnUd895/dYFt0MgDMq1hDzdVlZC+4R
 IoOzsl+4+FxBoZ2L9U6VDsSUQSelXooqNkNp5XWTHVgCjgygYgJUwwlIF/nl/U/7dsW+3BQPb
 LBy0zqfnhPO/xWO88DKFZBBSNcdPurxuKj5Gylw2SbnaiiUXyWksBGll4HwnVHSkF0E5dsEO/
 TqHgM5kJ3R85EaPecicHKcE86FEef7W+JuJwUyugNWUtjVS1y0cpLQlq4qGKOoBEgQdHgC2oF
 hVxw8TPuBRZhaGP1l/FxiWUyMPNTHbSCOOV+5aO7Ly8VmzULYn8zLDDxZVUswnRtZYIkxYXcI
 d6b/Bezp7v+E9TUaLDOfrsYTA6PYy1RFMWhBuRNA1WQWvduZ2uG7AHAXg5AhYyR7RW4BbhbEY
 N3fwGna9OyB3hrMr6Sykdup0QaWT4aGCntKsJtBb3/fPLwOU+KuOq9pwcmaatGGXLVa8cehQb
 Vsy/uwd6WmQ9OyplydHAi4lEJ3QgL9429pq2kaOXoTEsHQRtNAxyzzuPSHxHk5VizNtlHr4eE
 7YEx5xRg6CCuWaU8JMSeP87BnAFRnT1CkpuZ6kvRWh6AeuQh/r/eM8FdvF1uAo04uRPIWk+Gc
 2Fhifsk/M6Re2ICaPQkSic17M5ePWRWZ2WKqyOp39y1aEN1DQg5GGQ+Qgv0o72fiH6ZPDuA==

Am 22.03.25 um 22:03 schrieb Kurt Borja:

> Choices aggregates passed to _aggregate_choices() are already filled
> with ones, therefore we can avoid copying a new bitmap on the first
> iteration.
>
> This makes setting the PLATFORM_PROFILE_LAST bit on aggregates
> unnecessary, so drop it as well.
>
> While at it, add a couple empty lines to improve style.
>
Please add a comment to signal future developers that the bitmap needs to =
be filled with ones
before being passed to _aggregate_choices().

With this being addressed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>   drivers/acpi/platform_profile.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_pro=
file.c
> index ef9444482db1982b19d2a17884e1c3ab0e5cb55c..b5b24b075af6dfa612d56eb9=
5342c6af87a60d3e 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -256,12 +256,10 @@ static int _aggregate_choices(struct device *dev, =
void *arg)
>   	struct platform_profile_handler *handler;
>
>   	lockdep_assert_held(&profile_lock);
> +
>   	handler =3D to_pprof_handler(dev);
>   	bitmap_or(tmp, handler->choices, handler->hidden_choices, PLATFORM_PR=
OFILE_LAST);
> -	if (test_bit(PLATFORM_PROFILE_LAST, data->aggregate))
> -		bitmap_copy(data->aggregate, tmp, PLATFORM_PROFILE_LAST);
> -	else
> -		bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LA=
ST);
> +	bitmap_and(data->aggregate, tmp, data->aggregate, PLATFORM_PROFILE_LAS=
T);
>   	data->count++;
>
>   	return 0;
> @@ -305,7 +303,6 @@ static ssize_t platform_profile_choices_show(struct =
device *dev,
>   	};
>   	int err;
>
> -	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		err =3D class_for_each_device(&platform_profile_class, NULL,
>   					    &data, _aggregate_choices);
> @@ -422,7 +419,7 @@ static ssize_t platform_profile_store(struct device =
*dev,
>   	i =3D sysfs_match_string(profile_names, buf);
>   	if (i < 0 || i =3D=3D PLATFORM_PROFILE_CUSTOM)
>   		return -EINVAL;
> -	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
> +
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		ret =3D class_for_each_device(&platform_profile_class, NULL,
>   					    &data, _aggregate_choices);
> @@ -502,7 +499,6 @@ int platform_profile_cycle(void)
>   	enum platform_profile_option profile =3D PLATFORM_PROFILE_LAST;
>   	int err;
>
> -	set_bit(PLATFORM_PROFILE_LAST, data.aggregate);
>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>   		err =3D class_for_each_device(&platform_profile_class, NULL,
>   					    &profile, _aggregate_profiles);
>
> ---
> base-commit: 9a43102daf64dd0d172d8b39836dbc1dba4da1ea
> change-id: 20250322-pprof-opt-caa7f7f349b8
>
> Best regards,

