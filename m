Return-Path: <linux-acpi+bounces-15560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9731BB1D867
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35241AA44F8
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Aug 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274E7233713;
	Thu,  7 Aug 2025 12:57:47 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m1973179.qiye.163.com (mail-m1973179.qiye.163.com [220.197.31.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F30214813;
	Thu,  7 Aug 2025 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571467; cv=none; b=r/riXmXSqCz2ZlR+qpsfuTTAGWw4PzucOr5uMzdpmrPIGkDgmxHFxYoWLGnAJDLqE/SA/hJb0PEeeChUNv91EYk0kQItE3qUMbPhe+njnr37qyESDiqFjwj8sA5KqW+4SIuC2N7k35grqzGd3kUFunp8FWl/XaIBN7yhdPbzlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571467; c=relaxed/simple;
	bh=k/nUmfKwmZtDrpcdCfeCOCkmDLkr2OHuHXY3Yfs5T+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jxUL0Kg/9f9rMU3usAM62VzOYMRQFGeKfaogKVs1OA/dFaDeDZm4C/7BzAcdQKah8g60WCxYBWrTUPr//+EEzyFIZBxmsa5uorDQVAB1zHSwS7Yh0PK2lkizkNJMhtOJ81c2yzqDoWOlF4/QwkwuAgTs6+UuksBsYUQFhDUBCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=220.197.31.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from [192.168.1.94] (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id e4ab39fc;
	Thu, 7 Aug 2025 20:52:24 +0800 (GMT+08:00)
Message-ID: <47bffaac-4158-4978-8658-271157e568ec@easystack.cn>
Date: Thu, 7 Aug 2025 20:52:24 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: EINJ: Fix einj_tab memleak in einj_probe()
To: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de,
 guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com,
 lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20250807115657.503189-1-zhen.ni@easystack.cn>
From: "zhen.ni" <zhen.ni@easystack.cn>
In-Reply-To: <20250807115657.503189-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a988496fcd50229kunm7f3a541d7eec
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUNKVktJSU1KHR8dT0kZSlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+



在 2025/8/7 19:56, Zhen Ni 写道:
> Fixes a permanent ACPI table memory leak when einj_probe() return 0 by
> adding acpi_put_table().
> Remove the assignment rc = -ENOMEM to allow the function to propagate
> the actual return value.
> 
> Fixes: e40213450b53 ("ACPI, APEI, EINJ support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ...

I need to withdraw this patch because upon further investigation,
the issue it attempted to fix does not actually exist.

My apologies for the noise. Please disregard the original patch.


Best regards,
Zhen

