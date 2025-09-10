Return-Path: <linux-acpi+bounces-16613-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CF8B5210E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 21:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1417BA7DD
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928552D8791;
	Wed, 10 Sep 2025 19:31:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41E2C11D8;
	Wed, 10 Sep 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532679; cv=none; b=KX71v9GzcX25mxO/FSu/fVCV4icNIATh4g9WjawZ4XRmi8dBS0zQ67Ya0D9dBPyC3z8YfF0+ruoc7V+7ffN60BaS6R37nGlMofgj+gY4xzL6s0tvk6RQEHXSoX+O6/7zSO5KQ8Ic7siyEA2ZCsEIUcpNWKzConnHoNrQA0NYbC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532679; c=relaxed/simple;
	bh=hCHhBKzS5A6BxNcpZxzjLxXTNbsRhXQTiBkBBPXavxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLXCOI+wKz4oam100TKMBMt9AMU7ZUPGpDHxexo+Ty5EDgdR9zTFkIsGihoAv8g2CV6k5ijmAW4ctz/hwF4/h71PflmsJnPFqCPNbFleFxwtvg3D14zHouJA3lb73laCwvWia1KatifXMNuF2H2nmhuGKDSk6shR2Evgu9BI7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A52816F8;
	Wed, 10 Sep 2025 12:31:09 -0700 (PDT)
Received: from [10.1.197.69] (eglon.cambridge.arm.com [10.1.197.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F49D3F694;
	Wed, 10 Sep 2025 12:31:11 -0700 (PDT)
Message-ID: <e91167c4-0d80-472f-8384-14003b959991@arm.com>
Date: Wed, 10 Sep 2025 20:31:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] ACPI / MPAM: Parse the MPAM table
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
 "baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-43-james.morse@arm.com>
 <OSZPR01MB8798DAAAD9424C2C8706A8088B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB8798DAAAD9424C2C8706A8088B0FA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 09/09/2025 07:54, Shaopeng Tan (Fujitsu) wrote:
>> Add code to parse the arm64 specific MPAM table, looking up the cache level
>> from the PPTT and feeding the end result into the MPAM driver.

>> diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c new
>> file mode 100644 index 000000000000..e55fc2729ac5
>> --- /dev/null
>> +++ b/drivers/acpi/arm64/mpam.c
>> @@ -0,0 +1,331 @@

>> +static int __init acpi_mpam_parse(void) {
>> +        struct acpi_table_header *table __free(acpi_table) =
>> acpi_get_table_ret(ACPI_SIG_MPAM, 0);
>> +	char *table_end, *table_offset = (char *)(table + 1);
>> +	struct property_entry props[4]; /* needs a sentinel */
>> +	struct acpi_mpam_msc_node *tbl_msc;
>> +	int next_res, next_prop, err = 0;
>> +	struct acpi_device *companion;
>> +	struct platform_device *pdev;
>> +	enum mpam_msc_iface iface;
>> +	struct resource res[3];
>> +	char uid[16];
>> +	u32 acpi_id;
>> +
>> +	if (acpi_disabled || !system_supports_mpam() || IS_ERR(table))
>> +		return 0;
>> +
>> +	if (IS_ERR(table))
>> +		return 0;

> This is redundant, it's the same as the previous line.

Fixed, thanks.

James

