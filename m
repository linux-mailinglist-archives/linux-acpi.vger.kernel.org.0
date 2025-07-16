Return-Path: <linux-acpi+bounces-15174-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA3B06B97
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 04:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0A456172C
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CDF274FD9;
	Wed, 16 Jul 2025 02:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="I5/p2bfb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354A270EAA;
	Wed, 16 Jul 2025 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631541; cv=none; b=ixrQLXjw3wGP/oaeOseObHAGvwtv2PzJlINf07UqBz7BIqBpIdkbVGKzg/wI5YVaVGDTYRU5y+PJ65U2AVZV6fzwDrgdaq5R3zSiHXNU8BCRt76KjeSI90JyS6rW6jzNi2qoEa2OetLEbxQRJ6i3HHC4T3YvTJ+AK1qPwrRaQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631541; c=relaxed/simple;
	bh=Rq7A6ZARUBLXwh0/B00UjiojKtkVI5fFgnBC8LrD1f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naSI27vaCjfbSIfyHeuM1i469hxNcRJTFyvsDBNQh0PxVS3DB83tRFabzAKIu5MdJYIT+jN9tTBzuR3VPph28jj521QwJ2u45RREptzzTYTrkrqMu8smDtAUDTlCWk/CGhe+cj1bN3+hVl+9OFQrVYZQJCumcGpy9SbTqM6Rtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=I5/p2bfb; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752631531; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PJ5lsZI4OHNjAytd5bva2oVW3dsOReZjpWZ15UKmY3I=;
	b=I5/p2bfbQirgArOoCqnw3ztzkCZpIIPuuRhU3qLlLoy1Ldsx9Urs0KnUl/7TtkRi/RpQZ+3Jspuz1GqZxyuq2GPMUNMWKadu0EkZ/qt1VVS2h0qZ1JJ3S2xgszwBUvkZAAAu2d7Vq7V5Mz1RtCTG4h7VXrC53Idk+W5SAkTBAXg=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj26Dj7_1752631528 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 10:05:29 +0800
Message-ID: <564e0deb-73f0-449f-9d0f-181311d3a348@linux.alibaba.com>
Date: Wed, 16 Jul 2025 10:05:27 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
To: Borislav Petkov <bp@alien8.de>, mchehab+huawei@kernel.org
Cc: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Peter Gonda <pgonda@google.com>, "Luck, Tony" <tony.luck@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 James Morse <james.morse@arm.com>, "Moore, Robert" <robert.moore@intel.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
 "kernel-team@meta.com" <kernel-team@meta.com>
References: <20250714171040.GOaHU6EKH2xxSZFnZd@fat_crate.local>
 <SJ1PR11MB6083C38E6DA922E05E1748D6FC54A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <20250715150947.GAaHZvOxsvEvALZNDd@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250715150947.GAaHZvOxsvEvALZNDd@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/15 23:09, Borislav Petkov 写道:
> On Tue, Jul 15, 2025 at 09:46:03PM +0800, Shuai Xue wrote:
>> For the purpose of counting, how about using the cmdline of rasdaemon?
> 
> That would mean you have to run rasdaemon on those machines before they
> explode and then carve out the rasdaemon db from the coredump (this is
> post-mortem analysis).

Rasdaemon is a userspace tool that will collect all hardware error 
events reported by the Linux Kernel from several sources (EDAC, MCE, 
PCI, ...) into one common framework. And it has been a standard tools
in Alibaba. As far as I know, twitter also use Rasdaemon in its production.

> 
> I would love for rasdaemon to log over the network and then other tools can
> query those centralized logs but that has its own challenges...
> 

I also prefer collecting rasdaemon data in a centralized data center, as 
this is more beneficial for using big data analytics to analyze and 
predict errors. At the same time, the centralized side also uses 
rasdaemon logs as one of the references for machine operations and 
maintenance.

As for rasdaemon itself, it is just a single-node event collector and 
database, although it does also print logs. In practice, we use SLS [1] 
to collect rasdaemon text logs from individual nodes and parse them on 
the central side.

Thanks.
Shuai

[1]https://www.alibabacloud.com/help/en/sls/getting-started
[2]https://blog.x.com/engineering/en_us/topics/infrastructure/2023/how-twitter-uses-rasdaemon-for-hardware-reliability 


