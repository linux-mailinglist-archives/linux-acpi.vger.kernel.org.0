Return-Path: <linux-acpi+bounces-10917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC9A2A982
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 14:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9EAE3A9D01
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Feb 2025 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4DC13A244;
	Thu,  6 Feb 2025 13:16:59 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448DA1A3171;
	Thu,  6 Feb 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847819; cv=none; b=U7joXSkNaYrnxn2dlCVxXGKXaNhXWiHHrF8kNtzNOM7THUIXM43VQHbtAcD2LseumDu1BVkoKZ+KOdXhs1JzsmRfPkvm3w5QUmv1kRmzXoq9fy83iXdW0fv5YWUnSL3k3bOaDLY6fHycA/3pw0JrBRE8tDP9O5rKxeEcrMpVZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847819; c=relaxed/simple;
	bh=zPMubyTzwNIWyC+ejfLa+a/uH4M1ftWD5v1xxdK/8TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ihwffSGcgRGAYjdFV1r+Os5L2+y/MitVxHpOKMqZ1L4oYoq6HgY2v69RRSCp6SC0EzzPZXD2Fck2NkA2tIQQXUbdnj5XoOGZivXTP/eYT40aJEgOAxn152Jv59ESRpmNlUie/dXhJBEJRdKiG/wjlabvTFooEVa+jD4E0DKKUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YpczB6DdWzrRhk;
	Thu,  6 Feb 2025 21:15:18 +0800 (CST)
Received: from kwepemh100008.china.huawei.com (unknown [7.202.181.93])
	by mail.maildlp.com (Postfix) with ESMTPS id D08641400CA;
	Thu,  6 Feb 2025 21:16:54 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemh100008.china.huawei.com
 (7.202.181.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 6 Feb
 2025 21:16:53 +0800
Message-ID: <632cb20b-97b8-4c45-ad92-da3e09fad52d@huawei.com>
Date: Thu, 6 Feb 2025 21:16:53 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Support for autonomous selection in cppc_cpufreq
To: <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC: <lenb@kernel.org>, <robert.moore@intel.com>, <mario.limonciello@amd.com>,
	<gautham.shenoy@amd.com>, <ray.huang@amd.com>, <pierre.gondois@arm.com>,
	<acpica-devel@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<linuxarm@huawei.com>, <yumpusamongus@gmail.com>,
	<srinivas.pandruvada@linux.intel.com>, <jonathan.cameron@huawei.com>,
	<zhanjie9@hisilicon.com>, <lihuisong@huawei.com>, <hepeng68@huawei.com>,
	<fanghao11@huawei.com>
References: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <20250206131428.3261578-1-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh100008.china.huawei.com (7.202.181.93)

Hello Rafael & Viresh,

There are two things about this patchset I would like your advice on:

1. Pierre and I have discussed about whether or not to show auto_act_window
and energy_performance_preference_val when auto_select is disabled [1]. It
seems like whether to show these two files has their own points. We'd like
to ask for some advice.

2. In intel_pstate driver, there is a file named
"energy_performance_preference", which accepts not only raw value but also
a few string arguments and converts them to integers. But I think this
implementation is not really nice and prefer not to follow it [2]. To
distinguish it, I named the file in cppc_cpufreq
"energy_performance_preference_val" instead of
"energy_performance_preference". Should I follow the implementation of
intel_pstate?     

Looking forward to your reply!

Relevant discussion:
[1] https://lore.kernel.org/all/522721da-1a5c-439c-96a8-d0300dd0f906@huawei.com/
[2] https://lore.kernel.org/all/0c511da2-6a4a-4fa2-9d82-da45d1afe346@huawei.com/

