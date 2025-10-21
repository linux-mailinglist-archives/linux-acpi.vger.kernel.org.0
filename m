Return-Path: <linux-acpi+bounces-18017-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826EBF4C47
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 08:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE1F18C05CB
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B38C26B764;
	Tue, 21 Oct 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q5E+XnHT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD625EF81;
	Tue, 21 Oct 2025 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761029710; cv=none; b=AfVqa9sRQrLCymg3CEwuBFrhEjHaqteso/ib5SxE1iwTFWY7x5fR99r9+gVw6gzvHJlBS7P99PHeYaC32g17JOBcgICfi8KeBFJHl0ev7Pv9buygY4ZJ5lqNjy3HUXvhqbCJC8KUaGz/FLlknETP37wMzScdeLjXTXLcGzhIBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761029710; c=relaxed/simple;
	bh=b01jDFBPXq5rbV8Y/L7o1RFolYKy1v18IqquZM7AR4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3xClwdbF3Gi6JfmYqbLkA8na2bI+tp+oafEqOOVEiSJxUuqx9nLWtH4XLM0ZHLPnBN/BEKHSw3f0gQtskCE5Nv/EwUbMGdrdHnD2GMXfZ8yTCme6aiCWfPC3ZmP65MBnzqVGWEqUKPgHkjQhjsTs7K2qi5S4kwpgTdkANScv9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q5E+XnHT; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761029699; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hW6pCW/lelgtOE/oMGx+iPlRXFCWmvEmZjCWVQr6yhg=;
	b=q5E+XnHTiXMltzCPWENoIwgmZlX0FafHZjYYyhMwH6Zcegpv9DsjC4NmzhRKvl9iprOut0oSVQpPA+lq2iYzNJeuiL9BviiQoEO0gO9sLFFwE6SGG4Hpce/vlJYer4HoEzcr6fbUxzTD+eeVEdcqSuha3AVdZHfw69JF0de0YDA=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqhvgzO_1761029697 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 14:54:58 +0800
Message-ID: <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
Date: Tue, 21 Oct 2025 14:54:52 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, robert.moore@intel.com, andrew@kernel.org,
 bfaccini@nvidia.com, eahariha@linux.microsoft.com, dan.j.williams@intel.com,
 thorsten.blum@linux.dev, gourry@gourry.net,
 nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
 <20250915093549.00006109@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250915093549.00006109@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/15 16:35, Jonathan Cameron 写道:
> On Sat, 13 Sep 2025 10:32:24 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The Generic Initiator Affinity Structure in SRAT table uses device
>> handle type field to indicate the device type. According to ACPI
>> specification, the device handle type value of 1 represents PCI device,
>> not 0.
>>
>> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
>> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Thanks!
> 
>> ---
>> changes since v1: drop changes in actbl3.h to make it easy to progress per Jonathan
>> ---


Hi, Rafael,

Gentle ping.

Are you happy to pick this bugfix up in this cycle?

Thanks.
Shuai

