Return-Path: <linux-acpi+bounces-16091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B870CB37C43
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 09:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34E5188E384
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 07:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1632145B;
	Wed, 27 Aug 2025 07:53:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B51A9F86;
	Wed, 27 Aug 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281180; cv=none; b=loL5I2KC4KEzDqTiT1ycHTY11OdU6PQCbxzQfhUqirxJKKBHIGZTF+UeWHP7Q36Xyu+aJ7CHz/PEuJbmg4bzx9zXn3o1UQEh5LfDPr97cFmVonQONvKzwJhnjucVCCgKg2HTAmdcOq/O+tey2WPqcq17QDeIJidroFx4wxDDO4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281180; c=relaxed/simple;
	bh=t/7jF4HzApSGOAuft7CjB89pJWIK0eoDPs3XyyfXOW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA91a0HNZkqASZYVQ1y+kjofiv3QXVRjFI9f/s7BnjU0MAuFerD2cGPQDb1tVZ7jFIUv73M8l6jL/uZhEgpGG+N9NdUWHAQbhkm65kjS2anz/dIp2zw3koMf5XKlvvERatvnJEwmFID9UMeVCpJyc8APs66NVCyhWvEEkDH+oGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d3e5785c831a11f0b29709d653e92f7d-20250827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:13314357-5ac7-4a30-a0f8-4170a13db8b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d6d895d233e5934b84c0d63ae6c55bd7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d3e5785c831a11f0b29709d653e92f7d-20250827
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1407213635; Wed, 27 Aug 2025 15:52:49 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 5DFD1E008FAA;
	Wed, 27 Aug 2025 15:52:49 +0800 (CST)
X-ns-mid: postfix-68AEB951-303610565
Received: from [10.42.13.21] (unknown [10.42.13.21])
	by mail.kylinos.cn (NSMail) with ESMTPA id 93400E008FA3;
	Wed, 27 Aug 2025 15:52:47 +0800 (CST)
Message-ID: <a369a7a9-9132-4b37-8ba2-501503477bb8@kylinos.cn>
Date: Wed, 27 Aug 2025 15:52:46 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ACPI: processor: idle: Replace single idle driver
 with per-CPU model for better hybrid CPU support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
 Shaobo Huang <huangshaobo2075@phytium.com.cn>,
 Yinfeng Wang <wangyinfeng@phytium.com.cn>, Xu Wang <wangxu@phytium.com.cn>
References: <20250814072934.1016694-1-tianyaxiong@kylinos.cn>
 <20250814073156.1022939-1-tianyaxiong@kylinos.cn>
 <CAJZ5v0hGj3=GxnLkj0adm+ENSk7YbzNZRPiBTgm_bKZsH3OYDw@mail.gmail.com>
Content-Language: en-US
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
In-Reply-To: <CAJZ5v0hGj3=GxnLkj0adm+ENSk7YbzNZRPiBTgm_bKZsH3OYDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/8/25 22:56, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Thu, Aug 14, 2025 at 9:32=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylin=
os.cn> wrote:
>> Current implementations of hybrid architectures (e.g., ARM64 big.LITTL=
E
>> and Intel Alder Lake) feature CPU cores with different exit latencies.
> This is not true for Intel platforms, all of the CPUs in there have
> the same set of C-states.
Yes,it is.
>
>> Using a single driver to describe_LPI states for all core types is
>> therefore suboptimal. This is further supported by ACPI specification
>> 8.4.4.1 which states: "In a processor hierarchy, each node has its
>> own _LPI low-power states specific to that node."
>>
>> To address these limitations, we replace the monolithic idle driver
> It cannot be replaced or you potentially open a Pandora's box of
> regressions on old systems in the field.
I agree with this point. Regarding the potential risk, does it
make sense to=C2=A0 mitigate it through the following two approaches?

1) Restrict the usage of this multiple driver functionality to
the ARM64 platform only.
2) Use a mutex-protected global variable to indicate whether
the platform utilizes _LPI instead of C-states. This variable
would be determined during initialization via
acpi_has_method(handle, "_LPI"), and the multiple driver
would only be used if the platform employs _LPI.

Alternatively, the other option is to let users implement their
own drivers. Although many ARM64 users still initialize their
systems using the ACPI method rather than the traditional
device tree approach, and they hope to reuse the ACPI idle driver.
>
>> with a per-CPU model. This approach enables accurate idle state repres=
entation
>> for each core type
> The per-CPU model can be used instead of the "monolithic idle driver"
> only if the platform is actually known to be hybrid.
Yes,select CPU_IDLE_MULTIPLE_DRIVERS if ARM64=C2=A0 can=C2=A0 resolve thi=
s issue.
>
>> Tested-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
>> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
>> Signed-off-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
>> Signed-off-by: Yinfeng Wang <wangyinfeng@phytium.com.cn>
>> Signed-off-by: Xu Wang<wangxu@phytium.com.cn>
> What do all of the above S-o-b mean?  Are these people involved in the
> development of the code?  In that case Co-developed-by is also needed.
>
> Thanks!
Thank you for your response. If it makes sense, continue to follow up,
I will address both the issues mentioned above and the problem
in the previous patch.

