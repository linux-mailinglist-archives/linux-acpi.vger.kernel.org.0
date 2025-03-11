Return-Path: <linux-acpi+bounces-12101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90547A5CD07
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 19:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4842178AA8
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 18:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1926388C;
	Tue, 11 Mar 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f7mlYYFt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA2A263883
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716078; cv=none; b=AMAQmRWz57cMDjAOtG14dT6yd6AnkgJmru5LpxjrEgi3gt4BtU+bcc6Kaj0CuiX5IQzKgyNoOn7Ysgxon451I0sWZUN/wWXNX8JXVRxMHdtbIEZkDeNpSLSZZlUyv+sccxCrLzaTl3S/hdRlb6cPlNIi/2jSvKjuKewcRL4T1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716078; c=relaxed/simple;
	bh=YGUtbaoC0vpuFL55AG2VRarJ9dc5j39vjlLJQCOeDKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSkJuSHseD32S+NqFGoCwiCbyABGX058TnokxL4W+i5jBcv0FX3hP0EI5UwUWOG8gGG+YkZ1MqeMCw9mbfBK3kHCj3Y8NdlW///GTkn79DN0+Yd+u61UYOlgaknOV7YM7rVtJ1LGtN0rdmbH1TT8Me9tXW8TzFJg4ZARaRuCuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f7mlYYFt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BFiLNq016815
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 18:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YGUtbaoC0vpuFL55AG2VRarJ9dc5j39vjlLJQCOeDKA=; b=f7mlYYFt7jkvBncL
	ycrW6gqllkYuuuP3eTk0nPUOru3/oztfu4M12Rsz0adLFr5RPvGIcBuN8ygDnBmu
	/pZof8XL1WNBqVfjFWFebjQsJwKSYA/mhNQBJ53Fno+SvN9PH5R7kxj7/1naiuDM
	oKRz8gEx/HBvBDWeoO00EaDM8YgLJm2OmidoWAvqsCRy5ZMbzzwnjY1jsrIVwGPp
	o/9GxJe7/wVT3DfWhZNrMExav2YbW4Ft2kB/xLtC44/ARLdQL0wqQ692IQ8iwMnk
	GI3X+9EPx+rPEusBSj6czHHjjZmdw+FFSiQwBbo8X6mI+9vXEmCFPZjukOmu5YoZ
	DNS4pA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eyuhhdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 18:01:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-224364f2492so59753795ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 11 Mar 2025 11:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741716075; x=1742320875;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YGUtbaoC0vpuFL55AG2VRarJ9dc5j39vjlLJQCOeDKA=;
        b=KCrNOjmJJXWDHU7wpmSLhKkbfLzPEAunUcVJIVnJcIA1bm7NDzeQOoU8ew34+208ie
         eVo3NsC2OgOan47D6+TOzoAS2fZUE0WTTPzHUbbZJ6aadYM8V7ngiK03FVKUPR9Halvu
         dqk3w8wFZa8XE042uOOM4spXemAAgpmhYYgqcQhfTbcazTg2EVSTN6UmcBrUktwKZ8M+
         PFHclqoLopr59A9GazYJ7eO7PW3UF9RCX0XYdFT2JRpmYc4OvDU8OmQtCE5fHQwBAv1L
         TV22yORKToMRWxnXwjQRwiitWb1O5R2aOxWznCe74AIwHIUQWbqWvKyyNUiRPG7wm4fS
         Rf1w==
X-Forwarded-Encrypted: i=1; AJvYcCVt5/o96+yl2UQgmBJW64tSwP31nrs6Hn789b0XXVSPO30qDjk2qVddX+1V3kfWdsn8Ipgr2I8LvPMi@vger.kernel.org
X-Gm-Message-State: AOJu0YxDz50S6l07H9EWe1RE7PyhM+CU76l//DDaiVBwLNDw1NgC7SAO
	2RXdt7WPDWObEjDnpTszfD6DdYRwBBWqp7IvEzJEnLQJdndMtIuyMDYPkuF5H/7HRBTtglD68Hl
	66esX8Cq29U1I1OQgvsXJEcjRYzr6rnVD/l10cnD0Zhf2an5vKAjtysphFoj9
X-Gm-Gg: ASbGncuuTnS7KdSkkSDaNA8fAXVyS7c7CFyRcViNb/WxbMjNGdzbyAgTxydQ3doFefK
	G2UjOO4ddFb5N+1ZNkHEi1w4UfXJ/Kgpkm5OmctmToDG/gr/AjVNQo7ILTTw1MxOcyUPncVaBjW
	1dxdclFzCxlSCSoKntWjcM5upR8aTOIUfzOF063XYDs4IgiXXGmksEtalX6e8gzVW3FOozDNSVF
	5dS2TQwjYo7bwz4zZVoCBAD4+cEucWauTj8rAklBywhP1UtrtEmkszHNFVuDQxMNziQDB6qziwO
	3EoXaiSz0afvEj+UNg4kF9/cQUufhdl+sK5PQnnfPjwQYBGIJGpR
X-Received: by 2002:a17:902:ceca:b0:224:2175:b0cd with SMTP id d9443c01a7336-22428aa1c02mr211881485ad.26.1741716074103;
        Tue, 11 Mar 2025 11:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV1XMOUAaf3mrw2N9csl6TPk+/0MVQ+tofdzFboBXtSDMFtl99aFN84M5tc6CNvpuZXGk9IQ==
X-Received: by 2002:a17:902:ceca:b0:224:2175:b0cd with SMTP id d9443c01a7336-22428aa1c02mr211881145ad.26.1741716073692;
        Tue, 11 Mar 2025 11:01:13 -0700 (PDT)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a92016sm100936345ad.190.2025.03.11.11.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:01:13 -0700 (PDT)
Message-ID: <fcd132af-03e4-496d-ba70-0097e90a83cf@oss.qualcomm.com>
Date: Tue, 11 Mar 2025 11:01:09 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
        joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
        jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
        skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
        ssengar@linux.microsoft.com, apais@linux.microsoft.com,
        Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
        gregkh@linuxfoundation.org, vkuznets@redhat.com,
        prapal@linux.microsoft.com, muislam@microsoft.com,
        anrayabh@linux.microsoft.com, rafael@kernel.org, lenb@kernel.org,
        corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cbIormDM c=1 sm=1 tr=0 ts=67d07a6c cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=aMAvcm_y2WmIjkiga5kA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: juMYW2rQvVnND9GVcIV-IyJ5BUlNI_fz
X-Proofpoint-GUID: juMYW2rQvVnND9GVcIV-IyJ5BUlNI_fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1011 spamscore=0 mlxlogscore=660
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110115

On 2/26/25 15:08, Nuno Das Neves wrote:
...
> +
> +MODULE_AUTHOR("Microsoft");
> +MODULE_LICENSE("GPL");
> +

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. Please add a MODULE_DESCRIPTION()
to avoid this warning.

This is a canned review based upon finding a MODULE_LICENSE without a
MODULE_DESCRIPTION.

/jeff

