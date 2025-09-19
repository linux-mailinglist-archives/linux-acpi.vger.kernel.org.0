Return-Path: <linux-acpi+bounces-17125-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA14B87A4C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3DAF16F149
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Sep 2025 01:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6351A2441B8;
	Fri, 19 Sep 2025 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EG5VCx7L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4B231845
	for <linux-acpi@vger.kernel.org>; Fri, 19 Sep 2025 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246792; cv=none; b=EEO5wpWswTePIKQLQQTJd4gNQmWv3E2H2HMenhCe7S94RslboqrS+FAZ7auV0bymy6l6ubX8JCWgADaKSrhF/eVJ9CX4BPr2xuzithWZkbCXZlR3IdZvg5g6pEE13scr2wzsqdZFxkz0ZmiSj17y1MCkyrVsdJuGjEWMwhQbqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246792; c=relaxed/simple;
	bh=ih2IRnQ3XlePl5x1yLXE+yXxH0Jz4MwvJt1LkRGyOrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDA+UoXsfIVPEk3czHDR82X2jc6cT8EeMo/colTCKHJ2y4fjtbtdE+88UNmNJs6j652dGyNvtjft0ENHREFdy2i3PcYHdwlkBpwp+GuG81FZ7YZnlNslNayJm40lF30yYVLrdVJABPoRK/0PLStbsZMc38BmthsB3JA8teLNwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EG5VCx7L; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758246788; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LgbZj+hEehjjyVcd+jT3wqpfmb95ZNo+158s5pz+gIg=;
	b=EG5VCx7LFaeiV7YxM2NxSpQDbdlM96Y1jjQRQQN+mLVO39b4H+V8m4dRfkkhqPpsW6qtRRo/1aUxlso2GmufQEP+IbcsofOJlURrCmyoEfK+XXBXyPc8Ql9DGgSgMRB0e2F0bZKUPtp/GPKT3WypZJS0n897RZk0orlQweUu3Yc=
Received: from 30.246.178.33(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoHtQMf_1758246785 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 09:53:06 +0800
Message-ID: <248f19dd-25e6-4e97-8169-96da1e860035@linux.alibaba.com>
Date: Fri, 19 Sep 2025 09:53:04 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PATCH v3 ACPI: APEI: GHES: Don't offline huge pages just because
 BIOS asked
To: "Luck, Tony" <tony.luck@intel.com>, Jiaqi Yan <jiaqiyan@google.com>
Cc: "Meyer, Kyle" <kyle.meyer@hpe.com>,
 "jane.chu@oracle.com" <jane.chu@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 "surenb@google.com" <surenb@google.com>,
 "Anderson, Russ" <russ.anderson@hpe.com>, "rppt@kernel.org"
 <rppt@kernel.org>, "osalvador@suse.de" <osalvador@suse.de>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "mhocko@suse.com" <mhocko@suse.com>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "david@redhat.com" <david@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "vbabka@suse.cz"
 <vbabka@suse.cz>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Fan, Shawn" <shawn.fan@intel.com>
References: <20250904155720.22149-1-tony.luck@intel.com>
 <brfqzhbipg35twgv22vnnotbv3t3grwh2dxugvtbgqduuhsvst@f7exibz7i7tk>
 <aLsHh70jI6BGHjaN@agluck-desk3>
 <bwu744g3qzbzylxvfgt7v4tnf2k2eosqbkg7alm6u5roa7j3bn@gmut2l5227kw>
 <aLspJ5Tpqp4qRDk2@agluck-desk3>
 <cf05bc8e-fc79-49e4-a90a-47e661b4ae69@oracle.com>
 <CACw3F538k+dshTs1_rxbpYoRdFyX3tLYzfaWj-_d7Lq5Dd2Jsg@mail.gmail.com>
 <aL8rIgSImDh7Nj7E@hpe.com>
 <7d3cc42c-f1ef-4f28-985e-3a5e4011c585@linux.alibaba.com>
 <CACw3F50hU3BCP=A++Dx_V=U8PKvsTvTa1=krULxfQdeK2kVBrw@mail.gmail.com>
 <SJ1PR11MB6083B887B3EE4DBEB6438C2EFC16A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083B887B3EE4DBEB6438C2EFC16A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/19 02:45, Luck, Tony 写道:
>> Thank you for your detailed explanation. I believe this is exactly the problem
>> we're encountering in our production environment.
>>
>> As you mentioned, memory access is typically interleaved between channels. When
>> the per-rank threshold is exceeded, soft-offlining the last accessed address
>> seems unreasonable - regardless of whether it's a 4KB page or a huge page. The
>> error accumulation happens at the rank level, but the action is taken on a
>> specific page that happened to trigger the threshold, which doesn't address the
>> underlying issue.
>>
>> I'm curious about the intended use case for the CPER_SEC_ERROR_THRESHOLD_EXCEEDED
>> flag. What scenario was Intel BIOS expecting the OS to handle when this flag is set?
>> Is there a specific interpretation of "threshold exceeded" that would make
>> page-level offline action meaningful? If not, how about disabling soft offline from
>> GHES and leave that to userspace tools like rasdaemon (mcelog) ?
> 
> The original use case was defined by IBM [1] (that division is now part of Lenovo).
> IBM BIOS enabled a firmware first mode to handle errors, cutting the OS out of
> the picture. But the challenge with this was how to handle a case where the BIOS
> identified a recurring problem on a specific memory address. The solution proposed
> was to use GHES notification using the CPER_SEC_ERROR_THRESHOLD_EXCEEDED
> flag to let the OS know that this corrected error needs some action.
> 
> -Tony
> 
> [1] cf870c70a194 ("mce: acpi/apei: Soft-offline a page on firmware GHES notification")
> 
> 

Hi, Tony,

Thanks for the historical context. Understanding the IBM use case
and the original design intent is very helpful.

Best regards,
Shuai

