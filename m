Return-Path: <linux-acpi+bounces-14403-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B5ADBF3C
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 04:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD07171E58
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03623535C;
	Tue, 17 Jun 2025 02:33:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA34335C7;
	Tue, 17 Jun 2025 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127590; cv=none; b=S3k9qQLqeT8zOLFJiAuWApAluoo2B/qUIushiZ+3QoimxEBgOQ6hy6hiMqtyRsuOut0ex4YpNiL4dUjEZ38voEVGLlXG0nYQXooM7nLTDjXr/Z4BfemQ7TFEBgw2eEd5It8ljhq4o+aYvqJw9QPFKI1UMI5Hm90IUP+MxoNJ5u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127590; c=relaxed/simple;
	bh=icJQ57/lLtsIkqFlgrS3T4na4ZU3WMX2Sk5sOLAXQZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sb/Ay5tbYS0Y2nSNI0vmXhNOVygDvepFBq6mXnhGK51Fk0EAxCtxSXXcMSiKT/+qAnU2QZKusgERyH7vrx7GPzu+ToNIz23yuXLKzZn8RAnF8I/JCFwbj6EeogOnbytnBen7NgnbCWox8YOaiOWdNxofo7jWZbmXjoXC4l88+tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bLrXj37CKz2QVKM;
	Tue, 17 Jun 2025 10:33:57 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id BDBC914011F;
	Tue, 17 Jun 2025 10:33:03 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Jun
 2025 10:33:03 +0800
Message-ID: <9c82abca-0772-444c-8122-59a953c83984@huawei.com>
Date: Tue, 17 Jun 2025 10:33:02 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <robert.moore@intel.com>,
	<lenb@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <yubowen8@huawei.com>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Gentle ping.

On 2025/5/26 19:30, Lifeng Zheng wrote:
> This patch series makes some minor optimizations for cppc_cpufreq.c to
> makes codes cleaner.
> 
> Lifeng Zheng (3):
>   cpufreq: CPPC: Remove cpu_data_list
>   cpufreq: CPPC: Return void in populate_efficiency_class()
>   cpufreq: CPPC: Remove forward declaration of
>     cppc_cpufreq_register_em()
> 
>  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
>  include/acpi/cppc_acpi.h       |  1 -
>  2 files changed, 15 insertions(+), 45 deletions(-)
> 


