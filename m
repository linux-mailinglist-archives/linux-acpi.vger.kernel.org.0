Return-Path: <linux-acpi+bounces-18808-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 63341C52F0E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 16:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF066352E4C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 15:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E487F3446C5;
	Wed, 12 Nov 2025 14:55:55 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712E33C538;
	Wed, 12 Nov 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959355; cv=none; b=jViOWprRy71WG1C56dzejqYxvq9Ml1/TG5qIIAz+vU9esUJPSjVkwuQ9Qw9uYkiwk0BTB+zSd3I4nzuEoNNU05o71/fuUFXqG8nCTAlxyhupFpzfm1cVg8DiP6CM9fcBEBXysG4Apqi9KTNe4e6jwuFsDorxC3w5r2Ux6JeXpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959355; c=relaxed/simple;
	bh=4L01zClc8R6G+alNNCVxBvcGcFvDCVWg9HTtGTFYt5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcEofPHr9MR6HYZ18a9DN6wNWMwyC2Tl+l7lK6kM8lKaIRgeNEZSAv7KhZl9hxsCdPymkBiOeDoKjS/WKnfpyVi91X1GJkcMxatBMluz2JjBdQN9bPnHcEWLbBFT5p9+P2JCc6+8xLGIZEk3uI5XGn6NbsXnRWA5JjAS5taIhUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B993E1515;
	Wed, 12 Nov 2025 06:55:45 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0D483F66E;
	Wed, 12 Nov 2025 06:55:48 -0800 (PST)
Message-ID: <a9edf77f-41d8-4e3c-b621-e2d37604a410@arm.com>
Date: Wed, 12 Nov 2025 14:55:47 +0000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/33] ACPI / MPAM: Parse the MPAM table
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "james.morse@arm.com" <james.morse@arm.com>
Cc: "amitsinght@marvell.com" <amitsinght@marvell.com>,
 "baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dakr@kernel.org" <dakr@kernel.org>,
 "dave.martin@arm.com" <dave.martin@arm.com>,
 "david@redhat.com" <david@redhat.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "jeremy.linton@arm.com" <jeremy.linton@arm.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "kobak@nvidia.com" <kobak@nvidia.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peternewman@google.com" <peternewman@google.com>,
 "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "rohit.mathew@arm.com" <rohit.mathew@arm.com>,
 "scott@os.amperecomputing.com" <scott@os.amperecomputing.com>,
 "sdonthineni@nvidia.com" <sdonthineni@nvidia.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "will@kernel.org" <will@kernel.org>,
 "xhao@linux.alibaba.com" <xhao@linux.alibaba.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-10-ben.horgan@arm.com>
 <OSZPR01MB8798996B4D879FF695AE216C8BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <OSZPR01MB8798996B4D879FF695AE216C8BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 11/12/25 07:01, Shaopeng Tan (Fujitsu) wrote:
> Hello Ben,
> 
>> From: James Morse <james.morse@arm.com>
>>
>> Add code to parse the arm64 specific MPAM table, looking up the cache level
>> from the PPTT and feeding the end result into the MPAM driver.
>>
>> This happens in two stages. Platform devices are created first for the MSC
>> devices. Once the driver probes it calls acpi_mpam_parse_resources() to
>> discover the RIS entries the MSC contains.
>>
>> For now the MPAM hook mpam_ris_create() is stubbed out, but will update the
>> MPAM driver with optional discovered data about the RIS entries.
>>
>> CC: Carl Worth <carl@os.amperecomputing.com>
>> Link: https://developer.arm.com/documentation/den0065/3-0bet/?lang=en
>> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
>> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Peter Newman <peternewman@google.com>
>> Signed-off-by: James Morse <james.morse@arm.com>
>> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

>> +static struct platform_device * __init acpi_mpam_parse_msc(struct
>> +acpi_mpam_msc_node *tbl_msc) {
>> +	struct platform_device *pdev __free(platform_device_put) =
>> +		platform_device_alloc("mpam_msc", tbl_msc->identifier);
>> +	int next_res = 0, next_prop = 0, err;
>> +	/* pcc, nrdy, affinity and a sentinel */
>> +	struct property_entry props[4] = { 0 };
>> +	/* mmio, 2xirq, no sentinel. */
>> +	struct resource res[3] = { 0 };
>> +	struct acpi_device *companion;
>> +	enum mpam_msc_iface iface;
>> +	char uid[16];
>> +	u32 acpi_id;
>> +
>> +	if (!pdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* Some power management is described in the namespace: */
>> +	err = snprintf(uid, sizeof(uid), "%u", tbl_msc->identifier);
> 
> It's a bit strange to store the uid length in the variable err.

A little, yes. The value is only used for error checking and it's not
that uncommon so I'll leave it as is.

linux$ git grep 'err = snprintf' | wc -l
17

> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> 

Thanks!
Thanks,

Ben


