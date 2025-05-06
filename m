Return-Path: <linux-acpi+bounces-13500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC77AABD49
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30BA7B1205
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 08:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E519F115;
	Tue,  6 May 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TcLQQRe0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE52221289;
	Tue,  6 May 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746520306; cv=none; b=QurPVvy04UZ+d/zq9TyZOb6AbwWIZsbSj0c9m8UaxGu7xaGUzLpOzHGNUwbL+1IFS2BM5TGPmH6N5+cnO9rLq5AVc+mWG9BEv6V8dvt85N0DBE+5Cq8yshb05AkK6TaFYTJ1lzm27d7sDTaf/64BrVT1IUrxYgsCK1CMrJ5AVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746520306; c=relaxed/simple;
	bh=w77jzrrlgkBCO3XFMYGrCyAkdws+QJdfrjJ5d2ZqSdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iVt8eTHUr2p867QB2MaAnqrMQKfcdCH/VTsS87G/9DkMY2YHI3Elaih1JpIDMNPseUZHfp7jlrgq47jh33bTdhEoVT71QeLOzVk6dh8s1BCz8oJKVOscV+CqWnjuBLErztwOoyPLdpZxA3bUNxQtvRl3oXqVAixSlHSkd4W2a1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TcLQQRe0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54619Bqa006484;
	Tue, 6 May 2025 08:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zveFIEvzzEGg+UEVOqZmxBcPnjh2BP/NBRPkwAviQfU=; b=TcLQQRe0sGPf3ahQ
	N0uFSurxpChu88u9axyzPyFNDUnzar4tM2fmzcTpflBS+7Bem/bN0PGZXZX/nl+D
	i7JrzgIb3/2fCRYk/7hbaDMWLFWjY+2i8YTDTrQwE8yNBLxgX1cgmD+A3nkDAgpH
	Prc/D1ECaMqEqmlbEIkh1GZmOzsLfQe1kbVwXJNuD7Qw9Ax8A7imK5JavskrZNrC
	Fion55lB6bkOZAM1gjiDzxDfOnX0u9MLbOqGfTfek7b2SCpAcx7jzRVoIa4sBvqg
	/x/4FE2dgXPvtv8eOBB9HsmW2NurpUMbQgEmQgF35nxMAEA/PYhjGdjSVakwUYY3
	BJGSzA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f8gw14wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 08:31:17 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5468VGsw021494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 08:31:16 GMT
Received: from [10.239.132.50] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 6 May 2025
 01:31:09 -0700
Message-ID: <b5c04110-c899-4aec-85bf-9978d80bf4ac@quicinc.com>
Date: Tue, 6 May 2025 16:30:51 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: SDEI: Allow sdei initialization without
 ACPI_APEI_GHES
To: Will Deacon <will@kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <xueshuai@linux.alibaba.com>,
        <quic_aiquny@quicinc.com>, <quic_satyap@quicinc.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@quicinc.com>,
        <kernel@oss.qualcomm.com>
References: <20250428095623.3220369-1-quic_hyiwei@quicinc.com>
 <20250430102440.GA27570@willie-the-truck>
Content-Language: en-US
From: Huang Yiwei <quic_hyiwei@quicinc.com>
In-Reply-To: <20250430102440.GA27570@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yLN99YlpcPugfz7KBctlzqUlkGUI_Uw4
X-Authority-Analysis: v=2.4 cv=fdSty1QF c=1 sm=1 tr=0 ts=6819c8d5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=BcfgLWrW9SB--Ltqr6oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yLN99YlpcPugfz7KBctlzqUlkGUI_Uw4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4MCBTYWx0ZWRfXzz4kvG7TadUO
 8Pm3cmBF0uj9qvFT1ILJoCLh4AUj4YqjKjjX9/xEqpTLcn6o3N1xq67NU782QGt9AQ1Beuj17Xe
 zcAxMIU/k4Kaz+kxP+DNjo7UU4GdgkleuNPtvRd2onx3hnW6xu9zW4d2LPNFfA59PCn4QZXPvEj
 JfnDL4FBZ26DEiHataljfErO4ALUZm9kgiaBLNypcL1fSW909cscP9sKYOv/ookwV1IHobmL3S2
 paAqTp1IJTX+91Bun4hYzZkKPEFBh2fjS+YCVZAXv4/UQ/3jp3HrxqyJUTfQsUJUqYJbp54JNqn
 GOXXV2KnuSp+6VZchcEHsqZFWQp8mtQwySSqwSZ/kC6EVzXsxWBqXAaVrz0KA1HGHtzD2Ubv0bz
 n6btC37jWJ8wubpFU5SkPgtCq8WtwXI2pP0CJ4tOMNbhXhVKefwStlNFLinGl/kWLs7A8PCk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=740 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060080

> On Mon, Apr 28, 2025 at 05:56:23PM +0800, Huang Yiwei wrote:
>> SDEI usually initialize with the ACPI table, but on platforms where
>> ACPI is not used, the SDEI feature can still be used to handle
>> specific firmware calls or other customized purposes. Therefore, it
>> ......
>>   	}
>> +
>> +	return ret;
>>   }
>> +#ifndef CONFIG_ACPI_APEI_GHES
>> +subsys_initcall_sync(sdei_init);
>> +#endif
> 
> Using an initcall purely for the non-ACPI case feels like a hack to me.

Yeah, I agree with you actually, but to address the dependency chain 
issue highlighted in commit dc4e8c07e9e2 ("ACPI: APEI: explicit init of 
HEST and GHES in acpi_init()"), where the following relationships need 
to be maintained:

     ghes_init() => acpi_hest_init() => acpi_bus_init() => acpi_init()
     ghes_init() => sdei_init()

> Could we instead just call sdei_init() from the arch code (and remove
> the call from acpi_ghes_init()) so that the platform device is
> registered at the same time, regardless of the firmware?
> 
> Will

I propose splitting sdei_init() into two separate functions: sdei_init() 
and acpi_sdei_init(). This way, sdei_init() will be called by 
arch_initcall and will only initialize the platform driver, while 
acpi_sdei_init() will initialize the device from acpi_ghes_init() when 
ACPI is ready. This approach should help maintain the dependency chain 
without causing any breaks.

     sdei_init --> platform_driver_register
     arch_initcall(sdei_init)

     acpi_init
         acpi_bus_init();
         acpi_hest_init();
         acpi_ghes_init();
             acpi_sdei_init(); --> platform_device_register_simple
     subsys_initcall(acpi_init);


