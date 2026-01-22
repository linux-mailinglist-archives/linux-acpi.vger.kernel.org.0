Return-Path: <linux-acpi+bounces-20541-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB7JFRsPcmksawAAu9opvQ
	(envelope-from <linux-acpi+bounces-20541-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:50:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B126663CD
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 12:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D439172A7AF
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1363EF0A8;
	Thu, 22 Jan 2026 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XC7a8yEZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728E3BF300;
	Thu, 22 Jan 2026 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769082139; cv=none; b=c4jVjixY7vEMKiUUuaTXjzxkS7bOf+vkGtiZVByf4/dJpFs+KMwW9V3dJKN4XZVV+kfpmRSX4oyOtDrnmcQ/2l2jYi44RfTqZvGqtc4bxKXNeiQyx9AivhhyJVuFPco3Drj/M/ozTk6J066QvKuHHl2i00684ACPJ9cPM02nDvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769082139; c=relaxed/simple;
	bh=BzROj+qPjwn10Wcma/Olj18t2mzIjhUK3GYki215h+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HR3T6f+ioI5bVZfkcT+yavMfg72e7y4GqVg0KKiOvo3dBwQngY7CbDPo6yp2Etr7boOP0WLfwD+P07VdMr2w1qA4AuTq7mN5w+P6N8wRwZ62Tf23s0HKUJ+AphLz2G4ZkaGF32KzcBrzDSdod9NjgAluobQLnRorVBwE6T2OfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XC7a8yEZ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=h5IO1II72SHvth+63/+3XlMGErqZm+GjmL10qJGkNv0=;
	b=XC7a8yEZdC7zIgkgPK+S1MAfcQsfB27AFE7g5ZpXZyCtulOyzPlnTX6pwIVmtfOLGB/TCimUs
	ct20hV+y4kPWZVNVF98vHQMjNQCOnpLFo7/dVYu2TIisB7QjQYMo11UgeCX7UUnkJ6LCYy4D1hN
	zWYSjEQa9LNGQM7MYw6BYOw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dxfGB36X9z1prKl;
	Thu, 22 Jan 2026 19:38:42 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id C8F2340569;
	Thu, 22 Jan 2026 19:42:08 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 19:42:07 +0800
Message-ID: <0ea13064-be34-449c-9dd0-760333111da3@huawei.com>
Date: Thu, 22 Jan 2026 19:42:07 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] ACPI: CPPC: Add cppc_get_perf() API to read
 performance controls
To: Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>
CC: <rafael@kernel.org>, <viresh.kumar@linaro.org>, <ionela.voinescu@arm.com>,
	<lenb@kernel.org>, <robert.moore@intel.com>, <corbet@lwn.net>,
	<rdunlap@infradead.org>, <ray.huang@amd.com>, <gautham.shenoy@amd.com>,
	<mario.limonciello@amd.com>, <perry.yuan@amd.com>, <zhanjie9@hisilicon.com>,
	<linux-pm@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <acpica-devel@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
	<ksitaraman@nvidia.com>, <sanjayc@nvidia.com>, <nhartman@nvidia.com>,
	<bbasu@nvidia.com>
References: <20260120145623.2959636-1-sumitg@nvidia.com>
 <20260120145623.2959636-5-sumitg@nvidia.com>
 <7f0b280d-9c22-46dc-a924-a85591e1034d@huawei.com>
 <5afea521-7d80-4e72-8809-77af60b0d957@arm.com>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <5afea521-7d80-4e72-8809-77af60b0d957@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200001.china.huawei.com (7.202.181.227)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20541-lists,linux-acpi=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[huawei.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhenglifeng1@huawei.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 8B126663CD
X-Rspamd-Action: no action

On 2026/1/22 19:30, Pierre Gondois wrote:
> 
> On 1/22/26 09:56, zhenglifeng (A) wrote:
>> On 2026/1/20 22:56, Sumit Gupta wrote:
>>> +
>>> +    if (CPC_SUPPORTED(desired_perf_reg))
>>> +        cpc_read(cpu, desired_perf_reg, &desired_perf);
>>> +    perf_ctrls->desired_perf = desired_perf;
>> desired_perf_reg is not an optional one, so it has to be supported.
> 
> The ACPI spec seems to say it is optional under some circumstances.
> 
> Cf:
> """
> This register is optional when OSPM
> indicates support for CPPC2 in the platform-wide _OSC
> capabilities and the Autonomous Selection Enable reg-
> ister is Integer 1
> """
> 
> 
> Maybe it is ok to let this check here and to a more complex verification
> in acpi_cppc_processor_probe()

Right. My mistake.

> 


